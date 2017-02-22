USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_Company2AdminAccount]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_Company2AdminAccount]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_Company2AdminAccount]
(
	@CompanyID BIGINT
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @AdminAccount VARCHAR(100);
	SET @AdminAccount = '';
	
	SELECT @AdminAccount = User_Account FROM TMS_User WHERE User_CompanyID = @CompanyID AND User_RoleID = 256;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @AdminAccount = '';
	END
	
	RETURN @AdminAccount;
END
GO


