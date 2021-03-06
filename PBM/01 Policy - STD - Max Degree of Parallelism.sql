Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'STD - Max Degree of Parallelism', @description=N'', @facet=N'IServerPerformanceFacet', @expression=N'<Operator>
  <TypeClass>Bool</TypeClass>
  <OpType>AND</OpType>
  <Count>2</Count>
  <Operator>
    <TypeClass>Bool</TypeClass>
    <OpType>LE</OpType>
    <Count>2</Count>
    <Attribute>
      <TypeClass>Numeric</TypeClass>
      <Name>MaxDegreeOfParallelism</Name>
    </Attribute>
    <Function>
      <TypeClass>Numeric</TypeClass>
      <FunctionType>ExecuteSql</FunctionType>
      <ReturnType>Numeric</ReturnType>
      <Count>2</Count>
      <Constant>
        <TypeClass>String</TypeClass>
        <ObjType>System.String</ObjType>
        <Value>Numeric</Value>
      </Constant>
      <Constant>
        <TypeClass>String</TypeClass>
        <ObjType>System.String</ObjType>
        <Value>declare @MaxDop smallint&lt;?char 13?&gt;
select @MaxDop=min(online_scheduler_count) FROM sys.dm_os_nodes WITH (NOLOCK) &lt;?char 13?&gt;
WHERE node_state_desc &lt;&gt; N''''ONLINE DAC'''' OPTION (RECOMPILE)&lt;?char 13?&gt;
&lt;?char 13?&gt;
IF @MaxDop &gt;=8&lt;?char 13?&gt;
  select 8&lt;?char 13?&gt;
else&lt;?char 13?&gt;
  select @MaxDop</Value>
      </Constant>
    </Function>
  </Operator>
  <Operator>
    <TypeClass>Bool</TypeClass>
    <OpType>NE</OpType>
    <Count>2</Count>
    <Attribute>
      <TypeClass>Numeric</TypeClass>
      <Name>MaxDegreeOfParallelism</Name>
    </Attribute>
    <Function>
      <TypeClass>Numeric</TypeClass>
      <FunctionType>ExecuteSql</FunctionType>
      <ReturnType>Numeric</ReturnType>
      <Count>2</Count>
      <Constant>
        <TypeClass>String</TypeClass>
        <ObjType>System.String</ObjType>
        <Value>Numeric</Value>
      </Constant>
      <Constant>
        <TypeClass>String</TypeClass>
        <ObjType>System.String</ObjType>
        <Value>declare @MaxDop smallint&lt;?char 13?&gt;
select @MaxDop=min(online_scheduler_count) FROM sys.dm_os_nodes WITH (NOLOCK) &lt;?char 13?&gt;
WHERE node_state_desc &lt;&gt; N''''ONLINE DAC'''' OPTION (RECOMPILE)&lt;?char 13?&gt;
&lt;?char 13?&gt;
IF @MaxDop &gt;8&lt;?char 13?&gt;
  select 0&lt;?char 13?&gt;
else&lt;?char 13?&gt;
  select -1</Value>
      </Constant>
    </Function>
  </Operator>
</Operator>', @is_name_condition=0, @obj_name=N'', @condition_id=@condition_id OUTPUT
Select @condition_id


Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'STD - Max Degree of Parallelism_ObjectSet_1', @facet=N'IServerPerformanceFacet', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'STD - Max Degree of Parallelism_ObjectSet_1', @type_skeleton=N'Server', @type=N'SERVER', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id




Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'STD - Max Degree of Parallelism', @condition_name=N'STD - Max Degree of Parallelism', @policy_category=N'Standard Configuration Check', @description=N'checks if Max degree of para is set to best practise. 

code from Pieter Vanhove', @help_text=N'Source', @help_link=N'http://pietervanhove.azurewebsites.net/?p=14192', @schedule_uid=N'00000000-0000-0000-0000-000000000000', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'STD - Max Degree of Parallelism_ObjectSet_1'
Select @policy_id


