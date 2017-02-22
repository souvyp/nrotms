USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_DocExpiredNow]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_DocExpiredNow]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*报价单强制过期*/
CREATE PROCEDURE [dbo].[sp_pub_price_DocExpiredNow]
(
	@Operator BIGINT,
	@DocID BIGINT,
	@Description NVARCHAR(512)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 256);
	
	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510052001;
	END

	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_RoleID = 256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510052002;
	END
	
	-- 源报价单是否有效[只有对方已同意的报价单可以强制过期，草稿和未审核报价单走“关闭”流程]
	IF @Result = 0 AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_CreatorCompanyID = @CompanyID AND Index_Invalid = 0 AND 
Index_Status = 2 AND Index_EndTime > GETDATE())
	BEGIN
		SET @Result = -510052003;
	END
	
	-- 置为过期
	IF @Result = 0
	BEGIN
		UPDATE Price_DocIndex SET Index_EndTime = GETDATE() WHERE Index_ID = @DocID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result =-510052004;
		END
	END
	
	-- 写报价单流程表
	IF @Result = 0
	BEGIN
		INSERT INTO Price_DocFlow(Flow_DocID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid, Flow_Operation, Flow_Description) VALUES(
@DocID, 0, 0, @Operator, @CompanyID, GETDATE(), 0, 2, @Description);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510052005;
		END
	END
	
	-- 添加报价单被动过期的消息通知[15 报价单被强制过期]
	IF @Result = 0
	BEGIN
		DECLARE @_DstCompanyID BIGINT;
		DECLARE @_Result BIGINT;
		DECLARE @_EventID BIGINT;
		DECLARE @_OccursTime DATETIME;
		SET @_DstCompanyID = 0;
		SET @_Result = 0;
		SET @_EventID = 0;
		SET @_OccursTime = GETDATE();
		
		SELECT @_DstCompanyID = Index_CustomerCompanyID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0;
		
		EXEC sp_prv_event_AddEvent @Operator, 15, @_DstCompanyID, 0, @DocID, @_OccursTime, @Result = @_Result OUTPUT, @EventID = @_EventID OUTPUT;
		IF @_Result <> 0 
		BEGIN
			SET @Result = -510052006;
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
	
	SELECT @Result AS Price_Result;

	SET NOCOUNT OFF;
END
GO


