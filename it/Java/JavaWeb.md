# @Autowired和@Resource

> @Autowired与@Resource都可以用来装配bean. 都可以写在字段上,或写在setter方法上
>
> 
>
> 推荐使用 @Resource 原因：
>
> 1. 若使用idea编辑器，如果你使用autowired，那么编辑器都会给你一个提示不推荐直接使用
>
> 2. 注入方式不同；
>
>    @Resource（这个注解属于J2EE的），默认安装名称进行装配，名称可以通过name属性进行指定，如果没有指定name属性，当注解写在字段上时，默认取字段名进行安装名称查找，如果注解写在setter方法上默认取属性名进行装配。当找不到与名称匹配的bean时才按照类型进行装配。但是需要注意的是，如果name属性一旦指定，就只会按照名称进行装配。
>
>    @Autowired默认按类型装配（这个注解是属业spring的），默认情况下必须要求依赖对象必须存在，如果要允许null值，可以设置它的required属性为false，如：@Autowired(required=false) ，如果我们想使用名称装配可以结合@Qualifier注解进行使用
>
>    装配更灵活（指定名称的时候不用多写什么东西）
>
> 3. 解耦。使用@Resource可以减少耦合



# IDEA 远程debug

> [Intellij IDEA远程debug教程实战和要点总结](https://blog.csdn.net/qq_37192800/article/details/80761643)

## 服务器端开启调试模式，增加JVM启动参数，以支持远程调试

> -Xdebug  -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8089

### 各参数解释

- -Xdebug：通知JVM工作在调试模式下
- -Xrunjdwp：通知JVM使用（java debug wire protocol）来运行调试环境。参数同时有一系列的调试选项：
- <code>session</code>：指定了调试数据的传送方式，dt_socket是指用SOCKET模式，另外dt_shmem指用共享内存方式，其中dt_shmem只适用于窗口平台.server 参数是指是否支持在服务器模式的虚拟机中。
- onthrow：指明当产生该类型的异常时，JVM就会中断下来，进行调式该参数任选。
- <code>release</code>：指明当JVM被中断下来时，执行的可执行程序该参数可选
- <code>suspend</code><：指明：是否在调试客户端建立起来后，再执行 JVM。
- onuncaught（= y或n）指明出现未捕获的异常后，是否中断JVM的执行。



## 本机Intellij IDEA远程调试配置

> 1，打开Inteliij IDEA，顶部菜单栏选择Run-> Edit Configurations，进入下图的运行/调试配置界面。
>
> 2，点击左上角'+'号，选择Remote。分别填写右侧三个红框中的参数：Name，Host（想要指定的远程调试端口）。
>
> 3，点击界面右下角应用按钮即可。

![img](JavaWeb.assets/2018062115152934)



##  Intellij IDEA 启动远程调用

> 最后，打开IDEA，程序上打上断点，运行模式选远程，点击运行。调用服务器端运行的系统程序，系统自动进入断点

![img](JavaWeb.assets/20180621152105552)

![img](JavaWeb.assets/20180621152116752)