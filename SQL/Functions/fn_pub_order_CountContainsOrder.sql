USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_CountContainsOrder]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_CountContainsOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_pub_order_CountContainsOrder]
(
	@OrderID BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Amount BIGINT;
	SET @Amount = 0

	BEGIN
		SELECT @Amount = SUM(1) FROM dbo.TMS_OrderContains WHERE Contains_OwnerOrderID =@OrderID;
	END
	RETURN @Amount
END	



GO


