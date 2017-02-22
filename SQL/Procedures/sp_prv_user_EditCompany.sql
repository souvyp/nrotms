USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_user_EditCompany]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_user_EditCompany]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*修改公司信息*/
CREATE PROCEDURE [dbo].[sp_prv_user_EditCompany]
(
	@Operator BIGINT,
	@CompanyID BIGINT,
	@Name NVARCHAR(250),
	@Industry INT,
	@Logo NVARCHAR(300),
	@Web NVARCHAR(300),
	@ShortName NVARCHAR(100),
	@EnName NVARCHAR(200),
	@ShortEnName NVARCHAR(200),
	@Master NVARCHAR(100),
	@License NVARCHAR(100),
	@Contact NVARCHAR(300),
	@Phone NVARCHAR(100),
	@Fax NVARCHAR(100),
	@Zip NVARCHAR(100),
	@Address NVARCHAR(300),
	@Mail NVARCHAR(200),
	@WeiXin NVARCHAR(100),
	@Bank NVARCHAR(100),
	@BankAccount NVARCHAR(100),
	@Description NVARCHAR(MAX),
	@LicensePic NVARCHAR(300) = N'',
	@IsGroup BIGINT = 0,
	@IsZone BIGINT = 0,
	@TxnRequired BIGINT = 0,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	-- DECLARE @OperatorCompanyID BIGINT;
	SET @Result = 0;
	-- SET @OperatorCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);

	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510006001;
	END
	/**
	IF @OperatorCompanyID <= 0 
	BEGIN
		SET @Result = -510006002;
	END
	**/

	
	-- 当前用户没有修改公司资料的权限
	IF @Operator > 1 AND @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0 AND (User_RoleID = 256 OR User_RoleID = 547) ) 
	BEGIN
		SET @Result = -510006003;
	END
	
	IF @Result = 0
	BEGIN
		UPDATE TMS_Company SET Company_Industry = (CASE WHEN @Industry IS NULL THEN Company_Industry ELSE @Industry END), Company_Logo =(CASE WHEN @Logo IS NULL THEN Company_Logo ELSE @Logo END), Company_Web = (CASE WHEN @Web IS NULL THEN Company_Web ELSE @Web END), Company_ShortName = (CASE WHEN @ShortName IS NULL THEN Company_ShortName ELSE @ShortName END) , Company_EnName = (CASE WHEN @EnName IS NULL THEN Company_EnName ELSE @EnName END), Company_ShortEnName = (CASE WHEN @ShortEnName IS NULL THEN Company_ShortEnName ELSE @ShortEnName END), Company_Master = (CASE WHEN @Master IS NULL THEN Company_Master ELSE @Master END), Company_License = (CASE WHEN @License IS NULL THEN Company_License ELSE @License END), Company_LicensePic = (CASE WHEN @LicensePic IS NULL THEN Company_LicensePic ELSE @LicensePic END), Company_Contact = (CASE WHEN @Contact IS NULL THEN Company_Contact ELSE @Contact END), Company_Phone = (CASE WHEN @Phone IS NULL THEN Company_Phone ELSE @Phone END), Company_Fax = (CASE WHEN @Fax IS NULL THEN Company_Fax ELSE @Fax END), Company_Zip = (CASE WHEN @Zip IS NULL THEN Company_Zip ELSE @Zip END), Company_Address = (CASE WHEN @Address IS NULL THEN Company_Address ELSE @Address END),Company_Mail = (CASE WHEN @Mail IS NULL THEN Company_Mail ELSE @Mail END), Company_Weixin = (CASE WHEN @WeiXin IS NULL THEN Company_Weixin ELSE @WeiXin END), Company_Bank = (CASE WHEN @Bank IS NULL THEN Company_Bank ELSE @Bank END), Company_BankAccount = (CASE WHEN @BankAccount IS NULL THEN Company_BankAccount ELSE @BankAccount END), Company_Description = (CASE WHEN @Description IS NULL THEN Company_Description ELSE @Description END), Company_IsGroup = (CASE WHEN @IsGroup IS NULL THEN Company_IsGroup ELSE @IsGroup END), Company_Updater = @Operator,Company_UpdateTime = GETDATE() ,Company_IsZones = (CASE WHEN @IsZone IS NULL THEN Company_IsZones ELSE @IsZone END), Company_Name = (CASE WHEN @Name IS NULL THEN Company_Name ELSE @Name END)  WHERE Company_ID = @CompanyID;	
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510006004;
		END
		-- 管理员修改公司名字时 修改客户信息
		IF @Name IS NOT NULL
		BEGIN
		UPDATE TMS_MCustomer SET  Customer_Name = @Name FROM TMS_MCustomer INNER JOIN TMS_Company ON  Customer_ClientCode = Company_ClientCode WHERE Company_ID=@CompanyID;
		END
	END
END

GO


