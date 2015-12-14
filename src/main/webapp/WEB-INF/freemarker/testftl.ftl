<html>
<head>
    <title>测试FTL标签使用</title>
    <script type="text/javascript" src="/js/validationForm.js"></script>
</head>

<body>
<#--ftl通用插值测试-->
<#--
 FreeMarker的插值有如下两种类型
     1、通用插值：${expr}
     2、数字格式化插值：#{expr}或者#{expr;format}

    通用插值，有可以分为四种情况
    a、插值结果为字符串值：直接输出表达式结果
    b、插值结果为数字值：根据默认格式(#setting 指令设置)将表达式结果转换成文本输出。
       可以使用内建的字符串函数格式单个插值，例如
-->
<#--<#setting number_format="currency"/>-->
<#assign answer=42/>
${answer}<br>
${answer?string} <br><#-- the same as ${answer} -->
${answer?string.number}<br>
${answer?string.currency}<br>
${answer?string.percent}<br>
${answer}

<br>
<----------------------------------->
<br>
<#--
    c、输出值为日期值：根据默认格式(由 #setting 指令设置)将表达式结果转换成文本输出，
       可以使用内建的字符串函数格式化单个插值，例如
-->
<#assign lastUpdated = "2009-01-07 15:05"?datetime("yyyy-MM-dd HH:mm") />
${lastUpdated?string("yyyy-MM-dd HH:mm:ss zzzz")};<br>
${lastUpdated?string("EEE,MMM d,yy")};<br>
${lastUpdated?string("EEEE,MMMM dd,yyyy,hh:mm:ss a '('zzz')'")};<br>
${lastUpdated?string.short};<br>
${lastUpdated?string.long};<br>
${lastUpdated?string.full};<br>

<----------------------------------->
<br>

<#--d、插值结果为布尔值-->
<#assign foo=true />
${foo?string("yes","no")}
<br>
<----------------------------------->
<br>

<#--
    数字格式化插值
    数字格式化插值可采用#{expr;format}的形式来格式化数字，其中format可以是：
    mX:小数部分最小X位
    MX:小数部分最大X位
    例如：
-->
<#assign x = 2.582 />
<#assign y =4 />
#{x;M2}<br>
#{y;M2}<br>
#{x;m1}<br>
#{y;m1}<br>
#{x;m1M2}<br>
#{y;m1M2}<br>
<----------------------------------->
<br>

<#--
3, 表达式

表达式是FreeMarker模板的核心功能,表达式放置在插值语法${}之中时,表明需要输出表达式的值;
表达式语法也可与FreeMarker 标签结合,用于控制输出.
实际上FreeMarker的表达式功能非常强大,它不仅支持直接指定值,输出变量值,也支持字符串格式化输出和集合访问等功能.
-->

<#--
3.1 直接指定值

使用直接指定值语法让FreeMarker直接输出插值中的值,而不是输出变量值.
直接指定值可以是字符串,数值,布尔值,集合和MAP对象.
-->
<#--
1,字符串
直接指定字符串值使用单引号或双引号限定,如果字符串值中包含特殊字符需要转义,看下面的例子:
-->
${"我的文件保存在C:\\盘"}<br>
${'我名字是\"annlee\"'}<br>
<#--
FreeMarker支持如下转义字符:
\";双引号(u0022)
\';单引号(u0027)
\\;反斜杠(u005C)
\n;换行(u000A)
\r;回车(u000D)
\t;Tab(u0009)
\b;退格键(u0008)
\f;Form feed(u000C)
\l;<
\g;>
\a;&
\{;{
\xCode;直接通过4位的16进制数来指定Unicode码,输出该unicode码对应的字符.

如果某段文本中包含大量的特殊符号,FreeMarker提供了另一种特殊格式:可以在指定字符串内容的引号前增加r标记,在r标记后的文件将会直接输出.看如下代码:
-->

${r"${foo}"}<br>
${r"C:\foo\bar"}<br>

<#--
2,数值
表达式中的数值直接输出,不需要引号.小数点使用"."分隔,不能使用分组","符号.FreeMarker目前还不支持科学计数法,所以"1E3"是错误的.在FreeMarker表达式中使用数值需要注意以下几点:
1,数值不能省略小数点前面的0,所以".5"是错误的写法
2,数值8 , +8 , 8.00都是相同的

3,布尔值
直接使用true和false,不使用引号.
-->

<#--
4,集合
集合以方括号包括,各集合元素之间以英文逗号","分隔,看如下的例子:
-->
<#list ["星期一","星期二","星期三","星期四","星期五","星期六","星期天"] as x>
    ${x}<br>
</#list>

<br>
<#list [2+2,1.0,"whatnot"] as y>
    ${y}<br>
</#list>

<#--
5,Map对象
Map对象使用花括号包括,Map中的key-value对之间以英文冒号":"分隔,多组key-value对之间以英文逗号","分隔.下面是一个例子:
-->

<#assign map={"语文":78,"数学":87,"Java":90}>
<#list map ? keys as z>
    ${z}---->${map[z]}<br>
</#list>
<br>

<#--
3.6 算术运算符

FreeMarker表达式中完全支持算术运算,FreeMarker支持的算术运算符包括:+, - , * , / , % 看如下的代码:
-->
<#assign x=5>
${x*x-100}<br>
${x/2}<br>
${12%10}<br>

<#--
在表达式中使用算术运算符时要注意以下几点:
1,运算符两边的运算数字必须是数字
2,使用+运算符时,如果一边是数字,一边是字符串,就会自动将数字转换为字符串再连接,如:${3 + "5"},结果是:35

使用内建的int函数可对数值取整,如:
-->
<#assign x=5>
${ (x/2)?int }
${ 1.1?int }
${ 1.999?int }
${ -1.1?int }
${ -1.999?int }

<br><br>
<#--
3.7 比较运算符

表达式中支持的比较运算符有如下几个:
1,=或者==:判断两个值是否相等.
2,!=:判断两个值是否不等.
3,>或者gt:判断左边值是否大于右边值
4,>=或者gte:判断左边值是否大于等于右边值
5,<或者lt:判断左边值是否小于右边值
6,<=或者lte:判断左边值是否小于等于右边值

注意:=和!=可以用于字符串,数值和日期来比较是否相等,但=和!=两边必须是相同类型的值,否则会产生错误,
而且FreeMarker是精确比较,"x","x ","X"是不等的.其它的运行符可以作用于数字和日期,
但不能作用于字符串,大部分的时候,使用gt等字母运算符代替>会有更好的效果,
因为 FreeMarker会把>解释成FTL标签的结束字符,
当然,也可以使用括号来避免这种情况,如:<#if (x>y)>
-->

<#--
3.8 逻辑运算符

逻辑运算符有如下几个:
逻辑与:&&
逻辑或:||
逻辑非:!
逻辑运算符只能作用于布尔值,否则将产生错误
-->

<#--
3.9 内建函数
FreeMarker还提供了一些内建函数来转换输出,可以在任何变量后紧跟?,?后紧跟内建函数,就可以通过内建函数来轮换输出变量.下面是常用的内建的字符串函数:
html:对字符串进行HTML编码
cap_first:使字符串第一个字母大写
lower_case:将字符串转换成小写
upper_case:将字符串转换成大写
trim:去掉字符串前后的空白字符

下面是集合的常用内建函数
size:获取序列中元素的个数

下面是数字值的常用内建函数
int:取得数字的整数部分,结果带符号

例如:
-->
<#assign test="Tom & Jerry">
${test?html}<br>
${test?upper_case?html}<br>

<#--
3.10 空值处理运算符

FreeMarker对空值的处理非常严格,FreeMarker的变量必须有值,没有被赋值的变量就会抛出异常,因为FreeMarker未赋值的变量强制出错可以杜绝很多潜在的错误,
如缺失潜在的变量命名,或者其他变量错误.这里所说的空值,实际上也包括那些并不存在的变量,对于一个Java的 null值而言,
我们认为这个变量是存在的,只是它的值为null,但对于FreeMarker模板而言,它无法理解null值,null值和不存在的变量完全相同.

为了处理缺失变量,FreeMarker提供了两个运算符:
!:指定缺失变量的默认值
??:判断某个变量是否存在

其中,!运算符的用法有如下两种:
variable!或variable!defaultValue,第一种用法不给缺失的变量指定默认值,表明默认值是空字符串,长度为0的集合,或者长度为0的Map对象.

使用!指定默认值时,并不要求默认值的类型和变量类型相同.使用??运算符非常简单,它总是返回一个布尔值,用法为:variable??,
如果该变量存在,返回true,否则返回false
-->

<#--
3.11 运算符的优先级

FreeMarker中的运算符优先级如下(由高到低排列):
1,一元运算符:!
2,内建函数:?
3,乘除法:*, / , %
4,加减法:- , +
5,比较:> , < , >= , <= (lt , lte , gt , gte)
6,相等:== , = , !=
7,逻辑与:&&
8,逻辑或:||
9,数字范围:..

实际上,我们在开发过程中应该使用括号来严格区分,这样的可读性好,出错少
-->
<#--
4 FreeMarker的常用指令

FreeMarker的FTL指令也是模板的重要组成部分,这些指令可实现对数据模型所包含数据的抚今迭代,分支控制.
除此之外,还有一些重要的功能,也是通过FTL指令来实现的.

4.1 if指令

这是一个典型的分支控制指令,该指令的作用完全类似于Java语言中的if,if指令的语法格式如下:
<#if condition>...
<#elseif condition>...
<#elseif condition>...
<#else> ...
</#if>

例子如下:
-->
<#assign age=15>
<#if age gt 60>
    老年人
<#elseif age gt 40>
    中年人
<#elseif age gt 20>
    年轻人
<#else >
    少年
</#if>
<br>
<#--
4.2 switch , case , default , break指令

这些指令显然是分支指令,作用类似于Java的switch语句,switch指令的语法结构如下:
<#switch value>
<#case refValue>...<#break>
<#case refValue>...<#break>
<#default>...
</#switch>
-->
<#assign x=1>
<#switch x>
    <#case 1>
            小米
    <#break >
    <#case 2>
            华为
    <#break >
    <#case 3>
            魅族
    <#break >
    <#default>
            apple
</#switch>
<br>
<#--
4.3 list, break指令

list指令是一个迭代输出指令,用于迭代输出数据模型中的集合,list指令的语法格式如下:
<#list sequence as item>
...
</#list>
上面的语法格式中,sequence就是一个集合对象,也可以是一个表达式,但该表达式将返回一个集合对象,
而item是一个任意的名字,就是被迭代输出的集合元素.此外,迭代集合对象时,还包含两个特殊的循环变量:
item_index:当前变量的索引值
item_has_next:是否存在下一个对象
也可以使用<#break>指令跳出迭代

例子如下:
-->
<br>
<#list ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期天"] as x>
${x_index + 1}.${x}
    <#if x="星期四">
        <#break >
    </#if>
    <#if x_has_next>
        ,
    </#if>
</#list>
<br><br>
<#--
4.4 include指令

include指令的作用类似于JSP的包含指令,用于包含指定页.include指令的语法格式如下:
<#include filename [options]>
在上面的语法格式中,两个参数的解释如下:
filename:该参数指定被包含的模板文件
options:该参数可以省略,指定包含时的选项,包含encoding和parse两个选项,其中encoding指定包含页面时所用的解码集,而parse指定被包含文件是否作为FTL文件来解析,如果省略了parse选项值,则该选项默认是true.

4.5 import指令

该指令用于导入FreeMarker模板中的所有变量,并将该变量放置在指定的Map对象中,import指令的语法格式如下:
<#import "/lib/common.ftl" as com>
上面的代码将导入/lib/common.ftl模板文件中的所有变量,交将这些变量放置在一个名为com的Map对象中.
-->
<#--
4.6 noparse指令

noparse指令指定FreeMarker不处理该指定里包含的内容,该指令的语法格式如下:
<#noparse>...</#noparse>

看如下的例子:
-->
<#noparse>
<#list books as book><br>
    <tr><td>${book.name}<td>作者:${book.author}
</#list>
</#noparse>
<br>
<#--
4.7 escape , noescape指令

escape指令导致body区的插值都会被自动加上escape表达式,但不会影响字符串内的插值,只会影响到body内出现的插值,使用escape指令的语法格式如下:
<#escape identifier as expression>...
<#noescape>...</#noescape>
</#escape>

看如下的代码:
-->
<#assign firstName="ma">
<#assign lastName="shuai">
<#assign maidenName="">
<#escape x as x?html>
First name:${firstName}<br>
Last name:${lastName}<br>
Maiden name:${maidenName}
</#escape>
<#--
上面的代码等同于:
First name:${firstName?html}
Last name:${lastName?html}
Maiden name:${maidenName?html}
-->

<#--
escape指令在解析模板时起作用而不是在运行时起作用,除此之外,escape指令也嵌套使用,子escape继承父escape的规则,如下例子:
<#escape x as x?html>
Customer Name:${customerName}
Items to ship;
<#escape x as itemCodeToNameMap[x]>
   ${itemCode1}
   ${itemCode2}
   ${itemCode3}
   ${itemCode4}
</#escape>
</#escape>
上面的代码类似于:
Customer Name:${customerName?html}
Items to ship;
${itemCodeToNameMap[itemCode1]?html}
${itemCodeToNameMap[itemCode2]?html}
${itemCodeToNameMap[itemCode3]?html}
${itemCodeToNameMap[itemCode4]?html}

对于放在escape指令中所有的插值而言,这此插值将被自动加上escape表达式,
如果需要指定escape指令中某些插值无需添加escape表达式,则应该使用noescape指令,
放在noescape指令中的插值将不会添加escape表达式.
-->
<br>
<#--
4.8 assign指令

assign指令在前面已经使用了多次,它用于为该模板页面创建或替换一个顶层变量,assign指令的用法有多种,包含创建或替换一个顶层变量,
 或者创建或替换多个变量等,它的最简单的语法如下:<#assign name=value [in namespacehash]>,这个用法用于指定一个名为name的变量,
 该变量的值为value,此外,FreeMarker允许在使用 assign指令里增加in子句,in子句用于将创建的name变量放入namespacehash命名空间中.

assign指令还有如下用法:<#assign name1=value1 name2=value2 ... nameN=valueN [in namespacehash]>,
这个语法可以同时创建或替换多个顶层变量,此外,还有一种复杂的用法,如果需要创建或替换的变量值是一个复杂的表达式,
则可以使用如下语法格式:<#assign name [in namespacehash]>capture this</#assign>,在这个语法中,
是指将assign指令的内容赋值给name变量.如下例子:
-->
<#assign x>
    <#list ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期天"] as n>
    ${n}
    <#if n="星期四">
        <#break >
    </#if>
    </#list>
</#assign>
${x}
<#--
虽然assign指定了这种复杂变量值的用法,但是我们也不要滥用这种用法,
如下例子:<#assign x>Hello ${user}!</#assign>,以上代码改为如下写法更合适:<#assign x="Hello ${user}!">
-->
<br>
<#assign seq = ["winter", "spring", "summer", "autumn"]>
<#list seq as x>
${x_index + 1}. ${x}<#if x_has_next>,</#if>
</#list>

<br>

<#--
4.9 setting指令

该指令用于设置FreeMarker的运行环境,该指令的语法格式如下:<#setting name=value>,在这个格式中,name的取值范围包含如下几个:
locale:该选项指定该模板所用的国家/语言选项
number_format:指定格式化输出数字的格式
boolean_format:指定两个布尔值的语法格式,默认值是true,false
date_format,time_format,datetime_format:指定格式化输出日期的格式
time_zone:设置格式化输出日期时所使用的时区
-->

<#setting number_format="currency"/>
<#assign mydata=32 >
${mydata}
<br>
<#assign  m=[23,45,43.3,67.56]>
<#list m as x>
    ${x}<br>
</#list>
<br>
<#--
4.10 macro , nested , return指令

macro可以用于实现自定义指令,通过使用自定义指令,可以将一段模板片段定义成一个用户指令,使用macro指令的语法格式如下:
<#macro name param1 param2 ... paramN>
...
<#nested loopvar1, loopvar2, ..., loopvarN>
...
<#return>
...
</#macro>
在上面的格式片段中,包含了如下几个部分:
name:name属性指定的是该自定义指令的名字,使用自定义指令时可以传入多个参数
paramX:该属性就是指定使用自定义指令时报参数,使用该自定义指令时,必须为这些参数传入值
nested指令:nested标签输出使用自定义指令时的中间部分
nested指令中的循环变量:这此循环变量将由macro定义部分指定,传给使用标签的模板
return指令:该指令可用于随时结束该自定义指令.

看如下的例子:
-->

<#macro book>
    javaweb
</#macro>

<@book/>

<br>
<#--带一个list参数的宏-->
<#macro book booklist>
    <#list booklist as book>
    ${book}<br>
    </#list>
</#macro>
<@book booklist=["spring","j2ee"] />

<br>
<br>
<#--
3一些常用方法或注意事项
表达式转换类
数字循环
对浮点取整数
给变量默认值
判断对象是不是null
常用格式化日期
添加全局共享变量数据模型
直接调用java对象的方法
字符串处理(内置方法)
在模板里对sequences和hashes初始化
注释标志
sequences内置方法
hashes内置方法
4 freemarker在web开发中注意事项
web中常用的几个对象
view中值的搜索顺序
在模板里ftl里使用标签
如何初始化共享变量
与webwork整合配置
5高级方法
自定义方法
自定义 Transforms
-->
字符串
<#assign Size="mdium">
<#switch Size>
    <#case "small">
    This will be processed if it is small
        <#break>
    <#case "medium">
    This will be processed if it is medium
        <#break>
    <#case "large">
    This will be processed if it is large
        <#break>
    <#default>
    This will be processed if it is neither
</#switch>

<br>
数字
<#assign x=3>
<#switch x>
    <#case 1>
        1
    <#case 2>
        2
    <#default>
        d
</#switch>
<br>
<p style="color: aqua">hello,mushroom</p>

<br>
<#assign x = "    moo  \n\n   ">
(<#compress>
1 2  3   4    5

test only
I said, test only
</#compress>)
<br>

<table>
    <tr>
        <td>Catalog Id:</td>
        <td>
            <input type="text" size="20" id="catalogId" name="catalogId"  onkeyup="sendRequest()"/>
        </td>
        <td>
            <div id="validationMessage">

            </div>
        </td>
    </tr>
</table>

</body>
</html>