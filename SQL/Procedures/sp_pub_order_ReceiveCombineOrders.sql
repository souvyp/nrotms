USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_ReceiveCombineOrders]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_ReceiveCombineOrders]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*接收或拒绝调度给我的拼车单*/
CREATE PROCEDURE [dbo].[sp_pub_order_ReceiveCombineOrders]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@Accept BIGINT = 1,			-- 1 接受 0 拒绝
	@Description NVARCHAR(512) = N''
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	BEGIN TRANSACTION;

	EXEC sp_prv_order_ReceiveCombineOrders @Operator, @OrderID, @Accept, @Description, @Result = @Result OUTPUT;
	
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS Order_Result;

	SET NOCOUNT OFF;
END
GO


