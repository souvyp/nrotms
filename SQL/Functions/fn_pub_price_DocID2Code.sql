USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_price_DocID2Code]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_price_DocID2Code]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
/** 报价号转1:报价编号2:报价公司 3,报价类型**/
CREATE FUNCTION [dbo].[fn_pub_price_DocID2Code]
(
	@DocID BIGINT,
	@Type INT
)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @Code NVARCHAR(50);
	SET @Code = '';
	IF @TYPE = 1
		BEGIN
			SELECT @Code = Index_Code FROM Price_DocIndex WHERE Index_ID = @DocID;
			IF @@ROWCOUNT = 0
				BEGIN
				SET @Code = '';
				END
		END
	ELSE IF @TYPE = 2
	BEGIN
		SELECT @Code = dbo.fn_pub_user_Company2Name(Index_CreatorCompanyID) FROM Price_DocIndex WHERE Index_ID = @DocID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Code = '';
		END
	END
	ELSE IF @TYPE = 3
	BEGIN
		SELECT @Code = Index_Type FROM Price_DocIndex WHERE Index_ID = @DocID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Code = '';
		END
	END
	
	RETURN @Code ;
END
GO


