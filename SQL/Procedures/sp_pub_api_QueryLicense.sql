USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_api_QueryLicense]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_api_QueryLicense]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
@Mode: 1 普通 98 后台管理员
*/
CREATE PROCEDURE [dbo].[sp_pub_api_QueryLicense]
(
	@Account VARCHAR(100),
	@Password VARCHAR(100),
	@AppID NVARCHAR(20),
	@Mode BIGINT = 1
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @RoleID BIGINT;
	DECLARE @UserID BIGINT;
	DECLARE @LicenseID BIGINT;
	SET @Result = 0;
	SET @CompanyID = 0;
	SET @RoleID = 0;
	SET @UserID = 0;
	SET @LicenseID = 0;
	
	IF @Password IS NULL
	BEGIN
		SET @Password = '';
	END
	DECLARE @Pwd VARCHAR(32);
	SET @Pwd = LOWER(replace(sys.fn_varbintohexstr(hashbytes('MD5', @Password)), '0x', ''));

	IF @Mode = 98
	BEGIN
		SELECT @CompanyID = 24, @RoleID = 24, @UserID = Admin_ID FROM TMS_Administrator WHERE Admin_Account = @Account AND Admin_Password = @Pwd AND Admin_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -610004001;
		END
	END
	ELSE
	BEGIN
		SELECT @CompanyID = User_CompanyID, @RoleID = User_RoleID, @UserID = [User_ID] FROM TMS_User WHERE User_Account = @Account AND User_Password = @Pwd AND User_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -610004002;
		END
	END
	
	IF @Result = 0
	BEGIN
		SELECT @LicenseID = License_ID FROM API_License WHERE License_AppID = @AppID AND License_OwnerCompanyID = @CompanyID AND License_Invalid = 0 AND License_Confirmed = 1 AND (License_StartTime IS NULL OR License_StartTime <= GETDATE()) AND (License_EndTime IS NULL OR License_EndTime >= GETDATE());
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -610004003;
		END
	END
	
	SELECT @Result AS API_Result;
	
	IF @Result = 0
	BEGIN
		SELECT License_ID, License_AppID, @UserID AS License_UserID, @RoleID AS License_RoleID, License_HelloToken, License_AesKey, License_ClientUrl, @Mode AS License_Mode FROM API_License WHERE License_ID = @LicenseID;
	END

	SET NOCOUNT OFF;
END
GO


