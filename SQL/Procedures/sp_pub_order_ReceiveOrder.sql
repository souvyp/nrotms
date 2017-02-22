USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_ReceiveOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_ReceiveOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*接收订单*/
CREATE PROCEDURE [dbo].[sp_pub_order_ReceiveOrder]
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
	DECLARE @FromCompanyID BIGINT;
	DECLARE @FromOperator BIGINT;
	DECLARE @SupplierOrderID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @FromCompanyID = 0;
	SET @FromOperator = 0;
	SET @SupplierOrderID = 0;
	
	BEGIN TRANSACTION;

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510017001;
	END
	
	-- 当前用户没有接受订单的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510017002;
	END
	
	-- 执行订单接收操作
	IF @Result = 0
	BEGIN
		EXEC sp_prv_order_ReceiveOrder @Operator, @CompanyID, @OrderID, @Accept, @Description, @Result = @Result OUTPUT,@SupplierOrderID = @SupplierOrderID OUTPUT;
	END
	
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


