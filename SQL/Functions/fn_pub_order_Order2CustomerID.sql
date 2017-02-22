USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_Order2CustomerID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_Order2CustomerID]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_Order2CustomerID]
(
	@OrderID BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT;
	DECLARE @CreatorCompanyID BIGINT;
	SET @Result = 0;
	SET @CreatorCompanyID = 0;
	
	
	SELECT @CreatorCompanyID = Index_CreatorCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SupplierSymbolID > 0 AND Index_Invalid = 0;
	IF @@ROWCOUNT > 0
	BEGIN
		SELECT @Result = Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @CreatorCompanyID AND Customer_CompanyID = @CreatorCompanyID AND Customer_Invalid = 0;
	END
	ELSE
	BEGIN
		SELECT @Result = Index_CustomerID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0;
	END

	RETURN @Result;
END
GO


