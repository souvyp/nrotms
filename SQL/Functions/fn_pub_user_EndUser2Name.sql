USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_EndUser2Name]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_EndUser2Name]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_EndUser2Name]
(
	@EndUserID BIGINT
)
RETURNS NVARCHAR(300)
AS
BEGIN
	DECLARE @Name NVARCHAR(300);
	SET @Name = N'';
	
	SELECT @Name = EndUser_Name FROM TMS_MEndUser WHERE EndUser_ID = @EndUserID;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @Name = N'';
	END

	RETURN @Name;
END
GO


