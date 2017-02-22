USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_my_SupplierAccept]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_my_SupplierAccept]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 接受或拒绝供应商申请
CREATE PROCEDURE [dbo].[sp_prv_my_SupplierAccept]
(
	@Operator BIGINT,
	@SupplierID BIGINT,
	@Op BIGINT,				-- 1 接受 2 拒绝
	@TxnRequired BIGINT = 0,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	DECLARE @CompanyID BIGINT;
	DECLARE @OwnerCompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @OwnerCompanyID = 0;
	
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510023001;
	END
	
	-- 当前用户没有操作供应商的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510023002;
	END

	-- 供应商公司编号是否有效
	IF @Result = 0
	BEGIN
		SELECT @OwnerCompanyID = Supplier_OwnerCompanyID FROM TMS_MSupplier WHERE Supplier_ID = @SupplierID AND Supplier_CompanyID = @CompanyID AND Supplier_Status = 0 AND Supplier_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510023003;
		END
	END

	-- 接受或者拒绝
	DECLARE @tmpResult BIGINT;
	DECLARE @EventID BIGINT;
	DECLARE @OccurTime DATETIME;
	SET @tmpResult = 0;
	SET @EventID = 0;
	SET @OccurTime = GETDATE();

	IF @Result = 0
	BEGIN
		IF @Op = 1
		BEGIN
			-- 接受
			UPDATE TMS_MSupplier SET Supplier_Status = 1, Supplier_StatusTime = GETDATE(), Supplier_Processor = @Operator WHERE Supplier_ID = @SupplierID AND Supplier_Status = 0 AND Supplier_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510023004;
			END
			ELSE
			BEGIN
				-- 相同公司编号的客户是否存在
				IF NOT EXISTS(SELECT Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @CompanyID AND Customer_CompanyID = @OwnerCompanyID AND Customer_Invalid = 0)
				BEGIN
					-- 添加承运商成功，当前公司自动成为承运商的客户
					DECLARE @tempResult BIGINT;
					DECLARE @tempCustomerID BIGINT;
					SET @tempResult = 0;
					SET @tempCustomerID = 0;
					
					EXEC sp_prv_my_EditCustomer @Operator, 0, @OwnerCompanyID, 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', @Result = @tempResult OUTPUT, @CustomerID = @tempCustomerID OUTPUT
					IF @tempResult <> 0
					BEGIN
						SET @Result = -510023008;
					END
				END
				
				-- 添加消息通知(9 同意成为承运商)
				IF @Result = 0
				BEGIN
					EXEC sp_prv_event_AddEvent @Operator, 9, @OwnerCompanyID, 0, 0, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
					IF @tmpResult <> 0 
					BEGIN
						SET @Result = -510023009;
					END
				END
			END
		END
		ELSE IF @Op = 2
		BEGIN
			-- 拒绝
			UPDATE TMS_MSupplier SET Supplier_Status = 2, Supplier_StatusTime = GETDATE(), Supplier_Processor = @Operator WHERE Supplier_ID = @SupplierID AND Supplier_Status = 0 AND Supplier_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510023005;
			END
			ELSE
			BEGIN
				-- 添加事件通知(拒绝成为供应商)			
				EXEC sp_prv_event_AddEvent @Operator, 2, @OwnerCompanyID, 1, 0, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510023007;
				END
			END
		END
		ELSE
		BEGIN
			SET @Result = -510023006
		END
	END
END
GO


