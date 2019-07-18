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

-- 创建执行计划
declare
  job number;
BEGIN
  DBMS_JOB.SUBMIT(JOB       => job,  -- 自动生成的任务id
                  WHAT      => 'towercrnop.datatimingsync;',  -- 要执行此存储过程,或者sql语句 注意：里面的分号不能少,并且可以有多个语句或过程用分号分隔
                  NEXT_DATE => sysdate, -- 初次执行时间,立刻执行
                  INTERVAL  => 'sysdate + 5/(24 * 60 * 60)');  -- 执行周期
  COMMIT;
  -- 运行执行计划
  -- 经过测试，不执行这一句上面的commit后默认到指定间隔周期时间就自动执行启动了
  DBMS_JOB.RUN(job);
end;



-- 查看任务队列情况
-- 参数说明 broken=N 启用，broken=Y 停止
select job,what,next_date,next_sec,failures,broken,interval from all_jobs; 

-- 修改执行操作 what=字符串加双引号，并且别忘了最后的分号“;"
begin dbms_job.what(job, what);commit; end;

-- 修改间隔时间 interval=字符串加双引号
begin dbms_job.interval(job, interval);commit; end;

-- 停止job
begin dbms_job.broken(106, true, sysdate);commit; end;

-- 启用job
begin dbms_job.broken(106, false, sysdate);commit; end;

-- 删除job
begin dbms_job.remove(105);commit;end;
