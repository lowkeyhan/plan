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
    <title></title>
   <link href="${ctx}/static/repair/css/myscc.css" rel="stylesheet" />
    <link href="${ctx}/static/repair/css/weui.min.css" rel="stylesheet" />
    <script src="${ctx}/static/repair/js/zepto.min.js"></script>
    <style>
        body{
            background-color: #f0eff4;
        }
    </style>
</head>
<body>
<script type="text/javascript">
window.onload=function()
{
   var dailicell= document.getElementById("daili");
   if('${repairtype}'=='daili'){
	   dailicell.className="weui_cells weui_cells_form show";
	  }
}
</script>
<form id="eventForm_${uuid}" action="${ctx}/calender/edit" method="POST" >
    <input type="hidden" id="id" name="id" value="${events.id}" />
    <input type="hidden" id="oper" name="oper" value="${oper}" />
    <div class="weui_cells weui_cells_form">
        <div class="weui_cell">
            <div class="weui_cell_bd weui_cell_primary">
                <textarea class="weui_textarea" placeholder="请输入报修内容" rows="6"></textarea>

            </div>
        </div>
    </div>
    <div class="weui_cells_tips">长按输入框开始录音</div>
    <div class="weui_cells weui_cells_form">
        <div class="weui_cell">
            <div class="weui_cell_hd"><label class="weui_label">报修人</label></div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" id="starttime" readonly="readonly" name="starttime" type="text"  value='技服-韩雪冰'>
            </div>
        </div>

    </div>
    <div class="weui_cells weui_cells_form hide" id="daili" >
        <div class="weui_cell">
            <div class="weui_cell_hd"><label class="weui_label">代理人</label></div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" id="starttime" readonly="readonly" name="starttime" type="text"  value='技服-韩雪冰'>
            </div>
        </div>

    </div>
    </form>
<input type="button" id="submit_${uuid}" onclick="allsubmit('home');"  class="weui_btn weui_btn_primary" value="&nbsp;&nbsp;报&nbsp;&nbsp;修&nbsp;&nbsp;" />
<input type="button" id="submit_${uuid}" onclick=" gohome();"  class="weui_btn weui_btn_default" value="&nbsp;&nbsp;取&nbsp;&nbsp;消&nbsp;&nbsp;" />

</body>
</html>