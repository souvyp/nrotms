USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_AreaLocation]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_AreaLocation]
GO

USE [OTMS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<TDQ>
-- Create date: <2016/12/10,>
-- Description:	<Î»ÖÃ¾­Î³¶È>
-- =============================================
CREATE FUNCTION [dbo].[fn_pub_order_AreaLocation] 
(
	@Area_ID BIGINT,
	@Type TINYINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Location NVARCHAR(100);
	SET @Location = '';

	-- Add the T-SQL statements to compute the return value here
	SELECT @Location=(CAST(CAST([Longitude] AS DECIMAL(18,2)) AS NVARCHAR(100))+','+CAST(CAST([Latitude]  AS DECIMAL(18,2)) AS NVARCHAR(100))) FROM TMS_BasicArea WHERE [Area_ID] = @Area_ID AND [Area_Invalid]=0;
	IF @Location = ''
	BEGIN
		SET @Location = 0;
	END
	-- Return the result of the function
	RETURN @Location;

END
GO

