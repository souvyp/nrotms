-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_DEVPosition]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_DEVPosition]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <2016.12.21>
-- Description:	<最新位置信息>
-- =============================================
CREATE FUNCTION [dbo].[fn_pub_order_DEVPosition]
(
	@devicecode NVARCHAR(20)

)
RETURNS  NVARCHAR (100)
AS
BEGIN
	DECLARE @Position  NVARCHAR (100)
	SET @Position = '';

		
			SELECT TOP 1 @Position= (CAST([b_longitude]  AS NVARCHAR(100))+','+CAST([b_latitude] AS NVARCHAR(100))) FROM [TMS_Position] WHERE [DEV_ID] = @devicecode  ORDER BY [time] DESC

	
	
	RETURN @Position;

END
GO

