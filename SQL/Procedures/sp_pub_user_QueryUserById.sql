USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_QueryUserById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_QueryUserById]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_pub_user_QueryUserById]
(
	@UserID BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT [User_ID], User_Account, User_CompanyID, User_RoleID, [User_Name], User_Nickname, User_Portrait, 
User_Language, dbo.fn_pub_user_Gender2Name(User_Gender) AS User_Gender, User_Birthday, User_Phone, User_Dept, 
User_Duty, User_InsertTime, User_Invalid FROM TMS_User WHERE [User_ID] = @UserID AND User_Invalid = 0;
	
	SET NOCOUNT OFF;
END


GO


