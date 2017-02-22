USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_DriveOrder]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_DriveOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- 通知信息订单状态查询
CREATE FUNCTION [dbo].[fn_pub_order_DriveOrder]
(
	@OrderID BIGINT
)
RETURNS @Order TABLE 
(
orderid INT,
code NVARCHAR (50),
Statu INT,
SrcClass int,
TotalCost DECIMAL(18,2),
customercompanyid BIGINT
)
AS
BEGIN
	DECLARE @SrcClass TINYINT;
	DECLARE @Status TINYINT;
	DECLARE @customercompanyid BIGINT;
	SET @SrcClass = 0;
	SET @Status = 0;
	SET @customercompanyid = 0;
	SELECT @Status=Index_Status ,@SrcClass = Index_SrcClass, @customercompanyid = Index_CustomerCompanyID  FROM TMS_OrderIndex WHERE Index_Id = @OrderID;

	IF EXISTS (SELECT Index_Id FROM TMS_OrderIndex WHERE Index_SrcOrderID = @OrderID)
		BEGIN
		INSERT INTO @Order SELECT  Index_Id AS [orderid],Index_Code AS [code], Index_Status AS [statu], Index_SrcClass AS [srcclass], dbo.fn_pub_order_TotalCost(Index_Id) AS [TotalCost],Index_CustomerCompanyID AS [customercompanyid] FROM TMS_OrderIndex WHERE Index_SrcOrderID = @OrderID;
		END
	ELSE
		BEGIN
			INSERT INTO @Order SELECT Index_Id AS [orderid],Index_Code AS [code], Index_Status AS [statu], Index_SrcClass AS [srcclass],dbo.fn_pub_order_TotalCost(Index_Id) AS [TotalCost],Index_CustomerCompanyID AS [customercompanyid] FROM TMS_OrderIndex WHERE Index_Id = @OrderID;
		END
		RETURN
	END	

	

GO