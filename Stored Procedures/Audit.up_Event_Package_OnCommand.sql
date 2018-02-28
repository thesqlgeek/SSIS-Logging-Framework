
USE [SSISLogging]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [Audit].[up_Event_Package_OnCommand]
	 @Key				varchar(50)
	,@Type				varchar(50)
	,@Value				varchar(max)
	,@logID				int
with execute as caller
as

/**********************************************************************************************

Developer:  Jason McKittrick

Procedure Name:	[Audit].[up_Event_Package_OnCommand]

Description: This stored procedure logs a command entry in the custom event-log table. A command is termed
			 as any large SQL or XMLA statement that the ETL performs. It is useful for debugging purposes to know
			 the exact text of the statement.

Parameters:
		 @Key		varchar(50)
		,@Type		varchar(50)
		,@Value		varchar(max)
		,@logID		int

Example:
		exec audit.up_Event_Package_OnCommand 'Create Table', 'SQL', '...sql code...', 0
		select * from audit.CommandLog where LogID = 0

**********************************************************************************************/


begin
	set nocount on

	--Insert the log record
	insert into audit.CommandLog(
		 LogID
		,[Key]
		,[Type]
		,[Value]
    ) values (
		 isnull(@logID, 0)
		,@Key
		,@Type
		,@Value
	)

	set nocount off
end --proc
GO
