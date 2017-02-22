USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_CompanySignCheck]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_CompanySignCheck]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_pub_user_CompanySignCheck]
(
	@phone NVARCHAR(20),
	@mail NVARCHAR(50),
	@companyname NVARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @SupplierID BIGINT;
	SET @Result = 0;
	SET @SupplierID = 0;
	
	
	IF @Result = 0 AND  @phone IS NOT NULL AND @phone <> '' AND  EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_Phone = @phone AND Company_Invalid = 0)
	BEGIN
		SET @Result = -510001005;
	END	


	IF @Result = 0 AND @companyname IS NOT NULL AND @companyname <> '' AND EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_Name = @companyname AND Company_Invalid = 0)
	
	BEGIN
		SET @Result = -510001002;
	END
	
	
	IF @Result = 0 AND  @mail IS NOT NULL AND @mail <> '' AND EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_Mail = @mail AND Company_Invalid = 0)
	BEGIN
		SET @Result = -510001006;
	END	
	
	SELECT @Result AS check_Result
	
	SET NOCOUNT OFF;
END




GO


