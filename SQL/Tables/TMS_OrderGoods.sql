USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TMS_OrderGoods_TMS_OrderIndex]') AND parent_object_id = OBJECT_ID(N'[dbo].[TMS_OrderGoods]'))
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [FK_TMS_OrderGoods_TMS_OrderIndex]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_opt_status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_opt_status]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_Goods_OrderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_Goods_OrderID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_Goods_GoodsID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_Goods_GoodsID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_Goods_Qty]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_Goods_Qty]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_Goods_Weight]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_Goods_Weight]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_Goods_Volume]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_Goods_Volume]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_RealQty]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_RealQty]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_Goods_ExceptionQty]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_Goods_ExceptionQty]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_Goods_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_Goods_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_Goods_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_Goods_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_Goods_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_Goods_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderGoods_Goods_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderGoods] DROP CONSTRAINT [DF_TMS_OrderGoods_Goods_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_OrderGoods]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_OrderGoods]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_OrderGoods](
	[GoodsLst_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[opt_status] [int] NOT NULL,
	[GoodsLst_OrderID] [bigint] NOT NULL,
	[GoodsLst_GoodsID] [bigint] NOT NULL,
	[GoodsLst_Code] [nvarchar](50) NULL,
	[GoodsLst_Name] [nvarchar](50) NOT NULL,
	[GoodsLst_Qty] [float] NOT NULL,
	[GoodsLst_Weight] [float] NULL,
	[GoodsLst_Volume] [float] NULL,
	[GoodsLst_ReceiptQty] [float] NULL,
	[GoodsLst_ExceptionQty] [float] NULL,
	[GoodsLst_Creator] [bigint] NOT NULL,
	[GoodsLst_InsertTime] [datetime] NOT NULL,
	[GoodsLst_Updater] [bigint] NULL,
	[GoodsLst_UpdateTime] [datetime] NULL,
	[GoodsLst_Invalid] [tinyint] NOT NULL,
	[GoodsLst_Comments] [varchar](256) NULL,
 CONSTRAINT [PK__TMS_Orde__3214EC07451F3D2B] PRIMARY KEY CLUSTERED 
(
	[GoodsLst_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单物品编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderGoods', @level2type=N'COLUMN',@level2name=N'GoodsLst_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属订单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderGoods', @level2type=N'COLUMN',@level2name=N'GoodsLst_OrderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderGoods', @level2type=N'COLUMN',@level2name=N'GoodsLst_GoodsID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品编码(冗余)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderGoods', @level2type=N'COLUMN',@level2name=N'GoodsLst_Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderGoods', @level2type=N'COLUMN',@level2name=N'GoodsLst_Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderGoods', @level2type=N'COLUMN',@level2name=N'GoodsLst_Qty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'重量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderGoods', @level2type=N'COLUMN',@level2name=N'GoodsLst_Weight'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'体积' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderGoods', @level2type=N'COLUMN',@level2name=N'GoodsLst_Volume'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实际签收数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderGoods', @level2type=N'COLUMN',@level2name=N'GoodsLst_ReceiptQty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'异常数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderGoods', @level2type=N'COLUMN',@level2name=N'GoodsLst_ExceptionQty'
GO

ALTER TABLE [dbo].[TMS_OrderGoods]  WITH CHECK ADD  CONSTRAINT [FK_TMS_OrderGoods_TMS_OrderIndex] FOREIGN KEY([GoodsLst_OrderID])
REFERENCES [dbo].[TMS_OrderIndex] ([Index_ID])
GO

ALTER TABLE [dbo].[TMS_OrderGoods] CHECK CONSTRAINT [FK_TMS_OrderGoods_TMS_OrderIndex]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_opt_status]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_Goods_OrderID]  DEFAULT ((0)) FOR [GoodsLst_OrderID]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_Goods_GoodsID]  DEFAULT ((0)) FOR [GoodsLst_GoodsID]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_Goods_Qty]  DEFAULT ((0)) FOR [GoodsLst_Qty]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_Goods_Weight]  DEFAULT ((0)) FOR [GoodsLst_Weight]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_Goods_Volume]  DEFAULT ((0)) FOR [GoodsLst_Volume]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_RealQty]  DEFAULT ((0)) FOR [GoodsLst_ReceiptQty]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_Goods_ExceptionQty]  DEFAULT ((0)) FOR [GoodsLst_ExceptionQty]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_Goods_Creator]  DEFAULT ((0)) FOR [GoodsLst_Creator]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_Goods_InsertTime]  DEFAULT (getdate()) FOR [GoodsLst_InsertTime]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_Goods_Updater]  DEFAULT ((0)) FOR [GoodsLst_Updater]
GO

ALTER TABLE [dbo].[TMS_OrderGoods] ADD  CONSTRAINT [DF_TMS_OrderGoods_Goods_Invalid]  DEFAULT ((0)) FOR [GoodsLst_Invalid]
GO


