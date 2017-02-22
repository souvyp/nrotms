USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_OpenId2User]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_OpenId2User]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_OpenId2User]
(
	@OpenId NVARCHAR(300)
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @UserID BIGINT;
	SET @UserID = N'';
	
	SELECT @UserID = [User_Id] FROM TMS_User WHERE [user_OpenId] = @OpenId;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @UserID = N'';
	END

	RETURN @UserID;
END
GO


