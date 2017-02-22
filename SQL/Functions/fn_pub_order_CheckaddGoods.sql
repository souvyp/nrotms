USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_CheckAddGoods]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_CheckAddGoods]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_pub_order_CheckAddGoods]
(
	@CheckItem NVARCHAR(MAX),
	@Type BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @Name1 NVARCHAR(MAX);
	DECLARE @Name2 NVARCHAR(MAX);
	DECLARE @Name3 NVARCHAR(MAX);
	DECLARE @LENG BIGINT;
	
	IF @Type =1 
	BEGIN
	SELECT @Name1 = REPLACE(@CheckItem,',','');
	SELECT @Name2 = REPLACE(@Name1,';','');
	SELECT @Name3 = REPLACE(@Name2,' ','');
	SELECT @CheckItem = REPLACE(@Name3,'|','');
	SELECT @LENG=datalength(@CheckItem);
	END
	ELSE 
	BEGIN
	SELECT @Name1 = REPLACE(@CheckItem,',','');
	SELECT @Name2 = REPLACE(@Name1,';','');
	SELECT @CheckItem = REPLACE(@Name2,' ','');
	SELECT @LENG=datalength(@CheckItem);
	END

	RETURN @LENG ;
END

GO


