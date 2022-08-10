<%--
  Created by IntelliJ IDEA.
  User: 大眼怪
  Date: 2022/8/2
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>打印凭条</title>
</head>
<body>
<%--${orderInfo}--%>

<div style="width: 300px; height: 500px; background: #F6F6F6">
    <div align="center"><h1>欢迎光临</h1></div>
    <div align="center"><h2>铜锣烧饭店</h2></div>
    &nbsp;------------------------------------------
    <div align="center">电子凭条</div>
    &nbsp;------------------------------------------
    <div style="margin-left: 20px">
        <span>No.${orderInfo.tableId}/9999</span>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span>${orderInfo.orderBeginDate}</span><br/>
        <span>服务员:${orderInfo.waiterName}</span><br/>
    </div>
    &nbsp;------------------------------------------
    <table>
        <thead align="center">
        <tr>
            <td width="100px">名称</td>
            <td width="100px">数量</td>
            <td width="100px">单价</td>
        </tr>
        </thead>
        <tbody align="center">
        <c:forEach items="${orderInfo.dishesList}" var="dish">
            <tr>
                <td>${dish.dishesName}</td>
                <td>${dish.dishesPrice}</td>
                <td>${dish.dishesCount}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    &nbsp;------------------------------------------
    <table>
        <thead align="center">
        <tr>
            <td width="100px"><h3>合计</h3></td>
            <td width="100px"><h3>:</h3></td>
            <td width="100px"><h3>${orderInfo.sumMoney}</h3></td>
        </tr>
        </thead>
    </table>
    &nbsp;------------------------------------------
    <div>地址&nbsp;&nbsp;&nbsp;江苏省南通市如皋市</div>
    <div>电话&nbsp;&nbsp;&nbsp;021-88888888</div>
    <p align="center">谢谢光临</p>
</div>
</body>
</html>
