USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_my_AddSupplier]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_my_AddSupplier]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*添加或修改承运商*/
CREATE PROCEDURE [dbo].[sp_prv_my_AddSupplier]
(
	@Operator BIGINT,
	@CompanyCode NVARCHAR(100),
	@InviteDesc NVARCHAR(600),
	@TxnRequired BIGINT = 0,
	@Result BIGINT OUTPUT,
	@SupplierID BIGINT OUTPUT
)
AS
BEGIN
	DECLARE @OwnerCompanyID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	DECLARE @ClientCode NVARCHAR(100);
	SET @Result = 0;
	SET @OwnerCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @SupplierID = 0;
	SET @SupplierCompanyID = 0;
	SET @ClientCode = N'';
	

	
	-- 当前用户没有关联公司
	IF @OwnerCompanyID <= 0
	BEGIN
		SET @Result = -510009001;
	END
	
	-- 当前用户没有添加供应商的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @OwnerCompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510009002;
	END

	IF @Result = 0
	BEGIN
		SELECT @SupplierCompanyID = Company_ID FROM TMS_Company WHERE Company_ClientCode = @CompanyCode AND Company_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510009003;
		END
	END
	--供应商不是自己公司
	IF @Result = 0 AND EXISTS(SELECT Company_Name  AS [Name] FROM dbo.TMS_Company WHERE Company_ClientCode=@CompanyCode AND dbo.fn_pub_user_User2CompanyID(@Operator,0)=Company_ID)
	
		BEGIN
			SET @Result = -510009008;
		END
	

	-- 供应商公司编号是否有效
	IF @Result = 0 AND NOT EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = @SupplierCompanyID AND Company_Invalid = 0)
	BEGIN
		SET @Result = -510009004;
	END


	IF @Result = 0
	BEGIN
		EXEC sp_pub_basic_GetSN 6, @SN = @ClientCode OUTPUT;
		IF @ClientCode = ''
		BEGIN
			-- 序列号生成失败
			SET @Result = -510009007;
		END
	END

    -- 承运商公司是否存在(存在编辑, 不存在添加，被拒绝后允许再次添加)
    IF @Result = 0
    BEGIN
		SELECT @SupplierID = Supplier_ID FROM TMS_MSupplier WHERE Supplier_OwnerCompanyID = @OwnerCompanyID AND Supplier_CompanyID = @SupplierCompanyID AND Supplier_Invalid = 0 AND (Supplier_Status = 0 OR Supplier_Status = 1);
		IF @@ROWCOUNT = 0
		BEGIN
			INSERT INTO TMS_MSupplier(Supplier_OwnerCompanyID, Supplier_CompanyID, Supplier_ClientCode, Supplier_Welcome, Supplier_Creator, Supplier_InsertTime) VALUES(@OwnerCompanyID, @SupplierCompanyID, @ClientCode, @InviteDesc, @Operator, GETDATE());
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510009005;
			END
			ELSE
			BEGIN
				SET @SupplierID = IDENT_CURRENT('TMS_MSupplier');
				
				-- 添加事件通知(被邀请成为供应商)
				DECLARE @tmpResult BIGINT;
				DECLARE @EventID BIGINT;
				DECLARE @OccurTime DATETIME;
				SET @tmpResult = 0;
				SET @EventID = 0;
				SET @OccurTime = GETDATE();
				
				EXEC sp_prv_event_AddEvent @Operator, 1, @SupplierCompanyID, 0, 0, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -510009006;
				END
			END
		END
		ELSE 
		BEGIN
			SET @Result = -510009009; -- 已有邀请在审核，或者以是承运商
		END
    END


END

GO


