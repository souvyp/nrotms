USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_DocDetailsUnitAndRegion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_DocDetailsUnitAndRegion]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*匹配并更新报价单详情中的重量体积最大、最小值区间*/
CREATE PROCEDURE [dbo].[sp_prv_price_DocDetailsUnitAndRegion]
(
	@DetailID BIGINT,
	@UnitType BIGINT,			-- 1 重量 2 体积 3 数量
	@Unit BIGINT,				-- 重量单位或体积单位
	@Min DECIMAL(18,6) = 1,		-- 最小体积或重量
	@Max DECIMAL(18,4) = 1,		-- 最大体积或重量
	@MinEqual TINYINT = 1,
	@MaxEqual TINYINT = 0,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	
	SET @Result = 0;

	UPDATE Price_DocDetails SET 
Detail_MinVolume = (CASE WHEN @UnitType = 2 THEN @Min ELSE 0 END), 
Detail_MaxVolume = (CASE WHEN @UnitType = 2 THEN @Max ELSE 0 END), 
Detail_VolumeUnit = (CASE WHEN @UnitType = 2 THEN @Unit ELSE 0 END), 
Detail_MinWeight = (CASE WHEN @UnitType = 1 THEN @Min ELSE 0 END), 
Detail_MaxWeight = (CASE WHEN @UnitType = 1 THEN @Max ELSE 0 END), 
Detail_WeightUnit = (CASE WHEN @UnitType = 1 THEN @Unit ELSE 0 END), 
Detail_MinCount = (CASE WHEN @UnitType = 3 THEN @Min ELSE 0 END), 
Detail_MaxCount = (CASE WHEN @UnitType = 3 THEN @Max ELSE 0 END), 
Detail_CountUnit = (CASE WHEN @UnitType = 3 THEN @Unit ELSE 0 END), 
Detail_MinEqual = @MinEqual, Detail_MaxEqual = @MaxEqual WHERE Detail_ID = @DetailID;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @Result = -520014001;
	END

END
GO


