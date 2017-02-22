USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'PriceDocLst' AND ss.name = N'dbo')
DROP TYPE [dbo].[PriceDocLst]
GO

USE [OTMS]
GO

CREATE TYPE [dbo].[PriceDocLst] AS TABLE(
	[Doc_ID] [bigint] NULL DEFAULT ((0))
)
GO


