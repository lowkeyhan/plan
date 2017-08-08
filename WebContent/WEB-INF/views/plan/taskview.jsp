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
		.hidediv{
			display:none;
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
						<input type="hidden" id="jindu" name="jindu" value="${plan.jindu}"/>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">任务内容</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="title"  name="title" readOnly="true"
                                           type="text" value='${plan.title}' >
                                </div>
                            </div>
                        <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">开始时间</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                               <input class="weui_input" id="stime"  name="stime" readOnly="true"
                                           type="date" value='${plan.stime}'>
                                </div>
                            </div>
                           <div class="weui_cell">
                                <div class="weui_cell_hd">
                                    <label for="" class="weui_label">结束时间</label>
                                </div>
                                <div class="weui_cell_bd weui_cell_primary">
                                     <input class="weui_input" id="endtime"  name="endtime" readOnly="true"
                                           type="date" value='${plan.endtime}'>
                                </div>
                            </div>
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">负责人</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="fuzherenname"  name="fuzherenname" readOnly="true"
                                           type="text" value='${plan.fuzherenname}'>
                                            <input  type="hidden"  id="fuzherenid"  name="fuzherenid"
                                           type="text" value='${plan.fuzherenid}'>
                                </div>
                            </div>
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">资源配置</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="ziyuanpeizhi"  name="ziyuanpeizhi" readOnly="true"
                                           type="text" value='${plan.ziyuanpeizhi}'>
                                </div>
                            </div>
                        </div>

                    </form>
 <div class="weui_cells weui_cells_form hidediv" id="jindudiv">
	<div class="weui_cell">
	           <div class="weui_cell_hd"><label class="weui_label">进度</label></div>
	           <div class="weui_cell_bd weui_cell_primary">
	               <input class="weui_input" id="newjindu"  name="newjindu" 
	                      type="number" value='${plan.jindu}'>
	    		</div>
	    		<div class="weui_cell_ft">
	                %
	            </div>
	</div>
	<div class="weui_cell">
	           <div class="weui_cell_hd"><label class="weui_label">说明</label></div>
	           <div class="weui_cell_bd weui_cell_primary">
	               <input class="weui_input" id="shuoming"  name="shuoming" 
	                      type="text" value=''>
	    		</div>
	</div>
</div>
<div id="allrecord" class="approval-tline-box">

</div>

 <div id="btnlist"></div>             

                  
</body>
<script type="text/javascript">
//var deptid="${deptid}";
var authconfig=$.parseJSON('${authconfig}');
</script>
<script src='${ctx}/static/planjs/dingpublic.js'></script>
<script type="text/javascript">
dd.ready(function(){
	initpage();
	getrecord("allrecord","${plan.id}","jindu","${ctx}");
});
dd.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});


//
function submitplan(){
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/checklog/addjindu',
  	  data: {
	  		taskid:"${plan.id}",
	  		shuju:$("#newjindu").val(),
	  		shuoming:$("#shuoming").val(),
	  		type:"jindu"
	  	  },
  	  dataType: 'json',
  	  success: function(data){
  		alert(data.userdata);    
  		getrecord("allrecord","${plan.id}","jindu","${ctx}");
  	 // location.href="${ctx}/plan/planedit?id=${plan.planid}";
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}
function initpage(){
	  	    var state="${fuzhe}";
	  	    var btnlist="";
	  	    if(state!="-1"){
	  	    	btnlist+="<div  class=\"approve-foot show\">";
	  	    	btnlist+="<div class=\"tFlexbox tAlignCenter tJustifyCenter\" >";
	  	    	btnlist+="<div class=\"tFlex1 approval-action tTap agree\"  onclick=\"submitplan()\" >提交进度</div>";
	  	    	
	  	    	btnlist+="</div>";
	  	    		btnlist+="</div>";
	  	    	$("#jindudiv").show();
	  	    }
	  	  document.getElementById("btnlist").innerHTML=btnlist;	
		  
}
//获得进度记录
function getrecord(objid,taskid,type,ctx){
	$.ajax({
	  	  type: 'POST',
	  	  url: ctx+'/checklog/getlog',
	  	  data:{
	  		taskid:taskid,
	  		type:type,
	  	  },
	  	  dataType: 'json',
	  	  success: function(data){
	  		
	  			var listdept="";
	  		listdept+="<div class=\"approval-tline\" >";
	  		 $.each(data.userdata,function(i,n){
	  			listdept+="<div class=\"time-node\" >";
	  			listdept+="<div class=\"node-status\"><i class=\"weui_icon_info\" ></i></div>";
	  			listdept+="<div class=\"nodebox\" >";
	  			listdept+="	<div class=\"arrow\"></div>";
	  			listdept+="	<div class=\"nodebox-inner\">";
	  			listdept+="	<div class=\"node-avatar\">";
	  			listdept+=getnameimg(n.operationer);
	  			listdept+="</div>";
	  			listdept+="		<p class=\"username\">"+n.operationer+"更新进度"+n.shuju+"%</p>";
	  			if(n.shuoming!=null&&n.shuoming!=""){
	  				listdept+="		<p class=\"result-line\">"+n.shuoming+"</p>";
	  			}else{
	  				listdept+="		<p class=\"result-line\"></p>";
	  			}
	  			listdept+="		<div class=\"opreratetime\">"+n.operationdate+"</div>";
	  			listdept+="	</div>";
	  			listdept+="</div>";
	  			listdept+="</div>";
	          });
	  		listdept+="</div>";
	         document.getElementById(objid).innerHTML=listdept;
	  	  },
	  	  error: function(xhr, type,error){
	  	    alert('Ajax error!');
	  	  }
	  });
}
function getnameimg(username){
	var nameimg=username;
	if(username.length>2){
		nameimg=username.substr(username.length-2,2);
	}
	return nameimg;
}
</script>
</html>