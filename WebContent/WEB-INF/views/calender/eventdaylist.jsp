<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %> 

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
 <link href='${ctx}/static/dingding/fullcalendar.css' rel='stylesheet' />
<link href='${ctx}/static/dingding/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='${ctx}/static/dingding/jquery.min.js'></script>
<!-- 钉钉js -->
 <script src='${ctx}/static/dingding/dingtalk.js'></script>
<style type="text/css">
.list{
width:100%;
height:40px;
    border-right-width: 0px;
    border-left-width: 0px;
    padding: 5px
}
body{
    display: block;
    margin: 0px;
    font-size: 12px;
}
</style>
<script type="text/javascript">
function lookevents(id){
	window.location.href="${ctx}/calender/event?id="+id;
}
var _config = <%=com.techstar.sys.dingAPI.auth.AuthHelper.getConfig(request,"2")%>;
dd.config({
	agentId : _config.agentid,
	corpId : _config.corpId,
	timeStamp : _config.timeStamp,
	nonceStr : _config.nonceStr,
	signature : _config.signature,
	jsApiList : [ 'runtime.info', 'biz.contact.choose',
			'device.notification.confirm', 'device.notification.alert',
			'device.notification.prompt', 'biz.ding.post',
			'biz.util.openLink','biz.navigation.setRight','biz.navigation.setLeft' ]
});

dd.ready(function(){
	dd.biz.navigation.setTitle({
        title: '钉钉日程',
        onSuccess: function(data) {
        },
        onFail: function(err) {
            log.e(JSON.stringify(err));
        }
    });
	dd.biz.navigation.setRight({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    text: '添加',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	        //如果control为true，则onSuccess将在发生按钮点击事件被回调
	        /*
	        {}
	        */
	    	window.location.href="${ctx}/calender/event";
	    },
	    onFail : function(err) {}
	});
	dd.biz.navigation.setLeft({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    showIcon: true,//是否显示icon，true 显示， false 不显示，默认true； 注：具体UI以客户端为准
	    text: '主页',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	        /*
	{}
	*/
	        //如果control为true，则onSuccess将在发生按钮点击事件被回调
	    	window.location.href="${ctx}/calender/tab";
	    },
	    onFail : function(err) {}
	});
});


dd.error(function(err) {
	alert('dd error: ' + JSON.stringify(err));
});


</script>
<title>日程</title>
</head>
<body>
<c:forEach var="events" items="${list}">	
<div class="fc-state-default list" onclick="lookevents('${events.id}');"  style="font-size: 13px;">
${fn:substring(events.starttime,0,16)}-${fn:substring(events.endtime,0,16)} 创建者：${events.operationer}<br/>
标题：${events.title}
</div>		
</c:forEach>


</body>
</html>