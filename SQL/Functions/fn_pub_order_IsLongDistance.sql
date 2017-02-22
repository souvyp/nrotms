USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_IsLongDistance]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_IsLongDistance]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_pub_order_IsLongDistance]
(
	@OrderID BIGINT
)
RETURNS TINYINT
AS
BEGIN
	DECLARE @Result TINYINT;
	SET @Result = 0;
	
	IF EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND (CASE 
WHEN Index_FromProvince <> Index_ToProvince THEN 1 
WHEN Index_FromCity <> Index_ToCity THEN 1 ELSE 0 END) = 1)
	BEGIN
		SET @Result = 1;
	END

	RETURN @Result;
END
GO


