USE [SSISLogging]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [Audit].[up_ClearLogs]
with execute as caller
as
begin
	set nocount on

	truncate table audit.CommandLog
	truncate table audit.ExecutionLog
	truncate table audit.ProcessLog
	truncate table audit.StatisticLog
	truncate table dbo.sysdtslog90

	set nocount off
end --proc
GO
