USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_Gender2Name]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_Gender2Name]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_Gender2Name]
(
	@Gender TINYINT
)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @Result NVARCHAR(50);
	SET @Result = '';
	
	IF @Gender = 0
	BEGIN
		SET @Result = N'ÄÐ';
	END
	IF @Gender = 1
	BEGIN
		SET @Result = N'Å®';
	END

	RETURN @Result;
END
GO


