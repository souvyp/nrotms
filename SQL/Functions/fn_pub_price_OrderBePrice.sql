USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_price_OrderBePrice]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_price_OrderBePrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_price_OrderBePrice]
(
	@OrderID BIGINT
)
RETURNS TINYINT
BEGIN
	DECLARE @Result TINYINT;
	DECLARE @CombinedOrderID BIGINT;
	SET @Result = 0;
	SET @CombinedOrderID = 0;
	
	IF EXISTS(SELECT TOP 1 Index_ID FROM Price_DocIndex WHERE Index_OrderID = @OrderID AND Index_Type IN (1, 4) AND Index_Status <> 4 AND Index_Invalid = 0)
	BEGIN
		SET @Result = 1;
	END
	ELSE
	BEGIN
		SELECT @CombinedOrderID = Contains_OwnerOrderID FROM TMS_OrderContains WHERE Contains_OrderID = @OrderID AND Contains_Invalid = 0;
		IF @@ROWCOUNT > 0
		BEGIN
			IF EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_OrderID = @CombinedOrderID AND Index_Type = 4 AND Index_Status <> 4 AND Index_Invalid = 0)
			BEGIN
				SET @Result = 1;
			END
		END
	END
	
	RETURN @Result;
END
GO


