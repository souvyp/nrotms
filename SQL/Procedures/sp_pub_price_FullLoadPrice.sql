USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_FullLoadPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_FullLoadPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
按线路报价(整车)
*/
CREATE PROCEDURE [dbo].[sp_pub_price_FullLoadPrice]
(
	@Operator BIGINT,
	@DocID BIGINT,					-- 报价单号
	@DetailID BIGINT = 0,			-- 价格编号
	@DocType BIGINT,				-- 报价类型, 固定为2
	@FromProvince BIGINT,			-- 起点省
	@FromCity BIGINT,				-- 起点市
	@FromDistrict BIGINT = 0,
	@From NVARCHAR(300) = N'',
	@ToProvince BIGINT,				-- 目的省
	@ToCity BIGINT,					-- 目的市
	@ToDistrict BIGINT = 0,
	@To NVARCHAR(300) = N'',
	@Kms BIGINT = 0,
	@CarType BIGINT,				-- 车型
	@CarLength DECIMAL(18,2),		-- 车长
	@Price DECIMAL(18,2),			-- 价格
	@Description NVARCHAR(1024) = N'', 
	@TxnRequired TINYINT = 1,
	@CarVolume DECIMAL(18,6) = 0,
	@CarWeight DECIMAL(18,4) = 0,
	@Invalid TINYINT = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result= 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);

	IF @TxnRequired = 1
	BEGIN
		BEGIN TRANSACTION;
	END
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -5200031001;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520003002;
	END
	
	-- 价格类型是否匹配(整车运输)
	IF @Result = 0 AND @DocType <> 2
	BEGIN
		SET @Result = -520003003;
	END
	
	-- 计算方式校验
	IF @Result = 0 AND (@CarType = 0 OR @CarLength = 0)
	BEGIN
		SET @Result = -520003004;
	END
	IF @Result = 0 AND @Price <= 0
	BEGIN
		-- 允许0值，兼容将便于草稿状态只选
		SET @Price = 0;
		-- SET @Result = -520003008;
	END
	
	-- 报价单是否存在[只有草稿才能追加价格]
	IF @Result = 0 AND @DocID > 0  AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Status = 0 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -520003005;
	END
	
	IF @Result = 0
	BEGIN
		IF @DetailID = 0 OR @DetailID IS NULL
		BEGIN
			INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_FromProvince, Detail_FromCity, Detail_FromDistrict, Detail_From, 
Detail_ToProvince, Detail_ToCity, Detail_ToDistrict, Detail_To, Detail_Kms, Detail_Description, Detail_CarType, Detail_CarLength, Detail_CarVolume, Detail_CarWeight, 
Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, @DocType, @FromProvince, @FromCity, @FromDistrict, @From,
@ToProvince, @ToCity, @ToDistrict, @To, @Kms, @Description, @CarType, @CarLength, @CarVolume, @CarWeight, @Price, @Operator, @CompanyID, GETDATE(), @Invalid);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520003006;
			END
			ELSE
			BEGIN
				SET @DetailID = IDENT_CURRENT('Price_DocDetails');
			END 
		END
		ELSE
		BEGIN
			UPDATE Price_DocDetails SET Detail_DocID = @DocID, Detail_Type = @DocType, Detail_FromProvince = @FromProvince, 
Detail_FromCity = @FromCity, Detail_FromDistrict = @FromDistrict, Detail_From = @From, Detail_ToProvince = @ToProvince, Detail_ToCity = @ToCity, 
Detail_ToDistrict = @ToDistrict, Detail_To = @To, Detail_Kms = @Kms, Detail_Description = @Description, Detail_CarType = @CarType, 
Detail_CarLength = @CarLength, Detail_CarVolume = @CarVolume, Detail_CarWeight = @CarWeight, Detail_Amount = @Price, Detail_Updater = @Operator, 
Detail_UpdateTime = GETDATE(), Detail_Invalid = @Invalid WHERE Detail_ID = @DetailID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520003007;
			END
		END
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

	SELECT @Result AS Price_Result, @DetailID AS Detail_ID;

	SET NOCOUNT OFF;
END
GO


