USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_GoodsLst2Tbl]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_GoodsLst2Tbl]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 拆物品参数列表
-- goodid1=2,goodid2=1;goodid11=1
CREATE FUNCTION [dbo].[fn_pub_order_GoodsLst2Tbl]
(
	@GoodsLst NVARCHAR(MAX)
)
RETURNS @tblGoods TABLE
(
	A_Lst NVARCHAR(600)
)
AS
BEGIN
	INSERT INTO @tblGoods SELECT N.v.value('.' , 'varchar(400)') FROM (
SELECT  [value] = CONVERT(XML , '<v>' + REPLACE(@GoodsLst, ';' , '</v><v>') + '</v>')) A 
CROSS APPLY A.[value].nodes('/v') N ( v );

	RETURN;
END
GO


