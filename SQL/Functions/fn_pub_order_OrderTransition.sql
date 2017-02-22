USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_OrderTransition]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_OrderTransition]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_OrderTransition]
(
	@OrderID BIGINT,
	@type INT
)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @Transition NVARCHAR(50);
	SET @Transition = 0;
	-- 1 来源订单是否拼车 订单的Index_SrcOrderID=来源订单的 Index_ID
	IF @type = 1 
	
	BEGIN
		SELECT @Transition = Index_Combined FROM TMS_OrderIndex WHERE Index_ID = (SELECT Index_SrcOrderID FROM TMS_OrderIndex WHERE Index_ID = @OrderID);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Transition = 0;
		END
	END
	
	RETURN @Transition;
END
GO


