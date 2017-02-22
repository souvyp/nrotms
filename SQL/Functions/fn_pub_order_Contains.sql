USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_Contains]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_Contains]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- 合单订单转换
CREATE FUNCTION [dbo].[fn_pub_order_Contains]
(
	@orderid BIGINT,
	@type INT  -- 1 体积 2 重量 3 数量 4 发货地址 5 收货地址 6发货时间 7 到货时间 
)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @ContainsTran NVARCHAR(50);
	SET @ContainsTran = '';
	
	IF @type = 1 
	BEGIN
		SELECT @ContainsTran = SUM(Contains_Volume) FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @orderid
	END
	
	ELSE IF @type = 2
	BEGIN
		SELECT @ContainsTran = SUM(Contains_Weight) FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @orderid
	END
	
	ELSE IF @type = 3
	BEGIN
		SELECT @ContainsTran = SUM(Contains_Amount) FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @orderid
	END
	
	ELSE IF @type = 4
	BEGIN
		SELECT @ContainsTran = SUM(1) FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @orderid
	END
	
	ELSE IF @type = 5
	BEGIN
		SELECT @ContainsTran = SUM(1) FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @orderid
	END
	
	ELSE IF @type = 6
	BEGIN
		SELECT TOP 1 @ContainsTran = CONVERT(varchar(16),Index_FromTime,120) FROM TMS_OrderIndex INNER JOIN TMS_OrderContains ON Index_ID = Contains_OrderID WHERE Contains_OwnerOrderID = @orderid ORDER BY Index_FromTime ASC
	END
	
	ELSE IF @type = 7
	BEGIN
		SELECT TOP 1 @ContainsTran = CONVERT(varchar(16),Index_ToTime, 120) FROM TMS_OrderIndex INNER JOIN TMS_OrderContains ON Index_ID = Contains_OrderID WHERE Contains_OwnerOrderID = @orderid ORDER BY Index_ToTime DESC
	END
	
	ELSE IF @type = 8
	BEGIN
		SELECT @ContainsTran = SUM(1) FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @orderid
	END
		
		

	RETURN @ContainsTran;
END
GO


