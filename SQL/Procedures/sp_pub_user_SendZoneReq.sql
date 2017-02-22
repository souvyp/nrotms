USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_SendZoneReq]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_SendZoneReq]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*����԰������*/
CREATE PROCEDURE [dbo].[sp_pub_user_SendZoneReq]
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
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510062001;
	END
	
	-- ֻ�й���Ա���Է��ͼ���԰������
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_RoleID = 256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510062002;
	END
	
	-- ����Ǽ��Ƿ���ڲ�����Ч
	IF @Result = 0 AND NOT EXISTS(SELECT Branch_ID FROM TMS_CompanyBranches WHERE Branch_ID = @BranchID AND Branch_CompanyID = @CompanyID AND Branch_Invalid = 0 AND Branch_Status = 0)
	BEGIN
		SET @Result = -510062003;
	END
	
	-- ����Ǽ�
	IF @Result = 0
	BEGIN
		UPDATE TMS_CompanyBranches SET Branch_Status = 1 WHERE Branch_ID = @BranchID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510062004;
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
	
	SELECT @Result AS Branch_Result;

	SET NOCOUNT OFF;
END

GO


