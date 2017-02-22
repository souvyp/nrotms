USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_SendOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_SendOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*ί�ж�����������*/
CREATE PROCEDURE [dbo].[sp_prv_order_SendOrder]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@SupplieryID BIGINT,
	@VolumeAddition DECIMAL(18,6) = 0,			-- �������
	@WeightAddition DECIMAL(18,4) = 0,			-- ��������
	@TxnRequired TINYINT = 0,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	DECLARE @CompanyID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @SupplierCompanyID = 0;
	IF @SupplieryID IS NULL
	BEGIN
		SET @SupplieryID = 0;
	END
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510037001;
	END
	
	-- ��ǰ�û�û�з��Ͷ�����Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510037002;
	END
	
	-- �����Ƿ����[�����䶩���ܷ���]
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Invalid = 0 AND Index_SrcClass = 2)
	BEGIN
		SET @Result = -510037003;
	END
	
	-- �����Ƿ��Ѿ�������
	IF @Result = 0 AND EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Status > 1 AND Index_SupplierCompanyID > 0 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -510037004;
	END
	
	-- ���߳������Ƿ����
	IF @Result = 0 AND @SupplieryID > 0 
	BEGIN
		SELECT @SupplierCompanyID = Supplier_CompanyID FROM TMS_MSupplier WHERE Supplier_ID = @SupplieryID AND Supplier_OwnerCompanyID = @CompanyID AND Supplier_Invalid = 0 AND Supplier_Status = 1 AND Supplier_CompanyID > 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510037005;
		END
	END
	
	-- ����
	IF @Result = 0
	BEGIN
		-- ���ϳ�����
		UPDATE TMS_OrderIndex SET Index_SupplierID = @SupplieryID, Index_SupplierCompanyID = @SupplierCompanyID, 
Index_VolumeAddition = (CASE WHEN @VolumeAddition = 0 THEN Index_VolumeAddition ELSE @VolumeAddition END), 
Index_WeightAddition = (CASE WHEN @WeightAddition = 0 THEN Index_WeightAddition ELSE @WeightAddition END) WHERE Index_ID = @OrderID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510037006;
		END
	/**--	
		ELSE
		BEGIN
			-- ����¼�֪ͨ(�д����ն���)
			DECLARE @tmpResult BIGINT;
			DECLARE @EventID BIGINT;
			DECLARE @OccurTime DATETIME;
			SET @tmpResult = 0;
			SET @EventID = 0;
			SET @OccurTime = GETDATE();
					
			EXEC sp_prv_event_AddEvent @Operator, 3, @SupplierCompanyID, 0, @OrderID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
			IF @tmpResult <> 0 
			BEGIN
				SET @Result = -510037007;
			END
		END
	**/--
	END
END
GO


