USE [OTMS]
GO
/* 绑定微信帐号 */
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_BindDriverWxID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_BindDriverWxID]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_pub_user_BindDriverWxID]
(
	@OpenID VARCHAR(300),
	@Account VARCHAR(300),
	@Password VARCHAR(100)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Pwd VARCHAR(32);
	DECLARE @Result BIGINT;
	SET @Result = 0;
	IF @Password IS NULL
	BEGIN
		SET @Password = '';
	END
	SET @Pwd = LOWER(replace(sys.fn_varbintohexstr(hashbytes('MD5', @Password)), '0x', ''));
	
	BEGIN TRANSACTION;

	-- 只有个体司机用户才可以绑定账号
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE User_Account = @Account AND User_type = 2)
	BEGIN
		SET @Result = -510061001;
	END
	
	-- 帐号没有被绑定过
	IF @Result = 0 AND EXISTS(SELECT User_OpenId FROM TMS_User WHERE User_Account = @Account AND User_OpenId <> '' AND User_OpenId IS NOT NULL)
	BEGIN
		SET @Result = -510061002;
	END
	
	-- 验证账号密码
	IF @Result = 0 AND NOT EXISTS(SELECT User_Account  FROM TMS_User WHERE User_Account = @Account AND User_Password = @Pwd AND User_Invalid = 0 AND EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = User_CompanyID AND Company_Invalid = 0))
	BEGIN
		SET @Result = -510061003;
	END	
	
	
	IF @Result = 0
	BEGIN
		UPDATE TMS_User SET User_OpenId = @OpenID WHERE User_Account = @Account
	END
	
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS Bind_Result;
	
	SET NOCOUNT OFF;
END

GO


