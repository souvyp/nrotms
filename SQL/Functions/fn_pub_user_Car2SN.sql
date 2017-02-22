USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_Car2SN]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_Car2SN]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION  [dbo].[fn_pub_user_Car2SN]
(
	-- Add the parameters for the function here
	@CarID BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @CarSN NVARCHAR(300);

	-- Add the T-SQL statements to compute the return value here
	SELECT @CarSN = [Car_SN] FROM TMS_MCar WHERE [Car_ID] = @CarID  AND Car_Invalid = 0;
	
	IF @@ROWCOUNT = 0
	BEGIN
		SET @CarSN = N'';
	END
	-- Return the result of the function
	RETURN @CarSN

END

GO


