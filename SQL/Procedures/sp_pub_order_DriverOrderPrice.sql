USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_DriverOrderPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_DriverOrderPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*查询订单价格*/
CREATE PROCEDURE [dbo].[sp_pub_order_DriverOrderPrice]
(
	@OpenId NVARCHAR(300),
	@OrderID BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Operator BIGINT;	
	DECLARE @Result BIGINT;
	SET @Operator = dbo.fn_pub_user_OpenId2User (@OpenId);
	SET @Result = 0;
	
	BEGIN TRANSACTION;
	
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


