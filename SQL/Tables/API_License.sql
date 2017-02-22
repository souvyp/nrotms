USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_API_License_License_OwnerCompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[API_License] DROP CONSTRAINT [DF_API_License_License_OwnerCompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_API_License_License_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[API_License] DROP CONSTRAINT [DF_API_License_License_Invalid]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_API_License_License_Confirmed]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[API_License] DROP CONSTRAINT [DF_API_License_License_Confirmed]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_API_License_License_Confirmer]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[API_License] DROP CONSTRAINT [DF_API_License_License_Confirmer]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_API_License_License_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[API_License] DROP CONSTRAINT [DF_API_License_License_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_API_License_License_CreateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[API_License] DROP CONSTRAINT [DF_API_License_License_CreateTime]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[API_License]') AND type in (N'U'))
DROP TABLE [dbo].[API_License]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[API_License](
	[License_ID] [bigint] IDENTITY(1065231,1) NOT NULL,
	[License_AppID] [nvarchar](20) NULL,
	[License_OwnerCompanyID] [bigint] NOT NULL,
	[License_HelloToken] [nvarchar](40) NULL,
	[License_AesKey] [nvarchar](40) NULL,
	[License_ClientUrl] [nvarchar](500) NULL,
	[License_StartTime] [datetime] NULL,
	[License_EndTime] [datetime] NULL,
	[License_Invalid] [bigint] NOT NULL,
	[License_Confirmed] [bigint] NULL,
	[License_Confirmer] [bigint] NULL,
	[License_ConfirmTime] [datetime] NULL,
	[License_ConfirmDesc] [nvarchar](500) NULL,
	[License_Creator] [bigint] NOT NULL,
	[License_CreateTime] [datetime] NOT NULL,
	[License_Updater] [bigint] NULL,
	[License_UpdateTime] [datetime] NULL,
	[License_Comments] [nvarchar](50) NULL,
 CONSTRAINT [PK_API_License] PRIMARY KEY CLUSTERED 
(
	[License_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[API_License] ADD  CONSTRAINT [DF_API_License_License_OwnerCompanyID]  DEFAULT ((0)) FOR [License_OwnerCompanyID]
GO

ALTER TABLE [dbo].[API_License] ADD  CONSTRAINT [DF_API_License_License_Invalid]  DEFAULT ((0)) FOR [License_Invalid]
GO

ALTER TABLE [dbo].[API_License] ADD  CONSTRAINT [DF_API_License_License_Confirmed]  DEFAULT ((0)) FOR [License_Confirmed]
GO

ALTER TABLE [dbo].[API_License] ADD  CONSTRAINT [DF_API_License_License_Confirmer]  DEFAULT ((0)) FOR [License_Confirmer]
GO

ALTER TABLE [dbo].[API_License] ADD  CONSTRAINT [DF_API_License_License_Creator]  DEFAULT ((0)) FOR [License_Creator]
GO

ALTER TABLE [dbo].[API_License] ADD  CONSTRAINT [DF_API_License_License_CreateTime]  DEFAULT (getdate()) FOR [License_CreateTime]
GO


