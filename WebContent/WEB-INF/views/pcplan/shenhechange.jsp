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
     <link href="${ctx}/static/plancss/lookview.css" rel="stylesheet" />
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
                <p>变更前</p>
            </div>
            <div class="weui_cell_ft">
            </div>
        </a>
    </div>
<form class="look" >
 <div class="weui_cells weui_cells_form">
     <div class="weui_cell">
         <div class="weui_cell_hd"><label class="weui_label">任务内容</label></div>
         <div class="weui_cell_bd weui_cell_primary">
             <input class="weui_input" readonly="readonly"
                    type="text" value='${plan.title}'>
         </div>
     </div>
     <div class="weui_cell">
          <div class="weui_cell_hd"><label class="weui_label">开始时间</label></div>
          <div class="weui_cell_bd weui_cell_primary">
         <input class="weui_input" readonly="readonly"
                     type="date" value='${plan.stime}'>
          </div>
      </div>
     <div class="weui_cell">
          <div class="weui_cell_hd">
              <label for="" class="weui_label">结束时间</label>
          </div>
          <div class="weui_cell_bd weui_cell_primary">
               <input class="weui_input" readonly="readonly"
                     type="date" value='${plan.endtime}'>
          </div>
      </div>
       <div class="weui_cell">
           <div class="weui_cell_hd"><label class="weui_label">负责人</label></div>
           <div class="weui_cell_bd weui_cell_primary">
               <input class="weui_input" readonly="readonly"
                      type="text" value='${plan.fuzherenname}'>
           </div>
       </div>
        <div class="weui_cell">
            <div class="weui_cell_hd"><label class="weui_label">资源配置</label></div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" readonly="readonly"
                       type="text" value='${plan.ziyuanpeizhi}'>
            </div>
        </div>
 </div>
</form>
 <div class="weui_cells weui_cells_access">
        <a class="weui_cell" href="javascript:;" onclick="lookoldnews()">
            <div class="weui_cell_bd weui_cell_primary">
                <p>变更后</p>
            </div>
            <div class="weui_cell_ft">
            </div>
        </a>
    </div>
 <form id="planform"  method="POST" class="look">
						<input type="hidden" id="deptid" name="deptid" value="${changeplan.deptid}"/>
						<input type="hidden" id="year" name="year" value="${changeplan.year}"/>
						<input type="hidden" id="pid" name="pid" value="${changeplan.pid}"/>
						<input type="hidden" id="planid" name="planid" value="${changeplan.planid}"/>
						<input type="hidden" id="id" name="id" value="${changeplan.id}"/>
						<input type="hidden" id="jindu" name="jindu" value="${changeplan.jindu}"/>
                        <div class="weui_cells weui_cells_form">
                     
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">任务内容</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="title"  name="title" readonly="readonly"
                                           type="text" value='${changeplan.title}'>
                                </div>
                            </div>
                        <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">开始时间</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                               <input class="weui_input" id="stime"  name="stime" readonly="readonly"
                                           type="date" value='${changeplan.stime}'>
                                </div>
                            </div>
                           <div class="weui_cell">
                                <div class="weui_cell_hd">
                                    <label for="" class="weui_label">结束时间</label>
                                </div>
                                <div class="weui_cell_bd weui_cell_primary">
                                     <input class="weui_input" id="endtime"  name="endtime" readonly="readonly"
                                           type="date" value='${changeplan.endtime}'>
                                </div>
                            </div>
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">负责人</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="fuzherenname"  name="fuzherenname" readonly="readonly"
                                           type="text" value='${changeplan.fuzherenname}'>
                                            <input  type="hidden"  id="fuzherenid"  name="fuzherenid"
                                           type="text" value='${changeplan.fuzherenid}'>
                                </div>
                            </div>
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">资源配置</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="ziyuanpeizhi"  name="ziyuanpeizhi" readonly="readonly"
                                           type="text" value='${changeplan.ziyuanpeizhi}'>
                                </div>
                            </div>
				        <div class="weui_cell">
				        <div class="weui_cell_hd"><label class="weui_label">变更说明</label></div>
				            <div class="weui_cell_bd weui_cell_primary">
				                <textarea class="weui_textarea"   rows="5" id="changesm" name="changesm">${changeplan.changesm}</textarea>
				               
				            </div>
				        </div>
				   		 </div>
                    </form>
  <div class="weui_cells weui_cells_form" id="changediv" style="display:none;margin-bottom: 100px;" >
    <div class="weui_cell weui_cell_select weui_select_after">
        <div class="weui_cell_hd">
            <label for="" class="weui_label">变更性质</label>
        </div>
        <div class="weui_cell_bd weui_cell_primary">
            <select class="weui_select" id="changexz">
             <option value="2">请选择</option>
                <option value="1">正常变更</option>
                <option value="0">非正常变更</option>
            </select>
        </div>
    </div>
</div>
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
	if("${plancheck.state}"=="3"){
		$('#changediv').show();
		$("#changexz").val("2");
	}
	
	
});
DingTalkPC.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});


//
function submitplan(state){
	if(state=="2"){
		state="3";
	}else if(state=="3"){
		state="4";
		if($("#changexz").val()=="2"){
			successalert("请选择变更性质"); 
			return ;
		}
	}else if(state=="5"){
		state="5";
	}
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/change/shstate',
  	  data: {
  		  state:state,
  		  tid:'${plan.id}',
  		  cid:'${changeplan.id}',
  		  id:'${plancheck.id}',
  		  changexz:$("#changexz").val()
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