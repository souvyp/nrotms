USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_my_EditGoods]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_my_EditGoods]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*添加或修改物品*/
CREATE PROCEDURE [dbo].[sp_pub_my_EditGoods]
(
	@Operator BIGINT,
	@GoodsID BIGINT,
	@Name NVARCHAR(50),
	@TypeID BIGINT,
	@Price DECIMAL(18,2),
	@SPC NVARCHAR(50),
	@Volume DECIMAL(18,6),
	@Weight DECIMAL(18,4),
	@MWeight DECIMAL(18,4),
	@Long DECIMAL(18,2) = 0,		-- 长
	@Width DECIMAL(18,2) = 0,		-- 宽
	@Height DECIMAL(18,2) = 0,		-- 高
	@CustomerCompanyID BIGINT = 0,
	@Unit BIGINT = 0				-- 数量单位
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @Code NVARCHAR(100);
	IF @GoodsID IS NULL
	BEGIN
		SET @GoodsID = 0;
	END
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	EXEC sp_pub_basic_GetSN 3, @SN = @Code OUTPUT;
	
	BEGIN TRANSACTION;

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510016001;
	END
	
	-- 当前用户没有添加物品的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510016002;
	END
	
	-- 物品类型是否存在
	IF @Result = 0 AND NOT EXISTS(SELECT GoodsType_ID FROM TMS_MGoodsType WHERE GoodsType_ID = @TypeID AND GoodsType_CompanyID = @CompanyID AND GoodsType_Invalid = 0)
	BEGIN
		SET @Result = -510016003;
	END
	
	-- 数量单位是否存在
	IF @Result = 0 AND NOT EXISTS(SELECT Unit_ID FROM Price_Unit WHERE Unit_ID = @Unit AND Unit_Invalid = 0)
	BEGIN
		SET @Result = -510016006;
	END

	-- 添加物品
	IF @Result = 0
	BEGIN
		IF @GoodsID = 0
		BEGIN
			INSERT INTO TMS_MGoods(Goods_Code, Goods_Name, Goods_TypeID, Goods_CustomerCompanyID, Goods_Price, Goods_SPC, Goods_Volume, 
Goods_Weight, Goods_MWeight, Goods_Long, Goods_Width, Goods_Height, Goods_Creator, Goods_CreatorCompanyID, Goods_InsertTime, Goods_Unit, 
Goods_Invalid) VALUES(@Code, @Name, @TypeID, @CustomerCompanyID, @Price, @SPC, @Volume, @Weight, @MWeight, @Long, @Width, @Height, @Operator, 
@CompanyID, GETDATE(), @Unit, 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510016004;
			END
			ELSE
			BEGIN
				SET @GoodsID = IDENT_CURRENT('TMS_MGoods');
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_MGoods SET Goods_Code = @Code, Goods_Name = @Name, Goods_TypeID = @TypeID, Goods_CustomerCompanyID = @CustomerCompanyID, Goods_Price = @Price, Goods_SPC = @SPC, 
Goods_Volume = @Volume, Goods_Weight = @Weight, Goods_MWeight = @MWeight, Goods_Long = @Long, Goods_Width = @Width, Goods_Height = @Height, 
Goods_Updater = @Operator, Goods_UpdateTime = GETDATE(), Goods_Unit = @Unit WHERE Goods_ID = @GoodsID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510016005;
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
	
	SELECT @Result AS Goods_Result, @GoodsID AS Goods_ID;
	
	SET NOCOUNT OFF;
END
GO


