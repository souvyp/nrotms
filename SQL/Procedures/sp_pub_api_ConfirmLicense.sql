USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_api_ConfirmLicense]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_api_ConfirmLicense]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
@AOR  1 Accept
      0 Reject
*/
CREATE PROCEDURE [dbo].[sp_pub_api_ConfirmLicense]
(
	@Operator BIGINT,
	@LicenseID BIGINT,
	@Description NVARCHAR(500),
	@AOR BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	SET @Result = 0;
	
	BEGIN TRANSACTION;

	-- 只有管理员有权执行该操作
	IF @Result = 0 AND NOT EXISTS(SELECT [Admin_ID] FROM TMS_Administrator WHERE Admin_ID = @Operator AND Admin_Invalid = 0)
	BEGIN
		SET @Result = -610003001;
	END
	
	-- 授权是否存在
	IF @Result = 0 AND NOT EXISTS(SELECT License_ID FROM API_License WHERE License_ID = @LicenseID AND License_Invalid = 0)
	BEGIN
		SET @Result = -610003002;
	END
	
	IF @Result = 0
	BEGIN
		IF @AOR = 1
		BEGIN
			UPDATE API_License SET License_Confirmed = 1, License_Confirmer = @Operator, License_ConfirmTime = GETDATE(), License_ConfirmDesc = @Description WHERE License_ID = @LicenseID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -610003003;
			END
		END
		ELSE
		BEGIN
			UPDATE API_License SET License_Confirmed = 0, License_Invalid = 1, License_Confirmer = @Operator, License_ConfirmTime = GETDATE(), License_ConfirmDesc = @Description WHERE License_ID = @LicenseID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -610003003;
			END
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

	SELECT @Result AS API_Result;
	
	SET NOCOUNT OFF;
END

GO


