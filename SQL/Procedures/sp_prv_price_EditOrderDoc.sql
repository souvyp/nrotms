USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_EditOrderDoc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_EditOrderDoc]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*�������޸ı��۵�*/
CREATE PROCEDURE [dbo].[sp_prv_price_EditOrderDoc]
(
	@Operator BIGINT,
	@Type BIGINT,				-- 1 �������� 2 ����Լ���� 3 ���䱨�� 4 �ϵ����� 5 �ϵ����䱨��
	-- ����������
	@OrderID BIGINT = 0,
	-- ����ͬ����
	@PactCode NVARCHAR(50) = N'',
	@Name NVARCHAR(300),
	@Description NVARCHAR(1024),
	@CustomerID BIGINT,
	@StartTime DATETIME = NULL,
	@EndTime DATETIME = NULL,
	@TxnRequired TINYINT = 0,
	@DocID BIGINT = 0 OUTPUT,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	
	DECLARE @CompanyID BIGINT;
	DECLARE @Code NVARCHAR(100);
	DECLARE @CustomerCompanyID BIGINT;
	DECLARE @SupplierSymbolID BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
		IF @DocID IS NULL OR @DocID = 0
	BEGIN
		DECLARE @_AdditionType BIGINT;
		SET @_AdditionType = (CASE WHEN @Type = 1 THEN 2 WHEN @Type = 2 THEN 5 WHEN @Type = 3 THEN 3 WHEN @Type = 4 THEN 4 WHEN @Type = 5 THEN 6 ELSE 0 END);

		EXEC sp_pub_basic_GetSN 4, @SN = @Code OUTPUT, @AdditionType = @_AdditionType;
	END
	SET @CustomerCompanyID = 0;
	SET @SupplierSymbolID = 0;
	IF @StartTime IS NULL
	BEGIN
		SET @StartTime = 0
	END
	IF @EndTime IS NULL
	BEGIN
		SET @EndTime = 0
	END
	
	
	IF @StartTime IS NULL
	BEGIN
		SET @StartTime = 0
	END
	
	IF @EndTime IS NULL
	BEGIN
		SET @EndTime = 0
	END
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -520001001;
	END
	
	-- ��ǰ�û�û����ӿͻ���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520001002;
	END
	
	-- �������ۻ򲹳䱨��
	IF @Result = 0 AND (@Type = 1 OR @Type = 3) AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Status <> 32 AND Index_Invalid = 0 AND Index_SrcClass IN (1,2))
	BEGIN
		SET @Result = -520001003;
	END
	
	-- �ϵ�����
	IF @Result = 0 AND @Type = 4 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Status <> 32 AND Index_Invalid = 0 AND Index_SrcClass = 3)
	BEGIN
		SET @Result = -520001004;
	END

	-- ����Լ����(ͬһ��Լ���Զ�α���)
	IF @Result = 0 AND @Type = 2 AND (@PactCode IS NULL OR @PactCode = '')
	BEGIN
		SET @Result = -520001005;
	END
	
	-- �ͻ��Ƿ����
	IF @Result = 0
	BEGIN
		IF @Type IN(4,5)
		BEGIN		
			SELECT @CustomerCompanyID = Index_CreatorCompanyID FROM TMS_OrderIndex WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @CustomerCompanyID = 0;
			END

			SELECT @CustomerID = Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @CompanyID AND Customer_CompanyID = @CustomerCompanyID AND Customer_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @CustomerID = 0;
			END
		END
		ELSE
		BEGIN
			SELECT @CustomerCompanyID = Customer_CompanyID FROM TMS_MCustomer WHERE Customer_ID = @CustomerID AND Customer_OwnerCompany = @CompanyID AND Customer_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520001006;
			END
		END
	END
	
	-- [�༭ģʽ]ԭ���۵��Ƿ���ڣ����ݸ�ģʽ����༭
	IF @Result = 0 AND @DocID > 0 AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0 AND Index_Status = 0)
	BEGIN
		SET @Result = -520001007;
	END
	
	-- ��Ӫ�İ������ۻ���Ӫƴ������
	IF @Result = 0
	BEGIN
		SELECT @SupplierSymbolID = Index_SupplierSymbolID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_SupplierID = 0 AND Index_SupplierCompanyID = 0 AND Index_SupplierSymbolID > 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @SupplierSymbolID = 0;
		END
	END
	
	IF @Result = 0
	BEGIN
		IF @DocID = 0
		BEGIN
			-- ���
			INSERT INTO Price_DocIndex(Index_Code, Index_PactCode, Index_Name, Index_StartTime, Index_EndTime, Index_Description, 
Index_OrderID, Index_Type, Index_Status, Index_StatusTime, Index_CustomerID, Index_CustomerCompanyID, Index_SupplierSymbolID, Index_CreatorID, 
Index_CreatorCompanyID, Index_CreateTime, Index_Invalid) VALUES(@Code, @PactCode, @Name, @StartTime, @EndTime, @Description, @OrderID, 
@Type, 0, GETDATE(), @CustomerID, @CustomerCompanyID, @SupplierSymbolID, @Operator, @CompanyID, GETDATE(), 0);
			IF @@ROWCOUNT = 0 
			BEGIN
				SET @Result = -520001008;
			END
			ELSE
			BEGIN
				SET @DocID = IDENT_CURRENT('Price_DocIndex');
			END
		END
		ELSE
		BEGIN
			-- �༭
			UPDATE Price_DocIndex SET Index_PactCode = @PactCode, Index_Name = @Name, Index_StartTime = @StartTime, Index_EndTime = @EndTime, 
Index_Description = @Description, Index_OrderID = @OrderID, Index_Type = @Type, Index_CustomerID = @CustomerID, 
Index_CustomerCompanyID = @CustomerCompanyID, Index_SupplierSymbolID = @SupplierSymbolID WHERE Index_ID = @DocID AND Index_Invalid = 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520001009;
			END
		END
	END

END

	


GO


