USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_MAuto__opt_s__047AA831]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCar] DROP CONSTRAINT [DF__TMS_MAuto__opt_s__047AA831]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCar_Car_Type]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCar] DROP CONSTRAINT [DF_TMS_MCar_Car_Type]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCar_Car_Weight]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCar] DROP CONSTRAINT [DF_TMS_MCar_Car_Weight]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCar_Car_Seats]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCar] DROP CONSTRAINT [DF_TMS_MCar_Car_Seats]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCar_Car_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCar] DROP CONSTRAINT [DF_TMS_MCar_Car_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCar_Car_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCar] DROP CONSTRAINT [DF_TMS_MCar_Car_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCar_Car_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCar] DROP CONSTRAINT [DF_TMS_MCar_Car_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCar_Car_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCar] DROP CONSTRAINT [DF_TMS_MCar_Car_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCar_Car_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCar] DROP CONSTRAINT [DF_TMS_MCar_Car_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MCar_Car_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MCar] DROP CONSTRAINT [DF_TMS_MCar_Car_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_MCar]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_MCar]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_MCar](
	[Car_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[opt_status] [int] NULL,
	[Car_SN] [nvarchar](50) NOT NULL,
	[Car_Type] [bigint] NULL,
	[Car_Length] [nvarchar](50) NULL,
	[Car_Weight] [float] NULL,
	[Car_Seats] [bigint] NULL,
	[Car_PurchaseTime] [datetime] NULL,
	[Car_Insurance] [datetime] NULL,
	[Car_Brand] [nvarchar](50) NULL,
	[Car_Photo] [nvarchar](300) NULL,
	[Car_CompanyID] [bigint] NOT NULL,
	[Car_Creator] [bigint] NULL,
	[Car_InsertTime] [datetime] NULL,
	[Car_Updater] [bigint] NULL,
	[Car_UpdateTime] [datetime] NULL,
	[Car_Invalid] [tinyint] NOT NULL,
	[Car_Comments] [varchar](256) NULL,
 CONSTRAINT [PK__TMS_MAut__3214EC0702925FBF] PRIMARY KEY CLUSTERED 
(
	[Car_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'³µÅÆºÅ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MCar', @level2type=N'COLUMN',@level2name=N'Car_SN'
GO

ALTER TABLE [dbo].[TMS_MCar] ADD  CONSTRAINT [DF__TMS_MAuto__opt_s__047AA831]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_MCar] ADD  CONSTRAINT [DF_TMS_MCar_Car_Type]  DEFAULT ((0)) FOR [Car_Type]
GO

ALTER TABLE [dbo].[TMS_MCar] ADD  CONSTRAINT [DF_TMS_MCar_Car_Weight]  DEFAULT ((0)) FOR [Car_Weight]
GO

ALTER TABLE [dbo].[TMS_MCar] ADD  CONSTRAINT [DF_TMS_MCar_Car_Seats]  DEFAULT ((0)) FOR [Car_Seats]
GO

ALTER TABLE [dbo].[TMS_MCar] ADD  CONSTRAINT [DF_TMS_MCar_Car_CompanyID]  DEFAULT ((0)) FOR [Car_CompanyID]
GO

ALTER TABLE [dbo].[TMS_MCar] ADD  CONSTRAINT [DF_TMS_MCar_Car_Creator]  DEFAULT ((0)) FOR [Car_Creator]
GO

ALTER TABLE [dbo].[TMS_MCar] ADD  CONSTRAINT [DF_TMS_MCar_Car_InsertTime]  DEFAULT (getdate()) FOR [Car_InsertTime]
GO

ALTER TABLE [dbo].[TMS_MCar] ADD  CONSTRAINT [DF_TMS_MCar_Car_Updater]  DEFAULT ((0)) FOR [Car_Updater]
GO

ALTER TABLE [dbo].[TMS_MCar] ADD  CONSTRAINT [DF_TMS_MCar_Car_UpdateTime]  DEFAULT (getdate()) FOR [Car_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_MCar] ADD  CONSTRAINT [DF_TMS_MCar_Car_Invalid]  DEFAULT ((0)) FOR [Car_Invalid]
GO


