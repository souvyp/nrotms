USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_EODMAddr]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_EODMAddr]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*启用或禁用收货方地址*/
CREATE PROCEDURE [dbo].[sp_pub_user_EODMAddr]
(
	@Operator BIGINT,
	@AddrID BIGINT,
	@EOD TINYINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @Result = 0;
	
	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510029001;
	END
	
	-- 当前用户没有启用或禁用承运商的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510029002;
	END
	/**
	-- 承运商编号是否有效
	IF @Result = 0 AND NOT EXISTS(SELECT Addr_ID FROM TMS_MAddr WHERE Addr_ID = @AddrID AND Addr_CompanyID = @CompanyID)
	BEGIN
		SET @Result = -510029003;
	END
	**/
	-- 启用或禁用
	IF @Result = 0
	BEGIN
		UPDATE TMS_MAddr SET Addr_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE Addr_ID = @AddrID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510029004;
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

	SELECT @Result AS Customer_Result;

	SET NOCOUNT OFF;
END
GO


