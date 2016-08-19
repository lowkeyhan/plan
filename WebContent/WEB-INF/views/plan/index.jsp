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
    <title>计划审核</title>
  
    <link href="${ctx}/static/dingding/weui.min.css" rel="stylesheet" />
    <script src="${ctx}/static/dingding/zepto.min.js"></script>
    <!-- 钉钉js -->
 <script src='${ctx}/static/dingding/dingtalk.js'></script>
<link href="${ctx}/static/plancss/index.css" rel="stylesheet" />
    <style>
         body {
            background-color: #f0eff4;
        }

		
    </style>
</head>
<body>


<div class="main_title">

	<a href="${ctx}/plan/planlist" class="title_item">
		<i class="icon icon-check item_icon iconfont icon-jihuaguanli"  > </i>
		<div class="item_font">计划管理</div>
	</a>
		<a href="${ctx}/check/checklist" class="title_item">
		<span class="icon icon-message item_icon  iconfont icon-crmtubiao67" ></span>
		<div class="item_font">审批管理</div>
	</a>
	<a onclick="changedept()" class="title_item">
		<span class="icon icon-message item_icon  iconfont icon-houtaigunli" ></span>
		<div class="item_font">查看计划</div>
	</a>
	<a href="${ctx}/power/admin" class="title_item">
		<span class="icon icon-message item_icon  iconfont icon-houtaigunli" ></span>
		<div class="item_font">后台管理</div>
	</a>
	
</div>
<div class="weui_panel">
    <div class="weui_panel_hd">我的任务</div>
    <div class="weui_panel_bd" id="deptlistdiv">
       

    </div>
</div>
</body>
<script type="text/javascript" charset="utf-8" >
var authconfig=$.parseJSON('${authconfig}');
dd.config({
		agentId : authconfig.agentid,
		corpId : authconfig.corpId,
		timeStamp : authconfig.timeStamp,
		nonceStr : authconfig.nonceStr,
		signature : authconfig.signature,
		jsApiList : [ 'runtime.info', 'biz.contact.choose','biz.contact.complexChoose',
						'device.notification.confirm', 'device.notification.alert',
						'device.notification.prompt', 'biz.ding.post',
						'biz.util.openLink','biz.navigation.setRight','biz.navigation.setLeft',
						'device.notification.showPreloader','device.notification.hidePreloader','biz.navigation.close' ]
});
dd.ready(function(){
	//获得授权登陆code
	dd.runtime.permission.requestAuthCode({
	    corpId: authconfig.corpId,
	    onSuccess: function(result) {
	    $.ajax({
	    	  type: 'POST',
	    	  url: '${ctx}/plan/login',
	    	  data: { code: result.code },
	    	  dataType: 'json',
	    	  success: function(data){
	    	    var listtask="";
		    	    $.each(data.userdata,function(i,n){
			               listtask+=" <a href=\"${ctx}/plan/taskview?dd_nav_bgcolor=FF30A8A5&id="+n.id+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" onclick=\"openplaninfo('"+n.id+"')\">";
				  	    	listtask+="<p class=\"weui_media_desc\">"+n.title+"</p>";
				  	    	listtask+="<ul class=\"weui_media_info\">";
				  	    	listtask+="<li class=\"weui_media_info_meta\">进度："+n.jindu+"%</li>";
								listtask+="<li class=\"weui_media_info_meta\">负责人："+n.fuzherenname+"</li>";
				  	    
				  	    		listtask+="<li class=\"weui_media_info_meta\">"+n.stime+"至"+n.endtime+"</li>";
				  	    	
				  	    
				  	    	listtask+="</ul>";
				  	    	listtask+="</a>";
				  	    	 
		    	     });
		            document.getElementById("deptlistdiv").innerHTML=listtask;
	    	      
	    	  },
	    	  error: function(xhr, type,error){
	    	    alert('Ajax error!');
	    	  }
	    	});
	    
	    
	    
	    },
	    onFail : function(err) {}

	})
});
dd.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});
function changedept(){
	 dd.biz.contact.complexChoose({
		  startWithDepartmentId: 0, //-1表示从自己所在部门开始, 0表示从企业最上层开始，其他数字表示从该部门开始
		  selectedUsers: [], //预选用户
		  corpId: authconfig.corpId, //企业id
		  onSuccess: function(data) {
		//
			  var dept=data.departments;
				  for(var i=0; i<dept.length; i++)  
				  {  
					  window.location.href="${ctx}/plan/planview?dd_nav_bgcolor=FF30A8A5&power=look&deptid="+dept[i].id;
		  	          
				  }  
		  },
		  onFail : function(err) {}
		});
}

</script>
</html>