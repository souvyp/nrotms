USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_price_UnitName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_price_UnitName]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_price_UnitName]
(
	@UnitID BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @Name VARCHAR(100);
	SET @Name = N'';

	SELECT @Name = [Unit_Name]  FROM Price_Unit WHERE [Unit_ID] = @UnitID AND [Unit_Invalid] = 0;
	IF @@ROWCOUNT = 0 OR @UnitID = 16
	BEGIN
		SET @Name = N'';
	END

	RETURN @Name;
END

GO


