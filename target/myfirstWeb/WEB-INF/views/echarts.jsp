<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head id="Head1" runat="server">
    <title>出餐时间概率分布</title>
    <script src="../../js/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="../../js/esl.js" type="text/javascript"></script>
    <!-- ECharts单文件引入 -->
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
</head>

<body>
<!--定义页面图表容器-->
<!-- 必须制定容器的大小（height、width） -->
<div id="main" style="height: 400px; border: 1px solid #ccc; padding: 10px;">
</div>
<br>
<input type="button" value="更新报表数据" onclick="GetAjaxChartData()"/>&nbsp;&nbsp;
商家:
<select id="platform_poi_id">
    <c:forEach items="${platMap}" var="m">
        <option value="${m.key}">${m.value}</option>
    </c:forEach>
</select>&nbsp;&nbsp;

<script type="text/javascript" language="javascript">

    var myChart;
    require.config({
        paths : {
            echarts:'http://echarts.baidu.com/build/dist'
        }
    });

    require(
            [
                'echarts',
                'echarts/chart/line', //按需加载图表关于线性图、折线图的部分
                'echarts/chart/bar'
            ],
            DrawEChart //异步加载的回调函数绘制图表
    );

    //创建ECharts图表方法
    function DrawEChart(ec) {
        myChart = ec.init(document.getElementById('main'));
        //定义图表options
        var options = {
            title : {
                text : "出餐时间概率分布",
                subtext : "午高峰"
            },
            tooltip : {
                trigger : 'axis'
            },
            legend : {
                data : ['PDF','P']
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
                splitArea : {
                    show : true
                },
                scale: true,
                precision: 2,
                splitNumber: 6,
                splitArea: { show: true }
            } ],
            grid : {
                width : '60%'
            },
            series : [
                {
                name : 'PDF',
                type : 'line',
                data : [ 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 ]
                },
                {
                    name : 'P',
                    type : 'line',
                    data : [ 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 ]
                }
            ]
        };
        myChart.setOption(options); //初始可选项注入myChart中
        myChart.hideLoading();
       GetAjaxChartData();
    }

    //点击按钮获取图表数据采用ajax方式
    function GetAjaxChartData() {
        //获得图表的options对象
        var options = myChart.getOption();
        //获取前台参数，指定商家id
        var platform_poi_id= document.getElementById("platform_poi_id").value;
        var platform = {
            platform_poi_id:platform_poi_id
        };
        //通过Ajax获取数据
        $.ajax({
            type: "post",
            async: false, //同步执行
            url: "/echarts/line_data",
            data : platform,
            dataType: "json", //返回数据形式为json
            success: function (result) {
                if (result) {
                    //将返回的category和series对象赋值给options对象内的category和series
                    options.xAxis[0].data = result.category;
                    options.series = result.series;
                    options.legend.data = result.legend;
                    myChart.hideLoading();
                    myChart.setOption(options);
                }
            },
            error: function (errorMsg) {
                alert("对不起,报表请求数据失败!");
            }
        });
    }
</script>
</body>
</html>