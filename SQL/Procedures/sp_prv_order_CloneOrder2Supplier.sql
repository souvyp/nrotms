USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_CloneOrder2Supplier]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_CloneOrder2Supplier]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*承运商接收订单时，生成承运商端的客户订单*/
CREATE PROCEDURE [dbo].[sp_prv_order_CloneOrder2Supplier]
(
	@Creator BIGINT,
	@OrderID BIGINT,
	@CompanyID BIGINT,
	@SupplierCompanyID BIGINT,
	@SrcClass BIGINT,
	@Result BIGINT OUTPUT,
	@SupplierOrderID BIGINT OUTPUT
)
AS
BEGIN
	DECLARE @CustomerID BIGINT;
	DECLARE @Code NVARCHAR(100);
	DECLARE @EndUserID BIGINT;
	DECLARE @EndUserName NVARCHAR(300);
	DECLARE @DstOrderID BIGINT;
	DECLARE @ShipMode BIGINT;
	DECLARE @FromProvince BIGINT = 0;
	DECLARE @FromCity BIGINT = 0;
	DECLARE @ToProvince BIGINT = 0;
	DECLARE @ToCity BIGINT = 0;
	SET @Result = 0;
	SET @SupplierOrderID = 0;
	SET @CustomerID = 0;
	SET @EndUserID = 0;
	SET @EndUserName = N'';
	SET @DstOrderID = 0;
	SET @ShipMode = 0;
	SET @FromProvince = 0;
	SET @FromCity = 0;
	SET @ToProvince = 0;
	SET @ToCity = 0;

	-- 订单号是否存在
	IF @Result = 0
	BEGIN
		SELECT @EndUserName = Index_EndUserName, @FromProvince = Index_FromProvince, @FromCity = Index_FromCity, @ToProvince = Index_ToProvince, @ToCity = Index_ToCity FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510031001;
		END
	END
	
	-- 产生新订单的编号
	IF @Result = 0
	BEGIN
		EXEC sp_pub_basic_GetSN 2, @SN = @Code OUTPUT;
	END
	
	-- 下单公司是否是承运商的客户
	IF @Result = 0
	BEGIN
		SELECT @CustomerID = Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @SupplierCompanyID AND Customer_CompanyID = @CompanyID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510031002;
		END
	END
	
	-- 获取承运商的公司管理员
	-- 2016.5.12 guohl 调用者指定创建人
	/*
	IF @Result = 0
	BEGIN
		SELECT @Creator = [User_ID] FROM TMS_User WHERE User_CompanyID = @SupplierCompanyID AND User_RoleID = 256 AND User_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510031003;
		END
	END
	*/
	
	-- 自动将收获人信息追加为当前用户的EndUser
	--@EndUserID
	IF @Result = 0
	BEGIN
		DECLARE @EndUserCode NVARCHAR(100);
		SET @EndUserCode = N'';
		EXEC sp_pub_basic_GetSN 1, @SN = @EndUserCode OUTPUT;

		SELECT @EndUserID = EndUser_ID FROM TMS_MEndUser WHERE EndUser_OwnerCompany = @SupplierCompanyID AND 
