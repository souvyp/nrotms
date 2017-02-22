USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_SignDriverOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_SignDriverOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
签收订单
GoodsQty的格式：
goods_list_id1=receipt_qty1,exception_qty1;goods_list_id2=receipt_qty2,exception_qty2
*/
CREATE PROCEDURE [dbo].[sp_pub_order_SignDriverOrder]
(
	@OpenId NVARCHAR(300),
	@OrderID BIGINT,
	@Exception NVARCHAR(512),
	@GoodsQty VARCHAR(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Operator BIGINT;
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Operator = dbo.fn_pub_user_OpenId2User (@OpenId);
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	BEGIN TRANSACTION;

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510019001;
	END
	
	IF @GoodsQty IS NOT NULL AND @GoodsQty <> ''
	BEGIN
		SET @GoodsQty = REPLACE(@GoodsQty, ':', '=');
	END

	-- 当前用户没有签收订单的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510019002;
	END
	
	-- 订单是否存在
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Invalid = 0)
	BEGIN
		SET @Result = -510019003;
	END
	
	-- 订单是否已经被签收
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Status = 2 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -510019004;
	END
	
	-- 签收订单
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = 4, Index_StatusTime = GETDATE(), Index_Singer = @Operator, Index_SignTime = GETDATE(), Index_Exception = @Exception WHERE Index_ID = @OrderID AND Index_Invalid = 0 ANd Index_Status = 2;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510019005;
		END
	END
	
	-- 添加订单流程
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 2, 4, @Operator, @CompanyID, GETDATE(), 0);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510019006;
		END
	END
	
	-- 添加实签数量，异常数量
	IF @Result = 0 AND @GoodsQty IS NOT NULL AND @GoodsQty <> ''
	BEGIN
		-- 解析参数
		DECLARE @tblActual TABLE
		(
			A_ID BIGINT,
			A_Amount DECIMAL(18,2),
			A_Exception DECIMAL(18,2)
		);
		INSERT INTO @tblActual(A_ID, A_Amount, A_Exception) SELECT B.ID, B.Amount, B.Exception FROM (
SELECT  [value] = CONVERT(XML , '<v>' + REPLACE(@GoodsQty , ';' , '</v><v>') + '</v>')) A CROSS APPLY (SELECT 
ID = SUBSTRING(N.v.value('.' , 'varchar(100)'), 1, charindex( '=', N.v.value('.' , 'varchar(100)')) - 1 ), 
Amount = SUBSTRING(N.v.value('.' , 'varchar(100)'), charindex( '=', N.v.value('.' , 'varchar(100)')) + 1, charindex( ',', N.v.value('.' , 'varchar(100)')) - charindex( '=', N.v.value('.' , 'varchar(100)')) - 1), 
Exception = SUBSTRING(N.v.value('.' , 'varchar(100)'), charindex( ',', N.v.value('.' , 'varchar(100)')) + 1, LEN(N.v.value('.' , 'varchar(100)'))) FROM A.[value].nodes('/v') N ( v ) ) B;

		-- 更新实签数量，异常数量
		UPDATE TMS_OrderGoods SET GoodsLst_ReceiptQty = (SELECT TOP 1 t1.A_Amount  FROM @tblActual AS t1 WHERE t1.A_ID = GoodsLst_ID), 
GoodsLst_ExceptionQty = (SELECT TOP 1 t2.A_Exception FROM @tblActual AS t2 WHERE t2.A_ID = GoodsLst_ID), GoodsLst_Updater = @Operator, 
GoodsLst_UpdateTime = GETDATE() WHERE GoodsLst_OrderID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510019007;
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

	SELECT @Result AS Order_Result;

	SET NOCOUNT OFF;
END

GO


