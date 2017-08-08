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

 <form id="planform" action="${ctx}/plan/edit" method="POST">
                        <input type="hidden" id="oper" name="oper" value="${oper}"/>
						<input type="hidden" id="deptid" name="deptid" value="${plan.deptid}"/>
						<input type="hidden" id="year" name="year" value="${plan.year}"/>
						<input type="hidden" id="pid" name="pid" value="${plan.pid}"/>
						<input type="hidden" id="planid" name="planid" value="${plan.planid}"/>
						<input type="hidden" id="id" name="id" value="${plan.id}"/>
						<input type="hidden" id="taskid" name="taskid" value="${plan.id}"/>
						<input type="hidden" id="jindu" name="jindu" value="${plan.jindu}"/>
						<input type="hidden" id="zcbg" name="zcbg" value="${plan.zcbg}"/>
						<input type="hidden" id="fzcbg" name="fzcbg" value="${plan.fzcbg}"/>
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
						 <div class="weui_cells weui_cells_form">
				        <div class="weui_cell">
				            <div class="weui_cell_bd weui_cell_primary">
				                <textarea class="weui_textarea" placeholder="请输入变更原因" rows="5" id="changesm" name="changesm"></textarea>
				               
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
<script src='${ctx}/static/planjs/dingpublic.js'></script>
<script type="text/javascript">
dd.ready(function(){
	changepeople($("#fuzherenname"),$("#fuzherenid"));
	    
});
dd.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});


//
function submitform(){
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/change/savechange',
  	  data: $("#planform").serialize(),
  	  dataType: 'json',
  	  success: function(data){
  		successalert(data.message);    
  	  location.href="${ctx}/plan/planedit?id=${plan.planid}&pwoer=true";
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}

</script>
</html>