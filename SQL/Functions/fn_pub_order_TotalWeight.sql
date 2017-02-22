USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_TotalWeight]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_TotalWeight]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_TotalWeight]
(
	@OrderID BIGINT,
	@IsReceipt TINYINT
)
RETURNS DECIMAL(18,4)
AS
BEGIN
	DECLARE @Weight DECIMAL(18,4);
	DECLARE @Addition DECIMAL(18,4);
	SET @Weight = 0;
	SET @Addition = 0;
	
	IF @OrderID IS NOT NULL
	BEGIN
		SELECT @Addition = Index_WeightAddition FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0 OR @Addition IS NULL
		BEGIN
			SET @Addition = 0;
		END

		SELECT @Weight = SUM(GoodsLst_Weight) FROM TMS_OrderGoods WHERE GoodsLst_OrderID = @OrderID AND GoodsLst_Invalid = 0;
		
		-- 重量补差处理
		SET @Weight = @Weight + @Addition;
		
		-- 重量为零时换算 4方=1吨
		IF @Weight = 0 AND @IsReceipt = 1
		BEGIN
		SELECT @Weight = SUM(GoodsLst_Volume*250) FROM TMS_OrderGoods WHERE GoodsLst_OrderID = @OrderID AND GoodsLst_Invalid = 0 ;
		SELECT @Addition = Index_VolumeAddition*250 FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0;	
		SET @Weight = @Weight + @Addition;
		END
		
		IF @Weight < 0
		BEGIN
			SET @Weight = 0;
		END
	END

	RETURN @Weight;
END
GO


