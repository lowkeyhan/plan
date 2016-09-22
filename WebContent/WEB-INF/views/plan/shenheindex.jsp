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
    <!-- 钉钉js -->
 <script src='${ctx}/static/dingding/dingtalk.js'></script>
<link href="${ctx}/static/plancss/index.css" rel="stylesheet" />
<link href="${ctx}/static/plancss/lookview.css" rel="stylesheet" />
    <style>
         body {
            background-color: #f0eff4;
        }

		
    </style>
</head>
<body>


<div class="weui_panel">
    <div class="weui_panel_hd">待审核列表</div>
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
		jsApiList : [ 'runtime.info', 'biz.contact.choose',
						'device.notification.confirm', 'device.notification.alert',
						'device.notification.prompt', 'biz.ding.post',
						'biz.util.openLink','biz.navigation.setRight','biz.navigation.setLeft',
						'device.notification.showPreloader','device.notification.hidePreloader','biz.navigation.close' ]
});
dd.ready(function(){
	dd.biz.navigation.setLeft({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    showIcon: true,//是否显示icon，true 显示， false 不显示，默认true； 注：具体UI以客户端为准
	    text: '返回',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	        /*
	        {}
	        */
	        //如果control为true，则onSuccess将在发生按钮点击事件被回调
	    	window.location.href="${ctx}/plan/index?dd_nav_bgcolor=FF30A8A5";
	    },
	    onFail : function(err) {}
	});
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
		    	    		listtask+=" <a href=\"${ctx}/plan/planview?dd_nav_bgcolor=FF30A8A5&checkid="+n.id+"&deptid="+n.deptid+"&power=shenpi\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
				  	    	listtask+="<p class=\"weui_media_desc\">"+n.year+"年"+n.deptname+n.type+"</p>";
				  	    	listtask+="</a>";
		    	    	}else if(n.type=="变更"){
		    	    		listtask+=" <a href=\"${ctx}/change/"+changepage+"?dd_nav_bgcolor=FF30A8A5&id="+n.id+"&tid="+n.taskid+"&cid="+n.changeid+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
				  	    	listtask+="<p class=\"weui_media_desc\">"+n.year+"年"+n.deptname+"任务"+n.type+"申请</p>";
				  	    	listtask+="</a>";
		    	    	}else if(n.type=="撤销"){
		    	    		listtask+=" <a href=\"${ctx}/change/"+delpage+"?dd_nav_bgcolor=FF30A8A5&id="+n.id+"&tid="+n.taskid+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" >";
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
	    
	   
});
dd.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});

function addpower(){
	window.location.href="${ctx}/power/poweradd?dd_nav_bgcolor=FF30A8A5";
	
}

</script>
</html>