USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_User2RoleID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_User2RoleID]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_User2RoleID]
(
	@Operator BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT;
	SET @Result = 0;
	
	SELECT @Result = User_RoleID FROM TMS_User WHERE [User_ID] = @Operator AND User_Invalid = 0;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @Result = 0;
	END

	RETURN @Result;
END
GO


