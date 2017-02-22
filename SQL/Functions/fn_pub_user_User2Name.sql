USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_User2Name]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_User2Name]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_User2Name]
(
	@UserID BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @Name NVARCHAR(100);
	SET @Name = N'';
	
	SELECT @Name = [User_Name] FROM TMS_User WHERE [User_ID] = @UserID;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @Name = N'';
	END

	RETURN @Name;
END
GO


