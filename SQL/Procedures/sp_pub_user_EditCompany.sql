USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_EditCompany]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_EditCompany]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*修改公司信息*/
CREATE PROCEDURE [dbo].[sp_pub_user_EditCompany]
(
	@Operator BIGINT,
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
	@LicensePic NVARCHAR(300) = N'',
	@IsGroup BIGINT = 0 ,
	@IsZone BIGINT = 0 ,
	@CompanyID BIGINT ,
	@CompanyName NVARCHAR(250)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	SET @Result = 0;
	
	-- 非系统管理员不能修改公司名称
	IF @Operator > 1
	BEGIN
		SET @CompanyName = NULL;
		SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	END	

	
	BEGIN TRANSACTION;
	
	EXEC sp_prv_user_EditCompany @Operator, @CompanyID, @CompanyName, @Industry, @Logo, @Web, @ShortName, @EnName, @ShortEnName, @Master, @License, @Contact, @Phone, @Fax, @Zip, @Address, @Mail, @WeiXin, @Bank, @BankAccount, @Description, @LicensePic, @IsGroup, @IsZone, 0, @Result = @Result OUTPUT;
	
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


