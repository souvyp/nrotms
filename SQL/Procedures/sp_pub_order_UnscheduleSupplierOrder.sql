USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_UnscheduleSupplierOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_UnscheduleSupplierOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--����ί�и������̵ĵ���(�Է�δ����ǰ)
CREATE PROCEDURE [dbo].[sp_pub_order_UnscheduleSupplierOrder]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@Description NVARCHAR(512) = N''
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @SrcClass BIGINT;
	DECLARE @SupplierID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @SrcClass = 0;
	SET @SupplierID = 0;
	SET @SupplierCompanyID = 0;
	
	BEGIN TRANSACTION;

	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510055001;
	END
	
	-- ��ǰ�û�û�з��Ͷ�����Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510055002;
	END

	-- ��ǰ�����Ƿ����
	/*
	1��������ƥ��
	2��������Ч Invalid = 0
	3��������ί�е��Է�δ����
	4����ȡ������ID�������̹�˾ID������ȫ�ֱ���������Ҫ�õ�
	5����ȡ��������ͨ�������ϵ�����
	*/
	IF @Result = 0
	BEGIN
		SELECT @SrcClass = Index_SrcClass, @SupplierID = Index_SupplierID, @SupplierCompanyID = Index_SupplierCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND 
Index_Invalid = 0 AND Index_CreatorCompanyID = @CompanyID AND Index_SupplierID > 0 AND Index_Status = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510055003;
		END
		ELSE
		BEGIN
			IF @SupplierCompanyID <= 0
			BEGIN
				SET @Result = -510055004;
			END
		END
	END

	-- �޸Ķ�����Ӧ�ֶ�
	/*
	Index_SupplierID = 0, Index_SupplierCompanyID = 0
	*/
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = (CASE WHEN @SrcClass = 3 THEN 0 ELSE 1 END), Index_SupplierID = 0, Index_SupplierCompanyID = 0 WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND Index_Status = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510055005;
		END
	END

	-- ��Ӷ�������
	-- Ext��д������ţ�Descriptionд����������
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, (CASE WHEN @SrcClass = 3 THEN 0 ELSE 1 END), 4, @Description, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510055006;
		END
	END
	
	-- ����¼�֪ͨ
	-- ���������� ���� �����̵�֪ͨ
	-- ֪ͨ���� 17����ʾ�ͻ���������ί��
	IF @Result = 0
	BEGIN
		DECLARE @OccurTime DATETIME;
		DECLARE @EventID BIGINT;
		DECLARE @tmpResult BIGINT;
		SET @OccurTime = GETDATE();
		SET @EventID = 0;
		SET @tmpResult = 0;

		EXEC sp_prv_event_AddEvent @Operator, 17, @SupplierCompanyID, 0, @OrderID, @OccurTime, @Description, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
		IF @tmpResult <> 0 
		BEGIN
			SET @Result = -510055007;
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

	SELECT @Result AS Schedule_Result;

	SET NOCOUNT OFF;
END
GO


