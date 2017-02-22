USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_ReceiveOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_ReceiveOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*���ջ�ܾ���ί�ж���*/
CREATE PROCEDURE [dbo].[sp_prv_order_ReceiveOrder]
(
	@Operator BIGINT,
	@CompanyID BIGINT, 
	@OrderID BIGINT,
	@Accept BIGINT = 1,			-- 1 ���� 0 �ܾ�
	@Description NVARCHAR(512) = N'',
	@Result BIGINT OUTPUT,
	@SupplierOrderID BIGINT OUTPUT
)
AS
BEGIN
	DECLARE @FromCompanyID BIGINT;
	DECLARE @FromOperator BIGINT;
	DECLARE @IsCombine BIGINT;
	SET @Result = 0;
	SET @FromCompanyID = 0;
	SET @FromOperator = 0;
	SET @IsCombine = 0;

	-- �����Ƿ����
	IF @Result = 0
	BEGIN
		SELECT @FromOperator = Index_Creator, @FromCompanyID = Index_CreatorCompanyID, @IsCombine = Index_Combined FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SupplierCompanyID = @CompanyID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510017003;
		END
	END
	
	-- �����Ƿ��Ѿ�������
	IF @Result = 0 AND @Accept = 1 AND NOT EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Status = 1 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -510017004;
	END
	
	IF @Result = 0
	BEGIN
		DECLARE @tmpResult BIGINT;
		DECLARE @EventID BIGINT;
		DECLARE @OccurTime DATETIME;
		DECLARE @ProcResult BIGINT;
		SET @tmpResult = 0;
		SET @EventID = 0;
		SET @OccurTime = GETDATE();
		SET @ProcResult = (CASE WHEN @Accept = 1 THEN 0 ELSE 1 END);

		IF @Accept = 1
		BEGIN
			-- �����µĳ����̶���

			SET @SupplierOrderID = 0;
			EXEC sp_prv_order_CloneOrder2Supplier @Operator, @OrderID, @FromCompanyID, @CompanyID, 1, @Result = @Result OUTPUT, @SupplierOrderID = @SupplierOrderID OUTPUT;
			
			-- ���ܶ���[ֱ�ӱ�Ϊ�ѵ���]
			IF @Result = 0
			BEGIN
				UPDATE TMS_OrderIndex SET Index_Status = 2, Index_StatusTime = GETDATE(), Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE() WHERE Index_ID = @OrderID AND Index_Invalid = 0 ANd Index_Status = 1;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510017005;
				END
			END
			
			-- ��Ӷ�������
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, 2, 0, @Description, @Operator, @CompanyID, GETDATE(), 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510017006;
				END
			END
			
			-- ����۸񲢻��棬���ϵ�����������۸�
			IF @Result = 0 AND @IsCombine = 0
			BEGIN
				-- ���㱻ί�ж����۸�
				EXEC sp_prv_price_CacheOrderPrice @FromOperator, @OrderID, 0, @Result = @Result OUTPUT;
				
				-- ��������̶����۸�
				IF @Result = 0
				BEGIN
					EXEC sp_prv_price_CacheOrderPrice @Operator, @SupplierOrderID, 0, @Result = @Result OUTPUT;
				END
			END

			-- ����¼�֪ͨ(10 �����ѽ���)
			IF @Result = 0
			BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 10, @FromCompanyID, @ProcResult, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510017010;
				END
			END
		END
		ELSE
		BEGIN
			-- �ܾ�����
			UPDATE TMS_OrderIndex SET Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE(), Index_SupplierID = 0, Index_SupplierCompanyID = 0 WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND Index_Status = 1;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510017007;
			END
			
			-- ��Ӷ�������
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, 1, 1, @Description, @Operator, @CompanyID, GETDATE(), 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510017008;
				END
				ELSE
				BEGIN
					-- ����¼�֪ͨ(�������ܾ�)
					EXEC sp_prv_event_AddEvent @Operator, 4, @FromCompanyID, @ProcResult, @OrderID, @OccurTime, @Description,@Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
					IF @tmpResult <> 0 
					BEGIN
						SET @Result = -510017009;
					END
				END
			END
		END
	END
END
GO


