USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_api_RegisterLicense]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_api_RegisterLicense]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_pub_api_RegisterLicense]
(
	@Operator BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @LicenseID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @LicenseID = 0;

	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -610001001;
	END
	
	-- 同一公司不能重复注册
	IF @Result = 0 AND EXISTS(SELECT License_ID FROM API_License WHERE License_OwnerCompanyID = @CompanyID AND License_Invalid = 0)
	BEGIN
		SET @Result = -610001002;
	END
	
	IF @Result = 0
	BEGIN
		INSERT INTO API_License(License_OwnerCompanyID, License_Invalid, License_Creator, License_CreateTime) VALUES(@CompanyID, 0, @Operator, GETDATE());
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -610001003;
		END
		ELSE
		BEGIN
			SET @LicenseID = IDENT_CURRENT('API_License');
		END
	END
	
	IF @Result = 0
	BEGIN
		-- 生成AppID
		DECLARE @AppID VARCHAR(34);
		SET @AppID = sys.fn_varbintohexstr(hashbytes('MD5', CAST(@LicenseID AS VARCHAR)));
		SET @AppID = UPPER(SUBSTRING(@AppID,11,16));
		SET @AppID = 'wly' + @AppID;
	
		-- 生成Token
		DECLARE @Token VARCHAR(34);
		SET @Token = REPLACE(NEWID(), '-', '');
		
		-- 生成AesKey
		DECLARE @AesKey VARCHAR(34);
		SET @AesKey = REPLACE(NEWID(), '-', '');
		
		UPDATE API_License SET License_AppID = @AppID, License_HelloToken = @Token, License_AesKey = @AesKey WHERE License_ID = @LicenseID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -610001004;
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
	
	SELECT @Result AS API_Result, @LicenseID AS License_ID;

	SET NOCOUNT OFF;
END
GO


