USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_CacheOrderPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_CacheOrderPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*重算订单价格*/
CREATE PROCEDURE [dbo].[sp_prv_price_CacheOrderPrice]
(
	@Operator BIGINT,
	@OrderID BIGINT, 
	@IsDebugMode TINYINT = 0, 
	@Result BIGINT OUTPUT
)
AS
BEGIN
	
	
	DECLARE @CompanyID BIGINT;
	DECLARE @PriceFound TINYINT;
	DECLARE @DocIDs VARCHAR(MAX);
	DECLARE @OrderTime DATETIME;
	DECLARE @CustomerID BIGINT;
	DECLARE @CustomerCompanyID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	DECLARE @CreatorCompanyID BIGINT;
	DECLARE @FromProvince BIGINT;
	DECLARE @FromCity BIGINT;
	DECLARE @FromDistrict BIGINT;
	DECLARE @ToProvince BIGINT;
	DECLARE @ToCity BIGINT;
	DECLARE @ToDistrict BIGINT;
	DECLARE @ShipMode BIGINT;
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
	DECLARE @SupplierOrderID BIGINT;
	DECLARE @IsCombineIndex BIGINT;					-- 是否为拼车单主单
	DECLARE @IsPricedByOrderID BIGINT;				-- 是否为按单报价
	DECLARE @IsInsurance BIGINT;
	DECLARE @GoodsValue DECIMAL(18,2);
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @CustomerID = 0;
	SET @CustomerCompanyID = 0;
	SET @SupplierCompanyID = 0;
	SET @CreatorCompanyID = @CompanyID;
	SET @PriceFound = 0;
	SET @DocIDs = '';
	SET @FromProvince = 0;
	SET @FromCity = 0;
	SET @FromDistrict = 0;
	SET @ToProvince = 0;
	SET @ToCity = 0;
	SET @ToDistrict = 0;
	SET @ShipMode = 0;
	SET @Pick = 0;
	SET @Delivery = 0;
	SET @OnLoad = 0;
	SET @OffLoad = 0;
	SET @PriceUnit = 0;
	SET @ChargeMode = 0;
	SET @CarType = 0;
	SET @CarLength = 0;
	SET @CarVolume = 0;
	SET @CarWeight = 0;
	SET @Weight = 0;
	SET @Volume = 0;
	SET @Count = 0;
	SET @TransportMode = 0;
	SET @SupplierOrderID = 0;
	SET @IsInsurance = 0;
	SET @IsCombineIndex = 0;
	SET @IsPricedByOrderID = 0;
	SET @GoodsValue = 0;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510038002;
	END

	-- 当前用户没有添加客户的权限(取消用户是否有效验证，只需要用户存在：User_Invalid = 0)
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID )
	BEGIN
		SET @Result = -510038003;
	END

	-- 被合单的订单不能单独计算价格[直接退出存储过程]
	IF @Result = 0 AND EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Combined = 1 AND Index_Invalid = 0)
	BEGIN
		GOTO DIRECTLY_EXIT;
	END

	-- 获取当前客户以及影响报价的其他因素
	IF @Result = 0
	BEGIN
		SELECT @CustomerID = Index_CustomerID, @CustomerCompanyID = Index_CustomerCompanyID, @ShipMode = Index_ShipMode, 
