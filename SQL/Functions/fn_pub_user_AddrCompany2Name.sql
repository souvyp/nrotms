USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_AddrCompany2Name]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_AddrCompany2Name]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fn_pub_user_AddrCompany2Name]
(
	@Type BIGINT,
	@CustomerID BIGINT
)
RETURNS NVARCHAR(300)
AS
BEGIN
	DECLARE @Name NVARCHAR(300);
	SET @Name = '';
	
	-- 最终用户
	IF @Type = 1
	BEGIN
		SELECT @Name = EndUser_Name FROM TMS_MEndUser WHERE EndUser_ID = @CustomerID AND EndUser_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Name = '';
		END
	END
	
	-- 客户
	IF @Type = 2
	BEGIN
		SELECT @Name = Customer_Name FROM TMS_MCustomer WHERE Customer_ID = @CustomerID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Name = '';
		END
	END
	
	-- 供应商
	IF @Type = 3
	BEGIN
		SELECT @Name = b.Company_Name FROM TMS_MSupplier AS a INNER JOIN TMS_Company AS b ON a.Supplier_CompanyID = b.Company_ID WHERE a.Supplier_ID = @CustomerID AND a.Supplier_Invalid = 0 AND a.Supplier_Status = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Name = '';
		END
	END

	RETURN @Name;
END

GO


