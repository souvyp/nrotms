USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_SendBackOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_SendBackOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*��ض���(�볷�ز�һ��)*/
CREATE PROCEDURE [dbo].[sp_pub_order_SendBackOrder]
(
	@OrderID BIGINT,
	@Operator BIGINT,
	@Description NVARCHAR(512)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @SrcStatus BIGINT;
	DECLARE @DstStatus BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @SrcStatus = 0;
	SET @DstStatus = 0;
	
	BEGIN TRANSACTION;

	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510033001;
	END
	
	-- ��ǰ�û�û�д�ض�����Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510033002;
	END
	
	-- �����Ƿ����
	IF @Result = 0
	BEGIN
		SELECT @SrcStatus = Index_Status FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Status > 0 AND Index_Status < 16 AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510033003;
		END
	END
	
	-- �Ѿ�ί�й�Ӧ�̳��˵ĵ�����ʱ���ܴ��
	IF @Result = 0 AND EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SupplierID > 0 AND Index_SupplierCompanyID > 0)
	BEGIN
		SET @Result = -510033004;
	END

	-- ���㶩����Ŀ��״̬
	IF @Result = 0
	BEGIN
		-- �����(������)
		IF @SrcStatus = 1
		BEGIN
			SET @DstStatus = 0;

			UPDATE TMS_OrderIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE(), Index_Confirmer = 0, Index_SupplierID = 0, Index_SupplierCompanyID = 0 WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510033005;
			END
		END
		
		-- �ѷ���(��ǩ��)
		IF @SrcStatus = 2
		BEGIN
			SET @DstStatus = 1;
			
			UPDATE TMS_OrderIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE(), Index_DriverID = 0, Index_CarID = 0 WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510033006;
			END
		END
		
		-- ��ǩ��(���ص�)
		IF @SrcStatus = 4
		BEGIN
			SET @DstStatus = 2;
			
			UPDATE TMS_OrderIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE(), Index_Singer = 0, Index_Exception = '' WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510033007;
			END
			
			IF @Result = 0
			BEGIN
				UPDATE TMS_OrderGoods SET GoodsLst_ReceiptQty = 0, GoodsLst_ExceptionQty = 0, GoodsLst_Updater = 0, GoodsLst_UpdateTime = GETDATE() WHERE GoodsLst_OrderID = @OrderID AND GoodsLst_Invalid = 0;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510033008;
				END
			END
		END
		
		-- �ѻص�(������)���ݲ�ʵ��
		-- IF @SrcStatus = 8
	END
	
	-- �������
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, @SrcStatus, @DstStatus, 2, @Description, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510033009;
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
	
	SELECT @Result AS Back_Result;

	SET NOCOUNT OFF;
END
GO


