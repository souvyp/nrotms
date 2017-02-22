USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_RefreshPriceCache]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_RefreshPriceCache]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*重算订单价格*/
CREATE PROCEDURE [dbo].[sp_pub_order_RefreshPriceCache]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@IsDebugMode TINYINT = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @OrderSrcClass BIGINT;
	DECLARE @SrcOrderID BIGINT;
	DECLARE @SrcOrderCreator BIGINT;
	DECLARE @OrderCreatorCompanyID BIGINT;
	SET @OrderCreatorCompanyID = 0;
	SET @SrcOrderCreator = 0;
	SET @SrcOrderID = 0;
	SET @OrderSrcClass = 0;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 256);
	SELECT @OrderSrcClass = Index_SrcClass,@SrcOrderID =Index_SrcOrderID,@OrderCreatorCompanyID = Index_CreatorCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID;

	BEGIN TRANSACTION;

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510039001;
	END

	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510039002;
	END

	-- 订单是否可以刷新费用
	IF @Result = 0
	BEGIN
		IF NOT EXISTS(SELECT Cache_ID FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0) AND 
		NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND Index_CreatorCompanyID = @CompanyID AND 
(CASE WHEN Index_SupplierID > 0 THEN 1 
WHEN Index_SrcClass = 1 AND Index_SrcOrderID > 0 THEN 1 
WHEN Index_Combined = 1 THEN 1 
WHEN Index_SrcClass = 2 AND Index_SupplierSymbolID > 0 THEN 1 
ELSE 0 END) = 1)
		BEGIN
			SET @Result = -510039003;
		END
	END
	
	
	-- 历史价在每次计算时都会被置为无效
	IF @Result = 0  AND EXISTS(SELECT Cache_ID FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0)
	BEGIN
		UPDATE Price_OrderCache SET Cache_Invalid = 1 WHERE Cache_OrderID = @OrderID;
	END
	-- 执行重算操作
	IF @Result = 0
	BEGIN
		EXEC sp_prv_price_CacheOrderPrice @Operator, @OrderID, @IsDebugMode, @Result = @Result OUTPUT;
		
		IF @Result = 0 AND @SrcOrderID > 0 AND @OrderSrcClass = 1
							BEGIN
								SELECT @SrcOrderCreator = Index_Creator FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_SupplierCompanyID = @OrderCreatorCompanyID AND Index_SrcClass = 2 AND Index_Invalid = 0;
								IF @@ROWCOUNT > 0
								BEGIN
									EXEC sp_prv_price_CacheOrderPrice @SrcOrderCreator, @SrcOrderID, 0, @Result = @Result OUTPUT;
								END
							END
		
	END

	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END
	
	SELECT @Result AS Refresh_Result;

	SET NOCOUNT OFF;
END
GO


