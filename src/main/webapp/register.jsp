<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <title>${ORDER_SYS_NAME}</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--
        <link rel="stylesheet" type="text/css" href="styles.css">
        -->
    <!-- Bootstrap -->
    <script src="js/jquery-3.6.0.js" type="text/javascript"></script>
    <script src="bootstrap/js/jquery-1.11.1.js"></script>
    <%--<script src="bootstrap/js/jquery-1.11.1.min.js"></script>--%>
    <%--<script type="text/javascript" src="js/ajax.js"></script>--%>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="bootstrap/css/main.css" rel="stylesheet">
<%--    <script type="text/javascript" src="js/ajax.js"></script>--%>
    <link href="layui/css/layui.css" rel="stylesheet"/>
    <script src="layui/layui.js"></script>
    <script>

        layui.use('form', function () {
            var form = layui.form;
        });
        var code =0;
        function ObtCode(send) {
            var tel = document.getElementById("tel").value;
            if (tel == null || tel.length == 0) {
                alert("请输入手机号")
            } else {
                var pattern = /^[1][3,4,5,7,8][0-9]{9}$/;
                if(pattern.test(tel)){
                    sendMassage(tel);
                   var times=60;
                   var timer=null;
                    timer=setInterval(function(){
                        times--;
                        if(times<=0){
                            send.value='发送验证码';
                            clearInterval(timer);
                            times=60;
                            send.disabled=false;
                        }else{
                            send.value=times+'秒后重试';
                            send.disabled=true;
                        }
                    },1000);
                }else{
                    alert("不合法");
                }
            }

        }

        function sendMassage(tel){
        $.ajax({
            async:false,
            type:"GET",
            url:"${pageContext.request.contextPath}/regCode?tel="+tel,
            dateType:"json",
            success:function (getCode) {
                var obj = JSON.parse(getCode);
                console.log(getCode);
                code = obj.result.code;
                console.log(code);
            }
        });
        }
     function checkPsd() {
        var userPass = document.getElementById("userPass").value.trim();
        var Surepassword = document.getElementById("Surepassword");
        if(userPass!=Surepassword.value.trim()){
            alert("密码不一致");
           Surepassword.value = "";
        }
     }
     function checkCode() {
         var newCode = document.getElementById("newCode");
         if(code!=newCode.value.trim()){
             alert("验证码错误");
             checkCode.value = "";
         }
     }

    </script>

</head>

<body class="login-body">

<div class="panel login-panel" style="position: relative;top:-100px ">
    <div style="margin: 30px;">
        <form class="layui-form" action="${pageContext.request.contextPath}/register" lay-filter="test1" method="post">

            <div class="layui-form-item">
                <h2>注册页面</h2>
            </div>
            <div class="layui-form-item" style="position: relative;left: 60px;top: -5px;">
			    <span style="font-size: 10px;">
			        已有账号?<a href="${pageContext.request.contextPath}">登录</a>
		    	</span>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px;"><i class="layui-icon layui-icon-user"
                                                                        style="font-size: 30px; color: #1E9FFF;"></i></label>
                <div class="layui-input-inline">
                    <select name="role">
                        <option value="3">请选择职位</option>
                        <option value="1" disabled="">管理员</option>
                        <option value="2">厨师</option>
                        <option value="3">服务员</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">

                <label class="layui-form-label" style="width: 90px;"><i class="layui-icon layui-icon-username"
                                                                        style="font-size: 30px; color: #1E9FFF;"></i></label>
                <div class="layui-input-inline">
                    <input type="text" name="userAccount" required lay-verify="required" placeholder="请输入用户名"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px;"><i class="layui-icon layui-icon-key"
                                                                        style="font-size: 30px; color: #1E9FFF;"></i></label>
                <div class="layui-input-inline">
                    <input type="password" name="userPass" id="userPass" required lay-verify="required" placeholder="请输入密码"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px;"><i class="layui-icon layui-icon-key"
                                                                        style="font-size: 30px; color: #1E9FFF;"></i></label>
                <div class="layui-input-inline">
                    <input type="password" name="Surepassword" id="Surepassword" required lay-verify="required" placeholder="请输入密码"
                           autocomplete="off" class="layui-input" onblur="checkPsd()">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px;"><i class="layui-icon layui-icon-cellphone"
                                                                        style="font-size: 30px; color: #1E9FFF;"></i></label>
                <div class="layui-input-inline">
                    <input type="tel" id="tel" name="tel" required lay-verify="required" placeholder="请输入手机号"
                           autocomplete="off" class="layui-input" value="">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px;"><i class="layui-icon layui-icon-vercode"
                                                                        style="font-size: 30px; color: #1E9FFF;"></i></label>
                <input type="button" onclick="ObtCode(this)" class="layui-btn" value="发送验证码"
                       style="width: 100px;position: relative;left: -75px; "/>
                <div class="layui-input-inline">
                    <input type="text" name="username" required lay-verify="required" placeholder="请输入验证码"
                           autocomplete="off" class="layui-input"  id="newCode" onblur="checkCode()"
                           style="position: relative;left: 100;top: -38px; width: 100px;">
                </div>
            </div>
            <div class="layui-form-item" style="position: relative;left:-50px; top: -30px;">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">注册</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="bootstrap/js/jquery-1.11.1.min.js"></script>
<script src="bootstrap/js/bootstrap.js"></script>
</body>
</html>
