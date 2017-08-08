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
  
       <link href="${ctx}/static/plancss/header.css" rel="stylesheet" />
    <link href="${ctx}/static/dingding/weui.min.css" rel="stylesheet" />
    <script src="${ctx}/static/dingding/zepto.min.js"></script>
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
    </style>
</head>
<body>
<script type="text/javascript">
var deptid="${deptid}";
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
	    
});
DingTalkPC.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});


//
function submitplan(state){
	var nowstate='1';
	if(state=='2'){
		nowstate='3';
	}else if(state=='3'){
		nowstate='4';
	}else{
		nowstate='1';
	}
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/check/shenpistate',
  	  data: {
  		state:nowstate,
  		checkid:"${plancheck.id}",
  		shuju:$("#shuju").val()
  	  },
  	  dataType: 'json',
  	  success: function(data){
  	    alert(data.userdata);    
  	  location.href="${ctx}/pccheck/checklist";
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}

</script>
<header >
<a href="${ctx}/pcplan/planlist?deptid=${plancheck.deptid}" class="nav-bar"><span style="  color: #0894ec;" class="glyphicon glyphicon-circle-arrow-left"></span>返回</a>
</header>
 <form id="planform" action="${ctx}/plan/edit" method="POST">
						<input type="hidden" id="id" name="id" value="${plancheck.id}"/>
                        <input type="hidden" id="state" name="state" value="${plancheck.state}"/>
                        <div class="weui_cells weui_cells_access">
					        <a class="weui_cell" href="${ctx}/pcplan/planview?dd_nav_bgcolor=FF30A8A5&checkid=${plancheck.id}&deptid=${plancheck.deptid}&power=shenpi">
					            <div class="weui_cell_bd weui_cell_primary">
					                <p>${plancheck.year}年${plancheck.deptname}${plancheck.type}</p>
					            </div>
					            <div class="weui_cell_ft">
					            </div>
					        </a>
					    </div>
                        
                       <div class="weui_cells weui_cells_form">
				        <div class="weui_cell">
				            <div class="weui_cell_bd weui_cell_primary">
				                <textarea class="weui_textarea" placeholder="请输入评论" rows="5" id="shuju"></textarea>
				               
				            </div>
				        </div>
				   		 </div>
                       

                    </form>
                    <div class="approve-foot show">
<div class="tFlexbox tAlignCenter tJustifyCenter" id="btnlist">
<div class="tFlex1 approval-action tTap agree"  onclick="submitplan('${plancheck.state}')" >同意</div>
<div class="tFlex1 approval-action tTap agree"  onclick="submitplan('0')" >拒绝</div>	  	    	
</div>
</div>
</body>
</html>