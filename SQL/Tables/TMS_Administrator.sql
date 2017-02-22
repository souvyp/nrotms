USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Administrator_Admin_IsSa]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Administrator] DROP CONSTRAINT [DF_TMS_Administrator_Admin_IsSa]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Administrator_Admin_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Administrator] DROP CONSTRAINT [DF_TMS_Administrator_Admin_InsertTime]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TMS_Administrator_Admin_Invalid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TMS_Administrator] DROP CONSTRAINT [DF_TMS_Administrator_Admin_Invalid]
END

GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_Administrator]    Script Date: 08/18/2015 14:30:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_Administrator]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_Administrator]
GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_Administrator]    Script Date: 08/18/2015 14:30:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TMS_Administrator](
	[Admin_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Admin_Account] [varchar](100) NOT NULL,
	[Admin_Password] [varchar](40) NOT NULL,
	[Admin_IsSa] [tinyint] NULL,
	[Admin_InsertTime] [datetime] NULL,
	[Admin_Invalid] [tinyint] NOT NULL,
	[Admin_Comments] [varchar](256) NULL,
 CONSTRAINT [PK_TMS_Administrator] PRIMARY KEY CLUSTERED 
(
	[Admin_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TMS_Administrator] ADD  CONSTRAINT [DF_TMS_Administrator_Admin_IsSa]  DEFAULT ((0)) FOR [Admin_IsSa]
GO

ALTER TABLE [dbo].[TMS_Administrator] ADD  CONSTRAINT [DF_TMS_Administrator_Admin_InsertTime]  DEFAULT (getdate()) FOR [Admin_InsertTime]
GO

ALTER TABLE [dbo].[TMS_Administrator] ADD  CONSTRAINT [DF_TMS_Administrator_Admin_Invalid]  DEFAULT ((0)) FOR [Admin_Invalid]
GO


