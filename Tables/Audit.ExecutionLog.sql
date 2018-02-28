USE [SSISLogging]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Audit].[ExecutionLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ParentLogID] [int] NULL,
	[Description] [varchar](50) NULL,
	[PackageName] [varchar](50) NOT NULL,
	[PackageGuid] [uniqueidentifier] NOT NULL,
	[MachineName] [varchar](50) NOT NULL,
	[ExecutionGuid] [uniqueidentifier] NOT NULL,
	[LogicalDate] [datetime] NOT NULL,
	[Operator] [varchar](50) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[FailureTask] [varchar](64) NULL,
 CONSTRAINT [PK_ExecutionLog] PRIMARY KEY CLUSTERED
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
