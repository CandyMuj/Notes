# 查看当前的时区
> show variables like '%time_zone%';

# 查询当前时区所对应的时间
> select now();

# 查询当前时间与UTC时间相差多少小时
> select timediff(now(),UTC_TIMESTAMP);

# 查询MySQL当前的时区，全局和会话
> SELECT @@global.time_zone,@@session.time_zone ;

# 设置当前会话的时区为UTC时区（在重启数据库后将失效）
> set time_zone = '+0:00';
> set global time_zone = '+0:00';
> flush privileges;

# 如果要设置永久不过期的话，需要修改MySQL的配置文件，具体方式百度，然后再补充到这里来
