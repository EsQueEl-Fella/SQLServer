Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'STD - Agent Job History Max Rows', @description=N'', @facet=N'IServerConfigurationFacet', @expression=N'<Operator>
  <TypeClass>Bool</TypeClass>
  <OpType>EQ</OpType>
  <Count>2</Count>
  <Function>
    <TypeClass>Numeric</TypeClass>
    <FunctionType>ExecuteSql</FunctionType>
    <ReturnType>Numeric</ReturnType>
    <Count>2</Count>
    <Constant>
      <TypeClass>String</TypeClass>
      <ObjType>System.String</ObjType>
      <Value>numeric</Value>
    </Constant>
    <Constant>
      <TypeClass>String</TypeClass>
      <ObjType>System.String</ObjType>
      <Value>&lt;?char 13?&gt;
DECLARE @max_total_rows INT;&lt;?char 13?&gt;
EXECUTE master.dbo.xp_instance_regread N''''HKEY_LOCAL_MACHINE'''',&lt;?char 13?&gt;
    N''''SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent'''', N''''JobHistoryMaxRows'''',&lt;?char 13?&gt;
    @max_total_rows OUTPUT, N''''no_output'''';&lt;?char 13?&gt;
SELECT  @max_total_rows;&lt;?char 13?&gt;
</Value>
    </Constant>
  </Function>
  <Constant>
    <TypeClass>Numeric</TypeClass>
    <ObjType>System.Double</ObjType>
    <Value>-1</Value>
  </Constant>
</Operator>', @is_name_condition=0, @obj_name=N'', @condition_id=@condition_id OUTPUT
Select @condition_id


Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'STD - Agent Job History Max Rows_ObjectSet', @facet=N'IServerConfigurationFacet', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'STD - Agent Job History Max Rows_ObjectSet', @type_skeleton=N'Server', @type=N'SERVER', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id




Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'STD - Agent Job History Max Rows', @condition_name=N'STD - Agent Job History Max Rows', @policy_category=N'Standard Configuration Check', @description=N'Checks the setting for Max rows in msdb ', @help_text=N'', @help_link=N'', @schedule_uid=N'00000000-0000-0000-0000-000000000000', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'STD - Agent Job History Max Rows_ObjectSet'
Select @policy_id


