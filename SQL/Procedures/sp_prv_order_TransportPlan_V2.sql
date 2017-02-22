USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_TransportPlan_V2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_TransportPlan_V2]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- 运输计划
/*
V2版本描述：
1、拆单源头是运输订单

2、拆完单以后，被拆订单将被禁用
   拆单结果订单，将重新进行市内、长途待调度，等待下一轮拆单或直拉调度

3、支持按地址、按物品数量拆单

4、地址、联系人等信息中需要进行|,等特殊字符替换

拆地址参数：
fp1,fc1,fd1,from1,tp1,tc1,td1,to1,time1,eu1,fcnt1,tcnt1|fp2,fc2,fd2,from2,tp2,tc2,td2,to2,time2,eu2,fcnt2,tcnt2
*fp = from province, fc = from city, fd = from district, fcnt = from contact
*tp = to province, tc = to city, td = to district, tcnt = to contact
*eu = end user id

拆物品参数
goodid1=2,goodid2=1;goodid11=1
*/
CREATE PROCEDURE [dbo].[sp_prv_order_TransportPlan_V2]
(
	@Operator BIGINT,
	@PrevOrderID BIGINT,
	@AddrLst NVARCHAR(MAX),
	@GoodsLst NVARCHAR(MAX),
	@TxnRequired BIGINT = 0,
	@TransType TINYINT, -- 1 拆线路 2 拆数量
	@Result BIGINT OUTPUT
)
AS
BEGIN
	SET @Result = 0;
	

	DECLARE @SrcOrderID BIGINT;
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
	DECLARE @CustomerSymbolID BIGINT;
	DECLARE @CheckItem BIGINT;
	DECLARE @TotalWeight DECIMAL(18,4);
	DECLARE @TotalVolume DECIMAL(18,6);
	DECLARE @TotalWeight2 DECIMAL(18,4);
	DECLARE @TotalVolume2 DECIMAL(18,6);
	DECLARE @OrderID BIGINT;
	DECLARE @Payment  DECIMAL(18,2);
	DECLARE @Payable  DECIMAL(18,2);
	DECLARE @DeviceCode NVARCHAR(50) = N''  -- 绑定设备编号
	DECLARE @EndUserName NVARCHAR(300);
	SET @TotalWeight2 = 0;
	SET @TotalVolume2 = 0;
	SET @OrderID = 0;
	SET @RootOrderID = 0;
	SET @Result = 0;
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
	SET @SrcOrderID = 0;
	SET @CustomerSymbolID = 0;
	SET @CheckItem = 0;
	SET @DeviceCode = '';
	SET @EndUserName = '';
	SELECT @TotalWeight = SUM(GoodsLst_Weight) FROM TMS_OrderGoods WHERE GoodsLst_OrderID = @PrevOrderID AND GoodsLst_Invalid = 0;
	SELECT @TotalVolume = SUM(GoodsLst_Volume) FROM TMS_OrderGoods WHERE GoodsLst_OrderID = @PrevOrderID AND GoodsLst_Invalid = 0;
		
	
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	IF @TxnRequired = 1
	BEGIN
		BEGIN TRANSACTION;
	END
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510025101;
	END
	
	-- 当前用户没有拆单的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510025102;
	END

	-- 运输订单PrevOrderID是否存在，获取SrcOrderID等订单参数
	IF @Result = 0
	BEGIN
		SELECT @SrcOrderID = Index_SrcOrderID, @PactCode = Index_PactCode, @EndUserID = Index_EndUserID, @CustomerID = Index_CustomerID, @FromTime = Index_FromTime, @ToTime = Index_ToTime, @TransportMode = Index_TransportMode, @GoodsCategory = Index_GoodsCategory, @PackageMode = Index_PackageMode, @ChargeMode = Index_ChargeMode, @PriceUnit = Index_PriceUnit, @CarType = Index_CarType, @CarLength = Index_CarLength, @CarVolume = Index_CarVolume, @CarWeight = Index_CarWeight, @ShipMode = Index_ShipMode, @IsPick = Index_Pick, @IsDelivery = Index_Delivery, @IsOnLoad = Index_OnLoad, @IsOffLoad = Index_OffLoad, @IsInsurance = Index_Insurance, @VolumeAddition = Index_VolumeAddition, @WeightAddition = Index_WeightAddition, @Description = Index_Description, @FromContact = Index_FromContact, @ToContact = Index_ToContact, @RootOrderID = Index_RootOrderID, @GoodsValue = Index_GoodsValue, @CustomerSymbolID = Index_CustomerSymbolID,@DeviceCode = Index_DeviceCode,  @Payment = Index_payment ,@Payable = Index_payable   FROM TMS_OrderIndex WHERE Index_ID = @PrevOrderID AND Index_SrcClass = 2 AND Index_Status = 1 AND Index_Invalid = 0 AND Index_CreatorCompanyID = @CompanyID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510025103;
		END
	END
	-- 检查拆单参数 @AddrLst @GoodsLst
	IF @Result = 0
	BEGIN 
		SET @CheckItem =dbo.fn_pub_order_CheckAddGoods(@AddrLst,1)
			IF @CheckItem = 0
			BEGIN 
				SET @Result = -510025108;
			END	
			ELSE 
			BEGIN
				SET @CheckItem = dbo.fn_pub_order_CheckAddGoods(@GoodsLst,2);
			END
				IF @CheckItem = 0
				BEGIN 
					SET @Result = -510025108;
				END	
			
	END		
	-- 未拆单不许提交,应直接转入调度
	IF @Result = 0 AND (LEN(@AddrLst) = 0 OR LEN(@GoodsLst) = 0)
	BEGIN
		SET @Result = -510025104;
	END
	IF @Result = 0 AND dbo.fn_prv_order_IsMultiLst(@AddrLst, 1) = 0 AND dbo.fn_prv_order_IsMultiLst(@GoodsLst, 2) = 0
	BEGIN
		SET @Result = -510025105;
	END

	-- 拆单结果
	DECLARE @tblRlt TABLE
	(
		T_Result BIGINT,
		T_OrderID BIGINT
	);

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
		DECLARE @Addr_EndUserName NVARCHAR(300);
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
		SET @Addr_EndUserName = N'';

		DECLARE paras_cursor CURSOR LOCAL FOR SELECT a.Addr_FromProvince, a.Addr_FromCity, a.Addr_FromDistrict, a.Addr_From, a.Addr_ToProvince, a.Addr_ToCity, a.Addr_ToDistrict, a.Addr_To, a.Addr_Time, B.A_Lst, a.Addr_EndUserID, a.Addr_FromContact, a.Addr_ToContact,a.Addr_EndUserName FROM dbo.fn_pub_order_AddrLst2Tbl( @AddrLst ) AS A CROSS APPLY dbo.fn_pub_order_GoodsLst2Tbl( @GoodsLst ) AS B;
		OPEN paras_cursor;
			
		FETCH NEXT FROM paras_cursor INTO @Addr_FromProvince, @Addr_FromCity, @Addr_FromDistrict, @Addr_From, @Addr_ToProvince, @Addr_ToCity, @Addr_ToDistrict, @Addr_To, @Addr_Time, @A_Lst, @Addr_EndUserID, @Addr_FromContact, @Addr_ToContact, @Addr_EndUserName;
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
			IF @Addr_EndUserID = -1
			BEGIN
			EXEC sp_prv_my_EditEndUser @Operator=@Operator,@EndUserCompanyID=0,@Name=@Addr_EndUserName,@Industry=0,@Web=N'',@ShortName=N'',@EnName=N'',@ShortEnName=N'',@Master=N'',@License=N'',@Contact=N'',@Phone=N'',@Fax=N'',@Mail=N'',@Address=N'',@Zip=N'',@WeiXin=N'',@Logo=N'',@Bank=N'',@BankAccount=N'',@Description=N'',@CustomerID=252,@AutoAppend=1,@EndUserID=@Addr_EndUserID OUTPUT,@Result = @Result OUTPUT;
			END		
			IF @Addr_FromContact IS NULL
			BEGIN
				SET @Addr_FromContact = N'';
			END
			IF @Addr_ToContact IS NULL
			BEGIN
				SET @Addr_ToContact = N'';
			END
			
			-- 收发货地址、收发货人等内容中替换特殊字符
			SET @Addr_From = dbo.fn_prv_order_FormatPlanParas(@Addr_From, 1);
			SET @Addr_To = dbo.fn_prv_order_FormatPlanParas(@Addr_To, 1);
			SET @Addr_FromContact = dbo.fn_prv_order_FormatPlanParas(@Addr_FromContact, 1);
			SET @Addr_ToContact = dbo.fn_prv_order_FormatPlanParas(@Addr_ToContact, 1);

			-- 下单存储过程中会对收发货地址进行处理
			INSERT INTO @tblRlt EXEC sp_prv_order_EditOrder @Operator = @Operator,@PactCode = @PactCode,@EndUserID = @Addr_EndUserID,@From= @Addr_From,@To = @Addr_To,@SrcOrderID = @SrcOrderID,@CustomerID = @CustomerID,@SupplierID = 0,@GoodsLst = @A_Lst,@TxnRequired = 0,@FromProvince = @Addr_FromProvince, @FromCity = @Addr_FromCity, @FromDistrict =@Addr_FromDistrict, @FromTime =@_From,@ToProvince = @Addr_ToProvince,@ToCity = @Addr_ToCity, @ToDistrict = @Addr_ToDistrict,@ToTime = @_To,@TransportMode = @TransportMode,@GoodsCategory = @GoodsCategory,@PackageMode = @PackageMode, @ChargeMode = @ChargeMode,@PriceUnit = @PriceUnit,@SrcClass = 2,@Kms = 0,@CarType = @CarType,@CarLength = @CarLength,@ShipMode = @ShipMode,@IsPick = @IsPick,@IsDelivery = @IsDelivery,@DstStatus = 1,@IsOnLoad = @IsOnLoad ,@IsOffLoad =@IsOffLoad,@IsInsurance = @IsInsurance,@VolumeAddition = @VolumeAddition,@WeightAddition = @WeightAddition,@Descriptions = @Description,@CarVolume = @CarVolume,@CarWeight = @CarWeight,@CustomerSymbolID = @CustomerSymbolID,@FromContact = @Addr_FromContact,@ToContact = @Addr_ToContact,@GoodsValue = @GoodsValue,@PrevOrderID = @PrevOrderID,@_Version = 2,@DeviceCode = @DeviceCode,@Payment = @Payment,@Payable = @Payable,@OrderID = 0 ,@Result = @Result OUTPUT;
			-- 出错则退出游标循环
			SELECT TOP 1 @Result = T_Result FROM @tblRlt WHERE T_Result <> 0;
			IF @@ROWCOUNT > 0
			BEGIN
				BREAK;
			END
	
			SELECT @OrderID=T_OrderID FROM @tblRlt;
			IF @TotalWeight > 0
			BEGIN
				SELECT @TotalWeight2 = SUM(GoodsLst_Weight) FROM TMS_OrderGoods WHERE GoodsLst_OrderID = @OrderID AND GoodsLst_Invalid = 0;
				SET @TotalWeight2 = @TotalWeight2*@WeightAddition/@TotalWeight;
				UPDATE TMS_OrderIndex SET Index_WeightAddition = @TotalWeight2 WHERE Index_ID = @OrderID
			END	

			IF @TotalVolume > 0
			BEGIN
				SELECT @TotalVolume2 = SUM(GoodsLst_Volume) FROM TMS_OrderGoods WHERE GoodsLst_OrderID = @OrderID AND GoodsLst_Invalid = 0;
				SET @TotalVolume2 = @TotalVolume2*@VolumeAddition/@TotalVolume;	
				UPDATE TMS_OrderIndex SET Index_VolumeAddition = @TotalVolume2 WHERE Index_ID = @OrderID
			END	
		
			IF @TransType = 1
				BEGIN
				SET @_From = @_To;
				END

			FETCH NEXT FROM paras_cursor INTO @Addr_FromProvince, @Addr_FromCity, @Addr_FromDistrict, @Addr_From, @Addr_ToProvince, @Addr_ToCity, @Addr_ToDistrict, @Addr_To, @Addr_Time, @A_Lst, @Addr_EndUserID, @Addr_FromContact, @Addr_ToContact,@Addr_EndUserName;
		END

		CLOSE paras_cursor;
		DEALLOCATE paras_cursor;
	END

	SELECT @Result AS Order_Result;
	
	-- 返回所有拆单后的订单列表
	IF @Result = 0
	BEGIN
		SELECT a.T_OrderID AS Order_ID, b.Index_Code AS Order_Code, b.Index_ShipMode AS Order_ShipMode FROM @tblRlt AS a INNER JOIN TMS_OrderIndex AS b ON a.T_OrderID = b.Index_ID WHERE a.T_Result = 0 AND b.Index_Invalid = 0;
	END

END

GO