@Pick = Index_Pick, @Delivery = Index_Delivery, @PriceUnit = Index_PriceUnit, @ChargeMode = Index_ChargeMode, @CarType = Index_CarType, 
@CarLength = Index_CarLength, @TransportMode = Index_TransportMode, @FromProvince = Index_FromProvince, @FromCity = Index_FromCity, 
@FromDistrict = Index_FromDistrict, @ToProvince = Index_ToProvince, @ToCity = Index_ToCity, @ToDistrict = Index_ToDistrict,
@OrderTime = Index_CreateTime, @SupplierCompanyID = Index_SupplierCompanyID, @OnLoad = Index_OnLoad, @OffLoad = Index_OffLoad,
@IsInsurance = Index_Insurance, @CarVolume = Index_CarVolume, @CarWeight = Index_CarWeight, 
@IsCombineIndex = (CASE WHEN Index_SrcClass = 3 THEN 1 ELSE 0 END), @GoodsValue = Index_GoodsValue FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510039004;
		END
	END
	
	-- 订单在调用本存储过程前已执行过校验

	-- 获取订单的总重量与总体积
	IF @Result = 0
	BEGIN
		SET @Weight = dbo.fn_pub_order_TotalWeight(@OrderID, 0);
		SET @Volume = dbo.fn_pub_order_TotalVolume(@OrderID, 0);
		SET @Count = dbo.fn_pub_order_TotalAmount(@OrderID, 0);
		
		-- 体积重量补差在Total函数中已处理

		-- 订单系统中重量单位是公斤，体积单位是立方米，计价单位则可以按要求自由选择
		-- 应将订单总重量、总体积换算成计价单位
		SET @Weight = dbo.fn_pub_price_OrderWeightCast( @Weight, @PriceUnit );
		SET @Volume = dbo.fn_pub_price_OrderVolumeCast( @Volume, @PriceUnit );
	END

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
	-- 调试模式显示调试信息
	IF @IsDebugMode = 1
	BEGIN
		SELECT * FROM @tblDocIDs;
		SELECT @TransportMode AS 'TransportMode', @Delivery AS 'Delivery', @Pick AS 'Pick', @OnLoad AS 'OnLoad', @OffLoad AS 'OffLoad', @IsCombineIndex AS 'IsCombineIndex',
@IsInsurance AS 'IsInsurane', @Weight AS 'Weight', @Volume AS 'Volume', @Count AS 'Count', @ChargeMode AS 'ChargeMode', @PriceUnit AS 'PriceUnit';
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
	
	DECLARE @tmpResult BIGINT;
	DECLARE @EventID BIGINT;
	DECLARE @OccurTime DATETIME;
	DECLARE @FromCompanyID BIGINT;
	DECLARE @SrcClass TINYINT;
	
	SET @tmpResult = 0;
	SET @EventID = 0;
	SET @OccurTime = GETDATE();
	SET @FromCompanyID = 0;

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
	SET @SrcClass = 0;
	
	SELECT @SrcClass = Index_SrcClass FROM TMS_OrderIndex WHERE Index_ID = @OrderID
	
	-- 客户订单消息通知@FromCompanyID 是客户 运输订单 消息通知@FromCompanyID 是本公司
	IF @SrcClass < 2
		BEGIN
		SELECT @FromCompanyID = Index_CustomerCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND  Index_Invalid = 0;
		END 
		ELSE
		BEGIN
		SELECT @FromCompanyID = Index_CreatorCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND  Index_Invalid = 0;
		END  	

	IF @Result = 0
	BEGIN
		IF @IsCombineIndex = 0 AND @IsPricedByOrderID = 0
		BEGIN
			-- 获取货物总价值
			IF @GoodsValue = 0 
			BEGIN
				SELECT @GoodsValue = SUM(ISNULL(b.Goods_Price, 0) * ISNULL(a.GoodsLst_Qty, 0)) FROM TMS_OrderGoods AS a INNER JOIN TMS_MGoods AS b ON a.GoodsLst_GoodsID = b.Goods_ID WHERE a.GoodsLst_OrderID = @OrderID;
			END
			
			-- 计算价格	
			EXEC sp_prv_price_CalcPriceByDocLst @tblDocIDs, @FromProvince, @FromCity, @FromDistrict, @ToProvince, @ToCity, @ToDistrict, @Pick, @Delivery, @OnLoad, @OffLoad, @PriceUnit, @ChargeMode, @CarType, @CarLength, @CarVolume, @CarWeight, @Weight, @Volume, @Count, @TransportMode, @IsInsurance, @GoodsValue, @CustomerCompanyID, @CreatorCompanyID, @CustomerID, 1, @Result = @Result OUTPUT, @_LessLoadCost = @_LessLoadCost OUTPUT, @_FullLoadCost = @_FullLoadCost OUTPUT, @_PickCost = @_PickCost OUTPUT, @_DeliveryCost = @_DeliveryCost OUTPUT, @_OnLoadCost = @_OnLoadCost OUTPUT, @_OffLoadCost = @_OffLoadCost OUTPUT, @_MinCost = @_MinCost OUTPUT, @_InsuranceCost = @_InsuranceCost OUTPUT, @_AdditionCost = @_AdditionCost OUTPUT, @_TaxCost = @_TaxCost OUTPUT, @_TotalCost = @_TotalCost OUTPUT,   @_LessLoadCostDocID = @_LessLoadCostDocID OUTPUT, @_FullLoadCostDocID = @_FullLoadCostDocID OUTPUT, @_PickCostDocID = @_PickCostDocID OUTPUT, @_DeliveryCostDocID = @_DeliveryCostDocID OUTPUT, @_OnLoadCostDocID = @_OnLoadCostDocID OUTPUT, @_OffLoadCostDocID = @_OffLoadCostDocID OUTPUT, @_MinCostDocID = @_MinCostDocID OUTPUT, @_InsuranceCostDocID = @_InsuranceCostDocID OUTPUT, @_AdditionCostDocID = @_AdditionCostDocID OUTPUT, @_TaxCostDocID = @_TaxCostDocID OUTPUT;
		END
		ELSE
		BEGIN
			-- 零担1
			SELECT TOP 1 @_LessLoadCost = a.Detail_Amount,@_LessLoadCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE a.Detail_Type = 1 AND 
