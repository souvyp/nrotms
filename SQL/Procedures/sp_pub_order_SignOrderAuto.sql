USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_SignOrderAuto]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_SignOrderAuto]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- �ڶ����б���ֱ�ӵ�ǩ��
CREATE PROCEDURE [dbo].[sp_pub_order_SignOrderAuto]
(
	@Operator BIGINT,
	@OrderID BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @FromCompanyID BIGINT;
	DECLARE @SrcOrderID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	BEGIN TRANSACTION;

	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510052001;
	END
	
	-- ��ǰ�û�û��ǩ�ն�����Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510052002;
	END
	
	-- �����Ƿ����
	IF @Result = 0
	BEGIN
		SELECT @FromCompanyID = Index_CustomerCompanyID, @SrcOrderID = Index_SrcOrderID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Invalid = 0
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510052003;
		END
	END
	
	-- �����Ƿ��Ѿ���ǩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Status = 2 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -510052004;
	END
	
	-- ǩ�ն���
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = 4, Index_StatusTime = GETDATE(), Index_Singer = @Operator, Index_SignTime = GETDATE() WHERE Index_ID = @OrderID AND Index_Invalid = 0 ANd Index_Status = 2;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510052005;
		END
	END
	
	-- ��Ӷ�������
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 2, 4, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510052006;
		END
	END
	
	IF @Result = 0
	BEGIN
		-- ����ʵǩ�������쳣����
		UPDATE TMS_OrderGoods SET GoodsLst_ReceiptQty = GoodsLst_Qty, GoodsLst_ExceptionQty = 0, GoodsLst_Updater = @Operator, GoodsLst_UpdateTime = GETDATE() WHERE GoodsLst_OrderID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510052007;
		END
	END
	
	--����¼�֪ͨ
	--�����̶���״̬��� ���� 16
	IF @Result = 0
	BEGIN
		DECLARE @tmpResult BIGINT;
		DECLARE @EventID BIGINT;
		DECLARE @OccurTime DATETIME;
		SET @tmpResult = 0;
		SET @EventID = 0;
		SET @OccurTime = GETDATE();
		
		EXEC sp_prv_event_AddEvent @Operator, 16, @FromCompanyID, 0, @SrcOrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
		IF @tmpResult <> 0 
		BEGIN
			SET @Result = -510052008;
		END
	END
	
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS Order_Result;

	SET NOCOUNT OFF;
END
GO


