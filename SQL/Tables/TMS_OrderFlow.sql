USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TMS_OrderFlow_TMS_OrderIndex]') AND parent_object_id = OBJECT_ID(N'[dbo].[TMS_OrderFlow]'))
ALTER TABLE [dbo].[TMS_OrderFlow] DROP CONSTRAINT [FK_TMS_OrderFlow_TMS_OrderIndex]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderFlow_opt_status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderFlow] DROP CONSTRAINT [DF_TMS_OrderFlow_opt_status]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderFlow_Status_OrderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderFlow] DROP CONSTRAINT [DF_TMS_OrderFlow_Status_OrderID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderFlow_Status_SrcStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderFlow] DROP CONSTRAINT [DF_TMS_OrderFlow_Status_SrcStatus]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderFlow_Status_DstStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderFlow] DROP CONSTRAINT [DF_TMS_OrderFlow_Status_DstStatus]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderFlow_Flow_Result]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderFlow] DROP CONSTRAINT [DF_TMS_OrderFlow_Flow_Result]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderFlow_Status_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderFlow] DROP CONSTRAINT [DF_TMS_OrderFlow_Status_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderFlow_Status_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderFlow] DROP CONSTRAINT [DF_TMS_OrderFlow_Status_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderFlow_Status_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderFlow] DROP CONSTRAINT [DF_TMS_OrderFlow_Status_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_OrderFlow_Flow_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_OrderFlow] DROP CONSTRAINT [DF_TMS_OrderFlow_Flow_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_OrderFlow]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_OrderFlow]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_OrderFlow](
	[Flow_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[opt_status] [bigint] NOT NULL,
	[Flow_OrderID] [bigint] NOT NULL,
	[Flow_SrcStatus] [bigint] NOT NULL,
	[Flow_DstStatus] [bigint] NOT NULL,
	[Flow_Accept] [bigint] NOT NULL,
	[Flow_Creator] [bigint] NOT NULL,
	[Flow_CompanyID] [bigint] NOT NULL,
	[Flow_InsertTime] [datetime] NOT NULL,
	[Flow_Invalid] [tinyint] NOT NULL,
	[Flow_Comments] [varchar](256) NULL,
 CONSTRAINT [PK_TMS_OrderFlow] PRIMARY KEY CLUSTERED 
(
	[Flow_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderFlow', @level2type=N'COLUMN',@level2name=N'Flow_ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderFlow', @level2type=N'COLUMN',@level2name=N'Flow_OrderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'源状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderFlow', @level2type=N'COLUMN',@level2name=N'Flow_SrcStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目标状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderFlow', @level2type=N'COLUMN',@level2name=N'Flow_DstStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderFlow', @level2type=N'COLUMN',@level2name=N'Flow_Accept'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderFlow', @level2type=N'COLUMN',@level2name=N'Flow_Creator'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属公司(冗余)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderFlow', @level2type=N'COLUMN',@level2name=N'Flow_CompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderFlow', @level2type=N'COLUMN',@level2name=N'Flow_InsertTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_OrderFlow', @level2type=N'COLUMN',@level2name=N'Flow_Comments'
GO

ALTER TABLE [dbo].[TMS_OrderFlow]  WITH CHECK ADD  CONSTRAINT [FK_TMS_OrderFlow_TMS_OrderIndex] FOREIGN KEY([Flow_OrderID])
REFERENCES [dbo].[TMS_OrderIndex] ([Index_ID])
GO

ALTER TABLE [dbo].[TMS_OrderFlow] CHECK CONSTRAINT [FK_TMS_OrderFlow_TMS_OrderIndex]
GO

ALTER TABLE [dbo].[TMS_OrderFlow] ADD  CONSTRAINT [DF_TMS_OrderFlow_opt_status]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_OrderFlow] ADD  CONSTRAINT [DF_TMS_OrderFlow_Status_OrderID]  DEFAULT ((0)) FOR [Flow_OrderID]
GO

ALTER TABLE [dbo].[TMS_OrderFlow] ADD  CONSTRAINT [DF_TMS_OrderFlow_Status_SrcStatus]  DEFAULT ((0)) FOR [Flow_SrcStatus]
GO

ALTER TABLE [dbo].[TMS_OrderFlow] ADD  CONSTRAINT [DF_TMS_OrderFlow_Status_DstStatus]  DEFAULT ((0)) FOR [Flow_DstStatus]
GO

ALTER TABLE [dbo].[TMS_OrderFlow] ADD  CONSTRAINT [DF_TMS_OrderFlow_Flow_Result]  DEFAULT ((0)) FOR [Flow_Accept]
GO

ALTER TABLE [dbo].[TMS_OrderFlow] ADD  CONSTRAINT [DF_TMS_OrderFlow_Status_Creator]  DEFAULT ((0)) FOR [Flow_Creator]
GO

ALTER TABLE [dbo].[TMS_OrderFlow] ADD  CONSTRAINT [DF_TMS_OrderFlow_Status_CompanyID]  DEFAULT ((0)) FOR [Flow_CompanyID]
GO

ALTER TABLE [dbo].[TMS_OrderFlow] ADD  CONSTRAINT [DF_TMS_OrderFlow_Status_InsertTime]  DEFAULT (getdate()) FOR [Flow_InsertTime]
GO

ALTER TABLE [dbo].[TMS_OrderFlow] ADD  CONSTRAINT [DF_TMS_OrderFlow_Flow_Invalid]  DEFAULT ((0)) FOR [Flow_Invalid]
GO


