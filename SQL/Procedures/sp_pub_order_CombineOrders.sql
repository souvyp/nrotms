USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_CombineOrders]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_CombineOrders]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
ƴ��

@OrdersLst�Ǳ�ƴ���Ķ����б���ʽ��
orderid1,orderid2,orderid3
*/
CREATE PROCEDURE [dbo].[sp_pub_order_CombineOrders]
(
	@Operator BIGINT,
	@OrderID BIGINT = 0,
	@PactCode NVARCHAR(100),
	-- [ί��]�����̱��
	@SupplierID BIGINT = 0,
	@OrdersLst NVARCHAR(MAX) = N'',
	@Descriptions NVARCHAR(MAX) = N'',
	@SendDirectly TINYINT = 1, 
	@ShipMode BIGINT = 1,
	@TxnRequired TINYINT = 1,
	-- [��Ӫ]�����̱��ID
	@SupplierSymbolID BIGINT = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @CustomerID BIGINT;
	DECLARE @CustomerCompanyID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	DECLARE @InsertMode TINYINT;
	DECLARE @Code NVARCHAR(100);
	SET @Result = 0;
	SET @CustomerID = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @CustomerCompanyID = @CompanyID;
	IF @OrderID IS NULL OR @OrderID = 0
	BEGIN
		EXEC sp_pub_basic_GetSN 2, @SN = @Code OUTPUT, @AdditionType = 1;
	END
	SET @SupplierCompanyID = 0;
	SET @InsertMode = 0;
	IF @SendDirectly IS NULL
	BEGIN
		SET @SendDirectly = 1;
	END
	IF @OrdersLst IS NULL
	BEGIN
		SET @OrdersLst = '';
	END
	IF @SupplierID IS NULL
	BEGIN
		SET @SupplierID = 0;
	END
	IF @SupplierSymbolID IS NULL
	BEGIN
		SET @SupplierSymbolID = 0;
	END
	
	IF @TxnRequired = 1
	BEGIN
		BEGIN TRANSACTION;
	END
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510040001;
	END
	
	IF @Result = 0 AND LEN(@OrdersLst) = 0
	BEGIN
		SET @Result = -510040002;
	END
	
	-- ��ǰ�û�û����ӿͻ���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510040003;
	END
	
	-- �ͻ�Ĭ��Ϊ�Լ���˾
	IF @Result = 0
	BEGIN
		SELECT @CustomerID = Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @CompanyID AND Customer_CompanyID = @CompanyID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510040004;
		END
	END
	
	-- �༭ģʽ�����Ƿ����[ֻ�ܱ༭�Լ���˾�Ķ���]
	IF @Result = 0 AND @OrderID > 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SrcClass = 3 AND Index_Invalid = 0 ANd Index_CreatorCompanyID = @CompanyID)
	BEGIN
		SET @Result = -510040005;
	END
	
	-- ֻ�ܱ༭״̬Ϊ�µ��ݵĶ���
	IF @Result = 0 AND @OrderID > 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SrcClass = 3 AND Index_Invalid = 0 AND Index_Status = 0)
	BEGIN
		SET @Result = -510040006;
	END

	-- ��Ӧ���Ƿ����
	IF @Result = 0 AND @SupplierID > 0
	BEGIN
		SELECT @SupplierCompanyID = Supplier_CompanyID FROM TMS_MSupplier WHERE Supplier_ID = @SupplierID AND Supplier_OwnerCompanyID = @CompanyID AND Supplier_Invalid = 0 AND Supplier_Status = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510040007;
		END
	END
	
	-- �����̱���Ƿ����
	IF @Result = 0 AND @SupplierSymbolID > 0 AND NOT EXISTS(SELECT Symbol_ID FROM TMS_MSymbol WHERE Symbol_CompanyID = @CompanyID AND Symbol_Type = 2 AND Symbol_Invalid = 0)
	BEGIN
		SET @Result = -510040016;
	END
	
	-- ���������Ϣ
	IF @Result = 0
	BEGIN
		IF @OrderID = 0 OR @OrderID IS NULL
		BEGIN
			INSERT INTO TMS_OrderIndex(Index_Code, Index_PactCode, Index_Status, Index_StatusTime, Index_SrcClass, 
Index_SupplierID, Index_SupplierCompanyID, Index_ShipMode, Index_CustomerID, Index_CustomerCompanyID, 
Index_Creator, Index_CreatorCompanyID, Index_CreateTime, Index_Invalid, Index_Description, Index_SupplierSymbolID) VALUES(@Code, @PactCode, 
(CASE WHEN @SendDirectly = 1 THEN 1 ELSE 0 END), GETDATE(), 3, 
@SupplierID, @SupplierCompanyID, @ShipMode, @CustomerID, @CustomerCompanyID, @Operator, @CompanyID, GETDATE(), 0, @Descriptions, @SupplierSymbolID);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510040008;
			END
			ELSE
			BEGIN
				SET @OrderID = IDENT_CURRENT('TMS_OrderIndex');
				
				-- �ϵ��ĸ����������Լ�
				UPDATE TMS_OrderIndex SET Index_RootOrderID = @OrderID WHERE Index_ID = @OrderID;
				
				SET @InsertMode = 1;
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_OrderIndex SET Index_PactCode = @PactCode, Index_CustomerID = @CustomerID, Index_CustomerCompanyID = @CustomerCompanyID, 
Index_SupplierID = @SupplierID, Index_SupplierCompanyID = @SupplierCompanyID, Index_ShipMode = @ShipMode, Index_RootOrderID = @OrderID, Index_Description = @Descriptions,
Index_Status = (CASE WHEN @SendDirectly = 1 THEN 1 ELSE 0 END), Index_StatusTime = GETDATE(), Index_SupplierSymbolID = @SupplierSymbolID WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510040009;
			END
		END
	END
	
	-- ��Ӷ�������
	IF @Result = 0 AND @SendDirectly = 1
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 0, 1, 0, N'Send order auomatically!', @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510040010;
		END
	END

	-- ׷�ӱ��ϵ��Ķ���
	IF @Result = 0 AND LEN(@OrdersLst) > 0
	BEGIN
		-- �޸�ƴ����
		IF @InsertMode = 0
		BEGIN		
			-- ���б��ϵ����
			UPDATE TMS_OrderIndex SET Index_Combined = 0, Index_SupplierID = 0, Index_SupplierCompanyID = 0 WHERE Index_ID IN (SELECT Contains_OrderID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510040011;
			END
			ELSE
			-- ɾ������ƴ����¼
			BEGIN
				DELETE FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510040012;
				END
			END
		END
		
		IF @Result = 0
		BEGIN
			DECLARE @tblOrders TABLE
			(
				OrderID BIGINT
			);
			INSERT INTO @tblOrders SELECT CAST(N.v.value('.' , 'varchar(100)') AS BIGINT) FROM (SELECT  [value] = CONVERT(XML , '<v>' + REPLACE(@OrdersLst, ',' , '</v><v>') + '</v>')) A CROSS APPLY A.[value].nodes('/v') N ( v );

			-- ���ƴ����¼
			-- orderid1,orderid2,orderid3
			INSERT INTO TMS_OrderContains(Contains_OwnerOrderID, Contains_OrderID, Contains_Volume, Contains_Weight, Contains_Amount, Contains_Creator, Contains_InsertTime,
Contains_Invalid) SELECT @OrderID, a.Index_ID, dbo.fn_pub_order_TotalVolume(a.Index_ID, 0), dbo.fn_pub_order_TotalWeight(a.Index_ID, 0), dbo.fn_pub_order_TotalAmount(a.Index_ID, 0), 
@Operator, GETDATE(), 0 FROM TMS_OrderIndex AS a INNER JOIN @tblOrders AS b ON a.Index_ID = b.OrderID WHERE Index_SrcClass = 2 AND Index_Invalid = 0 AND Index_Status = 1 AND Index_ShipMode = @ShipMode; 
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510040013;
			END
			ELSE
			-- ���ϵ����������
			BEGIN
				UPDATE TMS_OrderIndex SET Index_Combined = 1,Index_SupplierCompanyID = (CASE WHEN @SendDirectly = 1 THEN @SupplierCompanyID ELSE 0 END), Index_SupplierID = (CASE WHEN @SendDirectly = 1 THEN @SupplierID ELSE 0 END),Index_StatusTime = GETDATE(), Index_SupplierSymbolID = (CASE WHEN @SendDirectly = 1 THEN @SupplierSymbolID ELSE 0 END) WHERE Index_ID IN (SELECT Contains_OrderID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510040014;
				END
			END
		END
	END
	
	-- ��Ӫƴ����û��֪ͨ
	IF @Result = 0 AND @SupplierID > 0 AND @SendDirectly = 1
	BEGIN
		-- ����¼�֪ͨ(�д�����ƴ����)
		DECLARE @tmpResult BIGINT;
		DECLARE @EventID BIGINT;
		DECLARE @OccurTime DATETIME;
		SET @tmpResult = 0;
		SET @EventID = 0;
		SET @OccurTime = GETDATE();
					
		EXEC sp_prv_event_AddEvent @Operator, 12, @SupplierCompanyID, 0, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
		IF @tmpResult <> 0 
		BEGIN
			SET @Result = -510040015;
		END
	END

	-- ��Ӫƴ�������Զ����͡�����
	IF @Result = 0 AND @SupplierSymbolID > 0 AND @SupplierID = 0
	BEGIN
		-- �Զ�����
		UPDATE TMS_OrderIndex SET Index_Status = 1, Index_StatusTime = GETDATE() WHERE Index_ID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510040017;
		END
	
		-- ��ӷ��Ͷ�������
		IF @Result = 0
		BEGIN
			INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 0, 1, 0, 'Send combined orders automatically!', @Operator, @CompanyID, GETDATE(), 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510040018;
			END
		END
		
		-- �Զ�����
		IF @Result = 0
		BEGIN
		    UPDATE TMS_OrderIndex SET Index_Status = 2, Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE() WHERE Index_ID = @OrderID;
		    IF @@ROWCOUNT = 0
		    BEGIN
				SET @Result = -510040019;
		    END
		END

		-- ��ӽ��ն�������
		IF @Result = 0
		BEGIN
			INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, 2, 0, 'Receive combined orders automatically!', @Operator, @CompanyID, GETDATE(), 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510040020;
			END
		END
			
		-- ���±��ϵ������б�����������������������
		IF @Result = 0
		BEGIN
			UPDATE TMS_OrderContains SET Contains_Volume = dbo.fn_pub_order_TotalVolume(Contains_OrderID, 0), Contains_Weight = dbo.fn_pub_order_TotalWeight(Contains_OrderID, 0), 
Contains_Amount = dbo.fn_pub_order_TotalAmount(Contains_OrderID, 0) WHERE Contains_OwnerOrderID= @OrderID AND Contains_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510040021;
			END
		END
		
		-- ���±��϶����ĳ����̱�� �Զ� ��Ϊǩ��״̬
		IF @Result = 0
		BEGIN
			UPDATE a SET a.Index_SupplierSymbolID = @SupplierSymbolID, a.Index_Status = 2, a.Index_StatusTime = GETDATE() FROM TMS_OrderIndex AS a 
INNER JOIN TMS_OrderContains AS b ON a.Index_ID = b.Contains_OrderID WHERE b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510040022;
			END
		END
		
		-- ��ӱ��϶�������
		IF @Result = 0
		BEGIN
			INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) SELECT 
a.Index_ID, 1, 2, 0, 'Schedule combined orders automatically!', a.Index_Creator, a.Index_CreatorCompanyID, GETDATE(), 0 FROM TMS_OrderIndex AS a INNER JOIN TMS_OrderContains AS b ON a.Index_ID = b.Contains_OrderID WHERE b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510040023;
			END
		END
	END

	IF @TxnRequired = 1
	BEGIN
		IF @Result = 0
		BEGIN
			COMMIT TRANSACTION;
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION;
		END
	END

	SELECT @Result AS Order_Result, @OrderID AS Order_ID;
	
	SET NOCOUNT ON;
END
GO


