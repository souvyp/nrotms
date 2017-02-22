USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_ReceiveOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_ReceiveOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*接收或拒绝被委托订单*/
CREATE PROCEDURE [dbo].[sp_prv_order_ReceiveOrder]
(
	@Operator BIGINT,
	@CompanyID BIGINT, 
	@OrderID BIGINT,
	@Accept BIGINT = 1,			-- 1 接受 0 拒绝
	@Description NVARCHAR(512) = N'',
	@Result BIGINT OUTPUT,
	@SupplierOrderID BIGINT OUTPUT
)
AS
BEGIN
	DECLARE @FromCompanyID BIGINT;
	DECLARE @FromOperator BIGINT;
	DECLARE @IsCombine BIGINT;
	SET @Result = 0;
	SET @FromCompanyID = 0;
	SET @FromOperator = 0;
	SET @IsCombine = 0;

	-- 订单是否存在
	IF @Result = 0
	BEGIN
		SELECT @FromOperator = Index_Creator, @FromCompanyID = Index_CreatorCompanyID, @IsCombine = Index_Combined FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SupplierCompanyID = @CompanyID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510017003;
		END
	END
	
	-- 订单是否已经被接受
	IF @Result = 0 AND @Accept = 1 AND NOT EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Status = 1 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -510017004;
	END
	
	IF @Result = 0
	BEGIN
		DECLARE @tmpResult BIGINT;
		DECLARE @EventID BIGINT;
		DECLARE @OccurTime DATETIME;
		DECLARE @ProcResult BIGINT;
		SET @tmpResult = 0;
		SET @EventID = 0;
		SET @OccurTime = GETDATE();
		SET @ProcResult = (CASE WHEN @Accept = 1 THEN 0 ELSE 1 END);

		IF @Accept = 1
		BEGIN
			-- 生成新的承运商订单

			SET @SupplierOrderID = 0;
			EXEC sp_prv_order_CloneOrder2Supplier @Operator, @OrderID, @FromCompanyID, @CompanyID, 1, @Result = @Result OUTPUT, @SupplierOrderID = @SupplierOrderID OUTPUT;
			
			-- 接受订单[直接变为已调度]
			IF @Result = 0
			BEGIN
				UPDATE TMS_OrderIndex SET Index_Status = 2, Index_StatusTime = GETDATE(), Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE() WHERE Index_ID = @OrderID AND Index_Invalid = 0 ANd Index_Status = 1;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510017005;
				END
			END
			
			-- 添加订单流程
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, 2, 0, @Description, @Operator, @CompanyID, GETDATE(), 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510017006;
				END
			END
			
			-- 计算价格并缓存，被合单订单不计算价格
			IF @Result = 0 AND @IsCombine = 0
			BEGIN
				-- 计算被委托订单价格
				EXEC sp_prv_price_CacheOrderPrice @FromOperator, @OrderID, 0, @Result = @Result OUTPUT;
				
				-- 计算承运商订单价格
				IF @Result = 0
				BEGIN
					EXEC sp_prv_price_CacheOrderPrice @Operator, @SupplierOrderID, 0, @Result = @Result OUTPUT;
				END
			END

			-- 添加事件通知(10 订单已接收)
			IF @Result = 0
			BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 10, @FromCompanyID, @ProcResult, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510017010;
				END
			END
		END
		ELSE
		BEGIN
			-- 拒绝订单
			UPDATE TMS_OrderIndex SET Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE(), Index_SupplierID = 0, Index_SupplierCompanyID = 0 WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND Index_Status = 1;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510017007;
			END
			
			-- 添加订单流程
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, 1, 1, @Description, @Operator, @CompanyID, GETDATE(), 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510017008;
				END
				ELSE
				BEGIN
					-- 添加事件通知(订单被拒绝)
					EXEC sp_prv_event_AddEvent @Operator, 4, @FromCompanyID, @ProcResult, @OrderID, @OccurTime, @Description,@Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
					IF @tmpResult <> 0 
					BEGIN
						SET @Result = -510017009;
					END
				END
			END
		END
	END
END
GO


