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
       <link href="${ctx}/static/plancss/header.css" rel="stylesheet" />
    <script src="${ctx}/static/dingding/zepto.min.js"></script>
     <script src="${ctx}/static/dingding/touch.js"></script>
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
        .weui_panel{
        -moz-user-select: none; -khtml-user-select: none; user-select: none;
        -webkit-user-select: none; /* for Chrome */
        }
        .zhuguan{
		   color: white;
		   background-color: #5cb85c;
		   border-radius: 4px;
		   padding-left: 5px;
		   padding-right: 5px;
		}
		.planchind{
			display:none;
		}
		.delfont{
			text-decoration:line-through;
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
.ml20{
 margin-left: 25px;
}
.showlist{
    position: absolute;
    width: 20px;
    height: 40px;
    line-height: 40px;
    text-align: center;
        border-right: 1px solid #DEE0CA;
    cursor: pointer;
    /*  */
}
.rot90{
transform: rotate(90deg);
}   
    </style>
</head>
<body>
<header >
<a href="${ctx}/pcplan/planlist?deptid=${plan.deptid}" class="nav-bar"><span style="  color: #0894ec;" class="glyphicon glyphicon-circle-arrow-left"></span>返回</a>
<a class="nav-bar-right" id="add1task" style="display:none" href="${ctx}/pcplan/taskadd?dd_nav_bgcolor=FF30A8A5&deptid=${plan.deptid}&year=${plan.year}&pid=${plan.id}&planid=${plan.id}">添加I级任务</a>
</header>
<div class="container" id="container">
    <div class="tabbar">
        <div class="weui_tab">
            <div class="weui_tab_bd">
                <!--计划信息开始-->
                <div id="planinfo">
 <form id="planform" action="${ctx}/plan/edit" method="POST">
                        <input type="hidden" id="oper" name="oper" value="${oper}"/>
						<input type="hidden" id="deptid" name="deptid" value="${plan.deptid}"/>
						<input type="hidden" id="year" name="year" value="${plan.year}"/>
						<input type="hidden" id="id" name="id" value="${plan.id}"/>
						<input type="hidden" id="pid" name="pid" value="${plan.pid}"/>
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

                    </form>
                    <input type="button" id="submitadd" onclick="submitform();"
                           class="weui_btn weui_btn_primary planchind"
                           value="&nbsp;&nbsp;保&nbsp;&nbsp;存&nbsp;&nbsp;"/>
                    <input type="button" id="delplan" onclick="delplan('${plan.id}');"
                           class="weui_btn weui_btn_default planchind"
                           value="&nbsp;&nbsp;删&nbsp;&nbsp;除&nbsp;&nbsp;"/>       
                    <input type="button" id="canbtn" onclick=" gohome();" class="weui_btn weui_btn_default planchind"
                           value="&nbsp;&nbsp;取&nbsp;&nbsp;消&nbsp;&nbsp;"/>
                    <a id="planchange" href="${ctx}/pcchange/planchange?id=${plan.id}" class="weui_btn weui_btn_primary planchind" >申请变更</a>
                    <a id="plandel" href="${ctx}/pcchange/plandel?id=${plan.id}" class="weui_btn weui_btn_default planchind" >申请撤销</a>
 </div>
                <!--计划信息结束-->
                <!--子任务列表开始-->
                <div id="planlist" style="display: none">
                    <div class="weui_panel">
                        <div class="weui_panel_hd">计划任务列表</div>
                        <div class="weui_panel_bd" id="tasklistDiv">
                        </div>
                    </div>
                </div>
                <!--子任务列表结束-->
            </div>
            <div class="weui_tabbar">
                <a href="javascript:settabbar(1);" class="weui_tabbar_item weui_bar_item_on" id="info">
                    <div class="weui_tabbar_icon">
                        <img src="${ctx}/static/dingding/icon_nav_cell.png" alt="">
                    </div>
                    <p class="weui_tabbar_label">计划信息</p>
                </a>
                <a href="javascript:settabbar(2);" class="weui_tabbar_item" id="list">
                    <div class="weui_tabbar_icon">
                        <img src="${ctx}/static/dingding/icon_nav_article.png" alt="">
                    </div>
                    <p class="weui_tabbar_label">任务列表</p>
                </a>
            </div>
        </div>
    </div>
</div>
<!--BEGIN actionSheet-->
<div id="actionSheet_wrap">
    <div class="weui_mask_transition" id="mask" style="display: none;"></div>
    <div class="weui_actionsheet" id="weui_actionsheet">
        <div class="weui_actionsheet_menu">
            <div class="weui_actionsheet_cell planchind" id="edittask" >编辑任务</div>
             <div class="weui_actionsheet_cell planchind" id="alldeltask">删除任务</div>
            <div class="weui_actionsheet_cell planchind" id="twotask">添加II级任务</div>
               <div class="weui_actionsheet_cell planchind" id="tasklook">查看任务</div>
            <div class="weui_actionsheet_cell planchind" id="taskchange">申请变更</div>
         
            <div class="weui_actionsheet_cell planchind" id="deltask">申请撤销</div>
            <input type="hidden" id="tpid" name="tpid" />
            <input type="hidden" id="leve" name="leve" />
            <input type="hidden" id="taskstate" name=""taskstate"" />
        </div>
        <div class="weui_actionsheet_action">
            <div class="weui_actionsheet_cell" id="actionsheet_cancel">取消</div>
        </div>
    </div>
</div> 
<!--END actionSheet-->               
</body>
<script type="text/javascript">
var deptid="${plan.deptid}";
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

Zepto(function ($) {
    var clienth = $(window).height() - 42;
    $("#container .weui_tab_bd").css("height", clienth + "px");
    $('#actionsheet_cancel').on('click', function () {
        hideActionSheet( $('#weui_actionsheet'),  $('#mask'));
    });
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

//弹出actiononsheet
function showactionsheet(){
    var mask = $('#mask');
    var weuiActionsheet = $('#weui_actionsheet');
    weuiActionsheet.addClass('weui_actionsheet_toggle');
    mask.show().addClass('weui_fade_toggle')
            .one('click', function () {
               hideActionSheet(weuiActionsheet, mask);
            });;//.focus()//加focus是为了触发一次页面的重排(reflow or layout thrashing),使mask的transition动画得以正常触发
}
//关闭actiononsheet
function hideActionSheet(weuiActionsheet, mask) {
    weuiActionsheet.removeClass('weui_actionsheet_toggle');
    mask.removeClass('weui_fade_toggle');
    mask.on('transitionend', function () {
        mask.hide();
    }).on('webkitTransitionEnd', function () {
        mask.hide();
    });
}
DingTalkPC.ready(function(){
	DingTalkPC.biz.navigation.setLeft({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    showIcon: true,//是否显示icon，true 显示， false 不显示，默认true； 注：具体UI以客户端为准
	    text: '返回',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	        /*
	        {}
	        */
	        //如果control为true，则onSuccess将在发生按钮点击事件被回调
	    	window.location.href="${ctx}/plan/index?dd_nav_bgcolor=FF30A8A5";
	    },
	    onFail : function(err) {}
	});
	//getplanlist();
	initpage();
	
	
	//添加二级任务
	$("#twotask").on('click', function () {
		window.location.href="${ctx}/pcplan/taskadd?dd_nav_bgcolor=FF30A8A5&deptid=${plan.deptid}&year=${plan.year}&pid="+$("#tpid").val()+"&planid=${plan.id}";
	});
	//编辑当前任务
	$("#edittask").on('click', function () {
		window.location.href="${ctx}/pcplan/taskadd?dd_nav_bgcolor=FF30A8A5&id="+$("#tpid").val();
	});
	//查看任务
	$("#tasklook").on('click', function () {
		window.location.href="${ctx}/pcplan/taskview?dd_nav_bgcolor=FF30A8A5&id="+$("#tpid").val();
	});
	//申请变更
	$("#taskchange").on('click', function () {
		window.location.href="${ctx}/pcchange/taskchange?dd_nav_bgcolor=FF30A8A5&id="+$("#tpid").val();
	});
	//申请撤销
	$("#deltask").on('click', function () {
		window.location.href="${ctx}/pcchange/taskdel?dd_nav_bgcolor=FF30A8A5&id="+$("#tpid").val();
	});
	
	//删除
	$("#alldeltask").on('click', function () {
		deltask($("#tpid").val());
	}); 
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
  	    alert(data.message);    
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}
function settabbar(type) {
    if (type == 1) {
        $("#planinfo").css("display", "block");
        $("#info").addClass("weui_bar_item_on");
        $("#planlist").css("display", "none");
        $("#list").removeClass("weui_bar_item_on");
    } else {
    	if($(".weui_media_box").length==0){
    		getoneleveltask("${plan.id}");
    	}
        $("#planinfo").css("display", "none");
        $("#info").removeClass("weui_bar_item_on");
        $("#planlist").css("display", "block");
        $("#list").addClass("weui_bar_item_on");
    }
}
//子任务点击
function openplaninfo(planid){
	 event.stopPropagation();
    if($("#"+planid).css("display")=="block"){
       $("#"+planid).hide();
       $("#"+planid+"rot").css("transform","rotate(0deg)");
    }else{
    	if($("#"+planid).children().length==0){
    		gettwoleveltask(planid);
    	}
        $("#"+planid).show();
        $("#"+planid+"rot").css("transform","rotate(90deg)");
    }
}
//获得一级任务
function getoneleveltask(pid){
	$.ajax({
	  	  type: 'POST',
	  	  url: '${ctx}/plan/gettask',
	  	  data: { pid: pid
	  	  		},
	  	  dataType: 'json',
	  	  success: function(data){
	  	    var listdept="";
	  	    var listtask="";
	  	     $.each(data.userdata,function(i,n){
	  	    	 
	  	    	listtask+=" <a  class=\"weui_media_box weui_media_text onetask ";
	  	    	if(n.isdel=="1"){
	  	    		listtask+=" delfont \" name=\""+n.id+"\" >";
	  	    	}else{
	  	    		listtask+=" \" name=\""+n.id+"\">";
	  	    	}
	  	    	listtask+="<div class=\"showlist\" onclick=\"openplaninfo('"+n.id+"')\" ><div id=\""+n.id+"rot\">\></div></div>";
	  	    	listtask+="<p  class=\"weui_media_desc ml20\">Ⅰ级:"+n.title+"</p>";
	  	    	listtask+="<ul class=\"weui_media_info ml20\">";
				if(n.fuzherenname!=null&&n.fuzherenname!=""){
					listtask+="<li class=\"weui_media_info_meta\">负责人："+n.fuzherenname+"</li>";
	  	    	}
	  	    	if(n.stime!=null&&n.stime!=""){
	  	    		listtask+="<li class=\"weui_media_info_meta\">"+n.stime+"至"+n.endtime+"</li>";
	  	    	}
	  	    
	  	    	listtask+="</ul>";
	  	    	
	  	    	if(n.fuzherenname!=null&&n.fuzherenname!=""){
		  	    	listtask+="<div style=\"width: 20px;height: 20px; background-color: #FFFFFF;position: absolute; right: 15px;top: 5px; font-size: 12px;line-height: 20px;vertical-align: middle;text-align: center;border-radius: 50%;border: 1px solid #0BB20C;\">";
		  	    	listtask+=n.zcbg;
		  	    	listtask+="</div>";
		  	    	listtask+="<div style=\"width: 20px;height: 20px; background-color: #FFFFFF;position: absolute; right: 15px;top: 28px; font-size: 12px;line-height: 20px;vertical-align: middle;text-align: center;border-radius: 50%;border: 1px solid #C90014;\">";
		  	    	listtask+=n.fzcbg;
		  	    	listtask+="</div>";
		  	    	listtask+="<div class=\"weui_progress\">";
		  	    	listtask+="    <div class=\"weui_progress_bar\">";
		  	    	listtask+="       <div class=\"weui_progress_inner_bar js_progress\" style=\"width: "+n.jindu+"%;\"></div>";
		  	    	listtask+="   </div>";
		  	    	listtask+="   <div  class=\"weui_progress_opr\">";
		  	    	listtask+=n.jindu+"%";
		  	    	listtask+="    </div>";
		  	    	listtask+="</div>";
	  	    	}
	  	    	
	  	    	
	  	    	
	  	    	listtask+="</a>";
	  	    	listtask+=" <div class=\"planchind\"  id=\""+n.id+"\" ></div>";
	  	    	 
	  	     	});
		            document.getElementById("tasklistDiv").innerHTML=listtask;
		            $('.onetask').on('click',function(){
		            	showactionsheet();
		            	$("#tpid").val($(this).attr("name"));
		            	$("#leve").val("1");
		            	if( $("#taskstate").val()=="1"){
		            		$("#twotask").show();
		            	}
		            	});
		           
	  	  },
	  	  error: function(xhr, type,error){
	  	    alert('Ajax error!');
	  	  }
	  	});
}

//获得二级任务
function gettwoleveltask(pid){
	$.ajax({
	  	  type: 'POST',
	  	  url: '${ctx}/plan/gettask',
	  	  data: { pid: pid
	  	  		},
	  	  dataType: 'json',
	  	  success: function(data){
	  	    var listdept="";
	  	    var listtask="<div class=\"weui_panel_bd\" style=\"width: 95%;margin-left: 30px;\">";
	  	    
	  	     $.each(data.userdata,function(i,n){
	  	    	 
	  	    	listtask+=" <a  class=\"weui_media_box weui_media_text twotask ";
	  	    		if(n.isdel=="1"){
		  	    		listtask+=" delfont \" name=\""+n.id+"\" >";
		  	    	}else{
		  	    		listtask+=" \" name=\""+n.id+"\" >";
		  	    	}
	  	    	
	  	    	listtask+="<p class=\"weui_media_desc\">Ⅱ级:"+n.title+"</p>";
	  	    	listtask+="<ul class=\"weui_media_info\">";
				if(n.fuzherenname!=null&&n.fuzherenname!=""){
					listtask+="<li class=\"weui_media_info_meta\">负责人："+n.fuzherenname+"</li>";
	  	    	}
	  	    	if(n.stime!=null&&n.stime!=""){
	  	    		listtask+="<li class=\"weui_media_info_meta\">"+n.stime+"至"+n.endtime+"</li>";
	  	    	}
	  	    
	  	    	listtask+="</ul>";
	  	    	if(n.fuzherenname!=null&&n.fuzherenname!=""){
		  	    	listtask+="<div style=\"width: 20px;height: 20px; background-color: #FFFFFF;position: absolute; right: 15px;top: 5px; font-size: 12px;line-height: 20px;vertical-align: middle;text-align: center;border-radius: 50%;border: 1px solid #0BB20C;\">";
		  	    	listtask+=n.zcbg;
		  	    	listtask+="</div>";
		  	    	listtask+="<div style=\"width: 20px;height: 20px; background-color: #FFFFFF;position: absolute; right: 15px;top: 28px; font-size: 12px;line-height: 20px;vertical-align: middle;text-align: center;border-radius: 50%;border: 1px solid #C90014;\">";
		  	    	listtask+=n.fzcbg;
		  	    	listtask+="</div>";
		  	    	listtask+="<div class=\"weui_progress\">";
		  	    	listtask+="    <div class=\"weui_progress_bar\">";
		  	    	listtask+="       <div class=\"weui_progress_inner_bar js_progress\" style=\"width: "+n.jindu+"%;\"></div>";
		  	    	listtask+="   </div>";
		  	    	listtask+="   <div  class=\"weui_progress_opr\">";
		  	    	listtask+=n.jindu+"%";
		  	    	listtask+="    </div>";
		  	    	listtask+="</div>";
	  	    	}
	  	    	listtask+="</a>";
	  	    	 
	  	     	});
	  	   listtask+="</div>";
		            document.getElementById(pid).innerHTML=listtask;
		            $('.twotask').on('click',function(){
		            	$("#twotask").hide();
		            	showactionsheet();
		            	$("#tpid").val($(this).attr("name"));
		            	$("#leve").val("1");
		            	});
		           
	  	  },
	  	  error: function(xhr, type,error){
	  	    alert('Ajax error!');
	  	  }
	  	});
}

function initpage(){
	 if("${power}"=="look"||"${power}"=="shenpi"){
	    	return;
	    }
	$.ajax({
	  	  type: 'POST',
	  	  url: '${ctx}/check/getstate',
	  	  data: { deptid: deptid,
	  		  	year:"${plan.year}"
	  	  		},
	  	  dataType: 'json',
	  	  success: function(data){
	  	    var state=data.userdata;
	  	    $("#taskstate").val(state);
	  	   
	  	    if(state=="1"){
	  	    	$("#submitadd").show();
	  	    	$("#add1task").show();
	  	    	$("#delplan").show();
	  	    	$("#alldeltask").show();
	  	    	//长按菜单
	  	    	$("#edittask").show();
	  	    	$("#twotask").show();
	  	    }else{
	  	    	$("#tasklook").show();
	  	    	$("#taskchange").show();
	  	    	$("#deltask").show();
	  	    	$("#planchange").css("display","block");
	  	    	$("#plandel").css("display","block");
	  	     }
		           
	  	  },
	  	  error: function(xhr, type,error){
	  	    alert('Ajax error!');
	  	  }
	  	});
}
function delplan(id){
	$.ajax({
	  	  type: 'POST',
	  	  url: '${ctx}/plan/delplan',
	  	  data: {
	  		  id: id
	  	  		},
	  	  dataType: 'json',
	  	  success: function(data){
	  		window.location.href="${ctx}/pcplan/planlist?deptid=${plan.deptid}";
		  },
	  	  error: function(xhr, type,error){
	  	    alert('Ajax error!');
	  	  }
	  	});
}
function deltask(id){
	$.ajax({
	  	  type: 'POST',
	  	  url: '${ctx}/plan/deltask',
	  	  data: {
	  		  id: id
	  	  		},
	  	  dataType: 'json',
	  	  success: function(data){
	  		 hideActionSheet( $('#weui_actionsheet'),  $('#mask'));
	  		getoneleveltask("${plan.id}");
		  },
	  	  error: function(xhr, type,error){
	  	    alert('Ajax error!');
	  	  }
	  	});
}
</script>
</html>