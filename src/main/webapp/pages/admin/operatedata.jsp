<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>${ORDER_SYS_NAME}-餐厅管理员</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
        <link rel="stylesheet" type="text/css" href="styles.css">
        -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/dashboard.css">


    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/rome.css">


    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="bootstrap/js/jquery-1.11.1.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/ajax.js"></script>
    <script type="text/javascript" src="js/rome.js"></script>

    <!--引入echarts文件-->
    <script src="https://cdn.bootcss.com/echarts/4.2.1-rc1/echarts.min.js"></script>

    <%--为了避免刷新界面屏幕抖动，无效（后期改动）--%>
    <script type="text/css">
        html, body {
            height: 100%;
            overflow: auto;
            margin: 0;
        }

        html {
            overflow-y: scroll;
        }
    </script>

    <script type="text/javascript">

        //填充模态框数据
        function modelTest(orderId) {
            $.ajax({
                url: "${pageContext.request.contextPath}/getDishesList",
                type: "post",
                data: {
                    "orderId": orderId,
                    "state": 1
                },
                success: function (result) {
                    $("#detailTable").empty();
                    var obj = JSON.parse(result)
                    $("#tableId").text(obj.result.checkOutTable.tableId);
                    var orderBeginTime = new Date(obj.result.checkOutTable.orderBeginDate);
                    $("#orderBeginTime").text(orderBeginTime.getFullYear() + '/' + (orderBeginTime.getMonth() + 1) + '/' + orderBeginTime.getDate() + '   ' + orderBeginTime.getHours() + ':' + orderBeginTime.getMinutes() + ':' + orderBeginTime.getSeconds());
                    $("#orderEndTime").text('未知');
                    $("#userAccount").text(obj.result.checkOutTable.waiterName);
                    $("#sumPrice").text(obj.result.checkOutTable.sumMoney);
                    $.each(obj.result.checkOutTable.dishesList, function (index, item) {
                        var dishesName = $("<td></td>").append(item.dishesName);
                        var dishesPrice = $("<td></td>").append(item.dishesPrice);
                        var dishesCount = $("<td></td>").append(item.dishesCount);
                        $("<tr></tr>").append(dishesName).append("       ")
                            .append(dishesPrice).append("       ").append(dishesCount).appendTo("#detailTable")
                    });
                    $('#myModal').modal('show')
                }
            })
        }

        //订单作废
        function cancel(orderId) {
            const r = confirm("您真的要删除" + orderId + "号订单吗？");
            if (r === true) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/deleteOrder",
                    type: "GET",
                    data: {
                        "orderId": orderId,
                    },
                    success() {
                        window.location.reload();
                        setTimeout(refresh, 5000);
                        alert("删除成功");
                        return true;
                    },
                    error() {
                        alert("权限不足");
                        return false;
                    }
                });

            }
            return false;
        }

        function checkOut(orderId, sumMoney) {
            /*$.ajax({
                url: "${pageContext.request.contextPath}/adminPay",
                type: "get",
                data: {
                    orderId: orderId,
                    price: sumMoney
                }
            });*/
            window.location = "${pageContext.request.contextPath}/adminPay?orderId=" + orderId + "&price=" + sumMoney;
        }

        function createXmlDom(str) {
            if (document.all) {
                var xmlDom = new ActiveXObject("Microsoft.XMLDOM");
                xmlDom.loadXML(str);
                return xmlDom;
            } else {
                return new DOMParser().parseFromString(str, "text/xml");
            }
        }

        function begin() {
            rome(document.getElementById("bt"));
            rome(document.getElementById("et"));

        }

        function search() {
            var begin = document.getElementById("bt");
            var end = document.getElementById("et");
            xmlAjaxRequest("${pageContext.request.contextPath}/getoperatedate?bt=" + begin.value + "&et="
                + end.value + "&time=" + Math.random(), "get", true, null,
                showOrder, null, null);

        }

        function showOrder(responseXml, obj) {

            var order = responseXml.getElementsByTagName("order");
            var table = document.getElementById("orderTable");
            table.innerHTML = "";
            for (var i = 0; i < order.length; i++) {
                var attrs = order[i].childNodes;
                var tableId;
                var orderId;

                var orderEndDate;
                var sumPrice;
                var userAccount;

                for (var j = 0; j < attrs.length; j++) {
                    var attr = attrs[j];
                    if (attr.nodeName == "tableId") {
                        tableId = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "userAccount") {
                        userAccount = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "orderId") {
                        orderId = attr.childNodes[0].nodeValue;
                    }

                    if (attr.nodeName == "orderEndDate") {
                        orderEndDate = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "sumPrice") {
                        sumPrice = attr.childNodes[0].nodeValue;
                    }
                }


                var newLine = "<tr><td>" + tableId + "</td><td>" + orderEndDate
                    + "</td><td>" + userAccount + "</td><td>" + sumPrice
                    + "</td>";
                newLine += "<td>";

                newLine += "<i style='cursor: pointer; font-size: 14;'";
                newLine += "onmouseover='this.style.color=\"orange\"'";
                newLine += "onmouseout='this.style.color=\"black\"'";
                newLine += "class='icon-sitemap icon-large' onclick='getOrderDetail("
                    + orderId + ")' title='查看订单详情'></i>";

                newLine += "</td></tr>";

                table.innerHTML += newLine;
            }

        }

        function getOrderDetail(id) {
            xmlAjaxRequest("${pageContext.request.contextPath}getorderdetail?orderId=" + id + "&time="
                + Math.random(), "get", true, null, showOrderDetail, null, null);
        }

        function showOrderDetail(responseXml, obj) {

            var tableId = document.getElementById("tableId");
            var orderBeginTime = document.getElementById("orderBeginTime");
            var orderEndTime = document.getElementById("orderEndTime");
            var sumPrice = document.getElementById("sumPrice");
            var userAccount = document.getElementById("userAccount");

            var detailTable = document.getElementById("detailTable");
            detailTable.innerHTML = "";

            tableId.innerHTML = responseXml.getElementsByTagName("tableId")[0].childNodes[0].nodeValue;
            orderBeginTime.innerHTML = responseXml
                .getElementsByTagName("orderBeginDate")[0].childNodes[0].nodeValue;
            orderEndTime.innerHTML = responseXml
                .getElementsByTagName("orderEndDate")[0].childNodes[0].nodeValue;
            sumPrice.innerHTML = responseXml.getElementsByTagName("sumPrice")[0].childNodes[0].nodeValue;
            userAccount.innerHTML = responseXml.getElementsByTagName("userAccount")[0].childNodes[0].nodeValue;

            var units = responseXml.getElementsByTagName("unit");
            for (var i = 0; i < units.length; i++) {
                var unit = units[i];
                var attrs = unit.childNodes;
                var dishesName;
                var num;
                var dishesPrice;
                for (var j = 0; j < attrs.length; j++) {
                    var attr = attrs[j];
                    if (attr.nodeName == "dishesName") {
                        dishesName = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "dishesPrice") {
                        dishesPrice = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "num") {
                        num = attr.childNodes[0].nodeValue;
                    }

                }

                var newLine = "<tr>";
                newLine += "<td>" + dishesName + "</td>";
                newLine += "<td>" + dishesPrice + "</td>";
                newLine += "<td>" + num + "</td>";
                newLine += "</tr>";

                detailTable.innerHTML += newLine;

            }
            $('#myModal').modal('show');

        }
    </script>
