USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_DelPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_DelPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
删除报价记录
*/
CREATE PROCEDURE [dbo].[sp_pub_price_DelPrice]
(
	@Operator BIGINT,
	@id BIGINT, 
	@TxnRequired TINYINT = 1
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	SET @Result= 0;

	IF @TxnRequired = 1
	BEGIN
		BEGIN TRANSACTION;
	END
	/**
	-- 报价单是否存在[只有草稿才能删除价格]
	IF @Result = 0 AND @DocID > 0  AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Status = 0 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -520009001;
	END
	**/
	
	IF @Result = 0
	BEGIN
		DELETE FROM Price_DocDetails WHERE Detail_ID = @id;
	END
	
	IF @TxnRequired = 1
	BEGIN
		IF @Result = 0
		BEGIN
			COMMIT TRANSACTION;
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION;
		END
	END

	SELECT @Result AS Price_Result;

	SET NOCOUNT OFF;
END
GO


