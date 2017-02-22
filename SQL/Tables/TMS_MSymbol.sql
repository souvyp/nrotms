USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSymbol_Symbol_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSymbol] DROP CONSTRAINT [DF_TMS_MSymbol_Symbol_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSymbol_Symbol_Type]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSymbol] DROP CONSTRAINT [DF_TMS_MSymbol_Symbol_Type]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSymbol_Symbol_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSymbol] DROP CONSTRAINT [DF_TMS_MSymbol_Symbol_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSymbol_Symbol_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSymbol] DROP CONSTRAINT [DF_TMS_MSymbol_Symbol_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MSymbol_Symbol_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MSymbol] DROP CONSTRAINT [DF_TMS_MSymbol_Symbol_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_MSymbol]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_MSymbol]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_MSymbol](
	[Symbol_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Symbol_CompanyID] [bigint] NOT NULL,
	[Symbol_Type] [bigint] NOT NULL,
	[Symbol_Code] [nvarchar](50) NOT NULL,
	[Symbol_Name] [nvarchar](300) NOT NULL,
	[Symbol_Creator] [bigint] NOT NULL,
	[Symbol_InsertTime] [datetime] NOT NULL,
	[Symbol_Updater] [bigint] NULL,
	[Symbol_UpdateTime] [datetime] NULL,
	[Symbol_Invalid] [tinyint] NOT NULL,
	[Symbol_Comments] [nvarchar](256) NULL,
 CONSTRAINT [PK_TMS_MSymbol] PRIMARY KEY CLUSTERED 
(
	[Symbol_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标记编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属公司' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_CompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标记类型，1 客户标记 2 承运商标记' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_Type'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标记代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标记名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_Creator'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_InsertTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_Updater'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_UpdateTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否失效' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_Invalid'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MSymbol', @level2type=N'COLUMN',@level2name=N'Symbol_Comments'
GO

ALTER TABLE [dbo].[TMS_MSymbol] ADD  CONSTRAINT [DF_TMS_MSymbol_Symbol_CompanyID]  DEFAULT ((0)) FOR [Symbol_CompanyID]
GO

ALTER TABLE [dbo].[TMS_MSymbol] ADD  CONSTRAINT [DF_TMS_MSymbol_Symbol_Type]  DEFAULT ((0)) FOR [Symbol_Type]
GO

ALTER TABLE [dbo].[TMS_MSymbol] ADD  CONSTRAINT [DF_TMS_MSymbol_Symbol_Creator]  DEFAULT ((0)) FOR [Symbol_Creator]
GO

ALTER TABLE [dbo].[TMS_MSymbol] ADD  CONSTRAINT [DF_TMS_MSymbol_Symbol_InsertTime]  DEFAULT (getdate()) FOR [Symbol_InsertTime]
GO

ALTER TABLE [dbo].[TMS_MSymbol] ADD  CONSTRAINT [DF_TMS_MSymbol_Symbol_Invalid]  DEFAULT ((0)) FOR [Symbol_Invalid]
GO


