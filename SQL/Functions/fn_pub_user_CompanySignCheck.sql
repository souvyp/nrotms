USE [OTMS]
GO
-- 验证邮箱 电话 公司是否重复
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_CompanySignCheck]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_CompanySignCheck]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_pub_user_CompanySignCheck]
(
	@phone NVARCHAR(20),
	@mail NVARCHAR(50),
	@companyname NVARCHAR(50)
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT;
	SET @Result = 0;
	
	IF @Result = 0 AND  @phone IS NOT NULL AND EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_Phone = @phone AND Company_Invalid = 0)
	BEGIN
		SET @Result = -510001005;
	END	


	IF @Result = 0 AND @companyname IS NOT NULL AND EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_Name = @companyname AND Company_Invalid = 0)
	
	BEGIN
		SET @Result = -510001002;
	END
	
	
	IF @Result = 0 AND  @mail IS NOT NULL AND EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_Mail = @mail AND Company_Invalid = 0)
	BEGIN
		SET @Result = -510001006;
	END	
			
	

	RETURN @Result;
END

GO


