USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_DynamicPriceByOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_DynamicPriceByOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_pub_price_DynamicPriceByOrder]
(
	 @OrderID BIGINT,
	 @IsDebugMode BIGINT = 0
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CustomerID BIGINT;
	DECLARE @Result BIGINT ;
	DECLARE @CreatorCompanyID BIGINT;
	DECLARE @CustomerCompanyID BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	DECLARE @FromProvince BIGINT;
	DECLARE @FromCity BIGINT;
	DECLARE @FromDistrict BIGINT;
	DECLARE @ToProvince BIGINT;
	DECLARE @ToCity BIGINT;
	DECLARE @ToDistrict BIGINT;
	DECLARE @Pick BIGINT;
	DECLARE @Delivery BIGINT;
	DECLARE @OnLoad BIGINT;
	DECLARE @OffLoad BIGINT;
	DECLARE @PriceUnit BIGINT;
	DECLARE @ChargeMode BIGINT;
	DECLARE @CarType BIGINT;
	DECLARE @CarLength DECIMAL(18,2);
	DECLARE @CarVolume DECIMAL(18,6);
	DECLARE @CarWeight DECIMAL(18,4);
	DECLARE @Weight DECIMAL(18,4);
	DECLARE @Volume DECIMAL(18,6);
	DECLARE @Count DECIMAL(18,2);
	DECLARE @TransportMode BIGINT;
	DECLARE @IsInsurance BIGINT;
	DECLARE @GoodsValue DECIMAL(18,2);
	DECLARE @IsCombineIndex TINYINT;
	DECLARE @SupplierOrderID BIGINT;
	DECLARE @IsPricedByOrderID TINYINT;
	DECLARE @PriceFound TINYINT;
	DECLARE @OrderTime DATETIME;
	
	SET @Result = 0;
	SET @CustomerID=0;
	SET @CustomerCompanyID = 0;

	SELECT @CustomerID = Index_CustomerID,@CreatorCompanyID = Index_CreatorCompanyID,@CustomerCompanyID = Index_CustomerCompanyID,@CompanyID = Index_CreatorCompanyID, @SupplierCompanyID = Index_SupplierCompanyID, @FromProvince = Index_FromProvince, @FromCity = Index_FromCity, @FromDistrict = Index_FromDistrict,@ToProvince = Index_ToProvince, @ToCity = Index_ToCity, @ToDistrict = Index_ToDistrict,@Pick = Index_Pick, @Delivery = Index_Delivery,@OnLoad = Index_OnLoad,@OffLoad = Index_OffLoad,@PriceUnit = Index_PriceUnit,@ChargeMode = Index_ChargeMode,@CarType = Index_CarType,@CarLength = Index_CarLength,@CarWeight = Index_CarWeight,@Weight = dbo.fn_pub_order_TotalWeight(Index_ID,0),@Volume = dbo.fn_pub_order_TotalVolume(Index_ID,0),@Count = dbo.fn_pub_order_TotalAmount(Index_ID,0),@TransportMode = Index_TransportMode,@IsInsurance = Index_Insurance,@GoodsValue = Index_GoodsValue,@IsCombineIndex = (CASE WHEN Index_SrcClass = 3 THEN 1 ELSE 0 END),@OrderTime = Index_CreateTime FROM TMS_OrderIndex WHERE Index_ID = @OrderID;
		

	
		-- 委托给承运商的订单，应该使用承运商的报价，主客倒置了一下
	IF @Result = 0 AND @SupplierCompanyID > 0 AND @IsCombineIndex = 0
	BEGIN
		SELECT @CustomerID = Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @SupplierCompanyID AND 
Customer_CompanyID = @CompanyID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			-- 当前公司不是承运商的客户
			SET @Result = -10039005;
		END
		ELSE
		BEGIN
			SET @CustomerCompanyID = @CompanyID;
			SET @CreatorCompanyID = @SupplierCompanyID;
			
			-- 一般来说，按单报价模式下承运商都是为自己接收的客户订单报价，客户的运输订单没有直接匹配的报价信息
			-- 计算与当前订单编号配对的承运商客户订单
			-- @SupplierOrderID
			SELECT @SupplierOrderID = Index_ID FROM TMS_OrderIndex WHERE Index_CustomerCompanyID = @CustomerCompanyID AND 
Index_CreatorCompanyID = @CreatorCompanyID AND Index_SrcOrderID = @OrderID AND Index_SrcClass = 1 AND Index_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510039006;
			END
		END
	END
	

	
	IF @Result = 0
	DECLARE @tblDocIDs PriceDocLst;
	IF @Result = 0
	BEGIN
		-- 合单主单是否存在匹配报价[如果存在多个，选择最后一个][本质上是按单报价，永不过期]
		IF @IsCombineIndex = 1
		BEGIN
			INSERT INTO @tblDocIDs SELECT TOP 1 Index_ID FROM Price_DocIndex WHERE Index_OrderID = @OrderID AND Index_Type = 4 AND Index_Invalid = 0 AND 
Index_Status = 2 ORDER BY Index_CreateTime DESC;
			IF @@ROWCOUNT > 0
			BEGIN
				SET @PriceFound = 1;
			END
		END
		ELSE
		BEGIN
			-- 该客户是否存在按单报价[如果存在多个，选择最后一个][按单报价永不过期]
			INSERT INTO @tblDocIDs SELECT TOP 1 Index_ID FROM Price_DocIndex WHERE Index_OrderID IN (@OrderID, @SupplierOrderID) AND Index_Type = 1 AND Index_Invalid = 0 AND 
Index_Status = 2 AND Index_CustomerID = @CustomerID AND Index_CustomerCompanyID = @CustomerCompanyID AND Index_CreatorCompanyID = @CreatorCompanyID ORDER BY Index_CreateTime DESC;
			IF @@ROWCOUNT > 0
			BEGIN
				SET @PriceFound = 1;
				SET @IsPricedByOrderID = 1;
			END
			ELSE
			BEGIN
				DECLARE @DocID BIGINT;
				SET @DocID = 0;

				-- 该客户是否存在合约报价
				INSERT INTO @tblDocIDs SELECT Index_ID FROM Price_DocIndex WHERE Index_CustomerID = @CustomerID AND 
Index_CustomerCompanyID = @CustomerCompanyID AND Index_Type = 2 AND Index_Invalid = 0 AND Index_Status = 2 AND 
Index_CreatorCompanyID = @CreatorCompanyID AND Index_StartTime <= @OrderTime AND Index_EndTime >= @OrderTime ORDER BY Index_CreateTime DESC;
				IF @@ROWCOUNT > 0
				BEGIN
					SET @PriceFound = 1;
				END
			END
		END
		
		-- 该客户是否存在补充报价[补充报价本质上是按单报价，永不过期]
		IF @PriceFound = 1
		BEGIN
			INSERT INTO @tblDocIDs SELECT Index_ID FROM Price_DocIndex WHERE Index_OrderID IN (@OrderID, @SupplierOrderID) AND Index_Type = 3 AND Index_Invalid = 0 AND 
Index_Status = 2 AND Index_CustomerID = @CustomerID AND Index_CustomerCompanyID = @CustomerCompanyID AND Index_CreatorCompanyID = @CreatorCompanyID;
		END
	END
	IF @IsDebugMode = 1
	BEGIN
		SELECT @CompanyID, @CustomerID, @CustomerCompanyID, @CreatorCompanyID;
		SELECT * FROM @tblDocIDs;
	END
	
	DECLARE @_LessLoadCost DECIMAL(18,2);
	DECLARE @_FullLoadCost DECIMAL(18,2);
	DECLARE @_PickCost DECIMAL(18,2);
	DECLARE @_DeliveryCost DECIMAL(18,2);
	DECLARE @_OnLoadCost DECIMAL(18,2);
	DECLARE @_OffLoadCost DECIMAL(18,2);
	DECLARE @_MinCost DECIMAL(18,2);
	DECLARE @_InsuranceCost DECIMAL(18,2);
	DECLARE @_AdditionCost DECIMAL(18,2);
	DECLARE @_TaxCost DECIMAL(18,2);
	DECLARE @_TotalCost DECIMAL(18,2);
	DECLARE @_LessLoadCostDocID BIGINT;
	DECLARE @_FullLoadCostDocID BIGINT;
	DECLARE @_PickCostDocID BIGINT;
	DECLARE @_DeliveryCostDocID BIGINT;
	DECLARE @_OnLoadCostDocID BIGINT;
	DECLARE @_OffLoadCostDocID BIGINT;
	DECLARE @_MinCostDocID BIGINT;
	DECLARE @_InsuranceCostDocID BIGINT;
	DECLARE @_AdditionCostDocID BIGINT;
	DECLARE @_TaxCostDocID BIGINT;
	DECLARE @_TotalCostDocID BIGINT;
	SET @_LessLoadCost = 0;
	SET @_FullLoadCost = 0;
	SET @_PickCost = 0;
	SET @_DeliveryCost = 0;
	SET @_OnLoadCost = 0;
	SET @_OffLoadCost = 0;
	SET @_MinCost = 0;
	SET @_InsuranceCost = 0;
	SET @_AdditionCost = 0;
	SET @_TaxCost = 0;
	SET @_TotalCost = 0;
	SET @_LessLoadCostDocID = 0;
	SET @_FullLoadCostDocID = 0;
	SET @_PickCostDocID = 0;
	SET @_DeliveryCostDocID = 0;
	SET @_OnLoadCostDocID = 0;
	SET @_OffLoadCostDocID = 0;
	SET @_MinCostDocID = 0;
	SET @_InsuranceCostDocID = 0;
	SET @_AdditionCostDocID = 0;
	SET @_TaxCostDocID = 0;
	SET @_TotalCostDocID = 0;

	EXEC sp_prv_price_CalcPriceByDocLst @tblDocIDs, @FromProvince, @FromCity, @FromDistrict, @ToProvince, @ToCity, @ToDistrict, @Pick, @Delivery, @OnLoad, @OffLoad, @PriceUnit, @ChargeMode, @CarType, @CarLength, @CarVolume, @CarWeight, @Weight, @Volume, @Count, @TransportMode, @IsInsurance, @GoodsValue, @CustomerCompanyID, @CreatorCompanyID, @CustomerID, 2, @Result = @Result OUTPUT, @_LessLoadCost = @_LessLoadCost OUTPUT, @_FullLoadCost = @_FullLoadCost OUTPUT, @_PickCost = @_PickCost OUTPUT, @_DeliveryCost = @_DeliveryCost OUTPUT, @_OnLoadCost = @_OnLoadCost OUTPUT, @_OffLoadCost = @_OffLoadCost OUTPUT, @_MinCost = @_MinCost OUTPUT, @_InsuranceCost = @_InsuranceCost OUTPUT, @_AdditionCost = @_AdditionCost OUTPUT, @_TaxCost = @_TaxCost OUTPUT, @_TotalCost = @_TotalCost OUTPUT,   @_LessLoadCostDocID = @_LessLoadCostDocID OUTPUT, @_FullLoadCostDocID = @_FullLoadCostDocID OUTPUT, @_PickCostDocID = @_PickCostDocID OUTPUT, @_DeliveryCostDocID = @_DeliveryCostDocID OUTPUT, @_OnLoadCostDocID = @_OnLoadCostDocID OUTPUT, @_OffLoadCostDocID = @_OffLoadCostDocID OUTPUT, @_MinCostDocID = @_MinCostDocID OUTPUT, @_InsuranceCostDocID = @_InsuranceCostDocID OUTPUT, @_AdditionCostDocID = @_AdditionCostDocID OUTPUT, @_TaxCostDocID = @_TaxCostDocID OUTPUT;
	
	SELECT @Result AS Result, @_LessLoadCost AS LessLoad,dbo.fn_pub_price_DocID2Code(@_LessLoadCostDocID,1) AS [LessLoadCostDoc], @_FullLoadCost AS FullLoad,dbo.fn_pub_price_DocID2Code(@_FullLoadCostDocID,1) AS [FullLoadCostDoc], @_PickCost AS Pick,dbo.fn_pub_price_DocID2Code(@_PickCostDocID,1) AS [PickCostDoc], @_DeliveryCost AS Delivery, dbo.fn_pub_price_DocID2Code(@_DeliveryCostDocID,1) AS [DeliveryCostDoc],
@_OnLoadCost AS OnLoad,dbo.fn_pub_price_DocID2Code(@_OnLoadCostDocID,1) AS [OnLoadCostDoc], @_OffLoadCost AS OffLoad ,dbo.fn_pub_price_DocID2Code(@_OffLoadCostDocID,1) AS [OffLoadCostDoc],  @_MinCost AS Min,dbo.fn_pub_price_DocID2Code(@_MinCostDocID,1) AS [MinCostDoc], @_InsuranceCost AS Insurance,dbo.fn_pub_price_DocID2Code(@_InsuranceCostDocID,1) AS [InsuranceCostDoc], @_AdditionCost AS Addition1, @_TaxCost AS Tax, 
@_TotalCost AS Total;
	
	SET NOCOUNT OFF;
END

GO


