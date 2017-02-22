USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_price_UnitCompare]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_price_UnitCompare]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_price_UnitCompare]
(
	@VOW DECIMAL(18,4),
	@Min DECIMAL(18,4),
	@Max DECIMAL(18,4),
	@MinEqual TINYINT,
	@MaxEqual TINYINT
)
RETURNS TINYINT
AS
BEGIN
	DECLARE @Result TINYINT;
	SET @Result = 1;

	IF @MinEqual = 1 AND @VOW < @Min
	BEGIN
		SET @Result = 0;
	END
	ELSE IF @MinEqual = 0 AND @VOW <= @Min
	BEGIN
		SET @Result = 0;
	END
	ELSE IF @MaxEqual = 1 AND @VOW > @Max
	BEGIN
		SET @Result = 0;
	END
	ELSE IF @MaxEqual = 0 AND @VOW >= @Max
	BEGIN
		SET @Result = 0;
	END

	RETURN @Result;
END
GO


