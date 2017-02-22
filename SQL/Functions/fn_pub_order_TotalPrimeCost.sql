USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_TotalPrimeCost]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_TotalPrimeCost]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_TotalPrimeCost]
(
	@OrderID BIGINT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE @Cost DECIMAL(18,2);
	SET @Cost = 0;

	IF @OrderID IS NOT NULL AND @OrderID > 0
	BEGIN
		SELECT @Cost = SUM(dbo.fn_pub_order_TotalCost( Index_ID )) FROM TMS_OrderIndex WHERE Index_SrcOrderID = @OrderID AND Index_SrcClass = 2 AND 
Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Cost = 0;
		END
	END

	RETURN ISNULL(@Cost, 0);
END
GO


