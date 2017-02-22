USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_sa_Login]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_sa_Login]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*ºóÌ¨µÇÂ¼*/
CREATE PROCEDURE [dbo].[sp_pub_sa_Login]
(
	@Username NVARCHAR(100),
	@Password VARCHAR(100)
)
AS
BEGIN
	SET NOCOUNT ON;

	IF @Password IS NULL
	BEGIN
		SET @Password = '';
	END
	DECLARE @Pwd VARCHAR(32);
	SET @Pwd = LOWER(replace(sys.fn_varbintohexstr(hashbytes('MD5', @Password)), '0x', ''));

	SELECT Admin_Account AS [User_Name], Admin_Account AS User_TrueName, Admin_ID AS [User_ID], 
'' AS User_GUID, 0 AS User_RoleID, '' AS User_Permission, '' AS User_Portrait, '' AS User_Language, 0 AS User_FirstSignIn FROM TMS_Administrator 
WHERE Admin_Account = @Username AND Admin_Password = @Pwd AND Admin_Invalid = 0;
	
	SET NOCOUNT OFF;
END

GO


