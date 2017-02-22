USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderContains_Contains_OwnerOrderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderContains] DROP CONSTRAINT [DF_TMS_OrderContains_Contains_OwnerOrderID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderContains_Contains_OrderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderContains] DROP CONSTRAINT [DF_TMS_OrderContains_Contains_OrderID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderContains_Contains_Volume]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderContains] DROP CONSTRAINT [DF_TMS_OrderContains_Contains_Volume]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderContains_Contains_Weight]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderContains] DROP CONSTRAINT [DF_TMS_OrderContains_Contains_Weight]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderContains_Contains_Amount]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderContains] DROP CONSTRAINT [DF_TMS_OrderContains_Contains_Amount]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderContains_Contains_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderContains] DROP CONSTRAINT [DF_TMS_OrderContains_Contains_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderContains_Contains_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderContains] DROP CONSTRAINT [DF_TMS_OrderContains_Contains_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderContains_Contains_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderContains] DROP CONSTRAINT [DF_TMS_OrderContains_Contains_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderContains_Contains_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderContains] DROP CONSTRAINT [DF_TMS_OrderContains_Contains_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_OrderContains]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_OrderContains]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_OrderContains](
	[Contains_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Contains_OwnerOrderID] [bigint] NOT NULL,
	[Contains_OrderID] [bigint] NOT NULL,
	[Contains_Volume] [decimal](18, 6) NULL,
	[Contains_Weight] [decimal](18, 4) NULL,
	[Contains_Amount] [decimal](18, 2) NULL,
	[Contains_Creator] [bigint] NOT NULL,
	[Contains_InsertTime] [datetime] NOT NULL,
	[Contains_Updater] [bigint] NULL,
	[Contains_UpdateTime] [datetime] NULL,
	[Contains_Invalid] [tinyint] NOT NULL,
	[Contains_Comments] [nvarchar](256) NULL,
 CONSTRAINT [PK_TMS_OrderContains] PRIMARY KEY CLUSTERED 
(
	[Contains_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所有者订单编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_OwnerOrderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_OrderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总体积' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_Volume'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总重量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_Weight'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_Amount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_Creator'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_InsertTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_Updater'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_UpdateTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否失效' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_Invalid'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderContains', @level2type=N'COLUMN',@level2name=N'Contains_Comments'
GO

ALTER TABLE [dbo].[TMS_OrderContains] ADD  CONSTRAINT [DF_TMS_OrderContains_Contains_OwnerOrderID]  DEFAULT ((0)) FOR [Contains_OwnerOrderID]
GO

ALTER TABLE [dbo].[TMS_OrderContains] ADD  CONSTRAINT [DF_TMS_OrderContains_Contains_OrderID]  DEFAULT ((0)) FOR [Contains_OrderID]
GO

ALTER TABLE [dbo].[TMS_OrderContains] ADD  CONSTRAINT [DF_TMS_OrderContains_Contains_Volume]  DEFAULT ((0)) FOR [Contains_Volume]
GO

ALTER TABLE [dbo].[TMS_OrderContains] ADD  CONSTRAINT [DF_TMS_OrderContains_Contains_Weight]  DEFAULT ((0)) FOR [Contains_Weight]
GO

ALTER TABLE [dbo].[TMS_OrderContains] ADD  CONSTRAINT [DF_TMS_OrderContains_Contains_Amount]  DEFAULT ((0)) FOR [Contains_Amount]
GO

ALTER TABLE [dbo].[TMS_OrderContains] ADD  CONSTRAINT [DF_TMS_OrderContains_Contains_Creator]  DEFAULT ((0)) FOR [Contains_Creator]
GO

ALTER TABLE [dbo].[TMS_OrderContains] ADD  CONSTRAINT [DF_TMS_OrderContains_Contains_InsertTime]  DEFAULT (getdate()) FOR [Contains_InsertTime]
GO

ALTER TABLE [dbo].[TMS_OrderContains] ADD  CONSTRAINT [DF_TMS_OrderContains_Contains_Updater]  DEFAULT ((0)) FOR [Contains_Updater]
GO

ALTER TABLE [dbo].[TMS_OrderContains] ADD  CONSTRAINT [DF_TMS_OrderContains_Contains_Invalid]  DEFAULT ((0)) FOR [Contains_Invalid]
GO


