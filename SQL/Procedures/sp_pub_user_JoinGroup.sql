USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_JoinGroup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_JoinGroup]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*申请加入集团*/
CREATE PROCEDURE [dbo].[sp_pub_user_JoinGroup]
(
	@Operator BIGINT,
	@BranchID BIGINT = 0,
	@GroupCompanyCode NVARCHAR(100),
	@Description NVARCHAR(500),
	@SendDirectly BIGINT = 1
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @CompanyName NVARCHAR(300);
	DECLARE @GroupCompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @GroupCompanyID = 0;
	SET @CompanyName = dbo.fn_pub_user_Company2Name(@CompanyID);
	IF @SendDirectly < 0 OR @SendDirectly IS NULL
	BEGIN
		SET @SendDirectly = 0;
	END
	IF @SendDirectly > 1
	BEGIN
		SET @SendDirectly = 1;
	END
	IF @BranchID IS NULL
	BEGIN
		SET @BranchID = 0;
	END
	
	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510056001;
	END
	
	-- 只有管理员可以提交或修改加入集团申请
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_RoleID = 256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510056002;
	END
	
	-- 获取集团的公司编号
	IF @Result = 0
	BEGIN
		SELECT @GroupCompanyID = Company_ID FROM TMS_Company WHERE Company_ClientCode = @GroupCompanyCode AND Company_Invalid = 0 AND Company_Status = 2;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510056003;
		END
	END
	
	-- 目标公司是否申明为集团本部
	IF @Result = 0 AND NOT EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = @GroupCompanyID AND Company_IsGroup = 1)
	BEGIN
		SET @Result = -510056004;
	END

	-- 是否已经申请过了[一个公司只能属于一个集团]
	IF @Result = 0 AND EXISTS(SELECT Branch_ID FROM TMS_CompanyBranches WHERE Branch_CompanyID = @CompanyID AND Branch_Invalid = 0 AND Branch_Status IN (0,1,2) AND Branch_ID <> @BranchID AND Branch_Category = 1)
	BEGIN
		SET @Result = -510056005;
	END
	
	-- 待编辑内容是否存在
	IF @Result = 0 AND @BranchID > 0 AND NOT EXISTS(SELECT Branch_ID FROM TMS_CompanyBranches WHERE Branch_ID = @BranchID AND Branch_Invalid = 0 AND Branch_Status = 0)
	BEGIN
		SET @Result = -510056006;
	END
	
	-- 申请登记
	IF @Result = 0
	BEGIN
		IF @BranchID > 0
		BEGIN
			UPDATE TMS_CompanyBranches SET Branch_OwnerCompanyID = @GroupCompanyID, Branch_ReqDescription = @Description, Branch_Creator = @Operator, Branch_CreateTime = GETDATE(), 
Branch_Status =(CASE WHEN @SendDirectly = 1 THEN 1 ELSE 0 END) WHERE Branch_ID = @BranchID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510056007;
			END
		END
		ELSE
		BEGIN
			INSERT INTO TMS_CompanyBranches(Branch_OwnerCompanyID, Branch_CompanyID, Branch_Name, Branch_ReqDescription, Branch_Creator, Branch_CreateTime, Branch_Status, Branch_Invalid) 
VALUES(@GroupCompanyID, @CompanyID, @CompanyName, @Description, @Operator, GETDATE(), (CASE WHEN @SendDirectly = 1 THEN 1 ELSE 0 END), 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510056008;
			END
		END
	END

	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END
	
	SELECT @Result AS Group_Result;
	
	SET NOCOUNT OFF;
END
GO


