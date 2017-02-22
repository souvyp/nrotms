USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_CompanyCode2Name]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_CompanyCode2Name]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_CompanyCode2Name]
(
	@ClientCode NVARCHAR(100)
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @Name NVARCHAR(300);
	SET @Name = N'';
	
	SELECT TOP 1 @Name = [Company_Name] FROM TMS_Company WHERE [Company_ClientCode] = @ClientCode AND Company_Status > 0 ORDER BY Company_InsertTime DESC;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @Name = N'';
	END

	RETURN @Name;
END
GO


