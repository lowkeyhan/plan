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
<header >
<a href="${ctx}/pcplan/planlist?deptid=${plan.deptid}" class="nav-bar"><span style="  color: #0894ec;" class="glyphicon glyphicon-circle-arrow-left"></span>返回</a>
</header>
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
                                <div class="weui_cell_hd"><label class="weui_label">计划名称</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="title"  name="title"
                                           type="text" value='${plan.title}'>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell weui_cell_select weui_select_after">
                                <div class="weui_cell_hd">
                                    <label for="" class="weui_label">计划级别</label>
                                </div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <select class="weui_select" name="level" id=selectlevel>
                                        <option value="公司计划">公司计划</option>
                                        <option value="部门计划">部门计划</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell weui_cell_select weui_select_after">
                                <div class="weui_cell_hd">
                                    <label for="" class="weui_label">计划类别</label>
                                </div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <select class="weui_select" name="type" id="selecttype">
                                        <option value="管理类计划">管理类计划</option>
                                        <option value="研发类计划">研发类计划</option>
                                        <option value="项目类计划">项目类计划</option>
                                        <option value="营销类计划">营销类计划</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">计划目标</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="target" name="target"
                                           type="text" value='${plan.target}'>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">权重比例</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="weight"  name="weight"
                                           type="number" value='${plan.weight}'>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">考核指标</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="ssessmentindex"  name="ssessmentindex"
                                           type="text" value='${plan.ssessmentindex}'>
                                </div>
                            </div>
                        </div>

						 <div class="weui_cells weui_cells_form">
				        <div class="weui_cell">
				            <div class="weui_cell_bd weui_cell_primary">
				                <textarea class="weui_textarea" placeholder="请输入变更原因" rows="3" id="changesm" name="changesm"></textarea>
				               
				            </div>
				        </div>
				   		 </div>
                    </form>
                    <input type="button" id="submit_${uuid}" onclick="submitform();"
                           class="weui_btn weui_btn_primary"
                           value="&nbsp;&nbsp;提&nbsp;&nbsp;交&nbsp;&nbsp;"/>
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
Zepto(function ($) {
    if("${plan.type}"==""){
		$("#selecttype").val("管理类计划");
	}else{
		$("#selecttype").val("${plan.type}");
	}
    if("${plan.level}"==""){
		$("#selectlevel").val("公司计划");
	}else{
		$("#selectlevel").val("${plan.level}");
	}
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
  	  location.href="${ctx}/pcplan/planedit?id=${plan.id}&pwoer=true";
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}

</script>
</html>