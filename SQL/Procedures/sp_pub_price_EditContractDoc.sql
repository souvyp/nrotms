USE OTMS
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sp_pub_price_EditContractDoc') AND type in (N'P', N'PC'))
DROP PROCEDURE dbo.sp_pub_price_EditContractDoc
GO

USE OTMS
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*创建或修改报价单*/
CREATE PROCEDURE dbo.sp_pub_price_EditContractDoc
(
	@Operator BIGINT,
	@DocID BIGINT = 0,
	@Type BIGINT,	 -- 1 按单报价 2 按合约报价 3 补充报价 4 合单报价 5 合单补充报价
	-- 按订单报价
	@OrderID BIGINT = 0,
	-- 按合同报价
	@PactCode NVARCHAR(50) = N'',
	@Description NVARCHAR(MAX),
	@Name NVARCHAR(300),
	@CustomerID BIGINT,
	@StartTime DATETIME = NULL,
	@EndTime DATETIME = NULL,
	@TxnRequired TINYINT = 1,
	@LessLoadPrice NVARCHAR(MAX),
	@FullLoadPrice NVARCHAR(MAX),
	@PickPrice NVARCHAR(MAX),
	@DeliveryPrice NVARCHAR(MAX),
	@OnLoadPrice NVARCHAR(MAX),
	@OffLoadPrice NVARCHAR(MAX),
	@InsuranceCost NVARCHAR(MAX), 
	@TaxPrice NVARCHAR(MAX),
	@Issend BIGINT,
	@MinPay NVARCHAR(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @Code NVARCHAR(100);
	DECLARE @CustomerCompanyID BIGINT;
	DECLARE @SupplierSymbolID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
		
	EXEC dbo.sp_prv_price_EditOrderDoc @Operator,@Type,@OrderID, @PactCode, @Name, @Description,@CustomerID, @StartTime, @EndTime, @TxnRequired, @DocID = @DocID OUTPUT, @Result = @Result	OUTPUT;
	
	IF (LEN(@LessLoadPrice)+LEN(@FullLoadPrice)+LEN(@PickPrice)+ LEN(@DeliveryPrice)+LEN(@OnLoadPrice)+LEN(@OffLoadPrice)+LEN(@InsuranceCost)+LEN(@TaxPrice)+LEN(@MinPay))<=0
		BEGIN
			SET @Result = -520001020
		END
	IF  @Result = 0 AND LEN(@LessLoadPrice) > 0
		BEGIN
			EXEC dbo.sp_prv_price_EditContractDoc @Operator, @DocID, @CompanyID , @LessLoadPrice , @Result = @Result	OUTPUT;
				IF 	@Result <> 0
					BEGIN
						SET @Result = -520001011
					END	
		END
		
	IF @Result = 0 AND	 LEN(@FullLoadPrice) > 0	
		BEGIN
			EXEC dbo.sp_prv_price_EditContractDoc @Operator, @DocID, @CompanyID , @FullLoadPrice , @Result = @Result	OUTPUT;
			IF 	@Result <> 0
				BEGIN
					SET @Result = -520001012
				END			
		END
	
	IF @Result = 0 AND  LEN(@PickPrice) > 0	
		BEGIN
			EXEC dbo.sp_prv_price_EditContractDoc @Operator, @DocID, @CompanyID , @PickPrice , @Result = @Result	OUTPUT;
				IF 	@Result <> 0
					BEGIN
						SET @Result = -520001013
					END			
		END	
		
	IF @Result = 0 AND LEN(@DeliveryPrice) > 0	
		BEGIN
			EXEC dbo.sp_prv_price_EditContractDoc @Operator, @DocID, @CompanyID , @DeliveryPrice , @Result = @Result	OUTPUT;
				IF 	@Result <> 0
					BEGIN
						SET @Result = -520001014
					END			
		END	
	
	IF @Result = 0 AND LEN(@OnLoadPrice) > 0	
		BEGIN
			EXEC dbo.sp_prv_price_EditContractDoc @Operator, @DocID, @CompanyID , @OnLoadPrice , @Result = @Result	OUTPUT;
				IF 	@Result <> 0
				BEGIN
					SET @Result = -520001015
				END			
		END		
		
	IF @Result = 0 AND LEN(@OffLoadPrice) > 0	
		BEGIN
			EXEC dbo.sp_prv_price_EditContractDoc @Operator, @DocID, @CompanyID , @OffLoadPrice , @Result = @Result	OUTPUT;
				IF 	@Result <> 0
				BEGIN
					SET @Result = -520001016
				END			
		END	
		
			
	IF @Result = 0 AND  LEN(@InsuranceCost) > 0	
		BEGIN
			EXEC dbo.sp_prv_price_EditContractDoc @Operator, @DocID, @CompanyID , @InsuranceCost , @Result = @Result	OUTPUT;
				IF 	@Result <> 0
				BEGIN
					SET @Result = -520001017
				END			
		END	
			
	IF @Result = 0 AND LEN(@TaxPrice) > 0	
		BEGIN
			EXEC dbo.sp_prv_price_EditContractDoc @Operator, @DocID, @CompanyID , @TaxPrice , @Result = @Result	OUTPUT;
				IF 	@Result <> 0
				BEGIN
					SET @Result = -520001018
				END				
		END	
	IF @Result = 0 AND LEN(@MinPay) > 0	
		BEGIN
			EXEC dbo.sp_prv_price_EditContractDoc @Operator, @DocID, @CompanyID , @MinPay , @Result = @Result	OUTPUT;
				IF 	@Result <> 0
				BEGIN
					SET @Result = -520001019
				END				
		END												
 ---
	IF @Result = 0 AND @Issend = 1
		BEGIN
			EXEC sp_prv_price_SendDoc @Operator,@DocID,@Result = @Result OUTPUT;				
		END
		
	IF @TxnRequired = 1
	BEGIN
		IF @Result = 0
		BEGIN
			COMMIT TRANSACTION;
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION;
		END
	END

	SELECT @Result AS Price_Result, @DocID AS Doc_ID;

	SET NOCOUNT OFF;
END

	


GO


