USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_prv_event_ModuleMatch]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_prv_event_ModuleMatch]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 检查事件类型与系统模块是否匹配
-- 系统模块定义请见sp_pub_event_EventList
-- 事件类型定义请见TMS_Event表
CREATE FUNCTION [dbo].[fn_prv_event_ModuleMatch]
(
	@EventType BIGINT,
	@Module BIGINT
)
RETURNS TINYINT
AS
BEGIN
	DECLARE @Result TINYINT;
	SET @Result = 0;
	
	-- TMS:@Module = 1
	IF @Module & 1 = 1 AND @EventType IN (1,2,3,4,5,6,9,10,12,13,14,16,17,18,19,20,21,25,26,27,28,29,30)
	BEGIN
		SET @Result = 1;
	END
	
	-- PMS:@Module = 2
	IF @Module & 2 = 2 AND @EventType IN (1,2,7,8,9,11,15,25,26,27,28,29,30)
	BEGIN
		SET @Result = 1;
	END
	
	-- GMS:@Module = 3
	IF @Module & 2 = 4 AND @EventType IN (22,23,24)
	BEGIN
		SET @Result = 1;
	END 

	RETURN @Result;
END
GO


