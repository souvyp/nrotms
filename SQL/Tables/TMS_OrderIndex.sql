USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_OrderIndex__opt_st__3F466844]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF__TMS_OrderIndex__opt_st__3F466844]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_EndUserID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_EndUserID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_FromProvince]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_FromProvince]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_FromCity]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_FromCity]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_FromDistrict]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_FromDistrict]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_ToProvince]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_ToProvince]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_ToCity]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_ToCity]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_ToDistrict]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_ToDistrict]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_Status]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_SrcOrderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_SrcOrderID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_RootOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_RootOrder]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_Order__Index__1798699D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF__TMS_Order__Index__1798699D]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_Kms]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_Kms]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_CarType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_CarType]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_CarLength]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_CarLength]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_CarVolume]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_CarVolume]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_CarWeight]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_CarWeight]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_DriverID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_DriverID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_CarID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_CarID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_Supplier]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_Supplier]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_SupplierCompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_SupplierCompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_CustomerID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_CustomerID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_CustomerCompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_CustomerCompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_ShipMode]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_ShipMode]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_Pick]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_Pick]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_Delivery]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_Delivery]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_OnLoad]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_OnLoad]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_OffLoad]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_OffLoad]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_CreatorCompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_CreatorCompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_CreateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_CreateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_Confirmer]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_Confirmer]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Order_Singer]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Order_Singer]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_Invalid]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_Order__Index__7A7D0802]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF__TMS_Order__Index__7A7D0802]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_Order__Index__7B712C3B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF__TMS_Order__Index__7B712C3B]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_Order__Index__7C655074]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF__TMS_Order__Index__7C655074]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_Order__Index__72A6DC10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF__TMS_Order__Index__72A6DC10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_Unioned]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_Unioned]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_Order__Index__28EDDE28]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF__TMS_Order__Index__28EDDE28]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_Order__Index__29E20261]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF__TMS_Order__Index__29E20261]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_Order__Index__04115F34]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF__TMS_Order__Index__04115F34]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderIndex_Index_PrevOrderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderIndex] DROP CONSTRAINT [DF_TMS_OrderIndex_Index_PrevOrderID]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_OrderIndex]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_OrderIndex]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_OrderIndex](
	[Index_ID] [bigint] IDENTITY(1026568,1) NOT NULL,
	[opt_status] [int] NOT NULL,
	[Index_Code] [nvarchar](50) NOT NULL,
	[Index_PactCode] [nvarchar](50) NULL,
	[Index_EndUserID] [bigint] NULL,
	[Index_EndUserName] [nvarchar](300) NULL,
	[Index_From] [nvarchar](300) NULL,
	[Index_FromProvince] [bigint] NULL,
	[Index_FromCity] [bigint] NULL,
	[Index_FromDistrict] [bigint] NULL,
	[Index_FromTime] [datetime] NULL,
	[Index_FromContact] [nvarchar](300) NULL,
	[Index_To] [nvarchar](300) NULL,
	[Index_ToProvince] [bigint] NULL,
	[Index_ToCity] [bigint] NULL,
	[Index_ToDistrict] [bigint] NULL,
	[Index_ToTime] [datetime] NULL,
	[Index_ToContact] [nvarchar](300) NULL,
	[Index_TransportMode] [bigint] NULL,
	[Index_GoodsCategory] [bigint] NULL,
	[Index_PackageMode] [bigint] NULL,
	[Index_ChargeMode] [bigint] NULL,
	[Index_PriceUnit] [bigint] NULL,
	[Index_Status] [bigint] NOT NULL,
	[Index_StatusTime] [datetime] NOT NULL,
	[Index_SrcOrderID] [bigint] NULL,
	[Index_RootOrderID] [bigint] NULL,
	[Index_SrcClass] [bigint] NOT NULL,
	[Index_Kms] [bigint] NULL,
	[Index_CarType] [bigint] NULL,
	[Index_CarLength] [decimal](18, 2) NULL,
	[Index_CarVolume] [decimal](18, 6) NULL,
	[Index_CarWeight] [decimal](18, 4) NULL,
	[Index_DriverID] [bigint] NULL,
	[Index_CarID] [bigint] NULL,
	[Index_SupplierID] [bigint] NULL,
	[Index_SupplierCompanyID] [bigint] NULL,
	[Index_CustomerID] [bigint] NULL,
	[Index_CustomerCompanyID] [bigint] NULL,
	[Index_ShipMode] [bigint] NULL,
	[Index_Pick] [bigint] NULL,
	[Index_Delivery] [bigint] NULL,
	[Index_OnLoad] [bigint] NULL,
	[Index_OffLoad] [bigint] NULL,
	[Index_Creator] [bigint] NOT NULL,
	[Index_CreatorCompanyID] [bigint] NOT NULL,
	[Index_CreateTime] [datetime] NOT NULL,
	[Index_Confirmer] [bigint] NULL,
	[Index_ConfirmTime] [datetime] NULL,
	[Index_Singer] [bigint] NULL,
	[Index_SignTime] [datetime] NULL,
	[Index_ReceiptDoc] [nvarchar](512) NULL,
	[Index_Exception] [nvarchar](512) NULL,
	[Index_Invalid] [tinyint] NOT NULL,
	[Index_Comments] [varchar](256) NULL,
	[Index_Insurance] [bigint] NULL,
	[Index_VolumeAddition] [decimal](18, 6) NULL,
	[Index_WeightAddition] [decimal](18, 4) NULL,
	[Index_Description] [nvarchar](max) NULL,
	[Index_Combined] [bigint] NULL,
	[Index_CustomerSymbolID] [bigint] NULL,
	[Index_SupplierSymbolID] [bigint] NULL,
	[Index_ReceiptDoc1] [nvarchar](512) NULL,
	[Index_ReceiptDoc2] [nvarchar](512) NULL,
	[Index_ReceiptDoc3] [nvarchar](512) NULL,
	[Index_GoodsValue] [decimal](18, 2) NULL,
	[Index_PrevOrderID] [bigint] NULL,
 CONSTRAINT [PK__TMS_OrderIndex__3214EC073D5E1FD2] PRIMARY KEY CLUSTERED 
(
	[Index_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'合同编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_PactCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收货人编号(ID)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_EndUserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收货人名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_EndUserName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发货地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_From'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出发省' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_FromProvince'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出发市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_FromCity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出发区' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_FromDistrict'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出发时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_FromTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收货地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_To'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到达省' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_ToProvince'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到达市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_ToCity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到达区' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_ToDistrict'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到达时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_ToTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'运输模式：1 零担 2 整车 3 空运 4 快递 5 铁路 6 海运' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_TransportMode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货物类型：1 普通货物 2 危险品 4 温控获取，允许使用or' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_GoodsCategory'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'包装类型：1 散箱(可堆叠，人工装卸) 2 托盘或木箱(可堆叠，叉车装卸) 3 托盘、木箱或不规则形状，不可堆叠，叉车装卸' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_PackageMode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计价方式：1 体积 2 重量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_ChargeMode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计价单位：1 吨 2 公斤 3 立方 4 其他' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_PriceUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Status'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单状态修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_StatusTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来源订单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_SrcOrderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'起始订单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_RootOrderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单类型，1 客户订单 2 运输订单 3 拼车订单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_SrcClass'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公里数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Kms'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_CarType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车长(米)或规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_CarLength'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车辆容积(方)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_CarVolume'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车辆载重(公斤)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_CarWeight'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'司机编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_DriverID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车辆编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_CarID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_SupplierID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商公司编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_SupplierCompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_CustomerID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户公司编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_CustomerCompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'运输模式, 1 市内 2 长途' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_ShipMode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否提货' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Pick'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否送货' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Delivery'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否装货' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_OnLoad'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否卸货' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_OffLoad'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下单人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Creator'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下单人所属公司' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_CreatorCompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下单时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_CreateTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核(或接受)人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Confirmer'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核(或接收)时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_ConfirmTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签收人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Singer'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签收时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_SignTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'签收单据图片路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_ReceiptDoc'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'异常描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Exception'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否保价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Insurance'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'体积补差' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_VolumeAddition'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'重量补差' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_WeightAddition'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否拼车订单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_Combined'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来源运输订单编号(用于多次拆单)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderIndex', @level2type=N'COLUMN',@level2name=N'Index_PrevOrderID'
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF__TMS_OrderIndex__opt_st__3F466844]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_EndUserID]  DEFAULT ((0)) FOR [Index_EndUserID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_FromProvince]  DEFAULT ((0)) FOR [Index_FromProvince]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_FromCity]  DEFAULT ((0)) FOR [Index_FromCity]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_FromDistrict]  DEFAULT ((0)) FOR [Index_FromDistrict]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_ToProvince]  DEFAULT ((0)) FOR [Index_ToProvince]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_ToCity]  DEFAULT ((0)) FOR [Index_ToCity]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_ToDistrict]  DEFAULT ((0)) FOR [Index_ToDistrict]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_Status]  DEFAULT ((0)) FOR [Index_Status]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_SrcOrderID]  DEFAULT ((0)) FOR [Index_SrcOrderID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_RootOrder]  DEFAULT ((0)) FOR [Index_RootOrderID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF__TMS_Order__Index__1798699D]  DEFAULT ((1)) FOR [Index_SrcClass]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_Kms]  DEFAULT ((0)) FOR [Index_Kms]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_CarType]  DEFAULT ((0)) FOR [Index_CarType]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_CarLength]  DEFAULT ((0)) FOR [Index_CarLength]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_CarVolume]  DEFAULT ((0)) FOR [Index_CarVolume]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_CarWeight]  DEFAULT ((0)) FOR [Index_CarWeight]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_DriverID]  DEFAULT ((0)) FOR [Index_DriverID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_CarID]  DEFAULT ((0)) FOR [Index_CarID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_Supplier]  DEFAULT ((0)) FOR [Index_SupplierID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_SupplierCompanyID]  DEFAULT ((0)) FOR [Index_SupplierCompanyID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_CustomerID]  DEFAULT ((0)) FOR [Index_CustomerID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_CustomerCompanyID]  DEFAULT ((0)) FOR [Index_CustomerCompanyID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_ShipMode]  DEFAULT ((0)) FOR [Index_ShipMode]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_Pick]  DEFAULT ((0)) FOR [Index_Pick]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_Delivery]  DEFAULT ((0)) FOR [Index_Delivery]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_OnLoad]  DEFAULT ((0)) FOR [Index_OnLoad]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_OffLoad]  DEFAULT ((0)) FOR [Index_OffLoad]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_Creator]  DEFAULT ((0)) FOR [Index_Creator]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_CreatorCompanyID]  DEFAULT ((0)) FOR [Index_CreatorCompanyID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_CreateTime]  DEFAULT (getdate()) FOR [Index_CreateTime]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_Confirmer]  DEFAULT ((0)) FOR [Index_Confirmer]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Order_Singer]  DEFAULT ((0)) FOR [Index_Singer]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_Invalid]  DEFAULT ((0)) FOR [Index_Invalid]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF__TMS_Order__Index__7A7D0802]  DEFAULT ((0)) FOR [Index_Insurance]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF__TMS_Order__Index__7B712C3B]  DEFAULT ((0)) FOR [Index_VolumeAddition]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF__TMS_Order__Index__7C655074]  DEFAULT ((0)) FOR [Index_WeightAddition]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF__TMS_Order__Index__72A6DC10]  DEFAULT ('') FOR [Index_Description]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_Unioned]  DEFAULT ((0)) FOR [Index_Combined]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF__TMS_Order__Index__28EDDE28]  DEFAULT ((0)) FOR [Index_CustomerSymbolID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF__TMS_Order__Index__29E20261]  DEFAULT ((0)) FOR [Index_SupplierSymbolID]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  DEFAULT ((0)) FOR [Index_GoodsValue]
GO

ALTER TABLE [dbo].[TMS_OrderIndex] ADD  CONSTRAINT [DF_TMS_OrderIndex_Index_PrevOrderID]  DEFAULT ((0)) FOR [Index_PrevOrderID]
GO