a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
			
			-- 整车2
			SELECT TOP 1 @_FullLoadCost = a.Detail_Amount,@_FullLoadCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE a.Detail_Type = 2 AND 
a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
			
			-- 提货费3
			SELECT TOP 1 @_PickCost = a.Detail_Amount, @_PickCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE a.Detail_Type = 3 AND 
a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
			
			-- 送货费4
			SELECT TOP 1 @_DeliveryCost = a.Detail_Amount, @_DeliveryCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE a.Detail_Type = 4 AND 
a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
			
			-- 装货费5
			SELECT TOP 1 @_OnLoadCost = a.Detail_Amount, @_OnLoadCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 5 AND a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
			
			-- 卸货费6
			SELECT TOP 1 @_OffLoadCost = a.Detail_Amount, @_OffLoadCostDocID = b.Doc_ID  FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 6 AND a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
					
			-- 最低收费7
			SELECT TOP 1 @_MinCost = a.Detail_Amount,@_MinCostDocID = b.Doc_ID  FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 7 AND a.Detail_Invalid = 0 AND a.Detail_Amount > 0 ORDER BY a.Detail_CreateTime DESC;
		
			-- 保费8
			SELECT TOP 1 @_InsuranceCost = a.Detail_Amount, @_InsuranceCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 8 AND a.Detail_Invalid = 0 AND a.Detail_Amount > 0 ORDER BY a.Detail_CreateTime DESC;
		
			-- 附加费9
			SELECT @_AdditionCost = a.Detail_Amount, @_AdditionCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 9 AND a.Detail_Invalid = 0;
			
			-- 税费10
			SELECT TOP 1 @_TaxCost = a.Detail_Amount, @_TaxCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 10 AND a.Detail_Invalid = 0 AND a.Detail_Amount > 0 ORDER BY a.Detail_CreateTime DESC;

			-- 返回
			SET @_TotalCost = ISNULL(@_LessLoadCost, 0) + ISNULL(@_FullLoadCost, 0) + ISNULL(@_PickCost, 0) + ISNULL(@_DeliveryCost, 0) + ISNULL(@_OnLoadCost, 0) + ISNULL(@_OffLoadCost, 0) + ISNULL(@_AdditionCost, 0) + ISNULL(@_InsuranceCost, 0);
		END
	END


	-- 订单费用是否已经存在(已存在则置为无效,并新增费用)
	IF @Result = 0 AND @_TotalCost > 0 AND EXISTS(SELECT Cache_ID FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0)
	BEGIN
		UPDATE Price_OrderCache SET Cache_Invalid = 1 WHERE Cache_OrderID = @OrderID;
	END
	
	-- 合约报价基础费用是否存在 ，基础费用为零发出预警，并跳出存储过程
	IF @_LessLoadCost = 0 AND @_FullLoadCost = 0 AND @IsPricedByOrderID = 0 AND @IsCombineIndex = 0
	
	BEGIN
		EXEC sp_prv_event_AddEvent @Operator, 25, @FromCompanyID, 1, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510017010;
				END
		GOTO DIRECTLY_EXIT;
	END

	-- 将费用添加的订单价格缓存表
	IF @_LessLoadCost > 0 AND @IsCombineIndex = 0
	BEGIN
		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, 
