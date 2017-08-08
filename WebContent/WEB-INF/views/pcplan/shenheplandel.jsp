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
     <link href="${ctx}/static/plancss/lookview.css" rel="stylesheet" />
       <link href="${ctx}/static/plancss/header.css" rel="stylesheet" />
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
		.weui_cells {
     margin-top:0px; 
    }
    </style>
</head>
<body>
<header >
		
<a href="javascript:history.go(-1);" class="nav-bar"><span style="  color: #0894ec;" class="glyphicon glyphicon-circle-arrow-left"></span>返回</a>
</header>
 <div class="weui_cells weui_cells_access">
        <a class="weui_cell" href="javascript:;" onclick="lookoldnews()">
            <div class="weui_cell_bd weui_cell_primary">
                <p>撤销任务信息</p>
            </div>
            <div class="weui_cell_ft">
            </div>
        </a>
    </div>
<form class="look" >
 <div class="weui_cells weui_cells_form">
    <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">计划名称</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="title"  name="title"
                                           type="text" value='${plan.title}'>
                                </div>
                            </div>
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
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">计划目标</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="target" name="target"
                                           type="text" value='${plan.target}'>
                                </div>
                            </div>
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">权重比例</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="weight"  name="weight"
                                           type="number" value='${plan.weight}'>
                                </div>
                            </div>
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">考核指标</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="ssessmentindex"  name="ssessmentindex"
                                           type="text" value='${plan.ssessmentindex}'>
                                </div>
                            </div>
         <div class="weui_cell">
            <div class="weui_cell_hd"><label class="weui_label">撤销说明</label></div>
            <div class="weui_cell_bd weui_cell_primary">
            </div>
        </div>
        <div class="weui_cell">
            <div class="weui_cell_bd weui_cell_primary">
                <textarea class="weui_textarea"   rows="5" >${plan.delsm}</textarea>
               
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
<script type="text/javascript">
//var deptid="${deptid}";
var authconfig=$.parseJSON('${authconfig}');
</script>
<script src='${ctx}/static/planjs/PCdingpublic.js'></script>
<script type="text/javascript">
DingTalkPC.ready(function(){
	
	
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
function submitplan(state){
	if(state=="2"){
		state="3";
	}else if(state=="3"){
		state="4";
	}else if(state=="5"){
		state="5";
	}
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/change/shdel',
  	  data: {
  		  state:state,
  		  tid:'${plan.id}',
  		  id:'${plancheck.id}'
  	  },
  	  dataType: 'json',
  	  success: function(data){
  		successalert(data.message);    
  	  location.href="${ctx}/pccheck/checklist";
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}

</script>
</html>