USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_OrderID2Code]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_OrderID2Code]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_OrderID2Code]
(
	@OrderID BIGINT
)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @OrderCode NVARCHAR(50);
	SET @OrderCode = N'';
	
	SELECT @OrderCode = Index_Code FROM TMS_OrderIndex WHERE Index_ID = @OrderID;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @OrderCode = N'';
	END
	
	RETURN @OrderCode;
END
GO


