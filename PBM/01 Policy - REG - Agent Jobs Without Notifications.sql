Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'REG - Agent Jobs Without Notifications', @description=N'', @facet=N'IServerConfigurationFacet', @expression=N'<Operator>
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
      <Value>	SELECT COUNT(*)
	FROM    msdb.[dbo].[sysjobs] j
										INNER JOIN ( SELECT DISTINCT
															[job_id]
													 FROM   [msdb].[dbo].[sysjobschedules]
													 WHERE  next_run_date &gt; 0
												   ) s ON j.job_id = s.job_id
								WHERE   j.enabled = 1
										AND j.notify_email_operator_id = 0
										AND j.notify_netsend_operator_id = 0
										AND j.notify_page_operator_id = 0</Value>
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
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'REG - Agent Jobs Without Notifications_ObjectSet', @facet=N'IServerConfigurationFacet', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'REG - Agent Jobs Without Notifications_ObjectSet', @type_skeleton=N'Server', @type=N'SERVER', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id




Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'REG - Agent Jobs Without Notifications', @condition_name=N'REG - Agent Jobs Without Notifications', @policy_category=N'Regular Health Check', @description=N'Counts the number of agent jobs that dont have notification configured', @help_text=N'', @help_link=N'', @schedule_uid=N'00000000-0000-0000-0000-000000000000', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'REG - Agent Jobs Without Notifications_ObjectSet'
Select @policy_id


