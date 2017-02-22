USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_CityDeliveryPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_CityDeliveryPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
(ͬ��)�ͻ���
*/
CREATE PROCEDURE [dbo].[sp_pub_price_CityDeliveryPrice]
(
	@Operator BIGINT,
	@DocID BIGINT,				-- ���۵���
	@DetailID BIGINT = 0,       -- �۸���
	@DocType BIGINT,			-- ���۵����ͣ��̶�Ϊ4
	@ToProvince BIGINT,			-- Ŀ��ʡ
	@ToCity BIGINT,				-- Ŀ����
	@ToDistrict BIGINT = 0,		-- Ŀ������
	@To NVARCHAR(300) = N'',
	@Price DECIMAL(18,2),		-- �۸�
	@Description NVARCHAR(1024) = N'', 
	@TxnRequired TINYINT = 1,
	@CarType BIGINT = 0,			-- ����
	@CarLength DECIMAL(18,2) = 0,	-- ����
	@CarVolume DECIMAL(18,6) = 0,
	@CarWeight DECIMAL(18,4) = 0,
	@UnitType BIGINT = 0,			-- 1 ���� 2 ��� 3 ����
	@Unit BIGINT = 0,				-- ������λ�������λ
	@Min DECIMAL(18,6) = 0,			-- ��С���������
	@Max DECIMAL(18,6) = 0,			-- ������������
	@MinEqual TINYINT = 1,
	@MaxEqual TINYINT = 0,
	@Invalid TINYINT = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result= 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	IF @ToDistrict IS NULL
	BEGIN
		SET @ToDistrict = 0;
	END

	IF @TxnRequired = 1
	BEGIN
		BEGIN TRANSACTION;
	END
	
	IF @Min = @Max
	BEGIN
		SET @MaxEqual = 1;
	END
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -5200051001;
	END
	
	-- ��ǰ�û�û����ӿͻ���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520005002;
	END
	
	-- �۸������Ƿ�ƥ��(ͬ���ͻ�)
	IF @Result = 0 AND @DocType <> 4
	BEGIN
		SET @Result = -520005003;
	END
	IF @Result = 0 AND @Price <= 0
	BEGIN
		-- ����0ֵ�����ݽ����ڲݸ�״ֻ̬ѡ
		SET @Price = 0;
		-- SET @Result = -520005007;
	END
	
	-- ���۵��Ƿ����[ֻ�вݸ����׷�Ӽ۸�]
	IF @Result = 0 AND @DocID > 0  AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Status = 0 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -520005004;
	END
	
	IF @Result = 0
	BEGIN
		IF @DetailID = 0
		BEGIN
			INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_ToProvince, Detail_ToCity, Detail_ToDistrict, Detail_To, Detail_Description, 
Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid, Detail_CarType, Detail_CarLength, Detail_CarVolume, Detail_CarWeight) VALUES(
@DocID, @DocType, @ToProvince, @ToCity, @ToDistrict, @To, @Description, @Price, @Operator, @CompanyID, GETDATE(), @Invalid, @CarType, @CarLength, @CarVolume, @CarWeight);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520005005;
			END
			ELSE
			BEGIN
				SET @DetailID = IDENT_CURRENT('Price_DocDetails');
				
				-- ��Ӽ۸�λ���Ƽ�����
				EXEC sp_prv_price_DocDetailsUnitAndRegion @DetailID, @UnitType, @Unit, @Min, @Max, @MinEqual, @MaxEqual, @Result = @Result OUTPUT;
			END 
		END
		ELSE
		BEGIN
			UPDATE Price_DocDetails SET Detail_DocID = @DocID, Detail_Type = @DocType, Detail_ToProvince = @ToProvince, Detail_ToCity = @ToCity, 
Detail_ToDistrict = @ToDistrict, Detail_To = @To, Detail_Description = @Description, Detail_Amount = @Price, Detail_Updater = @Operator, 
Detail_UpdateTime = GETDATE(), Detail_Invalid = @Invalid, Detail_CarType = @CarType, Detail_CarLength = @CarLength, Detail_CarVolume = @CarVolume, 
Detail_CarWeight = @CarWeight WHERE Detail_ID = @DetailID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520005006;
			END
			ELSE
			BEGIN
				-- ��Ӽ۸�λ���Ƽ�����
				EXEC sp_prv_price_DocDetailsUnitAndRegion @DetailID, @UnitType, @Unit, @Min, @Max, @MinEqual, @MaxEqual, @Result = @Result OUTPUT;
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


