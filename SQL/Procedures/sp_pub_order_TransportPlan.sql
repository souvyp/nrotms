USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_TransportPlan]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_TransportPlan]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- 运输计划
/*
拆地址参数：
fp1,fc1,fd1,from1,tp1,tc1,td1,to1,time1,eu1,fcnt1,tcnt1|fp2,fc2,fd2,from2,tp2,tc2,td2,to2,time2,eu2,fcnt2,tcnt2
*fp = from province, fc = from city, fd = from district, fcnt = from contact
*tp = to province, tc = to city, td = to district, tcnt = to contact
*eu = end user id

拆物品参数
goodid1=2,goodid2=1;goodid11=1
*/
CREATE PROCEDURE [dbo].[sp_pub_order_TransportPlan]
(
	@Operator BIGINT,	
	@SrcOrderID BIGINT,	
	@AddrLst NVARCHAR(MAX),	
	@GoodsLst NVARCHAR(MAX),	
	@_Version BIGINT = 0,	
	@TransType TINYINT ,   -- 1 拆线路 2 拆数量	
	@SupplierID BIGINT,	
	@DriverID BIGINT,	
	@CarID BIGINT,	
	@SupplierSymbolID BIGINT = 0,	
	@PactCode NVARCHAR(100),	
	@SrcClass BIGINT,	
	@TxnRequired TINYINT = 1,	
	@CustomerID BIGINT,	
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
	@VolumeAddition DECIMAL(18,6) = 0,	
	@WeightAddition DECIMAL(18,4) = 0,	
	@Descriptions NVARCHAR(MAX) = N'',	
	@CarVolume DECIMAL(18,6) = 0,	
	@CarWeight DECIMAL(18,4) = 0,	
	@CustomerSymbolID BIGINT = 0,	
	@FromContact NVARCHAR(300) = N'',	
	@ToContact NVARCHAR(300) = N'',	
	@GoodsValue DECIMAL(18,2) = 0,	
	@PrevOrderID BIGINT = 0,	
	@DeviceCode NVARCHAR(50) = N'',  -- 绑定设备编号
	@Payment DECIMAL(18,2) = 0,		-- 预付费用
	@Payable DECIMAL(18,2) = 0		-- 到付费用	

)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Result BIGINT;
	SET @Result = 0;
	

	BEGIN TRANSACTION;
	
	BEGIN
		EXEC sp_prv_order_EditOrder @Operator = @Operator,@PactCode = @PactCode,@EndUserID = @EndUserID,@From= @From,@To = @To,@SrcOrderID = @SrcOrderID,@CustomerID = @CustomerID,@SupplierID = @SupplierID,@GoodsLst = @GoodsLst,@TxnRequired = 1,
@FromProvince = @FromProvince, @FromCity = @FromCity, @FromDistrict =@FromDistrict, @FromTime =@FromTime,@ToProvince = @ToProvince,@ToCity = @ToCity, @ToDistrict = @ToDistrict,@ToTime = @ToTime,@TransportMode = @TransportMode,@GoodsCategory = @GoodsCategory,@PackageMode = @PackageMode, @ChargeMode = @ChargeMode,@PriceUnit = @PriceUnit,@SrcClass = @SrcClass,@Kms = @Kms,@CarType = @CarType,@CarLength = @CarLength,@ShipMode = @ShipMode,@IsPick = @IsPick,@IsDelivery = @IsDelivery,@DstStatus = @DstStatus,@IsOnLoad = @IsOnLoad ,@IsOffLoad =@IsOffLoad,@IsInsurance = @IsInsurance,@VolumeAddition = @VolumeAddition,@WeightAddition = @WeightAddition,@Descriptions = @Descriptions,@CarVolume = @CarVolume,@CarWeight = @CarWeight,@CustomerSymbolID = @CustomerSymbolID,@FromContact = @FromContact,@ToContact = @ToContact,@GoodsValue = @GoodsValue,@PrevOrderID = @PrevOrderID,@_Version = @_Version,@DeviceCode = @DeviceCode,@Payment = @Payment,@Payable = @Payable,@OrderID = @SrcOrderID OUTPUT,@Result = @Result OUTPUT;
	END
	
	IF @_Version <= 1 AND @Result = 0
	BEGIN
		EXEC sp_prv_order_TransportPlan_V1 @Operator, @SrcOrderID, @AddrLst, @GoodsLst, 0, @Result = @Result OUTPUT;
	END
	ELSE IF @_Version = 2  AND @Result = 0
	BEGIN
		EXEC sp_prv_order_TransportPlan_V2 @Operator, @SrcOrderID, @AddrLst, @GoodsLst, 0,@TransType, @Result = @Result OUTPUT;
	END
	ELSE IF  @Result = 0
	BEGIN
		-- 不支持的版本号
		SET @Result = -510025000;
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