EndUser_CustomerID = @CustomerID AND EndUser_Name = @EndUserName AND EndUser_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			INSERT INTO TMS_MEndUser(EndUser_OwnerCompany, EndUser_CustomerID, EndUser_CustomerCompanyID, EndUser_ClientCode, 
EndUser_Name, EndUser_Creator, EndUser_InsertTime, EndUser_Invalid) VALUES(@SupplierCompanyID, @CustomerID, @CompanyID, @EndUserCode, 
@EndUserName, @Creator, GETDATE(), 0);
			IF @@ROWCOUNT > 0
			BEGIN
				SET @EndUserID = IDENT_CURRENT('TMS_MEndUser');
			END
		END
	END
	
	-- 接收订单时自动重算长途、市内
	IF @Result = 0
	BEGIN
		SET @ShipMode = dbo.fn_pub_order_CalcShipMode( @Creator, @SupplierCompanyID, @FromProvince, @FromCity, @ToProvince, @ToCity);
	END

	-- 下单
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderIndex(
Index_Code, Index_PactCode, Index_EndUserID, Index_EndUserName, Index_From, Index_FromProvince, Index_FromCity, Index_FromDistrict, 
Index_FromTime, Index_To, Index_ToProvince, Index_ToCity, Index_ToDistrict, Index_ToTime, Index_TransportMode, Index_GoodsCategory, 
Index_PackageMode, Index_ChargeMode, Index_PriceUnit, Index_Status, Index_StatusTime, Index_SrcOrderID, Index_RootOrderID, 
Index_SrcClass, Index_CustomerID, Index_CustomerCompanyID, Index_Creator, Index_CreatorCompanyID, Index_CreateTime, Index_Pick, 
Index_Delivery, Index_CarType, Index_CarLength, Index_ShipMode, Index_OnLoad, Index_OffLoad, Index_Insurance, Index_VolumeAddition, 
Index_WeightAddition, Index_Description, Index_CarVolume, Index_CarWeight, Index_FromContact, Index_ToContact, Index_GoodsValue,Index_DeviceCode, Index_Payment, Index_Payable, Index_GoodsLst) SELECT @Code, Index_PactCode, @EndUserID, Index_EndUserName, Index_From, Index_FromProvince, 
Index_FromCity, Index_FromDistrict, Index_FromTime, Index_To, Index_ToProvince, Index_ToCity, Index_ToDistrict, Index_ToTime, 
Index_TransportMode, Index_GoodsCategory, Index_PackageMode, Index_ChargeMode, Index_PriceUnit, 0, GETDATE(), Index_ID, 
(CASE WHEN Index_RootOrderID IS NOT NULL AND Index_RootOrderID > 0 THEN Index_RootOrderID ELSE Index_ID END), @SrcClass, @CustomerID, 
@CompanyID, @Creator, @SupplierCompanyID, GETDATE(), Index_Pick, Index_Delivery, Index_CarType, Index_CarLength, @ShipMode, 
Index_OnLoad, Index_OffLoad, Index_Insurance, Index_VolumeAddition, Index_WeightAddition, Index_Description, Index_CarVolume, Index_CarWeight, Index_FromContact, 
Index_ToContact, Index_GoodsValue,Index_DeviceCode, Index_Payment, Index_Payable, Index_GoodsLst FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510031004;
		END
		ELSE
		BEGIN
			SET @SupplierOrderID = IDENT_CURRENT('TMS_OrderIndex');
		END
	END
	
	-- 订单附属表(TMS_OrderFlow)

	-- 订单附属表(TMS_OrderGoods)
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderGoods(GoodsLst_OrderID, GoodsLst_GoodsID, GoodsLst_Code, GoodsLst_Name, GoodsLst_Qty, GoodsLst_Weight, 
GoodsLst_Volume, GoodsLst_ReceiptQty, GoodsLst_ExceptionQty, GoodsLst_Unit, GoodsLst_BatchNo, GoodsLst_Price, GoodsLst_Creator, GoodsLst_InsertTime, GoodsLst_Invalid) SELECT 
@SupplierOrderID, GoodsLst_GoodsID, GoodsLst_Code, GoodsLst_Name, GoodsLst_Qty, GoodsLst_Weight, GoodsLst_Volume, GoodsLst_ReceiptQty, 
GoodsLst_ExceptionQty, GoodsLst_Unit, GoodsLst_BatchNo, GoodsLst_Price, @Creator, GETDATE(), 0 FROM TMS_OrderGoods WHERE GoodsLst_OrderID = @OrderID AND GoodsLst_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510031006;
		END
	END
	
	-- 订单创建后，自动执行运输计划
	IF @Result = 0
	BEGIN
		EXEC sp_prv_order_AutoPlan @Creator, @SupplierOrderID, 0, @Result = @Result OUTPUT, @DstOrderID = @DstOrderID OUTPUT;
	END
END
GO


