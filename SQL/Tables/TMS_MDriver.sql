USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_MDriv__opt_s__13BCEBC1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MDriver] DROP CONSTRAINT [DF__TMS_MDriv__opt_s__13BCEBC1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MDriver_Driver_Gender]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MDriver] DROP CONSTRAINT [DF_TMS_MDriver_Driver_Gender]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MDriver_Driver_LicenseType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MDriver] DROP CONSTRAINT [DF_TMS_MDriver_Driver_LicenseType]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MDriver_Driver_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MDriver] DROP CONSTRAINT [DF_TMS_MDriver_Driver_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MDriver_Driver_CreatorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MDriver] DROP CONSTRAINT [DF_TMS_MDriver_Driver_CreatorID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MDriver_Driver_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MDriver] DROP CONSTRAINT [DF_TMS_MDriver_Driver_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MDriver_Driver_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MDriver] DROP CONSTRAINT [DF_TMS_MDriver_Driver_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MDriver_Driver_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MDriver] DROP CONSTRAINT [DF_TMS_MDriver_Driver_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MDriver_Driver_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MDriver] DROP CONSTRAINT [DF_TMS_MDriver_Driver_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_MDriver]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_MDriver]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_MDriver](
	[Driver_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[opt_status] [int] NULL,
	[Driver_Name] [nvarchar](100) NOT NULL,
	[Driver_Gender] [tinyint] NULL,
	[Driver_Photo] [nvarchar](300) NULL,
	[Driver_Birthday] [datetime] NULL,
	[Driver_Phone] [nvarchar](50) NULL,
	[Driver_LicensedDate] [datetime] NULL,
	[Driver_LicenseType] [bigint] NULL,
	[Driver_SN] [nvarchar](100) NULL,
	[Driver_PersonalSN] [nvarchar](100) NULL,
	[Driver_CompanyID] [bigint] NOT NULL,
	[Driver_Creator] [bigint] NULL,
	[Driver_InsertTime] [datetime] NULL,
	[Driver_Updater] [bigint] NULL,
	[Driver_UpdateTime] [datetime] NULL,
	[Driver_Invalid] [tinyint] NOT NULL,
	[Driver_Comments] [varchar](256) NULL,
 CONSTRAINT [PK__TMS_MDri__3214EC0711D4A34F] PRIMARY KEY CLUSTERED 
(
	[Driver_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TMS_MDriver] ADD  CONSTRAINT [DF__TMS_MDriv__opt_s__13BCEBC1]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_MDriver] ADD  CONSTRAINT [DF_TMS_MDriver_Driver_Gender]  DEFAULT ((0)) FOR [Driver_Gender]
GO

ALTER TABLE [dbo].[TMS_MDriver] ADD  CONSTRAINT [DF_TMS_MDriver_Driver_LicenseType]  DEFAULT ((0)) FOR [Driver_LicenseType]
GO

ALTER TABLE [dbo].[TMS_MDriver] ADD  CONSTRAINT [DF_TMS_MDriver_Driver_CompanyID]  DEFAULT ((0)) FOR [Driver_CompanyID]
GO

ALTER TABLE [dbo].[TMS_MDriver] ADD  CONSTRAINT [DF_TMS_MDriver_Driver_CreatorID]  DEFAULT ((0)) FOR [Driver_Creator]
GO

ALTER TABLE [dbo].[TMS_MDriver] ADD  CONSTRAINT [DF_TMS_MDriver_Driver_InsertTime]  DEFAULT (getdate()) FOR [Driver_InsertTime]
GO

ALTER TABLE [dbo].[TMS_MDriver] ADD  CONSTRAINT [DF_TMS_MDriver_Driver_Updater]  DEFAULT ((0)) FOR [Driver_Updater]
GO

ALTER TABLE [dbo].[TMS_MDriver] ADD  CONSTRAINT [DF_TMS_MDriver_Driver_UpdateTime]  DEFAULT (getdate()) FOR [Driver_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_MDriver] ADD  CONSTRAINT [DF_TMS_MDriver_Driver_Invalid]  DEFAULT ((0)) FOR [Driver_Invalid]
GO


