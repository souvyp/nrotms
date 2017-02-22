USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_QueryOrdersByCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_QueryOrdersByCode]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
�����������ѯ�����б�

@Type�Ŀ���ֵ��
1 �Լ��Ķ��������ݿͻ��������������䶩���б�
2 �ͻ��ṩ(�ͻ�/����)����ǿ�ң���ȡ�ҷ��Ŀͻ��������
*/
CREATE PROCEDURE [dbo].[sp_pub_order_QueryOrdersByCode]
(
	@Operator BIGINT,
	@Code NVARCHAR(100),
	@Type BIGINT = 1
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @CompanyID BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	DECLARE @tblOrds TABLE
	(
		OrderID BIGINT
	);
	IF @Type = 1 AND LEN(@Code) >= 16
	BEGIN
		INSERT INTO @tblOrds SELECT Index_ID FROM TMS_OrderIndex WHERE Index_SrcClass = 2 AND Index_Code <> @Code AND Index_Code LIKE @Code + '%' AND Index_CreatorCompanyID = @CompanyID AND Index_Invalid = 0;
	END
	
	IF @Type = 2 AND LEN(@Code) >= 16
	BEGIN
		DECLARE @_RootOrderID BIGINT;
		SELECT @_RootOrderID = Index_RootOrderID FROM TMS_OrderIndex WHERE Index_Code LIKE @Code + '%' AND Index_SupplierCompanyID = @CompanyID AND Index_Invalid = 0;
		
		INSERT INTO @tblOrds SELECT Index_ID FROM TMS_OrderIndex WHERE Index_SrcClass = 1 AND Index_RootOrderID=  @_RootOrderID AND Index_CreatorCompanyID = @CompanyID AND Index_Invalid = 0;
	END

	-- 3 ͨ���ҵ����䶩���Ų�ѯ�����̷��Ŀͻ��������
	-- [�ݲ�֧��]�ɳ����̷�ͨ��2�еķ�����ѯ
	
	SELECT a.Index_ID AS [ID], a.Index_Code AS [Code], a.Index_PactCode AS [PactCode], dbo.fn_pub_user_Customer2Name(a.Index_CustomerID) AS [CustomerName], 
dbo.fn_pub_user_EndUser2Name(a.Index_EndUserID) AS [EndUserName], a.Index_From AS [From], a.Index_To AS [TO], 
dbo.fn_pub_order_TotalAmount(a.Index_ID, 0) AS [Amount], dbo.fn_pub_order_TotalWeight(a.Index_ID, 0) AS [Weight],
dbo.fn_pub_order_TotalVolume(a.Index_ID, 0) AS [Volume], a.Index_Status AS [Status] FROM TMS_OrderIndex AS a INNER JOIN @tblOrds AS b ON a.Index_ID = b.OrderID;

	SET NOCOUNT OFF;
END
GO


