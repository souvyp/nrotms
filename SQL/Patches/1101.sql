-- 新增设备表
USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Devices_Device_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Devices] DROP CONSTRAINT [DF_TMS_Devices_Device_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Devices_Device_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Devices] DROP CONSTRAINT [DF_TMS_Devices_Device_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_Devices]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_Devices]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_Devices](
	[Device_ID] [bigint] IDENTITY(100001,1) NOT NULL,
	[Device_Type] [int] NOT NULL,
	[Device_IMEICode] [nvarchar](50) NOT NULL,
	[Device_PhoneNo] [bigint] NULL,
	[Device_CompanyID] [bigint] NULL,
	[Device_Creator] [bigint] NOT NULL,
	[Device_InsertTime] [datetime] NOT NULL,
	[Device_Updater] [datetime] NULL,
	[Device_UpdateTime] [datetime] NULL,
	[Device_Invalid] [tinyint] NULL,
	[Device_Comments] [nvarchar](100) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[TMS_Devices] ADD  CONSTRAINT [DF_TMS_Devices_Device_InsertTime]  DEFAULT (getdate()) FOR [Device_InsertTime]
GO

ALTER TABLE [dbo].[TMS_Devices] ADD  CONSTRAINT [DF_TMS_Devices_Device_Invalid]  DEFAULT ((0)) FOR [Device_Invalid]
GO


