USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_event_EventCount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_event_EventCount]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*消息或待办事件的数量*/
CREATE PROCEDURE [dbo].[sp_pub_event_EventCount]
(
	@id BIGINT,
	@Module BIGINT = 1,				-- 系统模块(支持OR): 1 TMS 2 PMS 4 GMS
	@Type BIGINT = 3				-- 数量类型(支持OR)：1 消息 2 待办
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result INT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@id, 0);

	-- 消息数量
	IF @Type & 1 = 1
	BEGIN
		SELECT @Result = @Result + COUNT(*) FROM TMS_Events WHERE Event_DstCompanyID = @CompanyID AND Event_Processed = 0 AND Event_Invalid = 0 AND dbo.fn_prv_event_CheckPmis(@id, Event_Type) = 1 AND dbo.fn_prv_event_ModuleMatch(Event_Type, @Module) = 1 AND ((Event_DstCompanyID<>Event_SrcCompanyID AND Event_Ext<>0)  OR  Event_Type in(1,2,9,21));
	END

	IF @Type & 2 = 2
	BEGIN
		IF @Module = 1 AND dbo.fn_prv_event_CheckPmis(@id, 3) = 1
		BEGIN	
			-- 待接收订单数量
			SELECT @Result = @Result + COUNT(*) FROM TMS_OrderIndex WHERE Index_SupplierCompanyID = @CompanyID AND Index_SrcClass = 2 AND Index_Status = 1 AND Index_Invalid = 0 AND Index_Combined = 0;
		END

		IF @Module = 1 AND dbo.fn_prv_event_CheckPmis(@id, 12) = 1
		BEGIN
			-- 待接收拼车单数量
			SELECT @Result = @Result + COUNT(*) FROM TMS_OrderIndex WHERE Index_SupplierCompanyID = @CompanyID AND Index_SrcClass = 3 AND Index_Status = 1 AND Index_Invalid = 0 AND Index_Combined = 0;
	
							
		END
		ELSE IF @Module = 2 AND dbo.fn_prv_event_CheckPmis(@id, 7) = 1
		BEGIN
			-- 待处理的报价单数量
			SELECT @Result = @Result + COUNT(*) FROM Price_DocIndex WHERE Index_CustomerCompanyID = @CompanyID AND Index_Status = 1 AND 
Index_Invalid = 0 AND (CASE WHEN Index_Type = 2 AND Index_EndTime >= GETDATE() THEN 1 WHEN Index_Type IN ( 1,3,4,5 )THEN 1 ELSE 0 END) = 1 AND Index_SupplierSymbolID = 0;
		END
		ELSE IF @Module = 4 AND dbo.fn_prv_event_CheckPmis(@id, 22 ) =1
		BEGIN
			-- 待处理的加入集团申请
			SELECT @Result = @Result + COUNT(*) FROM TMS_CompanyBranches WHERE Branch_OwnerCompanyID = @CompanyID AND Branch_Invalid = 0 AND Branch_Status = 1;
		END

		IF dbo.fn_prv_event_CheckPmis(@id, 1) = 1
		BEGIN
			-- 待处理供应商邀请数量
			SELECT @Result = @Result + COUNT(*) FROM TMS_MSupplier WHERE Supplier_CompanyID = @CompanyID AND Supplier_Status = 0 AND Supplier_Invalid = 0 AND Supplier_CompanyID > 0;
		
		END	
		IF @Module = 1 
		BEGIN
					-- 价格预警			
			SELECT @Result = @Result + COUNT(*) FROM TMS_Events INNER JOIN TMS_OrderIndex ON Event_Ext = Index_ID WHERE Event_SrcCompanyID= @CompanyID  AND  dbo.fn_prv_event_CheckPmis(@id,Event_Type)=1 AND dbo.fn_prv_event_CheckOrderPrice(Event_Ext,Event_Type) = 1 AND  dbo.fn_prv_event_ModuleMatch(Event_Type,2)=1 AND Event_Type>24  AND Index_SrcClass = 2;	
		END
		ELSE IF @Module = 2
		BEGIN
					-- 价格预警			
			SELECT @Result = @Result + COUNT(*) FROM TMS_Events INNER JOIN TMS_OrderIndex ON Event_Ext = Index_ID WHERE Event_SrcCompanyID= @CompanyID  AND  dbo.fn_prv_event_CheckPmis(@id,Event_Type)=1 AND dbo.fn_prv_event_CheckOrderPrice(Event_Ext,Event_Type) = 1 AND  dbo.fn_prv_event_ModuleMatch(Event_Type,2)=1 AND Event_Type>24  AND Index_SrcClass = 1;	
		END
				
	END

	SELECT @Result AS Event_Count;

	SET NOCOUNT OFF;
END

GO


