USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_MCust__opt_s__55BFB948]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCustomer] DROP CONSTRAINT [DF__TMS_MCust__opt_s__55BFB948]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCustomer_Customer_OwnerCompany]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCustomer] DROP CONSTRAINT [DF_TMS_MCustomer_Customer_OwnerCompany]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCustomer_Customer_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCustomer] DROP CONSTRAINT [DF_TMS_MCustomer_Customer_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCustomer_Customer_Industry]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCustomer] DROP CONSTRAINT [DF_TMS_MCustomer_Customer_Industry]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCustomer_Customer_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCustomer] DROP CONSTRAINT [DF_TMS_MCustomer_Customer_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCustomer_Customer_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCustomer] DROP CONSTRAINT [DF_TMS_MCustomer_Customer_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCustomer_Customer_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCustomer] DROP CONSTRAINT [DF_TMS_MCustomer_Customer_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCustomer_Customer_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCustomer] DROP CONSTRAINT [DF_TMS_MCustomer_Customer_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCustomer_Customer_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCustomer] DROP CONSTRAINT [DF_TMS_MCustomer_Customer_Invalid]
END

GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_MCustomer]    Script Date: 08/18/2015 14:31:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_MCustomer]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_MCustomer]
GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_MCustomer]    Script Date: 08/18/2015 14:31:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_MCustomer](
	[Customer_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[opt_status] [int] NULL,
	[Customer_OwnerCompany] [bigint] NOT NULL,
	[Customer_CompanyID] [bigint] NULL,
	[Customer_ClientCode] [nvarchar](100) NULL,
	[Customer_Name] [nvarchar](300) NULL,
	[Customer_Industry] [int] NULL,
	[Customer_Web] [nvarchar](300) NULL,
	[Customer_ShortName] [nvarchar](100) NULL,
	[Customer_EnName] [nvarchar](200) NULL,
	[Customer_ShortEnName] [nvarchar](50) NULL,
	[Customer_Master] [nvarchar](100) NULL,
	[Customer_License] [nvarchar](100) NULL,
	[Customer_Contact] [nvarchar](300) NULL,
	[Customer_Phone] [nvarchar](100) NULL,
	[Customer_Fax] [nvarchar](100) NULL,
	[Customer_Mail] [nvarchar](200) NULL,
	[Customer_Address] [nvarchar](300) NULL,
	[Customer_Zip] [nvarchar](100) NULL,
	[Customer_WeiXin] [nvarchar](100) NULL,
	[Customer_Logo] [nvarchar](300) NULL,
	[Customer_Bank] [nvarchar](100) NULL,
	[Customer_BankAccount] [varchar](100) NULL,
	[Customer_Description] [nvarchar](max) NULL,
	[Customer_Creator] [bigint] NOT NULL,
	[Customer_InsertTime] [datetime] NULL,
	[Customer_Updater] [bigint] NULL,
	[Customer_UpdateTime] [datetime] NULL,
	[Customer_Invalid] [tinyint] NOT NULL,
	[Customer_Comments] [varchar](256) NULL,
 CONSTRAINT [PK__TMS_MCus__3214EC0753D770D6] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户属于哪个公司' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCustomer', @level2type=N'COLUMN',@level2name=N'Customer_OwnerCompany'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户的公司编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCustomer', @level2type=N'COLUMN',@level2name=N'Customer_CompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCustomer', @level2type=N'COLUMN',@level2name=N'Customer_ClientCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司全称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCustomer', @level2type=N'COLUMN',@level2name=N'Customer_Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属行业' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCustomer', @level2type=N'COLUMN',@level2name=N'Customer_Industry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司网站' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCustomer', @level2type=N'COLUMN',@level2name=N'Customer_Web'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司简称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCustomer', @level2type=N'COLUMN',@level2name=N'Customer_ShortName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCustomer', @level2type=N'COLUMN',@level2name=N'Customer_Contact'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCustomer', @level2type=N'COLUMN',@level2name=N'Customer_Phone'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'传真' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCustomer', @level2type=N'COLUMN',@level2name=N'Customer_Fax'
GO

ALTER TABLE [dbo].[TMS_MCustomer] ADD  CONSTRAINT [DF__TMS_MCust__opt_s__55BFB948]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_MCustomer] ADD  CONSTRAINT [DF_TMS_MCustomer_Customer_OwnerCompany]  DEFAULT ((0)) FOR [Customer_OwnerCompany]
GO

ALTER TABLE [dbo].[TMS_MCustomer] ADD  CONSTRAINT [DF_TMS_MCustomer_Customer_CompanyID]  DEFAULT ((0)) FOR [Customer_CompanyID]
GO

ALTER TABLE [dbo].[TMS_MCustomer] ADD  CONSTRAINT [DF_TMS_MCustomer_Customer_Industry]  DEFAULT ((0)) FOR [Customer_Industry]
GO

ALTER TABLE [dbo].[TMS_MCustomer] ADD  CONSTRAINT [DF_TMS_MCustomer_Customer_Creator]  DEFAULT ((0)) FOR [Customer_Creator]
GO

ALTER TABLE [dbo].[TMS_MCustomer] ADD  CONSTRAINT [DF_TMS_MCustomer_Customer_InsertTime]  DEFAULT (getdate()) FOR [Customer_InsertTime]
GO

ALTER TABLE [dbo].[TMS_MCustomer] ADD  CONSTRAINT [DF_TMS_MCustomer_Customer_Updater]  DEFAULT ((0)) FOR [Customer_Updater]
GO

ALTER TABLE [dbo].[TMS_MCustomer] ADD  CONSTRAINT [DF_TMS_MCustomer_Customer_UpdateTime]  DEFAULT (getdate()) FOR [Customer_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_MCustomer] ADD  CONSTRAINT [DF_TMS_MCustomer_Customer_Invalid]  DEFAULT ((0)) FOR [Customer_Invalid]
GO


