USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_EODSupplier]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_EODSupplier]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*���û���ó�����*/
CREATE PROCEDURE [dbo].[sp_pub_user_EODSupplier]
(
	@Operator BIGINT,
	@SupplierID BIGINT,
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
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510029001;
	END
	
	-- ��ǰ�û�û�����û���ó����̵�Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510029002;
	END

	-- �����̱���Ƿ���Ч
	IF @Result = 0 AND NOT EXISTS(SELECT Supplier_ID FROM TMS_MSupplier WHERE Supplier_ID = @SupplierID AND Supplier_OwnerCompanyID = @CompanyID)
	BEGIN
		SET @Result = -510029003;
	END

	-- ���û����
	IF @Result = 0
	BEGIN
		UPDATE TMS_MSupplier SET Supplier_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE Supplier_ID = @SupplierID;
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


