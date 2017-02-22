USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_api_VerifyLicense]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_api_VerifyLicense]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_pub_api_VerifyLicense]
(
	@LicenseID BIGINT,
	@ClientUrl NVARCHAR(500)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;

	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -610002001;
	END
	
	IF @Result = 0 AND NOT EXISTS(SELECT License_ID FROM API_License WHERE License_ID = @LicenseID AND License_Confirmed = 1 AND License_Invalid = 0)
	BEGIN
		SET @Result = -610002002;
	END
	
	IF @Result = 0
	BEGIN
		UPDATE API_License SET License_ClientUrl = @ClientUrl WHERE License_ID = @LicenseID ;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -610002003;
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


