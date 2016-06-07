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
    <!-- 钉钉js -->
 <script src='${ctx}/static/dingding/dingtalk.js'></script>
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
    </style>
</head>
<body>
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
	//获得授权登陆code
	dd.runtime.permission.requestAuthCode({
	    corpId: authconfig.corpId,
	    onSuccess: function(result) {
	    /*{
	        code: 'hYLK98jkf0m' //string authCode
	    }*/
	    $.ajax({
	    	  type: 'POST',
	    	  url: '${ctx}/plan/authuser',
	    	  // data to be added to query string:
	    	  data: { code: result.code },
	    	  // type of data we are expecting in return:
	    	  dataType: 'json',
	    	  success: function(data){
	    	    // Supposing this JSON payload was received:
	    	    //   {"project": {"id": 42, "html": "<div>..." }}
	    	    // append the HTML to context object.
	    	    var listdept="";
	    	     $.each(data.userdata,function(i,n){
		               if(n.parentid==="true"){
		            	   listdept=listdept+"<a href=\"${ctx}/plan/planlist?dd_nav_bgcolor=FF30A8A5&deptid="+n.id+"&deptname="+encodeURI(n.name)+"\" class=\"weui_media_box weui_media_text\"><p class=\"weui_media_desc\">"+n.name+" <span class=\"zhuguan\">主管</span></p></a> ";  		    	    	    
		                }else{
		                	listdept=listdept+"<a href=\"${ctx}/plan/tasklist?dd_nav_bgcolor=FF30A8A5&deptid="+n.id+"\" class=\"weui_media_box weui_media_text\"><p class=\"weui_media_desc\">"+n.name+"</p></a> ";  		    	    	    			                
		                }
	    	     });
		            document.getElementById("deptlistdiv").innerHTML=listdept;
		           
	    	  },
	    	  error: function(xhr, type,error){
	    	    alert('Ajax error!')
	    	  }
	    	})
	    
	    
	    
	    },
	    onFail : function(err) {}

	})
});
dd.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});

</script>
<div class="weui_panel">
    <div class="weui_panel_hd">部门列表</div>
    <div class="weui_panel_bd" id="deptlistdiv">
       

    </div>
</div>
</body>
</html>