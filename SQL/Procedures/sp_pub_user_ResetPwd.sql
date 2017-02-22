USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_ResetPwd]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_ResetPwd]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*��������*/
CREATE PROCEDURE [dbo].[sp_pub_user_ResetPwd]
(
	@Operator BIGINT,		-- ϵͳ����Ա���ù�˾���������,��˾����Ա���������˺ŵ�����
	@Username NVARCHAR(100),
	@Pwd VARCHAR(100)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @UserType BIGINT;		-- 256 ��˾����Ա ���� ��ͨ�˺�
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @UserType = 0;
	SET @CompanyID = 0;

	IF @Username IS NULL OR @Username = N''
	BEGIN
		-- ��������
		SET @Result = -510004001;
	END
	
	IF @Result = 0
	BEGIN
		SELECT @UserType = User_RoleID, @CompanyID = User_CompanyID FROM TMS_User WHERE User_Account = @Username AND User_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510004002;
		END
	END
	
	IF @Result = 0
	BEGIN
		IF @UserType = 256
		BEGIN
			-- ֻ��ϵͳ����Ա�����ù�˾����Ա������
			IF NOT EXISTS(SELECT Admin_ID FROM TMS_Administrator WHERE Admin_ID = @Operator AND Admin_Invalid = 0)
			BEGIN
				SET @Result = -510004003;
			END
		END
		ELSE
		BEGIN
			-- ��˾����Ա�����������û�������
			IF NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_RoleID = 256 AND User_Invalid = 0)
			BEGIN
				SET @Result = -510004004;
			END
		END
	END

	IF @Result = 0
	BEGIN
		IF @Pwd IS NULL
		BEGIN
			SET @Pwd = '';
		END
		SET @Pwd = LOWER(replace(sys.fn_varbintohexstr(hashbytes('MD5', @Pwd)), '0x', ''));
		
		UPDATE TMS_User SET User_Password = @Pwd WHERE User_Account = @Username AND User_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510004005;
		END
	END
	
	SELECT @Result AS Pwd_Result;
	
	SET NOCOUNT OFF;
END

GO


