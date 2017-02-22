USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_SendCombineOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_SendCombineOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*����ƴ����*/
CREATE PROCEDURE [dbo].[sp_pub_order_SendCombineOrder]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@Description NVARCHAR(512)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @Result = 0;
	SET @SupplierCompanyID = 0;

	BEGIN TRANSACTION;
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510047001;
	END
	
	-- ��ǰ�û�û�йرն�����Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510047002;
	END
	
	-- ƴ���Ƿ����(ֻ���µ��ݵ�ƴ�������ܷ���)
	IF @Result = 0
	BEGIN
		SELECT @SupplierCompanyID = Index_SupplierCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_SrcClass = 3 AND Index_Status = 0 AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510047003;
		END
	END
	
	-- ���Ͷ���
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = 1, Index_StatusTime = GETDATE() WHERE Index_ID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510047004;
		END
	END
	
	-- ��Ӷ�������
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 0, 1, 0, @Description, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510047005;
		END
	END
	
	IF @Result = 0
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
			SET @Result = -510047006;
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


