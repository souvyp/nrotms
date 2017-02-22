USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_ReceiveCombineOrders]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_ReceiveCombineOrders]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*���ջ�ܾ����ȸ��ҵ�ƴ����*/
CREATE PROCEDURE [dbo].[sp_prv_order_ReceiveCombineOrders]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@Accept BIGINT = 1,			-- 1 ���� 0 �ܾ�
	@Description NVARCHAR(512) = N'',
	@Result BIGINT OUTPUT
)
AS
BEGIN


	DECLARE @CompanyID BIGINT;
	DECLARE @FromCompanyID BIGINT;
	DECLARE @FromOperator BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @FromCompanyID = 0;
	SET @FromOperator = 0;

	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510043001;
	END
	
	-- ��ǰ�û�û�н��ܵ��ݵ�Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510043002;
	END
	
	-- �����Ƿ����
	IF @Result = 0
	BEGIN
		SELECT @FromOperator = Index_Creator, @FromCompanyID = Index_CreatorCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SrcClass = 3 AND Index_SupplierCompanyID = @CompanyID AND Index_Status = 1 AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510043003;
		END
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
		    -- �޸ĵ���״̬
		    UPDATE TMS_OrderIndex SET Index_Status = 2, Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE() WHERE Index_ID = @OrderID;
		    IF @@ROWCOUNT = 0
		    BEGIN
				SET @Result = -510043004;
		    END

			-- ��Ӷ�������
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, 2, 0, @Description, @Operator, @CompanyID, GETDATE(), 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510043005;
				END
			END
			
			-- ���±��ϵ������б�����������������������
			IF @Result = 0
			BEGIN
				UPDATE TMS_OrderContains SET Contains_Volume = dbo.fn_pub_order_TotalVolume(Contains_OrderID, 0), 
Contains_Weight = dbo.fn_pub_order_TotalWeight(Contains_OrderID, 0), Contains_Amount = dbo.fn_pub_order_TotalAmount(Contains_OrderID, 0) WHERE Contains_OwnerOrderID= @OrderID AND Contains_Invalid = 0;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510043011;
				END
			END

			-- ִ�ж����б�ķ��ͽ��ղ���
			IF @Result = 0
			BEGIN
				DECLARE @Desc NVARCHAR(512);
				SET @Desc = N'Combine the orders to ' + CAST(@OrderID AS VARCHAR);
				
				DECLARE @_OrderID BIGINT;
				DECLARE @_SupplierID BIGINT;
				DECLARE @_SupplierCompanyID BIGINT;
				DECLARE @_Result BIGINT;
				DECLARE @SupplierOrderID BIGINT;
				SET @_OrderID = 0;
				SET @_SupplierID = 0;
				SET @_SupplierCompanyID = 0;
				SET @_Result = 0;
				SET @SupplierOrderID = 0;

				DECLARE order_cursor CURSOR LOCAL FOR SELECT A.Contains_OrderID, B.Index_SupplierID, B.Index_SupplierCompanyID FROM TMS_OrderContains AS A INNER JOIN TMS_OrderIndex AS B ON A.Contains_OwnerOrderID = B.Index_ID WHERE A.Contains_OwnerOrderID = @OrderID AND A.Contains_Invalid = 0 AND B.Index_Invalid = 0 AND B.Index_Status <> 32;
				OPEN order_cursor;
				
				FETCH NEXT FROM order_cursor INTO @_OrderID, @_SupplierID, @_SupplierCompanyID;
				WHILE @@FETCH_STATUS = 0
				BEGIN
					DECLARE @_SupplierOperator BIGINT;
					SET @_SupplierOperator = 0;

					IF @_OrderID IS NULL
					BEGIN
						SET @_OrderID = 0;
					END
					IF @_SupplierID IS NULL
					BEGIN
						SET @_SupplierID = 0;
					END

					-- ��ȡ�����̶˵Ĳ�����[Ĭ��Ϊ����Ա]
					SELECT TOP 1 @_SupplierOperator = [User_ID] FROM TMS_User WHERE User_CompanyID = @_SupplierCompanyID AND User_RoleID = 256 AND User_Invalid = 0;
					IF @@ROWCOUNT = 0
					BEGIN
						SET @Result = -510043006;
					END

					IF @Result = 0
					BEGIN
						-- ���Ͷ���
						EXEC sp_prv_order_SendOrder @FromOperator, @_OrderID, @_SupplierID, 0, 0, 0, @Result = @_Result OUTPUT;
						IF @_Result = 0
						BEGIN
							-- ���ն���
							EXEC sp_prv_order_ReceiveOrder @_SupplierOperator, @_SupplierCompanyID, @_OrderID, 1, @Desc, @Result = @_Result OUTPUT,@SupplierOrderID = @SupplierOrderID OUTPUT;
							IF @_Result <> 0
							BEGIN
								SET @Result = @_Result;
							END
						END
						ELSE
						BEGIN
							SET @Result = @_Result;
						END
					END

					-- �������˳��α�					
					IF @Result <> 0
					BEGIN
						BREAK;
					END

					FETCH NEXT FROM order_cursor INTO @_OrderID, @_SupplierID, @_SupplierCompanyID;
				END

				CLOSE order_cursor;
				DEALLOCATE order_cursor;
			END

			-- ����¼�֪ͨ(14 �����ѽ���)
			IF @Result = 0
			BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 14, @FromCompanyID, @ProcResult, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510043010;
				END
			END
		END
		ELSE
		BEGIN
			-- ���ݱ��ܾ�
			UPDATE TMS_OrderIndex SET Index_Status = 0, Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE() WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510043007;
			END
			
			-- ��Ӷ�������
			IF @Result = 0
			BEGIN
				INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, Flow_InsertTime, Flow_Invalid) VALUES(
@OrderID, 1, 0, 1, @Description, @Operator, @CompanyID, GETDATE(), 0);
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510043008;
				END
			END
		
			-- ����¼�֪ͨ(13 �������ܾ�)
			IF @Result = 0
			BEGIN
				EXEC sp_prv_event_AddEvent @Operator, 13, @FromCompanyID, @ProcResult, @OrderID, @OccurTime,@Description, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510043009;
				END
			END
		END
	END

END
GO


