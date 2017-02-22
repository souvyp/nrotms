USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_my_EditCustomer]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_my_EditCustomer]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*添加或修改客户*/
CREATE PROCEDURE [dbo].[sp_pub_my_EditCustomer]
(
	@Operator BIGINT,
	@ID BIGINT,
	@CustomerCompanyID BIGINT, 
	@Name NVARCHAR(300) = '', 
	@Industry INT = 0,
	@Logo NVARCHAR(300) = '',
	@Web NVARCHAR(300) = '',
	@ShortName NVARCHAR(100) = '',
	@EnName NVARCHAR(200) = '',
	@ShortEnName NVARCHAR(200) = '',
	@Master NVARCHAR(100) = '',
	@License NVARCHAR(100) = '',
	@Contact NVARCHAR(300) = '',
	@Phone NVARCHAR(100) = '',
	@Fax NVARCHAR(100) = '',
	@Zip NVARCHAR(100) = '',
	@Address NVARCHAR(300) = '',
	@Mail NVARCHAR(200) = '',
	@WeiXin NVARCHAR(100) = '',
	@Bank NVARCHAR(100) = '',
	@BankAccount NVARCHAR(100) = '',
	@Description NVARCHAR(MAX) = ''
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	SET @Result = 0;
	
	BEGIN TRANSACTION;
	
	EXEC sp_prv_my_EditCustomer @Operator, @ID, @CustomerCompanyID, 0, @Name, @Industry, @Logo, @Web, @ShortName, @EnName, @ShortEnName, @Master, @License, @Contact, @Phone, @Fax, @Zip, @Address, @Mail, @WeiXin, @Bank, @BankAccount, @Description, @Result = @Result OUTPUT, @CustomerID = @ID OUTPUT

	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END
	
	SELECT @Result AS Customer_Result, @ID AS Customer_ID;
	
	SET NOCOUNT OFF;
END



GO


