USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_OrderPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_OrderPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*查询订单价格*/
CREATE PROCEDURE [dbo].[sp_prv_order_OrderPrice]
(
	@Operator NVARCHAR(300),
	@OrderID BIGINT,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	
	DECLARE @CompanyID BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510038002;
	END

	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510038003;
	END

    SELECT @Result AS [Price_Result];
	WITH T AS (SELECT Cache_OrderID AS [OrderID], 
	SUM(CASE WHEN Cache_Type = 1 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [LessLoad],
	SUM(CASE WHEN Cache_Type = 1 THEN ISNULL(Cache_DocID, 0) ELSE 0 END) AS [LessLoadDocID],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 1 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),1) AS [LessLoadDocCode],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 1 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),2) AS [LessLoadDocIDName],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 1 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),3) AS [LessLoadDocType],			
	SUM(CASE WHEN Cache_Type = 2 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [FullLoad],
	SUM(CASE WHEN Cache_Type = 2 THEN ISNULL(Cache_DocID, 0) ELSE 0 END) AS [FullLoadDocID],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 2 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),1) AS [FullLoadDocCode],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 2 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),2) AS [FullLoadDocIDName],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 2 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),3) AS [FullLoadDocType],			
	SUM(CASE WHEN Cache_Type = 3 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [Pick], 
	SUM(CASE WHEN Cache_Type = 3 THEN ISNULL(Cache_DocID, 0) ELSE 0 END) AS [PickDocID],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 3 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),1) AS [PickDocCode], 
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 3 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),2) AS [PickDocIDName], 	
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 3 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),3) AS [PickDocIDType], 		
	SUM(CASE WHEN Cache_Type = 4 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [Delivery],
	SUM(CASE WHEN Cache_Type = 4 THEN ISNULL(Cache_DocID, 0) ELSE 0 END) AS [DeliveryDocID],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 4 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),1) AS [DeliveryDocCode],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 4 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),2) AS [DeliveryDocIDName],	
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 4 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),3) AS [DeliveryDocType],	
	SUM(CASE WHEN Cache_Type = 5 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [OnLoad],
	SUM(CASE WHEN Cache_Type = 5 THEN ISNULL(Cache_DocID, 0) ELSE 0 END) AS [OnLoadDocID],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 5 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),1) AS [OnLoadDocCode],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 5 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),2) AS [OnLoadDocIDName],	
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 5 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),3) AS [OnLoadDocType],		
	SUM(CASE WHEN Cache_Type = 6 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [OffLoad],
	SUM(CASE WHEN Cache_Type = 6 THEN ISNULL(Cache_DocID, 0) ELSE 0 END) AS [OffLoadDocID],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 6 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),1) AS [OffLoadDocCode],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 6 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),2) AS [OffLoadDocIDName],	
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 6 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),3) AS [OffLoadDocType],		
	SUM(CASE WHEN Cache_Type = 7 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [Min],
	SUM(CASE WHEN Cache_Type = 7 THEN ISNULL(Cache_DocID, 0) ELSE 0 END) AS [MinDocID],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 7 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),1) AS [MinDocCode],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 7 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),2) AS [MinDocIDName],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 7 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),3) AS [MinDocType],		
	SUM(CASE WHEN Cache_Type = 8 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [InsuranceCost],
	SUM(CASE WHEN Cache_Type = 8 THEN ISNULL(Cache_DocID, 0) ELSE 0 END) AS [InsuranceCostDocID],	
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 8 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),1) AS [InsuranceCostDocCode],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 8 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),2) AS [InsuranceCostDocIDName],	
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 8 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),3) AS [InsuranceCostDocType],		
	SUM(CASE WHEN Cache_Type = 9 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [Addition],	
	SUM(CASE WHEN Cache_Type = 10 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [Tax],
	SUM(CASE WHEN Cache_Type = 10 THEN ISNULL(Cache_DocID, 0) ELSE 0 END) AS [TaxDocID],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 10 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),1) AS [TaxDocCode],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 10 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),2) AS [TaxDocIDName],
	dbo.fn_pub_price_DocID2Code (SUM(CASE WHEN Cache_Type = 10 THEN ISNULL(Cache_DocID, 0) ELSE 0 END),3) AS [TaxDocType]
			 FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0 GROUP BY Cache_OrderID)
				 
	SELECT LessLoad, LessLoadDocID,LessLoadDocCode, LessLoadDocIDName,LessLoadDocType, FullLoad,FullLoadDocID,FullLoadDocCode,FullLoadDocIDName,FullLoadDocType, Pick, PickDocID,PickDocCode,PickDocIDName,PickDocIDType, Delivery,DeliveryDocID,DeliveryDocCode,DeliveryDocIDName,DeliveryDocType, OnLoad, OnLoadDocID,OnLoadDocCode,OnLoadDocIDName,OnLoadDocType, OffLoad,OffLoadDocID, OffLoadDocCode,OffLoadDocIDName,OffLoadDocType,[Min],MinDocID,MinDocCode,MinDocIDName,MinDocType, InsuranceCost,InsuranceCostDocID,InsuranceCostDocCode,InsuranceCostDocIDName,InsuranceCostDocType,Addition, [Tax],TaxDocID,TaxDocCode,TaxDocIDName,TaxDocType, dbo.fn_pub_order_TotalCost(OrderID) AS Total FROM T;
	SELECT Cache_Amount AS [AdditionDetail],Cache_DocID AS [AdditionDocID],dbo.fn_pub_price_DocID2Code(Cache_DocID, 1) AS [AdditionDocCode],dbo.fn_pub_price_DocID2Code(Cache_DocID, 2) AS [AdditionDocIDName],dbo.fn_pub_price_DocID2Code (Cache_DocID,3) AS [AdditionType],Cache_OrderID AS [OrderID] FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0 AND Cache_Type = 9 ;
	--WITH B AS (SELECT (CASE WHEN Cache_Type = 9 THEN Cache_Amount ELSE 0 END) AS [AdditionDetail],dbo.fn_pub_price_DocID2Code(CASE WHEN Cache_Type = 9 THEN Cache_Amount ELSE 0 END) AS [AdditionDocID] FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0)	SELECT [AdditionDetail],[AdditionDocID] FROM B ;

		

END

GO


