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

/*���㶩���۸�*/
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
	DECLARE @IsCombineIndex BIGINT;					-- �Ƿ�Ϊƴ��������
	DECLARE @IsPricedByOrderID BIGINT;				-- �Ƿ�Ϊ��������
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
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510038002;
	END

	-- ��ǰ�û�û����ӿͻ���Ȩ��(ȡ���û��Ƿ���Ч��֤��ֻ��Ҫ�û����ڣ�User_Invalid = 0)
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID )
	BEGIN
		SET @Result = -510038003;
	END

	-- ���ϵ��Ķ������ܵ�������۸�[ֱ���˳��洢����]
	IF @Result = 0 AND EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Combined = 1 AND Index_Invalid = 0)
	BEGIN
		GOTO DIRECTLY_EXIT;
	END

	-- ��ȡ��ǰ�ͻ��Լ�Ӱ�챨�۵���������
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
	
	-- �����ڵ��ñ��洢����ǰ��ִ�й�У��

	-- ��ȡ�������������������
	IF @Result = 0
	BEGIN
		SET @Weight = dbo.fn_pub_order_TotalWeight(@OrderID, 0);
		SET @Volume = dbo.fn_pub_order_TotalVolume(@OrderID, 0);
		SET @Count = dbo.fn_pub_order_TotalAmount(@OrderID, 0);
		
		-- �������������Total�������Ѵ���

		-- ����ϵͳ��������λ�ǹ�������λ�������ף��Ƽ۵�λ����԰�Ҫ������ѡ��
		-- Ӧ�����������������������ɼƼ۵�λ
		SET @Weight = dbo.fn_pub_price_OrderWeightCast( @Weight, @PriceUnit );
		SET @Volume = dbo.fn_pub_price_OrderVolumeCast( @Volume, @PriceUnit );
	END

	-- ί�и������̵Ķ�����Ӧ��ʹ�ó����̵ı��ۣ����͵�����һ��
	IF @Result = 0 AND @SupplierCompanyID > 0 AND @IsCombineIndex = 0
	BEGIN
		SELECT @CustomerID = Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @SupplierCompanyID AND 
Customer_CompanyID = @CompanyID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			-- ��ǰ��˾���ǳ����̵Ŀͻ�
			SET @Result = -10039005;
		END
		ELSE
		BEGIN
			SET @CustomerCompanyID = @CompanyID;
			SET @CreatorCompanyID = @SupplierCompanyID;
			
			-- һ����˵����������ģʽ�³����̶���Ϊ�Լ����յĿͻ��������ۣ��ͻ������䶩��û��ֱ��ƥ��ı�����Ϣ
			-- �����뵱ǰ���������Եĳ����̿ͻ�����
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
		-- �ϵ������Ƿ����ƥ�䱨��[������ڶ����ѡ�����һ��][�������ǰ������ۣ���������]
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
			-- �ÿͻ��Ƿ���ڰ�������[������ڶ����ѡ�����һ��][����������������]
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

				-- �ÿͻ��Ƿ���ں�Լ����
				INSERT INTO @tblDocIDs SELECT Index_ID FROM Price_DocIndex WHERE Index_CustomerID = @CustomerID AND 
Index_CustomerCompanyID = @CustomerCompanyID AND Index_Type = 2 AND Index_Invalid = 0 AND Index_Status = 2 AND 
Index_CreatorCompanyID = @CreatorCompanyID AND Index_StartTime <= @OrderTime AND Index_EndTime >= @OrderTime ORDER BY Index_CreateTime DESC;
				IF @@ROWCOUNT > 0
				BEGIN
					SET @PriceFound = 1;
				END
			END
		END
		
		-- �ÿͻ��Ƿ���ڲ��䱨��[���䱨�۱������ǰ������ۣ���������]
		IF @PriceFound = 1
		BEGIN
			INSERT INTO @tblDocIDs SELECT Index_ID FROM Price_DocIndex WHERE Index_OrderID IN (@OrderID, @SupplierOrderID) AND Index_Type = 3 AND Index_Invalid = 0 AND 
