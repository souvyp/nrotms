USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_UserList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_UserList]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/*用户列表*/
CREATE PROCEDURE [dbo].[sp_pub_user_UserList]
(
	@Operator BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510007001;
	END
	
	-- 当前用户没有罗列公司用户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_RoleID = 256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510007002;
	END
	
	SELECT @Result AS User_Result;

	IF @Result = 0
	BEGIN
		SELECT [User_ID], User_Account, User_CompanyID, User_RoleID, [User_Name], User_Nickname, User_Portrait, User_Language, 
dbo.fn_pub_user_Gender2Name(User_Gender) AS User_Gender, User_Birthday, User_Phone, User_Dept, User_Duty, User_InsertTime, User_Invalid FROM TMS_User WHERE User_CompanyID = @CompanyID AND User_Invalid = 0;
	END
	
	SET NOCOUNT OFF;
END



GO


