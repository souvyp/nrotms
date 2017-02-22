USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_SrcOrderID2RootOrderID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_SrcOrderID2RootOrderID]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_SrcOrderID2RootOrderID]
(
	@OrderID BIGINT,
	@SrcOrderID BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT;
	SET @Result = 0;
	
	IF @SrcOrderID IS NULL OR @SrcOrderID = 0
	BEGIN
		SET @Result = @OrderID;
	END
	ELSE
	BEGIN
		SELECT @Result = Index_RootOrderID FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = @SrcOrderID;
		END
	END
	RETURN @Result;
END
GO


