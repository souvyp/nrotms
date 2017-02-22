USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_GoodsType2Name]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_GoodsType2Name]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_GoodsType2Name]
(
	@TypeID BIGINT
)
RETURNS NVARCHAR(300)
AS
BEGIN
	DECLARE @Name NVARCHAR(300);
	SET @Name = '';
	
	SELECT @Name = GoodsType_Name FROM TMS_MGoodsType WHERE GoodsType_ID = @TypeID;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @Name = '';
	END

	RETURN @Name;
END
GO


