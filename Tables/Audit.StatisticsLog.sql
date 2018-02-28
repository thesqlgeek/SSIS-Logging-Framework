USE [SSISLogging]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Audit].[StatisticLog](
	[LogID] [int] NOT NULL,
	[ComponentName] [varchar](50) NOT NULL,
	[Rows] [int] NULL,
	[TimeMS] [int] NULL,
	[MinRowsPerSec] [int] NULL,
	[MeanRowsPerSec]  AS (case when isnull([TimeMS],(0))=(0) then NULL else CONVERT([int],([Rows]*(1000.0))/[TimeMS],(0)) end) PERSISTED,
	[MaxRowsPerSec] [int] NULL,
	[LogTime] [datetime] NULL
) ON [PRIMARY]
GO

ALTER TABLE [Audit].[StatisticLog] ADD  CONSTRAINT [DF_ETL_StatisticLog_LogTime]  DEFAULT (getdate()) FOR [LogTime]
GO
