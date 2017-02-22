USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_EditOrderGoods]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_EditOrderGoods]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*添加或修改订单物品明细*/
CREATE PROCEDURE [dbo].[sp_pub_order_EditOrderGoods]
(
	@Operator BIGINT,
	@ListID BIGINT,			-- 订单物品编号
	@OrderID BIGINT,
	@GoodsID BIGINT,
	@Qty DECIMAL(18,2),
	@Weight DECIMAL(18,4),
	@Volume DECIMAL(18,6),
	@TxnRequired TINYINT = 1,
	@BatchNo NVARCHAR(50) = ''
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @CustomerCompanyID BIGINT;
	DECLARE @Code NVARCHAR(50);
	DECLARE @Name NVARCHAR(50);
	DECLARE @Unit BIGINT;
	DECLARE @Price DECIMAL(18,2);
	DECLARE @GoodsValue DECIMAL(18,2);
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @Code = '';
	SET @Name = '';
	SET @CustomerCompanyID = 0;
	SET @Unit = 0;
	SET @Price = 0;
	SET @GoodsValue = 0;
	
	IF @TxnRequired = 1
	BEGIN
		BEGIN TRANSACTION;
	END
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510015001;
	END
	
	-- 当前用户没有添加订单物品的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510015002;
	END

	-- 订单是否存在
	IF @Result = 0
	BEGIN
		SELECT @CustomerCompanyID = Index_CustomerCompanyID, @GoodsValue = Index_GoodsValue FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Creator = @Operator AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510015003;
		END
	END
	
	-- 同样物品允许传多次，通过BatchNo标识

	-- 物品是否存在
	IF @Result = 0
	BEGIN
		SELECT @Code = Goods_Code, @Name = Goods_Name, @Unit = Goods_Unit, @Price = ISNULL(Goods_Price, 0) FROM TMS_MGoods WHERE Goods_ID = @GoodsID AND Goods_CustomerCompanyID = @CustomerCompanyID AND Goods_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -51001504;
		END
	END

	--物品是否已添加
	IF @Result = 0
	BEGIN
		IF @ListID = 0
		BEGIN
			INSERT INTO TMS_OrderGoods(GoodsLst_OrderID, GoodsLst_GoodsID, GoodsLst_Code, GoodsLst_Name, GoodsLst_Qty, 
GoodsLst_Weight, GoodsLst_Volume, GoodsLst_Unit, GoodsLst_BatchNo, GoodsLst_Price, GoodsLst_Creator, GoodsLst_InsertTime, GoodsLst_Invalid) VALUES(@OrderID, 
@GoodsID, @Code, @Name, @Qty, @Weight, @Volume, @Unit, @BatchNo, @Price, @Operator, GETDATE(), 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510015005;
			END
			ELSE
			BEGIN
				SET @ListID = IDENT_CURRENT('TMS_OrderGoods');
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_OrderGoods SET GoodsLst_GoodsID = @GoodsID, GoodsLst_Code = @Code, GoodsLst_Name = @Name, 
GoodsLst_Qty = @Qty, GoodsLst_Weight = @Weight, GoodsLst_Volume = @Volume, GoodsLst_BatchNo = @BatchNo, GoodsLst_Updater = @Operator, 
GoodsLst_Unit = @Unit, GoodsLst_UpdateTime = GETDATE() WHERE GoodsLst_ID = @ListID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510015006;
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

	SELECT @Result AS Goods_Result, @ListID AS GoodsLst_ID;

	SET NOCOUNT OFF;
END


GO


