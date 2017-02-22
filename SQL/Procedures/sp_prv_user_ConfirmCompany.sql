USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_user_ConfirmCompany]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_user_ConfirmCompany]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ��˹�˾�Ǽ���Ϣ
CREATE PROCEDURE [dbo].[sp_prv_user_ConfirmCompany]
(
	@CompanyID BIGINT,
	@Accept TINYINT,			-- 1 ͬ�� 0 �ܾ�
	@Operator BIGINT,
	@AdminAccount VARCHAR(100) = N'',
	@AdminPwd VARCHAR(100) = N'',
	@AdminName NVARCHAR(100) = N'',
	@TxnRequired BIGINT = 0,
	@Result BIGINT OUTPUT,
	@AdminID BIGINT OUTPUT
)
AS
BEGIN
	DECLARE @Pwd VARCHAR(32);
	DECLARE @RoleID BIGINT;
	DECLARE @Phone BIGINT;
	
	SET @Phone = 0;
	SET @Result = 0;
	SET @Pwd = LOWER(replace(sys.fn_varbintohexstr(hashbytes('MD5', @AdminPwd)), '0x', ''));
	SET @RoleID = 256;
	SET @AdminID = 0;
	SELECT @Phone = Company_Phone FROM TMS_Company WHERE Company_ID = @CompanyID AND Company_Personal = 1;
	-- ֻ�й���Ա��Ȩִ�иò���
	IF @Result = 0 AND NOT EXISTS(SELECT [Admin_ID] FROM TMS_Administrator WHERE Admin_ID = @Operator AND Admin_Invalid = 0)
	BEGIN
		SET @Result = -510002000;
	END

	-- û���ҵ���Ӧ��˾��˾�ѱ����
	IF NOT EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = @CompanyID AND Company_Invalid = 0 AND Company_Status = 0)
	BEGIN
		SET @Result = -510002001;
	END
	
	-- ��˹�˾
	IF @Result = 0
	BEGIN
		UPDATE TMS_Company SET Company_Status = (CASE WHEN @Accept = 1 THEN 2 ELSE 0 END), Company_Invalid = (CASE WHEN @Accept = 0 THEN 1 ELSE 0 END), Company_Updater = @Operator, Company_UpdateTime = GETDATE() WHERE Company_ID = @CompanyID AND Company_Invalid = 0 AND Company_Status = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510002002;
		END
	END
	
	-- ����Ա�˺��Ƿ��Ѿ�����
	IF @Result = 0 AND @Accept = 1 AND EXISTS(SELECT User_Account FROM TMS_User WHERE User_Account = @AdminAccount AND User_Invalid = 0 AND User_CompanyID <> @CompanyID)
	BEGIN
		SET @Result = -510002003;
	END
	
	-- ��ӹ���Ա�˺�
	IF @Result = 0 AND @Accept = 1 AND @AdminAccount <> '' AND @AdminAccount IS NOT NULL
	BEGIN
		-- �����û�ȫ������
		UPDATE TMS_User SET User_Invalid = 1 WHERE User_CompanyID = @CompanyID;
		
		-- ��ӹ����˺�
		INSERT INTO TMS_User(User_Account, User_Password, [User_Name], User_CompanyID, User_RoleID, User_Invalid, User_InsertTime) VALUES(@AdminAccount, @Pwd, @AdminName, @CompanyID, @RoleID, 0, GETDATE());
		IF @@ROWCOUNT > 0
		BEGIN
			SET @AdminID = IDENT_CURRENT('TMS_User');
		END
		ELSE
		BEGIN
			SET @Result = -510002004;
		END
		
		-- ��Ӹ���˾���˺�	
		
		IF @Result = 0 AND NOT EXISTS (SELECT Company_Personal FROM TMS_Company WHERE Company_ID = @CompanyID AND Company_Personal = 0)
		BEGIN
			INSERT INTO TMS_User(User_Account, User_Password, [User_Name], User_CompanyID, User_RoleID, User_Invalid, User_InsertTime,User_Type) VALUES(@Phone, @Pwd, @AdminName, @CompanyID, 547, 0, GETDATE(),2);
		
		END	
			
	END
	
	-- ���Լ���ӵ��ͻ������������
	IF @Result = 0 AND @Accept = 1
	BEGIN
		DECLARE @CustomerID BIGINT;
		SET @CustomerID = 0;

		-- �Զ�ѡ��Ĺ�˾��ȡĬ��ֵ
		INSERT INTO TMS_MCustomer(Customer_OwnerCompany, Customer_CompanyID, Customer_ClientCode, 
Customer_Name, Customer_Industry, Customer_Logo, Customer_Web, Customer_ShortName, Customer_EnName, 
Customer_ShortEnName, Customer_Master, Customer_License, Customer_Contact, Customer_Phone, Customer_Fax, 
Customer_Zip, Customer_Address, Customer_Mail, Customer_WeiXin, Customer_Bank, Customer_BankAccount, 
Customer_Description, Customer_Creator, Customer_InsertTime) SELECT @CompanyID, @CompanyID, 
Company_ClientCode, Company_Name, Company_Industry, Company_Logo, Company_Web, Company_ShortName, 
Company_EnName, Company_ShortEnName, Company_Master, Company_License, 
Company_Contact, Company_Phone, Company_Fax, Company_Zip, 
Company_Address, Company_Mail, Company_Weixin, Company_Bank, 
Company_BankAccount, Company_Description, @Operator, GETDATE() FROM TMS_Company WHERE Company_ID = @CompanyID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = 510002005;
		END
		
		INSERT INTO TMS_MSupplier(Supplier_OwnerCompanyID, Supplier_CompanyID, Supplier_ClientCode, Supplier_Welcome, Supplier_Creator, Supplier_InsertTime) SELECT @CompanyID, @CompanyID, 
Company_ClientCode,'��Ӫ' , @Operator, GETDATE()FROM TMS_Company WHERE Company_ID = @CompanyID
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = 510002005;
		END
	END

END
GO


