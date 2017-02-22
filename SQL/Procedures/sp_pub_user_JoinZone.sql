USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_JoinZone]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_JoinZone]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*������뼯��*/
CREATE PROCEDURE [dbo].[sp_pub_user_JoinZone]
(
	@Operator BIGINT,
	@ZoneID BIGINT = 0,
	@ZoneCompanyCode NVARCHAR(100),
	@Description NVARCHAR(500),
	@SendDirectly BIGINT = 1
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @CompanyName NVARCHAR(300);
	DECLARE @ZoneCompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @ZoneCompanyID = 0;
	SET @CompanyName = dbo.fn_pub_user_Company2Name(@CompanyID);
	IF @SendDirectly < 0 OR @SendDirectly IS NULL
	BEGIN
		SET @SendDirectly = 0;
	END
	IF @SendDirectly > 1
	BEGIN
		SET @SendDirectly = 1;
	END
	IF @ZoneID IS NULL
	BEGIN
		SET @ZoneID = 0;
	END
	
	BEGIN TRANSACTION;
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510061001;
	END
	
	-- ֻ�й���Ա�����ύ���޸ļ�������԰������
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_RoleID = 256 AND User_Invalid = 0)
	BEGIN
		SET @Result = -510061002;
	END
	
	-- ��ȡ԰���Ĺ�˾���
	IF @Result = 0
	BEGIN
		SELECT @ZoneCompanyID = Company_ID FROM TMS_Company WHERE Company_ClientCode = @ZoneCompanyCode AND Company_Invalid = 0 AND Company_Status = 2;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510061003;
		END
	END
	
	-- Ŀ�깫˾�Ƿ�����Ϊ԰������
	IF @Result = 0 AND NOT EXISTS(SELECT Company_ID FROM TMS_Company WHERE Company_ID = @ZoneCompanyID AND Company_IsZones = 1)
	BEGIN
		SET @Result = -510061004;
	END

	-- �Ƿ��Ѿ��������[һ����˾ֻ������һ��԰��]
	IF @Result = 0 AND EXISTS(SELECT Branch_ID FROM TMS_CompanyBranches WHERE Branch_CompanyID = @CompanyID AND Branch_Invalid = 0 AND Branch_Status IN (0,1,2) AND Branch_ID <> @ZoneID AND Branch_Category = 2)
	BEGIN
		SET @Result = -510061005;
	END
	
	-- ���༭�����Ƿ����
	IF @Result = 0 AND @ZoneID > 0 AND NOT EXISTS(SELECT Branch_ID FROM TMS_CompanyBranches WHERE Branch_ID = @ZoneID AND Branch_Invalid = 0 AND Branch_Status = 0)
	BEGIN
		SET @Result = -510061006;
	END
	
	-- ����Ǽ�
	IF @Result = 0
	BEGIN
		IF @ZoneID > 0
		BEGIN
			UPDATE TMS_CompanyBranches SET Branch_OwnerCompanyID = @ZoneCompanyID, Branch_ReqDescription = @Description, Branch_Creator = @Operator, Branch_CreateTime = GETDATE(), 
Branch_Status =(CASE WHEN @SendDirectly = 1 THEN 1 ELSE 0 END) WHERE Branch_ID = @ZoneID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510061007;
			END
		END
		ELSE
		BEGIN
			INSERT INTO TMS_CompanyBranches(Branch_OwnerCompanyID, Branch_CompanyID, Branch_Name, Branch_ReqDescription, Branch_Creator, Branch_CreateTime, Branch_Status, Branch_Invalid,Branch_Category)  
VALUES(@ZoneCompanyID, @CompanyID, @CompanyName, @Description, @Operator, GETDATE(), (CASE WHEN @SendDirectly = 1 THEN 1 ELSE 0 END), 0,2);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510061008;
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


