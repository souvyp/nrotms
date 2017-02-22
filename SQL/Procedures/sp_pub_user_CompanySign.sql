USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_CompanySign]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_CompanySign]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- 公司登记
CREATE PROCEDURE [dbo].[sp_pub_user_CompanySign]
(
	@Name NVARCHAR(300),
	@Industry INT,
	@Logo NVARCHAR(300),
	@Web NVARCHAR(300),
	@ShortName NVARCHAR(100),
	@EnName NVARCHAR(200),
	@ShortEnName NVARCHAR(200),
	@Master NVARCHAR(100),
	@License NVARCHAR(100),
	@Contact NVARCHAR(300),
	@Phone NVARCHAR(100),
	@Fax NVARCHAR(100),
	@Zip NVARCHAR(100),
	@Address NVARCHAR(300),
	@Mail NVARCHAR(200),
	@WeiXin NVARCHAR(100),
	@Bank NVARCHAR(100),
	@BankAccount NVARCHAR(100),
	@Description NVARCHAR(MAX),
	@ReferCompanyID BIGINT = 0,			-- 推荐公司
	@IsPersonal tinyint = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @ClientCode NVARCHAR(100);
	SET @Result = 0;
	SET @ClientCode = 0;
	SET @CompanyID = 0;
	
	BEGIN TRANSACTION;
	
	EXEC sp_prv_user_CompanySign @Name, @Industry, @Logo, @Web, @ShortName, @EnName, @ShortEnName, @Master, @License, @Contact, @Phone, @Fax, @Zip, @Address, @Mail, @WeiXin, @Bank, @BankAccount, @Description, @ReferCompanyID, 0, @IsPersonal, @Result = @Result OUTPUT, @CompanyID = @CompanyID OUTPUT, @ClientCode = @ClientCode OUTPUT;

	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END
	
	SELECT @Result AS Company_Result, @CompanyID AS Company_ID, @ClientCode AS Company_Code;
	
	SET NOCOUNT OFF;
END



GO


