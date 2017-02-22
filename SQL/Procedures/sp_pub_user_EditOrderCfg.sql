USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_EditOrderCfg]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_EditOrderCfg]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*按用户修改订单默认值配置*/
CREATE PROCEDURE [dbo].[sp_pub_user_EditOrderCfg]
(
	@Operator BIGINT,
	@GoodsCategory BIGINT = 0,
	@PackageMode BIGINT = 0,
	@ChargeMode BIGINT = 0,
	@PriceUnit BIGINT = 0,
	@IsInsurance BIGINT = 0,
	@IsPick BIGINT = 0,
	@IsDelivery BIGINT = 0,
	@IsOnLoad BIGINT = 0,
	@IsOffLoad BIGINT = 0
	
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
		SET @Result = -510059001;
	END
	
	-- 当前用户没有修改公司资料的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510059002;
	END
	
	IF @Result = 0
	BEGIN
		-- 当前配置是否存在
		IF EXISTS(SELECT Cfg_ID FROM TMS_MConfig WHERE Cfg_CompanyID = @CompanyID AND Cfg_Creator = @Operator)
		BEGIN
			UPDATE TMS_MConfig SET Cfg_GoodsCategory = @GoodsCategory, Cfg_PackageMode = @PackageMode, 
Cfg_ChargeMode = @ChargeMode, Cfg_PriceUnit = @PriceUnit, Cfg_Insurance = @IsInsurance,Cfg_Pick = @IsPick,Cfg_Delivery = @IsDelivery, Cfg_OnLoad = @IsOnLoad, Cfg_OffLoad = @IsOffLoad,  Cfg_CreateTime = GETDATE() WHERE 
Cfg_Creator = @Operator AND Cfg_CompanyID = @CompanyID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510059003;
			END
		END
		ELSE
		BEGIN
			INSERT INTO TMS_MConfig(Cfg_CompanyID, Cfg_GoodsCategory, Cfg_PackageMode, Cfg_ChargeMode, Cfg_PriceUnit, Cfg_Insurance, Cfg_Creator, Cfg_CreateTime,Cfg_Pick,Cfg_Delivery,Cfg_OnLoad,Cfg_OffLoad) VALUES(
@CompanyID, @GoodsCategory, @PackageMode, @ChargeMode, @PriceUnit, @IsInsurance, @Operator, GETDATE(),@IsPick,@IsDelivery,@IsOnLoad,@IsOffLoad);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510059004;
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
	
	SELECT @Result AS Company_Result;
	
	SET NOCOUNT OFF;
END
GO


