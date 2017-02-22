USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_EODUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_EODUser]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*���û�����˺�*/
CREATE PROCEDURE [dbo].[sp_pub_user_EODUser]
(
	@Operator BIGINT,
	@UserID BIGINT,
	@EOD TINYINT					-- 1 enable 0 disable
)
AS
BEGIN
SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @UserType BIGINT;		-- 256 ��˾����Ա ���� ��ͨ�˺�
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @UserType = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);;

	BEGIN TRANSACTION;
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510051001;
	END
	
	-- ��ǰ�û�û���޸Ĺ�˾���ϵ�Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_RoleID = 256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510051002;
	END
	
	-- �Ƿ������Ա����ͬһ��˾
	IF @Result = 0
	BEGIN
		SELECT @UserType = User_RoleID FROM TMS_User WHERE [User_ID] = @UserID AND User_CompanyID = @CompanyID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510051003;
		END
	END
	
	-- ��˾����Ա�޷�����
	IF @Result = 0 AND @UserType = 256
	BEGIN
		SET @Result = -510051004;
	END

	IF @Result = 0
	BEGIN
		UPDATE TMS_User SET User_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE [User_ID] = @UserID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510051005;
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

	SELECT @Result AS EOD_Result;
	
	SET NOCOUNT OFF;
END
GO


