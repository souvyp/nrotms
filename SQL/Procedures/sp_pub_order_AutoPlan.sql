USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_AutoPlan]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_AutoPlan]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*自动执行运输计划(创建订单后)*/
CREATE PROCEDURE [dbo].[sp_pub_order_AutoPlan]
(
	@Operator BIGINT,
	@SrcOrderID BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Result BIGINT;
	DECLARE @DstOrderID BIGINT;
	SET @Result = 0;
	SET @DstOrderID = 0;
	
	BEGIN TRANSACTION;
	
	EXEC sp_prv_order_AutoPlan @Operator, @SrcOrderID, 0, @Result = @Result OUTPUT, @DstOrderID = @DstOrderID OUTPUT;
	
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS Order_Result, @DstOrderID AS Order_ID;

	SET NOCOUNT OFF;
END


GO


