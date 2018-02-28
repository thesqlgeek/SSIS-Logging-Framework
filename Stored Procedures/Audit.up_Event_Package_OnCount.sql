
USE [SSISLogging]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [Audit].[up_Event_Package_OnCount]
	 @logID				int
	,@ComponentName		varchar(50)
	,@Rows				int
	,@TimeMS			int
	,@MinRowsPerSec		int = null
	,@MaxRowsPerSec		int = null
with execute as caller
as

/**********************************************************************************************

Developer:  Jason McKittrick

Procedure Name:	audit.up_Event_Package_OnCount

Description: This stored procedure logs an error entry in the custom event-log table.
				Status = 0: Running (Incomplete)
				Status = 1: Complete
				Status = 2: Failed

Parameters:
		 @logID				int
		,@ComponentName		varchar(50)
		,@Rows				int
		,@TimeMS			int
		,@MinRowsPerSec		int = null
		,@MaxRowsPerSec		int = null

Example:
		exec audit.up_Event_Package_OnCount 0, 'Test', 100, 1000, 5, 50
		select * from audit.StatisticLog where LogID = 0

**********************************************************************************************/

begin
	set nocount on

	--Insert the record
	insert into audit.StatisticLog(
		LogID, ComponentName, Rows, TimeMS, MinRowsPerSec, MaxRowsPerSec
	) values (
		isnull(@logID, 0), @ComponentName, @Rows, @TimeMS, @MinRowsPerSec, @MaxRowsPerSec
	)

	set nocount off
end --proc
GO
