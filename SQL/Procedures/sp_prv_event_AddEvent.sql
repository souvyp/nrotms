USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_event_AddEvent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_event_AddEvent]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*添加通知消息*/
CREATE PROCEDURE [dbo].[sp_prv_event_AddEvent]
(
	@Operator BIGINT,
	@Type BIGINT, 
	@DstCompanyID BIGINT,
	@ProcResult BIGINT,                 -- 0 同意 1 拒绝
	@OrderID BIGINT,
	@OccurTime DATETIME,
	@Description NVARCHAR(600) = N'',
	@Result BIGINT OUTPUT,
	@EventID BIGINT OUTPUT
)
AS
BEGIN
	
	DECLARE @SrcCompanyID BIGINT;
	DECLARE @Category BIGINT;
	SET @Result = 0;
	SET @EventID = 0;
	SET @SrcCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @Category = (CASE 
WHEN @Type IN (1, 2, 9) THEN 1 
WHEN @Type IN (3, 4, 10, 16, 17, 18, 19, 20, 21) THEN 2 
WHEN @Type IN (5, 6) THEN 3 
WHEN @Type IN (7, 8, 11, 15) THEN 4 
WHEN @Type IN (12, 13, 14) THEN 5 
WHEN @Type IN (22,23,24,31) THEN 6
WHEN @Type IN (25,26,27,28,29,30) THEN 7 ELSE 0 END);
	
	-- 所有数据均在添加时间前被校验过了，此处不再验证
	INSERT INTO TMS_Events(Event_Category, Event_Type, Event_Result, Event_SrcCompanyID, Event_DstCompanyID, Event_Ext, 
Event_Time, Event_Invalid, Event_Creator, Event_InsertTime, Event_ProcessDesc) VALUES(@Category, @Type, @ProcResult, @SrcCompanyID, @DstCompanyID, 
CAST(@OrderID AS NVARCHAR), @OccurTime, 0, @Operator, GETDATE(), @Description);
	IF @@ROWCOUNT = 0
	BEGIN
		SET @Result = -1;
	END
	ELSE
	BEGIN
		SET @EventID = IDENT_CURRENT( 'TMS_Events' );
	END


END



GO


