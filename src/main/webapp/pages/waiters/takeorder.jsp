<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.7.5/css/layui.css">

    <link rel="stylesheet" href="css/font-awesome.min.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="bootstrap/js/jquery-1.11.1.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.7.5/layui.js"></script>

    <script type="text/javascript" src="js/ajax.js"></script>
    <script type="text/javascript">
        function begin() {
            getDishesList(1);
            txtAjaxRequest("getrtdishes?messageTitle=rtdishes&time="
                + Math.random(), "get", true, null, dishesCallback, null, null);
            txtAjaxRequest("getrtbord?messageTitle=rtbord&time="
                + Math.random(), "get", true, null, bordCallback, null, null);
        }

        function bordCallback(responseTxt, obj) {
            if (responseTxt != "Org_EricYang_Platform_ErrorMsg:ServerPush_Wait_TimeOut") {
                var msg = document.getElementById("msg");

                msg.innerHTML = responseTxt;

            }
            txtAjaxRequest("getrtbord?messageTitle=rtbord&time="
                + Math.random(), "get", true, null, bordCallback, null, null);

        }

        function dishesCallback(responseTxt, obj) {
            if (responseTxt != "Org_EricYang_Platform_ErrorMsg:ServerPush_Wait_TimeOut") {
                var msg = document.getElementById("msg");
                msg.innerHTML = responseTxt;

            }
            txtAjaxRequest("getrtdishes?messageTitle=rtdishes&time="
                + Math.random(), "get", true, null, dishesCallback, null, null);


        }

        function deleteDishes(id, name, obj) {

            if (confirm("您真的要删除菜品【" + name + "】吗？")) {
                xmlAjaxRequest("deletedishes?dishesId=" + id + "&time="
                    + Math.random(), "get", true, null, deleteCallback, obj,
                    null);

            }

        }

        function deleteCallback(responseTxt, obj) {

            alert("菜品删除成功！");
            obj.parentNode.parentNode.parentNode
                .removeChild(obj.parentNode.parentNode);
        }

        function getDishesList(page) {

            xmlAjaxRequest("getdishesbypage?page=" + page + "&time="
                + Math.random(), "get", true, null, showList, null, null);
        }

        function showList(responseXml, obj) {

            var maxPage = responseXml.getElementsByTagName("maxPage");
            maxPage = maxPage[0].childNodes;
            //alert(maxPage[0].nodeValue);
            var link = document.getElementById("last");
            link.href = "javascript:getDishesList(" + maxPage[0].nodeValue + ")";

            var page = responseXml.getElementsByTagName("page");
            page = page[0].childNodes;
            link = document.getElementById("next");
            link.href = "javascript:getDishesList("
                + (parseInt(page[0].nodeValue) + 1) + ")";
            link = document.getElementById("pre");
            link.href = "javascript:getDishesList("
                + (parseInt(page[0].nodeValue) - 1) + ")";
            var table = document.getElementById("dishesbord");
            table.innerHTML = "";
            var disheses = responseXml.getElementsByTagName("dishes");
            for (var i = 0; i < disheses.length; i++) {
                var dishes = disheses[i];
                var attrs = dishes.childNodes;
                var dishesId;
                var dishesName;
                var dishesDiscript;
                var dishesImg;
                var dishesTxt;
                var recommend;
                var dishesPrice;
                for (var j = 0; j < attrs.length; j++) {
                    var attr = attrs[j];
                    if (attr.nodeName == "dishesId") {
                        dishesId = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "dishesName") {
                        dishesName = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "dishesDiscript") {
                        dishesDiscript = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "dishesImg") {
                        dishesImg = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "dishesTxt") {
                        dishesTxt = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "recommend") {
                        recommend = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "dishesPrice") {
                        dishesPrice = attr.childNodes[0].nodeValue;
                    }
                }

                var subDiscript = dishesDiscript.length > 8 ? dishesDiscript
                        .substring(0, 7)
                    + "..." : dishesDiscript;
                var subRecommend = recommend == 1 ? "<span style='color: red;font-size: 12px'><i class='icon-heart '></i></span>&nbsp;"
                    : "";
                var newLine = "<div class='col-xs-6 col-sm-3 placeholder'>";
                newLine += "<a href=javascript:onclick=detail(\""
                    + dishesName
                    + "\",\""
                    + dishesDiscript
                    + "\",\""
                    + dishesTxt
                    + "\","
                    + dishesPrice
                    + ","
                    + recommend
                    + ",\""
                    + dishesImg
                    + "\")> <img class='img-thumbnail'	style='border-radius:20px;width:95%;height:200px' alt='Generic placeholder thumbnail' src='img/dishes/"
                    + dishesImg + "'></a>";
                newLine += "<h4>" + subRecommend + dishesName + "</h4>";
                newLine += "<span class='text-muted'>" + subDiscript + "</span>";
                newLine += "<div class='form-group'>";
                newLine += "<form action='addcart' target='formtarget' onsubmit='alert(\"添加成功！\")' method='post'>";
                newLine += "<div style='width:120px;margin: 0px auto'>";
                newLine += "<div class='input-group'>";
                newLine += "<span class='input-group-btn'>";
                newLine += "<button class='btn btn-default' type='button'	onclick='subtract(this)'>-</button></span> ";
                newLine += "<input type='text' class='form-control' value='1'  readonly='readonly' name='num' style='text-align: center;padding: 0px;cursor: text;'>";
                newLine += "<input type='hidden' name='dishes' value='" + dishesId + "' /> <span class='input-group-btn'>";
                newLine += "<button class='btn btn-default' type='button' onclick='add(this)'>+</button> </span> </div>";
                newLine += "</div>";
                newLine += "<p> <input type='submit' class='btn btn-danger' style='width:120px;margin-top: 5px' value='加入点餐车' /> </p> </form> </div> </div>";

                table.innerHTML += newLine;

            }

        }

        function cancel(obj) {

            if (confirm("此订单将不结账而直接作废？")) {
                obj.parentNode.parentNode.parentNode
                    .removeChild(obj.parentNode.parentNode);
            }
        }

        function detail(name, disc, txt, price, commend, img) {

            var dishesName = document.getElementById("dishesName");
            var dishesDiscript = document.getElementById("dishesDiscript");
            var dishesTxt = document.getElementById("dishesTxt");
            txt = txt.replace(/ordersysspace/g, "&nbsp;");
            txt = txt.replace(/ordersysbreak/g, "<br>");

            var dishesPrice = document.getElementById("dishesPrice");
            var recommend = document.getElementById("recommend");
            var dishesImg = document.getElementById("dishesImg");
            dishesImg.src = "img/dishes/" + img;
            dishesName.innerHTML = name;
            dishesDiscript.innerHTML = disc;
            dishesTxt.innerHTML = txt;
            dishesPrice.innerHTML = price;
            if (commend == 1) {
                recommend.innerHTML = "<i class='icon-heart icon-large'></i>&nbsp;推荐菜品";
            } else {
                recommend.innerHTML = "";
            }
            $("#myModal").modal("show");
        }

        function subtract(obj) {
            var form = obj.parentNode.parentNode.parentNode.parentNode;
            if (parseInt(form.num.value) > 1) {
                form.num.value = parseInt(form.num.value) - 1;
            }
        }

        function add(obj) {
            var form = obj.parentNode.parentNode.parentNode.parentNode;
            form.num.value = parseInt(form.num.value) + 1;

            //var child=form.
            //txt[0].value+=1;
        }

        function setTableId() {
            var id = document.getElementById("tableId");
            txtAjaxRequest("settableid?tableId=" + id.value + "&time="
                + Math.random(), "get", true, null, tableIdCallback, id, null);
        }

        function tableIdCallback(responseTxt, obj) {

            alert("桌号设置成功");
            var result = document.getElementById("tableresult");
            result.innerHTML = obj.value;

        }

        function commitOrder() {
            txtAjaxRequest("commitcart?time=" + Math.random(), "get", true,
                null, commitCallback, null, null);
        }

        function commitCallback(responseTxt, obj) {
            alert("订单提交成功，用餐愉快！");
            var tableresult = document.getElementById("tableresult");
            $("#tableId").val('');
            $("#tableresult").val('【】');
        }

        function tableFucation() {
            var flag = false;
            var pattern = /[1-9]\d*/;
            var str = document.getElementById("tableId").value;
            $("#tableId").val('');
            if (!pattern.test(str)) {
                alert("桌号不合法");
            } else {
                if (str > 0)
                    flag = true;
                else
                    alert("桌号不合法");
            }
            if (flag) {
                $.ajax({
                    async: false,
                    type: "GET",
                    url: "${pageContext.request.contextPath}/settableid?tableId=" + str
                });

                $("#tableresult").html("【" + str + "】");
            }


        }

        function getShowCart() {
            $.ajax({
                async: true,
                type: "GET",
                url: "${pageContext.request.contextPath}/cart/showCart",
                dateType: "json",
                success: function (result) {
                    console.log(result);
                    $("#detailTable").empty();
                    var obj = JSON.parse(result);
                    var sum = 0;
                    $.each(obj.result.checkOutTable, function (index, item) {
                        sum = item.sumPrice + sum;
                        var divDish = $("#detailTable");
                        var img = "<img src='${pageContext.request.contextPath}/img/dishes/" + item.dishesImg + "' style='height:40px;width:60px;'>";
                        var spanImg = $("<td></td>").append(img);
                        var spanPrice = $("<td></td>").append(item.dishesPrice);
                        var spanName = $("<td></td>").append(item.dishesName);
                        var spanNumber = $("<td></td>").append(item.num);
                        var spanSumPrice = $("<td></td>").append(item.sumPrice);
                        $("<tr align='center'></tr>").append(spanImg).append(spanPrice).append(spanName).append(spanNumber).append(spanSumPrice).appendTo(divDish);
                    });
                    var spanSum = $("<span></span>").append(sum);
                    var tdSum = $("<td colspan='5'>总计：</td>").append(spanSum);
                    $("<tr align='center'></tr>").append(tdSum).appendTo($("#detailTable"));

                }
            })
        }

        function alertDel() {
            if (confirm("确定要清空购物车吗？")) {
                return true;
            } else {
                return false;
            }
        }

        function clearCart() {
            if (alertDel()) {
                $("#detailTable").empty();
                $.ajax({
                    async: true,
                    type: "GET",
                    url: "${pageContext.request.contextPath}/cart/clearCart",
                    success: function () {
                        console.log("删除成功");
                    }

                })
            }


        }

        function showCart() {
            getShowCart();
            $("#showCart").modal("show");
        }

        function signIn(userId) {
            layer.open({
                title: '打卡',
                area: ['650px', '350px'],
                type: 2,
                offset:'t',
                content: '${pageContext.request.contextPath}/punch_clock/punchClock',//跳转controller
                cancel: function () {
                }
            });
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
            <img src="img/logo.png" class="navbar-brand"/>
            <button style="margin-top: 12px" onclick="signIn(${USER_INFO.userId})">
                签到
            </button>
            <span
                    class="navbar-brand">${ORDER_SYS_NAME}</span>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><span class="navbar-brand">点单界面：当前桌号<span id="tableresult">【】</span></span></li>

                <li class="dropdown"><a href="#" class="dropdown-toggle"
                                        data-toggle="dropdown" role="button" aria-haspopup="true"
                                        aria-expanded="false"><img src="img/faces/${USER_INFO.faceimg }"
                                                                   width="24" height="24" class="img-circle"
                                                                   style="border:1px solid #FFF"/>&nbsp;&nbsp;当前用户:【${USER_INFO.userAccount}】,身份为服务员
                    <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li style="text-align: center;padding-top: 15px"><img
                                src="img/faces/${USER_INFO.faceimg }" width="128" height="128"
                                class="img-circle"
                                style="border:1px solid #CCC;box-shadow:0 0 10px rgba(100, 100, 100, 1);margin-bottom: 20px"/>
                        </li>
                        <li><a href="modifymyinfo">修改我的密码</a></li>
                        <li role="separator" class="divider"></li>


                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/logout">退出登录</a></li>
            </ul>


            <%--<form class="navbar-form navbar-right">--%>
            <%--<input type="text" class="form-control" placeholder="设定桌号" id="tableId"><input--%>
            <%--class="btn btn-default" type="button" value="确定" onclick="setTableId()"/>--%>
            <%--</form>--%>
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="设定桌号" id="tableId" name="tableId" value=""><input
                    class="btn btn-default" type="button" value="确定" id="inputId" onclick="tableFucation()"/>
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
                        class="icon-user icon-large"></i>&nbsp;服务员点餐功能
                </li>
                <li class="active"><a href="towaitermain"><i class="icon-glass icon-large"></i>&nbsp;
                    服务点餐界面 <span class="sr-only">(current)</span></a></li>
                <li><a href="topaylist"><i
                        class="icon-credit-card icon-large"></i>&nbsp; 餐桌结账 <span
                        class="sr-only">(current)</span></a></li>


            </ul>

        </div>


        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

            <ol class="breadcrumb">
                <li><a href="/OrderSys/">首页</a></li>
                <li>服务员</li>
                <li class="active">服务员点餐界面</li>
            </ol>


            <div class="panel panel-danger">
                <div class="panel-heading">
                    <h2 class="panel-title">最新公告消息</h2>
                </div>
                <div class="panel-body" style="padding-bottom: 10px">

                    <h4>
                        <i class=" icon-envelope icon-large" style="color:orange;"></i>&nbsp;<span
                            id="msg"></span>
                    </h4>

                </div>
            </div>


            <div class="panel panel-danger">
                <div class="panel-heading">
                    <h2 class="panel-title">菜品清单</h2>
                </div>
                <div class="panel-body" style="padding-bottom: 0px">
                    <div class="row placeholders" id="dishesbord">
                        <div class="col-xs-6 col-sm-3 placeholder">
                            <a href="#"> <img class="img-thumbnail"
                                              style="border-radius:20px" alt="Generic placeholder thumbnail"
                                              src="img/dishes/1.jpg"></a>
                            <h4>鱼香肉丝</h4>
                            <span class="text-muted">色香味俱全，顾客都喜欢</span>
                            <div class="form-group">
                                <form>
                                    <div style="width:120px;margin: 0px auto">


                                        <div class="input-group">
												<span class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="subtract(this)">-</button>
												</span> <input type="text" class="form-control" value="1"
                                                               disabled="disabled" name="num"
                                                               style="text-align: center;padding: 0px;cursor: text;"><input
                                                type="hidden" name="dishes" value="6"/> <span
                                                class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="add(this)">+</button>
												</span>
                                        </div>


                                        <!-- /input-group -->
                                    </div>
                                    <p>
                                        <input type="button" class="btn btn-danger"
                                               style="width:120px;margin-top: 5px" value="加入点餐车"></input>
                                    </p>

                                </form>
                            </div>
                        </div>


                        <div class="col-xs-6 col-sm-3 placeholder">
                            <a href="#"> <img class="img-thumbnail"
                                              style="border-radius:20px" alt="Generic placeholder thumbnail"
                                              src="img/dishes/1.jpg"></a>
                            <h4>鱼香肉丝</h4>
                            <span class="text-muted">色香味俱全，顾客都喜欢</span>
                            <div class="form-group">
                                <form>
                                    <div style="width:120px;margin: 0px auto">


                                        <div class="input-group">
												<span class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="subtract(this)">-</button>
												</span> <input type="text" class="form-control" value="1"
                                                               disabled="disabled" name="num"
                                                               style="text-align: center;padding: 0px;cursor: text;"><input
                                                type="hidden" name="dishes" value="6"/> <span
                                                class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="add(this)">+</button>
												</span>
                                        </div>


                                        <!-- /input-group -->
                                    </div>
                                    <p>
                                        <input type="button" class="btn btn-danger"
                                               style="width:120px;margin-top: 5px" value="加入点餐车"></input>
                                    </p>

                                </form>
                            </div>
                        </div>


                        <div class="col-xs-6 col-sm-3 placeholder">
                            <a href="#"> <img class="img-thumbnail"
                                              style="border-radius:20px" alt="Generic placeholder thumbnail"
                                              src="img/dishes/1.jpg"></a>
                            <h4>鱼香肉丝</h4>
                            <span class="text-muted">色香味俱全，顾客都喜欢</span>
                            <div class="form-group">
                                <form>
                                    <div style="width:120px;margin: 0px auto">


                                        <div class="input-group">
												<span class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="subtract(this)">-</button>
												</span> <input type="text" class="form-control" value="1"
                                                               disabled="disabled" name="num"
                                                               style="text-align: center;padding: 0px;cursor: text;"><input
                                                type="hidden" name="dishes" value="6"/> <span
                                                class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="add(this)">+</button>
												</span>
                                        </div>


                                        <!-- /input-group -->
                                    </div>
                                    <p>
                                        <input type="button" class="btn btn-danger"
                                               style="width:120px;margin-top: 5px" value="加入点餐车"></input>
                                    </p>

                                </form>
                            </div>
                        </div>


                        <div class="col-xs-6 col-sm-3 placeholder">
                            <a href="#"> <img class="img-thumbnail"
                                              style="border-radius:20px" alt="Generic placeholder thumbnail"
                                              src="img/dishes/1.jpg"></a>
                            <h4>鱼香肉丝</h4>
                            <span class="text-muted">色香味俱全，顾客都喜欢</span>
                            <div class="form-group">
                                <form>
                                    <div style="width:120px;margin: 0px auto">


                                        <div class="input-group">
												<span class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="subtract(this)">-</button>
												</span> <input type="text" class="form-control" value="1"
                                                               disabled="disabled" name="num"
                                                               style="text-align: center;padding: 0px;cursor: text;"><input
                                                type="hidden" name="dishes" value="6"/> <span
                                                class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="add(this)">+</button>
												</span>
                                        </div>


                                        <!-- /input-group -->
                                    </div>
                                    <p>
                                        <input type="button" class="btn btn-danger"
                                               style="width:120px;margin-top: 5px" value="加入点餐车"></input>
                                    </p>

                                </form>
                            </div>
                        </div>


                        <div class="col-xs-6 col-sm-3 placeholder">
                            <a href="#"> <img class="img-thumbnail"
                                              style="border-radius:20px" alt="Generic placeholder thumbnail"
                                              src="img/dishes/1.jpg"></a>
                            <h4>鱼香肉丝</h4>
                            <span class="text-muted">色香味俱全，顾客都喜欢</span>
                            <div class="form-group">
                                <form>
                                    <div style="width:120px;margin: 0px auto">


                                        <div class="input-group">
												<span class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="subtract(this)">-</button>
												</span> <input type="text" class="form-control" value="1"
                                                               disabled="disabled" name="num"
                                                               style="text-align: center;padding: 0px;cursor: text;"><input
                                                type="hidden" name="dishes" value="6"/> <span
                                                class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="add(this)">+</button>
												</span>
                                        </div>


                                        <!-- /input-group -->
                                    </div>
                                    <p>
                                        <input type="button" class="btn btn-danger"
                                               style="width:120px;margin-top: 5px" value="加入点餐车"></input>
                                    </p>

                                </form>
                            </div>
                        </div>


                        <div class="col-xs-6 col-sm-3 placeholder">
                            <a href="#"> <img class="img-thumbnail"
                                              style="border-radius:20px" alt="Generic placeholder thumbnail"
                                              src="img/dishes/1.jpg"></a>
                            <h4>鱼香肉丝</h4>
                            <span class="text-muted">色香味俱全，顾客都喜欢</span>
                            <div class="form-group">
                                <form>
                                    <div style="width:120px;margin: 0px auto">


                                        <div class="input-group">
												<span class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="subtract(this)">-</button>
												</span> <input type="text" class="form-control" value="1"
                                                               disabled="disabled" name="num"
                                                               style="text-align: center;padding: 0px;cursor: text;"><input
                                                type="hidden" name="dishes" value="6"/> <span
                                                class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="add(this)">+</button>
												</span>
                                        </div>


                                        <!-- /input-group -->
                                    </div>
                                    <p>
                                        <input type="button" class="btn btn-danger"
                                               style="width:120px;margin-top: 5px" value="加入点餐车"></input>
                                    </p>

                                </form>
                            </div>
                        </div>


                        <div class="col-xs-6 col-sm-3 placeholder">
                            <a href="#"> <img class="img-thumbnail"
                                              style="border-radius:20px" alt="Generic placeholder thumbnail"
                                              src="img/dishes/1.jpg"></a>
                            <h4>鱼香肉丝</h4>
                            <span class="text-muted">色香味俱全，顾客都喜欢</span>
                            <div class="form-group">
                                <form>
                                    <div style="width:120px;margin: 0px auto">


                                        <div class="input-group">
												<span class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="subtract(this)">-</button>
												</span> <input type="text" class="form-control" value="1"
                                                               disabled="disabled" name="num"
                                                               style="text-align: center;padding: 0px;cursor: text;"><input
                                                type="hidden" name="dishes" value="6"/> <span
                                                class="input-group-btn">
													<button class="btn btn-default" type="button"
                                                            onclick="add(this)">+</button>
												</span>
                                        </div>


                                        <!-- /input-group -->
                                    </div>
                                    <p>
                                        <input type="button" class="btn btn-danger"
                                               style="width:120px;margin-top: 5px" value="加入点餐车"></input>
                                    </p>

                                </form>
                            </div>
                        </div>


                    </div>

                    <nav>
                        <ul class="pager">
                            <li><a href="javascript:getDishesList(1)">&larr;首页</a></li>
                            <li><a href="#" id="pre">上一页</a></li>
                            <li><a href="#" id="next">下一页</a></li>
                            <li><a href="#" id="last">末页&rarr;</a></li>
                        </ul>
                    </nav>

                    <div style="text-align: center;">

                        <a href="javascript:commitOrder()" class="btn btn-danger"
                           style="width: 40%;margin-bottom: 15px;font-size: 18px;font-weight: bold;">确认订单</a>
                        <a href="javascript:onclick=showCart()" class="btn btn-danger"
                           style="width: 65px ;margin-bottom:15px;">购物车</a>
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
                <h4 class="modal-title" id="myModalLabel">详细信息</h4>
            </div>
            <div class="modal-body"
                 style="background-image: url('img/body-bg.png')">


                <div class="panel panel-danger" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">菜品详情</h3>
                    </div>
                    <div class="panel-body">

                        <div style="text-align: center;">
                            <img src="img/faces/default.jpg" id="dishesImg" width="200px"
                                 height="200px" class="img-circle"
                                 style="border:1px solid #CCC;box-shadow:0 0 10px rgba(100, 100, 100, 1);"/>
                        </div>
                        <p>
                        <h2 style="text-align: center;">
                            菜品名称： <span id="dishesName"></span>
                        </h2>
                        <h3 style="text-align: center;">
                            <span style="color: red;font-weight: bold;" id="recommend"></span>
                        </h3>

                        <hr/>

                        <p>
                        <h3>菜品简介：</h3>
                        <p>
                            <span id="dishesDiscript"></span>
                        </p>

                        <p>
                        <h3>菜品描述：</h3>

                        <p>
                            <span id="dishesTxt"></span>
                        </p>
                        <h3>
                            菜品价格：<span id="dishesPrice"> </span> (元)
                        </h3>


                    </div>


                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>

            </div>

            <iframe name="formtarget" width="0" height="0" style="display: none"></iframe>
        </div>
    </div>
</div>
<%--mymodel--%>
<div class="modal fade" id="showCart" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">详细信息</h4>
            </div>
            <div class="modal-body"
                 style="background-image: url('img/body-bg.png')">
                <div class="panel panel-danger" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">菜品详情</h3>
                    </div>
                    <div class="panel-body">
                        <table id="divhead" width="500px">
                            <thead>
                            <tr align="center">
                                <td>图片</td>
                                <td>单价</td>
                                <td>菜名</td>
                                <td>数量</td>
                                <td>小计</td>
                            </tr>
                            </thead>
                            <tbody id="detailTable">

                            </tbody>
                        </table>

                    </div>

                </div>
                <h4 align="center">
                    <input type="button" value="清空购物车" onclick="clearCart()">
                </h4>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>

            </div>

            <iframe name="formtarget" width="0" height="0" style="display: none"></iframe>
        </div>
    </div>
</div>

</body>
</html>
