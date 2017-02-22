USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_User2CompanyID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_User2CompanyID]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE FUNCTION [dbo].[fn_pub_user_User2CompanyID]
(
	@UserID BIGINT,
	@RoleID BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @CompanyID BIGINT;
	SET @CompanyID = 0;
	
	SELECT @CompanyID = User_CompanyID FROM TMS_User WHERE [User_ID] = @UserID AND (CASE WHEN @RoleID = 0 THEN 1 WHEN User_RoleID = @RoleID THEN 1 WHEN User_RoleID & @RoleID = @RoleID THEN 1 ELSE 0 END) = 1;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @CompanyID = 0;
	END
	ELSE
	BEGIN
		SELECT @CompanyID = Company_ID FROM TMS_Company WHERE Company_ID = @CompanyID AND (Company_Status = 1 OR Company_Status = 2);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @CompanyID = 0;
		END
	END
	
	IF @CompanyID < 0
	BEGIN
		SET @CompanyID = 0;
	END
	
	RETURN @CompanyID;
END



GO


