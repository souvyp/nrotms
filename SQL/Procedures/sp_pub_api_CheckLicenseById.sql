USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_api_CheckLicenseById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_api_CheckLicenseById]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_pub_api_CheckLicenseById]
(
	@LicenseID BIGINT,
	@AppID NVARCHAR(20)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	SET @Result = 0;

	IF NOT EXISTS(SELECT License_ID FROM API_License WHERE License_ID = @LicenseID AND License_AppID = @AppID AND License_Invalid = 0 AND License_Confirmed = 1 AND (License_StartTime IS NULL OR License_StartTime <= GETDATE()) AND (License_EndTime IS NULL OR License_EndTime >= GETDATE()))
	BEGIN	
		SET @Result = -610005001;
	END
	
	SELECT @Result AS API_Result;

	SET NOCOUNT OFF;
END
GO


