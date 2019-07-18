-- 重新建表修改执行周期存储变为表达式的方式，因为无法确定上一次执行的时间，也无法实现每隔多少天执行，只能是规定的有周期性的日期，如每天几点，每周周几几点之类想
-- 创建定时执行配置表
create table timingrun_config(
       job number not null,
       priv_user varchar2(255) not null,
       what varchar2(255) not null,
       exec_cycle varchar2(255) not null,
       broken integer default 0 not null,
       remark varchar2(255)
);
comment on table timingrun_config is '定时执行配置表';
comment on column timingrun_config.job is '新增时为空，添加后会自动生成';
comment on column timingrun_config.priv_user is '存储过程所在用户，尽量都在towercrnop下';
comment on column timingrun_config.what is '存储过程名字';
comment on column timingrun_config.exec_cycle is '执行周期表达式';
comment on column timingrun_config.broken is '执行状态，是否执行 0：停止  1：启用';
comment on column timingrun_config.remark is '任务描述';

-- 创建测试表
create table test_ha(
       a date
);

-- 创建数据定时同步的存储过程
create or replace procedure towercrnop.datatimingsync
is
begin
  insert into test_ha values(sysdate);
  commit;
end;
/

-- 插入一条测试数据
begin
insert into timingrun_config values(null,'towercrnop','datatimingsync','sysdate + 5/(24 * 60 * 60)',0);
commit;
end;
/

-- 打开服务 set serveroutput on
-- 下面开始写触发器
-- 新增前
create or replace trigger timingrun_config_insert
before insert
on towercrnop.timingrun_config
for each row
declare
  pragma autonomous_transaction; -- 开启子事务 自治事务
  job number;
  whata timingrun_config.what%type;
  exec_cyclea timingrun_config.exec_cycle%type;
  brokena timingrun_config.broken%type;
BEGIN
  whata := :new.priv_user||'.'||:new.what||';';
  exec_cyclea := :new.exec_cycle;
  brokena := :new.broken;
  dbms_output.put_line('定时执行存储过程名称 ==> '||whata||' 执行周期 ==> '||exec_cyclea||' 是否启用 ==> '||brokena);
  
  -- 创建
  DBMS_JOB.SUBMIT(JOB       => job,  -- 自动生成的任务id
                  WHAT      => whata,  -- 要执行此存储过程,或者sql语句 注意：里面的分号不能少,并且可以有多个语句或过程用分号分隔
                  NEXT_DATE => sysdate, -- 初次执行时间,立刻执行
                  INTERVAL  => exec_cyclea);  -- 执行周期
  COMMIT;
  dbms_output.put_line('job ==> '||job);

  -- 添加job值到配置表
  :new.job := job;
  
  -- 如果初始为1就启用
  if brokena = 1 then
      DBMS_JOB.RUN(job);
  else -- 否则就先停止
      begin dbms_job.broken(job,true,sysdate);commit;end;
  end if;
end;
/

-- 更新后
create or replace trigger timingrun_config_update
after update
on towercrnop.timingrun_config
for each row
declare
  pragma autonomous_transaction; -- 开启子事务 自治事务
  counts number;
BEGIN
     dbms_output.put_line('job ==> '||:old.job);
     select count(1) into counts from all_jobs where job = :old.job;
     if :old.job is null or counts = 0 then
        raise_application_error(-20011,'job为空或计划不存在!');
     end if;
     if :old.job <> :new.job or :old.job is null or :new.job is null then
        raise_application_error(-20010,'job不允许被修改或为空!');
     end if;
     -- 修改执行操作
     if (:old.priv_user <> :new.priv_user) or (:old.what <> :new.what) then
       begin dbms_job.what(:old.job, :new.priv_user||'.'||:new.what||';');commit;end;
       dbms_output.put_line('修改执行操作成功 old ==> '||:old.priv_user||'.'||:old.what||'  new ==> '||:new.priv_user||'.'||:new.what);
     end if;
     -- 修改间隔时间
     if :old.exec_cycle <> :new.exec_cycle then
        begin dbms_job.interval(:old.job, :new.exec_cycle);commit;end;
        dbms_output.put_line('修改间隔周期成功 old ==> '||:old.exec_cycle||'  new ==> '||:new.exec_cycle);
     end if;
     -- 修改执行状态
     if :old.broken <> :new.broken then
        if :new.broken = 1 then -- 启用
            begin dbms_job.broken(:old.job, false, sysdate);commit;end;
            dbms_output.put_line('启用成功');
        else -- 停止
            begin dbms_job.broken(:old.job, true, sysdate);commit;end;
            dbms_output.put_line('停止成功');
        end if;
        dbms_output.put_line('修改执行状态成功 old ==> '||:old.broken||'  new ==> '||:new.broken);
     end if;
end;
/

-- 删除后
create or replace trigger timingrun_config_delete
after delete
on towercrnop.timingrun_config
for each row
declare
  pragma autonomous_transaction; -- 开启子事务 自治事务
  counts number;
BEGIN
     dbms_output.put_line('job ==> '||:old.job);
     select count(1) into counts from all_jobs where job = :old.job;
     if :old.job is null or counts = 0 then
        raise_application_error(-20011,'job为空或计划不存在!');
     else
        -- 停止当前计划
        begin dbms_job.broken(:old.job, true, sysdate);commit;end;
        dbms_output.put_line('计划停止成功!');
        -- 删除计划
        begin dbms_job.remove(:old.job);commit;end;
        dbms_output.put_line('计划删除成功!');
     end if;
end;
/


-- 下方是一些管理语句
-- 打开服务
set serveroutput on
-- 查询当前配置表信息
select * from timingrun_config;
-- 查询作业队列中的所有作业状态
select job,what,next_date,next_sec,failures,broken,interval from all_jobs;
-- 查询触发器当前状态
select trigger_name, status from user_triggers where trigger_name like 'TIMINGRUN_CONFIG%';
-- 激活配置表所有触发器
alter table timingrun_config enable all triggers;
-- 禁用配置表所有触发器
alter table timingrun_config disable all triggers;

