USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_TransportPlan_V1]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_TransportPlan_V1]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 运输计划
/*
V1版本描述：
1、拆单源头是客户订单
2、只能拆一次
3、支持按地址、按物品数量拆单

拆地址参数：
fp1,fc1,fd1,from1,tp1,tc1,td1,to1,time1,eu1,fcnt1,tcnt1|fp2,fc2,fd2,from2,tp2,tc2,td2,to2,time2,eu2,fcnt2,tcnt2
*fp = from province, fc = from city, fd = from district, fcnt = from contact
*tp = to province, tc = to city, td = to district, tcnt = to contact
*eu = end user id

拆物品参数
goodid1=2,goodid2=1;goodid11=1
*/
CREATE PROCEDURE [dbo].[sp_prv_order_TransportPlan_V1]
(
	@Operator BIGINT,
	@SrcOrderID BIGINT,
	@AddrLst NVARCHAR(MAX),
	@GoodsLst NVARCHAR(MAX),
	@TxnRequired BIGINT = 0,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	DECLARE @SrcCode NVARCHAR(100);
	DECLARE @PactCode NVARCHAR(100)
	DECLARE @EndUserID BIGINT;
	DECLARE @CustomerID BIGINT;
	DECLARE @FromTime DATETIME;
	DECLARE @ToTime DATETIME;
	DECLARE @TransportMode BIGINT;
	DECLARE @GoodsCategory BIGINT;
	DECLARE @PackageMode BIGINT;
	DECLARE @ChargeMode BIGINT;
	DECLARE @PriceUnit BIGINT;
	DECLARE @CarType BIGINT;
	DECLARE @CarLength DECIMAL(18,2);
	DECLARE @CarVolume DECIMAL(18,6);
	DECLARE @CarWeight DECIMAL(18,4);
	DECLARE @ShipMode BIGINT;
	DECLARE @IsPick BIGINT;
	DECLARE @IsDelivery BIGINT;
	DECLARE @IsOnLoad BIGINT;
	DECLARE @IsOffLoad BIGINT;
	DECLARE @IsInsurance BIGINT;
	DECLARE @VolumeAddition DECIMAL(18,6);
	DECLARE @WeightAddition DECIMAL(18,4);
	DECLARE @Description NVARCHAR(MAX);
	DECLARE @FromContact NVARCHAR(300);
	DECLARE @ToContact NVARCHAR(300);
	DECLARE @RootOrderID BIGINT;
	DECLARE @GoodsValue DECIMAL(18,2);
	SET @RootOrderID = 0;
	SET @Result = 0;
	SET @SrcCode = N'';
	SET @PactCode = N'';
	SET @EndUserID = 0;
	SET @CustomerID = 0;
	SET @FromTime = '';
	SET @ToTime = '';
	SET @TransportMode = 0;
	SET @GoodsCategory = 0;
	SET @PackageMode = 0;
	SET @ChargeMode = 0;
	SET @PriceUnit = 0;
	SET @CarType = 0;
	SET @CarLength = 0;
	SET @CarVolume = 0;
	SET @CarWeight = 0;
	SET @ShipMode = 0;
	SET @IsPick = 0;
	SET @IsDelivery = 0;
	SET @IsOnLoad = 0;
	SET @IsOffLoad = 0;
	SET @IsInsurance = 0;
	SET @VolumeAddition = 0;
	SET @WeightAddition = 0;
	SET @Description = N'';
	SET @FromContact = N'';
	SET @ToContact = N'';
	SET @GoodsValue = 0;
	
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510025001;
	END
	
	-- 当前用户没有拆单的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510025002;
	END
	
	-- 来源订单是否存在(只有客户订单允许创建计划)
	IF @Result = 0
	BEGIN
		SELECT @SrcCode = Index_Code, @PactCode = Index_PactCode, @EndUserID = Index_EndUserID, @CustomerID = Index_CustomerID, @FromTime = Index_FromTime, @ToTime = Index_ToTime, @TransportMode = Index_TransportMode, @GoodsCategory = Index_GoodsCategory, @PackageMode = Index_PackageMode, @ChargeMode = Index_ChargeMode, @PriceUnit = Index_PriceUnit, @CarType = Index_CarType, @CarLength = Index_CarLength, @CarVolume = Index_CarVolume, @CarWeight = Index_CarWeight, @ShipMode = Index_ShipMode, @IsPick = Index_Pick, @IsDelivery = Index_Delivery, @IsOnLoad = Index_OnLoad, @IsOffLoad = Index_OffLoad, @IsInsurance = Index_Insurance, @VolumeAddition = Index_VolumeAddition, @WeightAddition = Index_WeightAddition, @Description = Index_Description, @FromContact = Index_FromContact, @ToContact = Index_ToContact, @RootOrderID = Index_RootOrderID, @GoodsValue = Index_GoodsValue FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_SrcClass = 1 AND Index_Status = 0 AND Index_Invalid = 0 AND Index_CreatorCompanyID = @CompanyID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510025003;
		END
	END
	
	-- 拆单结果
	DECLARE @tblRlt TABLE
	(
		T_Result BIGINT,
		T_OrderID BIGINT
	);

	-- 是否拆成多个订单(>=2)
	IF LEN(@AddrLst) > 0 OR LEN(@GoodsLst) > 0
	BEGIN
		-- 解析拆单参数，并执行拆单
		IF @Result = 0
		BEGIN
			DECLARE @Addr_FromProvince BIGINT;
			DECLARE @Addr_FromCity BIGINT;
			DECLARE @Addr_FromDistrict BIGINT;
			DECLARE @Addr_ToProvince BIGINT;
			DECLARE @Addr_ToCity BIGINT;
			DECLARE @Addr_ToDistrict BIGINT;
			DECLARE @Addr_From NVARCHAR(600);
			DECLARE @Addr_To NVARCHAR(600);
			DECLARE @Addr_Time DATETIME;
			DECLARE @Addr_EndUserID BIGINT;
			DECLARE @A_Lst NVARCHAR(600);
			DECLARE @_From DATETIME;				-- 临时缓存拆单发货时间
			DECLARE @_To DATETIME;					-- 临时缓存拆单收货时间
			DECLARE @Addr_FromContact NVARCHAR(300);
			DECLARE @Addr_ToContact NVARCHAR(300);
			SET @Addr_FromProvince = 0;
			SET @Addr_FromCity = 0;
			SET @Addr_FromDistrict = 0;
			SET @Addr_ToProvince = 0;
			SET @Addr_ToCity = 0;
			SET @Addr_ToDistrict = 0;
			SET @Addr_From = N'';
			SET @Addr_To = N'';
			SET @Addr_Time = '';
			SET @Addr_EndUserID = 0;
			SET @A_Lst = N'';
			SET @_From = @FromTime;
			SET @_To = '';
			SET @Addr_FromContact = N'';
			SET @Addr_ToContact = N'';

			DECLARE paras_cursor CURSOR LOCAL FOR SELECT a.Addr_FromProvince, a.Addr_FromCity, a.Addr_FromDistrict, a.Addr_From, a.Addr_ToProvince, a.Addr_ToCity, a.Addr_ToDistrict, a.Addr_To, a.Addr_Time, B.A_Lst, a.Addr_EndUserID, a.Addr_FromContact, a.Addr_ToContact FROM dbo.fn_pub_order_AddrLst2Tbl( @AddrLst ) AS A CROSS APPLY dbo.fn_pub_order_GoodsLst2Tbl( @GoodsLst ) AS B;
			OPEN paras_cursor;
			
			FETCH NEXT FROM paras_cursor INTO @Addr_FromProvince, @Addr_FromCity, @Addr_FromDistrict, @Addr_From, @Addr_ToProvince, @Addr_ToCity, @Addr_ToDistrict, @Addr_To, @Addr_Time, @A_Lst, @Addr_EndUserID, @Addr_FromContact, @Addr_ToContact;
			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF @Addr_Time = ''
				BEGIN
					SET @_To = @ToTime;
				END
				ELSE
				BEGIN
					SET @_To = @Addr_Time;
				END
				IF @Addr_EndUserID IS NULL OR @Addr_EndUserID = 0
				BEGIN
					SET @Addr_EndUserID = @EndUserID;
				END
				IF @Addr_FromContact IS NULL
				BEGIN
					SET @Addr_FromContact = N'';
				END
				IF @Addr_ToContact IS NULL
				BEGIN
					SET @Addr_ToContact = N'';
				END

				-- 下单存储过程中会对收发货地址进行处理
				INSERT INTO @tblRlt EXEC sp_pub_order_EditOrder @Operator, 0, @PactCode, @Addr_EndUserID, @Addr_From, @Addr_To, @SrcOrderID, @CustomerID, 0, @A_Lst, 0, @Addr_FromProvince, @Addr_FromCity, @Addr_FromDistrict, @_From, @Addr_ToProvince, @Addr_ToCity, @Addr_ToDistrict, @_To, @TransportMode, @GoodsCategory, @PackageMode, @ChargeMode, @PriceUnit, 2, 0, @CarType, @CarLength, @ShipMode, @IsPick, @IsDelivery, 1, @IsOnLoad, @IsOffLoad, @IsInsurance, @VolumeAddition, @WeightAddition, @Description, @CarVolume, @CarWeight, 0, @Addr_FromContact, @Addr_ToContact, @GoodsValue, 0, 1;
				
				-- 出错则退出游标循环
				SELECT TOP 1 @Result = T_Result FROM @tblRlt WHERE T_Result <> 0;
				IF @@ROWCOUNT > 0
				BEGIN
					BREAK;
				END

				SET @_From = @_To;
				FETCH NEXT FROM paras_cursor INTO @Addr_FromProvince, @Addr_FromCity, @Addr_FromDistrict, @Addr_From, @Addr_ToProvince, @Addr_ToCity, @Addr_ToDistrict, @Addr_To, @Addr_Time, @A_Lst, @Addr_EndUserID, @Addr_FromContact, @Addr_ToContact;
			END

			CLOSE paras_cursor;
			DEALLOCATE paras_cursor;
		END
	END
	ELSE
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
Index_OnLoad, Index_OffLoad, Index_Insurance, Index_VolumeAddition, Index_WeightAddition, Index_Description, Index_CarVolume, Index_CarWeight, Index_FromContact, Index_ToContact) 
SELECT @Code, Index_PactCode, Index_EndUserID, Index_EndUserName, 
Index_From, Index_FromProvince, Index_FromCity, Index_FromDistrict, Index_FromTime, 
Index_To, Index_ToProvince, Index_ToCity, Index_ToDistrict, Index_ToTime, 
Index_TransportMode, Index_GoodsCategory, Index_PackageMode, Index_ChargeMode, Index_PriceUnit, 
1, GETDATE(), @SrcOrderID, @RootOrderID, 2, Index_Kms, Index_CarType, Index_CarLength, 
Index_SupplierID, Index_SupplierCompanyID, Index_CustomerID, Index_CustomerCompanyID, 
Index_ShipMode, Index_Pick, Index_Delivery, @Operator, @CompanyID, GETDATE(), 0, Index_OnLoad, Index_OffLoad, Index_Insurance, 
Index_VolumeAddition, Index_WeightAddition, Index_Description, Index_CarVolume, Index_CarWeight, Index_FromContact, Index_ToContact FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_Status = 0 AND Index_Invalid = 0 AND Index_CreatorCompanyID = @CompanyID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510025005;
		END
		ELSE
		BEGIN
			DECLARE @DstOrderID BIGINT;
			SET @DstOrderID = IDENT_CURRENT('TMS_OrderIndex');
			
			INSERT INTO @tblRlt SELECT 0, @DstOrderID;
			
			-- 写订单状态变更记录
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_InsertTime, Flow_CompanyID, Flow_Invalid) VALUES(@DstOrderID, 0, 1, @Operator, GETDATE(), @CompanyID, 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510025006;
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
				SET @Result = -510025008;
			END
		END
		
		-- 不拆单时直接提接复制原单
		-- 原单在下单时已经对收货地址和发货地址进行了处理
	END
	
	-- 拆单后原始订单保留，便于和客户结算，原始订单状态修改为待签收
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = 2, Index_StatusTime = GETDATE() WHERE Index_ID = @SrcOrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510025004;
		END
		
		-- 写订单状态变更记录
		IF @Result = 0
		BEGIN
			INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_InsertTime, Flow_CompanyID, Flow_Invalid) VALUES(@SrcOrderID, 0, 2, @Operator, GETDATE(), @CompanyID, 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510025007;
			END
		END
	END

	SELECT @Result AS Order_Result;
	
	-- 返回所有拆单后的订单列表
	IF @Result = 0
	BEGIN
		SELECT T_OrderID AS Order_ID FROM @tblRlt WHERE T_Result = 0;
	END
END
GO


