USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_my_EditCar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_my_EditCar]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*添加或修改车辆*/
CREATE PROCEDURE [dbo].[sp_pub_my_EditCar]
(
	@Operator BIGINT,
	@SN VARCHAR(50),
	@CarType BIGINT,
	@CarLength DECIMAL(18,2),
	@Weight DECIMAL(18,4),
	@Seats BIGINT,
	@PurchaseTime DATETIME,
	@Insurance DATETIME,
	@Brand NVARCHAR(50),
	@Photo NVARCHAR(300),
	@Volume DECIMAL(18,6)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @CarID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @CarID = 0;
	
	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510011001;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510011002;
	END

    -- 车辆是否存在(存在编辑, 不存在添加)
    IF @Result = 0
    BEGIN
		SELECT @CarID = Car_ID FROM TMS_MCar WHERE Car_CompanyID = @CompanyID AND Car_SN = @SN AND Car_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			INSERT INTO TMS_MCar(Car_SN, Car_Type, Car_Length, Car_Weight, Car_Volume, Car_Seats, Car_PurchaseTime, 
Car_Insurance, Car_Brand, Car_Photo, Car_CompanyID, Car_Creator, Car_InsertTime) VALUES(@SN, @CarType, @CarLength, @Weight, @Volume, 
@Seats, @PurchaseTime, @Insurance, @Brand, @Photo, @CompanyID, @Operator, GETDATE());
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510011003;
			END
			ELSE
			BEGIN
				SET @CarID = IDENT_CURRENT('TMS_MCar');
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_MCar SET Car_Type = @CarType, Car_Length = @CarLength, Car_Weight = @Weight, Car_Volume = @Volume, 
Car_Seats = @Seats, Car_PurchaseTime = @PurchaseTime, Car_Insurance = @Insurance, Car_Brand = @Brand, 
Car_Photo = @Photo, Car_Updater = @Operator, car_UpdateTime = GETDATE() WHERE Car_ID = @CarID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510011004;
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
	
	SELECT @Result AS Car_Result, @CarID AS Car_ID;
	
	SET NOCOUNT OFF;
END


GO


