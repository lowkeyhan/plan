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
    <title>计划管理</title>
  
    <link href="${ctx}/static/dingding/weui.min.css" rel="stylesheet" />
    <script src="${ctx}/static/dingding/zepto.min.js"></script>
    
       <link href="${ctx}/static/plancss/header.css" rel="stylesheet" />
    <!-- 钉钉js -->
  <script src='http://g.alicdn.com/dingding/dingtalk-pc-api/2.3.1/index.js'></script>
<link href="${ctx}/static/plancss/index.css" rel="stylesheet" />
<link href="${ctx}/static/plancss/lookview.css" rel="stylesheet" />
    <style>
         body {
            background-color: #f0eff4;
        }
.header_btn{
	    width: 100px;
    line-height: 37px;
    text-align: center;
    color: #666;
    cursor: pointer;
    height: 40px;
    display: block;
    float: left;
}
.header_btn_border{
	border-bottom: solid 2px #4BB9FF;
	font-weight: 700;
}
		
    </style>
</head>
<body>

<header >
		
<a href="${ctx}/pcplan/index" class="nav-bar"><span style="  color: #0894ec;" class="glyphicon glyphicon-circle-arrow-left"></span>返回</a>
<a onclick="gourl(this,'1')" id="daishenpi" class="header_btn header_btn_border">待审核</a>
<a  onclick="gourl(this,'2')" class="header_btn header_btn_border">我发起</a>
<a  onclick="gourl(this,'3')" class="header_btn header_btn_border">我审核</a>
</header>
<div class="weui_panel">
    <div class="weui_panel_hd">待审核列表</div>
    <div class="weui_panel_bd" id="deptlistdiv">
       

    </div>
</div>
</body>
<script type="text/javascript" charset="utf-8" >
var authconfig=$.parseJSON('${authconfig}');
DingTalkPC.config({
		agentId : authconfig.agentid,
		corpId : authconfig.corpId,
		timeStamp : authconfig.timeStamp,
		nonceStr : authconfig.nonceStr,
		signature : authconfig.signature,
		jsApiList : [ 'runtime.info', 'biz.contact.choose',
						'device.notification.confirm', 'device.notification.alert',
						'device.notification.prompt', 'biz.ding.post',
						'biz.util.openLink','biz.navigation.setRight','biz.navigation.setLeft',
						'device.notification.showPreloader','device.notification.hidePreloader','biz.navigation.close' ]
});
DingTalkPC.ready(function(){
	$("#daishenpi").click();
	
	    
	   
});
DingTalkPC.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});

function addpower(){
	window.location.href="${ctx}/power/pcpoweradd?dd_nav_bgcolor=FF30A8A5";
	
}
function hclear(){
	var ali=document.getElementsByTagName("header")[0].getElementsByTagName("a");
	for (var index=0;index<ali.length;index++) {
		ali[index].className="header_btn ";
		}
}
function gourl(obj,func) {
	hclear();
	 document.getElementById("deptlistdiv").innerHTML="";
	obj.className="header_btn  header_btn_border";
	if(func=="1"){
		getsheppilist();
	}else if(func=="2"){
		getmytijiao();
	}else if(func="3"){
		getmyshenpi();
	}
	
}
//获得我提交
function getmytijiao(){
	
	 $.ajax({
   	  type: 'POST',
   	  url: '${ctx}/pccheck/getowerallcheck',
   	  data: {  },
   	  dataType: 'json',
   	  success: function(data){
   	    var listtask="";
	    	    $.each(data.userdata,function(i,n){
	    	    	var changepage="shenhechange";
	    	    	var delpage="shenhedel";
	    	    	if(n.pid=="0"){
	    	    		var changepage="shenheplanchange";
		    	    	var delpage="shenheplandel";
	    	    	}
	    	    	if(n.type=="计划审核"){
	    	    		listtask+=" <a href=\"${ctx}/pccheck/shenheview?checkid="+n.id+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
			  	    	listtask+="<p class=\"weui_media_desc\">"+n.year+"年"+n.deptname+n.type+"</p>";
			  	    	listtask+="</a>";
	    	    	}else if(n.type=="变更"){
	    	    		listtask+=" <a href=\"${ctx}/pcchange/oldchange?dd_nav_bgcolor=FF30A8A5&id="+n.id+"&tid="+n.taskid+"&cid="+n.changeid+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
			  	    	listtask+="<p class=\"weui_media_desc\">"+n.pid+"任务"+n.type+"申请</p>";
			  	    	listtask+="</a>";
	    	    	}else if(n.type=="撤销"){
	    	    		listtask+=" <a href=\"${ctx}/pccheck/shenheview?checkid="+n.id+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
			  	    	listtask+="<p class=\"weui_media_desc\">"+n.pid+"任务"+n.type+"申请</p>";
			  	    	listtask+="</a>";
	    	    	}
		               
			  	    	 
	    	     });
	            document.getElementById("deptlistdiv").innerHTML=listtask;
   	      
   	  },
   	  error: function(xhr, type,error){
   	    alert('Ajax error!');
   	  }
   	});
}

