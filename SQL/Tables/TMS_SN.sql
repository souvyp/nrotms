USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_SN]    Script Date: 08/18/2015 14:32:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TMS_SN]') AND type in (N'U'))
DROP TABLE [dbo].[TMS_SN]
GO

USE [OTMS]
GO

/****** Object:  Table [dbo].[TMS_SN]    Script Date: 08/18/2015 14:32:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TMS_SN](
	[SN_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SN_Number] [bigint] NOT NULL,
	[SN_Type] [bigint] NOT NULL,
	[SN_Prefix] [nvarchar](50) NULL,
 CONSTRAINT [PK_TMS_SN] PRIMARY KEY CLUSTERED 
(
	[SN_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


