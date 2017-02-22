USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_my_AddSupplier]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_my_AddSupplier]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*邀请承运商*/
CREATE PROCEDURE [dbo].[sp_pub_my_AddSupplier]
(
	@Operator BIGINT,
	@CompanyCode NVARCHAR(100),
	@InviteDesc NVARCHAR(600)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @SupplierID BIGINT;
	SET @Result = 0;
	SET @SupplierID = 0;
	
	BEGIN TRANSACTION;
	
	EXEC sp_prv_my_AddSupplier @Operator, @CompanyCode, @InviteDesc, 0, @Result = @Result OUTPUT, @SupplierID = @SupplierID OUTPUT;

	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END
	
	SELECT @Result AS Supplier_Result, @SupplierID AS Supplier_ID;
	
	SET NOCOUNT OFF;
END



GO


