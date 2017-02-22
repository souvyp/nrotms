USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_GroupCompanyEOD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_GroupCompanyEOD]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 启用或禁用集体分公司
CREATE PROCEDURE [dbo].[sp_pub_user_GroupCompanyEOD]
(
	@Operator BIGINT,
	@BranchID BIGINT,
	@EOD TINYINT			-- 0 Disable 1 Enable
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	
	BEGIN TRANSACTION;

	-- 只有集团公司管理员有权执行该操作
	IF @Result = 0 AND NOT EXISTS(SELECT [USER_ID] FROM TMS_User INNER JOIN TMS_Company ON User_CompanyID = Company_ID WHERE [USER_ID]=@Operator AND User_RoleID & 256 =256 AND User_Invalid = 0 AND Company_IsGroup = 1)
	BEGIN
		SET @Result = -510024001;
	END


	-- 启用或禁用
	IF @Result = 0
	BEGIN
		UPDATE TMS_CompanyBranches SET Branch_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE Branch_ID = @BranchID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510024003;
		END
	END
	
		-- 添加事件通知(23 成功加入集团 24 集团申请被拒绝)
	IF @Result = 0
	BEGIN
		DECLARE @tmpResult BIGINT;
		DECLARE @EventType BIGINT;
		DECLARE @OccurTime DATETIME;
		DECLARE @EventID BIGINT;
		DECLARE @DstCompanyID BIGINT;
		SET @tmpResult = 0;
		SET @EventType = (CASE WHEN @EOD = 0 THEN 31 ELSE 23 END);
		SET @OccurTime = GETDATE();
		SET @EventID = 0;
		
		SELECT @DstCompanyID = Branch_CompanyID FROM TMS_CompanyBranches WHERE Branch_ID = @BranchID;
		
		EXEC sp_prv_event_AddEvent @Operator, @EventType, @DstCompanyID, @EOD, @BranchID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
		IF @tmpResult <> 0 
		BEGIN
			SET @Result = -510024004;
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

	SELECT @Result AS GroupCompanyEOD_Result;

	SET NOCOUNT OFF;
END
GO


