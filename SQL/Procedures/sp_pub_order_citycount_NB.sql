USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_citycount_NB]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_citycount_NB]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- 宁波专用
CREATE PROCEDURE [dbo].[sp_pub_order_citycount_NB]
(
	@Operator BIGINT,
	@type INT
)
AS
BEGIN

	DECLARE @CompanyID INT
	DECLARE @s NVARCHAR(max) 
	Declare @sql NVARCHAR(max)
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@operator,0)
	IF @type = 1 
	BEGIN 
	SELECT r.* FROM 
(SELECT Index_EndUserName AS [基地],SUM(GoodsLst_Qty) AS [Qty],dbo.fn_pub_order_GoodsId2Name(GoodsLst_GoodsID,2) AS GoodsLst_Name FROM [OTMS].[dbo].[TMS_OrderIndex] AS A inner join dbo.TMS_OrderGoods AS B on a.Index_ID = B.GoodsLst_OrderID  WHERE Index_CreatorCompanyID = @CompanyID AND  Index_CustomerCompanyID = 534 AND Index_SrcClass = 1 AND YEAR(Index_CreateTime) = YEAR(GETDATE()) GROUP BY dbo.fn_pub_order_GoodsId2Name(GoodsLst_GoodsID,2),Index_EndUserName) as t PIVOT 
	( max(t.[Qty]) FOR t.GoodsLst_Name in (制动器,减震器,助力器,其它产品)) AS r ORDER BY r.[基地] DESC
	END
	
	IF @type = 2 
	
	BEGIN 
	
	SELECT r.* FROM 
(SELECT Index_EndUserName AS [基地],SUM(GoodsLst_Qty) AS [Qty],dbo.fn_pub_order_GoodsId2Name(GoodsLst_GoodsID,2) AS GoodsLst_Name FROM [OTMS].[dbo].[TMS_OrderIndex] AS A inner join dbo.TMS_OrderGoods AS B on a.Index_ID = B.GoodsLst_OrderID  WHERE Index_CreatorCompanyID = @CompanyID AND  Index_CustomerCompanyID = 534 AND Index_SrcClass = 1 AND MONTH(Index_CreateTime) = MONTH(GETDATE()) AND YEAR(Index_CreateTime) = YEAR(GETDATE()) GROUP BY dbo.fn_pub_order_GoodsId2Name(GoodsLst_GoodsID,2),Index_EndUserName) as t PIVOT 
	( max(t.[Qty]) FOR t.GoodsLst_Name in (制动器,减震器,助力器,其它产品)) AS r ORDER BY r.[基地] DESC
	
	END
	
	IF @type = 3 
	
	BEGIN 
	
	
	SELECT r.* FROM 
(SELECT Index_EndUserName AS [基地],SUM(GoodsLst_Qty) AS [Qty],dbo.fn_pub_order_GoodsId2Name(GoodsLst_GoodsID,2) AS GoodsLst_Name FROM [OTMS].[dbo].[TMS_OrderIndex] AS A inner join dbo.TMS_OrderGoods AS B on a.Index_ID = B.GoodsLst_OrderID  WHERE Index_CreatorCompanyID = @CompanyID AND  Index_CustomerCompanyID = 534 AND Index_SrcClass = 1 AND DAY(Index_CreateTime) = DAY(GETDATE())-1 AND MONTH(Index_CreateTime) = MONTH(GETDATE()) AND YEAR(Index_CreateTime) = YEAR(GETDATE()) GROUP BY dbo.fn_pub_order_GoodsId2Name(GoodsLst_GoodsID,2),Index_EndUserName) as t PIVOT 
	( max(t.[Qty]) FOR t.GoodsLst_Name in (制动器,减震器,助力器,其它产品)) AS r ORDER BY r.[基地] DESC
	
	
	END	
	   


END


GO


