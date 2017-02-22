USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_DynamicPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_DynamicPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_pub_price_DynamicPrice]
(
	 @Operator BIGINT,
	 @SupplierCompanyID BIGINT,
	 @FromProvince BIGINT,
	 @FromCity BIGINT,
	 @FromDistrict BIGINT,
	 @ToProvince BIGINT,
	 @ToCity BIGINT,
	 @ToDistrict BIGINT,
	 @Pick BIGINT,
	 @Delivery BIGINT,
	 @OnLoad BIGINT,
	 @OffLoad BIGINT,
	 @PriceUnit BIGINT,
	 @ChargeMode BIGINT,
	 @CarType BIGINT,
	 @CarLength DECIMAL(18,2),
	 @CarVolume DECIMAL(18,6),
	 @CarWeight DECIMAL(18,4),
	 @Weight DECIMAL(18,4),
	 @Volume DECIMAL(18,6),
	 @Count DECIMAL(18,2),
	 @TransportMode BIGINT,
	 @IsInsurance BIGINT,
	 @GoodsValue DECIMAL(18,2),
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
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @CustomerID=0;
	SET @CustomerCompanyID = 0;
	SET @CreatorCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
		
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -520016001;
	END

	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520016002;
	END

	-- 委托给承运商的订单，应该使用承运商的报价，主客倒置了一下
	IF @Result = 0 AND @SupplierCompanyID > 0 
	BEGIN
		SELECT @CustomerID = Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @SupplierCompanyID AND 
Customer_CompanyID = @CompanyID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			-- 当前公司不是承运商的客户
			SET @Result = -520016003;
		END
		ELSE
		BEGIN
			SET @CustomerCompanyID = @CompanyID;
			SET @CreatorCompanyID = @SupplierCompanyID;
		END
	END
	
	DECLARE @tblDocIDs PriceDocLst;
	IF @Result = 0
	BEGIN
		INSERT INTO @tblDocIDs SELECT Index_ID FROM Price_DocIndex WHERE Index_CustomerID = @CustomerID AND 
Index_CustomerCompanyID = @CustomerCompanyID AND Index_Type = 2 AND Index_Invalid = 0 AND Index_Status = 2 AND 
Index_CreatorCompanyID = @CreatorCompanyID  AND Index_StartTime <= GETDATE() AND Index_EndTime >= GETDATE() ORDER BY Index_CreateTime DESC;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520016004;
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

	EXEC sp_prv_price_CalcPriceByDocLst @tblDocIDs, @FromProvince, @FromCity, @FromDistrict, @ToProvince, @ToCity, @ToDistrict, @Pick, @Delivery, @OnLoad, @OffLoad, @PriceUnit, @ChargeMode, @CarType, @CarLength, @CarVolume, @CarWeight, @Weight, @Volume, @Count, @TransportMode, @IsInsurance, @GoodsValue, @CustomerCompanyID, @CreatorCompanyID, @CustomerID, 2, @Result = @Result OUTPUT, @_LessLoadCost = @_LessLoadCost OUTPUT, @_FullLoadCost = @_FullLoadCost OUTPUT, @_PickCost = @_PickCost OUTPUT, @_DeliveryCost = @_DeliveryCost OUTPUT, @_OnLoadCost = @_OnLoadCost OUTPUT, @_OffLoadCost = @_OffLoadCost OUTPUT, @_MinCost = @_MinCost OUTPUT, @_InsuranceCost = @_InsuranceCost OUTPUT, @_AdditionCost = @_AdditionCost OUTPUT, @_TaxCost = @_TaxCost OUTPUT, @_TotalCost = @_TotalCost OUTPUT;
	
	SELECT @Result AS Result, @_LessLoadCost AS LessLoad, @_FullLoadCost AS FullLoad, @_PickCost AS Pick, @_DeliveryCost AS Delivery, 
@_OnLoadCost AS OnLoad, @_OffLoadCost AS OffLoad, @_MinCost AS Min, @_InsuranceCost AS Insurance, @_AdditionCost AS Addition1, @_TaxCost AS Tax, 
@_TotalCost AS Total;
	
	SET NOCOUNT OFF;
END
GO