</head>

<body style="font-family: 微软雅黑" onload="begin()">
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                    data-toggle="collapse" data-target="#navbar" aria-expanded="false"
                    aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span> <span
                    class="icon-bar"></span> <span class="icon-bar"></span> <span
                    class="icon-bar"></span>
            </button>
            <img src="img/logo.png" class="navbar-brand"/> <span
                class="navbar-brand">${ORDER_SYS_NAME}</span>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><span class="navbar-brand">餐厅管理界面</span></li>

                <li class="dropdown"><a href="#" class="dropdown-toggle"
                                        data-toggle="dropdown" role="button" aria-haspopup="true"
                                        aria-expanded="false"><img
                        src="img/faces/${USER_INFO.faceimg }" width="24" height="24"
                        class="img-circle" style="border:1px solid #FFF"/>&nbsp;&nbsp;当前用户:【${USER_INFO.userAccount
                        }】,身份为管理员 <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li style="text-align: center;padding-top: 15px"><img
                                src="img/faces/${USER_INFO.faceimg }" width="128" height="128"
                                class="img-circle"
                                style="border:1px solid #CCC;box-shadow:0 0 10px rgba(100, 100, 100, 1);margin-bottom: 20px"/>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/modifymyinfo">修改我的密码</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/toonlinewaiters">查看当前在线的厨师 </a></li>
                        <li><a href="${pageContext.request.contextPath}/toonlinekitchen">查看当前在线的点餐员</a></li>


                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/logout">退出登录</a></li>
            </ul>


            <form class="navbar-form navbar-right" method="post"
                  action="sendbord" target="formtarget">
                <input type="text" class="form-control" placeholder="公告"
                       style="width:300px" name="bord"><input
                    class="btn btn-default" type="submit" value="发送"/>
                <iframe name="formtarget" width="0" height="0" style="display: none"></iframe>
            </form>
        </div>
    </div>
