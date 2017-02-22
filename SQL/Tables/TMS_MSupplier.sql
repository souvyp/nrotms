USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSupplier_Supplier_OwnerCompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSupplier] DROP CONSTRAINT [DF_TMS_MSupplier_Supplier_OwnerCompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSupplier_Supplier_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSupplier] DROP CONSTRAINT [DF_TMS_MSupplier_Supplier_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSupplier_Supplier_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSupplier] DROP CONSTRAINT [DF_TMS_MSupplier_Supplier_Status]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSupplier_Supplier_Processor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSupplier] DROP CONSTRAINT [DF_TMS_MSupplier_Supplier_Processor]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSupplier_Supplier_CreatorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSupplier] DROP CONSTRAINT [DF_TMS_MSupplier_Supplier_CreatorID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSupplier_Supplier_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSupplier] DROP CONSTRAINT [DF_TMS_MSupplier_Supplier_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSupplier_Supplier_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSupplier] DROP CONSTRAINT [DF_TMS_MSupplier_Supplier_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSupplier_Supplier_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSupplier] DROP CONSTRAINT [DF_TMS_MSupplier_Supplier_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSupplier_Supplier_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSupplier] DROP CONSTRAINT [DF_TMS_MSupplier_Supplier_Invalid]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSupplier_opt_status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSupplier] DROP CONSTRAINT [DF_TMS_MSupplier_opt_status]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_MSupplier]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_MSupplier]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_MSupplier](
	[Supplier_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Supplier_OwnerCompanyID] [bigint] NOT NULL,
	[Supplier_CompanyID] [bigint] NULL,
	[Supplier_Status] [bigint] NOT NULL,
	[Supplier_StatusTime] [datetime] NULL,
	[Supplier_Processor] [bigint] NULL,
	[Supplier_Welcome] [nvarchar](600) NULL,
	[Supplier_Creator] [bigint] NOT NULL,
	[Supplier_InsertTime] [datetime] NULL,
	[Supplier_Updater] [bigint] NULL,
	[Supplier_UpdateTime] [datetime] NULL,
	[Supplier_Invalid] [tinyint] NOT NULL,
	[Supplier_Comments] [varchar](256) NULL,
	[opt_status] [bigint] NOT NULL,
 CONSTRAINT [PK_TMS_MSupplier] PRIMARY KEY CLUSTERED 
(
	[Supplier_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理状态：0 待处理申请 1 接受申请 2 拒绝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSupplier', @level2type=N'COLUMN',@level2name=N'Supplier_Status'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商申请处理者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSupplier', @level2type=N'COLUMN',@level2name=N'Supplier_Processor'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邀请词' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSupplier', @level2type=N'COLUMN',@level2name=N'Supplier_Welcome'
GO

ALTER TABLE [dbo].[TMS_MSupplier] ADD  CONSTRAINT [DF_TMS_MSupplier_Supplier_OwnerCompanyID]  DEFAULT ((0)) FOR [Supplier_OwnerCompanyID]
GO

ALTER TABLE [dbo].[TMS_MSupplier] ADD  CONSTRAINT [DF_TMS_MSupplier_Supplier_CompanyID]  DEFAULT ((0)) FOR [Supplier_CompanyID]
GO

ALTER TABLE [dbo].[TMS_MSupplier] ADD  CONSTRAINT [DF_TMS_MSupplier_Supplier_Status]  DEFAULT ((0)) FOR [Supplier_Status]
GO

ALTER TABLE [dbo].[TMS_MSupplier] ADD  CONSTRAINT [DF_TMS_MSupplier_Supplier_Processor]  DEFAULT ((0)) FOR [Supplier_Processor]
GO

ALTER TABLE [dbo].[TMS_MSupplier] ADD  CONSTRAINT [DF_TMS_MSupplier_Supplier_CreatorID]  DEFAULT ((0)) FOR [Supplier_Creator]
GO

ALTER TABLE [dbo].[TMS_MSupplier] ADD  CONSTRAINT [DF_TMS_MSupplier_Supplier_InsertTime]  DEFAULT (getdate()) FOR [Supplier_InsertTime]
GO

ALTER TABLE [dbo].[TMS_MSupplier] ADD  CONSTRAINT [DF_TMS_MSupplier_Supplier_Updater]  DEFAULT ((0)) FOR [Supplier_Updater]
GO

ALTER TABLE [dbo].[TMS_MSupplier] ADD  CONSTRAINT [DF_TMS_MSupplier_Supplier_UpdateTime]  DEFAULT (getdate()) FOR [Supplier_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_MSupplier] ADD  CONSTRAINT [DF_TMS_MSupplier_Supplier_Invalid]  DEFAULT ((0)) FOR [Supplier_Invalid]
GO

ALTER TABLE [dbo].[TMS_MSupplier] ADD  CONSTRAINT [DF_TMS_MSupplier_opt_status]  DEFAULT ((0)) FOR [opt_status]
GO


