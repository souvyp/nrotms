USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_ScanSearchOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_ScanSearchOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	扫码验证订单并查询详情
-- =============================================
CREATE PROCEDURE [dbo].[sp_pub_order_ScanSearchOrder]
	@OpenID NVARCHAR(50),
	@tocontact NVARCHAR(50),
	@devicecode  NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Result BIGINT;
	DECLARE @orderid BIGINT;
	DECLARE @Srclass BIGINT;
	SET @Result = 0;
	SET @orderid = 0;
	SET @Srclass = 0;
	
	IF NOT EXISTS (SELECT Index_ID FROM TMS_OrderIndex AS A LEFT JOIN (SELECT User_OpenId,User_CompanyID FROM TMS_User WHERE User_OpenId <> '' AND User_OpenId IS NOT NULL) AS B ON  A.Index_SupplierCompanyID = B.User_CompanyID WHERE Index_ToContact = @tocontact AND Index_DeviceCode = @devicecode)
	BEGIN
		SET @Result = 1
	END	
		
	-- 扫码签收查看托运方的客户订单
	IF @Result = 0 
	BEGIN
		SELECT TOP 1 @orderid=Index_ID  FROM TMS_OrderIndex AS A WHERE Index_ToContact = @tocontact AND Index_DeviceCode = @devicecode AND Index_SrcClass = 1 AND Index_Status < 4  ORDER BY Index_CreateTime ASC;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510019003;
		END	
	END	
	
		-- 订单是否已经被签收
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM TMS_OrderIndex WHERE Index_ID = @orderid AND Index_Status >= 2 AND Index_Invalid = 0)
	BEGIN
		SET @Result = -510019004;
	END

	
	SELECT @Result AS Search_Result;
	
	SELECT Index_ID AS [orderid], Index_Code AS [code],  Index_EndUserName AS [endusername], (dbo.fn_pub_order_AreaName( Index_FromProvince)+' '+dbo.fn_pub_order_AreaName( Index_FromCity)+' '+dbo.fn_pub_order_AreaName( Index_FromDistrict)+' '+Index_From) AS [from], (dbo.fn_pub_order_AreaName( Index_ToProvince)+' '+dbo.fn_pub_order_AreaName( Index_ToCity) +' '+dbo.fn_pub_order_AreaName( Index_ToDistrict) +' '+ Index_To) AS [to],dbo.fn_pub_order_TotalVolume(Index_ID,0) AS [volume] ,dbo.fn_pub_order_TotalWeight(Index_ID,0) AS [weight], dbo.fn_pub_order_TotalAmount(Index_ID,0) AS [amount],CONVERT(varchar(16), Index_FromTime,120) AS Fromtime,CONVERT(varchar(16), Index_ToTime,120) AS Totime,dbo.fn_pub_user_Company2Name( Index_CustomerCompanyID) AS [CustomerCompanyName], dbo.fn_pub_order_TotalCost( index_ID) AS [TotalCost], B.User_OpenId AS [OpenId], A.Index_DeviceCode AS [DeviceCode],CONVERT(varchar(16), Index_StatusTime,120) AS [StatusTime],Index_OnLoad AS [OnLoad], Index_OffLoad AS [OffLoad],Index_Pick AS [Pick],Index_Delivery AS [Delivery],Index_Insurance AS [Insurance],Index_ToContact AS [ToContact],Index_ChargeMode AS [ChargeMode], Index_PriceUnit AS [PriceUnit],Index_GoodsCategory
 AS [GoodsCategory],Index_PackageMode AS [PackageMode],Index_PactCode AS [pactcode],Index_FromContact AS [fromcontact],Index_TransportMode  AS [transportmode],Index_WeightAddition AS [weightaddition],Index_VolumeAddition AS [volumeaddtion],Index_ShipMode AS [shipmode]  FROM TMS_OrderIndex AS A LEFT JOIN (SELECT User_OpenId,User_CompanyID FROM TMS_User WHERE User_OpenId <> '' AND User_OpenId IS NOT NULL) AS B ON  A.Index_SupplierCompanyID = B.User_CompanyID WHERE Index_ID = @orderid ;
	/** 物品详情 前端暂时不支持一起获取
	SELECT a.GoodsLst_ID AS [ListID], a.GoodsLst_OrderID AS [OrderID], a.GoodsLst_GoodsID AS [GoodsID], a.GoodsLst_Code AS [Code], a.GoodsLst_Name AS [Name], (SELECT CAST(a.GoodsLst_Qty AS INT)) AS [Qty], a.GoodsLst_Weight AS [Weight], a.GoodsLst_Volume AS [Volume], a.GoodsLst_Weight AS [weight], a.GoodsLst_Volume AS [volume], CAST( a.GoodsLst_Price*a.GoodsLst_Qty AS   DECIMAL(10,2)) AS [Price], CAST( a.GoodsLst_Price AS   DECIMAL(10,2)) AS [price],(SELECT CAST(a.GoodsLst_ReceiptQty AS INT)) AS [ReceiptQty], (SELECT CAST(a.GoodsLst_ExceptionQty AS INT)) AS [ExceptionQty],a.GoodsLst_BatchNo AS [BatchNo], a.GoodsLst_Creator AS [Creator], a.GoodsLst_InsertTime AS [InsertTime], a.GoodsLst_Updater AS [Updater], a.GoodsLst_UpdateTime AS [UpdateTime], a.GoodsLst_Invalid AS [Invalid], a.GoodsLst_Comments AS [Comments],b.Goods_SPC AS [SPC],dbo.fn_pub_price_UnitName(b.Goods_Unit) AS [UnitName] FROM TMS_OrderGoods AS a INNER JOIN TMS_MGoods AS b ON a.GoodsLst_GoodsID = b.Goods_ID WHERE a.GoodsLst_OrderID = @orderid;	
	**/
    -- Insert statements for procedure here
	
END

GO


