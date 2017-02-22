USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_event_CountByType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_event_CountByType]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*分类型获取事件或待办数量*/
CREATE PROCEDURE [dbo].[sp_pub_event_CountByType]
(
	@Operator BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @CompanyID BIGINT;
	DECLARE @_Recv BIGINT;
	DECLARE @_Schedule BIGINT;
	DECLARE @_ScheduleIn BIGINT;
	DECLARE @_ScheduleLong BIGINT;
	DECLARE @_ScheduleComb BIGINT;
	DECLARE @_Sign BIGINT;
	DECLARE @_Receipt BIGINT;
	DECLARE @_Confirm BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @_Recv = 0;
	SET @_Schedule = 0;
	SET @_ScheduleIn = 0;
	SET @_ScheduleLong = 0;
	SET @_ScheduleComb = 0;
	SET @_Sign = 0;
	SET @_Receipt = 0;
	SET @_Confirm = 0;

	-- 待接收订单数量
	SELECT @_Recv = COUNT(*) FROM TMS_OrderIndex WHERE Index_SupplierCompanyID = @CompanyID AND (Index_SrcClass = 2 OR Index_SrcClass = 3) AND 
Index_Status = 1 AND Index_Invalid = 0 AND Index_Combined = 0;

    -- 待调度计单
	SELECT @_Schedule = COUNT(*) FROM TMS_OrderIndex WHERE Index_CreatorCompanyID = @CompanyID AND Index_SupplierCompanyID = 0 AND (Index_SrcClass = 2 OR Index_SrcClass = 3) AND Index_Status = 1 AND Index_Invalid = 0 AND Index_Combined = 0;
	
	-- 待市内调度计单
	SELECT @_ScheduleIn = COUNT(*) FROM TMS_OrderIndex WHERE Index_CreatorCompanyID = @CompanyID AND Index_SupplierCompanyID = 0 AND Index_SrcClass = 2 AND Index_Status = 1 AND Index_Invalid = 0 AND Index_Combined = 0 AND Index_ShipMode=1;
	
	-- 待长途调度计单
	SELECT @_ScheduleLong = COUNT(*) FROM TMS_OrderIndex WHERE Index_CreatorCompanyID = @CompanyID AND Index_SupplierCompanyID = 0 AND Index_SrcClass = 2 AND Index_Status = 1 AND Index_Invalid = 0 AND Index_Combined = 0 AND Index_ShipMode=2;
	
	-- 待拼车调度计单
	SELECT @_ScheduleComb = COUNT(*) FROM TMS_OrderIndex WHERE Index_CreatorCompanyID = @CompanyID AND Index_SrcClass = 3 AND Index_Status = 0 AND Index_Invalid = 0 AND Index_Combined = 0;
	
	-- 待签收订单数量
	SELECT @_Sign = COUNT(*) FROM TMS_OrderIndex WHERE Index_CreatorCompanyID = @CompanyID AND (Index_SrcClass = 1 OR Index_SrcClass = 2) AND Index_Status = 2 AND Index_Invalid = 0 AND dbo.fn_pub_order_SrcClassPmis(@Operator,Index_SrcClass)=1;
	
	-- 待回单订单数量
	SELECT @_Receipt = COUNT(*) FROM TMS_OrderIndex WHERE Index_CreatorCompanyID = @CompanyID AND (Index_SrcClass = 1 OR Index_SrcClass = 2) AND Index_Status = 4 AND Index_Invalid = 0 AND dbo.fn_pub_order_SrcClassPmis(@Operator,Index_SrcClass)=1;

	-- 待处理供应商邀请数量
	SELECT @_Confirm = COUNT(*) FROM TMS_MSupplier WHERE Supplier_CompanyID = @CompanyID AND Supplier_Status = 0 AND Supplier_Invalid = 0;

	SELECT ISNULL(@_Recv, 0) AS Recv_Count,
		ISNULL(@_Schedule, 0) AS Schedule_Count,
		ISNULL(@_ScheduleIn, 0) AS ScheduleIn_Count,
		ISNULL(@_ScheduleLong, 0) AS ScheduleLonge_Count,
		ISNULL(@_ScheduleComb, 0) AS ScheduleComb_Count,
		ISNULL(@_Sign, 0) AS Sign_Count,
		ISNULL(@_Receipt, 0) AS Receipt_Count,
		ISNULL(@_Confirm, 0) AS Confirm_Count;

	SET NOCOUNT OFF;
END




GO


