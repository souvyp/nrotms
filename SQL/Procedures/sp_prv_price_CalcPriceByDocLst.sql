USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_CalcPriceByDocLst]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_CalcPriceByDocLst]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_prv_price_CalcPriceByDocLst]
(
	@tblDocIDs PriceDocLst READONLY,
	@FromProvince BIGINT,
	@FromCity BIGINT,
	@FromDistrict BIGINT,
	@ToProvince BIGINT,
	@ToCity BIGINT,
	@ToDistrict BIGINT,
	@Pick BIGINT,
	@Delivery BIGINT,
	@OnLoad BIGINT,
	@OffLoad BIGINT,
	@PriceUnit BIGINT,
	@ChargeMode BIGINT,
	@CarType BIGINT,
	@CarLength DECIMAL(18,2),
	@CarVolume DECIMAL(18,6),
	@CarWeight DECIMAL(18,4),
	@Weight DECIMAL(18,4),
	@Volume DECIMAL(18,6),
	@Count DECIMAL(18,2),
	@TransportMode BIGINT,
	@IsInsurance BIGINT,
	@GoodsValue DECIMAL(18,2),
	@CustomerCompanyID BIGINT,
	@CreatorCompanyID BIGINT,
	@CustomerID BIGINT,
	@CalcMode BIGINT = 1,			-- 1 重算价格 2 实时计算
	@Result BIGINT OUTPUT,
	@_LessLoadCost DECIMAL(18,2) OUTPUT,
	@_FullLoadCost DECIMAL(18,2) OUTPUT,
	@_PickCost DECIMAL(18,2) OUTPUT,
	@_DeliveryCost DECIMAL(18,2) OUTPUT,
	@_OnLoadCost DECIMAL(18,2) OUTPUT,
	@_OffLoadCost DECIMAL(18,2) OUTPUT,
	@_MinCost DECIMAL(18,2) OUTPUT,
	@_InsuranceCost DECIMAL(18,2) OUTPUT,
	@_AdditionCost DECIMAL(18,2) OUTPUT,
	@_TaxCost DECIMAL(18,2) OUTPUT,
	@_TotalCost DECIMAL(18,2) OUTPUT,
	@_LessLoadCostDocID BIGINT OUTPUT,
	@_FullLoadCostDocID BIGINT OUTPUT,
	@_PickCostDocID BIGINT OUTPUT,
	@_DeliveryCostDocID BIGINT OUTPUT,
	@_OnLoadCostDocID BIGINT OUTPUT,
	@_OffLoadCostDocID BIGINT OUTPUT,
	@_MinCostDocID BIGINT OUTPUT,
	@_InsuranceCostDocID BIGINT OUTPUT,
	@_AdditionCostDocID BIGINT OUTPUT,
	@_TaxCostDocID BIGINT OUTPUT
)
AS
BEGIN
	
	DECLARE @PriceFound TINYINT;
	SET @Result = 0;
	SET @PriceFound = 0;
	
	-- 仅实时计算时检查，是否有相应路线(零担、整车)
	IF @Result = 0 AND @CalcMode = 2 AND NOT EXISTS(SELECT b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID AND a.Detail_FromProvince = @FromProvince AND 
a.Detail_FromCity = @FromCity AND a.Detail_FromDistrict = @FromDistrict AND a.Detail_ToProvince = @ToProvince AND a.Detail_ToCity = @ToCity AND a.Detail_ToDistrict = @ToDistrict AND Detail_Type IN (1,2))
	BEGIN
		SET @Result = -520017001;
	END
	
	IF @Result = 0
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 Doc_ID FROM @tblDocIDs)
		BEGIN
			IF @CalcMode = 2
			BEGIN
				SET @Result = -520017002;
			END
			ELSE
			BEGIN
				SET @PriceFound = 0;
			END
		END
		ELSE
		BEGIN
			SET @PriceFound = 1;
		END
	END
	
	DECLARE @_GoodsVal DECIMAL(18,2);
	SET @_LessLoadCost = 0;
	SET @_FullLoadCost = 0;
	SET @_PickCost = 0;
	SET @_DeliveryCost = 0;
	SET @_OnLoadCost = 0;
	SET @_OffLoadCost = 0;
	SET @_MinCost = 0;
	SET @_InsuranceCost = 0;
	SET @_AdditionCost = 0;
	SET @_TaxCost = 0;
	SET @_TotalCost = 0;
	SET @_GoodsVal = 0;
	
	SET @_LessLoadCostDocID = 0;
	SET @_FullLoadCostDocID = 0;
	SET @_PickCostDocID = 0;
	SET @_DeliveryCostDocID = 0;
	SET @_OnLoadCostDocID = 0;
	SET @_OffLoadCostDocID = 0;
	SET @_MinCostDocID = 0;
	SET @_InsuranceCostDocID = 0;
	SET @_AdditionCostDocID = 0;
	SET @_TaxCostDocID = 0;


	-- 选出报价单信息
	IF @Result = 0 AND @PriceFound = 1
	BEGIN
		-- 零担
		IF @TransportMode = 1
		BEGIN
			SELECT TOP 1 @_LessLoadCost = ( CASE 
-- 体积
WHEN @ChargeMode =2 THEN a.Detail_Amount * @Volume 
-- 重量
WHEN @ChargeMode = 1 THEN a.Detail_Amount * @Weight 
-- 数量
WHEN @ChargeMode = 3 THEN a.Detail_Amount * @Count ELSE 0 END ), @_LessLoadCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE a.Detail_Type = 1 AND a.Detail_Invalid = 0 AND 
a.Detail_FromProvince = @FromProvince AND a.Detail_FromCity = @FromCity AND (a.Detail_FromDistrict = 0 OR a.Detail_FromDistrict = @FromDistrict) AND 
a.Detail_ToProvince = @ToProvince AND a.Detail_ToCity = @ToCity AND (a.Detail_ToDistrict = 0 OR a.Detail_ToDistrict = @ToDistrict) AND (
CASE 
-- 体积
WHEN @ChargeMode = 2 AND a.Detail_VolumeUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Volume, a.Detail_MinVolume, a.Detail_MaxVolume, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
-- 重量
WHEN @ChargeMode = 1 AND a.Detail_WeightUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Weight, a.Detail_MinWeight, a.Detail_MaxWeight, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
-- 数量
WHEN @ChargeMode = 3 AND a.Detail_CountUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Count, a.Detail_MinCount, a.Detail_MaxCount, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
ELSE 0 END) = 1 ORDER BY a.Detail_FromDistrict DESC, a.Detail_ToDistrict DESC, a.Detail_CreateTime DESC;
				IF @_LessLoadCost = 0
					BEGIN
					GOTO DIRECTLY_EXIT;
					END

			-- 提货费3
			IF @Pick = 1
			BEGIN
				SELECT TOP 1 @_PickCost = a.Detail_Amount, @_PickCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 3 AND a.Detail_Invalid = 0 AND a.Detail_FromProvince = @FromProvince AND a.Detail_FromCity = @FromCity AND (a.Detail_FromDistrict = 0 OR a.Detail_FromDistrict = @FromDistrict) AND (
CASE 
-- 体积
WHEN @ChargeMode = 2 AND a.Detail_VolumeUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Volume, a.Detail_MinVolume, a.Detail_MaxVolume, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
-- 重量
WHEN @ChargeMode = 1 AND a.Detail_WeightUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Weight, a.Detail_MinWeight, a.Detail_MaxWeight, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
-- 数量
WHEN @ChargeMode = 3 AND a.Detail_CountUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Count, a.Detail_MinCount, a.Detail_MaxCount, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
ELSE 0 END) = 1 ORDER BY a.Detail_FromDistrict DESC, a.Detail_CreateTime DESC;
			END

			-- 送货费4
			IF @Delivery = 1
			BEGIN
				SELECT TOP 1 @_DeliveryCost = a.Detail_Amount,@_DeliveryCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 4 AND a.Detail_Invalid = 0 AND a.Detail_ToProvince = @ToProvince AND a.Detail_ToCity = @ToCity AND (a.Detail_ToDistrict = 0 OR a.Detail_ToDistrict = @ToDistrict) AND (
CASE 
-- 体积
WHEN @ChargeMode = 2 AND a.Detail_VolumeUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Volume, a.Detail_MinVolume, a.Detail_MaxVolume, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
-- 重量
WHEN @ChargeMode = 1 AND a.Detail_WeightUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Weight, a.Detail_MinWeight, a.Detail_MaxWeight, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
-- 数量
WHEN @ChargeMode = 3 AND a.Detail_CountUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Count, a.Detail_MinCount, a.Detail_MaxCount, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
ELSE 0 END) = 1 ORDER BY a.Detail_ToDistrict DESC, a.Detail_CreateTime DESC;
			END
		END
		-- 整车
		ELSE IF @TransportMode = 2
		BEGIN
			-- 整车2
			SELECT TOP 1 @_FullLoadCost = a.Detail_Amount, @_FullLoadCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 2 AND a.Detail_Invalid = 0 AND a.Detail_FromProvince = @FromProvince AND a.Detail_FromCity = @FromCity AND 
