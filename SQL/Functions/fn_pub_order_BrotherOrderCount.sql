USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_BrotherOrderCount]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_BrotherOrderCount]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_BrotherOrderCount]
(
	@OrderID BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Count BIGINT;
	DECLARE @SrcOrderID BIGINT;
	SET @Count = 0;
	SET @SrcOrderID = 0;

	SELECT @SrcOrderID = Index_SrcOrderID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND Index_Status <> 32;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @SrcOrderID = 0;
	END
	
	SELECT @Count = COUNT(Index_ID) FROM TMS_OrderIndex WHERE Index_SrcOrderID = @SrcOrderID AND Index_Invalid = 0 AND Index_Status <> 32;
	IF @@ROWCOUNT = 0
	BEGIN
		SEt @Count = 0;
	END
	
	RETURN @Count;
END
GO


