-- DBA_objects，all_objects
-- all_triggers，user_triggers
--所有触发器
Select object_name From user_objects Where object_type='TRIGGER';
SELECT owner,trigger_name,trigger_type,status FROM all_triggers;
--所有存储过程
Select object_name From user_objects Where object_type='PROCEDURE';
select * from user_procedures
--所有视图
Select object_name From user_objects Where object_type='VIEW';
--所有表
Select object_name From user_objects Where object_type='TABLE';

-- 查询表字段和注释定义等 参考：https://blog.csdn.net/yali1990515/article/details/75084471
select 
      ut.COLUMN_NAME,--字段名称
      uc.comments,--字段注释
      ut.DATA_TYPE,--字典类型
      ut.DATA_LENGTH,--字典长度
      ut.NULLABLE--是否为空
from user_tab_columns  ut
inner JOIN user_col_comments uc
on ut.TABLE_NAME  = uc.table_name and ut.COLUMN_NAME = uc.column_name
where ut.Table_Name='RC_METADATA' 
order by ut.column_name