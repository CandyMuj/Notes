--1、查询表空间使用情况
select a.tablespace_name 表空间名称,
       total "总空间（M）",
       free "剩余空间（M）",
       total - free as "已使用空间（M）",
       substr(free / total * 100, 1, 5) as 剩余比例,
       substr((total - free) / total * 100, 1, 5) as 已使用率
  from (select tablespace_name, sum(bytes) / 1024 / 1024 as total
          from dba_data_files
         group by tablespace_name) a,
       (select tablespace_name, sum(bytes) / 1024 / 1024 as free
          from dba_free_space
         group by tablespace_name) b
 where a.tablespace_name = b.tablespace_name
 order by a.total desc;

--2、查询表空间的数据文件序号：
select * from dba_data_files c where c.tablespace_name = '表空间全称';

--3.  添加数据文件到表空间：（file_name的数字序号+1）
alter tablespace 表空间全称 add datafile '数据文件绝对路径及名称' size 10G autoextend off;
    
--例如：
alter tablespace METADB_V2 add datafile '/Data/app/oracle/oradata/sctower/metadb_v2_03.dbf' size 10G autoextend off;