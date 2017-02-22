USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MConfig_Cfg_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MConfig] DROP CONSTRAINT [DF_TMS_MConfig_Cfg_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MConfig_Cfg_GoodsCategory]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MConfig] DROP CONSTRAINT [DF_TMS_MConfig_Cfg_GoodsCategory]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MConfig_Cfg_PackageMode]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MConfig] DROP CONSTRAINT [DF_TMS_MConfig_Cfg_PackageMode]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MConfig_Cfg_ChargeMode]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MConfig] DROP CONSTRAINT [DF_TMS_MConfig_Cfg_ChargeMode]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MConfig_Cfg_PriceUnit]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MConfig] DROP CONSTRAINT [DF_TMS_MConfig_Cfg_PriceUnit]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MConfig_Cfg_Insurance]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MConfig] DROP CONSTRAINT [DF_TMS_MConfig_Cfg_Insurance]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MConfig_Cfg_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MConfig] DROP CONSTRAINT [DF_TMS_MConfig_Cfg_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MConfig_Cfg_CreateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MConfig] DROP CONSTRAINT [DF_TMS_MConfig_Cfg_CreateTime]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_MConfig]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_MConfig]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_MConfig](
	[Cfg_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Cfg_CompanyID] [bigint] NOT NULL,
	[Cfg_GoodsCategory] [bigint] NULL,
	[Cfg_PackageMode] [bigint] NULL,
	[Cfg_ChargeMode] [bigint] NULL,
	[Cfg_PriceUnit] [bigint] NULL,
	[Cfg_Insurance] [bigint] NULL,
	[Cfg_Creator] [bigint] NOT NULL,
	[Cfg_CreateTime] [datetime] NOT NULL,
	[Cfg_Comments] [nvarchar](300) NULL,
 CONSTRAINT [PK_TMS_MConfig] PRIMARY KEY CLUSTERED 
(
	[Cfg_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ËùÊô¹«Ë¾' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MConfig', @level2type=N'COLUMN',@level2name=N'Cfg_CompanyID'
GO

ALTER TABLE [dbo].[TMS_MConfig] ADD  CONSTRAINT [DF_TMS_MConfig_Cfg_CompanyID]  DEFAULT ((0)) FOR [Cfg_CompanyID]
GO

ALTER TABLE [dbo].[TMS_MConfig] ADD  CONSTRAINT [DF_TMS_MConfig_Cfg_GoodsCategory]  DEFAULT ((0)) FOR [Cfg_GoodsCategory]
GO

ALTER TABLE [dbo].[TMS_MConfig] ADD  CONSTRAINT [DF_TMS_MConfig_Cfg_PackageMode]  DEFAULT ((0)) FOR [Cfg_PackageMode]
GO

ALTER TABLE [dbo].[TMS_MConfig] ADD  CONSTRAINT [DF_TMS_MConfig_Cfg_ChargeMode]  DEFAULT ((0)) FOR [Cfg_ChargeMode]
GO

ALTER TABLE [dbo].[TMS_MConfig] ADD  CONSTRAINT [DF_TMS_MConfig_Cfg_PriceUnit]  DEFAULT ((0)) FOR [Cfg_PriceUnit]
GO

ALTER TABLE [dbo].[TMS_MConfig] ADD  CONSTRAINT [DF_TMS_MConfig_Cfg_Insurance]  DEFAULT ((0)) FOR [Cfg_Insurance]
GO

ALTER TABLE [dbo].[TMS_MConfig] ADD  CONSTRAINT [DF_TMS_MConfig_Cfg_Creator]  DEFAULT ((0)) FOR [Cfg_Creator]
GO

ALTER TABLE [dbo].[TMS_MConfig] ADD  CONSTRAINT [DF_TMS_MConfig_Cfg_CreateTime]  DEFAULT (getdate()) FOR [Cfg_CreateTime]
GO


