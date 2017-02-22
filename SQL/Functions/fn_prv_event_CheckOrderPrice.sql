USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_prv_event_CheckOrderPrice]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_prv_event_CheckOrderPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 检查用户是否有获取当前事件的权限
CREATE FUNCTION [dbo].[fn_prv_event_CheckOrderPrice]
(
	@OrderID BIGINT,
	@EventType BIGINT
)
RETURNS TINYINT
AS
BEGIN
	DECLARE @Result TINYINT;
	DECLARE @Pick TINYINT;
	DECLARE @Delivery TINYINT;
	DECLARE @OnLoad TINYINT;
	DECLARE @OffLoad TINYINT;
	DECLARE @Insurance TINYINT;

	SET @Result=0;
	SELECT @Pick=Index_Pick,@Delivery=Index_Delivery,@OnLoad=Index_OnLoad,@OffLoad=Index_OffLoad,@Insurance=Index_Insurance FROM TMS_OrderIndex WHERE Index_ID=@OrderID

	IF @EventType = 25 
	BEGIN
		IF NOT EXISTS
		(SELECT SUM(CASE WHEN Cache_Type IN (1, 2) THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [LessLoad]	FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0 GROUP BY Cache_OrderID)
		BEGIN
			SET @Result = 1;
		END
	END
	ELSE
	BEGIN
		
		IF @EventType = 26 AND @Pick = 1 AND NOT EXISTS(SELECT SUM(CASE WHEN Cache_Type = 3 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [Amount] FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0 GROUP BY Cache_OrderID)
		BEGIN
			SET @Result = 1;
		END	
	
		IF  @EventType = 27 AND @Delivery = 1 AND NOT EXISTS(SELECT	SUM(CASE WHEN Cache_Type = 4 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [Delivery] FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0 GROUP BY Cache_OrderID)
		BEGIN
			SET @Result = 1;
		END	
		
		IF @EventType = 28 AND @OnLoad =1 AND NOT EXISTS(SELECT	SUM(CASE WHEN Cache_Type = 5 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [OnLoad] FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0 GROUP BY Cache_OrderID)
		BEGIN
			SET @Result = 1;
		END	
	
		IF @EventType = 29 AND @OffLoad = 1 AND NOT EXISTS(SELECT SUM(CASE WHEN Cache_Type = 6 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [OffLoad] FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0 GROUP BY Cache_OrderID)
		BEGIN
			SET @Result = 1;
		END	

		IF @EventType = 30 AND @Insurance = 1 AND NOT EXISTS(SELECT	SUM(CASE WHEN Cache_Type = 8 THEN ISNULL(Cache_Amount, 0) ELSE 0 END) AS [InsuranceCost] FROM Price_OrderCache WHERE Cache_OrderID = @OrderID AND Cache_Invalid = 0 GROUP BY Cache_OrderID)
		BEGIN
			SET @Result = 1;
		END	
		
	END
	RETURN @Result;
END
GO


