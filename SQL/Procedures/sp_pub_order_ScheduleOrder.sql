USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_ScheduleOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_ScheduleOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 订单调度
CREATE PROCEDURE [dbo].[sp_pub_order_ScheduleOrder]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@SupplierID BIGINT,
	@DriverID BIGINT,
	@CarID BIGINT,
	@SupplierSymbolID BIGINT = 0,
	@PactCode NVARCHAR(100),

	@SrcClass BIGINT,
	@GoodsLst NVARCHAR(MAX) = N'',
	@TxnRequired TINYINT = 1,
	@CustomerID BIGINT,
	@SrcOrderID BIGINT,
	@EndUserID BIGINT,
	@From NVARCHAR(600),
	@FromProvince BIGINT = 0,
	@FromCity BIGINT = 0,
	@FromDistrict BIGINT = 0,
	@FromTime DATETIME = NULL,
	@To NVARCHAR(600),
	@ToProvince BIGINT = 0,
	@ToCity BIGINT = 0,
	@ToDistrict BIGINT = 0,
	@ToTime DATETIME = NULL,
	@TransportMode BIGINT = 0,
	@GoodsCategory BIGINT = 0,
	@PackageMode BIGINT = 0,
	@ChargeMode BIGINT = 0,
	@PriceUnit BIGINT = 0,
	@Kms BIGINT = 0,
	@CarType BIGINT = 0,            -- 车型(枚举值)
	@CarLength DECIMAL(18,2) = 0,
	@ShipMode BIGINT = 0,
	@IsPick BIGINT = 0,
	@IsOnLoad BIGINT = 0,
	@IsOffLoad BIGINT = 0,
	@IsDelivery BIGINT = 0,
	@DstStatus BIGINT = 0,
	@IsInsurance BIGINT = 0,
	@VolumeAddition DECIMAL(18,6) = 0,			-- 体积补差
	@WeightAddition DECIMAL(18,4) = 0,			-- 重量补差
	@Descriptions NVARCHAR(MAX) = N'',
	@CarVolume DECIMAL(18,6) = 0,
	@CarWeight DECIMAL(18,4) = 0,
	@CustomerSymbolID BIGINT = 0,
	@FromContact NVARCHAR(300) = N'',
	@ToContact NVARCHAR(300) = N'',
	@GoodsValue DECIMAL(18,2) = 0,	-- 货物总价值
	@PrevOrderID BIGINT = 0,		-- 多次拆单时的前置订单号
	@_Version BIGINT = 1 ,			-- 调用存储过程的哪个版本号
	@Payment DECIMAL(18,2),			-- 预付
	@Payable DECIMAL(18,2),			-- 到付
	@DeviceCode NVARCHAR(50) = N''  -- 绑定设备编号
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
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
	
	BEGIN TRANSACTION;

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

	IF @Result = 0 
	BEGIN
		EXEC sp_prv_order_EditOrder @Operator = @Operator,@PactCode = @PactCode,@EndUserID = @EndUserID,@From= @From,@To = @To,@SrcOrderID = @SrcOrderID,@CustomerID = @CustomerID,@SupplierID = @SupplierID,@GoodsLst = @GoodsLst,@TxnRequired = 1,
@FromProvince = @FromProvince, @FromCity = @FromCity, @FromDistrict =@FromDistrict, @FromTime =@FromTime,@ToProvince = @ToProvince,@ToCity = @ToCity, @ToDistrict = @ToDistrict,@ToTime = @ToTime,@TransportMode = @TransportMode,@GoodsCategory = @GoodsCategory,@PackageMode = @PackageMode, @ChargeMode = @ChargeMode,@PriceUnit = @PriceUnit,@SrcClass = @SrcClass,@Kms = @Kms,@CarType = @CarType,@CarLength = @CarLength,@ShipMode = @ShipMode,@IsPick = @IsPick,@IsDelivery = @IsDelivery,@DstStatus = @DstStatus,@IsOnLoad = @IsOnLoad ,@IsOffLoad =@IsOffLoad,@IsInsurance = @IsInsurance,@VolumeAddition = @VolumeAddition,@WeightAddition = @WeightAddition,@Descriptions = @Descriptions,@CarVolume = @CarVolume,@CarWeight = @CarWeight,@CustomerSymbolID = @CustomerSymbolID,@FromContact = @FromContact,@ToContact = @ToContact,@GoodsValue = @GoodsValue,@PrevOrderID = @PrevOrderID,@_Version = @_Version,@DeviceCode = @DeviceCode,@Payment = @Payment,@Payable = @Payable,@OrderID = @OrderID OUTPUT,@Result = @Result OUTPUT;
	END
	
	IF @Result = 0
	BEGIN
	 EXEC sp_prv_order_ScheduleOrder @Operator,@OrderID,@SupplierID,@DriverID,@CarID,@VolumeAddition,@WeightAddition,@SupplierSymbolID,@PactCode,@Result = @Result OUTPUT;
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


