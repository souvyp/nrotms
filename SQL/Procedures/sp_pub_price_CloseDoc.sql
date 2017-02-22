USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_price_CloseDoc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_price_CloseDoc]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*�رձ��۵�*/
CREATE PROCEDURE [dbo].[sp_pub_price_CloseDoc]
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
	DECLARE @SrcStatus BIGINT;
	DECLARE @DstStatus BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @SrcStatus = 0;
	SET @DstStatus = 4;

	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -520011001;
	END
	
	-- ��ǰ�û�û�йرձ��۵���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520011002;
	END

	-- ���۵��Ƿ����
	IF @Result = 0
	BEGIN
		SELECT @SrcStatus = [Index_Status]  FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520011003;
		END
	END
	
	-- ֻ�б��۵�������(���ڹ�˾)���Թر�
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_CreatorCompanyID = @CompanyID)
	BEGIN
		SET @Result = -520011004;
	END

	-- ֻ�вݸ塢�ѷ�����δ�����ı��۵����Թر�
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM Price_DocIndex WHERE Index_ID = @DocID AND (Index_Status = 0 OR Index_Status = 1))
	BEGIN
		SET @Result = -520011005;
	END
	
	-- ִ�йرղ���
	IF @Result = 0
	BEGIN
		UPDATE Price_DocIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE() WHERE Index_ID = @DocID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520011006;
		END
	END
	
	-- д�������̱�
	IF @Result = 0
	BEGIN
		INSERT INTO Price_DocFlow(Flow_DocID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, 
Flow_InsertTime, Flow_Invalid) VALUES(@DocID, @SrcStatus, @DstStatus, 0, @Description, @Operator, @CompanyID, GETDATE(), 0);
	END

	SELECT @Result AS Close_Result;
	
	SET NOCOUNT OFF;
END
GO


