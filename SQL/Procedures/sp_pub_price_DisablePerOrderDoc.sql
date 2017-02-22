USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_DisablePerOrderDoc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_DisablePerOrderDoc]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 禁用按单报价的报价单
CREATE PROCEDURE [dbo].[sp_pub_price_DisablePerOrderDoc]
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
	DECLARE @OrderID BIGINT;
	DECLARE @SrcStatus BIGINT;
	DECLARE @DstStatus BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @OrderID = 0;
	SET @SrcStatus = 0;
	SET @DstStatus = 4;

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -520054001;
	END
	
	-- 当前用户没有禁用报价单的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520054002;
	END

	-- 报价单是否存在
	IF @Result = 0
	BEGIN
		SELECT @SrcStatus = [Index_Status], @OrderID = Index_OrderID  FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0 AND Index_Type = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520054003;
		END
	END
	
	-- 只有报价单创建者(所在公司)可以禁用
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_CreatorCompanyID = @CompanyID)
	BEGIN
		SET @Result = -520054004;
	END

	-- 执行禁用操作
	IF @Result = 0
	BEGIN
		UPDATE Price_DocIndex SET Index_Invalid = 1 WHERE Index_ID = @DocID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520054006;
		END
	END
	
	-- 删除原价格
	IF @Result = 0
	BEGIN
		UPDATE Price_OrderCache SET Cache_Invalid = 1 WHERE Cache_OrderID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520054007;
		END
	END
	
	-- 写报价流程表
	IF @Result = 0
	BEGIN
		INSERT INTO Price_DocFlow(Flow_DocID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, 
Flow_InsertTime, Flow_Invalid) VALUES(@DocID, 0, 0, 3, @Description, @Operator, @CompanyID, GETDATE(), 0);
	END

	SELECT @Result AS Close_Result;
	
	SET NOCOUNT OFF;
END

GO


