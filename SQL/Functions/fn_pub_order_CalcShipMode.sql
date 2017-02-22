USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_CalcShipMode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_CalcShipMode]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_CalcShipMode]
(
	@Operator BIGINT,
	@CompanyID BIGINT,
	@FromProvince BIGINT,
	@FromCity BIGINT,
	@ToProvince BIGINT,
	@ToCity BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @ShipMode BIGINT;
	DECLARE @SetProvince BIGINT;
	DECLARE @SetCity BIGINT;
	SET @ShipMode = 1;
	SET @SetCity = 0;
	SET @SetProvince = 0;
	
	IF @FromProvince = @ToProvince AND @FromCity = @ToCity
	BEGIN
		-- ÊÐÄÚ
		SELECT @SetProvince = ISNULL(Company_ProvinceID, 0), @SetCity = ISNULL(Company_CityID, 0) FROM TMS_Company WHERE Company_ID = @CompanyID;
		IF @@ROWCOUNT > 0
		BEGIN
			IF @SetProvince = 0 OR @SetCity = 0
			BEGIN
				SET @ShipMode = 1;
			END
			ELSE
			BEGIN
				IF @ToProvince <> @SetProvince OR @ToCity <> @SetCity
				BEGIN
					SET @ShipMode = 2;
				END
				ELSE
				BEGIN
					SET @ShipMode = 1;
				END
			END
		END
		ELSE
		BEGIN
			SET @ShipMode = 1;
		END
	END
	ELSE
	BEGIN
		-- ³¤Í¾
		SET @ShipMode = 2;
	END

	RETURN @ShipMode;
END
GO


