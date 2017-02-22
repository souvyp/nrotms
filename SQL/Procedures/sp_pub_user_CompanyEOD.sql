USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_CompanyEOD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_CompanyEOD]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ���û���ù�˾
CREATE PROCEDURE [dbo].[sp_pub_user_CompanyEOD]
(
	@Operator BIGINT,
	@CompanyID BIGINT,
	@EOD TINYINT			-- 0 Disable 1 Enable
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	SET @Result = 0;
	
	BEGIN TRANSACTION;

	-- ֻ�й���Ա��Ȩִ�иò���
	IF @Result = 0 AND NOT EXISTS(SELECT [Admin_ID] FROM TMS_Administrator WHERE Admin_ID = @Operator AND Admin_Invalid = 0)
	BEGIN
		SET @Result = -510024001;
	END

	-- ��˾����Ƿ���Ч
	IF @Result = 0 AND NOT EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = @CompanyID)
	BEGIN
		SET @Result = -510024002;
	END
	
	-- ���ù�˾�е��ĳ����̽�ɫ
	IF @Result = 0 AND @EOD = 0
	BEGIN 
		UPDATE TMS_MSupplier SET Supplier_Invalid = 1 WHERE Supplier_CompanyID = @CompanyID;
	END	

	-- ���û����
	IF @Result = 0
	BEGIN
		UPDATE TMS_Company SET Company_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE Company_ID = @CompanyID;
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


