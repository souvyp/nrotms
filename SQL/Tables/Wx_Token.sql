USE [OTMS]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Wx_Token_Wx_InsertTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Wx_Token] DROP CONSTRAINT [DF_Wx_Token_Wx_InsertTime]
END

GO

USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Wx_Token]') AND type in (N'U'))
DROP TABLE [dbo].[Wx_Token]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Wx_Token](
	[Wx_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Wx_AppID] [nvarchar](100) NOT NULL,
	[Wx_Token] [nvarchar](200) NULL,
	[Wx_ExpiredTime] [datetime] NULL,
	[Wx_InsertTime] [datetime] NOT NULL,
	[Wx_Comments] [nvarchar](256) NULL,
 CONSTRAINT [PK_Wx_Token] PRIMARY KEY CLUSTERED 
(
	[Wx_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Wx_Token] ADD  CONSTRAINT [DF_Wx_Token_Wx_InsertTime]  DEFAULT (getdate()) FOR [Wx_InsertTime]
GO


