<%--
  Created by IntelliJ IDEA.
  User: 大眼怪
  Date: 2022/7/28
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单信息</title>
    <%--引入layui css--%>
    <%--<link rel="stylesheet" href="/layui/css/layui.css">--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.7.5/css/layui.css">
</head>
<body>
<%--引入layui js--%>
<%--<script type="text/javascript">
    var obj = JSON.parse(${query})
    alert(obj.alipay_trade_query_response.total_amount)
</script>--%>
<%--<script src="/layui/layui.js"></script>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.7.5/layui.js"></script>
<script>
    function orderInfo() {
        layer.open({
            type: 2 //Page层类型
            , area: ['350px', '500px']
            , title: false
            , shade: 0.6 //遮罩透明度
            , maxmin: true //允许全屏最小化
            , anim: 0 //0-6的动画形式，-1不开启
            , content: '/pages/admin/showOrder.jsp'

        })
    }
</script>
<div>
    <div align="right" style="margin-right: 10px; margin-top: 10px">
        <span><i class="layui-icon layui-icon-release" style="font-size: 30px"></i></span>
        <span><i class="layui-icon layui-icon-rss" style="font-size: 30px"></i></span>
        <span><i class="layui-icon layui-icon-bluetooth" style="font-size: 30px"></i></span>
        <span><i class="layui-icon layui-icon-mute" style="font-size: 30px"></i></span>
        <span><i class="layui-icon layui-icon-email" style="font-size: 30px"></i></span>
        <span><i class="layui-icon layui-icon-console" style="font-size: 30px"></i></span>
    </div>
    <div style="font-weight: bold; font-size: 30px; margin-top: 66px; margin-left: 66px">支付详情</div>
    <div align="center" style="margin-top: 66px">
        <i class="layui-icon layui-icon-rmb" style="font-size: 150px; color: #5fb878;"></i>
        <p style="font-size: 40px; font-weight: bolder; margin-top: 35px; color: #5bb75b">
            支付成功<span id="money"></span>
        </p>
        <%--<a href="/pages/admin/showOrder.jsp" class="layui-btn layui-btn-radius layui-btn-warm" style="margin-top: 30px">打印凭条</a>--%>
        <button onclick="orderInfo();" type="button" data-method="notice"
                class="layui-btn layui-btn-radius layui-btn-warm"
                style="margin-top: 30px">打印凭条
        </button>

        <a href="/toadminmain" class="layui-btn layui-btn-radius layui-btn-normal"
           style="margin-top: 30px">返回首页</a>
        <div style="color: #FF5722; margin-top: 30px"><span id="jumpTo">10</span>秒后自动返回首页</div>
    </div>
    <div align="right" style="margin-right: 10px; margin-top: 100px">
        <span><i class="layui-icon layui-icon-login-qq" style="font-size: 30px"></i></span>
        <span><i class="layui-icon layui-icon-login-wechat" style="font-size: 30px"></i></span>
        <span><i class="layui-icon layui-icon-login-weibo" style="font-size: 30px"></i></span>
    </div>
</div>

<script type="text/javascript">
    //当页面加载完毕运行。我们这里的js写在html后面可以不用写。
    window.onload = function () {
        var obj = JSON.parse(${query});
        var money = obj.alipay_trade_query_response.total_amount;
        document.getElementById("money").innerText = money;
        //定义一个初始时间
        let timer = 10;
        //开启定时器
        setInterval(() => {
            //递减
            timer--;
            //获取我们需要改变的数字的那个标签，修改里面文本等于已经递减的timer
            document.getElementById('jumpTo').innerText = timer;
            //如果时间等于0就跳回去a页面
            if (timer == 0) {
                window.location = '/toadminmain';
            }

        }, 1000);

    };
</script>
</div>
</body>
</html>
