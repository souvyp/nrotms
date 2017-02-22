USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_EndUser2Customer]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_EndUser2Customer]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_user_EndUser2Customer]
(
	@EndUserID BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @CustomerID BIGINT;
	SET @CustomerID = 0;
	
	SELECT @CustomerID = EndUser_CustomerID FROM TMS_MEndUser WHERE EndUser_ID = @EndUserID AND EndUser_Invalid = 0;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @CustomerID = 0;
	END
	
	RETURN @CustomerID;
END
GO


