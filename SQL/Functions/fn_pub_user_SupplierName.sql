USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_SupplierName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_SupplierName]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_SupplierName] 
(
	@SupplierID BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @SupplierName NVARCHAR(100)
	SET @SupplierName = N'';

	SELECT @SupplierName = b.Company_Name FROM TMS_MSupplier AS a INNER JOIN TMS_Company AS b ON a.Supplier_CompanyID = b.Company_ID WHERE a.Supplier_ID = @SupplierID ;
	IF @@ROWCOUNT = 0
	BEGIN
		IF @SupplierID = 0
		BEGIN
			SET @SupplierName = N'втс╙';
		END
		ELSE
		BEGIN
			SET @SupplierName = N'';
		END
	END

	RETURN @SupplierName;

END

GO


