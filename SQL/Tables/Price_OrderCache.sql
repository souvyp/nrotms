USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Price_OrderCache_Cache_OrderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Price_OrderCache] DROP CONSTRAINT [DF_Price_OrderCache_Cache_OrderID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Price_OrderCache_Cache_Type]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Price_OrderCache] DROP CONSTRAINT [DF_Price_OrderCache_Cache_Type]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Price_OrderCache_Cache_IsAddition]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Price_OrderCache] DROP CONSTRAINT [DF_Price_OrderCache_Cache_IsAddition]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Price_OrderCache_Cache_Amount]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Price_OrderCache] DROP CONSTRAINT [DF_Price_OrderCache_Cache_Amount]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Price_OrderCache_Cache_Author]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Price_OrderCache] DROP CONSTRAINT [DF_Price_OrderCache_Cache_Author]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Price_OrderCache_Cache_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Price_OrderCache] DROP CONSTRAINT [DF_Price_OrderCache_Cache_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Price_OrderCache_Cache_Updater]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Price_OrderCache] DROP CONSTRAINT [DF_Price_OrderCache_Cache_Updater]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Price_OrderCache_Cache_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Price_OrderCache] DROP CONSTRAINT [DF_Price_OrderCache_Cache_Invalid]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Price_OrderCache]') AND type in (N'U'))
DROP TABLE [dbo].[Price_OrderCache]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Price_OrderCache](
	[Cache_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Cache_OrderID] [bigint] NOT NULL,
	[Cache_Type] [bigint] NOT NULL,
	[Cache_IsAddition] [bigint] NOT NULL,
	[Cache_Amount] [decimal](18, 2) NOT NULL,
	[Cache_Author] [bigint] NOT NULL,
	[Cache_InsertTime] [datetime] NOT NULL,
	[Cache_Updater] [bigint] NULL,
	[Cache_UpdateTime] [datetime] NULL,
	[Cache_Invalid] [tinyint] NOT NULL,
	[Cache_Comments] [nvarchar](256) NULL,
 CONSTRAINT [PK_Price_OrderCache] PRIMARY KEY CLUSTERED 
(
	[Cache_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Price_OrderCache] ADD  CONSTRAINT [DF_Price_OrderCache_Cache_OrderID]  DEFAULT ((0)) FOR [Cache_OrderID]
GO

ALTER TABLE [dbo].[Price_OrderCache] ADD  CONSTRAINT [DF_Price_OrderCache_Cache_Type]  DEFAULT ((0)) FOR [Cache_Type]
GO

ALTER TABLE [dbo].[Price_OrderCache] ADD  CONSTRAINT [DF_Price_OrderCache_Cache_IsAddition]  DEFAULT ((0)) FOR [Cache_IsAddition]
GO

ALTER TABLE [dbo].[Price_OrderCache] ADD  CONSTRAINT [DF_Price_OrderCache_Cache_Amount]  DEFAULT ((0)) FOR [Cache_Amount]
GO

ALTER TABLE [dbo].[Price_OrderCache] ADD  CONSTRAINT [DF_Price_OrderCache_Cache_Author]  DEFAULT ((0)) FOR [Cache_Author]
GO

ALTER TABLE [dbo].[Price_OrderCache] ADD  CONSTRAINT [DF_Price_OrderCache_Cache_InsertTime]  DEFAULT (getdate()) FOR [Cache_InsertTime]
GO

ALTER TABLE [dbo].[Price_OrderCache] ADD  CONSTRAINT [DF_Price_OrderCache_Cache_Updater]  DEFAULT ((0)) FOR [Cache_Updater]
GO

ALTER TABLE [dbo].[Price_OrderCache] ADD  CONSTRAINT [DF_Price_OrderCache_Cache_Invalid]  DEFAULT ((0)) FOR [Cache_Invalid]
GO


