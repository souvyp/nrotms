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

/*启用或禁用账号*/
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
	DECLARE @UserType BIGINT;		-- 256 公司管理员 其他 普通账号
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @UserType = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);;

	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510051001;
	END
	
	-- 当前用户没有修改公司资料的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_RoleID = 256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510051002;
	END
	
	-- 是否与管理员属于同一公司
	IF @Result = 0
	BEGIN
		SELECT @UserType = User_RoleID FROM TMS_User WHERE [User_ID] = @UserID AND User_CompanyID = @CompanyID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510051003;
		END
	END
	
	-- 公司管理员无法禁用
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


