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
<script type="text/javascript">
var deptid="${deptid}";
var authconfig=$.parseJSON('${authconfig}');
dd.config({
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
    var clienth = $(window).height() - 2;
    $("#container .weui_tab_bd").css("height", clienth + "px");
})
dd.ready(function(){
	//指定默认年份
	$("#selectyear").val("${year}");
	
	getplanlist();
	    
});
dd.error(function(err) {
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
        $("#planinfo").css("display", "none");
        $("#info").removeClass("weui_bar_item_on");
        $("#planlist").css("display", "block");
        $("#list").addClass("weui_bar_item_on");
    }
}
function openplaninfo(planid){
    if($("#1").css("display")=="block"){
       $("#"+planid).hide();
    }else{
        $("#"+planid).show();
    }

}
</script>
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
                                    <select class="weui_select" name="level">
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
                                    <select class="weui_select" name="type">
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
                                           type="text" value='${plan.weight}'>
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
                    <input type="button" id="submit_${uuid}" onclick="submitform();"
                           class="weui_btn weui_btn_primary"
                           value="&nbsp;&nbsp;保&nbsp;&nbsp;存&nbsp;&nbsp;"/>
                    <input type="button" id="submit_${uuid}" onclick=" gohome();" class="weui_btn weui_btn_default"
                           value="&nbsp;&nbsp;取&nbsp;&nbsp;消&nbsp;&nbsp;"/>
 </div>
                <!--计划信息结束-->
                <!--子任务列表开始-->
                <div id="planlist" style="display: none">
                    <div class="weui_panel">
                        <div class="weui_panel_hd">公司计划子任务列表</div>
                        <div class="weui_panel_bd">
                              <div href="repairlistview.html" class="weui_media_box weui_media_text" onclick="openplaninfo('1')">

                                <p class="weui_media_desc">落实全镇农业生产、责任制完善、农村电力、水利设施建设。</p>

                            </div>
                            <div class="planchind"  id="1" >
                                <div class="weui_panel_bd" style="width: 95%;margin-left: 30px;">
                                    <div href="repairlistview.html" class="weui_media_box weui_media_text">

                                        <p class="weui_media_desc">落实农业生产建设。</p>
                                        <ul class="weui_media_info">
                                            <li class="weui_media_info_meta">负责人：员工甲</li>
                                            <li class="weui_media_info_meta">2016-04-04至2016-12-04</li>
                                        </ul>
                                    </div>
                                    <div href="repairlistview.html" class="weui_media_box weui_media_text">

                                        <p class="weui_media_desc">落实责任制完善建设。</p>
                                        <ul class="weui_media_info">
                                            <li class="weui_media_info_meta">负责人：员工乙</li>
                                            <li class="weui_media_info_meta">2016-04-04至2016-12-04</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div href="repairlistviewfenpei.html" class="weui_media_box weui_media_text">

                                <p class="weui_media_desc">引导农村产业结构调整，做好防水、防汛工作。</p>
                                <ul class="weui_media_info">
                                    <li class="weui_media_info_meta">负责人：员工甲</li>
                                </ul>
                            </div>

                            <div class="weui_media_box weui_media_text">

                                <p class="weui_media_desc">落实各项惠农政策及减负工作。 </p>
                                <ul class="weui_media_info">
                                    <li class="weui_media_info_meta">负责人：员工甲</li>
                                </ul>
                            </div>

                            <div class="weui_media_box weui_media_text">

                                <p class="weui_media_desc"> 完成农村环境卫生综合整治工作。</p>
                                <ul class="weui_media_info">
                                    <li class="weui_media_info_meta">负责人：员工甲</li>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
                <!--子任务列表结束-->
            </div>
            <div class="weui_tabbar">
                <a href="javascript:settabbar(1);" class="weui_tabbar_item weui_bar_item_on" id="info">
                    <div class="weui_tabbar_icon">
                        <img src="img/icon_nav_cell.png" alt="">
                    </div>
                    <p class="weui_tabbar_label">计划信息</p>
                </a>
                <a href="javascript:settabbar(2);" class="weui_tabbar_item" id="list">
                    <div class="weui_tabbar_icon">
                        <img src="img/icon_nav_article.png" alt="">
                    </div>
                    <p class="weui_tabbar_label">任务列表</p>
                </a>
            </div>
        </div>
    </div>
</div>
                        
</body>
</html>