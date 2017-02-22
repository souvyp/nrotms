USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_TaxPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_TaxPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
˰��
*/
CREATE PROCEDURE [dbo].[sp_pub_price_TaxPrice]
(
	@Operator BIGINT,
	@DocID BIGINT,				-- ���۵���
	@DetailID BIGINT = 0,       -- �۸���
	@DocType BIGINT,			-- �������ͣ��̶�Ϊ10
	@Price DECIMAL(18,2),		-- �۸�(�ٷֱ�)
	@Description NVARCHAR(1024) = N'', 
	@TxnRequired TINYINT = 1
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
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -5200151001;
	END
	
	-- ��ǰ�û�û����ӿͻ���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520015002;
	END
	
	-- �۸������Ƿ�ƥ��(˰��)
	IF @Result = 0 AND @DocType <> 10
	BEGIN
		SET @Result = -520015003;
	END
	IF @Result = 0 AND @Price <= 0
	BEGIN
		SET @Result = -520015007;
	END
	
	-- ���۵��Ƿ����[ֻ�вݸ����׷�Ӽ۸�]
	IF @Result = 0 AND @DocID > 0  AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Status = 0 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -520015004;
	END
	
	IF @Result = 0
	BEGIN
		IF @DetailID = 0
		BEGIN
			INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Description, Detail_Creator, 
Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, @DocType, @Price, @Description, @Operator, @CompanyID, GETDATE(), 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520015005;
			END
			ELSE
			BEGIN
				SET @DetailID = IDENT_CURRENT('Price_DocDetails');
			END 
		END
		ELSE
		BEGIN
			UPDATE Price_DocDetails SET Detail_DocID = @DocID, Detail_Type = @DocType, Detail_Amount = @Price, 
Detail_Description = @Description, Detail_Updater = @Operator, Detail_UpdateTime = GETDATE(), Detail_Invalid = 0 WHERE Detail_ID = @DetailID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520015006;
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


