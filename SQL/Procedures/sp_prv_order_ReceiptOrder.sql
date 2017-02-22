USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_ReceiptOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_ReceiptOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*�����ص�*/
CREATE PROCEDURE [dbo].[sp_prv_order_ReceiptOrder]
(
	@Operator BIGINT,
	@CompanyID BIGINT,
	@OrderID BIGINT,
	@ReceiptDocPath0 NVARCHAR(512) = N'',
	@ReceiptDocPath1 NVARCHAR(512) = N'',
	@ReceiptDocPath2 NVARCHAR(512) = N'',
	@ReceiptDocPath3 NVARCHAR(512) = N'',
	@IsPaperReceived BIGINT = 0,
	@TxnRequired BIGINT,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SrcOrderID BIGINT;
	DECLARE @FromCompanyID BIGINT;
	DECLARE @Description NVARCHAR(512);
	
	IF @TxnRequired = 1
	BEGIN
		BEGIN TRANSACTION;
	END


	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510020001;
	END
	
	-- ��ǰ�û�û���ύ�����ص���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510020002;
	END
	
	-- �����Ƿ����
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Invalid = 0)
	BEGIN
		SET @Result = -510020003;
	END
	
	-- �����Ƿ��Ѿ��ص�
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Status = 4 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -510020004;
	END
	
	-- �ص�·������Ϊ��
	-- 2016.5.11 ȥ���ص�·����У��
	/*
	IF @Result = 0 AND (@ReceiptDocPath IS NULL OR @ReceiptDocPath = '')
	BEGIN
		SET @Result = -510020005;
	END
	*/
	
	-- �����ص�
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = (CASE WHEN @IsPaperReceived = 1 THEN 8 ELSE Index_Status END), 
Index_StatusTime = (CASE WHEN @IsPaperReceived = 1 THEN GETDATE() ELSE Index_StatusTime END), 
Index_ReceiptDoc = @ReceiptDocPath0,
Index_ReceiptDoc1 = @ReceiptDocPath1,
Index_ReceiptDoc2 = @ReceiptDocPath2,
Index_ReceiptDoc3 = @ReceiptDocPath3 WHERE Index_ID = @OrderID AND Index_Invalid = 0 ANd Index_Status = 4;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510020006;
		END
	END
	
	-- ��Ӷ�������
	IF @Result = 0 AND @IsPaperReceived = 1
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 4, 8, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510020007;
		END
	END
	
	--����¼�֪ͨ
	IF @Result = 0
	BEGIN
		DECLARE @tmpResult BIGINT;
		DECLARE @EventID BIGINT;
		DECLARE @OccurTime DATETIME;
		SET @tmpResult = 0;
		SET @EventID = 0;
		SET @OccurTime = GETDATE();
		
		SELECT @FromCompanyID = Index_CustomerCompanyID, @SrcOrderID = Index_SrcOrderID, @Description = Index_ReceiptDoc + ',' + Index_ReceiptDoc1 + ',' + Index_ReceiptDoc2  FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Invalid = 0
		
		IF @IsPaperReceived = 1
		BEGIN
			--������ ���� ����������
			--���� 20 �����ѻص�
			EXEC sp_prv_event_AddEvent @Operator, 20, @FromCompanyID, 0, @SrcOrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
			IF @tmpResult <> 0 
			BEGIN
				SET @Result = -510020008;
			END
		END
		ELSE
		BEGIN
			--������ ���� ����������
			--���� 19 �������ϴ��ص���Ƭ
			EXEC sp_prv_event_AddEvent @Operator, 19, @FromCompanyID, 0, @SrcOrderID, @OccurTime, @Description, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
			IF @tmpResult <> 0 
			BEGIN
				SET @Result = -510020009;
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
	
	SET NOCOUNT OFF;
	END
END

GO