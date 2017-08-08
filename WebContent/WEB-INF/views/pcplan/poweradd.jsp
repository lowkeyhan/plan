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
    <link href="${ctx}/static/ztree/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="${ctx}/static/ztree/jquery-1.4.4.min.js"></script>
    <script src="${ctx}/static/ztree/jquery.ztree.core.js"></script>
    <script src="${ctx}/static/ztree/jquery.ztree.excheck.js"></script>
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
		
<a href="${ctx}/power/pcadmin" class="nav-bar"><span style="  color: #0894ec;" class="glyphicon glyphicon-circle-arrow-left"></span>返回</a>
</header>
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
                                        <option value="主管副总审批">主管副总审批</option>
                                        <option value="总经理助理审批">总经理助理审批</option>
                                        <option value="所有计划查看">所有计划查看</option>
                                        <option value="后台管理">后台管理</option>
                                        <option value="提醒人员">提醒人员</option>
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
                                            <input class="weui_input" type="text" readonly="readonly"  id="deptname"  name="deptname"
                                           type="text" value='${power.deptname}'>
                                </div>
                            </div>
                        </div>
                         <div class="weui_cells weui_cells_form" id="deptselect" >
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">选择部门</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                     <ul id="treeDemo" class="ztree">
						
						</ul>
                                </div>
                            </div>
                        </div>
						
                    </form>
                    <input type="button" id="submit_${uuid}" onclick="submitform();"
                           class="weui_btn weui_btn_primary"
                           value="&nbsp;&nbsp;保&nbsp;&nbsp;存&nbsp;&nbsp;"/>
                    <input type="button" id="submit_${uuid}" onclick=" goadmin();" class="weui_btn weui_btn_default"
                           value="&nbsp;&nbsp;取&nbsp;&nbsp;消&nbsp;&nbsp;"/>
</body>
<script type="text/javascript">
//var deptid="${deptid}";
var authconfig=$.parseJSON('${authconfig}');
</script>
<script src='${ctx}/static/planjs/PCdingpublic.js'></script>
<script type="text/javascript">
DingTalkPC.ready(function(){
	if("${power.type}"==""){
		$("#type").val("主管副总审批");
	}else{
		$("#type").val("${power.type}");
	}
	typeChange();
	var setting = {
			check: {
				chkboxType: { "Y": "", "N": "" },
				enable: true
			},
			data: {
				simpleData: {
					enable: true,
					idKey:"id",
					pIdKey:"parentid"
				}

			},
			callback: {
				onCheck: onCheck
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
	
	ppchangepeople($("#adminname"),$("#adminid"));
	//changedept($("#deptname"),$("#deptid"));
});
DingTalkPC.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});
function ppchangepeople(clickinputobj,idobj){
	clickinputobj.click( function () {
		 var useridlist='';
		 if(idobj.val()){
			 useridlist=idobj.val();
		 }
		
		 DingTalkPC.biz.contact.choose({
			  multiple: true, //是否多选： true多选 false单选； 默认true
			  users:  useridlist.split(","), //默认选中的用户列表，userid；成功回调中应包含该信息
			  corpId: authconfig.corpId, //企业id
			  max: 500, //人数限制，当multiple为true才生效，可选范围1-1500
			  onSuccess: function(data) {
			  //onSuccess将在选人结束，点击确定按钮的时候被回调
			  var names='';
			  var nameids='';
				  for(var i=0; i<data.length; i++)  
				  {  
					  names=names+ data[i].name+",";
					  nameids=nameids+data[i].emplId+",";
				  }  
				  clickinputobj.val(names.substring(0,names.length-1));
				  idobj.val(nameids.substring(0,nameids.length-1));
			  },
			  onFail : function(err) {}
			});;
		});
}

function onCheck(e, treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	nodes = zTree.getChangeCheckedNodes();
	var names='';
	  var nameids='';
	  for (var i=0, l=nodes.length; i<l; i++) {
			  names=names+ nodes[i].name+",";
			  nameids=nameids+nodes[i].id+",";
		  }  
	  $("#deptname").val(names.substring(0,names.length-1));
	  $("#deptid").val(nameids.substring(0,nameids.length-1));
	
}
function goadmin(){
	 location.href="${ctx}/power/pcadmin";
}
//
function submitform(){
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/power/addpower',
  	  data: $("#planform").serialize(),
  	  dataType: 'json',
  	  success: function(data){
  		successalert(data.message);    
  	  location.href="${ctx}/power/pcadmin";
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
		$("#deptselect").show();
		
	}else{
		$("#zhuguanbumen").hide();
		$("#deptselect").hide();
	}
}
</script>
</html>