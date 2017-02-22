USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_bill_CheckoutBalance]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_bill_CheckoutBalance]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*账单结束*/
CREATE PROCEDURE [dbo].[sp_pub_bill_CheckoutBalance]
(
	@Operator BIGINT,
	@DocID BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -530002001;
	END
	-- 是否有效对账单
	IF @Result = 0 AND @DocID =0 
	BEGIN
		SET @Result = -530002005;
	END
	-- 用户是否有权限
	IF @Result = 0 AND NOT EXISTS
	(SELECT Index_ID FROM Balance_BillIndex WHERE Index_ID = @DocID AND dbo.fn_pub_user_User2CompanyID(Index_Author,0) = @CompanyID)
	BEGIN
		SET @Result = -530002006;
	END
	-- 更新账单
	IF @Result = 0
	BEGIN
		UPDATE Balance_BillIndex SET Index_Status = 1  WHERE Index_ID = @DocID ;
		IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -530002007;
				END	 
	END
	-- 是否有权限更改订单
	IF @Result = 0 AND  EXISTS (SELECT * FROM TMS_OrderIndex  INNER JOIN Balance_BillDetails ON Index_ID = Detail_OrderID WHERE Detail_DocID = @DocID AND Index_CreatorCompanyID <> @CompanyID )
				BEGIN
					SET @Result = -530002008;
				END		
	
	-- 更改订单状态为已结账
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = 16 FROM TMS_OrderIndex INNER JOIN Balance_BillDetails ON Index_ID = Detail_OrderID WHERE Detail_DocID = @DocID ;
		IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -530002009;
				END	 
	END

	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;	
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS Bill_Result;
	
	SET NOCOUNT OFF;
END
GO


