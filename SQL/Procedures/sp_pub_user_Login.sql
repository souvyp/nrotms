USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_Login]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_Login]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
@Host的可能值:
   www.wlyuan.com.cn/otms.zld.com.cn
   group.wlyuan.com.cn/group.zld.com.cn
   park.wlyuan.com.cn/park.zld.com.cn
   beta.wlyuan.com.cn/wotms.zld.com.cn
   driver.zld.com.cn
*/
CREATE PROCEDURE [dbo].[sp_pub_user_Login]
(
	@Username NVARCHAR(100),
	@Password VARCHAR(100),
	@Host VARCHAR(100) = 'www.wlyuan.com.cn'
)
AS
BEGIN
	SET NOCOUNT ON;
    
    DECLARE @Result TINYINT;
    DECLARE @Pwd VARCHAR(32);
    DECLARE @CompanyID BIGINT;
    DECLARE @UserID BIGINT;
    DECLARE @RoleID BIGINT;
    DECLARE @IsGroup BIGINT;
    DECLARE @IsZone BIGINT;
    DECLARE @Type BIGINT;
	SET @Result=0;
	IF @Password IS NULL
	BEGIN
		SET @Password = '';
	END
	SET @Pwd = LOWER(replace(sys.fn_varbintohexstr(hashbytes('MD5', @Password)), '0x', ''));
	SELECT @UserID = [User_ID], @RoleID = User_RoleID FROM TMS_User WHERE User_Account = @Username;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID( @UserID, 0);
	SELECT @IsGroup = Company_IsGroup, @IsZone = Company_IsZones FROM TMS_Company WHERE Company_ID = @CompanyID;
	SELECT @Type = User_Type FROM TMS_User WHERE User_Account = @Username;	

	-- 检查调用者(某个网站)与当前账号角色是否匹配
    SELECT @Result=(CASE 
WHEN @Host IN( 'park.wlyuan.com.cn', 'park.zld.com.cn') AND @IsZone = 1 AND @RoleID & 128 = 128 AND @Type = 1 THEN 1 
WHEN @Host IN ('group.wlyuan.com.cn', 'group.zld.com.cn') AND @IsGroup = 1 AND @RoleID & 128 = 128 AND @Type = 1 THEN 1 
WHEN @Host IN ('beta.wlyuan.com.cn', 'wotms.zld.com.cn') AND (@RoleID & 1 = 1 OR @RoleID & 2 = 2 OR @RoleID & 32 = 32 OR @RoleID & 512 = 512) AND @Type = 1 THEN 1
WHEN @Host IN ('driver.zld.com.cn') AND @Type = 2 THEN 1 
WHEN @Host IN ('www.wlyuan.com.cn','otms.zld.com.cn','otms.techns.com.cn') AND @Type = 1 THEN 1 ELSE 0 END);
    
    IF @Result =1 
    BEGIN
		SELECT User_Account AS [User_Name], (CASE WHEN [User_Name] IS NULL OR [User_Name] = '' THEN [User_Account] ELSE [User_Name] END) AS User_TrueName, [User_ID], 
'' AS User_GUID, User_RoleID, '' AS User_Permission, User_Portrait, User_Language,(CASE WHEN User_SignInTime IS NULL THEN 1 ELSE 0 END) AS User_FirstSignIn FROM TMS_User WHERE 
User_Account = @Username AND User_Password = @Pwd AND User_Invalid = 0 AND EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = User_CompanyID AND Company_Invalid = 0);
		IF @@ROWCOUNT > 0
		BEGIN
			UPDATE TMS_User SET User_SignInTime = GETDATE() WHERE User_Account = @Username AND User_Password = @Pwd AND User_Invalid = 0;
		END
	END

	SET NOCOUNT OFF;
END

GO


