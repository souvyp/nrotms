USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_License_License_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_License] DROP CONSTRAINT [DF_TMS_License_License_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_License_License_MaxUser]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_License] DROP CONSTRAINT [DF_TMS_License_License_MaxUser]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_License_License_CreatorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_License] DROP CONSTRAINT [DF_TMS_License_License_CreatorID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_License_License_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_License] DROP CONSTRAINT [DF_TMS_License_License_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_License_License_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_License] DROP CONSTRAINT [DF_TMS_License_License_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_License_License_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_License] DROP CONSTRAINT [DF_TMS_License_License_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_License_License_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_License] DROP CONSTRAINT [DF_TMS_License_License_Invalid]
END

GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_License]    Script Date: 08/18/2015 14:31:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_License]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_License]
GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_License]    Script Date: 08/18/2015 14:31:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_License](
	[License_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[License_CompanyID] [bigint] NULL,
	[License_MaxUser] [bigint] NULL,
	[License_CreatorID] [bigint] NULL,
	[License_InsertTime] [datetime] NULL,
	[License_Updater] [bigint] NULL,
	[License_UpdateTime] [datetime] NULL,
	[License_Invalid] [tinyint] NULL,
	[License_Comments] [varchar](256) NULL,
 CONSTRAINT [PK_TMS_License] PRIMARY KEY CLUSTERED 
(
	[License_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TMS_License] ADD  CONSTRAINT [DF_TMS_License_License_CompanyID]  DEFAULT ((0)) FOR [License_CompanyID]
GO

ALTER TABLE [dbo].[TMS_License] ADD  CONSTRAINT [DF_TMS_License_License_MaxUser]  DEFAULT ((0)) FOR [License_MaxUser]
GO

ALTER TABLE [dbo].[TMS_License] ADD  CONSTRAINT [DF_TMS_License_License_CreatorID]  DEFAULT ((0)) FOR [License_CreatorID]
GO

ALTER TABLE [dbo].[TMS_License] ADD  CONSTRAINT [DF_TMS_License_License_InsertTime]  DEFAULT (getdate()) FOR [License_InsertTime]
GO

ALTER TABLE [dbo].[TMS_License] ADD  CONSTRAINT [DF_TMS_License_License_Updater]  DEFAULT ((0)) FOR [License_Updater]
GO

ALTER TABLE [dbo].[TMS_License] ADD  CONSTRAINT [DF_TMS_License_License_UpdateTime]  DEFAULT (getdate()) FOR [License_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_License] ADD  CONSTRAINT [DF_TMS_License_License_Invalid]  DEFAULT ((0)) FOR [License_Invalid]
GO


