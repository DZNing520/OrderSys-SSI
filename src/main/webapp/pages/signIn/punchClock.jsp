<%--
  Created by IntelliJ IDEA.
  User: 大眼怪
  Date: 2022/8/5
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>打卡页面</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/layui/2.7.5/css/layui.css">
    <link href="favicon.ico" rel="shortcut icon">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/layui/2.7.5/layui.js"></script>
    <script src="http://lib.sinaapp.com/js/jquery/2.0.2/jquery-2.0.2.min.js"></script>
    <%--调用sohu的接口获取所在地位置--%>
    <script src="http://pv.sohu.com/cityjson?ie=utf-8"></script>
</head>
<body>
<div class="layui-form-item">
    <div class="layui-input-block">
        <form class="layui-form">
            <div align="center">
                当前位置：<p id="city"></p>
            </div>
            <br>
            <div class="layui-form-item" }>
                <label class="layui-form-label">打卡时间:</label>
                <div class="layui-input-block" style="width: 250px">
                    <input type="text" id="in_text" name='' required value=""
                           autocomplete="off" class="layui-input" readonly>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block" style="width: 400px">
                        <button class="layui-btn" type="button" id="in_btn">打卡</button>
                    </div>
                </div>
            </div>
            <br>
            <div class="layui-form-item" }>
                <label class="layui-form-label">签退时间:</label>
                <div class="layui-input-block" style="width: 250px">
                    <input type="text" id="out_text" name='' required value=""
                           autocomplete="off" class="layui-input" readonly>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block" style="width: 400px">
                        <button class="layui-btn" type="button" id="out_btn">签退</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $.ajax({
            url: '${pageContext.request.contextPath}/punch_clock/in_time.do',
            type: 'POST',
            dataType: 'text',
            data: {},
            success: function (in_time) {
                out_time()
                document.getElementById('in_text').value = in_time;
            },
            error: function (XMLHttpRequest) {
                console.log('XMLHttpRequest:');
                console.log(XMLHttpRequest);
                alert('网络异常！尝试刷新网页解决问题');
            }
        })

        function out_time() {
            $.ajax({
                url: '${pageContext.request.contextPath}/punch_clock/out_time.do',
                type: 'POST',
                dataType: 'text',
                data: {},
                success: function (out_time) {
                    document.getElementById('out_text').value = out_time;

                },
                error: function (XMLHttpRequest) {
                    console.log('XMLHttpRequest:');
                    console.log(XMLHttpRequest);
                    alert('网络异常！尝试刷新网页解决问题');
                }
            })
        }

        $('#in_btn').on('click', function () {
            var loginaddress = $("#city").text();
            $.ajax({
                url: '${pageContext.request.contextPath}/punch_clock/punch_in.do',
                type: 'POST',
                dataType: 'text',
                data: {
                    loginaddress: loginaddress,
                },
                success: function (result) {
                    //1:打卡成功，2：打卡失败（超过8点30，打卡状态为迟到），3：打卡失败（超过8点30后任不打卡，超过17:30点为缺席）
                    if (result >= 1) {
                        layer.msg("打卡成功!");
                    } else if (result == -2) {
                        layer.confirm("打卡成功，您已迟到，请填写迟到原因!", {
                            btn: ['确定', '取消']
                        }, function () {
                            layer.open({
                                title: '迟到原因说明',
                                area: ['650px', '250px'],
                                type: 2,
                                content: '${pageContext.request.contextPath}/punch_clock/lateinfo',
                                cancel: function () {
                                }
                            });
                        }, function () {
                        })
                    } else if (result == -3) {
                        layer.msg("打卡失败，当前状态为缺勤!");
                    } else if (result == -4) {
                        layer.msg("您已打卡，请勿重复打卡!");
                    }
                },
                error: function (XMLHttpRequest) {
                    console.log('XMLHttpRequest:');
                    console.log(XMLHttpRequest);
                    alert('网络异常！尝试刷新网页解决问题');
                }
            })
        })
        $('#out_btn').on('click', function () {
            $.ajax({
                url: '${pageContext.request.contextPath}/punch_clock/punch_out.do',
                type: 'POST',
                dataType: 'text',
                data: {},
                success: function (result) {
                    if (result >= 1) {
                        layer.msg("签退成功!");
                        out_time();
                    } else if (result == -2) {
                        layer.msg("早退提示：当前未到签退时间!");
                    } else if (result == -3) {
                        layer.msg("您已签退，请勿重复签退!");
                    }
                },
                error: function (XMLHttpRequest) {
                    console.log('XMLHttpRequest:');
                    console.log(XMLHttpRequest);
                    alert('网络异常！尝试刷新网页解决问题');
                }
            })
        })
        $(function () {
            //获取城市ajax
            /*$.ajax({
                url: 'http://pv.sohu.com/cityjson?ie=utf-8',
                type: 'GET',
                dataType: 'script',
                success: function (data) {
                    console.log("success" + JSON.stringify(data))
                    /!*$('#city').html(JSON.stringify(data.content.address_detail.province + "," + data.content.address_detail.city))*!/
                },
                error: function (data) {
                    console.log("error:" + JSON.stringify(data))
                }
            });*/
            $.ajax({
                url: 'http://pv.sohu.com/cityjson?ie=utf-8',
                dataType: "script",
                method: 'GET',
            }).done(function () {
                console.log(returnCitySN);
                $('#city').html(JSON.stringify(returnCitySN.cname))
            });

        })
    })
</script>
</body>
</html>
