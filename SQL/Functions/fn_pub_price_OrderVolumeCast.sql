USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_price_OrderVolumeCast]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_price_OrderVolumeCast]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_price_OrderVolumeCast]
(
	@Volume DECIMAL(18,6),
	@PriceUnit BIGINT			-- 1 吨 2 公斤 3 立方 4 升
)
RETURNS DECIMAL(18, 6)
AS
BEGIN
	DECLARE @Result DECIMAL(18,6);
	SET @Result = 0;
	
	IF @PriceUnit = 3
	BEGIN
		-- 订单中物品重量单位为立方米，计价单位为立方米时无需转换
		SET @Result = @Volume;
	END
	ELSE IF @PriceUnit = 4
	BEGIN
		-- 计价单位为升
		SET @Result = @Volume * 1000;
	END
	ELSE
	BEGIN
		-- 其他不支持的单位
		SET @Result = @Volume;
	END
	
	RETURN @Result;
END
GO


