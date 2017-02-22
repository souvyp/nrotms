USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_user_SymbolName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_user_SymbolName]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_pub_user_SymbolName]
(
	@SymbolID BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @SymbolName NVARCHAR(100);

	SELECT @SymbolName=Symbol_Name FROM TMS_MSymbol WHERE Symbol_ID = @SymbolID AND Symbol_Invalid = 0;
	IF @@ROWCOUNT=0
	BEGIN
		SET @SymbolName=N'';
	END

	RETURN @SymbolName
END

GO


