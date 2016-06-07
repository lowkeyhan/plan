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
<script type="text/javascript">
var deptid="${deptid}";
var deptname="${deptname}";
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
	//指定默认年份
	$("#selectyear").val("${year}");
	//加载默认年份计划
	getplanlist();
	//设置标题
	dd.biz.navigation.setTitle({
        title: deptname,
        onSuccess: function(data) {
        },
        onFail: function(err) {
            log.e(JSON.stringify(err));
        }
    });
	//设置右侧按钮
	dd.biz.navigation.setMenu({
        backgroundColor : "#ADD8E6",
        items : [ {"id":"1",//字符串
            "iconId":"add",//字符串，图标命名
              "text":"添加"}],
        onSuccess: function(data) {
        	window.location.href="${ctx}/plan/planadd?dd_nav_bgcolor=FF30A8A5&deptid="+deptid+"&year="+$("#selectyear").val();
            
        },
        onFail: function(err) {
        }
    });
	
	//设置左侧按钮
	dd.biz.navigation.setLeft({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    showIcon: true,//是否显示icon，true 显示， false 不显示，默认true； 注：具体UI以客户端为准
	    text: '钉钉',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	    	dd.biz.navigation.close({
			    onSuccess : function(result) {},
			    onFail : function(err) {}}
	    	);
	    },
	    onFail : function(err) {}
	});
	//
	    
});
dd.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});


//
function getplanlist(){
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/plan/getplan',
  	  data: { deptid: deptid,
  		  	year:$("#selectyear").val()	
  	  		},
  	  dataType: 'json',
  	  success: function(data){
  	    var listdept="";
  	     $.each(data.userdata,function(i,n){
  	    	 listdept+="<a href=\"${ctx}/plan/planadd?id="+n.id+"\" class=\"weui_media_box weui_media_text\">";
  	    	 listdept+="<p class=\"weui_media_desc\">"+n.title+"</p>";
  	    	 listdept+="<ul class=\"weui_media_info\">";
  	    	 listdept+="<li class=\"weui_media_info_meta\">创建人:"+n.operationer+"</li>";
  	    	 listdept+="<li class=\"weui_media_info_meta\">"+n.level+"</li>";
  	    	 listdept+="<li class=\"weui_media_info_meta weui_media_info_meta_extra\">权重："+n.weight+"%</li>";
  	    	 listdept+="</ul>";
  	    	 listdept+="</a>";
  	     	});
	            document.getElementById("planlistdiv").innerHTML=listdept;
	           
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}
</script>
<div class="weui_panel">
    <div class="weui_panel_hd">
     <select  name="selectyear" id="selectyear">
            <option value="2015" >2015年</option>
            <option value="2016">2016年</option>
            <option value="2017">2017年</option>
     </select>计划列表
    </div>
    <div class="weui_panel_bd" id="planlistdiv">
       <a href="planinfo.html" class="weui_media_box weui_media_text">

            <p class="weui_media_desc">公司计划工作处理</p>
            <ul class="weui_media_info">
                <li class="weui_media_info_meta">创建人：部门经理</li>
                <li class="weui_media_info_meta">公司计划</li>
                <li class="weui_media_info_meta weui_media_info_meta_extra">计划权重：30%</li>
            </ul>
        </a>

    </div>
</div>
</body>
</html>