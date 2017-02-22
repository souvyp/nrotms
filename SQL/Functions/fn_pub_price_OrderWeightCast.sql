USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_price_OrderWeightCast]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_price_OrderWeightCast]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_price_OrderWeightCast]
(
	@Weight DECIMAL(18,4),
	@PriceUnit BIGINT			-- 1 公斤 2 吨 3 立方 4 升
)
RETURNS DECIMAL(18, 4)
AS
BEGIN
	DECLARE @Result DECIMAL(18,4);
	SET @Result = 0;
	
	IF @PriceUnit = 1
	BEGIN
		-- 订单中物品重量单位为公斤，计价单位为公斤时无需转换
		SET @Result = @Weight;
	END
	ELSE IF @PriceUnit = 2
	BEGIN
		-- 计价单位为吨
		SET @Result = CONVERT( DECIMAL(18,4), @Weight / 1000 );
	END
	ELSE
	BEGIN
		-- 其他不支持的单位
		SET @Result = @Weight;
	END
	
	RETURN @Result;
END
GO


