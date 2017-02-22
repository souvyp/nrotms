USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_prv_order_IsMultiLst]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_prv_order_IsMultiLst]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_prv_order_IsMultiLst]
(
	@Lst NVARCHAR(MAX),
	-- 1 Addrs Lst 2 Goods Lst
	@Mode BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT;
	SET @Result = 0;

	IF @Mode = 1 AND CHARINDEX('|', @Lst, 1) > 0
	BEGIN
		SET @Result = 1;
	END
	IF @Mode = 2 AND CHARINDEX(';', @Lst, 1) > 0
	BEGIN
		SET @Result = 1;
	END

	RETURN @Result;
END
GO


