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
    <link href="${ctx}/static/plancss/lookview.css" rel="stylesheet" />
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
		.weui_media_box.weui_media_text .weui_media_info {
		    margin-top: 5px;
		    padding-bottom: 5px;
		    font-size: 13px;
		    color: #cecece;
		    line-height: 16px;
		    list-style: none;
		    overflow: hidden;
		}
		.weui_progress_opr {
    display: block;
    margin-left: 15px;
    font-size: 12px;
}
.weui_media_box {
    padding: 10px 15px;
    position: relative;
}
    </style>
</head>
<body>
<script type="text/javascript">
var authconfig=$.parseJSON('${authconfig}');
</script>
<script src="${ctx}/static/planjs/dingpublic.js"></script>
<script type="text/javascript">
var deptid="${deptid}";
var deptname="${deptname}";


dd.ready(function(){
	//指定默认年份
	$("#selectyear").val("${year}");
	//加载默认年份计划
	getplanlist();
	//设置标题
	dd.biz.navigation.setTitle({
        title: deptname,
        onSuccess: function(data) {
        },
        onFail: function(err) {
            log.e(JSON.stringify(err));
        }
    });

	initpage();
	    
});
dd.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});


//
function getplanlist(){
	$.ajax({
  	  type: 'POST',
  	  url: '${ctx}/plan/getplanjindu',
  	  data: { deptid: deptid,
  		  	year:$("#selectyear").val()	
  	  		},
  	  dataType: 'json',
  	  success: function(data){
  	    var listdept="";
  	     $.each(data.userdata,function(i,n){
  	    	 listdept+="<a href=\"${ctx}/plan/planedit?id="+n.id+"&power=${power}\" class=\"weui_media_box weui_media_text\">";
  	    	 listdept+="<p class=\"weui_media_desc\">"+n.title+"</p>";
  	    	 listdept+="<ul class=\"weui_media_info\">";
  	    	 listdept+="<li class=\"weui_media_info_meta\">创建人:"+n.operationer+"</li>";
  	    	 listdept+="<li class=\"weui_media_info_meta\">"+n.level+"</li>";
  	    	 listdept+="<li class=\"weui_media_info_meta weui_media_info_meta_extra\">权重："+n.weight+"%</li>";
  	    	 listdept+="</ul>";
  	    	 
  	    	listdept+="<div class=\"weui_progress\">";
  	    	listdept+="    <div class=\"weui_progress_bar\">";
  	    	listdept+="       <div class=\"weui_progress_inner_bar js_progress\" style=\"width: "+n.jindu+"%;\"></div>";
  	    	listdept+="   </div>";
  	    	listdept+="   <div  class=\"weui_progress_opr\">";
  	    	listdept+=n.jindu+"%";
  	    	listdept+="    </div>";
  	    	listdept+="</div>";
  	    	
  	    	 listdept+="</a>";
  	     	});
	            document.getElementById("planlistdiv").innerHTML=listdept;
	           
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}
</script>
<div class="weui_panel">
    <div class="weui_panel_hd">
     <select  name="selectyear" id="selectyear" onchange="getplanlist();initpage()">
            <option value="2015" >2015年</option>
            <option value="2016">2016年</option>
            <option value="2017">2017年</option>
     </select>计划列表
    </div>
    <div class="weui_panel_bd" id="planlistdiv">
      

    </div>
</div>
<div class="approve-foot show">
<div class="tFlexbox tAlignCenter tJustifyCenter" id="btnlist">

</div>
</div>
</body>
<script>
function addplan(){
	window.location.href="${ctx}/plan/planadd?dd_nav_bgcolor=FF30A8A5&deptid="+deptid+"&year="+$("#selectyear").val();
	
}
function opencheck(){
	window.location.href="${ctx}/check/shenpiadd?dd_nav_bgcolor=FF30A8A5&checkid=${checkid}";
	
}
function initpage(){
	if("${power}"=="look"){return;}
	if("${power}"=="shenpi"){
		btnlist="<div class=\"tFlex1 approval-action tTap agree\"  onclick=\"opencheck()\" >审核</div>";
	    
	  document.getElementById("btnlist").innerHTML=btnlist;	
	  return;
	}
	$.ajax({
	  	  type: 'POST',
	  	  url: '${ctx}/check/getstate',
	  	  data: { deptid: deptid,
	  		  	year:$("#selectyear").val()	
	  	  		},
	  	  dataType: 'json',
	  	  success: function(data){
	  	    var state=data.userdata;
	  	    var btnlist="";
	  	    if(state=="1"){
	  	    	btnlist="<div class=\"tFlex1 approval-action tTap agree\" onclick=\"addplan()\" >添加计划</div>";
	  	    	btnlist+="<div class=\"tFlex1 approval-action tTap agree\"  onclick=\"submitplan()\" >提交计划</div>";
	  	    	
	  	    }else{
	  	    	btnlist="<div class=\"tFlex1 approval-action tTap agree\"  onclick=\"lookcheck("+data.message+")\" >查看审核记录</div>";
	  	    }
	  	  document.getElementById("btnlist").innerHTML=btnlist;	
		           
	  	  },
	  	  error: function(xhr, type,error){
	  	    alert('Ajax error!');
	  	  }
	  	});
}
function submitplan(){
	$.ajax({
	  	  type: 'POST',
	  	  url: '${ctx}/check/subplan',
	  	  data: { deptid: deptid,
	  		  	year:$("#selectyear").val(),
	  		  	deptname:deptname,
	  	  		},
	  	  dataType: 'json',
	  	  success: function(data){
	  		successalert(data.userdata);
	  		initpage();
	  	  },
	  	  error: function(xhr, type,error){
	  	    alert('Ajax error!');
	  	  }
	  	});
}
function lookcheck(checkid){
	window.location.href="${ctx}/check/shenheview?dd_nav_bgcolor=FF30A8A5&checkid="+checkid;
	
}
</script>               
</html>