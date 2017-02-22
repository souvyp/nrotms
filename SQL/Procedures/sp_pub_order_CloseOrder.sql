USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_CloseOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_CloseOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*�رն���*/
CREATE PROCEDURE [dbo].[sp_pub_order_CloseOrder]
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
	DECLARE @SrcStatus BIGINT;
	DECLARE @DstStatus BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	DECLARE @SrcOrderID BIGINT;
	DECLARE @FromCompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @SrcStatus = 0;
	SET @DstStatus = 32;
	
	BEGIN TRANSACTION;
	
	-- û����д�ر�����	
	IF LEN(@Description)=0
	BEGIN
		SET @Result = -510034008;
	END

	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510034001;
	END
	
	-- ��ǰ�û�û�йرն�����Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND dbo.fn_pub_user_User2RoleID(@Operator) = 256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510034002;
	END
	
	-- �����Ƿ����
	IF @Result = 0
	BEGIN
		SELECT @SrcStatus = Index_Status FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Status <> 16 AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510034003;
		END
	END
	


	-- �رն���
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE() WHERE Index_ID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510034004;
		END		
	END
	
	-- �������
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, @SrcStatus, @DstStatus, 0, @Description, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510034005;
		END
	END
	
	IF @Result = 0
	BEGIN
		--����¼�֪ͨ
		DECLARE @tmpResult BIGINT;
		DECLARE @EventID BIGINT;
		DECLARE @OccurTime DATETIME;
		SET @tmpResult = 0;
		SET @EventID = 0;
		SET @OccurTime = GETDATE();
		
		SELECT @SupplierCompanyID = Index_SupplierCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SupplierID > 0 AND Index_SupplierCompanyID > 0
		IF @@ROWCOUNT = 0
		BEGIN
			--������ ���� ����������
			--�����̹رն��� ���� 21
			SELECT @FromCompanyID = Index_CustomerCompanyID, @SrcOrderID = (CASE WHEN Index_SrcOrderID =0 THEN Index_ID ELSE Index_SrcOrderID END) FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Invalid = 0
			EXEC sp_prv_event_AddEvent @Operator, 21, @FromCompanyID, 0, @SrcOrderID, @OccurTime, @Description, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
			IF @tmpResult <> 0 
			BEGIN
				SET @Result = -510034007;
			END
		END
		ELSE
		BEGIN
			--���������� ���� ������
			--�ͻ��ر�ί�ж��� ���� 18
			EXEC sp_prv_event_AddEvent @Operator, 18, @SupplierCompanyID, 0, @OrderID, @OccurTime, @Description, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
			IF @tmpResult <> 0 
			BEGIN
				SET @Result = -510034006;
			END
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


