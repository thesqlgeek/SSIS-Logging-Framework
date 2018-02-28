

USE [SSISLogging]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [Audit].[up_Event_Package_OnBegin]
	 @ParentLogID		int
	,@Description		varchar(50) = null
	,@PackageName		varchar(50)
	,@PackageGuid		uniqueidentifier
	,@MachineName		varchar(50)
	,@ExecutionGuid		uniqueidentifier
	,@logicalDate		datetime
	,@operator			varchar(30)
	,@logID				int = null output
with execute as caller
as

/**********************************************************************************************

Developer:  Jason McKittrick

Procedure Name:audit.up_Event_Package_OnBegin

Description: This stored procedure logs a starting event to the custom event-log table

Parameters :
		 @ParentLogID		int
		,@Description		varchar(50) = null
		,@PackageName		varchar(50)
		,@PackageGuid		uniqueidentifier
		,@MachineName		varchar(50)
		,@ExecutionGuid		uniqueidentifier
		,@logicalDate		datetime
		,@operator			varchar(30)
		,@logID				int = null output

Example:
		declare @logID int
		exec audit.up_Event_Package_OnBegin
			 0, 'Description'
			,'PackageName' ,'00000000-0000-0000-0000-000000000000'
			,'MachineName', '00000000-0000-0000-0000-000000000000'
			,'2018-01-01', null, @logID output
		select * from audit.ExecutionLog where LogID = @logID



**********************************************************************************************/

begin
	set nocount on

	--Coalesce @logicalDate
	set @logicalDate = isnull(@logicalDate, getdate())

	--Coalesce @operator
	set @operator = nullif(ltrim(rtrim(@operator)), '')
	set @operator = isnull(@operator, suser_sname())

	--Root-level nodes should have a null parent
	if @ParentLogID <= 0 set @ParentLogID = null

	--Root-level nodes should not have a null Description
	set @Description = nullif(ltrim(rtrim(@Description)), '')
	if @Description is null and @ParentLogID is null set @Description = @PackageName

	--Insert the log record
	insert into audit.ExecutionLog(
		 ParentLogID
		,Description
		,PackageName
		,PackageGuid
		,MachineName
		,ExecutionGuid
		,LogicalDate
		,Operator
		,StartTime
		,EndTime
		,Status
		,FailureTask
	) values (
		 @ParentLogID
		,@Description
		,@PackageName
		,@PackageGuid
		,@MachineName
		,@ExecutionGuid
		,@logicalDate
		,@operator
		,getdate() --Note: This should NOT be @logicalDate
		,null
		,0	--InProcess
		,null
	)
	set @logID = scope_identity()

	set nocount off
end --proc
GO
