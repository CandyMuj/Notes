# 样式设置  
> CSS参考手册：http://www.divcss5.com/shouce/  

### css字体加粗  
> CSS基础必学列表：http://www.divcss5.com/rumen/r122.shtml

```
font-weight参数：

normal : 正常的字体。相当于number为400。声明此值将取消之前任何设置
bold : 粗体。相当于number为700。也相当于b对象的作用
bolder : IE5+　特粗体
lighter : IE5+　细体
number : IE5+　100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
```


# 选择器

### table - 用css指定第N个td的样式
> 引用自：http://bbs.csdn.net/topics/360219622#new_post

```html
td:nth-child(N){ }
以每一个tr（行）为参照
如：
    <table>
        <tr>
         	<td >
         		<font  size="3" ></font>
         	</td>
         	<td >
         		<font  size="3" ></font>
         	</td>
        </tr>
        <tr>
         	<td >
         		<font  size="3" ></font>
         	</td>
         	<td >
         		<font  size="3" ></font>
         	</td>
        </tr>
    </table>
-- td:nth-child(1){}
    指的就是每一个tr下的第一个td，并不是，所有的td从1到结束
```
