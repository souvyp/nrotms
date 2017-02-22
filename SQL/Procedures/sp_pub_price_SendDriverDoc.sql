USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_SendDriverDoc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_SendDriverDoc]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*发送报价单*/
CREATE PROCEDURE [dbo].[sp_pub_price_SendDriverDoc]
(
	@OpenId NVARCHAR(300),
	@DocID BIGINT = 0,
	@Type BIGINT,				-- 1 按单报价 2 按合约报价 3 补充报价 4 合单报价
	-- 按订单报价
	@OrderID BIGINT = 0,
	-- 按合同报价
	@PactCode NVARCHAR(50) = N'',
	@Name NVARCHAR(300),
	@Description NVARCHAR(1024),
	@CustomerID BIGINT,
	@LessLoadPrice DECIMAL(18,2),
	@FullLoadPrice DECIMAL(18,2),
	@PickPrice DECIMAL(18,2),
	@DeliveryPrice DECIMAL(18,2),
	@OnLoadPrice DECIMAL(18,2),
	@OffLoadPrice DECIMAL(18,2),
	@AdditionPrice DECIMAL(18,2),
	@InsuranceCost DECIMAL(18, 2), 
	@TaxPrice DECIMAL(18,2),
	@AddpriceLst NVARCHAR(MAX) = N''
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @StartTime DATETIME = NULL;
	DECLARE @EndTime DATETIME = NULL;
	DECLARE @Operator BIGINT;
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @SrcStatus BIGINT;
	DECLARE @DstStatus BIGINT;
	DECLARE @DocType BIGINT;
	DECLARE @SupplierSymbolID BIGINT;
	DECLARE @TxnRequired TINYINT = 1;
	SET @Operator = dbo.fn_pub_user_OpenId2User (@OpenId);
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @SrcStatus = 0;
	SET @DstStatus = 1;
	SET @DocType = 0;
	SET @SupplierSymbolID=0;
	
	BEGIN TRANSACTION;
	
	EXEC sp_prv_price_EditOrderDoc @Operator,@Type,@OrderID,@PactCode,@Name,@Description,@CustomerID,@StartTime,@EndTime,0,@DocID = @DocID OUTPUT,@Result = @Result OUTPUT;
	
	IF @Result = 0
	BEGIN
		IF @Type =1 OR @Type = 4
		BEGIN
			EXEC sp_prv_price_CombineOrderPrice @Operator,@DocID,@LessLoadPrice,@FullLoadPrice,@PickPrice,@DeliveryPrice,@OnLoadPrice,@OffLoadPrice,@AdditionPrice,@InsuranceCost,@TaxPrice,0, @Result = @Result OUTPUT;
		END
		ELSE
		BEGIN
			EXEC sp_prv_price_AdditionPrice @Operator,9,0,@DocID,@AddpriceLst, @Result = @Result OUTPUT;
		END
	END	
	
	IF @Result = 0 
		BEGIN
			EXEC sp_prv_price_SendDoc @Operator,@DocID,@Result = @Result OUTPUT;				
		END

	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS Price_Result;

	SET NOCOUNT OFF;
END
GO


