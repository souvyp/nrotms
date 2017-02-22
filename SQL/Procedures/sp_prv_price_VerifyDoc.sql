USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_VerifyDoc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_VerifyDoc]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*��˱��۵�*/
CREATE PROCEDURE [dbo].[sp_prv_price_VerifyDoc]
(
	@Operator BIGINT,
	@DocID BIGINT,
	@Op BIGINT,					-- 0 ͬ�� 1 �ܾ�
	@Description NVARCHAR(512),	-- ����(�ܾ�ʱ����)
	@Result BIGINT OUTPUT
)
AS
BEGIN

	DECLARE @CompanyID BIGINT;
	DECLARE @DstCompanyID BIGINT;
	DECLARE @SrcStatus BIGINT;
	DECLARE @DstStatus BIGINT;
	DECLARE @DocType BIGINT;				-- ���۵�����: 1 �������� 2 ����Լ���� 3 ���䱨�� 4 �ϵ����� 5 �ϵ����䱨��
	DECLARE @DocOrderID BIGINT;				-- �������� �� ���䱨�� ��ԵĶ������
	
	DECLARE @OrderCreator BIGINT;			-- �����۸������
	DECLARE @OrderCreatorCompanyID BIGINT;	-- �����۸���㹫˾���
	DECLARE @SrcOrderID BIGINT;				-- Դ����
	DECLARE @OrderSrcClass BIGINT;			-- ��������
	DECLARE @SrcOrderCreator BIGINT;		-- Դ����������
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @DstCompanyID = 0;
	SET @SrcStatus = 1;
	IF @Op = 0
	BEGIN
		SET @DstStatus = 2;
	END
	ELSE
	BEGIN
		SET @DstStatus = 0;
	END
	SET @DocType = 0;
	SET @DocOrderID = 0;
	SET @OrderCreator = 0;
	SET @OrderCreatorCompanyID = 0;
	SET @SrcOrderID = 0;
	SET @OrderSrcClass = 0;
	SET @SrcOrderCreator = 0;

	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -520013001;
	END
	

	-- ��ǰ�û�û�з������۵���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520013002;
	END

	-- ���۵��Ƿ����
	IF @Result = 0
	BEGIN
		SELECT @DocType = [Index_Type], @DocOrderID = [Index_OrderID], @SrcStatus = [Index_Status], @DstCompanyID = Index_CreatorCompanyID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0 AND Index_Status = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520013003;
		END
	END
	
	-- ֻ�б��۵�������(���ڹ�˾)������Ӫ�������ۿ������
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM Price_DocIndex WHERE Index_ID = @DocID AND (CASE WHEN  Index_SupplierSymbolID > 0 AND Index_CreatorCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0) THEN 1 WHEN Index_SupplierSymbolID = 0 AND Index_CustomerCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0)THEN 1  ELSE 0 END)=1)
	BEGIN
		SET @Result = -520013004;
	END

	-- ֻ���ѷ����ı��۵��������
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Status = 1)
	BEGIN
		SET @Result = -520013005;
	END
	
	-- �ܾ�ʱ����д����
	IF @Result = 0 AND @Op = 1 AND (@Description IS NULL OR @Description = '')
	BEGIN
		SET @Result = -520013006;
	END

	-- ִ����˲���
	IF @Result = 0
	BEGIN
		UPDATE Price_DocIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE(), Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE() WHERE Index_ID = @DocID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520013007;
		END
		ELSE
		BEGIN
			DECLARE @tmpResult BIGINT;
			DECLARE @EventID BIGINT;
			DECLARE @OccurTime DATETIME;
			SET @tmpResult = 0;
			SET @EventID = 0;
			SET @OccurTime = GETDATE();

			IF @Op = 1
			BEGIN
				-- ����¼�֪ͨ(8 ���۵����ܾ�)
				EXEC sp_prv_event_AddEvent @Operator, 8, @DstCompanyID, 1, @DocID, @OccurTime,@Description, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -520013008;
				END
			END
			-- ���ɱ���(���۵����ͨ��,���ұ��۵�����Ϊ�������� �� ���䱨��
			ELSE IF @Op = 0
			BEGIN
				SELECT @OrderCreator = Index_Creator, @OrderCreatorCompanyID = Index_CreatorCompanyID, @SrcOrderID = Index_SrcOrderID, @OrderSrcClass = Index_SrcClass FROM TMS_OrderIndex WHERE Index_ID = @DocOrderID AND Index_Invalid = 0;
				IF @@ROWCOUNT > 0
				BEGIN
					-- ������������,���䱨��׷�Ӽ۸�
					IF @DocType IN (1,3,5) AND @DocOrderID > 0
					BEGIN
						-- �������ۣ������۸�����
						IF @DocType = 1
						BEGIN
							-- ��ǰ����
							EXEC sp_prv_price_CacheOrderPrice @OrderCreator, @DocOrderID, 0, @Result = @Result OUTPUT;
							
							-- �ͻ������䶩��
							IF @Result = 0 AND @SrcOrderID > 0 AND @OrderSrcClass = 1
							BEGIN
								SELECT @SrcOrderCreator = Index_Creator FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_SupplierCompanyID = @OrderCreatorCompanyID AND Index_SrcClass = 2 AND Index_Invalid = 0;
								IF @@ROWCOUNT > 0
								BEGIN
									EXEC sp_prv_price_CacheOrderPrice @SrcOrderCreator, @SrcOrderID, 0, @Result = @Result OUTPUT;
								END
							END
						END
						-- ���䱨�ۣ�׷�Ӽ۸�
						ELSE IF @DocType IN (3,5)
						BEGIN
							-- ��ǰ����
							IF @DocType = 3 
							BEGIN
								INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, 
		Cache_InsertTime, Cache_Invalid, Cache_DocID) SELECT @DocOrderID, Detail_Type, 1, Detail_Amount, @OrderCreator, GETDATE(), 0 ,@DocID FROM Price_DocDetails WHERE Detail_DocID = @DocID AND Detail_Invalid = 0;
								IF @@ROWCOUNT = 0
								BEGIN
									SET @Result = -520013009;
								END
							END
							-- �ͻ����䶩��
							IF @Result = 0 AND @SrcOrderID > 0 AND @OrderSrcClass = 1
							BEGIN
								SELECT @SrcOrderCreator = Index_Creator FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_SupplierCompanyID = @OrderCreatorCompanyID AND Index_SrcClass = 2 AND Index_Invalid = 0;
								IF @@ROWCOUNT > 0
								BEGIN
									INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, 
	Cache_InsertTime, Cache_Invalid,Cache_DocID) SELECT @SrcOrderID, Detail_Type, 1, Detail_Amount, @SrcOrderCreator, GETDATE(), 0,@DocID FROM Price_DocDetails WHERE Detail_DocID = @DocID AND Detail_Invalid = 0;
									IF @@ROWCOUNT = 0
									BEGIN
										SET @Result = -520013010;
									END
								END
							END
						END
						
						IF @DocType = 5 AND @DocOrderID > 0
						BEGIN
							DECLARE @OrderID BIGINT;
							DECLARE @_AdditionCost BIGINT;
							SET @OrderID = 0;
							SET @_AdditionCost = 0;
							SELECT @OrderID = Index_OrderID FROM Price_DocIndex WHERE Index_ID = @DocID;
							SELECT @_AdditionCost = Detail_Amount FROM Price_DocDetails WHERE Detail_DOCID = @DocID;

							EXEC sp_prv_price_CacheCombineOrderPrice @Operator, @OrderID, 0, 0, 0, 0, 0, 0, @_AdditionCost, 0, 0, 0, @DocID,@Result = @Result OUTPUT;
						END
					END
					-- �ϵ���������
					ELSE IF @DocType = 4 AND @DocOrderID > 0
					BEGIN
						-- ���ϵ��������Զ�����۸�
						EXEC sp_prv_price_CacheOrderPrice @OrderCreator, @DocOrderID, 0, @Result = @Result OUTPUT;
					END
				END
				
				-- ����¼�֪ͨ(11 �ͻ����ܱ��۵�)
				IF @Result = 0
				BEGIN
					EXEC sp_prv_event_AddEvent @Operator, 11, @DstCompanyID, 0, @DocID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
					IF @tmpResult <> 0 
					BEGIN
						SET @Result = -520013008;
					END
				END
			END
		END
	END
	
	-- д�������̱�
	IF @Result = 0
	BEGIN
		INSERT INTO Price_DocFlow(Flow_DocID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, 
Flow_InsertTime, Flow_Invalid) VALUES(@DocID, @SrcStatus, @DstStatus, @Op, @Description, @Operator, @CompanyID, GETDATE(), 0);
	END

	
END
GO


