USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_my_EditEndUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_my_EditEndUser]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
前端自动追加模式：
创建订单时允许手写收货人，订单提交时该收货人将自动添加到订单指定客户的名下
*/
CREATE PROCEDURE [dbo].[sp_pub_my_EditEndUser]
(
	@Operator BIGINT,
	@EndUserID BIGINT,
	@EndUserCompanyID BIGINT = 0,
	@Name NVARCHAR(300),
	@Industry BIGINT,
	@Web NVARCHAR(300),
	@ShortName NVARCHAR(100),
	@EnName NVARCHAR(200),
	@ShortEnName NVARCHAR(50),
	@Master NVARCHAR(100),
	@License NVARCHAR(100),
	@Contact NVARCHAR(300),
	@Phone NVARCHAR(100),
	@Fax NVARCHAR(100),
	@Mail NVARCHAR(200),
	@Address NVARCHAR(300),
	@Zip NVARCHAR(100),
	@WeiXin NVARCHAR(100),
	@Logo NVARCHAR(300),
	@Bank NVARCHAR(100),
	@BankAccount NVARCHAR(100),
	@Description NVARCHAR(MAX),
	@CustomerID BIGINT = 0,
	@AutoAppend TINYINT = 0					-- 前端自动追加模式
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @ClientCode VARCHAR(100);
	DECLARE @OwnerCompanyID BIGINT;
	DECLARE @CustomerCompanyID BIGINT;
	SET @Result = 0;
	SET @OwnerCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @ClientCode = '';
	SET @CustomerCompanyID = 0;
	IF @AutoAppend IS NULL
	BEGIN
		SET @AutoAppend = 0;
	END
	-- 编辑时不允许使用自动追加模式
	IF @EndUserID > 0 AND @AutoAppend = 1
	BEGIN
		SET @AutoAppend = 0;
	END
	
	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @OwnerCompanyID <= 0
	BEGIN
		SET @Result = -510021001;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @OwnerCompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510021002;
	END

	-- 收件人公司编号是否有效
	IF @Result = 0 AND @EndUserCompanyID > 0 AND NOT EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = @EndUserCompanyID AND Company_Invalid = 0)
	BEGIN
		SET @Result = -510021003;
	END

	-- 客户是否存在
	IF @Result = 0
	BEGIN
		SELECT @CustomerCompanyID = Customer_CompanyID FROM TMS_MCustomer WHERE Customer_ID = @CustomerID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510021007;
		END
		
		IF @CustomerCompanyID IS NULL
		BEGIN
			SET @CustomerCompanyID = 0;
		END
	END
	
	-- 收件人姓名(也可以填写公司名)是否重复
	IF @Result = 0 AND @EndUserCompanyID = 0
	BEGIN
		DECLARE @tEndUserID BIGINT;
		SET @tEndUserID = 0;

		-- 不同客户的收件人姓名可以重复
		SELECT @tEndUserID = EndUser_ID FROM TMS_MEndUser WHERE EndUser_ID <> @EndUserID AND EndUser_OwnerCompany = @OwnerCompanyID AND EndUser_Name = @Name AND EndUser_Invalid = 0 AND (@CustomerCompanyID = 0 OR EndUser_CustomerCompanyID = @CustomerCompanyID);
		IF @@ROWCOUNT > 0
		BEGIN
			IF @AutoAppend = 1
			BEGIN
				-- 自动追加模式下，如果收件人已经存在，直接返回该收件人的编号
				SET @EndUserID = @tEndUserID;
				
				GOTO PROC_RESULT;
			END
			ELSE
			BEGIN
				SET @Result = -510021008;
			END
		END
	END

	-- 手动录入的公司生成编号
	IF @EndUserCompanyID = 0
	BEGIN
		EXEC sp_pub_basic_GetSN 7, @SN = @ClientCode OUTPUT;
		IF @ClientCode = ''
		BEGIN
			-- 序列号生成失败
			SET @Result = -510021004;
		END
	END
	ELSE
	BEGIN
		-- 自动选择的公司读取默认值
		SELECT @ClientCode = Company_ClientCode, @Name = Company_Name, 
@Industry = Company_Industry, @Logo = Company_Logo, @Web = Company_Web, @ShortName = Company_ShortName, 
@EnName = Company_EnName, @ShortEnName = Company_ShortEnName, @Master = Company_Master, @License = Company_License, 
@Contact = Company_Contact, @Phone = Company_Phone, @Fax = Company_Fax, @Zip = Company_Zip, 
@Address = Company_Address, @Mail = Company_Mail, @WeiXin = Company_Weixin, @Bank = Company_Bank, 
@BankAccount = Company_BankAccount, @Description = Company_Description FROM TMS_Company WHERE Company_ID = @EndUserCompanyID;
	END

	-- 收件人是否存在(存在编辑, 不存在添加)
    IF @Result = 0
    BEGIN
		SELECT @EndUserID = EndUser_ID FROM TMS_MEndUser WHERE EndUser_OwnerCompany = @OwnerCompanyID AND EndUser_ID = @EndUserID AND EndUser_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			INSERT INTO TMS_MEndUser(EndUser_OwnerCompany, EndUser_CompanyID, EndUser_ClientCode, 
EndUser_Name, EndUser_Industry, EndUser_Logo, EndUser_Web, EndUser_ShortName, EndUser_EnName, 
EndUser_ShortEnName, EndUser_Master, EndUser_License, EndUser_Contact, EndUser_Phone, EndUser_Fax, 
EndUser_Zip, EndUser_Address, EndUser_Mail, EndUser_WeiXin, EndUser_Bank, EndUser_BankAccount, 
EndUser_Description, EndUser_Creator, EndUser_InsertTime, EndUser_CustomerID, EndUser_CustomerCompanyID) VALUES(@OwnerCompanyID, @EndUserCompanyID, @ClientCode, 
@Name, @Industry, @Logo, @Web, @ShortName, @EnName, @ShortEnName, @Master, @License, @Contact, @Phone, @Fax, 
@Zip, @Address, @Mail, @WeiXin, @Bank, @BankAccount, @Description, @Operator, GETDATE(), @CustomerID, @CustomerCompanyID);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510021005;
			END
			ELSE
			BEGIN
				SET @EndUserID = IDENT_CURRENT('TMS_MEndUser');
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_MEndUser SET EndUser_Name = @Name, EndUser_Industry = @Industry, EndUser_Logo = @Logo, 
EndUser_Web = @Web, EndUser_ShortName = @ShortName, EndUser_EnName = @EnName, EndUser_ShortEnName = @ShortEnName, 
EndUser_Master = @Master, EndUser_License = @License, EndUser_Contact = @Contact, EndUser_Phone = @Phone, 
EndUser_Fax = @Fax, EndUser_Zip = @Zip, EndUser_Address = @Address, EndUser_Mail = @Mail, EndUser_WeiXin = @WeiXin, 
EndUser_Bank = @Bank, EndUser_BankAccount = @BankAccount, EndUser_Description = @Description,
EndUser_Updater = @Operator, EndUser_UpdateTime = GETDATE(), EndUser_CustomerID = @CustomerID, 
EndUser_CustomerCompanyID = @CustomerCompanyID WHERE EndUser_ID = @EndUserID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510021006;
			END
		END
    END

PROC_RESULT:
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS EndUser_Result, @EndUserID AS EndUser_ID;

	SET NOCOUNT OFF;
END

GO


