USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_ChangePwd]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_ChangePwd]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/*修改密码*/
CREATE PROCEDURE [dbo].[sp_pub_user_ChangePwd]
(
	@Username NVARCHAR(100),
	@OldPwd VARCHAR(100),
	@NewPwd VARCHAR(100)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	SET @Result = 0;

	IF @Username IS NULL OR @Username = N''
	BEGIN
		-- 参数错误
		SET @Result = -510003001;
	END
	
	IF @Result = 0 AND NOT EXISTS(SELECT User_Account FROM TMS_User WHERE User_Account = @Username AND User_Invalid = 0)
	BEGIN
		SET @Result = -510003002;
	END

	IF @Result = 0
	BEGIN
		IF @OldPwd IS NULL
		BEGIN
			SET @OldPwd = '';
		END
		IF @NewPwd IS NULL
		BEGIN
			SET @NewPwd = '';
		END
		DECLARE @OPwd VARCHAR(32);
		DECLARE @NPwd VARCHAR(32);
		SET @OPwd = LOWER(replace(sys.fn_varbintohexstr(hashbytes('MD5', @OldPwd)), '0x', ''));
		SET @NPwd = LOWER(replace(sys.fn_varbintohexstr(hashbytes('MD5', @NewPwd)), '0x', ''));
		
		UPDATE TMS_User SET User_Password = @NPwd WHERE User_Account = @Username AND User_Password = @OPwd AND User_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			-- 用户名与原始密码不匹配
			SET @Result = -510003003;
		END
	END
	
	SELECT @Result AS Pwd_Result;
	
	SET NOCOUNT OFF;
END


GO