Cache_Invalid, Cache_DocID) VALUES(@OrderID, 1, 0, @_LessLoadCost, @Operator, GETDATE(), 0, @_LessLoadCostDocID);
	END

	IF @_FullLoadCost > 0 AND @IsCombineIndex = 0
	BEGIN
		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, 
Cache_Invalid ,Cache_DocID) VALUES(@OrderID, 2, 0, @_FullLoadCost, @Operator, GETDATE(), 0,@_FullLoadCostDocID);
	END
	
	IF NOT EXISTS (SELECT * FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Pick = 0)
	BEGIN	
		IF @_PickCost > 0
		BEGIN
			INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, 
Cache_Invalid, Cache_DocID) VALUES(@OrderID, 3, 0, @_PickCost, @Operator, GETDATE(), 0,@_PickCostDocID);
		END
		ELSE
		BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 26, @FromCompanyID, 1, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510017010;
				END
		END
	END

	IF NOT EXISTS (SELECT * FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Delivery = 0) 
	BEGIN	
		IF @_DeliveryCost > 0
		BEGIN
			INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, 
Cache_Invalid, Cache_DocID) VALUES(@OrderID, 4, 0, @_DeliveryCost, @Operator, GETDATE(), 0,@_DeliveryCostDocID);
		END
	ELSE
		BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 27, @FromCompanyID, 1, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510017010;
				END
		END
	END	

	IF NOT EXISTS (SELECT * FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_OnLoad = 0)
	BEGIN	
		IF @_OnLoadCost > 0
		BEGIN
			INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, 
Cache_Invalid, Cache_DocID) VALUES(@OrderID, 5, 0, @_OnLoadCost, @Operator, GETDATE(), 0, @_OnLoadCostDocID);
		END
		ELSE
		BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 28, @FromCompanyID, 1, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510017010;
				END
		END
	END	
		
	IF NOT EXISTS (SELECT * FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_OffLoad = 0)
	BEGIN
		IF @_OffLoadCost > 0
		BEGIN
			INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, 
Cache_Invalid, Cache_DocID) VALUES(@OrderID, 6, 0, @_OffLoadCost, @Operator, GETDATE(), 0,@_OffLoadCostDocID);
		END
		ELSE
		BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 29, @FromCompanyID, 1, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510017010;
				END
		END
	END	

	IF @_MinCost > 0 AND @IsCombineIndex = 0
	BEGIN
		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, 
Cache_Invalid, Cache_DocID) VALUES(@OrderID, 7, 0, @_MinCost, @Operator, GETDATE(), 0, @_MinCostDocID);
	END

	IF NOT EXISTS (SELECT * FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Insurance = 0)
	BEGIN
		IF @_InsuranceCost > 0
		BEGIN
			INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, 
Cache_Invalid, Cache_DocID) VALUES(@OrderID, 8, 0, @_InsuranceCost, @Operator, GETDATE(), 0, @_InsuranceCostDocID);
		END
		ELSE
		BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 30, @FromCompanyID, 1, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510017010;
				END
		END
	END	

	IF @_AdditionCost <> 0 AND @IsCombineIndex = 0
	BEGIN
		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, 
Cache_Invalid, Cache_DocID) VALUES(@OrderID, 9, 0, @_AdditionCost, @Operator, GETDATE(), 0 ,@_AdditionCostDocID);
	END

	IF @_TaxCost <> 0 AND @IsCombineIndex = 0
	BEGIN
		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, 
Cache_Invalid, Cache_DocID) VALUES(@OrderID, 10, 0, @_TaxCost, @Operator, GETDATE(), 0, @_TaxCostDocID);
	END
		
	-- 被拼车的订单根据主单计算价格
	IF @IsCombineIndex = 1

	BEGIN
		SELECT TOP 1 @DocID=Doc_ID FROM @tblDocIDs
		EXEC sp_prv_price_CacheCombineOrderPrice @Operator, @OrderID, @_LessLoadCost, @_FullLoadCost, @_PickCost, @_DeliveryCost, @_OnLoadCost, @_OffLoadCost, @_AdditionCost, @_InsuranceCost, @_TaxCost, @IsDebugMode, @DocID,@Result = @Result OUTPUT;
	END

DIRECTLY_EXIT:

END
GO


