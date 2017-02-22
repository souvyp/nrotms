USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_OrderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_OrderID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_FromProvince]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_FromProvince]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_FromCity]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_FromCity]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_ToProvince]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_ToProvince]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_ToCity]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_ToCity]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Volume]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Volume]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Weight]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Weight]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_LessLoad]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_LessLoad]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_FullLoad]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_FullLoad]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Pick]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Pick]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Delivery]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Delivery]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_OnLoad]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_OnLoad]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_OffLoad]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_OffLoad]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Min]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Min]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Addition]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Addition]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Insurance]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Insurance]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Total]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Total]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Author]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Author]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Balance_BillDetails_Detail_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Balance_BillDetails] DROP CONSTRAINT [DF_Balance_BillDetails_Detail_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Balance_BillDetails]') AND type in (N'U'))
DROP TABLE [dbo].[Balance_BillDetails]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Balance_BillDetails](
	[Detail_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Detail_OrderID] [bigint] NOT NULL,
	[Detail_PactCode] [nvarchar](50) NOT NULL,
	[Detail_FromProvince] [bigint] NOT NULL,
	[Detail_FromCity] [bigint] NOT NULL,
	[Detail_ToProvince] [bigint] NOT NULL,
	[Detail_ToCity] [bigint] NOT NULL,
	[Detail_Volume] [decimal](18, 4) NOT NULL,
	[Detail_Weight] [decimal](18, 4) NOT NULL,
	[Detail_Description] [nvarchar](500) NULL,
	[Detail_LessLoad] [decimal](18, 2) NOT NULL,
	[Detail_FullLoad] [decimal](18, 2) NOT NULL,
	[Detail_Pick] [decimal](18, 2) NOT NULL,
	[Detail_Delivery] [decimal](18, 2) NOT NULL,
	[Detail_OnLoad] [decimal](18, 2) NOT NULL,
	[Detail_OffLoad] [decimal](18, 2) NOT NULL,
	[Detail_Min] [decimal](18, 2) NOT NULL,
	[Detail_Addition] [decimal](18, 2) NOT NULL,
	[Detail_Insurance] [decimal](18, 2) NOT NULL,
	[Detail_Total] [decimal](18, 2) NOT NULL,
	[Detail_Author] [bigint] NOT NULL,
	[Detail_InsertTime] [datetime] NOT NULL,
	[Detail_Updater] [bigint] NULL,
	[Detail_UpdateTime] [datetime] NULL,
	[Detail_Invalid] [tinyint] NOT NULL,
	[Detail_Comments] [nvarchar](256) NULL,
 CONSTRAINT [PK_Balance_BillDetails] PRIMARY KEY CLUSTERED 
(
	[Detail_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账单明细编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_OrderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单合同编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_PactCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发站省' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_FromProvince'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发站市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_FromCity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到站省' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_ToProvince'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到站市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_ToCity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总体积' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Volume'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总重量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Weight'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'零担费用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_LessLoad'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'整车费用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_FullLoad'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提货费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Pick'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'送货费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Delivery'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'装货费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_OnLoad'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卸货费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_OffLoad'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最低收费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Min'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附加费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Addition'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Insurance'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Total'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Author'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_InsertTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Updater'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_UpdateTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否失效' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Invalid'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Balance_BillDetails', @level2type=N'COLUMN',@level2name=N'Detail_Comments'
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_OrderID]  DEFAULT ((0)) FOR [Detail_OrderID]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_FromProvince]  DEFAULT ((0)) FOR [Detail_FromProvince]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_FromCity]  DEFAULT ((0)) FOR [Detail_FromCity]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_ToProvince]  DEFAULT ((0)) FOR [Detail_ToProvince]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_ToCity]  DEFAULT ((0)) FOR [Detail_ToCity]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Volume]  DEFAULT ((0)) FOR [Detail_Volume]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Weight]  DEFAULT ((0)) FOR [Detail_Weight]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_LessLoad]  DEFAULT ((0)) FOR [Detail_LessLoad]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_FullLoad]  DEFAULT ((0)) FOR [Detail_FullLoad]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Pick]  DEFAULT ((0)) FOR [Detail_Pick]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Delivery]  DEFAULT ((0)) FOR [Detail_Delivery]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_OnLoad]  DEFAULT ((0)) FOR [Detail_OnLoad]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_OffLoad]  DEFAULT ((0)) FOR [Detail_OffLoad]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Min]  DEFAULT ((0)) FOR [Detail_Min]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Addition]  DEFAULT ((0)) FOR [Detail_Addition]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Insurance]  DEFAULT ((0)) FOR [Detail_Insurance]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Total]  DEFAULT ((0)) FOR [Detail_Total]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Author]  DEFAULT ((0)) FOR [Detail_Author]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_InsertTime]  DEFAULT (getdate()) FOR [Detail_InsertTime]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Updater]  DEFAULT ((0)) FOR [Detail_Updater]
GO

ALTER TABLE [dbo].[Balance_BillDetails] ADD  CONSTRAINT [DF_Balance_BillDetails_Detail_Invalid]  DEFAULT ((0)) FOR [Detail_Invalid]
GO


