USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_AutoPlan]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_AutoPlan]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*自动执行不拆单的运输计划(下单后)*/
CREATE PROCEDURE [dbo].[sp_prv_order_AutoPlan]
(
	@Operator BIGINT,
	@SrcOrderID BIGINT,
	@TxnRequired BIGINT,
	@Result BIGINT OUTPUT,
	@DstOrderID BIGINT OUTPUT
)
AS
BEGIN
	DECLARE @SrcCode NVARCHAR(100);
	DECLARE @RootOrderID BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @RootOrderID = 0;
	SET @SrcCode = N'';
	SET @Result = 0;
	SET @DstOrderID = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	
	-- 来源订单是否存在(只有客户订单允许创建计划)
	IF @Result = 0
	BEGIN
		SELECT @SrcCode = Index_Code, @RootOrderID = Index_RootOrderID FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_SrcClass = 1 AND Index_Status = 0 AND Index_Invalid = 0 AND Index_CreatorCompanyID = @CompanyID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014900;
		END
	END
	
	IF @Result = 0
	BEGIN
		-- 生成新订单的编号
		DECLARE @Code NVARCHAR(100);
		SET @Code = @SrcCode + '-1';

		-- 复制原单
		INSERT INTO TMS_OrderIndex(Index_Code, Index_PactCode, Index_EndUserID, Index_EndUserName, 
Index_From, Index_FromProvince, Index_FromCity, Index_FromDistrict, Index_FromTime, 
Index_To, Index_ToProvince, Index_ToCity, Index_ToDistrict, Index_ToTime, 
Index_TransportMode, Index_GoodsCategory, Index_PackageMode, Index_ChargeMode, Index_PriceUnit, 
Index_Status, Index_StatusTime, Index_SrcOrderID, Index_RootOrderID, Index_SrcClass, Index_Kms, Index_CarType, Index_CarLength, 
Index_SupplierID, Index_SupplierCompanyID, Index_CustomerID, Index_CustomerCompanyID, 
Index_ShipMode, Index_Pick, Index_Delivery, Index_Creator, Index_CreatorCompanyID, Index_CreateTime, Index_Invalid, 
Index_OnLoad, Index_OffLoad, Index_Insurance, Index_VolumeAddition, Index_WeightAddition, Index_Description, Index_CarVolume, Index_CarWeight, Index_FromContact, 
Index_ToContact, Index_GoodsValue, Index_CustomerSymbolID,Index_DeviceCode) 
SELECT @Code, Index_PactCode, Index_EndUserID, Index_EndUserName, 
Index_From, Index_FromProvince, Index_FromCity, Index_FromDistrict, Index_FromTime, 
Index_To, Index_ToProvince, Index_ToCity, Index_ToDistrict, Index_ToTime, 
Index_TransportMode, Index_GoodsCategory, Index_PackageMode, Index_ChargeMode, Index_PriceUnit, 
1, GETDATE(), @SrcOrderID, @RootOrderID, 2, Index_Kms, Index_CarType, Index_CarLength, 
Index_SupplierID, Index_SupplierCompanyID, Index_CustomerID, Index_CustomerCompanyID, 
Index_ShipMode, Index_Pick, Index_Delivery, @Operator, @CompanyID, GETDATE(), 0, Index_OnLoad, Index_OffLoad, Index_Insurance, 
Index_VolumeAddition, Index_WeightAddition, Index_Description, Index_CarVolume, Index_CarWeight, Index_FromContact, Index_ToContact, Index_GoodsValue, 
Index_CustomerSymbolID, Index_DeviceCode FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_Status = 0 AND Index_Invalid = 0 AND Index_CreatorCompanyID = @CompanyID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014901;
		END
		ELSE
		BEGIN
			SET @DstOrderID = IDENT_CURRENT('TMS_OrderIndex');
			
			-- 写订单状态变更记录
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_InsertTime, Flow_CompanyID, Flow_Invalid) VALUES(@DstOrderID, 0, 1, @Operator, GETDATE(), @CompanyID, 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510014902;
				END
			END
		END
		
		-- 复制原单的物品信息
		IF @Result = 0
		BEGIN
			INSERT INTO TMS_OrderGoods(GoodsLst_OrderID, GoodsLst_GoodsID, GoodsLst_Code, GoodsLst_Name, GoodsLst_Qty, GoodsLst_Weight, 
GoodsLst_Volume, GoodsLst_Unit, GoodsLst_BatchNo, GoodsLst_Price, GoodsLst_Creator, GoodsLst_InsertTime, GoodsLst_Invalid) SELECT @DstOrderID, GoodsLst_GoodsID, GoodsLst_Code, 
GoodsLst_Name, GoodsLst_Qty, GoodsLst_Weight, GoodsLst_Volume, GoodsLst_Unit, GoodsLst_BatchNo, GoodsLst_Price, @Operator, GETDATE(), GoodsLst_Invalid FROM TMS_OrderGoods 
WHERE GoodsLst_OrderID = @SrcOrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014903;
			END
		END
	END
	
	-- 原订单保留，便于和客户结算，原始订单状态修改为待签收
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = 2, Index_StatusTime = GETDATE() WHERE Index_ID = @SrcOrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014904;
		END
		
		-- 写订单状态变更记录
		IF @Result = 0
		BEGIN
			INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_InsertTime, Flow_CompanyID, Flow_Invalid) VALUES(@SrcOrderID, 0, 2, @Operator, GETDATE(), @CompanyID, 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014905;
			END
		END
	END


END
GO


