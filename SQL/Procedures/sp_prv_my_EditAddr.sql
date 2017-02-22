USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_my_EditAddr]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_my_EditAddr]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*��ӻ��޸��ջ������������õ�ַ*/
CREATE PROCEDURE [dbo].[sp_prv_my_EditAddr]
(
	@Operator BIGINT,
	@ID BIGINT,
	@CustomerID BIGINT,
	@Address NVARCHAR(300),
	@Type TINYINT,                -- 1 �ջ���ַ 2 ������ַ 3 ��Ӧ�̳��õ�ַ
	@ProvinceID BIGINT = 0,
	@CityID BIGINT = 0,
	@DistrictID BIGINT = 0,
	@TxnRequied TINYINT = 0,
	@Automatic TINYINT = 0,       -- �Ƿ�Ϊ�Զ�����
	@Phone NVARCHAR(300) = N'',
	@Result BIGINT OUTPUT,
	@AddrID BIGINT OUTPUT
	
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @AddrID = 0;
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510013001;
	END
	
	-- ��ǰ�û�û����ӿͻ���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510013002;
	END

	-- �ջ����Ƿ����
	IF @Result = 0
	BEGIN
		IF @Type = 1 AND @CustomerID > 0 AND NOT EXISTS(SELECT EndUser_ID FROM TMS_MEndUser WHERE EndUser_ID = @CustomerID AND EndUser_Invalid = 0)
		BEGIN
			SET @Result = -510013003;
		END
		
		IF @Type = 2 AND @CustomerID > 0 AND NOT EXISTS(SELECT Customer_ID FROM TMS_MCustomer WHERE Customer_ID = @CustomerID AND Customer_Invalid = 0)
		BEGIN
			SET @Result = -510013006;
		END
		
		IF @Type = 3 AND @CustomerID > 0 AND NOT EXISTS(SELECT Supplier_ID FROM TMS_MSupplier WHERE Supplier_ID = @CustomerID AND Supplier_Invalid = 0)
		BEGIN
			SET @Result = -510013007;
		END
	END

    -- ��ַ�Ƿ����(���ڱ༭, ���������)
    IF @Result = 0
    BEGIN
		SELECT @ID = Addr_ID FROM TMS_MAddr WHERE Addr_ID = @ID AND Addr_CompanyID = @CompanyID AND Addr_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			INSERT INTO TMS_MAddr(Addr_CustomerID, Addr_Desc, Addr_Type, Addr_CompanyID, Addr_ProvinceID, Addr_CityID, Addr_DistrictID, Addr_Creator, Addr_InsertTime, Addr_Comments, Addr_Phone) VALUES(
@CustomerID, @Address, @Type, @CompanyID, @ProvinceID, @CityID, @DistrictID, @Operator, GETDATE(), (CASE WHEN @Automatic = 1 THEN N'�Զ����' ELSE '' END), @Phone);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510013004;
			END
			ELSE
			BEGIN
				SET @ID = IDENT_CURRENT('TMS_MAddr');
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_MAddr SET Addr_CustomerID = @CustomerID, Addr_Desc = @Address, Addr_Type = @Type, Addr_ProvinceID = @ProvinceID, Addr_CityID = @CityID, Addr_DistrictID = @DistrictID, Addr_Phone = @Phone, Addr_Updater = @Operator, Addr_UpdateTime = GETDATE() WHERE Addr_ID = @ID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510013005;
			END
		END
    END

	SET @AddrID = @ID;	
	
	SET NOCOUNT OFF;
END
GO


