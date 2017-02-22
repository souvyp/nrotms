USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_SendBackOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_SendBackOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*打回订单(与撤回不一样)*/
CREATE PROCEDURE [dbo].[sp_pub_order_SendBackOrder]
(
	@OrderID BIGINT,
	@Operator BIGINT,
	@Description NVARCHAR(512)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @SrcStatus BIGINT;
	DECLARE @DstStatus BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @SrcStatus = 0;
	SET @DstStatus = 0;
	
	BEGIN TRANSACTION;

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510033001;
	END
	
	-- 当前用户没有打回订单的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510033002;
	END
	
	-- 订单是否存在
	IF @Result = 0
	BEGIN
		SELECT @SrcStatus = Index_Status FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Status > 0 AND Index_Status < 16 AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510033003;
		END
	END
	
	-- 已经委托供应商承运的单子暂时不能打回
	IF @Result = 0 AND EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SupplierID > 0 AND Index_SupplierCompanyID > 0)
	BEGIN
		SET @Result = -510033004;
	END

	-- 计算订单的目标状态
	IF @Result = 0
	BEGIN
		-- 已审核(待分配)
		IF @SrcStatus = 1
		BEGIN
			SET @DstStatus = 0;

			UPDATE TMS_OrderIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE(), Index_Confirmer = 0, Index_SupplierID = 0, Index_SupplierCompanyID = 0 WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510033005;
			END
		END
		
		-- 已分配(待签收)
		IF @SrcStatus = 2
		BEGIN
			SET @DstStatus = 1;
			
			UPDATE TMS_OrderIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE(), Index_DriverID = 0, Index_CarID = 0 WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510033006;
			END
		END
		
		-- 已签收(待回单)
		IF @SrcStatus = 4
		BEGIN
			SET @DstStatus = 2;
			
			UPDATE TMS_OrderIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE(), Index_Singer = 0, Index_Exception = '' WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510033007;
			END
			
			IF @Result = 0
			BEGIN
				UPDATE TMS_OrderGoods SET GoodsLst_ReceiptQty = 0, GoodsLst_ExceptionQty = 0, GoodsLst_Updater = 0, GoodsLst_UpdateTime = GETDATE() WHERE GoodsLst_OrderID = @OrderID AND GoodsLst_Invalid = 0;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510033008;
				END
			END
		END
		
		-- 已回单(待结算)，暂不实现
		-- IF @SrcStatus = 8
	END
	
	-- 添加流程
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, @SrcStatus, @DstStatus, 2, @Description, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510033009;
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
	
	SELECT @Result AS Back_Result;

	SET NOCOUNT OFF;
END
GO


