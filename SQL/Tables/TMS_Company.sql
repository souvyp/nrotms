USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_Personal]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_Personal]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_Industry]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_Industry]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_Scale]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_Scale]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_ProvinceID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_ProvinceID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_CityID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_CityID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_DistrictID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_DistrictID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_TownID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_TownID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_Gender]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_Gender]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_Status]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_RefereCompany]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_RefereCompany]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_CreatorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_CreatorID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_Company_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_Company_Invalid]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Company_opt_status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF_TMS_Company_opt_status]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_Compa__Compa__411A6D74]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Company] DROP CONSTRAINT [DF__TMS_Compa__Compa__411A6D74]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_Company]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_Company]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_Company](
	[Company_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Company_Name] [nvarchar](300) NOT NULL,
	[Company_Personal] [tinyint] NULL,
	[Company_Industry] [int] NULL,
	[Company_Logo] [nvarchar](300) NULL,
	[Company_Web] [nvarchar](300) NULL,
	[Company_Description] [nvarchar](max) NULL,
	[Company_Scale] [tinyint] NULL,
	[Company_Map] [nvarchar](300) NULL,
	[Company_ProvinceID] [bigint] NULL,
	[Company_CityID] [bigint] NULL,
	[Company_DistrictID] [bigint] NULL,
	[Company_TownID] [bigint] NULL,
	[Company_Keywords] [nvarchar](200) NULL,
	[Company_Contact] [nvarchar](300) NULL,
	[Company_Gender] [tinyint] NULL,
	[Company_Phone] [nvarchar](100) NULL,
	[Company_Status] [bigint] NOT NULL,
	[Company_OfficeNo] [nvarchar](100) NULL,
	[Company_Fax] [nvarchar](100) NULL,
	[Company_Address] [nvarchar](300) NULL,
	[Company_Zip] [nvarchar](100) NULL,
	[Company_Mail] [nvarchar](200) NULL,
	[Company_ClientCode] [nvarchar](100) NULL,
	[Company_ShortName] [nvarchar](100) NULL,
	[Company_EnName] [nvarchar](200) NULL,
	[Company_ShortEnName] [nvarchar](200) NULL,
	[Company_Master] [nvarchar](100) NULL,
	[Company_License] [nvarchar](300) NULL,
	[Company_LicensePic] [nvarchar](300) NULL,
	[Company_Weixin] [nvarchar](100) NULL,
	[Company_Bank] [nvarchar](100) NULL,
	[Company_BankAccount] [nvarchar](100) NULL,
	[Company_RefereCompany] [bigint] NULL,
	[Company_CreatorID] [bigint] NULL,
	[Company_InsertTime] [datetime] NULL,
	[Company_Updater] [bigint] NULL,
	[Company_UpdateTime] [datetime] NULL,
	[Company_Invalid] [tinyint] NOT NULL,
	[Company_Comments] [varchar](256) NULL,
	[opt_status] [int] NULL,
	[Company_IsGroup] [bigint] NULL,
	[Company_IsZones] [bigint] NULL,
 CONSTRAINT [PK_TMS_Company] PRIMARY KEY CLUSTERED 
(
	[Company_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ÓªÒµÖ´ÕÕ±àºÅ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Company', @level2type=N'COLUMN',@level2name=N'Company_License'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ÓªÒµÖ´ÕÕÍ¼Æ¬' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Company', @level2type=N'COLUMN',@level2name=N'Company_LicensePic'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ÍÆ¼ö¹«Ë¾±àºÅ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Company', @level2type=N'COLUMN',@level2name=N'Company_RefereCompany'
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_Personal]  DEFAULT ((0)) FOR [Company_Personal]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_Industry]  DEFAULT ((0)) FOR [Company_Industry]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_Scale]  DEFAULT ((0)) FOR [Company_Scale]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_ProvinceID]  DEFAULT ((0)) FOR [Company_ProvinceID]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_CityID]  DEFAULT ((0)) FOR [Company_CityID]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_DistrictID]  DEFAULT ((0)) FOR [Company_DistrictID]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_TownID]  DEFAULT ((0)) FOR [Company_TownID]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_Gender]  DEFAULT ((0)) FOR [Company_Gender]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_Status]  DEFAULT ((0)) FOR [Company_Status]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_RefereCompany]  DEFAULT ((0)) FOR [Company_RefereCompany]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_CreatorID]  DEFAULT ((0)) FOR [Company_CreatorID]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_InsertTime]  DEFAULT (getdate()) FOR [Company_InsertTime]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_Updater]  DEFAULT ((0)) FOR [Company_Updater]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_UpdateTime]  DEFAULT (getdate()) FOR [Company_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_Company_Invalid]  DEFAULT ((0)) FOR [Company_Invalid]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  CONSTRAINT [DF_TMS_Company_opt_status]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_Company] ADD  DEFAULT ((0)) FOR [Company_IsGroup]
GO


