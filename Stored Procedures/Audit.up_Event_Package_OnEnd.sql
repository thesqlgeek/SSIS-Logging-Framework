USE [SSISLogging]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [Audit].[up_Event_Package_OnEnd]
	 @logID				int
with execute as caller
as

/**********************************************************************************************

Developer:  Jason McKittrick

Procedure Name:[Audit].[up_Event_Package_OnEnd]

Description: This stored procedure updates an existing entry in the custom event-log table. It flags the
			 execution run as complete.
				Status = 0: Running (Incomplete)
				Status = 1: Complete
				Status = 2: Failed

Parameters :  @ParmaterName   ParameterDataType     Description

Example:
		declare @logID int
		set @logID = 0
		exec audit.up_Event_Package_OnEnd @logID
		select * from audit.ExecutionLog where LogID = @logID

**********************************************************************************************/

begin
	set nocount on

	update audit.ExecutionLog set
		 EndTime = getdate() --Note: This should NOT be @logicalDate
		,Status = case
			when Status = 0 then 1	--Complete
			else Status
		end --case
	where
		LogID = @logID

	set nocount off
end --proc
GO
