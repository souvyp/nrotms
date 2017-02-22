USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_RegisterUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_RegisterUser]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*注册物流公司*/
CREATE PROCEDURE [dbo].[sp_pub_user_RegisterUser]
(
	@Operator BIGINT,
	@Acccount VARCHAR(100),
	@Password VARCHAR(100),
	@RoleID BIGINT,
	@Name NVARCHAR(100),
	@Gender TINYINT,
	@Birthday NVARCHAR(50),
	@Phone NVARCHAR(100),
	@Dept NVARCHAR(100),
	@Duty NVARCHAR(100),
	@Photo NVARCHAR(255),
	@Nickname NVARCHAR(100),
	@UserType TINYINT = 1
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @UserID BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @Pwd VARCHAR(40);
	SET @Result = 0;
	SET @UserID = 0;
	SET @CompanyID = 0;
	IF @Password IS NULL
	BEGIN
		SET @Password = '';
	END
	SET @Pwd = LOWER(replace(sys.fn_varbintohexstr(hashbytes('MD5', @Password)), '0x', ''));

	BEGIN TRANSACTION;
	
	-- 不能添加公司管理员
	IF @Result = 0 AND (@RoleID & 256) = 256
	BEGIN
		SET @Result = -510005001;
	END

	-- 角色为必填项	
	IF @Result = 0 AND (@RoleID IS NULL OR @RoleID = 0)
	BEGIN
		SET @Result = -510005005;
	END

	-- 只有公司管理员才能添加用户
	IF @Result = 0
	BEGIN
		SELECT @CompanyID = User_CompanyID FROM TMS_User WHERE [User_ID] = @Operator AND User_RoleID = 256 AND User_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510005002;
		END
	END
	
	-- 用户是否已经存在
	IF @Result = 0 AND EXISTS(SELECT [User_ID] FROM TMS_User WHERE User_Account = @Acccount AND User_Invalid = 0)
	BEGIN
		SET @Result = -510005003;
	END
	
	-- 不是微信个人用户公司
	IF @Result = 0 AND @RoleID = 547 AND NOT EXISTS (SELECT Company_ID FROM TMS_Company WHERE Company_ID = @CompanyID AND Company_Personal = 1)
	BEGIN
		SET @Result = -510005006;
	END	
	
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_User(User_Account, User_Password, User_CompanyID, User_RoleID, [User_Name], User_Portrait, 
User_Language, User_Gender, User_Birthday, User_Phone, User_Dept, User_Duty, User_InsertTime, User_Invalid, 
User_Nickname, User_Type) VALUES(@Acccount, @Pwd, @CompanyID, @RoleID, @Name, @Photo, 'CHS', @Gender, @Birthday, @Phone, @Dept, @Duty,
GETDATE(), 0, @Nickname, @UserType);
		IF @@ROWCOUNT > 0
		BEGIN
			SET @UserID = IDENT_CURRENT('TMS_User');
		END
		ELSE
		BEGIN
			SET @Result = -510005004;
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


