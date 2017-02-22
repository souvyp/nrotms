USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_OrderPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_OrderPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*查询订单价格*/
CREATE PROCEDURE [dbo].[sp_pub_order_OrderPrice]
(
	@Operator BIGINT,
	@OrderID BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION;
	
	DECLARE @Result NVARCHAR;
	SET @Result = '';
	
	EXEC sp_prv_order_OrderPrice @Operator,@OrderID,@Result = @Result OUTPUT;
	
	IF @Result = 0
		BEGIN
			COMMIT TRANSACTION;
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION;
		END

	SET NOCOUNT OFF;
END

GO


