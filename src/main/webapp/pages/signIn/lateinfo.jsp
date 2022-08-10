<%--
  Created by IntelliJ IDEA.
  User: 大眼怪
  Date: 2022/8/6
  Time: 9:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>迟到</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.7.5/css/layui.css">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.7.5/layui.js"></script>
    <script src='http://libs.baidu.com/jquery/1.10.2/jquery.min.js'></script>
</head>
<body>
<div class="layui-form-item">
    <div class="layui-input-block">
        <form class="layui-form">
            <div class="layui-form-item" }>
                <br><br><br>
                <label class="layui-form-label">迟到原因:</label>
                <div class="layui-input-block" style="width: 250px">
                    <input type="textbox" id="lateresult" name='' required
                           autocomplete="off" class="layui-input">
                </div>
                <br>
                <div class="layui-form-item">
                    <div class="layui-input-block" style="width: 400px">
                        <button class="layui-btn" type="button" id="latego">确定</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


<script type="text/javascript">

    $('#latego').on('click', function () {
        var remark = document.getElementById('lateresult').value;
        $.ajax({
            url: '${pageContext.request.contextPath}/punch_clock/late.do',
            type: 'POST',
            dataType: 'json',
            data: {
                remark: remark,
            },
            success: function (result) {
                if (result > 0) {
                    layer.confirm("迟到原因填写成功!", {
                        btn: ['确定']
                    }, function () {
                        window.parent.location.reload();
                    })

                }
            },
            error: function (XMLHttpRequest) {
                console.log('XMLHttpRequest:');
                console.log(XMLHttpRequest);
                alert('网络异常！尝试刷新网页解决问题');
            }
        })
    })
</script>
</body>
</html>
