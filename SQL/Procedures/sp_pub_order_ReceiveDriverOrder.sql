USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_ReceiveDriverOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_ReceiveDriverOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*���ն���*/
CREATE PROCEDURE [dbo].[sp_pub_order_ReceiveDriverOrder]
(
	@OpenId NVARCHAR(300),
	@OrderID BIGINT,
	@Accept BIGINT = 1,			-- 1 ���� 0 �ܾ�
	@Description NVARCHAR(512) = N''
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Operator BIGINT;
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	DECLARE @FromCompanyID BIGINT;
	DECLARE @FromOperator BIGINT;
	DECLARE @SupplierOrderID BIGINT;
	SET @Result = 0;
	SET @Operator = dbo.fn_pub_user_OpenId2User (@OpenId);
	SET @CompanyID = dbo.fn_pub_user_OpenId2CompanyID(@OpenId, 0);
	SET @FromCompanyID = 0;
	SET @FromOperator = 0;
	SET @SupplierOrderID = 0;
	
	
	BEGIN TRANSACTION;

	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510017001;
	END
	
	-- ��ǰ�û�û�н��ܶ�����Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510017002;
	END
	
	-- ִ�ж������ղ���
	IF @Result = 0
	BEGIN
		EXEC sp_prv_order_ReceiveOrder @Operator, @CompanyID, @OrderID, @Accept, @Description, @Result = @Result OUTPUT,@SupplierOrderID = @SupplierOrderID OUTPUT;
	END
	
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS Order_Result,@SupplierOrderID AS SupplierOrderID;

	SET NOCOUNT OFF;
END
GO


