USE [SSISLogging]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Audit].[ProcessLog](
	[LogID] [int] NOT NULL,
	[RootTableName] [sysname] NOT NULL,
	[PartitionDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
