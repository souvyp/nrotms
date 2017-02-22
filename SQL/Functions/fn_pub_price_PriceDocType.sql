USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_price_PriceDocType]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_price_PriceDocType]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_price_PriceDocType]
(
	@DocID BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Type BIGINT;
	SET @Type = 0;
	
	SELECT @Type = Index_Type FROM Price_DocIndex WHERE Index_ID = @DocID;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @Type = 0;
	END

	RETURN @Type;
END
GO


