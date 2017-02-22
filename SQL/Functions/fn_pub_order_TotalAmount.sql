USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_TotalAmount]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_TotalAmount]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_TotalAmount]
(
	@OrderID BIGINT,
	@IsReceipt TINYINT
)
RETURNS DECIMAL(18,0)
AS
BEGIN
	DECLARE @Amount DECIMAL(18,0);
	SET @Amount = 0;
	
	IF @OrderID IS NOT NULL
	BEGIN
		SELECT @Amount = CAST(SUM(CASE WHEN @IsReceipt = 1 THEN GoodsLst_ReceiptQty ELSE GoodsLst_Qty END) AS BIGINT) FROM TMS_OrderGoods WHERE GoodsLst_OrderID = @OrderID AND GoodsLst_Invalid = 0;
	END

	RETURN @Amount;
END
GO


