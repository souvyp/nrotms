USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_DevicesEOD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_DevicesEOD]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 启用或禁用公司
CREATE PROCEDURE [dbo].[sp_pub_user_DevicesEOD]
(
	@Operator BIGINT,
	@DeviceID  BIGINT,
	@EOD TINYINT			-- 0 Disable 1 Enable
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	SET @Result = 0;
	
	BEGIN TRANSACTION;

	-- 只有管理员有权执行该操作
	IF @Result = 0 AND NOT EXISTS(SELECT [Admin_ID] FROM TMS_Administrator WHERE Admin_ID = @Operator AND Admin_Invalid = 0)
	BEGIN
		SET @Result = -510024001;
	END

	-- 启用或禁用
	IF @Result = 0
	BEGIN
		UPDATE TMS_Devices SET Device_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE Device_ID = @DeviceID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510024003;
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

	SELECT @Result AS Order_Result;

	SET NOCOUNT OFF;
END
GO


