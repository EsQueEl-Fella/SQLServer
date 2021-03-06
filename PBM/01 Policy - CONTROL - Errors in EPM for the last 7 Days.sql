Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'Control - Errors in EPM for the last 7 Days', @description=N'', @facet=N'IServerAuditFacet', @expression=N'<Operator>
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
      <Value>SELECT * FROM mdw.policy.EvaluationErrorHistory&lt;?char 13?&gt;
WHERE EvaluationDateTime &gt; GETDATE()-7</Value>
    </Constant>
  </Function>
  <Constant>
    <TypeClass>Numeric</TypeClass>
    <ObjType>System.Double</ObjType>
    <Value>0</Value>
  </Constant>
</Operator>', @is_name_condition=0, @obj_name=N'', @condition_id=@condition_id OUTPUT
Select @condition_id


Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'CONTROL - Errors in EPM for the last 7 Days_ObjectSet', @facet=N'IServerAuditFacet', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'CONTROL - Errors in EPM for the last 7 Days_ObjectSet', @type_skeleton=N'Server', @type=N'SERVER', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id




Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'CONTROL - Errors in EPM for the last 7 Days', @condition_name=N'Control - Errors in EPM for the last 7 Days', @policy_category=N'EPM & Security Checks', @description=N'Returns number of errors in the EPM error table for the last 7 days', @help_text=N'', @help_link=N'', @schedule_uid=N'00000000-0000-0000-0000-000000000000', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'CONTROL - Errors in EPM for the last 7 Days_ObjectSet'
Select @policy_id