</nav>


<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li class="nav-header"
                    style="font-size: 18;margin-bottom: 10px;margin-left: 10px"><i
                        class="icon-credit-card icon-large"></i>&nbsp;运营功能
                </li>
                <li><a href="toadminmain"><i
                        class="icon-money icon-large"></i>&nbsp; 顾客结账界面 <span
                        class="sr-only">(current)</span></a></li>


            </ul>
            <ul class="nav nav-sidebar">
                <li class="nav-header"
                    style="font-size: 18;margin-bottom: 10px;margin-left: 10px"><i
                        class="icon-cog icon-large"></i>&nbsp;餐厅管理
                </li>
                <li><a href="touseradmin"><i
                        class="icon-group icon-large"></i>&nbsp;员工管理</a></li>
                <li><a href="todishesadmin"><i
                        class="icon-coffee icon-large"></i>&nbsp;菜品管理</a></li>
                <li class="active"><a href="tooperatedata"><i
                        class="icon-bar-chart icon-large"></i>&nbsp;查看经营数据 </a></li>

            </ul>
        </div>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

            <ol class="breadcrumb">
                <li><a href="/OrderSys/">首页</a></li>
                <li>管理员</li>
                <li class="active">管理管理界面</li>
            </ol>

            <div class="panel panel-danger">
                <div class="panel-heading">
                    <h2 class="panel-title">搜索特定时间订单</h2>
                </div>
                <div class="panel-body" style="padding-bottom: 0px">

                    <form class="form-inline">
                        <div class="form-group">
                            <label for="exampleInputName2">开始时间：</label>
                            <input type="text" class="form-control" id="bt" name="bt">
                        </div>
                        &nbsp;&nbsp;
                        <div class="form-group">
                            <label for="exampleInputEmail2">结束时间：</label>
                            <input type="text" class="form-control" id="et" name="et">
                        </div>
                        <input type="button" class="btn btn-danger" onclick="search()"
                               value="开始搜索"/>
                    </form>

                </div>
            </div>
            <div class="panel panel-danger">
                <div class="panel-heading">
                    <h3 class="panel-title">搜索结果</h3>
                </div>
                <div class="panel-body">

                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>桌号</th>
                                <th>结账时间</th>
                                <th>服务员</th>
                                <th>总价</th>
                                <th>详情</th>
                            </tr>
                            </thead>
                            <tbody id="orderTable">
                            <c:forEach items="${msg.result.checkOutTableList.list}" var="checkOutTable">
                                <tr>
                                    <td>${checkOutTable.tableId}</td>
                                    <td>${checkOutTable.orderBeginDate}</td>
                                    <td>${checkOutTable.waiterName}</td>
                                    <td>
                                        <c:if test="${checkOutTable.sumMoney==null}">
                                            0
                                        </c:if>
                                        <c:if test="${checkOutTable.sumMoney!=null}">
                                            ${checkOutTable.sumMoney}
                                        </c:if>
                                    </td>
                                    <td>
                                        <i style="cursor: pointer; font-size: 14;"
                                           onmouseover="this.style.color='orange'"
                                           onmouseout="this.style.color='black'"
                                           class="icon-credit-card icon-large" title="确认结账"
                                           onclick="checkOut(${checkOutTable.orderId}, ${checkOutTable.sumMoney})"></i>&nbsp;&nbsp;
                                        <i style="cursor: pointer; font-size: 14;"
                                           onmouseover="this.style.color='orange'"
                                           onmouseout="this.style.color='black'"
                                           class="icon-sitemap icon-large" title="查看订单详情"
                                           onclick="modelTest(${checkOutTable.orderId})"></i> &nbsp;&nbsp;<i
                                            style="cursor: pointer; font-size: 14;"
                                            onmouseover="this.style.color='orange'"
                                            onmouseout="this.style.color='black'"
                                            class=" icon-remove-sign icon-large" title="订单作废"
                                            onclick="cancel(${checkOutTable.orderId})"></i></td>
                                </tr>
                            </c:forEach>
                            <%--<tr>
                                <td>1,001</td>
                                <td>Lorem</td>
                                <td>ipsum</td>
                                <td>dolor</td>
                                <td><i style="cursor: pointer; font-size: 14;"
                                    onmouseover="this.style.color='orange'"
                                    onmouseout="this.style.color='black'"
                                    class="icon-credit-card icon-large" title="确认结账"></i>&nbsp;&nbsp;<i
                                    style="cursor: pointer; font-size: 14;"
                                    onmouseover="this.style.color='orange'"
                                    onmouseout="this.style.color='black'"
                                    class="icon-sitemap icon-large" title="查看订单详情"
                                    onclick="$('#myModal').modal('show')"></i> &nbsp;&nbsp;<i
                                    style="cursor: pointer; font-size: 14;"
                                    onmouseover="this.style.color='orange'"
                                    onmouseout="this.style.color='black'"
                                    class=" icon-remove-sign icon-large" title="订单作废"
                                    onclick="cancel(this)"></i></td>
                            </tr>--%>
                            </tbody>
                        </table>
                        <nav>
                            <ul class="pager">
                                <c:if test="${msg.result.checkOutTableList.isFirstPage==true}">
                                    <li><a href="#" style="pointer-events: none;">上一页</a></li>
                                </c:if>
                                <c:if test="${msg.result.checkOutTableList.isFirstPage==false}">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/tooperatedata?pageNum=${msg.result.checkOutTableList.prePage}">上一页</a>
                                    </li>
                                </c:if>
                                <c:if test="${msg.result.checkOutTableList.isLastPage==true}">
                                    <li><a href="#" style="pointer-events: none;">下一页</a></li>
                                </c:if>
                                <c:if test="${msg.result.checkOutTableList.isLastPage==false}">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/tooperatedata?pageNum=${msg.result.checkOutTableList.nextPage}">下一页</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>

                </div>
            </div>

            <div
                    style="height:1px;width: 100%;background: #CCC;margin-bottom: 10px"></div>
            <footer>
                <p>&copy; ${ORDER_SYS_NAME}-中软国际ETC 2015</p>
            </footer>

        </div>
    </div>
