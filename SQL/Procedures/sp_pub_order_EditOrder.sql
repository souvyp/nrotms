USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_EditOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_EditOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
添加或编辑订单

Status的可能值：
 0 新单据
 1 已计划
 2 已调度
 4 已签收
 8 已回单
16 已结账

@_Version = 1相关功能与sp_prv_order_TransportPlan_V1配套, 适合运输计划手动执行的情况

@_Version = 2相关功能与sp_prv_order_TransportPlan_V2配套, 适合运输计划自动执行且允许多次拆单的情况
当前模式为拆单时，@GoodsLst的格式：
goodid1=goodamount1,goodid2=goodamount2

@_Version >= 3时下单或拆单时(不含修改订单)，@GoodsLst的格式：
<Lst>
	<Goods>
		<ID>88</ID>
		<Code>2016042200226</Code>
		<Name>钢筋</Name>
		<Qty>1</Qty>
		<Weight>1.2000</Weight>
		<Volume>2.000000</Volume>
		<Unit>2</Unit>
		<BatchNo>w</BatchNo>
		<Price>14</Price>
	</Goods>
</Lst>
*/
CREATE PROCEDURE [dbo].[sp_pub_order_EditOrder]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@PactCode NVARCHAR(100),
	@EndUserID BIGINT,
	@From NVARCHAR(600),
	@To NVARCHAR(600),
	@SrcOrderID BIGINT,
	@CustomerID BIGINT = 0,			-- 客户编号不填(默认为自己公司)
	@SupplierID BIGINT,
	@GoodsLst NVARCHAR(MAX) = N'',
	@TxnRequired TINYINT = 1,
	@FromProvince BIGINT = 0,		-- 发货省
	@FromCity BIGINT = 0,			-- 发货市
	@FromDistrict BIGINT = 0,		-- 发货区
	@FromTime DATETIME = NULL,		-- 发货时间
	@ToProvince BIGINT = 0,			-- 到货省
	@ToCity BIGINT = 0,				-- 到货市
	@ToDistrict BIGINT = 0,			-- 到货区
	@ToTime DATETIME = NULL,		-- 到货时间
	@TransportMode BIGINT = 0,		-- 运输模式，1 零担 2 整车 3 空运 4 快递 5 铁路 6 海运
	@GoodsCategory BIGINT = 0,		-- 货物分类，1 普通货物 2 危险品 4 温控获取，允许使用or
	@PackageMode BIGINT = 0,		-- 包装方式，1 散箱(可堆叠，人工装卸) 2 托盘或木箱(可堆叠，叉车装卸) 3 托盘、木箱或不规则形状，不可堆叠，叉车装卸
	@ChargeMode BIGINT = 0,			-- 计费模式，1 体积 2 重量
	@PriceUnit BIGINT = 0,			-- 价格单位，1 公斤 2 吨 3 立方 4 升
	@SrcClass BIGINT = 1,			-- 来源类型，1 客户订单 2 运输订单
	@Kms BIGINT = 0,				-- 总公里数
	@CarType BIGINT = 0,            -- 车型(枚举值)
	@CarLength DECIMAL(18,2) = 0,	-- 车长/规格(枚举值)
	@ShipMode BIGINT = 0,			-- 运输模式，1 市内 2 长途
	@IsPick BIGINT = 0,				-- 是否提货
	@IsDelivery BIGINT = 0,			-- 是否送货
	@DstStatus BIGINT = 0,			-- 目标订单状态
	@IsOnLoad BIGINT = 0,			-- 是否装货
	@IsOffLoad BIGINT = 0,			-- 是否卸货
	@IsInsurance BIGINT = 0,		-- 是否保价
	@VolumeAddition DECIMAL(18,6) = 0,			-- 体积补差
	@WeightAddition DECIMAL(18,4) = 0,			-- 重量补差
	@Descriptions NVARCHAR(MAX) = N'',
	@CarVolume DECIMAL(18,6) = 0,	-- 车辆容积
	@CarWeight DECIMAL(18,4) = 0,	-- 车辆载重
	@CustomerSymbolID BIGINT = 0,	-- 客户标识(供线下客户使用)
	@FromContact NVARCHAR(300) = N'',			-- 发货联系信息
	@ToContact NVARCHAR(300) = N'',				-- 收货联系信息
	@GoodsValue DECIMAL(18,2) = 0,	-- 货物总价值
	@PrevOrderID BIGINT = 0,		-- 多次折单时的前置订单号
	@_Version BIGINT = 1 ,			-- 调用存储过程的哪个版本号
	@DeviceCode NVARCHAR(50) = N'',  -- 绑定设备编号
	@Payment DECIMAL(18,2) = 0,		-- 预付费用
	@Payable DECIMAL(18,2) = 0		-- 到付费用
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @RootOrderID BIGINT;
	DECLARE @CustomerCompanyID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	DECLARE @Code NVARCHAR(100);
	DECLARE @InsertMode TINYINT;
	DECLARE @AddrID BIGINT;
	DECLARE @SetProvince BIGINT;
	DECLARE @SetCity BIGINT;
	DECLARE @Mode BIGINT;
	DECLARE @DstOrderID BIGINT;
	SET @AddrID = 0;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	BEGIN
		EXEC sp_prv_order_EditOrder @Operator = @Operator,@PactCode = @PactCode,@EndUserID = @EndUserID,@From= @From,@To = @To,@SrcOrderID = @SrcOrderID,@CustomerID = @CustomerID,@SupplierID = @SupplierID,@GoodsLst = @GoodsLst,@TxnRequired = 1,@FromProvince = @FromProvince, @FromCity = @FromCity, @FromDistrict =@FromDistrict, @FromTime =@FromTime,@ToProvince = @ToProvince,@ToCity = @ToCity, @ToDistrict = @ToDistrict,@ToTime = @ToTime,@TransportMode = @TransportMode,@GoodsCategory = @GoodsCategory,@PackageMode = @PackageMode, @ChargeMode = @ChargeMode,@PriceUnit = @PriceUnit,@SrcClass = @SrcClass,@Kms = @Kms,@CarType = @CarType,@CarLength = @CarLength,@ShipMode = @ShipMode,@IsPick = @IsPick,@IsDelivery = @IsDelivery,@DstStatus = @DstStatus,@IsOnLoad = @IsOnLoad ,@IsOffLoad =@IsOffLoad,@IsInsurance = @IsInsurance,@VolumeAddition = @VolumeAddition,@WeightAddition = @WeightAddition,@Descriptions = @Descriptions,@CarVolume = @CarVolume,@CarWeight = @CarWeight,@CustomerSymbolID = @CustomerSymbolID,@FromContact = @FromContact,@ToContact = @ToContact,@GoodsValue = @GoodsValue,@PrevOrderID = @PrevOrderID,@_Version = @_Version,@DeviceCode = @DeviceCode,@Payment = @Payment,@Payable = @Payable,@OrderID = @OrderID OUTPUT,@Result = @Result OUTPUT;
	END

	IF @TxnRequired = 1
	BEGIN
		IF @Result = 0
		BEGIN
			COMMIT TRANSACTION;
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION;
		END
	END

	IF @_Version >= 3
	BEGIN
		SELECT @Result AS Order_Result, @OrderID AS Order_ID, @DstOrderID AS Order_DstID;
	END
	ELSE
	BEGIN
		SELECT @Result AS Order_Result, @OrderID AS Order_ID;
	END

	SET NOCOUNT OFF;
END





GO


