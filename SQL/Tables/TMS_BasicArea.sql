USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OTMS_BasicArea_Area_ParentID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_BasicArea] DROP CONSTRAINT [DF_OTMS_BasicArea_Area_ParentID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OTMS_BasicArea_Area_NodeType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_BasicArea] DROP CONSTRAINT [DF_OTMS_BasicArea_Area_NodeType]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OTMS_BasicArea_Area_CreatorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_BasicArea] DROP CONSTRAINT [DF_OTMS_BasicArea_Area_CreatorID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OTMS_BasicArea_Area_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_BasicArea] DROP CONSTRAINT [DF_OTMS_BasicArea_Area_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OTMS_BasicArea_Area_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_BasicArea] DROP CONSTRAINT [DF_OTMS_BasicArea_Area_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OTMS_BasicArea_Area_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_BasicArea] DROP CONSTRAINT [DF_OTMS_BasicArea_Area_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OTMS_BasicArea_Area_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_BasicArea] DROP CONSTRAINT [DF_OTMS_BasicArea_Area_Invalid]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_BasicArea_opt_status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_BasicArea] DROP CONSTRAINT [DF_TMS_BasicArea_opt_status]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_BasicArea]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_BasicArea]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_BasicArea](
	[Area_ID] [bigint] NOT NULL,
	[Area_Code] [nvarchar](10) NULL,
	[Area_Name] [nvarchar](100) NOT NULL,
	[Area_ParentID] [bigint] NOT NULL,
	[Area_NodeType] [int] NULL,
	[Area_CreatorID] [bigint] NOT NULL,
	[Area_InsertTime] [datetime] NULL,
	[Area_Updater] [bigint] NULL,
	[Area_UpdateTime] [datetime] NULL,
	[Area_Invalid] [tinyint] NOT NULL,
	[Area_Comments] [varchar](256) NULL,
	[opt_status] [int] NULL,
 CONSTRAINT [PK_TMS_BasicArea] PRIMARY KEY CLUSTERED 
(
	[Area_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TMS_BasicArea] ADD  CONSTRAINT [DF_OTMS_BasicArea_Area_ParentID]  DEFAULT ((0)) FOR [Area_ParentID]
GO

ALTER TABLE [dbo].[TMS_BasicArea] ADD  CONSTRAINT [DF_OTMS_BasicArea_Area_NodeType]  DEFAULT ((0)) FOR [Area_NodeType]
GO

ALTER TABLE [dbo].[TMS_BasicArea] ADD  CONSTRAINT [DF_OTMS_BasicArea_Area_CreatorID]  DEFAULT ((0)) FOR [Area_CreatorID]
GO

ALTER TABLE [dbo].[TMS_BasicArea] ADD  CONSTRAINT [DF_OTMS_BasicArea_Area_InsertTime]  DEFAULT (getdate()) FOR [Area_InsertTime]
GO

ALTER TABLE [dbo].[TMS_BasicArea] ADD  CONSTRAINT [DF_OTMS_BasicArea_Area_Updater]  DEFAULT ((0)) FOR [Area_Updater]
GO

ALTER TABLE [dbo].[TMS_BasicArea] ADD  CONSTRAINT [DF_OTMS_BasicArea_Area_UpdateTime]  DEFAULT (getdate()) FOR [Area_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_BasicArea] ADD  CONSTRAINT [DF_OTMS_BasicArea_Area_Invalid]  DEFAULT ((0)) FOR [Area_Invalid]
GO

ALTER TABLE [dbo].[TMS_BasicArea] ADD  CONSTRAINT [DF_TMS_BasicArea_opt_status]  DEFAULT ((0)) FOR [opt_status]
GO


