-- Oracle创建序列
CREATE SEQUENCE emp_sequence  --序列名
INCREMENT BY 1		      -- 每次加几个  
START WITH 1		      -- 从1开始计数  
NOMAXVALUE		      -- 不设置最大值  
NOCYCLE			      -- 一直累加，不循环  
CACHE 10;

-- 修改序列每次增加多少
ALTER SEQUENCE seq_name INCREMENT BY 1000

--创建索引
CREATE UNIQUE INDEX rms_portinfo_in ON RMS_PORT_INFO(city_id,zh_label,stateflag,source_ne)
  tablespace RMS_INDX_TABSPACE_1
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
tablespace users pctfree 10 initrans 2 maxtrans 255 storage ( initial 1m next 1m minextents 1 maxextents unlimited )

--开启命令窗口输出服务
set serveroutput on

--创建存储过程
create or replace procedure procedure_name
is
begin
  
end;
/

--更改表的名字
alter table busi_system_info rename to rms_sys_info;


--查询表当前索引
select * from user_indexes where table_name='RMS_EQUIPMENT_INFO';   


-- 查看视图的名称（查询所有用户的视图使用系统视图：all_views)
SQL>select view_name from user_views;
-- 查看创建视图的select语句
SQL>select view_name,text_length from user_views;
SQL>set long 2000; --说明：可以根据视图的text_length值设定set long 的大小
SQL>select text from user_views where view_name=upper('&view_name');


--添加注释
comment on table table_name is '';
comment on column table_name.column_name is '';