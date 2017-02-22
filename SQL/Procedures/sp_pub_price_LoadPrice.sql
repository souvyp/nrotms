USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_LoadPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_LoadPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
װ��/ж����
*/
CREATE PROCEDURE [dbo].[sp_pub_price_LoadPrice]
(
	@Operator BIGINT,
	@DocID BIGINT,				-- ���۵���
	@DetailID BIGINT = 0,       -- �۸���
	@DocType BIGINT,			-- �������ͣ�5 װ���� 6 ж����
	@UnitType BIGINT,			-- 1 ���� 2 ��� 3 ����
	@Unit BIGINT,				-- ������λ�������λ
	@Min DECIMAL(18,6) = 1,		-- ��С���������
	@Max DECIMAL(18,6) = 1,		-- ������������
	@MinEqual TINYINT = 1,
	@MaxEqual TINYINT = 0,
	@Price DECIMAL(18,2),		-- �۸�
	@Description NVARCHAR(1024) = N'', 
	@TxnRequired TINYINT = 1,
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
	
	IF @Min = @Max
	BEGIN
		SET @MaxEqual = 1;
	END
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -5200061001;
	END
	
	-- ��ǰ�û�û����ӿͻ���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520006002;
	END
	
	-- �۸������Ƿ�ƥ��(װ����/ж����)
	IF @Result = 0 AND @DocType <> 5 AND @DocType <> 6
	BEGIN
		SET @Result = -520006003;
	END
	IF @Result = 0 AND @Price <= 0
	BEGIN
		SET @Result = -520006008;
	END
	
	-- ���㷽ʽУ��
	IF @Result = 0 AND @UnitType <> 1 AND @UnitType <> 2 AND @UnitType <> 3
	BEGIN
		SET @Result = -520006004;
	END
	
	-- ���۵��Ƿ����[ֻ�вݸ����׷�Ӽ۸�]
	IF @Result = 0 AND @DocID > 0  AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Status = 0 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -520006005;
	END
	
	IF @Result = 0
	BEGIN
		IF @DetailID = 0
		BEGIN
			INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Description, Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(
@DocID, @DocType, @Description, @Price, @Operator, @CompanyID, GETDATE(), @Invalid);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520006006;
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
			UPDATE Price_DocDetails SET Detail_DocID = @DocID, Detail_Type = @DocType, Detail_Description = @Description, Detail_Amount = @Price, 
Detail_Updater = @Operator, Detail_UpdateTime = GETDATE(), Detail_Invalid = @Invalid WHERE Detail_ID = @DetailID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520006007;
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


