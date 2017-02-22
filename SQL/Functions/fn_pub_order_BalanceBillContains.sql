USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_BalanceBillContains]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_BalanceBillContains]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 是否已经从属某张应收/应付结账单
CREATE FUNCTION [dbo].[fn_pub_order_BalanceBillContains]
(
	@OrderID BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT;
	DECLARE @BillID BIGINT;
	SET @Result = 0;
	SET @BillID = 0;
	
	SELECT @BillID = Detail_DocID FROM Balance_BillDetails WHERE Detail_OrderID = @OrderID AND Detail_Invalid = 0;
	IF @@ROWCOUNT > 0 AND @BillID IS NOT NULL AND @BillID > 0
	BEGIN
		IF EXISTS(SELECT Index_ID FROM Balance_BillIndex WHERE Index_ID = @BillID AND Index_Invalid = 0)
		BEGIN
			SET @Result = 1;
		END
	END
	
	RETURN @Result;
END
GO


