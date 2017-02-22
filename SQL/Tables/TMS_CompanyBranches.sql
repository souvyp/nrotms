USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_CompanyBranches_Branch_OwnerCompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_CompanyBranches] DROP CONSTRAINT [DF_TMS_CompanyBranches_Branch_OwnerCompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_CompanyBranches_Branch_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_CompanyBranches] DROP CONSTRAINT [DF_TMS_CompanyBranches_Branch_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_CompanyBranches_Branch_Category]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_CompanyBranches] DROP CONSTRAINT [DF_TMS_CompanyBranches_Branch_Category]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_CompanyBranches_Branch_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_CompanyBranches] DROP CONSTRAINT [DF_TMS_CompanyBranches_Branch_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_CompanyBranches_Branch_CreateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_CompanyBranches] DROP CONSTRAINT [DF_TMS_CompanyBranches_Branch_CreateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_CompanyBranches_Branch_Confirmer]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_CompanyBranches] DROP CONSTRAINT [DF_TMS_CompanyBranches_Branch_Confirmer]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_CompanyBranches_Branch_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_CompanyBranches] DROP CONSTRAINT [DF_TMS_CompanyBranches_Branch_Status]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_CompanyBranches_Branch_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_CompanyBranches] DROP CONSTRAINT [DF_TMS_CompanyBranches_Branch_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_CompanyBranches]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_CompanyBranches]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_CompanyBranches](
	[Branch_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch_OwnerCompanyID] [bigint] NOT NULL,
	[Branch_CompanyID] [bigint] NOT NULL,
	[Branch_Category] [bigint] NOT NULL,
	[Branch_Name] [nvarchar](300) NOT NULL,
	[Branch_ReqDescription] [nvarchar](500) NULL,
	[Branch_ResDescription] [nvarchar](500) NULL,
	[Branch_Creator] [bigint] NOT NULL,
	[Branch_CreateTime] [datetime] NOT NULL,
	[Branch_Confirmer] [bigint] NULL,
	[Branch_ConfirmTime] [datetime] NULL,
	[Branch_Status] [bigint] NOT NULL,
	[Branch_Invalid] [bigint] NOT NULL,
	[Branch_Comments] [nvarchar](300) NULL,
 CONSTRAINT [PK_TMS_CompanyBranches] PRIMARY KEY CLUSTERED 
(
	[Branch_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'集团编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_CompanyBranches', @level2type=N'COLUMN',@level2name=N'Branch_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'集团公司编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_CompanyBranches', @level2type=N'COLUMN',@level2name=N'Branch_OwnerCompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分支机构公司编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_CompanyBranches', @level2type=N'COLUMN',@level2name=N'Branch_CompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 集团子公司 2 园区企业' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_CompanyBranches', @level2type=N'COLUMN',@level2name=N'Branch_Category'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分支机构名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_CompanyBranches', @level2type=N'COLUMN',@level2name=N'Branch_Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_CompanyBranches', @level2type=N'COLUMN',@level2name=N'Branch_ReqDescription'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_CompanyBranches', @level2type=N'COLUMN',@level2name=N'Branch_ResDescription'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_CompanyBranches', @level2type=N'COLUMN',@level2name=N'Branch_Creator'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_CompanyBranches', @level2type=N'COLUMN',@level2name=N'Branch_CreateTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态, 0 待发送 1 待审核 2 已审核 32 已关闭' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_CompanyBranches', @level2type=N'COLUMN',@level2name=N'Branch_Status'
GO

ALTER TABLE [dbo].[TMS_CompanyBranches] ADD  CONSTRAINT [DF_TMS_CompanyBranches_Branch_OwnerCompanyID]  DEFAULT ((0)) FOR [Branch_OwnerCompanyID]
GO

ALTER TABLE [dbo].[TMS_CompanyBranches] ADD  CONSTRAINT [DF_TMS_CompanyBranches_Branch_CompanyID]  DEFAULT ((0)) FOR [Branch_CompanyID]
GO

ALTER TABLE [dbo].[TMS_CompanyBranches] ADD  CONSTRAINT [DF_TMS_CompanyBranches_Branch_Category]  DEFAULT ((1)) FOR [Branch_Category]
GO

ALTER TABLE [dbo].[TMS_CompanyBranches] ADD  CONSTRAINT [DF_TMS_CompanyBranches_Branch_Creator]  DEFAULT ((0)) FOR [Branch_Creator]
GO

ALTER TABLE [dbo].[TMS_CompanyBranches] ADD  CONSTRAINT [DF_TMS_CompanyBranches_Branch_CreateTime]  DEFAULT (getdate()) FOR [Branch_CreateTime]
GO

ALTER TABLE [dbo].[TMS_CompanyBranches] ADD  CONSTRAINT [DF_TMS_CompanyBranches_Branch_Confirmer]  DEFAULT ((0)) FOR [Branch_Confirmer]
GO

ALTER TABLE [dbo].[TMS_CompanyBranches] ADD  CONSTRAINT [DF_TMS_CompanyBranches_Branch_Status]  DEFAULT ((0)) FOR [Branch_Status]
GO

ALTER TABLE [dbo].[TMS_CompanyBranches] ADD  CONSTRAINT [DF_TMS_CompanyBranches_Branch_Invalid]  DEFAULT ((0)) FOR [Branch_Invalid]
GO


