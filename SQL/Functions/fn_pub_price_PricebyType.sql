USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_price_PricebyType]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_price_PricebyType]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- 订单指定费用类型查找
CREATE FUNCTION [dbo].[fn_pub_price_PricebyType]
(
	@orderid BIGINT,
	@type INT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE @amount DECIMAL(18,2);
	SET @amount = 0;
	
	SELECT @amount =(CASE WHEN SUM(Cache_Amount) IS NULL THEN 0 ELSE SUM(Cache_Amount) END) FROM Price_OrderCache WHERE Cache_OrderID = @orderid AND Cache_Type = @type AND Cache_Invalid = 0;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @amount = 0;
	END

	RETURN @amount;
END
GO


