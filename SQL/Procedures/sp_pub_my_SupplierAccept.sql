USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_my_SupplierAccept]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_my_SupplierAccept]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- 接受或拒绝供应商申请
CREATE PROCEDURE [dbo].[sp_pub_my_SupplierAccept]
(
	@Operator BIGINT,
	@SupplierID BIGINT,
	@Op BIGINT				-- 1 接受 2 拒绝
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	SET @Result = 0;

	BEGIN TRANSACTION;
	
	EXEC sp_prv_my_SupplierAccept @Operator, @SupplierID, @Op, 0, @Result = @Result OUTPUT;
	
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


