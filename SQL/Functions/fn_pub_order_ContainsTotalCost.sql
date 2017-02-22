USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_ContainsTotalCost]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_ContainsTotalCost]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/** 合单补充报价总价 **/
CREATE FUNCTION [dbo].[fn_pub_order_ContainsTotalCost]
(
	@Order BIGINT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE @Cost DECIMAL(18,2);

	SET @Cost = 0;

	
	BEGIN
		SELECT @Cost = SUM(CASE WHEN Detail_Type IN (1,2,3,4,5,6,8,9,10) THEN Detail_Amount ELSE 0 END) FROM Price_DocDetails INNER JOIN  Price_DocIndex ON Detail_DocID = Index_ID WHERE Index_OrderID = @Order AND Detail_Invalid = 0 AND Index_Status = 2;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Cost = 0;
		END
	END
	

	RETURN ISNULL(@Cost, 0);
END

GO


