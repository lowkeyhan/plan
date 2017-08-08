<%@ page language="java" contentType="text/html; charset=UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %> 

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- 
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
   -->
    <meta charset="UTF-8">
    <title>计划审核</title>
  
    <link href="${ctx}/static/dingding/weui.min.css" rel="stylesheet" />
      <link href="${ctx}/static/ztree/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="${ctx}/static/ztree/jquery-1.4.4.min.js"></script>
    <script src="${ctx}/static/ztree/jquery.ztree.core.js"></script>
    <script src="${ctx}/static/ztree/jquery.ztree.excheck.js"></script>
      <!-- 钉钉js -->
  <script src='http://g.alicdn.com/dingding/dingtalk-pc-api/2.3.1/index.js'></script>
<link href="${ctx}/static/plancss/index.css" rel="stylesheet" />
    <style>
         body {
            background-color: #f0eff4;
        }
		.hides{
		display:none;
		}
		
    </style>
</head>
<body>


<div class="main_title">

	<a href="${ctx}/pcplan/planlist" class="title_item">
		<i class="icon icon-check item_icon iconfont icon-jihuaguanli"  > </i>
		<div class="item_font">计划管理</div>
	</a>
		<a href="${ctx}/pccheck/checklist" class="title_item">
		<span class="icon icon-message item_icon  iconfont icon-crmtubiao67" ></span>
		<div class="item_font">审批管理</div>
	</a>
	<a onclick="changedept()" id="lookitem" class="title_item hides">
		<span class="icon icon-message item_icon  iconfont icon-houtaigunli" ></span>
		<div class="item_font">查看计划</div>
	</a>
	<a href="${ctx}/power/pcadmin" id="poweritem" class="title_item hides">
		<span class="icon icon-message item_icon  iconfont icon-houtaigunli" ></span>
		<div class="item_font">后台管理</div>
	</a>
</div>
<div class="weui_panel">
    <div class="weui_panel_hd">我的任务</div>
    <div class="weui_panel_bd" id="deptlistdiv">
       

    </div>
</div>


<!--BEGIN 弹出选择部门-->
    <div class="weui_dialog_confirm" id="gohomedialog" style="display: none;">
        <div class="weui_mask"></div>
        <div class="weui_dialog">
            <div class="weui_dialog_hd"><strong class="weui_dialog_title">选择查看部门</strong></div>
            <div class="weui_dialog_bd">
           		<ul id="treeDemo" class="ztree">
						
				</ul>
            </div>
            <div class="weui_dialog_ft">
               <a href="javascript:;" onclick="closeselect();" class="weui_btn_dialog default">关闭</a>
                <a href="javascript:;" onclick="allselect();" class="weui_btn_dialog default">下载计划统计表</a>
            </div>
        </div>
    </div>
    <!--END dialog1-->
</body>
<script type="text/javascript" charset="utf-8" >
var authconfig=$.parseJSON('${authconfig}');
DingTalkPC.config({
		agentId : authconfig.agentid,
		corpId : authconfig.corpId,
		timeStamp : authconfig.timeStamp,
		nonceStr : authconfig.nonceStr,
		signature : authconfig.signature,
		jsApiList : [ 'runtime.info','runtime.permission.requestAuthCode', 'biz.contact.choose','biz.contact.complexChoose',
						'device.notification.confirm', 'device.notification.alert',
						'device.notification.prompt', 'biz.ding.post',
						'biz.util.openLink','biz.navigation.setRight','biz.navigation.setLeft',
						'device.notification.showPreloader','device.notification.hidePreloader','biz.navigation.close' ]
});
DingTalkPC.ready(function(){
	//获得授权登陆code
	DingTalkPC.runtime.permission.requestAuthCode({
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
			               listtask+=" <a href=\"${ctx}/pcplan/taskview?dd_nav_bgcolor=FF30A8A5&id="+n.id+"\" class=\"weui_media_box weui_media_text \" name=\""+n.id+"\" onclick=\"openplaninfo('"+n.id+"')\">";
				  	    	listtask+="<p class=\"weui_media_desc\">"+n.title+"</p>";
				  	    	listtask+="<ul class=\"weui_media_info\">";
				  	    	listtask+="<li class=\"weui_media_info_meta\">进度："+n.jindu+"%</li>";
								listtask+="<li class=\"weui_media_info_meta\">负责人："+n.fuzherenname+"</li>";
				  	    
				  	    		listtask+="<li class=\"weui_media_info_meta\">"+n.stime+"至"+n.endtime+"</li>";
				  	    	
				  	    
				  	    	listtask+="</ul>";
				  	    	listtask+="</a>";
				  	    	 
		    	     });
		            document.getElementById("deptlistdiv").innerHTML=listtask;
		            var powerlist=data.message.split(",");
		            if(powerlist[0]=="1"){
		            	$("#lookitem").show();
		            }
		            if(powerlist[1]=="1"){
		            	$("#poweritem").show();
		            }
	    	  },
	    	  error: function(xhr, type,error){
	    	    alert('Ajax error!');
	    	  }
	    	});
	    
	    
	    
	    },
	    onFail : function(err) {}

	})
});
DingTalkPC.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});
function closeselect(){
	$("#gohomedialog").hide();
}
function allselect(){
	$("#gohomedialog").hide();
		window.location.href="${ctx}/power/getjindulist";
}
function changedept(){
	$("#gohomedialog").show();
	var setting = {
			data: {
				simpleData: {
					enable: true,
					idKey:"id",
					pIdKey:"parentid"
				}

			},
			callback: {
				onClick: onClick
			}
		};
	//获得部门
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/pcplan/getdept',
  	  data: {},
  	  dataType: 'json',
  	  success: function(data){
  		$.fn.zTree.init($("#treeDemo"), setting, data.userdata);
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});

}
function onClick(event, treeId, treeNode, clickFlag) {
	window.location.href="${ctx}/pcplan/planview?dd_nav_bgcolor=FF30A8A5&power=look&deptid="+treeNode.id;
    }	

</script>
</html>