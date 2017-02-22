USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__TMS_MAddr__opt_s__2E70E1FD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF__TMS_MAddr__opt_s__2E70E1FD]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MAddr_Addr_CompanyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF_TMS_MAddr_Addr_CompanyID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MAddr_Addr_CustomerID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF_TMS_MAddr_Addr_CustomerID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MAddr_Addr_ProvinceID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF_TMS_MAddr_Addr_ProvinceID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MAddr_Addr_CityID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF_TMS_MAddr_Addr_CityID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MAddr_Addr_DistrictID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF_TMS_MAddr_Addr_DistrictID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MAddr_Addr_Creator]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF_TMS_MAddr_Addr_Creator]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MAddr_Addr_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF_TMS_MAddr_Addr_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MAddr_Addr_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF_TMS_MAddr_Addr_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MAddr_Addr_UpdateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF_TMS_MAddr_Addr_UpdateTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_MAddr_Addr_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_MAddr] DROP CONSTRAINT [DF_TMS_MAddr_Addr_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_MAddr]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_MAddr]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_MAddr](
	[Addr_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[opt_status] [int] NULL,
	[Addr_CompanyID] [bigint] NOT NULL,
	[Addr_Code] [nvarchar](100) NULL,
	[Addr_CustomerID] [bigint] NULL,
	[Addr_ProvinceID] [bigint] NULL,
	[Addr_CityID] [bigint] NULL,
	[Addr_DistrictID] [bigint] NULL,
	[Addr_Desc] [nvarchar](300) NOT NULL,
	[Addr_Type] [tinyint] NOT NULL,
	[Addr_Creator] [bigint] NULL,
	[Addr_InsertTime] [datetime] NULL,
	[Addr_Updater] [bigint] NULL,
	[Addr_UpdateTime] [datetime] NULL,
	[Addr_Invalid] [tinyint] NOT NULL,
	[Addr_Comments] [varchar](256) NULL,
 CONSTRAINT [PK__TMS_MAdd__3214EC072C88998B] PRIMARY KEY CLUSTERED 
(
	[Addr_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 收货地址 2 发货地址 3 供应商常用地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_MAddr', @level2type=N'COLUMN',@level2name=N'Addr_Type'
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF__TMS_MAddr__opt_s__2E70E1FD]  DEFAULT ((0)) FOR [opt_status]
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF_TMS_MAddr_Addr_CompanyID]  DEFAULT ((0)) FOR [Addr_CompanyID]
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF_TMS_MAddr_Addr_CustomerID]  DEFAULT ((0)) FOR [Addr_CustomerID]
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF_TMS_MAddr_Addr_ProvinceID]  DEFAULT ((0)) FOR [Addr_ProvinceID]
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF_TMS_MAddr_Addr_CityID]  DEFAULT ((0)) FOR [Addr_CityID]
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF_TMS_MAddr_Addr_DistrictID]  DEFAULT ((0)) FOR [Addr_DistrictID]
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF_TMS_MAddr_Addr_Creator]  DEFAULT ((0)) FOR [Addr_Creator]
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF_TMS_MAddr_Addr_InsertTime]  DEFAULT (getdate()) FOR [Addr_InsertTime]
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF_TMS_MAddr_Addr_Updater]  DEFAULT ((0)) FOR [Addr_Updater]
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF_TMS_MAddr_Addr_UpdateTime]  DEFAULT (getdate()) FOR [Addr_UpdateTime]
GO

ALTER TABLE [dbo].[TMS_MAddr] ADD  CONSTRAINT [DF_TMS_MAddr_Addr_Invalid]  DEFAULT ((0)) FOR [Addr_Invalid]
GO


