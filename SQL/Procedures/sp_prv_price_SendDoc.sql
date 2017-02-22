USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_SendDoc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_SendDoc]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*���ͱ��۵�*/
CREATE PROCEDURE [dbo].[sp_prv_price_SendDoc]
(
	@Operator BIGINT,
	@DocID BIGINT,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	
	DECLARE @CompanyID BIGINT;
	DECLARE @SrcStatus BIGINT;
	DECLARE @DstStatus BIGINT;
	DECLARE @DocType BIGINT;
	DECLARE @SupplierSymbolID BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @SrcStatus = 0;
	SET @DstStatus = 1;
	SET @DocType = 0;
	SET @SupplierSymbolID=0;
	SET @Result = 0;
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -520012001;
	END
	
	-- ��ǰ�û�û�з������۵���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520012002;
	END

	-- ���۵��Ƿ����
	IF @Result = 0
	BEGIN
		SELECT @SrcStatus = [Index_Status], @DocType = [Index_Type] FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0 AND Index_Status = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520012003;
		END
	END
	
	-- ֻ�б��۵�������(���ڹ�˾)���Է���
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_CreatorCompanyID = @CompanyID)
	BEGIN
		SET @Result = -520012004;
	END

	-- ֻ�вݸ���Է���
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM Price_DocIndex WHERE Index_ID = @DocID AND (Index_Status = 0 OR Index_Status = 0))
	BEGIN
		SET @Result = -520012005;
	END
	
	-- δ���ڲſ��Է���
	IF @Result = 0 AND EXISTS(SELECT [Index_ID] FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_EndTime <= GETDATE() AND Index_Type = 2)
	BEGIN
		SET @Result = -520012007;
	END

	-- ��Լ����û�м۸���ϸ��¼ʱ��������
	IF @Result = 0 AND @DocType = 2 AND NOT EXISTS(SELECT TOP 1 Detail_ID FROM Price_DocDetails WHERE Detail_DocID = @DocID AND Detail_Invalid = 0)
	BEGIN
		SET @Result = -520012009;
	END
	
	-- ��Լ���ۺͲ��䱨��ʱĳ��۸�Ϊ0ʱ��������
	IF @Result = 0 AND (@DocType = 2 OR @DocType = 3) AND EXISTS(SELECT [Detail_ID] FROM Price_DocDetails WHERE Detail_DocID = @DocID AND 
Detail_Invalid = 0 AND Detail_Amount <= 0 AND Detail_Type IN (1,2,3,4,9))
	BEGIN
		SET @Result = -520012008;
	END
	
		
	-- ִ�з��Ͳ���
	IF @Result = 0
	BEGIN
		UPDATE Price_DocIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE() WHERE Index_ID = @DocID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520012006;
		END
	END
	
	-- ��Ӫ���۲���Ҫ���
	IF @Result = 0
	BEGIN
	SELECT @SupplierSymbolID = Index_SupplierSymbolID FROM Price_DocIndex WHERE Index_ID = @DocID;
		IF @SupplierSymbolID > 0
		BEGIN
		    EXEC sp_prv_price_VerifyDoc @Operator,@DocID,0,'', @Result = @Result OUTPUT;
		END     
	END	
	
	-- д�������̱�
	IF @Result = 0
	BEGIN
		INSERT INTO Price_DocFlow(Flow_DocID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Creator, Flow_CompanyID, 
Flow_InsertTime, Flow_Invalid) VALUES(@DocID, @SrcStatus, @DstStatus, 0, @Operator, @CompanyID, GETDATE(), 0);
	END

END
GO


