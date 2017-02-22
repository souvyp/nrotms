USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_User_User_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_User] DROP CONSTRAINT [DF_TMS_User_User_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_User_User_RoleID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_User] DROP CONSTRAINT [DF_TMS_User_User_RoleID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_User_User_Language]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_User] DROP CONSTRAINT [DF_TMS_User_User_Language]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_User_User_Gender]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_User] DROP CONSTRAINT [DF_TMS_User_User_Gender]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_User_User_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_User] DROP CONSTRAINT [DF_TMS_User_User_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_User_User_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_User] DROP CONSTRAINT [DF_TMS_User_User_Invalid]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_User_User_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_User] DROP CONSTRAINT [DF_TMS_User_User_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_User_opt_status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_User] DROP CONSTRAINT [DF_TMS_User_opt_status]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_User]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_User]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_User](
	[User_ID] [bigint] IDENTITY(10000,1) NOT NULL,
	[User_Account] [varchar](100) NOT NULL,
	[User_Password] [varchar](40) NOT NULL,
	[User_CompanyID] [bigint] NOT NULL,
	[User_RoleID] [bigint] NULL,
	[User_Name] [nvarchar](100) NULL,
	[User_Nickname] [nvarchar](100) NULL,
	[User_Portrait] [nvarchar](255) NULL,
	[User_Language] [varchar](10) NULL,
	[User_Gender] [tinyint] NULL,
	[User_Birthday] [nvarchar](50) NULL,
	[User_Phone] [nvarchar](100) NULL,
	[User_Dept] [nvarchar](100) NULL,
	[User_Duty] [nvarchar](100) NULL,
	[User_InsertTime] [datetime] NULL,
	[User_Invalid] [tinyint] NOT NULL,
	[User_UpdateTime] [datetime] NULL,
	[User_SignInTime] [datetime] NULL,
	[User_Comments] [varchar](256) NULL,
	[opt_status] [int] NULL,
 CONSTRAINT [PK_TMS_User] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色编号：1 下单员 2 收单员 4 司机 8 财务 16 调度 32 采购 64 管理人员 128 老板 256 管理员 512 业务员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_User', @level2type=N'COLUMN',@level2name=N'User_RoleID'
GO

ALTER TABLE [dbo].[TMS_User] ADD  CONSTRAINT [DF_TMS_User_User_CompanyID]  DEFAULT ((0)) FOR [User_CompanyID]
GO

ALTER TABLE [dbo].[TMS_User] ADD  CONSTRAINT [DF_TMS_User_User_RoleID]  DEFAULT ((0)) FOR [User_RoleID]
GO

ALTER TABLE [dbo].[TMS_User] ADD  CONSTRAINT [DF_TMS_User_User_Language]  DEFAULT (' ') FOR [User_Language]
GO

ALTER TABLE [dbo].[TMS_User] ADD  CONSTRAINT [DF_TMS_User_User_Gender]  DEFAULT ((0)) FOR [User_Gender]
GO

ALTER TABLE [dbo].[TMS_User] ADD  CONSTRAINT [DF_TMS_User_User_InsertTime]  DEFAULT (getdate()) FOR [User_InsertTime]
GO

ALTER TABLE [dbo].[TMS_User] ADD  CONSTRAINT [DF_TMS_User_User_Invalid]  DEFAULT ((0)) FOR [User_Invalid]
GO

ALTER TABLE [dbo].[TMS_User] ADD  CONSTRAINT [DF_TMS_User_User_UpdateTime]  DEFAULT (getdate()) FOR [User_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_User] ADD  CONSTRAINT [DF_TMS_User_opt_status]  DEFAULT ((0)) FOR [opt_status]
GO


