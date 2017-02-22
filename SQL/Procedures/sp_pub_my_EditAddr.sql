USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_my_EditAddr]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_my_EditAddr]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*��ӻ��޸��ջ������������õ�ַ��*/
CREATE PROCEDURE [dbo].[sp_pub_my_EditAddr]
(
	@Operator BIGINT,
	@ID BIGINT,
	@CustomerID BIGINT,
	@Address NVARCHAR(300),
	@Type TINYINT,                -- 1 �ջ���ַ 2 ������ַ 3 ��Ӧ�̳��õ�ַ
	@ProvinceID BIGINT = 0,
	@CityID BIGINT = 0,
	@DistrictID BIGINT = 0,
	@Phone NVARCHAR(300) = N''
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @AddrID BIGINT;
	SET @Result = 0;
	SET @AddrID = 0;

	BEGIN TRANSACTION;

	EXEC sp_prv_my_EditAddr @Operator, @ID, @CustomerID, @Address, @Type, @ProvinceID, @CityID, @DistrictID, 0, 0, @Phone, @Result = @Result OUTPUT, @AddrID = @AddrID OUTPUT;

	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END
	
	SELECT @Result AS Addr_Result, @AddrID AS Addr_ID;
	
	SET NOCOUNT OFF;
END


GO


