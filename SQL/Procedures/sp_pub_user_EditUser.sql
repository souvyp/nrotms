USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_EditUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_EditUser]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*添加或修改各子系统账号*/
CREATE PROCEDURE [dbo].[sp_pub_user_EditUser]
(
	@Operator BIGINT,
	@UserID BIGINT,
	@RoleID BIGINT,
	@Name NVARCHAR(100),
	@Gender TINYINT,
	@Birthday NVARCHAR(50),
	@Phone NVARCHAR(100),
	@Dept NVARCHAR(100),
	@Duty NVARCHAR(100),
	@Photo NVARCHAR(255),
	@Nickname NVARCHAR(100)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @Pwd VARCHAR(40);
	SET @Result = 0;
	SET @CompanyID = 0;

	BEGIN TRANSACTION;
	
	-- 不能设置公司管理员
	IF @Result = 0 AND (@RoleID & 256) = 256
	BEGIN
		SET @Result = -510041001;
	END

	-- 角色为必填项	
	IF @Result = 0 AND (@RoleID IS NULL OR @RoleID = 0)
	BEGIN
		SET @Result = -510041005;
	END

	-- 只有公司管理员才能修改用户
	IF @Result = 0
	BEGIN
		SELECT @CompanyID = User_CompanyID FROM TMS_User WHERE [User_ID] = @Operator AND User_RoleID = 256 AND User_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510041002;
		END
	END
	
	-- 用户是否已经存在
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @UserID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510041003;
	END
	
	IF @Result = 0
	BEGIN
		UPDATE TMS_User SET User_RoleID = @RoleID, [User_Name] = @Name, User_Portrait = @Photo, 
User_Language = 'CHS', User_Gender = @Gender, User_Birthday = @Birthday, User_Phone = @Phone, User_Dept = @Dept, 
User_Duty = @Duty, User_UpdateTime = GETDATE(), User_Invalid = 0, User_Nickname = @Nickname WHERE [USER_ID] = @UserID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510041004;
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
	
	SELECT @Result AS User_Result;
	
	SET NOCOUNT OFF;
END
GO


