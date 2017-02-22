USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_bill_EditBalanceDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_bill_EditBalanceDetails]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*添加或修改对账单明细*/
CREATE PROCEDURE [dbo].[sp_pub_bill_EditBalanceDetails]
(
	@Operator BIGINT,
	@DetailID BIGINT,
	@DocID BIGINT,
	@OrderID BIGINT,
	@Description NVARCHAR(500)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @Code NVARCHAR(50);
	DECLARE @PactCode NVARCHAR(50);
	DECLARE @FromProvince BIGINT;
	DECLARE @FromCity BIGINT;
	DECLARE @ToProvince BIGINT;
	DECLARE @ToCity BIGINT;
	DECLARE @Volume DECIMAL(18,6);
	DECLARE @Weight DECIMAL(18,4);
	DECLARE @Amount DECIMAL(18,2);
	DECLARE @ReceiptQty DECIMAL(18,2);
	DECLARE @LessLoad DECIMAL(18,2);
	DECLARE @FullLoad DECIMAL(18,2);
	DECLARE @Pick DECIMAL(18,2);
	DECLARE @Delivery DECIMAL(18,2);
	DECLARE @OnLoad DECIMAL(18,2);
	DECLARE @OffLoad DECIMAL(18,2);
	DECLARE @Min DECIMAL(18,2);
	DECLARE @Addition DECIMAL(18,2);
	DECLARE @Insurance DECIMAL(18,2);
	DECLARE @Tax DECIMAL(18,2);
	DECLARE @Total DECIMAL(18,2);
	SET @Result = 0;
	IF @DetailID IS NULL
	BEGIN
		SET @DetailID = 0;
	END
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @Code = N'';
	SET @PactCode = N'';
	SET @FromProvince = 0;
	SET @FromCity = 0;
	SET @ToProvince = 0;
	SET @ToCity = 0;
	SET @Volume = 0;
	SET @Weight = 0;
	SET @Amount = 0;
	SET @ReceiptQty = 0;
	SET @LessLoad = 0;
	SET @FullLoad = 0;
	SET @Pick = 0;
	SET @Delivery = 0;
	SET @OnLoad = 0;
	SET @OffLoad = 0;
	SET @Min = 0;
	SET @Addition = 0;
	SET @Insurance = 0;
	SET @Tax = 0;
	SET @Total = 0;

	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -530001001;
	END
	
	-- 当前用户没有添加订单物品的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -530001002;
	END

	-- 订单是否存在[已回单的订单]
	IF @Result = 0
	BEGIN
		SELECT @Code = Index_Code, @PactCode = Index_PactCode, @FromProvince = Index_FromProvince, @FromCity = Index_FromCity, @ToProvince = Index_ToProvince, @ToCity = Index_ToCity FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Invalid = 0 AND Index_Status = 8;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -530001003;
		END
	END
	
	-- 明细是否存在
	IF @Result = 0 AND @DetailID > 0 AND NOT EXISTS(SELECT Detail_ID FROM Balance_BillDetails WHERE Detail_ID = @DetailID AND Detail_Invalid = 0)
	BEGIN
		SET @Result = -530001004;
	END
	/*
	-- 计算总重量、总体积、总数量
	IF @Result = 0
	BEGIN
		SET @Weight = dbo.fn_pub_order_TotalWeight(@OrderID, 0);
		SET @Volume = dbo.fn_pub_order_TotalVolume(@OrderID, 0);
		SET @Amount = dbo.fn_pub_order_TotalAmount(@OrderID, 0);
		SET @ReceiptQty = dbo.fn_pub_order_TotalAmount(@OrderID, 1);
		IF @Weight = 0 OR @Volume = 0 OR @Amount = 0
		BEGIN
			SET @Result = -530001005;
		END
	END
	*/
	-- 读取价格信息
	IF @Result = 0
	BEGIN
		IF NOT EXISTS (SELECT Cache_Amount FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0)
		BEGIN
			SET @Total = 0;
		END		
		ELSE
		BEGIN
		SELECT @LessLoad = SUM(CASE WHEN Cache_Type = 1 THEN Cache_Amount ELSE 0 END), 
		@FullLoad = SUM(CASE WHEN Cache_Type = 2 THEN Cache_Amount ELSE 0 END),
		@Pick = SUM(CASE WHEN Cache_Type = 3 THEN Cache_Amount ELSE 0 END),
		@Delivery = SUM(CASE WHEN Cache_Type = 4 THEN Cache_Amount ELSE 0 END),
		@OnLoad = SUM(CASE WHEN Cache_Type = 5 THEN Cache_Amount ELSE 0 END),
		@OffLoad = SUM(CASE WHEN Cache_Type = 6 THEN Cache_Amount ELSE 0 END),
		@Min = SUM(CASE WHEN Cache_Type = 7 THEN Cache_Amount ELSE 0 END),
		@Insurance = SUM(CASE WHEN Cache_Type = 8 THEN Cache_Amount ELSE 0 END),
		@Addition = SUM(CASE WHEN Cache_Type = 9 THEN Cache_Amount ELSE 0 END),
		@Tax = SUM(CASE WHEN Cache_Type = 10 THEN Cache_Amount ELSE 0 END) FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -530001006;
			
			SET @Total = 0;
		END
		ELSE
		BEGIN
			SET @Total = dbo.fn_pub_order_TotalCost(@OrderID);
		END
		END
	END
	
	IF @Result = 0
	BEGIN
		IF @DetailID > 0
		BEGIN
			UPDATE Balance_BillDetails SET Detail_DocID = @DocID, Detail_OrderID = @OrderID, Detail_Code = @Code, Detail_PactCode = @PactCode, Detail_FromProvince = @FromProvince, 
Detail_FromCity = @FromCity, Detail_ToProvince = @ToProvince, Detail_ToCity = @ToCity, Detail_Volume = @Volume, Detail_Weight = @Weight, 
Detail_Amount = @Amount, Detail_ReceiptQty = @ReceiptQty, Detail_Description = @Description, Detail_LessLoad = @LessLoad, 
Detail_FullLoad = @FullLoad, Detail_Pick = @Pick, Detail_Delivery = @Delivery, Detail_OnLoad = @OnLoad, Detail_OffLoad = @OffLoad, 
Detail_Min = @Min, Detail_Addition = @Addition, Detail_Insurance = @Insurance, Detail_Tax = @Tax, Detail_Total = @Total, 
Detail_Updater = @Operator, Detail_UpdateTime = GETDATE() WHERE Detail_ID = @DetailID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -530001007;
			END
		END
		ELSE
		BEGIN
			INSERT INTO Balance_BillDetails(Detail_DocID, Detail_OrderID, Detail_Code, Detail_PactCode, Detail_FromProvince, Detail_FromCity, Detail_ToProvince, 
Detail_ToCity, Detail_Volume, Detail_Weight, Detail_Amount, Detail_ReceiptQty, Detail_Description, Detail_LessLoad, Detail_FullLoad, 
Detail_Pick, Detail_Delivery, Detail_OnLoad, Detail_OffLoad, Detail_Min, Detail_Addition, Detail_Insurance, Detail_Tax, Detail_Total, 
Detail_Author, Detail_InsertTime, Detail_Invalid) VALUES(@DocID, @OrderID, @Code, @PactCode, @FromProvince, @FromCity, @ToProvince, @ToCity, 
@Volume, @Weight, @Amount, @ReceiptQty, @Description, @LessLoad, @FullLoad, @Pick, @Delivery, @OnLoad, @OffLoad, @Min, @Addition, 
@Insurance, @Tax, @Total, @Operator, GETDATE(), 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -530001008;
			END
			ELSE
			BEGIN
				SET @DetailID = IDENT_CURRENT('Balance_BillDetails');
			END
		END
	END
	
	/**-- 更新发票金额 放到前端页面自动计算
	IF @Result = 0
	BEGIN
		--获取总金额
		DECLARE @_Total DECIMAL(18,2);
		SET @_Total = 0;
		
		SELECT @_Total = SUM(Detail_Total) FROM Balance_BillDetails WHERE Detail_DocID = @DocID AND Detail_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @_Total = 0;
		END

		UPDATE Balance_BillIndex SET Index_Amount = @_Total WHERE Index_ID = @DocID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -530001009;
		END
	END
	**/
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;	
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS Detail_Result, @DetailID AS Detail_ID;
	
	SET NOCOUNT OFF;
END
GO


