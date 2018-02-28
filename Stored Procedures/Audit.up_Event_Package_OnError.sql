USE [SSISLogging]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [Audit].[up_Event_Package_OnError]
	 @logID		int
	,@message	varchar(64) = null	--optional, for custom failures
with execute as caller
as

/**********************************************************************************************

Developer:  Jason McKittrick

Procedure Name:[Audit].[up_Event_Package_OnError]

Description: This stored procedure logs an error entry in the custom event-log table.
				Status = 0: Running (Incomplete)
				Status = 1: Complete
				Status = 2: Failed

Parameters :  @ParmaterName   ParameterDataType     Description

Example:
		exec audit.up_Event_Package_OnError 1, 'Failed'
		select * from audit.ExecutionLog where LogID = 1
              
**********************************************************************************************/

begin
	set nocount on

	declare
		 @failureTask		varchar(64)
		,@packageName		varchar(64)
		,@executionGuid		uniqueidentifier

	if @message is null begin
		select
			 @packageName = upper(PackageName)
			,@executionGuid = ExecutionGuid
		from audit.ExecutionLog
		where LogID = @logID

		select top 1 @failureTask = source
		from dbo.sysdtslog90
		where executionid = @executionGuid
			and (upper(event) = 'ONERROR')
			and upper(source) <> @packageName
		order by endtime desc
	end else begin
		set @failureTask = @message
	end

	update audit.ExecutionLog set
		 EndTime = getdate()
		,Status = 2	--Failed
		,FailureTask = @failureTask
	where
		LogID = @logID

	set nocount off
end
GO
