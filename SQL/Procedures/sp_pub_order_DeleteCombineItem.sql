USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_DeleteCombineItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_DeleteCombineItem]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*ɾ����ƴ��������¼*/
CREATE PROCEDURE [dbo].[sp_pub_order_DeleteCombineItem]
(
	@Operator BIGINT,
	@CombineOrderID BIGINT,
	@OrdersLst NVARCHAR(MAX),
	@Description NVARCHAR(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	BEGIN TRANSACTION;
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510046001;
	END
	
	IF @Result = 0 AND LEN(@OrdersLst) = 0
	BEGIN
		SET @Result = -510046002;
	END
	
	-- ��ǰ�û�û����ӿͻ���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510046003;
	END
	
	-- �����Ƿ����
	IF @Result = 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @CombineOrderID AND Index_SrcClass = 3 AND Index_Invalid = 0 ANd Index_CreatorCompanyID = @CompanyID)
	BEGIN
		SET @Result = -510046004;
	END
	
	-- ֻ�����͵ĵ�����ɾ��
	IF @Result = 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @CombineOrderID AND Index_SrcClass = 3 AND Index_Invalid = 0 AND Index_Status = 0)
	BEGIN
		SET @Result = -510046005;
	END
	
	IF @Result = 0
	BEGIN
		DECLARE @tblOrders TABLE
		(
			OrderID BIGINT
		);
		INSERT INTO @tblOrders SELECT CAST(N.v.value('.' , 'varchar(100)') AS BIGINT) FROM (SELECT  [value] = CONVERT(XML , '<v>' + REPLACE(@OrdersLst, ',' , '</v><v>') + '</v>')) A CROSS APPLY A.[value].nodes('/v') N ( v );
		
		-- ɾ��ƴ����¼
		-- orderid1,orderid2,orderid3
		DELETE FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @CombineOrderID AND Contains_OrderID IN (SELECT OrderID FROM @tblOrders); 
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510046006;
		END
		ELSE
		-- Դ���ϵ�����������
		BEGIN
			UPDATE TMS_OrderIndex SET Index_Combined = 0, Index_SupplierID = 0, Index_SupplierCompanyID = 0 WHERE Index_ID IN (SELECT OrderID FROM @tblOrders);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510046007;
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
	
	SELECT @Result AS Combine_Result;

	SET NOCOUNT OFF;
END
GO


