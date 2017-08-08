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

 <form id="planform"  method="POST">
                        <input type="hidden" id="oper" name="oper" value="${oper}"/>
						<input type="hidden" id="id" name="id" value="${power.id}"/>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell weui_cell_select weui_select_after">
                                <div class="weui_cell_hd">
                                    <label for="" class="weui_label">权限类别</label>
                                </div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <select class="weui_select" name="type" id="type" onchange="typeChange()" >
                                        <option value="主管副总审批">主管副总审批审批</option>
                                        <option value="总经理助理审批">总经理助理审批</option>
                                        <option value="所有计划查看">所有所有计划查看</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">权限人员</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="adminname"  name="adminname"
                                           type="text" value='${power.adminname}'>
                                            <input  type="hidden"  id="adminid"  name="adminid"
                                           type="text" value='${power.adminid}'>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form" id="zhuguanbumen">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">主管部门</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                     <input  id="deptid"  name="deptid"
                                           type="hidden" value='${power.deptid}'>
                                            <input class="weui_input" type="text"  id="deptname"  name="deptname"
                                           type="text" value='${power.deptname}'>
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
	if("${power.type}"==""){
		$("#type").val("主管副总审批");
	}else{
		$("#type").val("${power.type}");
	}
	
	changepeople($("#adminname"),$("#adminid"));
	changedept($("#deptname"),$("#deptid"));
});
dd.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});


//
function submitform(){
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/power/addpower',
  	  data: $("#planform").serialize(),
  	  dataType: 'json',
  	  success: function(data){
  		successalert(data.message);    
  	  location.href="${ctx}/power/admin";
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}
function typeChange(){
	var selectval=$("#type").val();
	if(selectval=="主管副总审批"){
		$("#zhuguanbumen").show();
	}else{
		$("#zhuguanbumen").hide();
	}
}
</script>
</html>