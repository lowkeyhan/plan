<%@ page language="java" contentType="text/html; charset=UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %> 

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta charset="UTF-8">
    <title>报修管理</title>
    <link href="${ctx}/static/repair/css/myscc.css" rel="stylesheet" />
    <link href="${ctx}/static/repair/css/weui.min.css" rel="stylesheet" />
    <script src="${ctx}/static/repair/js/zepto.min.js"></script>
    <style>
        td{
            border: solid 1px #EDEDED;
        }
    </style>
</head>
<body>
<div   class="maincolor" >
    <a href="${ctx}/repair/addrepair?type=0" class="title_left"  >
        <div class="title_img" ><i class="iconfont icon-baoxiu"></i></div>
        <div class="title_text" >本人报修</div>
    </a>
    <a  href="${ctx}/repair/addrepair?type=daili"  class="title_right"  >
        <div class="title_img"><i class="iconfont icon-dailibaoxiu"></i></div>
        <div class="title_text">代理报修</div>
    </a>
</div>

<table style="width: 100%;border-collapse:collapse">
    <tr>
        <td>
            <a href="repairlist.html?state=daifenpei" class="item_button" >
                <div class="item_img"><i class="iconfont icon-chulizhong2"></i></div>
                <div class="item_text">未完成</div>
            </a>
        </td>
        <td>
            <a class="item_button"  >
                <div class="item_img"><i class="iconfont icon-daipingjia"></i></div>
                <div class="item_text">待评价</div>
            </a>
        </td>
        <td>
            <a class="item_button" >
                <div class="item_img"><i class="iconfont icon-wancheng1"></i></div>
                <div class="item_text">已完成</div>
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="repairlist.html?state=daifenpei" class="item_button" style="" >
            <div class="item_img"><i class="iconfont icon-daifenpei"></i></div>
            <div class="item_text">待分配</div>
            </a>
        </td>
        <td>
            <a class="item_button"  >
                <div class="item_img"><i class="iconfont icon-daichuli"></i></div>
                <div class="item_text">待受理</div>
            </a>
        </td>
        <td>
            <a class="item_button" >
                <div class="item_img"><i class="iconfont icon-paidui"></i></div>
                <div class="item_text">排队中</div>
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a class="item_button" >
                <div class="item_img"><i class="iconfont icon-daipingjia"></i></div>
                <div class="item_text">待评价</div>
            </a>
        </td>
        <td>
            <a class="item_button" >
                <div class="item_img"><i class="iconfont icon-wancheng1"></i></div>
                <div class="item_text">已完成</div>
            </a>
        </td>
        <td>

        </td>
    </tr>
</table>

</body>
</html>