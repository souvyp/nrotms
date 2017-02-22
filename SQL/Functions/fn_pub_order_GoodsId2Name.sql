USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_GoodsId2Name]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_GoodsId2Name]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_order_GoodsId2Name]
(
	@GoodsId BIGINT,
	@Type INT  -- 1 物品名称 2 物品类型名称
)
RETURNS NVARCHAR(300)
AS
BEGIN
	DECLARE @Name NVARCHAR(300);
	SET @Name = '';
	
	IF @Type = 1
	
	BEGIN
		SELECT @Name = Goods_Name FROM TMS_MGoods WHERE Goods_ID = @GoodsId;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Name = '';
		END
	END
	
	IF @Type = 2
	
	BEGIN
		SELECT @Name = GoodsType_Name FROM TMS_MGoods INNER JOIN TMS_MGoodsType  ON Goods_TypeID =  GoodsType_ID WHERE Goods_ID = @GoodsId;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Name = '';
		END
	END
	
	RETURN @Name;
END
GO


