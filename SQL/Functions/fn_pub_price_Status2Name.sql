USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_price_Status2Name]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_price_Status2Name]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fn_pub_price_Status2Name]
(
	@Status BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	RETURN (CASE 
	WHEN @Status = 0 THEN N'�ݸ�' 
	WHEN @Status = 1 THEN N'�����' 
	WHEN @Status = 2 THEN N'�����' 
	WHEN @Status = 4 THEN N'�ѹر�' 
	ELSE N'δ֪״̬' END);
END


GO

