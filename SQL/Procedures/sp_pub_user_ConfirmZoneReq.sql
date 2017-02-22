USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_ConfirmZoneReq]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_ConfirmZoneReq]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*��˼�������*/
CREATE PROCEDURE [dbo].[sp_pub_user_ConfirmZoneReq]
(
	@Operator BIGINT,
	@ZoneID BIGINT,
	@Description NVARCHAR(500),
	@AOR BIGINT				-- Accept = 1 or Reject = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @DstCompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @DstCompanyID = 0;
	
	BEGIN TRANSACTION;
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510063001;
	END
	
	-- ֻ�м���Ȩ�޲����������ż�������[��δȷ������Ȩ�޵�RoleID]
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510063002;
	END
	
	-- ��ǰ��˾�Ƿ�����Ϊ���ű���
	IF @Result = 0 AND NOT EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = @CompanyID AND Company_IsZones = 1 AND Company_Invalid = 0 AND Company_Status = 2)
	BEGIN
		SET @Result = -510063003;
	END

	-- ����Ǽ��Ƿ���ڲ�����Ч
	IF @Result = 0
	BEGIN
		SELECT @DstCompanyID = Branch_CompanyID FROM TMS_CompanyBranches WHERE Branch_ID = @ZoneID AND Branch_OwnerCompanyID = @CompanyID AND Branch_Invalid = 0 AND Branch_Status = 1 AND Branch_Category=2 ;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510063004;
		END
	END
	
	-- ����Ǽ�
	IF @Result = 0
	BEGIN
		UPDATE TMS_CompanyBranches SET Branch_Status = (CASE WHEN @AOR = 1 THEN 2 ELSE 0 END), Branch_ResDescription = @Description, Branch_Confirmer = @Operator, Branch_ConfirmTime = GETDATE() WHERE Branch_ID = @ZoneID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510063005;
		END
	END
	
	-- ����¼�֪ͨ(34 �ɹ�����԰�� 35 ԰�����뱻�ܾ�)
	IF @Result = 0
	BEGIN
		DECLARE @tmpResult BIGINT;
		DECLARE @EventType BIGINT;
		DECLARE @OccurTime DATETIME;
		DECLARE @EventID BIGINT;
		SET @tmpResult = 0;
		SET @EventType = (CASE WHEN @AOR = 1 THEN 34 ELSE 35 END);
		SET @OccurTime = GETDATE();
		SET @EventID = 0;

		EXEC sp_prv_event_AddEvent @Operator, @EventType, @DstCompanyID, @AOR, @ZoneID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
		IF @tmpResult <> 0 
		BEGIN
			SET @Result = -510063006;
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


