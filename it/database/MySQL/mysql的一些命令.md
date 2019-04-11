# 创建用户 和 授权

> 具体参数可参考：https://www.cnblogs.com/sos-blue/p/6852945.html

```sql
-- 第一步 创建用户
CREATE USER 'test'@'%' IDENTIFIED BY 'xxxxx';
-- 第二步 授权
grant select on *.* to 'test'@'%';
```
