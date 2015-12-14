<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head id="Head1" runat="server">
    <title>点击按钮通过ajax同步获取数据并渲染图表示例</title>
    <script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="js/esl.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
</head>

<body>
<!--定义页面图表容器-->
<!-- 必须制定容器的大小（height、width） -->
<div id="main" style="height: 400px; border: 1px solid #ccc; padding: 10px;">
</div>
<br>
<%
    List<String> list=new ArrayList<String>();
    list.add("12131");
    list.add("211");
    list.add("4432");
    request.setAttribute("list",list);
%>
<input type="button" value="更新报表数据" onclick="GetAjaxChartData()"/>&nbsp;&nbsp;
<%--商家Id:<input type="text" name="platform_poi_id"/>--%>
商家Id:
<select name="poi" id="poi">
    <c:forEach items="${list}" var="platform_poi_id">
        <option>${platform_poi_id}</option>
    </c:forEach>
</select>

<script type="text/javascript" language="javascript">

    var myChart;
    require.config({
        paths : {
            echarts: 'http://echarts.baidu.com/build/dist'
        }
    });
    require(
            [
                'echarts',
                'echarts/chart/line' //按需加载图表关于线性图、折线图的部分
            ],
            DrawEChart //异步加载的回调函数绘制图表
    );

    //创建ECharts图表方法
    function DrawEChart(ec) {
        //--- 折柱 ---
        myChart = ec.init(document.getElementById('main'));

        //定义图表options
        var options = {
            title : {
                text : "出餐时间概率分布",
                subtext : "纯属虚构",
                sublink : "http://www.baidu.com"
            },
            tooltip : {
                trigger : 'axis'
            },
            legend : {
                data : ['PDF']
            },
            toolbox : {
                show : true,
                feature : {
                    mark : {
                        show : true
                    },
                    dataView : {
                        show : true,
                        readOnly : false
                    },
                    magicType : {
                        show : true,
                        type : [ 'line', 'bar' ]
                    },
                    restore : {
                        show : true
                    },
                    saveAsImage : {
                        show : true
                    }
                }
            },
            calculable : true,
            xAxis : [ {
                type : 'category',
                boundaryGap : false,
                data : [ '1', '2', '3', '4', '5', '6', '7' ]
            } ],
            yAxis : [ {
                type : 'value',
                axisLabel : {
                    formatter : '{value}'
                },
                splitArea : {
                    show : true
                }
            } ],
            grid : {
                width : '90%'
            },
            series : [
                {
                name : 'PDF',
                type : 'line',
                data : [ 11, 22, 33, 44, 55, 33, 44 ]
                }
            ]
        };
        myChart.setOption(options); //先把可选项注入myChart中
        myChart.hideLoading();
       // GetAjaxChartData();//ajax后台交互
    }

    ///点击按钮获取图表数据采用ajax方式
    function GetAjaxChartData() {
        //获得图表的options对象
        var options = myChart.getOption();
        //通过Ajax获取数据
        $.ajax({
            type: "post",
            async: false, //同步执行
            url: "/echarts/line_data",
            data : {},
            dataType: "json", //返回数据形式为json
            success: function (result) {
                if (result) {
//                    alert(result);
                    //将返回的category和series对象赋值给options对象内的category和series
                    //因为xAxis是一个数组 这里需要是xAxis[i]的形式
                    options.xAxis[0].data = result.category;
                    options.series = result.series;
                    options.legend.data = result.legend;
                    myChart.hideLoading();
                    myChart.setOption(options);
                }
            },
            error: function (errorMsg) {
                alert("对不起,图表请求数据失败啦!");
            }
        });
    }
</script>
</body>
</html>