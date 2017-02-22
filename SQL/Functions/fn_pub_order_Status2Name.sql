USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_Status2Name]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_Status2Name]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_Status2Name]
(
	@Status BIGINT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	RETURN (CASE 
	WHEN @Status = 0 THEN N'新单据' 
	WHEN @Status = 1 THEN N'待调度' 
	WHEN @Status = 2 THEN N'待签收' 
	WHEN @Status = 4 THEN N'待回单' 
	WHEN @Status = 8 THEN N'已回单' 
	WHEN @Status = 16 THEN N'已结账' 
	WHEN @Status = 32 THEN N'已关闭' 
	ELSE N'未知状态' END);
END
GO


