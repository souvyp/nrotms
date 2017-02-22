USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_AreaName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_AreaName]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_pub_order_AreaName]
(
	@ID BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @AreaName NVARCHAR(100);
	SET @AreaName=N'';

	SELECT @AreaName = [Area_Name] FROM TMS_BasicArea WHERE [Area_ID] = @ID AND [Area_Invalid]=0;
	IF @@ROWCOUNT=0
	BEGIN
		SET @AreaName = N'';
	END

	RETURN @AreaName

END


GO


