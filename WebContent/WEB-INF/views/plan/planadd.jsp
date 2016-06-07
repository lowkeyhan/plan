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
  	  location.href="${ctx}/plan/planedit?id="+data.userdata;
  	  },
  	  error: function(xhr, type,error){
  	    alert('Ajax error!');
  	  }
  	});
}

</script>
 <form id="planform" action="${ctx}/plan/edit" method="POST">
                        <input type="hidden" id="oper" name="oper" value="${oper}"/>
						<input type="hidden" id="deptid" name="deptid" value="${deptid}"/>
						<input type="hidden" id="year" name="year" value="${year}"/>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">计划名称</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="title"  name="title"
                                           type="text" value=''>
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
                                           type="text" value=''>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">权重比例</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="weight"  name="weight"
                                           type="text" value=''>
                                </div>
                            </div>
                        </div>
                        <div class="weui_cells weui_cells_form">
                            <div class="weui_cell">
                                <div class="weui_cell_hd"><label class="weui_label">考核指标</label></div>
                                <div class="weui_cell_bd weui_cell_primary">
                                    <input class="weui_input" id="ssessmentindex"  name="ssessmentindex"
                                           type="text" value=''>
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
</html>