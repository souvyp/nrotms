USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_event_EventList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_event_EventList]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- 获取指定数量的事件
CREATE PROCEDURE [dbo].[sp_pub_event_EventList]
(
	@Operator BIGINT,
	@Amount BIGINT,
	@Module BIGINT = 1				-- 系统模块(支持OR): 1 TMS 2 PMS 4 GMS
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @ProcessTime DATETIME;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @ProcessTime = GETDATE();
	
	IF @Amount <= 0
	BEGIN
		SET @Amount = 1;
	END
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510027001;
	END
	
	-- 当前用户没有获取事件的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510027002;
	END
	
	BEGIN TRANSACTION;

	-- 事件总数量
	IF @Result = 0
	BEGIN
		SELECT COUNT(*) AS Event_Count, @Result AS Event_Result FROM TMS_Events WHERE Event_DstCompanyID = @CompanyID AND Event_Processed = 0 AND 
Event_Invalid = 0 AND dbo.fn_prv_event_CheckPmis(@Operator, Event_Type) = 1 AND dbo.fn_prv_event_ModuleMatch(Event_Type, @Module) = 1 AND ((Event_DstCompanyID<>Event_SrcCompanyID AND Event_Ext <> 0)  OR Event_Type in(1,2,9, 21) );
	END
	ELSE
	BEGIN
		SELECT 0 AS Event_Count, @Result AS Event_Result;
	END
	
	-- 事件锁定
	IF @Result = 0
	BEGIN
		UPDATE TOP (@Amount) TMS_Events SET Event_Processor = @Operator, Event_Processed = 1, Event_ProcessTime = @ProcessTime WHERE 
Event_DstCompanyID = @CompanyID AND Event_Processed = 0 AND Event_Invalid = 0 AND dbo.fn_prv_event_CheckPmis(@Operator, Event_Type) = 1 AND dbo.fn_prv_event_ModuleMatch(Event_Type, @Module) = 1 AND ((Event_DstCompanyID<>Event_SrcCompanyID  AND  Event_Ext <> 0)  OR  Event_Type in(1,2,9,21)) ;
	END
	
	-- 选取锁定的事件
	IF @Result = 0
	BEGIN
		SELECT TOP (@Amount) a.Event_Category, a.Event_Type, a.Event_Result, a.Event_SrcCompanyID, dbo.fn_pub_user_Company2Name(a.Event_SrcCompanyID) AS Event_SrcCompanyName, 
a.Event_DstCompanyID, dbo.fn_pub_user_Company2Name(a.Event_DstCompanyID) AS Event_DstCompanyName, a.Event_Ext, CONVERT(VARCHAR(100),a.Event_Time,111) AS Event_Time, 
a.Event_InsertTime, dbo.fn_pub_order_IsLongDistance(ISNULL(CAST(ISNULL(a.Event_Ext, '') AS BIGINT), 0)) AS [IsDistance], a.Event_ProcessDesc AS [Desc], 
ISNULL(b.Index_Type, 0) AS [Doc_Type], ISNULL(b.Index_SupplierSymbolID, 0) AS [Symbol_ID] FROM TMS_Events AS a 
LEFT JOIN Price_DocIndex AS b ON a.Event_Category = 4 AND a.Event_Ext = b.Index_ID 
WHERE a.Event_Processor = @Operator AND a.Event_ProcessTime = @ProcessTime AND a.Event_Processed = 1 AND a.Event_Invalid = 0;
	END
	
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END
	
	SET NOCOUNT OFF;
END

GO


