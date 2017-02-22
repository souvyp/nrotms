USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_AppendComments]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_AppendComments]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- 为订单附加备注信息
CREATE PROCEDURE [dbo].[sp_pub_order_AppendComments]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@Description NVARCHAR(512)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @FlowID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @FlowID = 0;
	
	BEGIN TRANSACTION;

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510035001;
	END
	
	-- 当前用户没有添加订单备注的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510035002;
	END
	
	-- 源订单是否存在
	IF @Result = 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND (Index_CreatorCompanyID = @CompanyID OR Index_SupplierCompanyID = @CompanyID) AND Index_Status > 1 AND Index_Status < 16)
	BEGIN
		SET @Result = -510035003;
	END

	IF @Result = 0
	BEGIN
		INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid, Flow_Description) VALUES(@OrderID, 0, 0, 3, @Operator, @CompanyID, GETDATE(), 0, @Description);
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510035004;
		END
		ELSE
		BEGIN
			SET @FlowID = IDENT_CURRENT('TMS_OrderFlow');
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

	SELECT @Result AS Flow_Result, @FlowID AS Flow_ID;

	SET NOCOUNT OFF;
END


GO


