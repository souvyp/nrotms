USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_CheckGoodsAddition]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_CheckGoodsAddition]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_CheckGoodsAddition]
(
	@OrderID BIGINT,
	@VolumeAddition DECIMAL(18,6) = 0,			-- 体积补差
	@WeightAddition DECIMAL(18,4) = 0			-- 重量补差
)
RETURNS TINYINT									-- 0 False 1 True
AS
BEGIN
	DECLARE @Result TINYINT;
	DECLARE @Volume DECIMAL(18,6);
	DECLARE @Weight DECIMAL(18,4);
	DECLARE @Count DECIMAL(18,2);
	SET @Result = 1;
	SET @Volume = dbo.fn_pub_order_TotalVolume(@OrderID, 0);
	SET @Weight = dbo.fn_pub_order_TotalWeight(@OrderID, 0);
	
	-- 不能减到负数
	IF @VolumeAddition < 0 AND @VolumeAddition IS NOT NULL AND (@Volume + @VolumeAddition) < 0
	BEGIN
		SET @Result = 0;
	END
	IF @WeightAddition < 0 AND @WeightAddition IS NOT NULL AND (@Weight + @WeightAddition) < 0
	BEGIN
		SET @Result = 0;
	END

	RETURN @Result;
END
GO


