USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_TotalVolume]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_TotalVolume]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_TotalVolume]
(
	@OrderID BIGINT,
	@IsReceipt TINYINT
)
RETURNS DECIMAL(18,6)
AS
BEGIN
	DECLARE @Volume DECIMAL(18,6);
	DECLARE @Addition DECIMAL(18,6);
	SET @Volume = 0;
	SET @Addition = 0;
	
	IF @OrderID IS NOT NULL
	BEGIN
		SELECT @Addition = Index_VolumeAddition FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0 OR @Addition IS NULL
		BEGIN
			SET @Addition = 0;
		END

		SELECT @Volume = SUM(GoodsLst_Volume) FROM TMS_OrderGoods WHERE GoodsLst_OrderID = @OrderID AND GoodsLst_Invalid = 0;
		
		-- 体积补差处理
		SET @Volume = @Volume + @Addition;
		
		-- 体积为零时换算 4方=1吨
		IF @Volume = 0 AND @IsReceipt = 1
		BEGIN
		SELECT @Volume = SUM(GoodsLst_Weight/250) FROM TMS_OrderGoods WHERE GoodsLst_OrderID = @OrderID AND GoodsLst_Invalid = 0 ;
		SELECT @Addition = Index_WeightAddition/250 FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0;	
		SET @Volume = @Volume + @Addition;
		
		END
		
		IF @Volume < 0
		BEGIN
			SET @Volume = 0;
		END
	END

	RETURN @Volume;
END
GO


