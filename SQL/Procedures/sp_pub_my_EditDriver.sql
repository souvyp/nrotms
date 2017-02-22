USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_my_EditDriver]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_my_EditDriver]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*添加或修改司机*/
CREATE PROCEDURE [dbo].[sp_pub_my_EditDriver]
(
	@Operator BIGINT,
	@ID BIGINT,
	@Name NVARCHAR(300), 
	@Gender TINYINT,
	@Photo NVARCHAR(300),
	@Birthday DATETIME,
	@Phone NVARCHAR(50),
	@LicensedDate DATETIME,
	@LicenseType BIGINT,
	@SN NVARCHAR(100),
	@PersonalSN NVARCHAR(100)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	IF @ID IS NULL	
	BEGIN
		SET @ID = 0;
	END

	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510010001;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510010002;
	END
	
	-- 司机不能重名(如果确实姓名相同,应添加标识符,例如:李明(湖南)、李明(山东)等)
	IF @Result = 0 AND @ID = 0 AND EXISTS(SELECT [Driver_ID] FROM TMS_MDriver WHERE Driver_CompanyID = @CompanyID AND Driver_Invalid = 0 AND Driver_Name = @Name)
	BEGIN
		SET @Result = -510010005;
	END

    -- 司机是否存在(存在编辑, 不存在添加)
    IF @Result = 0
    BEGIN
		SELECT @ID = Driver_ID FROM TMS_MDriver WHERE Driver_ID = @ID AND Driver_CompanyID = @CompanyID AND Driver_Invalid = 0
		IF @@ROWCOUNT = 0
		BEGIN
			INSERT INTO TMS_MDriver(Driver_Name, Driver_Gender, Driver_Photo, 
Driver_Birthday, Driver_Phone, Driver_LicensedDate, Driver_LicenseType, Driver_SN, Driver_PersonalSN, 
Driver_CompanyID, Driver_Creator, Driver_InsertTime) VALUES(@Name, @Gender, @Photo, @Birthday, @Phone, @LicensedDate,
@LicenseType, @SN, @PersonalSN, @CompanyID, @Operator, GETDATE());
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510010003;
			END
			ELSE
			BEGIN
				SET @ID = IDENT_CURRENT('TMS_MDriver');
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_MDriver SET Driver_Name = @Name, Driver_Gender = @Gender, Driver_Photo = @Photo, Driver_Birthday = @Birthday, 
Driver_Phone = @Phone, Driver_LicensedDate = @LicensedDate, Driver_LicenseType = @LicenseType, Driver_SN = @SN, 
Driver_PersonalSN = @PersonalSN, Driver_Updater = @Operator, Driver_UpdateTime = GETDATE() WHERE Driver_ID = @ID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510010004;
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
	
	SELECT @Result AS Driver_Result, @ID AS Driver_ID;
	
	SET NOCOUNT OFF;
END




GO


