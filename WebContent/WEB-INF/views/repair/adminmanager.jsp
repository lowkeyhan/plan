<%@ page language="java" contentType="text/html; charset=UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %> 

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link href="${ctx}/static/repair/css/myscc.css" rel="stylesheet" />
    <link href="${ctx}/static/repair/css/weui.min.css" rel="stylesheet" />
<script src='${ctx}/static/dingding/jquery.min.js'></script>
    <style>
        body{
            margin: 0px;
            border: 0px;
        }
    </style>

</head>
<body onload="add()">

<!--头部开始-->
<div class="" style="height: 50px;width: 100%;background-color:#2f4355 ">
<img alt="touxiang" src="${avatar}">${name}
</div>
<!--头部结束-->
<div style="width: 100%;min-height: 100%;">
 	<nav id="sidebar"  class=" navbar-static-side" style="min-height: 100%;height:700px">
        <div style="height: 80px;width: 100%;border-bottom: solid 1px #FFFFFF;color: #FFFFFF;text-align: center; font-size: 20px;line-height: 80px ">管理员：技服-霍海滨</div>
        <div style="height: 50px;width: 100%;border-bottom: solid 1px #FFFFFF;color: #FFFFFF;text-align: center;font-size: 13px;line-height: 50px">管理人员</div>
    </nav>
    <div id="page-wrapper">
	 	<div class="weui_cells_title"  style="margin-top: 0px"><a  href="javascript:addment('1');">北京恒泰实达科技股份有限公司</a></div>
	    <div class="weui_cells weui_cells_access" id="listname">
	        
	    </div>
	     <div class="weui_cells_title">部门人员</div>
	    <div class="weui_cells weui_cells_access" id="listuser">
	
	    </div>
    </div>
</div>
<script>
var deparment;
function add(){
    $.ajax({
        url:'${ctx}/repair/admin/bmlist',
        data:{},
        type:'POST',
        dataType:'json',
        success:function(responseText){
            deparment=responseText.userdata;
            addment("1");
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){

            alert(XMLHttpRequest.status+XMLHttpRequest.readyState+textStatus);
        }
    });


}
function addment(parentid){
    var list= document.getElementById("listname");
    var listitme="";
    $.each(deparment,function(i,n){
        if(n.parentid==parentid){
            listitme=listitme+"<a class=\"weui_cell\" href=\"javascript:addment("+ n.id+");\"><div class=\"weui_cell_bd weui_cell_primary\"> <p>"+n.name+"</p> </div><div class=\"weui_cell_ft\"> </div> </a>";
        }
    });
    list.innerHTML=listitme;
    var listuser="";
    $.ajax({
        url:'${ctx}/repair/admin/userlist',
        data:{id:parentid},
        type:'POST',
        dataType:'json',
        success:function(responseText){
            $.each(responseText.userdata,function(i,n){
                listuser=listuser+"<a class=\"weui_cell\" href=\"javascript:addment("+ n.userid+");\"><div class=\"weui_cell_bd weui_cell_primary\"> <p>"+n.name+"</p> </div><div class=\"weui_cell_ft\"> </div> </a>";
            });
            document.getElementById("listuser").innerHTML=listuser;
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            alert(XMLHttpRequest.status+XMLHttpRequest.readyState+textStatus);
        }
    });
}
</script>
</body>
</html>