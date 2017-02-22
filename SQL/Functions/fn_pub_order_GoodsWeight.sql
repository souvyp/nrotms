USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_GoodsWeight]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_GoodsWeight]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_GoodsWeight]
(
	@GoodsID BIGINT,
	@Qty DECIMAL(18,2)
)
RETURNS DECIMAL(18,4)
AS
BEGIN
	DECLARE @Weight DECIMAL(18,4);
	SET @Weight = 0;
	
	SELECT @Weight = ISNULL(Goods_Weight, 0) FROM TMS_MGoods WHERE Goods_ID = @GoodsID AND Goods_Invalid = 0;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @Weight = 0;
	END
	
	SET @Weight = ISNULL(@Weight, 0) * @Qty;

	RETURN @Weight;
END
GO


