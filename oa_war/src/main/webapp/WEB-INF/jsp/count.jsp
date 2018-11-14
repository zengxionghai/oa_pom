<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/1
  Time: 18:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen"/>
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css"
          media="screen"/>
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css"
          media="screen"/>

    <!--                       Javascripts                       -->
    <!-- jQuery -->
    <script type="text/javascript"
            src="resources/scripts/jquery-1.8.3.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>

    <!-- echarts插件引入 -->
    <script type="text/javascript" src="resources/widget/echarts/echarts.min.js"></script>

</head>
<body>

<!-- 部门人数统计 -->

<button class="mybutton" onclick="numCount()">柱状显示部门人数</button>
<br/>
<button class="mybutton" onclick="sexCount()">柱状显示部门性别</button>
<br/>
<button class="mybutton" onclick="numCount1()">饼状显示部门人数</button>
<br/>
<button class="mybutton" onclick="sexCount1()">饼状显示部门性别</button>
<br/>
<a href="exc/depin">测试</a>
<div>
    <div id="z_id" style="width: 700px;height:300px;"></div>
    <div id="b_id" style="width: 700px;height:300px;"></div>
</div>


<script type="text/javascript">

    /*柱状显示部门人数*/
    function numCount() {
        var myChart = echarts.init(document.getElementById('z_id'));
        var names = [];
        var nums = [];

        $.ajax({
            type: "post",
            async: true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url: "dep/numcount",
            data: {},
            dataType: "json",        //返回数据形式为json
            success: function (result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result) {
                    for (var i = 0; i < result.length; i++) {
                        names.push(result[i].name);
                        nums.push(result[i].count);
                    }
                    myChart.setOption({
                        title: {
                            text: '部门性别统计'
                        },
                        tooltip: {},
                        legend: {
                            data: ['人数']
                        },
                        xAxis: {

                            data: names
                        },
                        yAxis: {},
                        series: [{
                            name: '人数',
                            type: 'bar',
                            data: nums
                        }]
                    });

                }

            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        })
    }

    /*柱状显示部门性别*/
    function sexCount() {
        var myChart = echarts.init(document.getElementById('z_id'));
        var names = [];
        var nums = [];

        $.ajax({
            type: "post",
            async: true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url: "emp/sexcount",
            data: {},
            dataType: "json",        //返回数据形式为json
            success: function (result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result) {
                    for (var i = 0; i < result.length; i++) {
                        names.push(result[i].sex);
                        nums.push(result[i].count);
                    }
                    myChart.setOption({
                        title: {
                            text: '部门性别统计'
                        },
                        tooltip: {},
                        legend: {
                            data: ['人数']
                        },
                        xAxis: {

                            data: names
                        },
                        yAxis: {},
                        series: [{
                            name: '人数',
                            type: 'bar',
                            data: nums
                        }]
                    });

                }

            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        })
    }

    /*饼状显示部门人数*/
    function numCount1() {
        var myChart = echarts.init(document.getElementById('b_id'));
        var names = [];
        var num = []
        $.ajax({
            type: "post",
            async: true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url: "dep/numcount",
            data: {},
            dataType: "json",        //返回数据形式为json
            success: function (result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result) {
                    for (var i = 0; i < result.length; i++) {
                        names.push(result[i].name);
                        num.push({name: result[i].name, value: result[i].count});
                    }
                    myChart.setOption({
                        title: {
                            text: '部门人数统计',
                            subtext: '数据支持',
                            x: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            left: 'left',
                            data: names
                        },
                        series: [
                            {
                                name: '访问来源',
                                type: 'pie',
                                radius: '55%',
                                center: ['50%', '60%'],
                                data: num,
                                itemStyle: {
                                    emphasis: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                }
                            }
                        ]
                    })
                }
            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        })
    }

    /*饼状显示部门性别*/
    function sexCount1() {
        var myChart = echarts.init(document.getElementById('b_id'));
        var names = [];
        var num = []
        $.ajax({
            type: "post",
            async: true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url: "emp/sexcount",
            data: {},
            dataType: "json",        //返回数据形式为json
            success: function (result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result) {
                    for (var i = 0; i < result.length; i++) {
                        names.push(result[i].sex);
                        num.push({name: result[i].sex, value: result[i].count});
                    }
                    myChart.setOption({
                        title: {
                            text: '部门性别统计',
                            subtext: '数据支持',
                            x: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            left: 'left',
                            data: names
                        },
                        series: [
                            {
                                name: '访问来源',
                                type: 'pie',
                                radius: '55%',
                                center: ['50%', '60%'],
                                data: num,
                                itemStyle: {
                                    emphasis: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                }
                            }
                        ]
                    })
                }
            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        })
    }

</script>


</body>
</html>
