USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_EditCompanyCfg]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_EditCompanyCfg]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*修改公司相关配置*/
CREATE PROCEDURE [dbo].[sp_pub_user_EditCompanyCfg]
(
	@Operator BIGINT,
	@ProvinceID BIGINT = 0,
	@CityID BIGINT = 0,
	@DistrictID BIGINT = 0
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
		SET @Result = -510040001;
	END
	
	-- 当前用户没有修改公司资料的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_RoleID = 256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510040002;
	END
	
	IF @Result = 0
	BEGIN
		UPDATE TMS_Company SET Company_ProvinceID = @ProvinceID, 
Company_CityID = @CityID, Company_DistrictID = @DistrictID, Company_Updater = @Operator,Company_UpdateTime = GETDATE() WHERE 
Company_ID = @CompanyID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510040003;
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


