USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_user_CompanySign]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_user_CompanySign]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 公司登记
CREATE PROCEDURE [dbo].[sp_prv_user_CompanySign]
(
	@Name NVARCHAR(300),
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
	@ReferCompanyID BIGINT = 0,			-- 推荐公司
	@TxnRequired BIGINT = 0,
	@IsPersonal tinyint = 0,
	@Result BIGINT OUTPUT,
	@CompanyID BIGINT OUTPUT,
	@ClientCode NVARCHAR(100) OUTPUT
)
AS
BEGIN
	SET @Result = 0;
	SET @ClientCode = N'';
	SET @CompanyID = 0;
	
	EXEC sp_pub_basic_GetSN 1, @SN = @ClientCode OUTPUT;
	IF @ClientCode = ''
	BEGIN
		-- 序列号生成失败
		SET @Result = -510001001;
	END

	-- 判断公司名是否重复
	IF @Result = 0 AND EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_Name = @Name AND Company_Invalid = 0)
	BEGIN
		SET @Result = -510001002;
	END
	
	-- 判断参数是否有效
	IF @Result = 0 AND (@Name IS NULL OR @Name = '' OR @Contact IS NULL OR @Contact = '' OR @Phone IS NULL OR @Phone = '')
	BEGIN
		SET @Result = -510001004;
	END
	
	-- 推荐公司是否存在
	IF @Result = 0 AND NOT EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = @ReferCompanyID AND Company_Invalid = 0)
	BEGIN
		SET @CompanyID = 0;
	END

	IF @Result = 0
	BEGIN
		INSERT INTO TMS_Company(Company_ClientCode, Company_Personal, Company_Name, Company_Industry, Company_Logo, Company_Web, 
Company_ShortName, Company_EnName, Company_ShortEnName, Company_Master, Company_License, Company_Contact, 
Company_Phone, Company_Fax, Company_Zip, Company_Address, Company_Mail, Company_Weixin, Company_Bank, 
Company_BankAccount, Company_Description, Company_RefereCompany, Company_InsertTime, Company_CreatorID) VALUES(
@ClientCode,@IsPersonal, @Name, @Industry, @Logo, @Web, @ShortName, @EnName, @ShortEnName, @Master, @License, @Contact, 
@Phone, @Fax, @Zip, @Address, @Mail, @WeiXin, @Bank, @BankAccount, @Description, @ReferCompanyID, GETDATE(), 1);
		IF @@ROWCOUNT > 0 
		BEGIN
			SET @CompanyID = IDENT_CURRENT('TMS_Company');
		END
		ELSE
		BEGIN
			SET @Result = -510001003;
		END
	END

END
GO


