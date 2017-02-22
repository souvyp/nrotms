USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_ConfirmCompany]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_ConfirmCompany]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- 审核公司登记信息
CREATE PROCEDURE [dbo].[sp_pub_user_ConfirmCompany]
(
	@CompanyID BIGINT,
	@Accept TINYINT,			-- 1 同意 0 拒绝
	@Operator BIGINT,
	@AdminAccount VARCHAR(100) = N'',
	@AdminPwd VARCHAR(100) = N'',
	@AdminName NVARCHAR(100) = N''
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @AdminID BIGINT;
	SET @Result = 0;
	SET @AdminID = 0;

	BEGIN TRANSACTION;
	
	EXEC sp_prv_user_ConfirmCompany	@CompanyID, @Accept, @Operator, @AdminAccount, @AdminPwd, @AdminName, 0, @Result = @Result OUTPUT, @AdminID = @AdminID OUTPUT;

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