Index_Status = 2 AND Index_CustomerID = @CustomerID AND Index_CustomerCompanyID = @CustomerCompanyID AND Index_CreatorCompanyID = @CreatorCompanyID;
		END
	END
	-- ����ģʽ��ʾ������Ϣ
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
	
	-- �ͻ�������Ϣ֪ͨ@FromCompanyID �ǿͻ� ���䶩�� ��Ϣ֪ͨ@FromCompanyID �Ǳ���˾
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
			-- ��ȡ�����ܼ�ֵ
			IF @GoodsValue = 0 
			BEGIN
				SELECT @GoodsValue = SUM(ISNULL(b.Goods_Price, 0) * ISNULL(a.GoodsLst_Qty, 0)) FROM TMS_OrderGoods AS a INNER JOIN TMS_MGoods AS b ON a.GoodsLst_GoodsID = b.Goods_ID WHERE a.GoodsLst_OrderID = @OrderID;
			END
			
			-- ����۸�	
			EXEC sp_prv_price_CalcPriceByDocLst @tblDocIDs, @FromProvince, @FromCity, @FromDistrict, @ToProvince, @ToCity, @ToDistrict, @Pick, @Delivery, @OnLoad, @OffLoad, @PriceUnit, @ChargeMode, @CarType, @CarLength, @CarVolume, @CarWeight, @Weight, @Volume, @Count, @TransportMode, @IsInsurance, @GoodsValue, @CustomerCompanyID, @CreatorCompanyID, @CustomerID, 1, @Result = @Result OUTPUT, @_LessLoadCost = @_LessLoadCost OUTPUT, @_FullLoadCost = @_FullLoadCost OUTPUT, @_PickCost = @_PickCost OUTPUT, @_DeliveryCost = @_DeliveryCost OUTPUT, @_OnLoadCost = @_OnLoadCost OUTPUT, @_OffLoadCost = @_OffLoadCost OUTPUT, @_MinCost = @_MinCost OUTPUT, @_InsuranceCost = @_InsuranceCost OUTPUT, @_AdditionCost = @_AdditionCost OUTPUT, @_TaxCost = @_TaxCost OUTPUT, @_TotalCost = @_TotalCost OUTPUT,   @_LessLoadCostDocID = @_LessLoadCostDocID OUTPUT, @_FullLoadCostDocID = @_FullLoadCostDocID OUTPUT, @_PickCostDocID = @_PickCostDocID OUTPUT, @_DeliveryCostDocID = @_DeliveryCostDocID OUTPUT, @_OnLoadCostDocID = @_OnLoadCostDocID OUTPUT, @_OffLoadCostDocID = @_OffLoadCostDocID OUTPUT, @_MinCostDocID = @_MinCostDocID OUTPUT, @_InsuranceCostDocID = @_InsuranceCostDocID OUTPUT, @_AdditionCostDocID = @_AdditionCostDocID OUTPUT, @_TaxCostDocID = @_TaxCostDocID OUTPUT;
		END
		ELSE
		BEGIN
			-- �㵣1
			SELECT TOP 1 @_LessLoadCost = a.Detail_Amount,@_LessLoadCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE a.Detail_Type = 1 AND 
a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
			
			-- ����2
			SELECT TOP 1 @_FullLoadCost = a.Detail_Amount,@_FullLoadCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE a.Detail_Type = 2 AND 
a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
			
			-- �����3
			SELECT TOP 1 @_PickCost = a.Detail_Amount, @_PickCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE a.Detail_Type = 3 AND 
a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
			
			-- �ͻ���4
			SELECT TOP 1 @_DeliveryCost = a.Detail_Amount, @_DeliveryCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE a.Detail_Type = 4 AND 
a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
			
			-- װ����5
			SELECT TOP 1 @_OnLoadCost = a.Detail_Amount, @_OnLoadCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 5 AND a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
			
			-- ж����6
			SELECT TOP 1 @_OffLoadCost = a.Detail_Amount, @_OffLoadCostDocID = b.Doc_ID  FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 6 AND a.Detail_Invalid = 0 ORDER BY a.Detail_CreateTime DESC;
					
			-- ����շ�7
			SELECT TOP 1 @_MinCost = a.Detail_Amount,@_MinCostDocID = b.Doc_ID  FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 7 AND a.Detail_Invalid = 0 AND a.Detail_Amount > 0 ORDER BY a.Detail_CreateTime DESC;
		
			-- ����8
			SELECT TOP 1 @_InsuranceCost = a.Detail_Amount, @_InsuranceCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 8 AND a.Detail_Invalid = 0 AND a.Detail_Amount > 0 ORDER BY a.Detail_CreateTime DESC;
		
			-- ���ӷ�9
			SELECT @_AdditionCost = a.Detail_Amount, @_AdditionCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 9 AND a.Detail_Invalid = 0;
			
			-- ˰��10
			SELECT TOP 1 @_TaxCost = a.Detail_Amount, @_TaxCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 10 AND a.Detail_Invalid = 0 AND a.Detail_Amount > 0 ORDER BY a.Detail_CreateTime DESC;

			-- ����
			SET @_TotalCost = ISNULL(@_LessLoadCost, 0) + ISNULL(@_FullLoadCost, 0) + ISNULL(@_PickCost, 0) + ISNULL(@_DeliveryCost, 0) + ISNULL(@_OnLoadCost, 0) + ISNULL(@_OffLoadCost, 0) + ISNULL(@_AdditionCost, 0) + ISNULL(@_InsuranceCost, 0);
		END
	END


	-- ���������Ƿ��Ѿ�����(�Ѵ�������Ϊ��Ч,����������)
	IF @Result = 0 AND @_TotalCost > 0 AND EXISTS(SELECT Cache_ID FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0)
	BEGIN
		UPDATE Price_OrderCache SET Cache_Invalid = 1 WHERE Cache_OrderID = @OrderID;
	END
	
	-- ��Լ���ۻ��������Ƿ���� ����������Ϊ�㷢��Ԥ�����������洢����
	IF @_LessLoadCost = 0 AND @_FullLoadCost = 0 AND @IsPricedByOrderID = 0 AND @IsCombineIndex = 0
	
	BEGIN
		EXEC sp_prv_event_AddEvent @Operator, 25, @FromCompanyID, 1, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510017010;
				END
		GOTO DIRECTLY_EXIT;
	END

	-- ��������ӵĶ����۸񻺴��
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
		
	-- ��ƴ���Ķ���������������۸�
	IF @IsCombineIndex = 1

	BEGIN
		SELECT TOP 1 @DocID=Doc_ID FROM @tblDocIDs
		EXEC sp_prv_price_CacheCombineOrderPrice @Operator, @OrderID, @_LessLoadCost, @_FullLoadCost, @_PickCost, @_DeliveryCost, @_OnLoadCost, @_OffLoadCost, @_AdditionCost, @_InsuranceCost, @_TaxCost, @IsDebugMode, @DocID,@Result = @Result OUTPUT;
	END

DIRECTLY_EXIT:

END
GO