</div>

<br>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">订单详情</h4>
            </div>
            <div class="modal-body"
                 style="background-image: url('img/body-bg.png')">


                <div class="container-fluid" style="padding: 0px 0px;">
                    <div class="row-fluid">
                        <div class="span6" style="width:30%;float:left">
                            <div
                                    style="background-color: #66A;padding: 15px;margin: 1px;height:202px;color:white;">
                                <h2 style="color: white;font-weight: bold;font-family: 微软雅黑">桌号</h2>
                                <p id="tableId">101</p>

                                <p style="text-align: center;font-size: 24;margin-top: 11px ">
                                    <i class="icon-warning-sign icon-large"></i>
                                </p>
                            </div>
                        </div>
                        <div class="span6" style="width:70%;float:left">
                            <div class="row-fluid">
                                <div class="span6" style="width:50%;float:left">
                                    <div
                                            style="background-color: #CCC;padding: 15px;margin: 1px;height:100px;">
                                        <h3>开始时间</h3>
                                        <p id="orderBeginTime">2015-9-8 10：30</p>

                                    </div>

                                </div>
                                <div class="span6" style="width:50%;float:left">

                                    <div
                                            style="background-color: #CF0;padding: 15px;margin: 1px;height:100px;">
                                        <h3>结餐时间</h3>
                                        <p id="orderEndTime">2015-9-8 10：30</p>

                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span6" style="width:50%;float:left">

                                    <div
                                            style="background-color: #FA0;padding: 15px;margin: 1px;height:100px;">
                                        <h3>点餐服务员</h3>
                                        <p id="userAccount">杨强</p>

                                    </div>
                                </div>
                                <div class="span6" style="width:50%;float:left">

                                    <div
                                            style="background-color: #DAD;padding: 15px;margin: 1px;height:100px;">
                                        <h3>总价（元）</h3>
                                        <p>
                                            <span style="color:red;font-weight: bold" id="sumPrice">1000.00</span>
                                        </p>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="panel panel-danger" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">订单详情</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-striped">

                            <caption>该桌的订单详情如下</caption>
                            <thead>
                            <tr>
                                <th>菜品</th>
                                <th>单价</th>
                                <th>数量</th>
                            </tr>
                            </thead>
                            <tbody id="detailTable">
                            </tbody>
                        </table>
                    </div>
                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<div id="main" style="width: 800px;height: 300px;margin-left: 500px"></div>
