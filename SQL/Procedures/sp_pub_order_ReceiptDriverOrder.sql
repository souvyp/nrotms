USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_ReceiptDriverOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_ReceiptDriverOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*¶©µ¥»Øµ¥*/
CREATE PROCEDURE [dbo].[sp_pub_order_ReceiptDriverOrder]
(
	@OpenId NVARCHAR(300),
	@OrderID BIGINT,
	@ReceiptDocPath0 NVARCHAR(512) = N'',
	@ReceiptDocPath1 NVARCHAR(512) = N'',
	@ReceiptDocPath2 NVARCHAR(512) = N'',
	@ReceiptDocPath3 NVARCHAR(512) = N'',
	@IsPaperReceived BIGINT = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Operator BIGINT;
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Operator = dbo.fn_pub_user_OpenId2User (@OpenId);
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	BEGIN TRANSACTION;

	EXEC sp_prv_order_ReceiptOrder @Operator,@CompanyID, @OrderID,@ReceiptDocPath0,@ReceiptDocPath1,@ReceiptDocPath2,@ReceiptDocPath3,@IsPaperReceived,0,@Result = @Result OUTPUT;

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


