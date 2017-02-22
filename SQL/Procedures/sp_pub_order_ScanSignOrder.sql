USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_ScanSignOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_ScanSignOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 扫描码签收
/*
签收订单
GoodsQty的格式：
goods_list_id1=receipt_qty1,exception_qty1;goods_list_id2=receipt_qty2,exception_qty2
*/
CREATE PROCEDURE [dbo].[sp_pub_order_ScanSignOrder]
(
	@OrderID BIGINT,
	@Exception NVARCHAR(512),
	@GoodsQty VARCHAR(MAX),
	@OpenID NVARCHAR(512) = N'',
	@DeviceCode NVARCHAR(512) = N'',
	@ReceiptDocPath0 NVARCHAR(512) = N'',
	@ReceiptDocPath1 NVARCHAR(512) = N'',
	@ReceiptDocPath2 NVARCHAR(512) = N'',
	@ReceiptDocPath3 NVARCHAR(512) = N''
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @FromCompanyID BIGINT;
	DECLARE @SrcOrderID BIGINT;
	SET @FromCompanyID = 0;
	SET @SrcOrderID = 0;
	SET @Result = 0;
	
	
	
	
	BEGIN TRANSACTION;


	
	-- 订单是否存在
	IF @Result = 0 
	BEGIN
		SELECT @FromCompanyID = Index_CustomerCompanyID, @SrcOrderID = Index_SrcOrderID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0
		IF @@ROWCOUNT = 0
		BEGIN
		SET @Result = -510019003;
		END
	END	
	
	
	-- 订单是否已经被签收
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Status = 2 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -510019004;
	END
	
	-- 签收订单 上传照片
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = 4, Index_StatusTime = GETDATE(), Index_Singer = 1,Index_ReceiptDoc = @ReceiptDocPath0, Index_ReceiptDoc1 = @ReceiptDocPath1, Index_ReceiptDoc2 = @ReceiptDocPath2, Index_ReceiptDoc3 = @ReceiptDocPath3,  Index_SignTime = GETDATE(), Index_Exception = @Exception WHERE Index_ID = @OrderID AND Index_Invalid = 0 ANd Index_Status = 2;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510019005;
		END
	END
	
	-- 添加订单流程
	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid, Flow_Comments) VALUES(
@OrderID, 2, 4, 1, 0, GETDATE(), 0,@OpenID);
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
GoodsLst_ExceptionQty = (SELECT TOP 1 t2.A_Exception FROM @tblActual AS t2 WHERE t2.A_ID = GoodsLst_ID), GoodsLst_Updater = 1, 
GoodsLst_UpdateTime = GETDATE() WHERE GoodsLst_OrderID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510019007;
		END
	END
	
	--添加事件通知
	--承运商订单状态变更 类型 16
	IF @Result = 0
	BEGIN
		DECLARE @tmpResult BIGINT;
		DECLARE @EventID BIGINT;
		DECLARE @OccurTime DATETIME;
		SET @tmpResult = 0;
		SET @EventID = 0;
		SET @OccurTime = GETDATE();
		
		EXEC sp_prv_event_AddEvent 1, 16, @FromCompanyID, 0, @SrcOrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
		IF @tmpResult <> 0 
		BEGIN
			SET @Result = -510052008;
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


