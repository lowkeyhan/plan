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
  
    <link href="${ctx}/static/dingding/weui.min.css" rel="stylesheet" />
    <script src="${ctx}/static/dingding/zepto.min.js"></script>
    
       <link href="${ctx}/static/plancss/header.css" rel="stylesheet" />
    <!-- 钉钉js -->
  <script src='http://g.alicdn.com/dingding/dingtalk-pc-api/2.3.1/index.js'></script>
     <link href="${ctx}/static/plancss/lookview.css" rel="stylesheet" />
    <style>
         body {
            background-color: #f0eff4;
        }

        .weui_media_box {
            display: block;
        }

        .weui_media_desc {
            color: #000000 !important;
        }
        .zhuguan{
		   color: white;
		   background-color: #5cb85c;
		   border-radius: 4px;
		   padding-left: 5px;
		   padding-right: 5px;
		}
		.hidediv{
			display:none;
		}
    </style>
</head>
<body>
<header >
<a href="javascript:history.go(-1);" class="nav-bar"><span style="  color: #0894ec;" class="glyphicon glyphicon-circle-arrow-left"></span>返回</a>
</header>
 
<div id="allrecord" class="approval-tline-box">

</div>
<script type="text/javascript">
//var deptid="${deptid}";
var authconfig=$.parseJSON('${authconfig}');
</script>
<script src='${ctx}/static/planjs/PCdingpublic.js'></script>
<script type="text/javascript">
DingTalkPC.ready(function(){
	getrecord("allrecord","${id}","zhuguan","${ctx}");
});
DingTalkPC.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});


//获得进度记录
function getrecord(objid,checkid,type,ctx){
	$.ajax({
	  	  type: 'POST',
	  	  url: ctx+'/checklog/getchecklog',
	  	  data:{
	  		checkid:checkid,
	  		type:type,
	  	  },
	  	  dataType: 'json',
	  	  success: function(data){
	  		
	  			var listdept="";
	  		listdept+="<div class=\"approval-tline\" >";
	  		 $.each(data.userdata,function(i,n){
	  			listdept+="<div class=\"time-node\" >";
	  			listdept+="<div class=\"node-status\"><i class=\"weui_icon_info\" ></i></div>";
	  			listdept+="<div class=\"nodebox\" >";
	  			listdept+="	<div class=\"arrow\"></div>";
	  			listdept+="	<div class=\"nodebox-inner\">";
	  			listdept+="	<div class=\"node-avatar\">";
	  			listdept+=getnameimg(n.operationer);
	  			listdept+="</div>";
	  			listdept+="		<p class=\"username\">"+n.operationer+n.shuoming+"</p>";
	  			if(n.shuoming!=null&&n.shuoming!=""){
	  				listdept+="		<p class=\"result-line\">"+n.shuju+"</p>";
	  			}else{
	  				listdept+="		<p class=\"result-line\"></p>";
	  			}
	  			listdept+="		<div class=\"opreratetime\">"+getTime(n.operationdate)+"</div>";
	  			listdept+="	</div>";
	  			listdept+="</div>";
	  			listdept+="</div>";
	          });
	  		listdept+="</div>";
	         document.getElementById(objid).innerHTML=listdept;
	  	  },
	  	  error: function(xhr, type,error){
	  	    alert('Ajax error!');
	  	  }
	  });
}
function getnameimg(username){
	var nameimg=username;
	if(username.length>2){
		nameimg=username.substr(username.length-2,2);
	}
	return nameimg;
}
</script>
</html>