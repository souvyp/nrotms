USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_SupplierName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_SupplierName]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_SupplierName] 
(
	@SupplierID BIGINT,
	@Orderid BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @SupplierName NVARCHAR(100)
	DECLARE @Status NVARCHAR(100)
	SET @SupplierName = N'';
	DECLARE @SrcClass INT;
	DECLARE @Supplier BIGINT;
	SET @SrcClass = 0;
	SET @Supplier = 0;
	-- 承运商名字 没有委托时 没有名字
	SELECT @SrcClass =Index_SrcClass,@Supplier =Index_SupplierID+Index_SupplierSymbolID,@Status = Index_Status FROM TMS_OrderIndex WHERE Index_ID = @Orderid

	SELECT @SupplierName = b.Company_Name FROM TMS_MSupplier AS a INNER JOIN TMS_Company AS b ON a.Supplier_CompanyID = b.Company_ID WHERE a.Supplier_ID = @SupplierID ;
	IF @@ROWCOUNT = 0
	BEGIN
		IF @SupplierID = 0 AND @Status > 1
		BEGIN
			IF EXISTS (SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderId AND Index_SrcClass <> 1 )			
			BEGIN	
			SET @SupplierName = N'自营';
			END
			ELSE
			BEGIN	
			SET @SupplierName = dbo.fn_pub_user_Company2Name((SELECT Index_CreatorCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderId))
			END			
		END
		ELSE
		BEGIN
			SET @SupplierName = N'';
		END
	END

	RETURN @SupplierName;

END

GO


