USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MEndUser_opt_status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MEndUser] DROP CONSTRAINT [DF_TMS_MEndUser_opt_status]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MEndUser_EndUser_OwnerCompany]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MEndUser] DROP CONSTRAINT [DF_TMS_MEndUser_EndUser_OwnerCompany]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MEndUser_EndUser_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MEndUser] DROP CONSTRAINT [DF_TMS_MEndUser_EndUser_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MEndUser_EndUser_Industry]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MEndUser] DROP CONSTRAINT [DF_TMS_MEndUser_EndUser_Industry]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MEndUser_EndUser_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MEndUser] DROP CONSTRAINT [DF_TMS_MEndUser_EndUser_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MEndUser_EndUser_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MEndUser] DROP CONSTRAINT [DF_TMS_MEndUser_EndUser_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MEndUser_EndUser_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MEndUser] DROP CONSTRAINT [DF_TMS_MEndUser_EndUser_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MEndUser_EndUser_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MEndUser] DROP CONSTRAINT [DF_TMS_MEndUser_EndUser_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MEndUser_EndUser_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MEndUser] DROP CONSTRAINT [DF_TMS_MEndUser_EndUser_Invalid]
END

GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_MEndUser]    Script Date: 08/18/2015 14:31:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_MEndUser]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_MEndUser]
GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_MEndUser]    Script Date: 08/18/2015 14:31:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_MEndUser](
	[EndUser_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[opt_status] [int] NULL,
	[EndUser_OwnerCompany] [bigint] NOT NULL,
	[EndUser_CompanyID] [bigint] NULL,
	[EndUser_ClientCode] [nvarchar](100) NULL,
	[EndUser_Name] [nvarchar](300) NULL,
	[EndUser_Industry] [bigint] NULL,
	[EndUser_Web] [nvarchar](300) NULL,
	[EndUser_ShortName] [nvarchar](100) NULL,
	[EndUser_EnName] [nvarchar](200) NULL,
	[EndUser_ShortEnName] [nvarchar](50) NULL,
	[EndUser_Master] [nvarchar](100) NULL,
	[EndUser_License] [nvarchar](100) NULL,
	[EndUser_Contact] [nvarchar](300) NULL,
	[EndUser_Phone] [nvarchar](100) NULL,
	[EndUser_Fax] [nvarchar](100) NULL,
	[EndUser_Mail] [nvarchar](200) NULL,
	[EndUser_Address] [nvarchar](300) NULL,
	[EndUser_Zip] [nvarchar](100) NULL,
	[EndUser_WeiXin] [nvarchar](100) NULL,
	[EndUser_Logo] [nvarchar](300) NULL,
	[EndUser_Bank] [nvarchar](100) NULL,
	[EndUser_BankAccount] [varchar](100) NULL,
	[EndUser_Description] [nvarchar](max) NULL,
	[EndUser_Creator] [bigint] NOT NULL,
	[EndUser_InsertTime] [datetime] NULL,
	[EndUser_Updater] [bigint] NULL,
	[EndUser_UpdateTime] [datetime] NULL,
	[EndUser_Invalid] [tinyint] NOT NULL,
	[EndUser_Comments] [varchar](256) NULL,
 CONSTRAINT [PK_TMS_MEndUser] PRIMARY KEY CLUSTERED 
(
	[EndUser_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户属于哪个公司' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MEndUser', @level2type=N'COLUMN',@level2name=N'EndUser_OwnerCompany'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户的公司编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MEndUser', @level2type=N'COLUMN',@level2name=N'EndUser_CompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MEndUser', @level2type=N'COLUMN',@level2name=N'EndUser_ClientCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司全称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MEndUser', @level2type=N'COLUMN',@level2name=N'EndUser_Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属行业' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MEndUser', @level2type=N'COLUMN',@level2name=N'EndUser_Industry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司网站' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MEndUser', @level2type=N'COLUMN',@level2name=N'EndUser_Web'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司简称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MEndUser', @level2type=N'COLUMN',@level2name=N'EndUser_ShortName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MEndUser', @level2type=N'COLUMN',@level2name=N'EndUser_Contact'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MEndUser', @level2type=N'COLUMN',@level2name=N'EndUser_Phone'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'传真' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MEndUser', @level2type=N'COLUMN',@level2name=N'EndUser_Fax'
GO

ALTER TABLE [dbo].[TMS_MEndUser] ADD  CONSTRAINT [DF_TMS_MEndUser_opt_status]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_MEndUser] ADD  CONSTRAINT [DF_TMS_MEndUser_EndUser_OwnerCompany]  DEFAULT ((0)) FOR [EndUser_OwnerCompany]
GO

ALTER TABLE [dbo].[TMS_MEndUser] ADD  CONSTRAINT [DF_TMS_MEndUser_EndUser_CompanyID]  DEFAULT ((0)) FOR [EndUser_CompanyID]
GO

ALTER TABLE [dbo].[TMS_MEndUser] ADD  CONSTRAINT [DF_TMS_MEndUser_EndUser_Industry]  DEFAULT ((0)) FOR [EndUser_Industry]
GO

ALTER TABLE [dbo].[TMS_MEndUser] ADD  CONSTRAINT [DF_TMS_MEndUser_EndUser_Creator]  DEFAULT ((0)) FOR [EndUser_Creator]
GO

ALTER TABLE [dbo].[TMS_MEndUser] ADD  CONSTRAINT [DF_TMS_MEndUser_EndUser_InsertTime]  DEFAULT (getdate()) FOR [EndUser_InsertTime]
GO

ALTER TABLE [dbo].[TMS_MEndUser] ADD  CONSTRAINT [DF_TMS_MEndUser_EndUser_Updater]  DEFAULT ((0)) FOR [EndUser_Updater]
GO

ALTER TABLE [dbo].[TMS_MEndUser] ADD  CONSTRAINT [DF_TMS_MEndUser_EndUser_UpdateTime]  DEFAULT (getdate()) FOR [EndUser_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_MEndUser] ADD  CONSTRAINT [DF_TMS_MEndUser_EndUser_Invalid]  DEFAULT ((0)) FOR [EndUser_Invalid]
GO


