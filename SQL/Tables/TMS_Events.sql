USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_1_Event_Type]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_Table_1_Event_Type]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Events_Event_Type]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_TMS_Events_Event_Type]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Events_Event_Result]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_TMS_Events_Event_Result]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Events_Event_SrcCompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_TMS_Events_Event_SrcCompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Events_Event_DstCompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_TMS_Events_Event_DstCompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Events_Event_Processed]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_TMS_Events_Event_Processed]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Events_Event_Processor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_TMS_Events_Event_Processor]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Events_Event_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_TMS_Events_Event_Invalid]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Events_Event_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_TMS_Events_Event_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Events_Event_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_TMS_Events_Event_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Events_Event_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Events] DROP CONSTRAINT [DF_TMS_Events_Event_Updater]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_Events]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_Events]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_Events](
	[Event_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Event_Category] [bigint] NOT NULL,
	[Event_Type] [bigint] NOT NULL,
	[Event_Result] [bigint] NOT NULL,
	[Event_SrcCompanyID] [bigint] NOT NULL,
	[Event_DstCompanyID] [bigint] NOT NULL,
	[Event_Ext] [nvarchar](600) NULL,
	[Event_Time] [datetime] NULL,
	[Event_Processed] [tinyint] NOT NULL,
	[Event_ProcessTime] [datetime] NULL,
	[Event_Processor] [bigint] NULL,
	[Event_Invalid] [tinyint] NOT NULL,
	[Event_Creator] [bigint] NOT NULL,
	[Event_InsertTime] [datetime] NULL,
	[Event_Updater] [bigint] NULL,
	[Event_UpdateTime] [datetime] NULL,
	[Event_Remark] [varchar](256) NULL,
 CONSTRAINT [PK_TMS_Events] PRIMARY KEY CLUSTERED 
(
	[Event_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'事件分类，1 供应商通知 2 订单通知 3 异常与附加费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Category'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'事件类型，1 被邀成为供应商 2 供应商邀请被拒 3 待接收订单 4 订单被拒 5 异常提醒 6 附加费提醒' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Type'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'事件结果，0 同意 1 拒绝' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Result'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发起事件的公司编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_SrcCompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'事件当事人的公司编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_DstCompanyID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Ext'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发生时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Time'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否已读取' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Processed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_ProcessTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Processor'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否失效' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Invalid'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Creator'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_InsertTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Updater'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_UpdateTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_Events', @level2type=N'COLUMN',@level2name=N'Event_Remark'
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_Table_1_Event_Type]  DEFAULT ((0)) FOR [Event_Category]
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_TMS_Events_Event_Type]  DEFAULT ((0)) FOR [Event_Type]
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_TMS_Events_Event_Result]  DEFAULT ((0)) FOR [Event_Result]
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_TMS_Events_Event_SrcCompanyID]  DEFAULT ((0)) FOR [Event_SrcCompanyID]
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_TMS_Events_Event_DstCompanyID]  DEFAULT ((0)) FOR [Event_DstCompanyID]
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_TMS_Events_Event_Processed]  DEFAULT ((0)) FOR [Event_Processed]
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_TMS_Events_Event_Processor]  DEFAULT ((0)) FOR [Event_Processor]
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_TMS_Events_Event_Invalid]  DEFAULT ((0)) FOR [Event_Invalid]
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_TMS_Events_Event_Creator]  DEFAULT ((0)) FOR [Event_Creator]
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_TMS_Events_Event_InsertTime]  DEFAULT (getdate()) FOR [Event_InsertTime]
GO

ALTER TABLE [dbo].[TMS_Events] ADD  CONSTRAINT [DF_TMS_Events_Event_Updater]  DEFAULT ((0)) FOR [Event_Updater]
GO


