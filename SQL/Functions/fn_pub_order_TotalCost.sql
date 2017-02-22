USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_TotalCost]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_TotalCost]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_TotalCost]
(
	@OrderID BIGINT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE @Cost DECIMAL(18,2);
	DECLARE @Min DECIMAL(18,2);
	SET @Cost = 0;
	SET @Min = 0;

	IF @OrderID IS NOT NULL AND @OrderID > 0
	BEGIN
		SELECT @Cost = SUM(CASE WHEN Cache_Type IN (1,2,3,4,5,6,8,9,10) THEN Cache_Amount ELSE 0 END), @Min = SUM(CASE WHEN Cache_Type = 7 THEN Cache_Amount ELSE 0 END) FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Cost = 0;
			SET @Min = 0;
		END
	END
	
	IF @Cost < @Min
	BEGIN
		SET @Cost = @Min;
	END

	RETURN ISNULL(@Cost, 0);
END
GO


