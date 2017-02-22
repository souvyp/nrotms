USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_Bill_Bill_CustomerID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillIndex] DROP CONSTRAINT [DF_Balance_Bill_Bill_CustomerID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillIndex_Index_SupplierID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillIndex] DROP CONSTRAINT [DF_Balance_BillIndex_Index_SupplierID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_Bill_Bill_Amount]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillIndex] DROP CONSTRAINT [DF_Balance_Bill_Bill_Amount]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_Bill_Bill_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillIndex] DROP CONSTRAINT [DF_Balance_Bill_Bill_Status]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_Bill_Bill_Author]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillIndex] DROP CONSTRAINT [DF_Balance_Bill_Bill_Author]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_Bill_Bill_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillIndex] DROP CONSTRAINT [DF_Balance_Bill_Bill_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_Bill_Bill_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillIndex] DROP CONSTRAINT [DF_Balance_Bill_Bill_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_Bill_Bill_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillIndex] DROP CONSTRAINT [DF_Balance_Bill_Bill_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Balance_BillIndex]') AND type in (N'U'))
DROP TABLE [dbo].[Balance_BillIndex]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Balance_BillIndex](
	[Index_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Index_CustomerID] [bigint] NOT NULL,
	[Index_SupplierID] [bigint] NOT NULL,
	[Index_Code] [nvarchar](100) NULL,
	[Index_No] [nvarchar](100) NULL,
	[Index_Amount] [decimal](18, 2) NOT NULL,
	[Index_Description] [nvarchar](500) NULL,
	[Index_Status] [bigint] NOT NULL,
	[Index_StatusTime] [datetime] NULL,
	[Index_Author] [bigint] NOT NULL,
	[Index_InsertTime] [datetime] NOT NULL,
	[Index_Updater] [bigint] NULL,
	[Index_UpdateTime] [datetime] NULL,
	[Index_Invalid] [tinyint] NOT NULL,
	[Index_Comments] [nvarchar](256) NULL,
 CONSTRAINT [PK_Balance_Bill] PRIMARY KEY CLUSTERED 
(
	[Index_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账单编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户编号(应收)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_CustomerID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'承运商编号(应付)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_SupplierID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发票代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发票号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_No'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发票金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_Amount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账单描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账单状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_Status'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态变更日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_StatusTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_Author'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_InsertTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_Updater'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillIndex', @level2type=N'COLUMN',@level2name=N'Index_UpdateTime'
GO

ALTER TABLE [dbo].[Balance_BillIndex] ADD  CONSTRAINT [DF_Balance_Bill_Bill_CustomerID]  DEFAULT ((0)) FOR [Index_CustomerID]
GO

ALTER TABLE [dbo].[Balance_BillIndex] ADD  CONSTRAINT [DF_Balance_BillIndex_Index_SupplierID]  DEFAULT ((0)) FOR [Index_SupplierID]
GO

ALTER TABLE [dbo].[Balance_BillIndex] ADD  CONSTRAINT [DF_Balance_Bill_Bill_Amount]  DEFAULT ((0)) FOR [Index_Amount]
GO

ALTER TABLE [dbo].[Balance_BillIndex] ADD  CONSTRAINT [DF_Balance_Bill_Bill_Status]  DEFAULT ((0)) FOR [Index_Status]
GO

ALTER TABLE [dbo].[Balance_BillIndex] ADD  CONSTRAINT [DF_Balance_Bill_Bill_Author]  DEFAULT ((0)) FOR [Index_Author]
GO

ALTER TABLE [dbo].[Balance_BillIndex] ADD  CONSTRAINT [DF_Balance_Bill_Bill_InsertTime]  DEFAULT (getdate()) FOR [Index_InsertTime]
GO

ALTER TABLE [dbo].[Balance_BillIndex] ADD  CONSTRAINT [DF_Balance_Bill_Bill_Updater]  DEFAULT ((0)) FOR [Index_Updater]
GO

ALTER TABLE [dbo].[Balance_BillIndex] ADD  CONSTRAINT [DF_Balance_Bill_Bill_Invalid]  DEFAULT ((0)) FOR [Index_Invalid]
GO


