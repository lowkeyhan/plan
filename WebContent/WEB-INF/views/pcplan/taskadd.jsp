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
  <script src='http://g.alicdn.com/dingding/dingtalk-pc-api/2.3.1/index.js'></script>
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
		.nav-bar{
	float: left;line-height: 40px;padding-left: 10px;cursor: pointer;font-size: 16px;
}
header{
	height: 40px;width: 100%px;  border-bottom: 1px solid #E7E8EA;margin-bottom: 20px;text-align: center;
}
label{
	font-weight:normal;
}
    </style>
</head>
<body>
<header >
		
<a href="javascript:history.go(-1);" class="nav-bar"><span style="  color: #0894ec;" class="glyphicon glyphicon-circle-arrow-left"></span>返回</a>
</header>
 <form id="planform"  method="POST">
                        <input type="hidden" id="oper" name="oper" value="${oper}"/>
						<input type="hidden" id="deptid" name="deptid" value="${plan.deptid}"/>
						<input type="hidden" id="year" name="year" value="${plan.year}"/>
						<input type="hidden" id="pid" name="pid" value="${plan.pid}"/>
						<input type="hidden" id="planid" name="planid" value="${plan.planid}"/>
						<input type="hidden" id="id" name="id" value="${plan.id}"/>
						<input type="hidden" id="jindu" name="jindu" value="${plan.jindu}"/>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">任务内容</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="title"  name="title"
                                           type="text" value='${plan.title}'>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                        <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">开始时间</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                               <input class="weui_input" id="stime"  name="stime"
                                           type="date" value='${plan.stime}'>
                                </div>
                            </div>
                           <div class="weui_cell">
                                <div class="weui_cell_hd">
                                    <label for="" class="weui_label">结束时间</label>
                                </div>
                                <div class="weui_cell_bd weui_cell_primary">
                                     <input class="weui_input" id="endtime"  name="endtime"
                                           type="date" value='${plan.endtime}'>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">负责人</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="fuzherenname"  name="fuzherenname"
                                           type="text" value='${plan.fuzherenname}'>
                                            <input  type="hidden"  id="fuzherenid"  name="fuzherenid"
                                           type="text" value='${plan.fuzherenid}'>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">资源配置</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="ziyuanpeizhi"  name="ziyuanpeizhi"
                                           type="text" value='${plan.ziyuanpeizhi}'>
                                </div>
                            </div>
                        </div>
						
                    </form>
                    <input type="button" id="submit_${uuid}" onclick="submitform();"
                           class="weui_btn weui_btn_primary"
                           value="&nbsp;&nbsp;保&nbsp;&nbsp;存&nbsp;&nbsp;"/>
                    <input type="button" id="submit_${uuid}" onclick=" gohome();" class="weui_btn weui_btn_default"
                           value="&nbsp;&nbsp;取&nbsp;&nbsp;消&nbsp;&nbsp;"/>
</body>
<script type="text/javascript">
//var deptid="${deptid}";
var authconfig=$.parseJSON('${authconfig}');
</script>
<script src='${ctx}/static/planjs/PCdingpublic.js'></script>
<script type="text/javascript">
DingTalkPC.ready(function(){
	changepeople($("#fuzherenname"),$("#fuzherenid"));
	    
});
DingTalkPC.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});


//
function submitform(){
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/plan/edit',
  	  data: $("#planform").serialize(),
  	  dataType: 'json',
  	  success: function(data){
  		successalert(data.message);    
  	  location.href="${ctx}/pcplan/planedit?id=${plan.planid}";
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}

</script>
</html>