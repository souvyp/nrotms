USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_CloseCombineOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_CloseCombineOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*关闭拼车单*/
CREATE PROCEDURE [dbo].[sp_pub_order_CloseCombineOrder]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@Description NVARCHAR(512)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @SrcStatus BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @Result = 0;
	SET @SrcStatus = 0;

	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510044001;
	END
	
	-- 当前用户没有关闭订单的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510044002;
	END
	
	-- 拼车是否存在(只有未经审核的拼车单才能关闭)
	IF @Result = 0
	BEGIN
		SELECT @SrcStatus = Index_Status FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_SrcClass = 3 AND Index_Status <= 1 AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510044003;
		END
	END

	-- 关闭订单
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = 32, Index_StatusTime = GETDATE() WHERE Index_ID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510044004;
		END
	END
	
	-- 添加订单流程
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, @SrcStatus, 32, 0, N'Send order auomatically!', @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510043008;
		END
	END

	-- 释放被拼车订单
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Combined = 0, Index_SupplierID = 0, Index_SupplierCompanyID = 0 WHERE Index_ID IN (SELECT Contains_OrderID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510044005;
		END
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