//获得我审批
function getmyshenpi(){
	 $.ajax({
	   	  type: 'POST',
	   	  url: '${ctx}/pccheck/findshenpiall',
	   	  data: {  },
	   	  dataType: 'json',
	   	  success: function(data){
	   	    var listtask="";
		    	    $.each(data.userdata,function(i,n){
		    	    	var changepage="shenhechange";
		    	    	var delpage="shenhedel";
		    	    	if(n.pid=="0"){
		    	    		var changepage="shenheplanchange";
			    	    	var delpage="shenheplandel";
		    	    	}
		    	    	if(n.type=="计划审核"){
		    	    		listtask+=" <a href=\"${ctx}/pccheck/shenheview?checkid="+n.id+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
				  	    	listtask+="<p class=\"weui_media_desc\">"+n.year+"年"+n.deptname+n.type+"</p>";
				  	    	listtask+="</a>";
		    	    	}else if(n.type=="变更"){
		    	    		listtask+=" <a href=\"${ctx}/pcchange/oldchange?dd_nav_bgcolor=FF30A8A5&id="+n.id+"&tid="+n.taskid+"&cid="+n.changeid+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
				  	    	listtask+="<p class=\"weui_media_desc\">"+n.pid+"任务"+n.type+"申请</p>";
				  	    	listtask+="</a>";
		    	    	}else if(n.type=="撤销"){
		    	    		listtask+=" <a href=\"${ctx}/pccheck/shenheview?checkid="+n.id+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
				  	    	listtask+="<p class=\"weui_media_desc\">"+n.pid+"任务"+n.type+"申请</p>";
				  	    	listtask+="</a>";
		    	    	}
			               
				  	    	 
		    	     });
		            document.getElementById("deptlistdiv").innerHTML=listtask;
	   	      
	   	  },
	   	  error: function(xhr, type,error){
	   	    alert('Ajax error!');
	   	  }
	   	});
	 
}
function getsheppilist(){
	  $.ajax({
    	  type: 'POST',
    	  url: '${ctx}/check/getcheck',
    	  data: {  },
    	  dataType: 'json',
    	  success: function(data){
    	    var listtask="";
	    	    $.each(data.userdata,function(i,n){
	    	    	var changepage="shenhechange";
	    	    	var delpage="shenhedel";
	    	    	if(n.pid=="0"){
	    	    		var changepage="shenheplanchange";
		    	    	var delpage="shenheplandel";
	    	    	}
	    	    	if(n.type=="计划审核"){
	    	    		listtask+=" <a href=\"${ctx}/pcplan/planview?dd_nav_bgcolor=FF30A8A5&checkid="+n.id+"&deptid="+n.deptid+"&power=shenpi\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
			  	    	listtask+="<p class=\"weui_media_desc\">"+n.year+"年"+n.deptname+n.type+"</p>";
			  	    	listtask+="</a>";
	    	    	}else if(n.type=="变更"){
	    	    		listtask+=" <a href=\"${ctx}/pcchange/"+changepage+"?dd_nav_bgcolor=FF30A8A5&id="+n.id+"&tid="+n.taskid+"&cid="+n.changeid+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
			  	    	listtask+="<p class=\"weui_media_desc\">"+n.year+"年"+n.deptname+"任务"+n.type+"申请</p>";
			  	    	listtask+="</a>";
	    	    	}else if(n.type=="撤销"){
	    	    		listtask+=" <a href=\"${ctx}/pcchange/"+delpage+"?dd_nav_bgcolor=FF30A8A5&id="+n.id+"&tid="+n.taskid+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
			  	    	listtask+="<p class=\"weui_media_desc\">"+n.year+"年"+n.deptname+"任务"+n.type+"申请</p>";
			  	    	listtask+="</a>";
	    	    	}
		               
			  	    	 
	    	     });
	            document.getElementById("deptlistdiv").innerHTML=listtask;
    	      
    	  },
    	  error: function(xhr, type,error){
    	    alert('Ajax error!');
    	  }
    	});
}
</script>
</html>