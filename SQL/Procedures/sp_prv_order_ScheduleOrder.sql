USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_ScheduleOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_ScheduleOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 订单调度
CREATE PROCEDURE [dbo].[sp_prv_order_ScheduleOrder]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@SupplierID BIGINT,
	@DriverID BIGINT,
	@CarID BIGINT,
	@_VolumeAddition DECIMAL(18,6) = 0,			-- 体积补差
	@_WeightAddition DECIMAL(18,4) = 0,			-- 重量补差
	@SupplierSymbolID BIGINT = 0,
	@PactCode NVARCHAR(100),
	@Result BIGINT OUTPUT
)
AS
BEGIN

	DECLARE @CompanyID BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	IF @SupplierID IS NULL
	BEGIN
		SET @SupplierID = 0;
	END
	IF @CarID IS NULL
	BEGIN
		SET @CarID = 0;
	END
	IF @DriverID IS NULL
	BEGIN
		SET @DriverID = 0;
	END
	

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510036001;
	END
	
	-- 当前用户没有发送订单的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510036002;
	END

	-- 原始订单是否存在，是否处于待调度状态(只有运输订单允许调度)
	IF @Result = 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SrcClass = 2 AND Index_Status = 1 AND Index_Invalid = 0 AND Index_CreatorCompanyID = @CompanyID)
	BEGIN
		SET @Result = -510036003;
	END

	-- 检查体积补差、重量补差、数量补差值
	IF @Result = 0 AND dbo.fn_pub_order_CheckGoodsAddition(@OrderID, @_VolumeAddition, @_WeightAddition) = 0
	BEGIN
		SET @Result = -510036009;
	END
	
	
	
	-- 承运商标识是否存在
	IF @Result = 0 AND @SupplierSymbolID > 0
	BEGIN
		IF NOT EXISTS(SELECT Symbol_ID FROM TMS_MSymbol WHERE Symbol_ID = @SupplierSymbolID AND Symbol_Type = 2 AND Symbol_Invalid = 0)
		BEGIN
			SET @SupplierSymbolID = 0;
		END
	END
	
	-- 调度业务
	IF @Result = 0
	BEGIN
		IF @SupplierID = 0
		BEGIN
			-- 自营

			-- 车辆是否存在[车辆编号允许为0]
			IF @Result = 0 AND @CarID > 0 AND NOT EXISTS(SELECT Car_ID FROM TMS_MCar WHERE Car_ID = @CarID AND Car_CompanyID = @CompanyID AND Car_Invalid = 0)
			BEGIN
				SET @Result = -510036005;
			END
	
			-- 司机是否存在[司机编号允许为0]
			IF @Result = 0 AND @DriverID > 0 AND NOT EXISTS(SELECT Driver_ID FROM TMS_MDriver WHERE Driver_ID = @DriverID AND Driver_CompanyID = @CompanyID AND Driver_Invalid = 0)
			BEGIN
				SET @Result = -510036006;
			END
	
			-- 分配订单
			IF @Result = 0
			BEGIN
				UPDATE TMS_OrderIndex SET Index_Status = 2, Index_StatusTime = GETDATE(), Index_CarID = @CarID, Index_DriverID = @DriverID, Index_SupplierSymbolID = @SupplierSymbolID WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND Index_Status = 1;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510036007;
				END
			END
	
			
		END
		ELSE
		BEGIN
			-- 线上承运商
			EXEC sp_prv_order_SendOrder @Operator, @OrderID, @SupplierID, @_VolumeAddition, @_WeightAddition, 0, @Result = @Result OUTPUT;
		END
	END
	
	-- 添加订单流程
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid, Flow_Comments) VALUES(
@OrderID, 1, 2, @Operator, @CompanyID, GETDATE(), 0,convert(nvarchar,@_VolumeAddition)+','+convert(nvarchar,@_WeightAddition));
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510036008;
				END
			END
	
END
GO


