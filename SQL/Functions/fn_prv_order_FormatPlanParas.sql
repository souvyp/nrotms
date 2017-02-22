USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_prv_order_FormatPlanParas]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_prv_order_FormatPlanParas]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_prv_order_FormatPlanParas]
(
	@Addr NVARCHAR(MAX),
	-- 1 µÿ÷∑¡–±Ì
	@Mode BIGINT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @Result NVARCHAR(MAX);
	SET @Result = N'';
	
	IF @Mode = 1
	BEGIN
		SET @Result = REPLACE(@Addr, '&#124;', '|');
		SET @Result = REPLACE(@Addr, '&#44;', ',');
	END
	ELSE
	BEGIN
		SET @Result = @Addr;
	END
	
	RETURN @Result;
END
GO


