USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_MGood__opt_s__220B0B18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoodsType] DROP CONSTRAINT [DF__TMS_MGood__opt_s__220B0B18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MGoodsType_GoodsType_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoodsType] DROP CONSTRAINT [DF_TMS_MGoodsType_GoodsType_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MGoodsType_GoodsType_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoodsType] DROP CONSTRAINT [DF_TMS_MGoodsType_GoodsType_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MGoodsType_GoodsType_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoodsType] DROP CONSTRAINT [DF_TMS_MGoodsType_GoodsType_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MGoodsType_GoodsType_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoodsType] DROP CONSTRAINT [DF_TMS_MGoodsType_GoodsType_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MGoodsType_GoodsType_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoodsType] DROP CONSTRAINT [DF_TMS_MGoodsType_GoodsType_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MGoodsType_GoodsType_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MGoodsType] DROP CONSTRAINT [DF_TMS_MGoodsType_GoodsType_Invalid]
END

GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_MGoodsType]    Script Date: 08/18/2015 14:31:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_MGoodsType]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_MGoodsType]
GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_MGoodsType]    Script Date: 08/18/2015 14:31:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_MGoodsType](
	[GoodsType_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[opt_status] [int] NULL,
	[GoodsType_CompanyID] [bigint] NOT NULL,
	[GoodsType_Code] [nvarchar](50) NULL,
	[GoodsType_Unit] [nvarchar](50) NULL,
	[GoodsType_Name] [nvarchar](100) NOT NULL,
	[GoodsType_Description] [nvarchar](500) NULL,
	[GoodsType_Creator] [bigint] NULL,
	[GoodsType_InsertTime] [datetime] NULL,
	[GoodsType_Updater] [bigint] NULL,
	[GoodsType_UpdateTime] [datetime] NULL,
	[GoodsType_Invalid] [tinyint] NOT NULL,
	[GoodsType_Comments] [nvarchar](200) NULL,
 CONSTRAINT [PK__TMS_MGoo__3214EC072022C2A6] PRIMARY KEY CLUSTERED 
(
	[GoodsType_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoodsType', @level2type=N'COLUMN',@level2name=N'GoodsType_Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoodsType', @level2type=N'COLUMN',@level2name=N'GoodsType_Unit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoodsType', @level2type=N'COLUMN',@level2name=N'GoodsType_Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoodsType', @level2type=N'COLUMN',@level2name=N'GoodsType_Creator'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoodsType', @level2type=N'COLUMN',@level2name=N'GoodsType_InsertTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MGoodsType', @level2type=N'COLUMN',@level2name=N'GoodsType_Comments'
GO

ALTER TABLE [dbo].[TMS_MGoodsType] ADD  CONSTRAINT [DF__TMS_MGood__opt_s__220B0B18]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_MGoodsType] ADD  CONSTRAINT [DF_TMS_MGoodsType_GoodsType_CompanyID]  DEFAULT ((0)) FOR [GoodsType_CompanyID]
GO

ALTER TABLE [dbo].[TMS_MGoodsType] ADD  CONSTRAINT [DF_TMS_MGoodsType_GoodsType_Creator]  DEFAULT ((0)) FOR [GoodsType_Creator]
GO

ALTER TABLE [dbo].[TMS_MGoodsType] ADD  CONSTRAINT [DF_TMS_MGoodsType_GoodsType_InsertTime]  DEFAULT (getdate()) FOR [GoodsType_InsertTime]
GO

ALTER TABLE [dbo].[TMS_MGoodsType] ADD  CONSTRAINT [DF_TMS_MGoodsType_GoodsType_Updater]  DEFAULT ((0)) FOR [GoodsType_Updater]
GO

ALTER TABLE [dbo].[TMS_MGoodsType] ADD  CONSTRAINT [DF_TMS_MGoodsType_GoodsType_UpdateTime]  DEFAULT (getdate()) FOR [GoodsType_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_MGoodsType] ADD  CONSTRAINT [DF_TMS_MGoodsType_GoodsType_Invalid]  DEFAULT ((0)) FOR [GoodsType_Invalid]
GO


