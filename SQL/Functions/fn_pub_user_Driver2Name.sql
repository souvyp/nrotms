USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_Driver2Name]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_Driver2Name]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_Driver2Name]
(
	@DriverID BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @DriverName NVARCHAR(300);
	SET @DriverName = N'';
	
	SELECT @DriverName = [Driver_Name] FROM TMS_MDriver WHERE [Driver_ID] = @DriverID  AND Driver_Invalid = 0;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @DriverName = N'';
	END

	RETURN @DriverName;
END
GO


