USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_my_EditCustomer]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_my_EditCustomer]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*添加或修改客户*/
CREATE PROCEDURE [dbo].[sp_prv_my_EditCustomer]
(
	@Operator BIGINT,
	@ID BIGINT,
	@CustomerCompanyID BIGINT, 
	@TxnRequired TINYINT = 1, 
	@Name NVARCHAR(300) = '', 
	@Industry INT = 0,
	@Logo NVARCHAR(300) = '',
	@Web NVARCHAR(300) = '',
	@ShortName NVARCHAR(100) = '',
	@EnName NVARCHAR(200) = '',
	@ShortEnName NVARCHAR(200) = '',
	@Master NVARCHAR(100) = '',
	@License NVARCHAR(100) = '',
	@Contact NVARCHAR(300) = '',
	@Phone NVARCHAR(100) = '',
	@Fax NVARCHAR(100) = '',
	@Zip NVARCHAR(100) = '',
	@Address NVARCHAR(300) = '',
	@Mail NVARCHAR(200) = '',
	@WeiXin NVARCHAR(100) = '',
	@Bank NVARCHAR(100) = '',
	@BankAccount NVARCHAR(100) = '',
	@Description NVARCHAR(MAX) = '', 
	@Result BIGINT OUTPUT,
	@CustomerID BIGINT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @OwnerCompanyID BIGINT;
	DECLARE @ClientCode NVARCHAR(100);
	SET @Result = 0;
	SET @CustomerID = 0;
	SET @OwnerCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @ClientCode = '';
	
	
	-- 当前用户没有关联公司
	IF @OwnerCompanyID <= 0
	BEGIN
		SET @Result = -510008001;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @OwnerCompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510008002;
	END

	-- 客户公司编号是否有效
	IF @Result = 0 AND @CustomerCompanyID > 0 AND NOT EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = @CustomerCompanyID AND Company_Invalid = 0)
	BEGIN
		SET @Result = -510008003;
	END
	
	-- 手动录入的客户公司名称是否重复
	IF @Result = 0 AND @CustomerCompanyID = 0 AND EXISTS(SELECT Customer_ID FROM TMS_MCustomer WHERE Customer_ID <> @ID AND Customer_OwnerCompany = @OwnerCompanyID AND Customer_Name = @Name AND Customer_Invalid = 0)
	BEGIN
		SET @Result = -510008007;
	END

	-- 自动选择的公司读取默认值
	IF @Result = 0 AND @CustomerCompanyID > 0
	BEGIN
		SELECT @Name = Company_Name, 
@Industry = Company_Industry, @Logo = Company_Logo, @Web = Company_Web, @ShortName = Company_ShortName, 
@EnName = Company_EnName, @ShortEnName = Company_ShortEnName, @Master = Company_Master, @License = Company_License, 
@Contact = Company_Contact, @Phone = Company_Phone, @Fax = Company_Fax, @Zip = Company_Zip, 
@Address = Company_Address, @Mail = Company_Mail, @WeiXin = Company_Weixin, @Bank = Company_Bank, 
@BankAccount = Company_BankAccount, @Description = Company_Description FROM TMS_Company WHERE Company_ID = @CustomerCompanyID;
	END
	
	IF @Result = 0
	BEGIN
		EXEC sp_pub_basic_GetSN 5, @SN = @ClientCode OUTPUT;
		IF @ClientCode = ''
		BEGIN
			-- 序列号生成失败
			SET @Result = -510008004;
		END
	END

    -- 客户公司是否存在(存在编辑, 不存在添加)
    IF @Result = 0
    BEGIN
		SELECT @ID = Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @OwnerCompanyID AND Customer_ID = @ID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			INSERT INTO TMS_MCustomer(Customer_OwnerCompany, Customer_CompanyID, Customer_ClientCode, 
Customer_Name, Customer_Industry, Customer_Logo, Customer_Web, Customer_ShortName, Customer_EnName, 
Customer_ShortEnName, Customer_Master, Customer_License, Customer_Contact, Customer_Phone, Customer_Fax, 
Customer_Zip, Customer_Address, Customer_Mail, Customer_WeiXin, Customer_Bank, Customer_BankAccount, 
Customer_Description, Customer_Creator, Customer_InsertTime) VALUES(@OwnerCompanyID, @CustomerCompanyID, @ClientCode, 
@Name, @Industry, @Logo, @Web, @ShortName, @EnName, 
@ShortEnName, @Master, @License, @Contact, @Phone, @Fax, 
@Zip, @Address, @Mail, @WeiXin, @Bank, @BankAccount, @Description, @Operator, GETDATE());
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510008005;
			END
			ELSE
			BEGIN
				SET @ID = IDENT_CURRENT('TMS_MCustomer');
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_MCustomer SET Customer_Name = @Name, Customer_Industry = @Industry, Customer_Logo = @Logo, 
Customer_Web = @Web, Customer_ShortName = @ShortName, Customer_EnName = @EnName, Customer_ShortEnName = @ShortEnName, 
Customer_Master = @Web, Customer_License = @License, Customer_Contact = @Contact, Customer_Phone = @Phone, 
Customer_Fax = @Fax, Customer_Zip = @Zip, Customer_Address = @Address, Customer_Mail = @Mail, Customer_WeiXin = @WeiXin, 
Customer_Bank = @Bank, Customer_BankAccount = @BankAccount, Customer_Description = @Description,
Customer_Updater = @Operator, Customer_UpdateTime = GETDATE() WHERE Customer_ID = @ID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510008006;
			END
		END
    END

	
	SET @CustomerID = @ID;
	
	SET NOCOUNT OFF;
END
GO


