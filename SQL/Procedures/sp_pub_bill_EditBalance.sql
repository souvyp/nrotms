USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_bill_EditBalance]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_bill_EditBalance]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*添加或修改对账单*/
CREATE PROCEDURE [dbo].[sp_pub_bill_EditBalance]
(
	@Operator BIGINT,
	@Customerid BIGINT,
	@Supplierid BIGINT,
	@Code NVARCHAR(100),
	@No NVARCHAR(100), 
	@Amount DECIMAL(18,2),
	@DocID BIGINT,
	@OrdersLst NVARCHAR(MAX),
	@BillType INT, -- 对账单表加对账类型 1 应收 2 应付
	@Description NVARCHAR(500)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	
	DECLARE @RootDocID BIGINT;
	SET @Result = 0;
	IF @DocID IS NULL
	BEGIN
		SET @DocID = 0;
	END
	SET @RootDocID = @DocID;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -530002001;
	END

	
	IF @Result = 0
	BEGIN
		IF @DocID > 0
		BEGIN
			UPDATE Balance_BillIndex SET Index_CustomerID = @customerid, Index_SupplierID = @supplierid, Index_Code = @code, Index_No = @no, Index_Amount = @amount, Index_Description = @Description WHERE Index_ID = @DocID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -530002002;
			END
		END
		ELSE
		BEGIN
			INSERT INTO Balance_BillIndex(Index_CustomerID, Index_SupplierID, Index_Code, Index_No, Index_Amount, Index_Description, Index_Status, Index_Author,Index_BillType) VALUES(@customerid, @supplierid, @code, @no, @amount, @Description, 0, @Operator,@BillType );
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -530002003;
			END
			ELSE
			BEGIN
				SET @DocID = IDENT_CURRENT('Balance_BillIndex');
			END
		END
	END
	-- 处理订单
		-- 如果详单记录 先删除
		IF @RootDocID > 0
		BEGIN		

			BEGIN
				DELETE FROM Balance_BillDetails WHERE Detail_DocID = @DocID;

			END
		END
		
		IF @Result = 0
		BEGIN
			DECLARE @tblOrders TABLE
			(
				OrderID BIGINT
			);
			INSERT INTO @tblOrders SELECT CAST(N.v.value('.' , 'varchar(100)') AS BIGINT) FROM (SELECT  [value] = CONVERT(XML , '<v>' + REPLACE(@OrdersLst, ',' , '</v><v>') + '</v>')) A CROSS APPLY A.[value].nodes('/v') N ( v );

			-- 添加账单详情
			-- orderid1,orderid2,orderid3
			INSERT INTO Balance_BillDetails(Detail_DocID, Detail_OrderID, Detail_Code, Detail_PactCode, Detail_FromProvince, Detail_FromCity, Detail_ToProvince,Detail_ToCity, Detail_Volume, Detail_Weight, Detail_Amount, Detail_ReceiptQty, Detail_Description, Detail_LessLoad, Detail_FullLoad, 
Detail_Pick, Detail_Delivery, Detail_OnLoad, Detail_OffLoad, Detail_Min, Detail_Addition, Detail_Insurance, Detail_Tax, Detail_Total, 
Detail_Author, Detail_InsertTime, Detail_Invalid) SELECT @DocID, a.Index_ID,a.Index_Code,A.Index_PactCode,a.Index_FromProvince,a.Index_FromCity,a.Index_ToProvince,a.Index_ToCity,dbo.fn_pub_order_TotalVolume(Index_ID,0),dbo.fn_pub_order_TotalWeight(Index_ID,0),dbo.fn_pub_order_TotalAmount(Index_ID,0),dbo.fn_pub_order_TotalAmount(Index_ID,1),Index_Description,dbo.fn_pub_price_PricebyType(A.Index_ID,1) ,dbo.fn_pub_price_PricebyType(A.Index_ID,2) ,dbo.fn_pub_price_PricebyType(A.Index_ID,3) ,dbo.fn_pub_price_PricebyType(A.Index_ID,4),dbo.fn_pub_price_PricebyType(A.Index_ID,5) ,dbo.fn_pub_price_PricebyType(A.Index_ID,6),dbo.fn_pub_price_PricebyType(A.Index_ID,7),dbo.fn_pub_price_PricebyType(A.Index_ID,9),dbo.fn_pub_price_PricebyType(A.Index_ID,8),dbo.fn_pub_price_PricebyType(A.Index_ID,10),dbo.fn_pub_order_TotalCost(Index_ID),@Operator,GETDATE(),0  FROM TMS_OrderIndex AS a INNER JOIN @tblOrders AS b ON a.Index_ID = b.OrderID WHERE Index_Invalid = 0 
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -530002004;
			END
		END	
	--
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;	
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS Bill_Result, @DocID AS Detail_ID;
	
	SET NOCOUNT OFF;
END
GO


