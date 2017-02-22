USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_UnscheduleSupplierOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_UnscheduleSupplierOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--撤回委托给承运商的单子(对方未接收前)
CREATE PROCEDURE [dbo].[sp_pub_order_UnscheduleSupplierOrder]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@Description NVARCHAR(512) = N''
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @SrcClass BIGINT;
	DECLARE @SupplierID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @SrcClass = 0;
	SET @SupplierID = 0;
	SET @SupplierCompanyID = 0;
	
	BEGIN TRANSACTION;

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510055001;
	END
	
	-- 当前用户没有发送订单的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510055002;
	END

	-- 当前订单是否存在
	/*
	1、订单号匹配
	2、订单有效 Invalid = 0
	3、订单被委托但对方未接收
	4、获取承运商ID、承运商公司ID，放在全局变量，下面要用到
	5、获取订单是普通订单、合单订单
	*/
	IF @Result = 0
	BEGIN
		SELECT @SrcClass = Index_SrcClass, @SupplierID = Index_SupplierID, @SupplierCompanyID = Index_SupplierCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND 
Index_Invalid = 0 AND Index_CreatorCompanyID = @CompanyID AND Index_SupplierID > 0 AND Index_Status = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510055003;
		END
		ELSE
		BEGIN
			IF @SupplierCompanyID <= 0
			BEGIN
				SET @Result = -510055004;
			END
		END
	END

	-- 修改订单相应字段
	/*
	Index_SupplierID = 0, Index_SupplierCompanyID = 0
	*/
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = (CASE WHEN @SrcClass = 3 THEN 0 ELSE 1 END), Index_SupplierID = 0, Index_SupplierCompanyID = 0 WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND Index_Status = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510055005;
		END
	END

	-- 添加订单流程
	-- Ext中写订单编号，Description写到描述里面
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, (CASE WHEN @SrcClass = 3 THEN 0 ELSE 1 END), 4, @Description, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510055006;
		END
	END
	
	-- 添加事件通知
	-- 订单所有者 发给 承运商的通知
	-- 通知类型 17，表示客户撤销订单委托
	IF @Result = 0
	BEGIN
		DECLARE @OccurTime DATETIME;
		DECLARE @EventID BIGINT;
		DECLARE @tmpResult BIGINT;
		SET @OccurTime = GETDATE();
		SET @EventID = 0;
		SET @tmpResult = 0;

		EXEC sp_prv_event_AddEvent @Operator, 17, @SupplierCompanyID, 0, @OrderID, @OccurTime, @Description, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
		IF @tmpResult <> 0 
		BEGIN
			SET @Result = -510055007;
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

	SELECT @Result AS Schedule_Result;

	SET NOCOUNT OFF;
END
GO


