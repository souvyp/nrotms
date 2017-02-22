USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_AdditionDriverPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_AdditionDriverPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
附加费
*/
CREATE PROCEDURE [dbo].[sp_pub_price_AdditionDriverPrice]
(
	@OpenId NVARCHAR(300),
	@DocID BIGINT,							-- 报价单号
	@DetailID BIGINT = 0,					-- 价格编号
	@DocType BIGINT,						-- 报价类型，固定为9
	@Price DECIMAL(18,2),					-- 价格
	@Description NVARCHAR(1024) = N'',		-- 附加说明 
	@TxnRequired TINYINT = 1,
	@AdditionType BIGINT = 0				-- 附加费的名目编号
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE	@Operator BIGINT;
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Operator = dbo.fn_pub_user_OpenId2User (@OpenId);
	SET @Result= 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);

	IF @TxnRequired = 1
	BEGIN
		BEGIN TRANSACTION;
	END
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -5200101001;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520010002;
	END
	
	-- 价格类型是否匹配(附加费)
	IF @Result = 0 AND @DocType <> 9
	BEGIN
		SET @Result = -520010003;
	END
	IF @Result = 0 AND @Price <= 0
	BEGIN
		SET @Result = -520010007;
	END
	
	-- 报价单是否存在
	IF @Result = 0 AND @DocID > 0  AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0)
	BEGIN
		SET @Result = -520010004;
	END
	
	IF @Result = 0
	BEGIN
		IF @DetailID = 0
		BEGIN
			INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Description, Detail_Creator, 
Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid, Detail_AdditionType) VALUES(@DocID, @DocType, @Price, @Description, @Operator, @CompanyID, GETDATE(), 0, @AdditionType);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520010005;
			END
			ELSE
			BEGIN
				SET @DetailID = IDENT_CURRENT('Price_DocDetails');
			END 
		END
		ELSE
		BEGIN
			UPDATE Price_DocDetails SET Detail_DocID = @DocID, Detail_Type = @DocType, Detail_Amount = @Price, Detail_Description = @Description, 
Detail_Updater = @Operator, Detail_UpdateTime = GETDATE(), Detail_Invalid = 0, Detail_AdditionType = @AdditionType WHERE Detail_ID = @DetailID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520010006;
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