a.Detail_ToProvince = @ToProvince AND a.Detail_ToCity = @ToCity AND a.Detail_CarType = @CarType AND a.Detail_CarLength = @CarLength AND 
a.Detail_CarVolume = @CarVolume AND a.Detail_CarWeight = @CarWeight ORDER BY a.Detail_CreateTime DESC;
				IF @_FullLoadCost = 0
					BEGIN
					GOTO DIRECTLY_EXIT;
					END
		END
		
		-- 装货费5
		IF @OnLoad = 1
		BEGIN
			SELECT TOP 1 @_OnLoadCost = ( CASE 
-- 体积
WHEN @ChargeMode = 2 THEN a.Detail_Amount * @Volume 
-- 重量
WHEN @ChargeMode = 1 THEN a.Detail_Amount * @Weight 
-- 数量
WHEN @ChargeMode = 3 THEN a.Detail_Amount * @Count ELSE 0 END ),@_OnLoadCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 5 AND a.Detail_Invalid = 0 AND (
CASE 
-- 体积
WHEN @ChargeMode = 2 AND a.Detail_VolumeUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Volume, a.Detail_MinVolume, a.Detail_MaxVolume, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
-- 重量
WHEN @ChargeMode = 1 AND a.Detail_WeightUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Weight, a.Detail_MinWeight, a.Detail_MaxWeight, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
-- 数量
WHEN @ChargeMode = 3 AND a.Detail_CountUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Count, a.Detail_MinCount, a.Detail_MaxCount, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
ELSE 0 END) = 1 ORDER BY a.Detail_CreateTime DESC;
		END
		
		-- 卸货费6
		IF @OffLoad = 1
		BEGIN
			SELECT TOP 1 @_OffLoadCost = ( CASE 
-- 体积
WHEN @ChargeMode = 2 THEN a.Detail_Amount * @Volume 
-- 重量
WHEN @ChargeMode = 1 THEN a.Detail_Amount * @Weight 
-- 数量
WHEN @ChargeMode = 3 THEN a.Detail_Amount * @Count ELSE 0 END ),@_OffLoadCostDocID = Doc_ID  FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 6 AND a.Detail_Invalid = 0 AND (
CASE 
-- 体积
WHEN @ChargeMode = 2 AND a.Detail_VolumeUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Volume, a.Detail_MinVolume, a.Detail_MaxVolume, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
-- 重量
WHEN @ChargeMode = 1 AND a.Detail_WeightUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Weight, a.Detail_MinWeight, a.Detail_MaxWeight, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
-- 数量
WHEN @ChargeMode = 3 AND a.Detail_CountUnit = @PriceUnit AND dbo.fn_pub_price_UnitCompare( @Count, a.Detail_MinCount, a.Detail_MaxCount, a.Detail_MinEqual, a.Detail_MaxEqual ) = 1 THEN 1 
ELSE 0 END) = 1 ORDER BY a.Detail_CreateTime DESC;
		END
		
		-- 最低收费7
		SELECT TOP 1 @_MinCost = a.Detail_Amount, @_MinCostDocID = b.Doc_ID  FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 7 AND a.Detail_Invalid = 0 AND a.Detail_Amount > 0 ORDER BY a.Detail_CreateTime DESC;
		
		-- 保费8
		SELECT TOP 1 @_InsuranceCost = a.Detail_Amount, @_InsuranceCostDocID = b.Doc_ID FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 8 AND a.Detail_Invalid = 0 AND a.Detail_Amount > 0 ORDER BY a.Detail_CreateTime DESC;
		
		-- 附加费9
		SELECT @_AdditionCost = SUM( a.Detail_Amount) FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 9 AND a.Detail_Invalid = 0;
	
		-- 计算保险费(计算公式: 保险比例*货物单价*数量)
		IF @IsInsurance = 1
		BEGIN
			SET @_GoodsVal = @GoodsValue;
			SET @_InsuranceCost = ROUND(@_GoodsVal * ISNULL(@_InsuranceCost, 0) / 100, 2);
		END
		ELSE
		BEGIN
			SET @_InsuranceCost = 0;
		END
		
		-- 税费10
		SELECT TOP 1 @_TaxCost = a.Detail_Amount, @_TaxCostDocID = b.Doc_ID  FROM Price_DocDetails AS a INNER JOIN @tblDocIDs AS b ON a.Detail_DocID = b.Doc_ID WHERE 
