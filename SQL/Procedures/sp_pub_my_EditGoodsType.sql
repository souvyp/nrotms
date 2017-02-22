USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_my_EditGoodsType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_my_EditGoodsType]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*修改物品类型*/
CREATE PROCEDURE [dbo].[sp_pub_my_EditGoodsType]
(
	@Operator BIGINT,
	@ID BIGINT,
	@Name NVARCHAR(300), 
	@Description NVARCHAR(500)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);

	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510012001;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510012002;
	END

    -- 司机是否存在(存在编辑, 不存在添加)
    IF @Result = 0
    BEGIN
		SELECT @ID = GoodsType_ID FROM TMS_MGoodsType WHERE GoodsType_ID = @ID AND GoodsType_CompanyID = @CompanyID AND GoodsType_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			INSERT INTO TMS_MGoodsType(GoodsType_Name, GoodsType_Description, GoodsType_CompanyID, GoodsType_Creator, GoodsType_InsertTime) VALUES(@Name, @Description, @CompanyID, @Operator, GETDATE());
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510012003;
			END
			ELSE
			BEGIN
				SET @ID = IDENT_CURRENT('TMS_MGoodsType');
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_MGoodsType SET GoodsType_Name = @Name, GoodsType_Description = @Description, GoodsType_Updater = @Operator, GoodsType_UpdateTime = GETDATE() WHERE GoodsType_ID = @ID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510012004;
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
	
	SELECT @Result AS GoodsType_Result, @ID AS GoodsType_ID;
	
	SET NOCOUNT OFF;
END
GO


