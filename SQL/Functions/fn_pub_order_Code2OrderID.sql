USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_Code2OrderID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_Code2OrderID]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_Code2OrderID]
(
	@devicecode NVARCHAR(20)
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT;
	
	SET @Result = 0;

	SELECT @Result = Index_ID FROM TMS_OrderIndex WHERE Index_DeviceCode = @devicecode AND Index_Invalid = 0;


	RETURN @Result;
END
GO


