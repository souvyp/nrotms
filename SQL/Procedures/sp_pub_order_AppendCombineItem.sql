USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_AppendCombineItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_AppendCombineItem]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*追加被拼车订单到拼车单中*/
CREATE PROCEDURE [dbo].[sp_pub_order_AppendCombineItem]
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
	DECLARE @SupplierID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	DECLARE @ShipMode BIGINT;
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @SupplierID = 0;
	SET @SupplierCompanyID = 0;
	SET @ShipMode = 0;
	
	BEGIN TRANSACTION;
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510045001;
	END
	
	IF @Result = 0 AND LEN(@OrdersLst) = 0
	BEGIN
		SET @Result = -510045002;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510045003;
	END
	
	-- 订单是否存在
	IF @Result = 0
	BEGIN
		SELECT @SupplierID = Index_SupplierID, @SupplierCompanyID = Index_SupplierCompanyID, @ShipMode = Index_ShipMode FROM TMS_OrderIndex WHERE Index_ID = @CombineOrderID AND Index_SrcClass = 3 AND Index_Invalid = 0 ANd Index_CreatorCompanyID = @CompanyID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510045004;
		END
	END
	
	-- 只待发送的单据能追加
	IF @Result = 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @CombineOrderID AND Index_SrcClass = 3 AND Index_Invalid = 0 AND Index_Status = 0)
	BEGIN
		SET @Result = -510045005;
	END
	
	IF @Result = 0
	BEGIN
		DECLARE @tblOrders TABLE
		(
			OrderID BIGINT
		);
		INSERT INTO @tblOrders SELECT CAST(N.v.value('.' , 'varchar(100)') AS BIGINT) FROM (SELECT  [value] = CONVERT(XML , '<v>' + REPLACE(@OrdersLst, ',' , '</v><v>') + '</v>')) A CROSS APPLY A.[value].nodes('/v') N ( v );
		
		-- 删除绑定清单中已经存在的
		DELETE FROM @tblOrders WHERE OrderID IN (SELECT Contains_OrderID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @CombineOrderID AND Contains_Invalid = 0);

		-- 添加拼车记录
		-- orderid1,orderid2,orderid3
		INSERT INTO TMS_OrderContains(Contains_OwnerOrderID, Contains_OrderID, Contains_Volume, Contains_Weight, Contains_Amount, Contains_Creator, Contains_InsertTime,
Contains_Invalid) SELECT @CombineOrderID, a.Index_ID, dbo.fn_pub_order_TotalVolume(a.Index_ID, 0), dbo.fn_pub_order_TotalWeight(a.Index_ID, 0), dbo.fn_pub_order_TotalAmount(a.Index_ID, 0), 
@Operator, GETDATE(), 0 FROM TMS_OrderIndex AS a INNER JOIN @tblOrders AS b ON a.Index_ID = b.OrderID WHERE Index_SrcClass = 2 AND Index_Invalid = 0 AND Index_Status = 1 AND Index_ShipMode = @ShipMode; 
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510045006;
		END
		ELSE
		-- 被合单订单做标记
		BEGIN
			UPDATE TMS_OrderIndex SET Index_Combined = 1 WHERE Index_ID IN (SELECT Contains_OrderID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @CombineOrderID AND Contains_Invalid = 0);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510045007;
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


