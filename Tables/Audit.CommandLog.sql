USE [SSISLogging]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Audit].[CommandLog](
	[LogID] [int] NOT NULL,
	[CommandID] [int] IDENTITY(1,1) NOT NULL,
	[Key] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
	[Value] [varchar](max) NULL,
	[LogTime] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [Audit].[CommandLog] ADD  CONSTRAINT [DF_ETL_CommandLog_LogTime]  DEFAULT (getdate()) FOR [LogTime]
GO