<div id="pancake" style="width: 800px;height: 300px;margin-left: 500px;margin-top: 50px"></div>
</body>

<script type="text/javascript">

    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    // 绘制图表
    myChart.setOption({
        title: {
            text: '菜品分析数据柱状图'
        },
        //提示小工具
        tooltip: {},
        //如果是柱坐标图示，会存在X坐标xAxis和Y坐标yAxis
        xAxis: {
            data: []
        },
        yAxis: {},
        series: [{
            name: '销量',
            //声明此图示为柱状图
            type: 'bar',
            data: []
        }]
    });
    myChart.showLoading(); //数据加载完之前先显示一段简单的loading动画

    var names = []; //类别数组（实际用来盛放X轴坐标值）
    var nums = []; //销量数组（实际用来盛放Y坐标值）

    //使用ajax前后端进行数据交互
    $.ajax({
        type: "post",
        async: true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "${pageContext.request.contextPath}/echartsJson",
        data: {},
        dataType: "json",
        success: function (result) {
            var data = result.result.dishesList;
            console.log(data)
            $.each(data, function (index, item) {
                names.push(item.dishesName);
                nums.push(item.dishesCount);
            });
            myChart.hideLoading(); //隐藏加载动画
            myChart.setOption({ //加载数据图表
                xAxis: {
                    data: names
                },
                yAxis: {},
                series: [{
                    // 根据名字对应到相应的系列
                    name: '销量',
                    data: nums
                }]
            });
        },
        error: function () {
            //请求失败时执行该函数
            alert("图表请求数据失败!");
            myChart.hideLoading();
        }
    })
</script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myCharts = echarts.init(document.getElementById('pancake'));

    // 指定图表的配置项和数据
    var option = {
        series: [
            {
                name: '菜品分析数据饼状图',
                type: 'pie',
                radius: '70%',
                data: [],
                roseType: 'angle',
                itemStyle: {
                    normal: {
                        shadowBlur: 200,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myCharts.setOption(option);

    var dataList = [];

    $.ajax({
        type: "post",
        async: true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "${pageContext.request.contextPath}/echartsJson",
        data: {},
        dataType: "json",
        success: function (result) {
            var data = result.result.dishesList;
            console.log(data)
            $.each(data, function (index, item) {
                dataList.push({
                    name: item.dishesName,
                    value: item.dishesCount
                })
            });
            myCharts.hideLoading(); //隐藏加载动画
            myCharts.setOption({ //加载数据图表
                series: [{
                    data: dataList
                }]
            });
        },
        error: function () {
            //请求失败时执行该函数
            alert("图表请求数据失败!");
            myCharts.hideLoading();
        }
    })
</script>
</html>




