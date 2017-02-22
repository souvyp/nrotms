USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_District2ProvinceID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_District2ProvinceID]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_District2ProvinceID]
(
	@DistrictID BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @CityID BIGINT;
	DECLARE @ProvinceID BIGINT;
	SET @CityID = 0;
	SET @ProvinceID = 0;
	
	SELECT @CityID = Area_ParentID FROM TMS_BasicArea WHERE Area_ID = @DistrictID AND Area_NodeType = 3 AND Area_Invalid = 0;
	IF @CityID <> 0
	BEGIN
		SELECT @ProvinceID = Area_ParentID FROM TMS_BasicArea WHERE Area_ID = @CityID AND Area_NodeType = 2 AND Area_Invalid = 0;
	END

	RETURN @ProvinceID;
END
GO


