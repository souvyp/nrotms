USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_EditContractDoc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_EditContractDoc]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*创建或修改报价单*/
CREATE PROCEDURE [dbo].[sp_prv_price_EditContractDoc]
(	
	@Operator BIGINT,
	@DocID BIGINT,
	@CompanyID BIGINT,
	@Contract NVARCHAR (MAX),
	@Result BIGINT OUTPUT
)
AS
BEGIN
	
	DECLARE @XmlDocId INT;
	SET @XmlDocId = 0;
	
	IF @Result = 0 AND LEN(@Contract) > 0
	BEGIN		
		EXEC SP_XML_PREPAREDOCUMENT @XmlDocId OUTPUT, @Contract;
			-- 新增  零担
		IF EXISTS (SELECT DetailID FROM 
OPENXML(@XmlDocId, '/Add/Pr', 2) WITH (
	DetailID NVARCHAR(50),
	DocType NVARCHAR(200),
	FromProvince NVARCHAR(50),
	FromCity NVARCHAR(50),
	FromDistrict NVARCHAR(50),
	ToProvince NVARCHAR(50),
	ToCity NVARCHAR(50),
	ToDistrict NVARCHAR(50),
	UnitType NVARCHAR(10),	-- 1 重量 2 体积 3 数量
	Unit NVARCHAR(10),			
	UMin DECIMAL(18, 6),			
	UMax DECIMAL(18, 6),		
	Price DECIMAL(18, 2),
	MinPay NVARCHAR(50),
	CarType NVARCHAR(10),
	CarLength NVARCHAR(10),
	CarVolume NVARCHAR(50),
	CarWeight NVARCHAR(50),
	Comments  NVARCHAR(1000)
	) WHERE DetailID = 0 )
	
			BEGIN
			INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_FromProvince, Detail_FromCity, Detail_FromDistrict, Detail_ToProvince, Detail_ToCity, Detail_ToDistrict, Detail_CarType, Detail_CarLength, Detail_MinVolume, Detail_MaxVolume, Detail_VolumeUnit, Detail_MinWeight, Detail_MaxWeight, Detail_WeightUnit,Detail_MinEqual, Detail_MaxEqual, Detail_Amount, Detail_MinPay, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Updater, Detail_UpdateTime, Detail_Invalid, Detail_MinCount, Detail_MaxCount, Detail_CountUnit, Detail_CarVolume, Detail_CarWeight, Detail_Comments) SELECT @DocID, DocType, FromProvince, FromCity, FromDistrict, ToProvince, ToCity, ToDistrict, CarType, CarLength,(CASE WHEN UnitType = 2 THEN UMin ELSE 0 END ) , (CASE WHEN UnitType = 2 THEN UMax ELSE 0 END ), (CASE WHEN UnitType = 2 THEN Unit ELSE 0 END ),(CASE WHEN UnitType = 1 THEN UMin ELSE 0 END ) , (CASE WHEN UnitType = 1 THEN UMax ELSE 0 END ) ,(CASE WHEN UnitType = 1 THEN Unit ELSE 0 END ), 1, 0, Price, MinPay ,@Operator, @CompanyID, GETDATE(), 0, 0, 0, (CASE WHEN UnitType = 3 THEN UMin ELSE 0 END ), (CASE WHEN UnitType = 3 THEN UMax ELSE 0 END ) , (CASE WHEN UnitType = 3 THEN Unit ELSE 0 END ) , CarVolume, CarWeight , Comments FROM 
OPENXML(@XmlDocId, '/Add/Pr', 2) WITH (
	DetailID NVARCHAR(50),
	DocType NVARCHAR(200),
	FromProvince NVARCHAR(50),
	FromCity NVARCHAR(50),
	FromDistrict NVARCHAR(50),
	ToProvince NVARCHAR(50),
	ToCity NVARCHAR(50),
	ToDistrict NVARCHAR(50),
	UnitType NVARCHAR(10),	-- 1 重量 2 体积 3 数量
	Unit NVARCHAR(10),			
	UMin DECIMAL(18, 6),			
	UMax DECIMAL(18, 6),		
	Price DECIMAL(18, 2),
	MinPay NVARCHAR(50),
	CarType NVARCHAR(10),
	CarLength NVARCHAR(10),
	CarVolume NVARCHAR(50),
	CarWeight NVARCHAR(50),
	Comments  NVARCHAR(1000)
	) WHERE DetailID = 0 ;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -520002006;
				END
			END	
			ELSE
			BEGIN
			-- 修改
			UPDATE Price_DocDetails  SET 
			Detail_FromProvince = FromProvince, 
			Detail_FromCity = FromCity,
			Detail_FromDistrict = FromDistrict,
			Detail_ToProvince = ToProvince, 
			Detail_ToCity = ToCity, 
			Detail_ToDistrict = ToDistrict, 
			Detail_CarType = CarType , 
			Detail_CarLength = CarLength, 
			Detail_MinVolume  = (CASE WHEN UnitType = 2 THEN UMin ELSE 0 END ),						Detail_MaxVolume = (CASE WHEN UnitType = 2 THEN UMax ELSE 0 END ),						Detail_VolumeUnit = (CASE WHEN UnitType = 2 THEN Unit ELSE 0 END ),						Detail_MinWeight = (CASE WHEN UnitType = 1 THEN UMin ELSE 0 END ),						Detail_MaxWeight = (CASE WHEN UnitType = 1 THEN UMax ELSE 0 END ),						Detail_WeightUnit = (CASE WHEN UnitType = 1 THEN Unit ELSE 0 END ),						Detail_Amount = Price, 
			Detail_MinPay = MinPay, 
			Detail_Updater = @Operator, 
			Detail_UpdateTime =  GETDATE(), 
			Detail_MinCount = (CASE WHEN UnitType = 3 THEN UMin ELSE 0 END ),						Detail_MaxCount = (CASE WHEN UnitType = 3 THEN UMax ELSE 0 END ),						Detail_CountUnit = (CASE WHEN UnitType = 3 THEN Unit ELSE 0 END ),						Detail_CarVolume = CarVolume, 
			Detail_CarWeight = CarWeight,Detail_Comments = Comments  FROM 
OPENXML(@XmlDocId, '/Add/Pr', 2) WITH (
	DetailID NVARCHAR(50),
	DocType NVARCHAR(200),
	FromProvince NVARCHAR(50),
	FromCity NVARCHAR(50),
	FromDistrict NVARCHAR(50),
	ToProvince NVARCHAR(50),
	ToCity NVARCHAR(50),
	ToDistrict NVARCHAR(50),
	CarType NVARCHAR(10),
	CarLength NVARCHAR(10),
	UnitType NVARCHAR(10),	-- 1 重量 2 体积 3 数量
	Unit NVARCHAR(10),			
	UMin decimal(18, 6),			
	UMax decimal(18, 6),		
	Price NVARCHAR(50),
	MinPay NVARCHAR(50),
	CarVolume NVARCHAR(50),
	CarWeight NVARCHAR(50),
	Comments  NVARCHAR(1000)
	)  WHERE DetailID > 0 AND Detail_ID = DetailID;
		IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520002007;
			END
		END	
	END

END

	


GO


