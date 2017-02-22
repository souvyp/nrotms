USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_ZoneCompanyEOD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_ZoneCompanyEOD]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 退出园区
CREATE PROCEDURE [dbo].[sp_pub_user_ZoneCompanyEOD]
(
	@Operator BIGINT,
	@BranchID BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	
	BEGIN TRANSACTION;

	-- 只有公司管理员有权执行该操作
	IF @Result = 0 AND NOT EXISTS(SELECT [USER_ID] FROM TMS_User INNER JOIN TMS_Company ON User_CompanyID = Company_ID WHERE [USER_ID]=@Operator AND User_RoleID & 256 =256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510024001;
	END
	
	-- 是否在园区内
	IF @Result = 0 AND NOT EXISTS(SELECT Branch_ID FROM TMS_CompanyBranches WHERE Branch_ID = @BranchID AND @CompanyID = Branch_CompanyID AND  Branch_Category=2 AND Branch_Invalid = 0)
	BEGIN
		SET @Result = -510024002;
	END	


	-- 启用或禁用
	IF @Result = 0
	BEGIN
		UPDATE TMS_CompanyBranches SET Branch_Invalid = 1,Branch_Status = 32 WHERE Branch_ID = @BranchID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510024003;
		END
	END
	
	
	-- 添加事件通知
	-- 退出园区 类型 32
	IF @Result = 0
	BEGIN
		DECLARE @tmpResult BIGINT;
		DECLARE @EventID BIGINT;
		DECLARE @OccurTime DATETIME;
		DECLARE @DstCompanyID BIGINT;
		SET @tmpResult = 0;
		SET @EventID = 0;
		SET @OccurTime = GETDATE();
		SELECT @DstCompanyID = Branch_OwnerCompanyID FROM TMS_CompanyBranches WHERE Branch_ID = @BranchID;
		
		EXEC sp_prv_event_AddEvent @Operator, 32, @DstCompanyID, 0, @BranchID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
		IF @tmpResult <> 0 
		BEGIN
			SET @Result = -510052008;
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

	SELECT @Result AS OuteZone_Result;

	SET NOCOUNT OFF;
END
GO


