USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_EditOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_EditOrder]
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
CREATE PROCEDURE [dbo].[sp_prv_order_EditOrder]
(
	@Operator BIGINT,
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
	@Payable DECIMAL(18,2) = 0,		-- 到付费用
	@OrderID BIGINT OUTPUT,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	
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
	
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	IF @OrderID IS NULL OR @OrderID = 0
	BEGIN
		IF @SrcOrderID IS NULL OR @SrcOrderID = 0
		BEGIN
			-- 非拆单模式直接生成编号
			EXEC sp_pub_basic_GetSN 2, @SN = @Code OUTPUT;
		END
		ELSE
		BEGIN
			-- 拆单模式按原单据生成编号
			SELECT @Code = Index_Code FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014013;
			END
			ELSE
			BEGIN
				DECLARE @__Amount BIGINT;
				SET @__Amount = 0;
				
				SELECT @__Amount = COUNT(*) FROM TMS_OrderIndex WHERE Index_SrcOrderID = @SrcOrderID;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @__Amount = 0;
				END
				
				SET @__Amount = @__Amount + 1;
				SET @Code = @Code + '-' + CAST(@__Amount AS VARCHAR);
			END
		END
	END
	SET @RootOrderID = 0;
	SET @CustomerCompanyID = 0;
	SET @SupplierCompanyID = 0;
	SET @InsertMode = 0;
	IF @CarLength IS NULL
	BEGIN
		SET @CarLength = 0;
	END
	IF @SrcOrderID IS NULL
	BEGIN
		SET @SrcOrderID = 0;
	END
	IF @CustomerID IS NULL
	BEGIN
		SET @CustomerID = 0;
	END
	IF @SupplierID IS NULL
	BEGIN
		SET @SupplierID = 0;
	END
	IF @EndUserID IS NULL
	BEGIN
		SET @EndUserID = 0;
	END
	IF @DstStatus <> 1 AND @DstStatus <> 0
	BEGIN
		SET @DstStatus = 0;
	END
	IF @FromContact IS NULL
	BEGIN
		SET @FromContact = N'';
	END
	IF @ToContact IS NULL
	BEGIN
		SET @ToContact = N'';
	END
	SET @SetProvince = 0;
	SET @SetCity = 0;
	-- 当前存储过程工作模式
	/*
	1 拆单
	2 下单
	3 修改
	*/
	SET @Mode = 2;
	IF @SrcOrderID IS NOT NULL AND @SrcOrderID > 0
	BEGIN
		SET @Mode = 1;
	END
	IF @OrderID IS NOT NULL AND @OrderID > 0
	BEGIN
		SET @Mode = 3;
		SELECT @WeightAddition = Index_WeightAddition+@WeightAddition,@VolumeAddition=Index_VolumeAddition+@VolumeAddition FROM TMS_OrderIndex WHERE Index_ID = @OrderID;
	END
	SET @DstOrderID = 0;
	
	-- 拆单时长途、市内应按起始、截止点重新计算
	SET @ShipMode = dbo.fn_pub_order_CalcShipMode( @Operator, @CompanyID, @FromProvince, @FromCity, @ToProvince, @ToCity);
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510014001;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510014002;
	END

	-- 需要投保时货物总价值必须填写
	-- 拆单时不校验货物总价值
	IF @Result = 0 AND @Mode <> 1 AND @IsInsurance = 1 AND @GoodsValue = 0
	BEGIN
		SET @Result = -510014015;
	END

	-- 客户没有填(为0或为空,默认为自己公司)
	IF @Result = 0 AND (@CustomerID = 0 OR @CustomerID IS NULL)
	BEGIN
		SELECT @CustomerID = Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @CompanyID AND Customer_CompanyID = @CompanyID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014012;
		END
	END
	
	-- 客户标识是否存在
	IF @Result = 0 AND @CustomerSymbolID > 0
	BEGIN
		IF NOT EXISTS(SELECT Symbol_ID FROM TMS_MSymbol WHERE Symbol_ID = @CustomerSymbolID AND Symbol_Type = 1 AND Symbol_Invalid = 0)
		BEGIN
			SET @CustomerSymbolID = 0;
		END
	END
	
	-- EndUser是否存在[收货人必填]
	IF @Result = 0 AND NOT EXISTS(SELECT EndUser_ID FROM TMS_MEndUser WHERE EndUser_ID = @EndUserID AND EndUser_OwnerCompany = @CompanyID AND EndUser_Invalid = 0)
	BEGIN
		SET @Result = -510014003;
	END

	-- Customer是否存在
	IF @Result = 0
	BEGIN
		SELECT @CustomerCompanyID = Customer_CompanyID FROM TMS_MCustomer WHERE Customer_ID = @CustomerID AND Customer_OwnerCompany = @CompanyID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014004;
		END
	END

	-- 发货地址在客户常用地址中是否存在，不存在则自动追加，存在则修改联系电话等
	IF @Result = 0 AND @SrcOrderID = 0
	BEGIN
		SELECT @AddrID = Addr_ID FROM TMS_MAddr WHERE Addr_CustomerID = @CustomerID AND Addr_Type = 2 AND Addr_ProvinceID = @FromProvince AND Addr_CityID = @FromCity AND Addr_DistrictID = @FromDistrict AND Addr_Desc = @From;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @AddrID = 0;
		END

		EXEC sp_prv_my_EditAddr @Operator, @AddrID, @CustomerID, @From, 2, @FromProvince, @FromCity, @FromDistrict, 0, 1, @FromContact, @Result = @Result OUTPUT, @AddrID = @AddrID OUTPUT;
	END

	-- 收货地址在收货人常用地址中是否存在，不存在则自动追加，存在则修改联系电话等
	IF @Result = 0 
	BEGIN
		SELECT @AddrID = Addr_ID FROM TMS_MAddr WHERE Addr_CustomerID = @EndUserID AND Addr_Type = 1 AND Addr_ProvinceID = @ToProvince AND Addr_CityID = @ToCity AND Addr_DistrictID = @ToDistrict AND Addr_Desc = @To;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @AddrID = 0;
		END

		EXEC sp_prv_my_EditAddr @Operator, @AddrID, @EndUserID, @To, 1, @ToProvince, @ToCity, @ToDistrict, 0, 1, @ToContact, @Result = @Result OUTPUT, @AddrID = @AddrID OUTPUT;
	END
	
	-- 来源订单是否存在
	IF @Result = 0 AND @SrcOrderID > 0
	BEGIN
		SELECT @RootOrderID = Index_RootOrderID FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014005;
		END
		ELSE
		BEGIN
			IF @RootOrderID = 0
			BEGIN
				SET @RootOrderID = @SrcOrderID;
			END
		END
	END
	
	-- 编辑模式订单是否存在[只能编辑自己公司的订单]
	IF @Result = 0 AND @OrderID > 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0 ANd Index_CreatorCompanyID = @CompanyID)
	BEGIN
		SET @Result = -510014006;
	END
	
	-- 只能编辑状态为新单据\已计划的订单
	IF @Result = 0 AND @OrderID > 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND Index_Status <= 1)
	BEGIN
		SET @Result = -510014007;
	END

	-- 供应商是否存在
	IF @Result = 0 AND @SupplierID > 0
	BEGIN
		SELECT @SupplierCompanyID = Supplier_CompanyID FROM TMS_MSupplier WHERE Supplier_ID = @SupplierID AND Supplier_OwnerCompanyID = @CompanyID AND Supplier_Invalid = 0 AND Supplier_Status = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014010;
		END
	END

	-- 添加主单信息
	IF @Result = 0
	BEGIN
		IF @OrderID = 0 OR @OrderID IS NULL
		BEGIN
			INSERT INTO TMS_OrderIndex(Index_Code, Index_PactCode, Index_EndUserID, Index_EndUserName, 
Index_From, Index_FromProvince, Index_FromCity, Index_FromDistrict, Index_FromTime, 
Index_To, Index_ToProvince, Index_ToCity, Index_ToDistrict, Index_ToTime, 
Index_TransportMode, Index_GoodsCategory, Index_PackageMode, Index_ChargeMode, Index_PriceUnit, 
Index_Status, Index_StatusTime, Index_SrcOrderID, Index_RootOrderID, Index_SrcClass, Index_Kms, Index_CarType, Index_CarLength, 
Index_SupplierID, Index_SupplierCompanyID, Index_CustomerID, Index_CustomerCompanyID, Index_ShipMode, Index_Pick, Index_Delivery, 
Index_Creator, Index_CreatorCompanyID, Index_CreateTime, Index_Invalid, Index_OnLoad, Index_OffLoad, 
Index_Insurance, Index_VolumeAddition, Index_WeightAddition, Index_Description, Index_CarVolume, Index_CarWeight, Index_CustomerSymbolID,
Index_FromContact, Index_ToContact,Index_DeviceCode,Index_Payment, Index_Payable) VALUES(@Code, @PactCode, @EndUserID, dbo.fn_pub_user_EndUser2Name(@EndUserID), @From, @FromProvince, @FromCity, @FromDistrict, 
(CASE WHEN @FromTime IS NULL THEN '' ELSE @FromTime END), @To, @ToProvince, @ToCity, @ToDistrict, 
(CASE WHEN @ToTime IS NULL THEN '' ELSE @ToTime END),@TransportMode, @GoodsCategory, @PackageMode, @ChargeMode, @PriceUnit, @DstStatus, 
GETDATE(), @SrcOrderID, @RootOrderID, @SrcClass, @Kms, @CarType, @CarLength, 0, 0, @CustomerID, 
@CustomerCompanyID, @ShipMode, @IsPick, @IsDelivery, @Operator, @CompanyID, GETDATE(), 0, @IsOnLoad, @IsOffLoad, @IsInsurance, @VolumeAddition, 
@WeightAddition, @Descriptions, @CarVolume, @CarWeight, @CustomerSymbolID, @FromContact, @ToContact, @DeviceCode, @Payment, @Payable);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014008;
			END
			ELSE
			BEGIN
				SET @OrderID = IDENT_CURRENT('TMS_OrderIndex');
				
				-- 新建订单的根订单编号是自己
				UPDATE TMS_OrderIndex SET Index_RootOrderID = (CASE WHEN Index_RootOrderID IS NULL OR Index_RootOrderID = 0 THEN @OrderID ELSE Index_RootOrderID END) WHERE Index_ID = @OrderID AND Index_SrcOrderID = 0;
				
				SET @InsertMode = 1;
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_OrderIndex SET Index_PactCode = @PactCode, Index_EndUserID = @EndUserID, Index_EndUserName = dbo.fn_pub_user_EndUser2Name(@EndUserID),
Index_From = @From, Index_FromProvince= @FromProvince, Index_FromCity = @FromCity, Index_FromDistrict = @FromDistrict, Index_FromTime = (CASE WHEN @FromTime IS NULL THEN '' ELSE @FromTime END), 
Index_To = @To, Index_ToProvince = @ToProvince, Index_ToCity = @ToCity, Index_ToDistrict = @ToDistrict, Index_ToTime = (CASE WHEN @ToTime IS NULL THEN '' ELSE @ToTime END), 
Index_TransportMode = @TransportMode, Index_GoodsCategory = @GoodsCategory, Index_PackageMode = @PackageMode, Index_ChargeMode = @ChargeMode, Index_PriceUnit = @PriceUnit, 
-- 郭红亮 2016-07-30
-- 编辑时不能修改源订单\根订单
-- Index_SrcOrderID = @SrcOrderID, Index_RootOrderID = (CASE WHEN @RootOrderID IS NULL OR @RootOrderID = 0 THEN @OrderID ELSE @RootOrderID END), 
Index_Kms = @Kms, Index_CarType = @CarType, Index_CarLength = @CarLength, 
Index_CustomerID = @CustomerID, Index_CustomerCompanyID = @CustomerCompanyID, Index_ShipMode = @ShipMode, Index_Pick = @IsPick,
Index_OnLoad = @IsOnLoad, Index_OffLoad = @IsOffLoad, Index_Delivery = @IsDelivery, Index_SupplierID = 0, Index_SupplierCompanyID = 0, 
Index_Insurance = @IsInsurance, Index_VolumeAddition = @VolumeAddition, Index_WeightAddition = @WeightAddition, Index_Description = @Descriptions, Index_CarVolume = @CarVolume, 
Index_CarWeight = @CarWeight, Index_CustomerSymbolID = @CustomerSymbolID, Index_FromContact = @FromContact, Index_ToContact = @ToContact , Index_Payment = @Payment, Index_Payable = @Payable WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014009;
			END
		END
	END
	
	-- 添加时追加物品信息
	IF @Result = 0 AND @InsertMode = 1
	BEGIN
		IF @_Version < 3 AND @SrcOrderID > 0 AND LEN(@GoodsLst) > 0
		BEGIN
			-- 物品信息样式
			-- goodid1=goodamount1,goodid2=goodamount2
			INSERT INTO TMS_OrderGoods(GoodsLst_OrderID, GoodsLst_GoodsID, GoodsLst_Code, GoodsLst_Name, GoodsLst_Qty, 
	GoodsLst_Weight, GoodsLst_Volume, GoodsLst_Unit, GoodsLst_BatchNo, GoodsLst_Price, GoodsLst_Creator, GoodsLst_InsertTime, GoodsLst_Invalid) 
	SELECT @OrderID, A.GoodsLst_GoodsID AS Goods_ID, A.GoodsLst_Code, A.GoodsLst_Name, B.Amount AS Goods_Amount, 
	dbo.fn_pub_order_GoodsWeight(A.GoodsLst_GoodsID, B.Amount) AS Goods_Weight, 
	dbo.fn_pub_order_GoodsVolume(A.GoodsLst_GoodsID, B.Amount) AS Goods_Volume, 
	A.GoodsLst_Unit, A.GoodsLst_BatchNo, A.GoodsLst_Price, @Operator, GETDATE(), 0 FROM TMS_OrderGoods AS A 
	INNER JOIN (SELECT  [value] = CONVERT(XML , '<v>' + REPLACE(@GoodsLst , ',' , '</v><v>') + '</v>')) C 
	CROSS APPLY (SELECT ID = SUBSTRING(N.v.value('.' , 'varchar(100)'), 1, charindex( '=', N.v.value('.' , 'varchar(100)')) - 1 ), Amount = SUBSTRING(N.v.value('.' , 'varchar(100)'), charindex( '=', N.v.value('.' , 'varchar(100)')) + 1, LEN(N.v.value('.' , 'varchar(100)'))) FROM C.[value].nodes('/v') N ( v ) ) B 
	ON A.GoodsLst_ID = B.ID WHERE A.GoodsLst_OrderID = (CASE WHEN @PrevOrderID IS NOT NULL AND @PrevOrderID > 0 THEN @PrevOrderID ELSE @SrcOrderID END) AND B.Amount > 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014011;
			END
		END
		IF @_Version >= 3 AND LEN(@GoodsLst) > 0
		BEGIN
			/*
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
			DECLARE @XmlDocId INT;
			SET @XmlDocId = 0;
			
			EXEC SP_XML_PREPAREDOCUMENT @XmlDocId OUTPUT, @GoodsLst;
			INSERT TMS_OrderGoods(GoodsLst_OrderID, GoodsLst_GoodsID, GoodsLst_Code, GoodsLst_Name, GoodsLst_Qty, GoodsLst_Weight, GoodsLst_Volume, GoodsLst_Creator, 
GoodsLst_Unit, GoodsLst_BatchNo, GoodsLst_Price) SELECT @OrderID, [ID], Code, Name, Qty, [Weight], Volume, @Operator, Unit, BatchNo, Price FROM 
OPENXML(@XmlDocId, '/Lst/Goods', 2) WITH (
	[ID] BIGINT,
	Code NVARCHAR(100),
	Name NVARCHAR(200),
	Qty DECIMAL(18, 2),
	[Weight] DECIMAL(18,4),
	Volume DECIMAL(18,6),
	Unit BIGINT,
	BatchNo NVARCHAR(100),
	Price DECIMAL(18,2)
);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014019;
			END

			EXEC SP_XML_REMOVEDOCUMENT @XmlDocId;
		END
	END
	
	-- 货物总价值
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_GoodsValue = @GoodsValue, Index_GoodsLst = STUFF((select '; '+A.GOODSLST from (SELECT GoodsLst_Name+'(数量：'+CAST (LTRIM(CAST(GoodsLst_Qty as float))  AS NVARCHAR )+')' AS GOODSLST FROM TMS_OrderGoods WHERE  GoodsLst_OrderID = @OrderID) A FOR xml PATH('')), 1, 1, '') WHERE Index_ID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014014;
		END
	END

	-- 版本3以上执行自动计划, 之前的版本通过协议调用
	IF @Result = 0 AND @_Version >= 3 AND LEN(@GoodsLst) > 0
	BEGIN
		EXEC sp_prv_order_AutoPlan @Operator, @OrderID, 0, @Result = @Result OUTPUT, @DstOrderID = @DstOrderID OUTPUT;
	END
	
	-- 版本3以上自动将计划后的运输订单@DstOrderID调度给@SupplierID
	IF @Result = 0 AND @_Version >= 3 AND @DstOrderID > 0 AND @SupplierID > 0
	BEGIN
		EXEC sp_prv_order_SendOrder @Operator, @DstOrderID, @SupplierID, 0, 0, 0, @Result = @Result OUTPUT;
	END
	
	-- 郭红亮 2016-07-27
	-- 2以上版本时启用，拆单时保存来源运输订单
	IF @Result = 0 AND @Mode = 1 AND @_Version >= 2
	BEGIN
		UPDATE TMS_OrderIndex SET Index_PrevOrderID = @PrevOrderID WHERE Index_ID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014016;
		END
	END
	
	-- 郭红亮 2016-07-29
	-- 2以上版本启用，拆单时将原单置为无效
	IF @Result = 0 AND @Mode = 1 AND @PrevOrderID > 0 AND @_Version >= 2
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = 32, Index_StatusTime = GETDATE() WHERE Index_ID = @PrevOrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014017;
		END
		
		-- 写订单状态变更记录
		IF @Result = 0
		BEGIN
			INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_InsertTime, Flow_CompanyID, Flow_Invalid,Flow_Description) VALUES(@PrevOrderID, 1, 32, @Operator, GETDATE(), @CompanyID, 0,'拆单');
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014018;
			END
		END
	END


	IF @_Version >= 3
	BEGIN
		SELECT @Result AS Order_Result, @OrderID AS Order_ID, @DstOrderID AS Order_DstID;
	END
	ELSE
	IF @_Version < 3 AND @Mode = 1
	BEGIN
		SELECT @Result AS Order_Result, @OrderID AS Order_ID;
	END

	
END





GO


