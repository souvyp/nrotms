USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_ViewPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_ViewPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<TDQ>
-- Create date: <2016.12.6>
-- Description:	<²éÑ¯¼Û¸ñ>
-- =============================================
CREATE PROCEDURE [dbo].[sp_pub_price_ViewPrice]
	@OrderID BIGINT,
	@Operator BIGINT
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @DocId BIGINT;
	SET @DocId = 0;
	
	IF NOT EXISTS (SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SrcClass = 3)
		BEGIN
			SELECT 
		SUM(CASE WHEN Cache_Type = 1 THEN Cache_Amount ELSE 0 END) AS 'LessLoad',
		SUM(CASE WHEN Cache_Type = 2 THEN Cache_Amount ELSE 0 END) AS 'FullLoad',
		SUM(CASE WHEN Cache_Type = 3 THEN Cache_Amount ELSE 0 END) AS 'Pick',
		SUM(CASE WHEN Cache_Type = 4 THEN Cache_Amount ELSE 0 END) AS 'Delivery',
		SUM(CASE WHEN Cache_Type = 5 THEN Cache_Amount ELSE 0 END) AS 'OnLoad',
		SUM(CASE WHEN Cache_Type = 6 THEN Cache_Amount ELSE 0 END) AS 'OffLoad',
		SUM(CASE WHEN Cache_Type = 8 THEN Cache_Amount ELSE 0 END) AS 'InsuranceCost',
		SUM(CASE WHEN Cache_Type = 9 THEN Cache_Amount ELSE 0 END) AS 'Addition',
		SUM(CASE WHEN Cache_Type = 10 THEN Cache_Amount ELSE 0 END) AS 'Tax',
		dbo.fn_pub_order_TotalCost(Cache_OrderID) AS [TotalAmounts]
		 FROM Price_OrderCache  WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0  GROUP BY Cache_OrderID;
	 END
	 ELSE 
		BEGIN
		SELECT 
	SUM(CASE WHEN Detail_Type = 1 THEN Detail_Amount ELSE 0 END) AS 'LessLoad',
	SUM(CASE WHEN Detail_Type = 2 THEN Detail_Amount ELSE 0 END) AS 'FullLoad',
	SUM(CASE WHEN Detail_Type = 3 THEN Detail_Amount ELSE 0 END) AS 'Pick',
	SUM(CASE WHEN Detail_Type = 4 THEN Detail_Amount ELSE 0 END) AS 'Delivery',
	SUM(CASE WHEN Detail_Type = 5 THEN Detail_Amount ELSE 0 END) AS 'OnLoad',
	SUM(CASE WHEN Detail_Type = 6 THEN Detail_Amount ELSE 0 END) AS 'OffLoad',
	SUM(CASE WHEN Detail_Type = 8 THEN Detail_Amount ELSE 0 END) AS 'InsuranceCost',
	SUM(CASE WHEN Detail_Type = 9 THEN Detail_Amount ELSE 0 END) AS 'Addition',
	SUM(CASE WHEN Detail_Type = 10 THEN Detail_Amount ELSE 0 END) AS 'Tax',
	SUM(Detail_Amount) AS [TotalAmounts]
	 FROM Price_DocDetails a INNER JOIN Price_DocIndex b ON a.Detail_DOCID=b.Index_ID 
	 
	  WHERE B.Index_OrderID = @OrderID AND Detail_Invalid = 0  AND B.Index_Status = 2 AND (Detail_CreatorCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0) OR b.Index_CustomerCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0))
		
		END
	 
	 
END

GO


