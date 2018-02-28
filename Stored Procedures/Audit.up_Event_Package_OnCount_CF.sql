USE [SSISLogging]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [Audit].[up_Event_Package_OnCount_CF]
       @logID                       int
      ,@ComponentName         varchar(50)
      ,@Rows                        int
      ,@StartTime             datetime
with execute as caller
as

/**********************************************************************************************

Developer:  Jason McKittrick

Procedure Name:Audit.up_Event_Package_OnCount_CF

Description: This stored procedure logs an entry to the custom RowCount-log table.

Parameters :  @ParmaterName   ParameterDataType     Description

Example:
            exec audit.up_Event_Package_OnCount_CF 0, 'Test', 100, '2017-11-04'
            select * from audit.StatisticLog where LogID = 0

**********************************************************************************************/


begin
      set nocount on

      --Insert the record
      insert into audit.StatisticLog(
            LogID, ComponentName, Rows, TimeMS
      ) values (
            isnull(@logID, 0), @ComponentName, @Rows, datediff(ms,@StartTime,getdate())
      )

      set nocount off
end
GO
