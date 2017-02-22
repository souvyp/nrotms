USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_GoodsVolume]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_GoodsVolume]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_GoodsVolume]
(
	@GoodsID BIGINT,
	@Qty DECIMAL(18,2)
)
RETURNS DECIMAL(18,6)
AS
BEGIN
	DECLARE @Volume DECIMAL(18,6);
	SET @Volume = 0;
	
	SELECT @Volume = ISNULL(Goods_Volume, 0) FROM TMS_MGoods WHERE Goods_ID = @GoodsID AND Goods_Invalid = 0;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @Volume = 0;
	END
	
	SET @Volume = ISNULL(@Volume, 0) * @Qty;

	RETURN @Volume;
END
GO


