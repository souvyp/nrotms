USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_EditDriverCompany]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_EditDriverCompany]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*修改个体司机信息*/
CREATE PROCEDURE [dbo].[sp_pub_user_EditDriverCompany]
(
	@OpenId NVARCHAR(300),
	@Contact NVARCHAR(300),
	@Phone NVARCHAR(100),
	@Fax NVARCHAR(100),
	@Zip NVARCHAR(100),
	@Address NVARCHAR(300),
	@Mail NVARCHAR(200),
	@Bank NVARCHAR(100),
	@BankAccount NVARCHAR(100)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Operator BIGINT;
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Operator = dbo.fn_pub_user_OpenId2User(@OpenId);
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	
	BEGIN TRANSACTION;
	
	EXEC sp_prv_user_EditCompany @Operator, @CompanyID, N'', N'', N'', N'', N'', N'', N'', N'', N'', @Contact, @Phone, @Fax, @Zip, @Address, @Mail, N'', @Bank, @BankAccount, N'', N'', N'', N'', 0, @Result = @Result OUTPUT;
	
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END
	
	SELECT @Result AS Company_Result;
	
	SET NOCOUNT OFF;
END






GO


