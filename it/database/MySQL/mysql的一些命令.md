# 用户和权限

## 创建用户 和 授权

> 具体参数可参考：https://www.cnblogs.com/sos-blue/p/6852945.html

```mysql
-- 第一步 创建用户
CREATE USER 'test'@'%' IDENTIFIED BY 'xxxxx';
-- 第二步 授权
grant select on *.* to 'test'@'%';
```

## 查询mysql某个用户所具有的权限

```mysql
show grants for 'candy'@'%';
```

## 授权

> mysql设置远程访问 实质是修改msyql库中的user表
>
> 此方式，如果用户不存在，则还会差创建用户

``` mysql
-- 不用这个 GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'mJ1314521@!' WITH GRANT OPTION;
grant all privileges on *.* to 'root'@'%' identified by 'Mj1314521';
grant all privileges on *.* to candy@'%' identified by 'mJ1314521@!';
grant all privileges on typecho.* to candy@'%' identified by 'mJ1314521!@';

flush privileges;
```

# 备份和恢复

## 数据库备份

* 语法

```mysql
mysqldump -h主机名  -P端口 -u用户名 -p密码 –database 数据库名 > 文件名.sql

-- single-transaction 会将隔离级别设置成repeatable-commited
mysqldump --single-transaction -h [server] -u [username] -p[password] [db_name] > 文件名.sql
```

* 示例

```mysql
mysqldump -h localhost  -P 3306 -u root -pmJ1314521@! typecho > /candy_backup/typecho.sql

-- 指定具体某张表进行备份
mysqldump -h localhost  -P 3306 -u root -pmJ1314521@! mysql user > /candy_backup/mysql_user.sql
```

## 数据库恢复

* 语法

```mysql
mysql -h [server] -u [username] -p[password] [db_name] < nextcloud-sqlbkp.bak
```

# 系统指令或其他命令

## mysql现在已提供什么存储引擎

```mysql
show engines;
```

## mysql当前默认的存储引擎:

```mysql
show variables like '%storage_engine%';
```

