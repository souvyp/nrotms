USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_my_SupplierAccept]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_my_SupplierAccept]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ���ܻ�ܾ���Ӧ������
CREATE PROCEDURE [dbo].[sp_prv_my_SupplierAccept]
(
	@Operator BIGINT,
	@SupplierID BIGINT,
	@Op BIGINT,				-- 1 ���� 2 �ܾ�
	@TxnRequired BIGINT = 0,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	DECLARE @CompanyID BIGINT;
	DECLARE @OwnerCompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @OwnerCompanyID = 0;
	
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510023001;
	END
	
	-- ��ǰ�û�û�в�����Ӧ�̵�Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510023002;
	END

	-- ��Ӧ�̹�˾����Ƿ���Ч
	IF @Result = 0
	BEGIN
		SELECT @OwnerCompanyID = Supplier_OwnerCompanyID FROM TMS_MSupplier WHERE Supplier_ID = @SupplierID AND Supplier_CompanyID = @CompanyID AND Supplier_Status = 0 AND Supplier_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510023003;
		END
	END

	-- ���ܻ��߾ܾ�
	DECLARE @tmpResult BIGINT;
	DECLARE @EventID BIGINT;
	DECLARE @OccurTime DATETIME;
	SET @tmpResult = 0;
	SET @EventID = 0;
	SET @OccurTime = GETDATE();

	IF @Result = 0
	BEGIN
		IF @Op = 1
		BEGIN
			-- ����
			UPDATE TMS_MSupplier SET Supplier_Status = 1, Supplier_StatusTime = GETDATE(), Supplier_Processor = @Operator WHERE Supplier_ID = @SupplierID AND Supplier_Status = 0 AND Supplier_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510023004;
			END
			ELSE
			BEGIN
				-- ��ͬ��˾��ŵĿͻ��Ƿ����
				IF NOT EXISTS(SELECT Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @CompanyID AND Customer_CompanyID = @OwnerCompanyID AND Customer_Invalid = 0)
				BEGIN
					-- ��ӳ����̳ɹ�����ǰ��˾�Զ���Ϊ�����̵Ŀͻ�
					DECLARE @tempResult BIGINT;
					DECLARE @tempCustomerID BIGINT;
					SET @tempResult = 0;
					SET @tempCustomerID = 0;
					
					EXEC sp_prv_my_EditCustomer @Operator, 0, @OwnerCompanyID, 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', @Result = @tempResult OUTPUT, @CustomerID = @tempCustomerID OUTPUT
					IF @tempResult <> 0
					BEGIN
						SET @Result = -510023008;
					END
				END
				
				-- �����Ϣ֪ͨ(9 ͬ���Ϊ������)
				IF @Result = 0
				BEGIN
					EXEC sp_prv_event_AddEvent @Operator, 9, @OwnerCompanyID, 0, 0, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
					IF @tmpResult <> 0 
					BEGIN
						SET @Result = -510023009;
					END
				END
			END
		END
		ELSE IF @Op = 2
		BEGIN
			-- �ܾ�
			UPDATE TMS_MSupplier SET Supplier_Status = 2, Supplier_StatusTime = GETDATE(), Supplier_Processor = @Operator WHERE Supplier_ID = @SupplierID AND Supplier_Status = 0 AND Supplier_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510023005;
			END
			ELSE
			BEGIN
				-- ����¼�֪ͨ(�ܾ���Ϊ��Ӧ��)			
				EXEC sp_prv_event_AddEvent @Operator, 2, @OwnerCompanyID, 1, 0, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510023007;
				END
			END
		END
		ELSE
		BEGIN
			SET @Result = -510023006
		END
	END
END
GO