a.Detail_Type = 10 AND a.Detail_Invalid = 0 AND a.Detail_Amount > 0 ORDER BY a.Detail_CreateTime DESC;

		-- 返回
		SET @_TotalCost = ISNULL(@_LessLoadCost, 0) + ISNULL(@_FullLoadCost, 0) + ISNULL(@_PickCost, 0) + ISNULL(@_DeliveryCost, 0) + ISNULL(@_OnLoadCost, 0) + ISNULL(@_OffLoadCost, 0) + ISNULL(@_AdditionCost, 0) + ISNULL(@_InsuranceCost, 0);
		
		-- 按现有总价计算税费具体金额
		IF @_TaxCost > 0
		BEGIN
			SET @_TaxCost = ROUND(@_TotalCost * ISNULL(@_TaxCost, 0) / 100, 2);
		
			SET @_TotalCost = @_TotalCost + @_TaxCost;
		END
	END
	
	DIRECTLY_EXIT:
	
	SET @_LessLoadCost = ISNULL(@_LessLoadCost, 0);
	SET @_FullLoadCost = ISNULL(@_FullLoadCost, 0);
	SET @_PickCost = ISNULL(@_PickCost, 0); 
	SET @_DeliveryCost = ISNULL(@_DeliveryCost, 0);
	SET @_OnLoadCost = ISNULL(@_OnLoadCost, 0);
	SET @_OffLoadCost = ISNULL(@_OffLoadCost, 0);
	SET @_AdditionCost = ISNULL(@_AdditionCost, 0);
	SET @_MinCost = ISNULL(@_MinCost, 0);
	SET @_TaxCost = ISNULL(@_TaxCost, 0);
	
	SET @_LessLoadCostDocID = ISNULL(@_LessLoadCostDocID, 0);
	SET @_FullLoadCostDocID = ISNULL(@_FullLoadCostDocID, 0);
	SET @_PickCostDocID = ISNULL(@_PickCostDocID, 0); 
	SET @_DeliveryCostDocID = ISNULL(@_DeliveryCostDocID, 0);
	SET @_OnLoadCostDocID = ISNULL(@_OnLoadCostDocID, 0);
	SET @_OffLoadCostDocID = ISNULL(@_OffLoadCostDocID, 0);
	SET @_AdditionCostDocID = ISNULL(@_AdditionCostDocID, 0);
	SET @_MinCostDocID = ISNULL(@_MinCostDocID, 0);
	SET @_TaxCostDocID = ISNULL(@_TaxCostDocID, 0);

END

GO


