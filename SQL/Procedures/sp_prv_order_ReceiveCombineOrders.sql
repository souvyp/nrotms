USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_ReceiveCombineOrders]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_ReceiveCombineOrders]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*接收或拒绝调度给我的拼车单*/
CREATE PROCEDURE [dbo].[sp_prv_order_ReceiveCombineOrders]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@Accept BIGINT = 1,			-- 1 接受 0 拒绝
	@Description NVARCHAR(512) = N'',
	@Result BIGINT OUTPUT
)
AS
BEGIN


	DECLARE @CompanyID BIGINT;
	DECLARE @FromCompanyID BIGINT;
	DECLARE @FromOperator BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @FromCompanyID = 0;
	SET @FromOperator = 0;

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510043001;
	END
	
	-- 当前用户没有接受单据的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510043002;
	END
	
	-- 单据是否存在
	IF @Result = 0
	BEGIN
		SELECT @FromOperator = Index_Creator, @FromCompanyID = Index_CreatorCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SrcClass = 3 AND Index_SupplierCompanyID = @CompanyID AND Index_Status = 1 AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510043003;
		END
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
		    -- 修改单据状态
		    UPDATE TMS_OrderIndex SET Index_Status = 2, Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE() WHERE Index_ID = @OrderID;
		    IF @@ROWCOUNT = 0
		    BEGIN
				SET @Result = -510043004;
		    END

			-- 添加订单流程
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, 2, 0, @Description, @Operator, @CompanyID, GETDATE(), 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510043005;
				END
			END
			
			-- 更新被合单订单列表的总体积、总重量、总数量
			IF @Result = 0
			BEGIN
				UPDATE TMS_OrderContains SET Contains_Volume = dbo.fn_pub_order_TotalVolume(Contains_OrderID, 0), 
Contains_Weight = dbo.fn_pub_order_TotalWeight(Contains_OrderID, 0), Contains_Amount = dbo.fn_pub_order_TotalAmount(Contains_OrderID, 0) WHERE Contains_OwnerOrderID= @OrderID AND Contains_Invalid = 0;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510043011;
				END
			END

			-- 执行订单列表的发送接收操作
			IF @Result = 0
			BEGIN
				DECLARE @Desc NVARCHAR(512);
				SET @Desc = N'Combine the orders to ' + CAST(@OrderID AS VARCHAR);
				
				DECLARE @_OrderID BIGINT;
				DECLARE @_SupplierID BIGINT;
				DECLARE @_SupplierCompanyID BIGINT;
				DECLARE @_Result BIGINT;
				DECLARE @SupplierOrderID BIGINT;
				SET @_OrderID = 0;
				SET @_SupplierID = 0;
				SET @_SupplierCompanyID = 0;
				SET @_Result = 0;
				SET @SupplierOrderID = 0;

				DECLARE order_cursor CURSOR LOCAL FOR SELECT A.Contains_OrderID, B.Index_SupplierID, B.Index_SupplierCompanyID FROM TMS_OrderContains AS A INNER JOIN TMS_OrderIndex AS B ON A.Contains_OwnerOrderID = B.Index_ID WHERE A.Contains_OwnerOrderID = @OrderID AND A.Contains_Invalid = 0 AND B.Index_Invalid = 0 AND B.Index_Status <> 32;
				OPEN order_cursor;
				
				FETCH NEXT FROM order_cursor INTO @_OrderID, @_SupplierID, @_SupplierCompanyID;
				WHILE @@FETCH_STATUS = 0
				BEGIN
					DECLARE @_SupplierOperator BIGINT;
					SET @_SupplierOperator = 0;

					IF @_OrderID IS NULL
					BEGIN
						SET @_OrderID = 0;
					END
					IF @_SupplierID IS NULL
					BEGIN
						SET @_SupplierID = 0;
					END

					-- 获取承运商端的操作者[默认为管理员]
					SELECT TOP 1 @_SupplierOperator = [User_ID] FROM TMS_User WHERE User_CompanyID = @_SupplierCompanyID AND User_RoleID = 256 AND User_Invalid = 0;
					IF @@ROWCOUNT = 0
					BEGIN
						SET @Result = -510043006;
					END

					IF @Result = 0
					BEGIN
						-- 发送订单
						EXEC sp_prv_order_SendOrder @FromOperator, @_OrderID, @_SupplierID, 0, 0, 0, @Result = @_Result OUTPUT;
						IF @_Result = 0
						BEGIN
							-- 接收订单
							EXEC sp_prv_order_ReceiveOrder @_SupplierOperator, @_SupplierCompanyID, @_OrderID, 1, @Desc, @Result = @_Result OUTPUT,@SupplierOrderID = @SupplierOrderID OUTPUT;
							IF @_Result <> 0
							BEGIN
								SET @Result = @_Result;
							END
						END
						ELSE
						BEGIN
							SET @Result = @_Result;
						END
					END

					-- 出错则退出游标					
					IF @Result <> 0
					BEGIN
						BREAK;
					END

					FETCH NEXT FROM order_cursor INTO @_OrderID, @_SupplierID, @_SupplierCompanyID;
				END

				CLOSE order_cursor;
				DEALLOCATE order_cursor;
			END

			-- 添加事件通知(14 单据已接收)
			IF @Result = 0
			BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 14, @FromCompanyID, @ProcResult, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510043010;
				END
			END
		END
		ELSE
		BEGIN
			-- 单据被拒绝
			UPDATE TMS_OrderIndex SET Index_Status = 0, Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE() WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510043007;
			END
			
			-- 添加订单流程
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, 0, 1, @Description, @Operator, @CompanyID, GETDATE(), 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510043008;
				END
			END
		
			-- 添加事件通知(13 订单被拒绝)
			IF @Result = 0
			BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 13, @FromCompanyID, @ProcResult, @OrderID, @OccurTime,@Description, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510043009;
				END
			END
		END
	END

END
GO


