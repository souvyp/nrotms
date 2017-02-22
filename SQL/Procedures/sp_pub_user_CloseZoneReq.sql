USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_CloseZoneReq]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_CloseZoneReq]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*�رռ�������*/
CREATE PROCEDURE [dbo].[sp_pub_user_CloseZoneReq]
(
	@Operator BIGINT,
	@ZoneID BIGINT,
	@Description NVARCHAR(300)
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
		SET @Result = -510060001;
	END
	
	-- ֻ�й���Ա���Թرռ��뼯������
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_RoleID = 256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510060002;
	END
	
	-- ����Ǽ��Ƿ���ڲ��ҿ��Թر�
	IF @Result = 0 AND NOT EXISTS(SELECT Branch_ID FROM TMS_CompanyBranches WHERE Branch_ID = @ZoneID AND Branch_CompanyID = @CompanyID AND Branch_Invalid = 0 AND (Branch_Status = 0 OR Branch_Status = 1))
	BEGIN
		SET @Result = -510060003;
	END
	
	-- �ر�
	IF @Result = 0
	BEGIN
		UPDATE TMS_CompanyBranches SET Branch_Status = 32, Branch_Comments = @Description WHERE Branch_ID = @ZoneID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510060004;
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


