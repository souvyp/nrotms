USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_CombineOrderPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_CombineOrderPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*合单报价*/
CREATE PROCEDURE [dbo].[sp_prv_price_CombineOrderPrice]
(
	@Operator BIGINT,
	@DocID BIGINT,
	@LessLoadPrice DECIMAL(18,2),
	@FullLoadPrice DECIMAL(18,2),
	@PickPrice DECIMAL(18,2),
	@DeliveryPrice DECIMAL(18,2),
	@OnLoadPrice DECIMAL(18,2),
	@OffLoadPrice DECIMAL(18,2),
	@AdditionPrice DECIMAL(18,2),
	@InsuranceCost DECIMAL(18, 2), 
	@TaxPrice DECIMAL(18,2),
	@TxnRequired TINYINT = 0,
	@Result BIGINT OUTPUT
)
AS
BEGIN

	DECLARE @CompanyID BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
		
	IF @TxnRequired = 1
	BEGIN
		BEGIN TRANSACTION;
	END
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -5200048001;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -5200048002;
	END

	-- 报价单是否存在[只有草稿才能追加价格]
	IF @Result = 0 AND @DocID > 0  AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Status = 0 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -5200048003;
	END

	IF @Result = 0
	BEGIN
		-- 报价存在则清除
		UPDATE Price_DocDetails SET Detail_Invalid = 1 WHERE Detail_DocID = @DocID AND Detail_Invalid = 0;
		
		DECLARE @_Count BIGINT;
		SET @_Count = 0;

		-- 添加价格
		INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, 
1, @LessLoadPrice, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT > 0
		BEGIN
			SET @_Count = @_Count + 1;
		END
		
		INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, 
2, @FullLoadPrice, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT > 0
		BEGIN
			SET @_Count = @_Count + 1;
		END
		
		INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, 
3, @PickPrice, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT > 0
		BEGIN
			SET @_Count = @_Count + 1;
		END
		
		INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, 
4, @DeliveryPrice, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT > 0
		BEGIN
			SET @_Count = @_Count + 1;
		END
		
		INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, 
5, @OnLoadPrice, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT > 0
		BEGIN
			SET @_Count = @_Count + 1;
		END
		
		INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, 
6, @OffLoadPrice, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT > 0
		BEGIN
			SET @_Count = @_Count + 1;
		END
		
		INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, 
8, @InsuranceCost, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT > 0
		BEGIN
			SET @_Count = @_Count + 1;
		END
		
		INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, 
9, @AdditionPrice, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT > 0
		BEGIN
			SET @_Count = @_Count + 1;
		END
		
		INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid) VALUES(@DocID, 
10, @TaxPrice, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT > 0
		BEGIN
			SET @_Count = @_Count + 1;
		END
		
		IF @_Count <= 0
		BEGIN
			SET @Result = -5200048004;
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

	SELECT @Result AS Price_Result;

END
GO


