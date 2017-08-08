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
       <link href="${ctx}/static/plancss/header.css" rel="stylesheet" />
    <script src="${ctx}/static/dingding/zepto.min.js"></script>
    <!-- 钉钉js -->
  <script src='http://g.alicdn.com/dingding/dingtalk-pc-api/2.3.1/index.js'></script>
<link href="${ctx}/static/plancss/index.css" rel="stylesheet" />
<link href="${ctx}/static/plancss/lookview.css" rel="stylesheet" />
    <style>
         body {
            background-color: #f0eff4;
        }

		
    </style>
</head>
<body>

<header >
		
<a href="${ctx}/pcplan/index" class="nav-bar">返回</a>
<a onclick="sendmessage()" class="nav-bar-right">发布提醒</a>

</header>
<div class="weui_panel">
    <div class="weui_panel_hd">权限列表</div>
    <div class="weui_panel_bd" id="deptlistdiv">
       

    </div>
</div>
<div class="approve-foot show">
<div class="tFlexbox tAlignCenter tJustifyCenter" id="btnlist">
<div class="tFlex1 approval-action tTap agree" onclick="addpower()" >添加权限</div>
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
	
	    $.ajax({
	    	  type: 'POST',
	    	  url: '${ctx}/power/getpower',
	    	  data: {  },
	    	  dataType: 'json',
	    	  success: function(data){
	    	    var listtask="";
		    	    $.each(data.userdata,function(i,n){
			               listtask+=" <a href=\"${ctx}/power/pcpoweradd?dd_nav_bgcolor=FF30A8A5&oper=edit&id="+n.id+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
				  	    	listtask+="<p class=\"weui_media_desc\">"+n.adminname+n.type+"</p>";
				  	    	listtask+="<ul class=\"weui_media_info\">";
				  	    	if(n.deptname!=null&&n.deptname!=""){
				  	    		listtask+="<li class=\"weui_media_info_meta\">"+n.deptname+"</li>";
				  	    	}
				  	    	
				  	    	
				  	    
				  	    	listtask+="</ul>";
				  	    	listtask+="</a>";
				  	    	 
		    	     });
		            document.getElementById("deptlistdiv").innerHTML=listtask;
	    	      
	    	  },
	    	  error: function(xhr, type,error){
	    	    alert('Ajax error!');
	    	  }
	    	});
	    
	   
});
DingTalkPC.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});

function addpower(){
	window.location.href="${ctx}/power/pcpoweradd?dd_nav_bgcolor=FF30A8A5";
	
}
function sendmessage(){
    $.ajax({
  	  type: 'POST',
  	  url: '${ctx}/power/getmessuser',
  	  data: {  },
  	  dataType: 'json',
  	  success: function(data){
  	    var users=data.userdata.split(",");
	  	  DingTalkPC.biz.ding.post({
	  	    users : users,//用户列表，userid
	  	    corpId: authconfig.corpId, //加密的企业id
	  	    type: 1, //钉类型 1：image  2：link
	  	    alertType: 2,
	  	    alertDate: {},
	  	    attachment: {
	  	        images: [''], //只取第一个image
	  	    }, //附件信息
	  	    text: '', //消息体
	  	    onSuccess : function() {},
	  	    onFail : function() {}
	  	});
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
	
}


</script>
</html>