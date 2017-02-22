USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_Goods__opt_s__7775B2CE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF__TMS_Goods__opt_s__7775B2CE]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Goods_Goods_TypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF_TMS_Goods_Goods_TypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Goods_Goods_CustomerID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF_TMS_Goods_Goods_CustomerID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Goods_Goods_Price]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF_TMS_Goods_Goods_Price]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Goods_Goods_Volume]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF_TMS_Goods_Goods_Volume]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Goods_Goods_Weight]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF_TMS_Goods_Goods_Weight]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Goods_Goods_MWeight]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF_TMS_Goods_Goods_MWeight]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Goods_Goods_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF_TMS_Goods_Goods_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_MGood__Goods__18227982]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF__TMS_MGood__Goods__18227982]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Goods_Goods_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF_TMS_Goods_Goods_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Goods_Goods_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF_TMS_Goods_Goods_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Goods_Goods_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoods] DROP CONSTRAINT [DF_TMS_Goods_Goods_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_MGoods]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_MGoods]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_MGoods](
	[Goods_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[opt_status] [int] NULL,
	[Goods_Code] [nvarchar](50) NOT NULL,
	[Goods_Name] [nvarchar](50) NOT NULL,
	[Goods_TypeID] [bigint] NOT NULL,
	[Goods_CustomerCompanyID] [bigint] NOT NULL,
	[Goods_Price] [decimal](18, 2) NULL,
	[Goods_SPC] [nvarchar](50) NULL,
	[Goods_Volume] [decimal](18, 2) NULL,
	[Goods_Long] [decimal](18, 2) NULL,
	[Goods_Width] [decimal](18, 2) NULL,
	[Goods_Height] [decimal](18, 2) NULL,
	[Goods_Weight] [decimal](18, 2) NULL,
	[Goods_MWeight] [decimal](18, 2) NULL,
	[Goods_Creator] [bigint] NOT NULL,
	[Goods_CreatorCompanyID] [bigint] NOT NULL,
	[Goods_InsertTime] [datetime] NOT NULL,
	[Goods_Updater] [bigint] NULL,
	[Goods_UpdateTime] [datetime] NULL,
	[Goods_Invalid] [tinyint] NOT NULL,
	[Goods_Comments] [varchar](256) NULL,
 CONSTRAINT [PK_TMS_Goods] PRIMARY KEY CLUSTERED 
(
	[Goods_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_TypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属客户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_CustomerCompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品价值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_Price'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_SPC'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'体积' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_Volume'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'长，单位：米' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_Long'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'宽，单位米' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_Width'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'高，单位米' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_Height'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'重量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_Weight'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'毛重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_MWeight'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者公司' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoods', @level2type=N'COLUMN',@level2name=N'Goods_CreatorCompanyID'
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF__TMS_Goods__opt_s__7775B2CE]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF_TMS_Goods_Goods_TypeID]  DEFAULT ((0)) FOR [Goods_TypeID]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF_TMS_Goods_Goods_CustomerID]  DEFAULT ((0)) FOR [Goods_CustomerCompanyID]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF_TMS_Goods_Goods_Price]  DEFAULT ((0)) FOR [Goods_Price]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF_TMS_Goods_Goods_Volume]  DEFAULT ((0)) FOR [Goods_Volume]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF_TMS_Goods_Goods_Weight]  DEFAULT ((0)) FOR [Goods_Weight]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF_TMS_Goods_Goods_MWeight]  DEFAULT ((0)) FOR [Goods_MWeight]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF_TMS_Goods_Goods_Creator]  DEFAULT ((0)) FOR [Goods_Creator]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF__TMS_MGood__Goods__18227982]  DEFAULT ((0)) FOR [Goods_CreatorCompanyID]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF_TMS_Goods_Goods_InsertTime]  DEFAULT (getdate()) FOR [Goods_InsertTime]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF_TMS_Goods_Goods_Updater]  DEFAULT ((0)) FOR [Goods_Updater]
GO

ALTER TABLE [dbo].[TMS_MGoods] ADD  CONSTRAINT [DF_TMS_Goods_Goods_Invalid]  DEFAULT ((0)) FOR [Goods_Invalid]
GO


