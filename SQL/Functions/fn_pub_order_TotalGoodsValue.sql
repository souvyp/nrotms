USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_TotalGoodsValue]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_TotalGoodsValue]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 计算货物总价值
CREATE FUNCTION [dbo].[fn_pub_order_TotalGoodsValue]
(
	@OrderID BIGINT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE @GoodsValue DECIMAL(18,2);
	SET @GoodsValue = 0;
	
	SELECT @GoodsValue = SUM(ISNULL(b.Goods_Price, 0) * ISNULL(a.GoodsLst_Qty, 0)) FROM TMS_OrderGoods AS a INNER JOIN TMS_MGoods AS b ON a.GoodsLst_GoodsID = b.Goods_ID WHERE a.GoodsLst_OrderID = @OrderID AND a.GoodsLst_Invalid = 0;
	IF @@ROWCOUNT = 0 OR @GoodsValue IS NULL
	BEGIN
		SET @GoodsValue = 0;
	END
	
	RETURN @GoodsValue;
END
GO


