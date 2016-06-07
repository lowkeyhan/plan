<%@ page contentType="text/html;charset=UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %> 

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<script src='${ctx}/static/dingding/jquery.min.js'></script>


<!-- bootstrap -->
<link href="${ctx}/static/dingding/weui.min.css" rel="stylesheet" type="text/css" />
  <!-- 公用方法 -->
<script src="${ctx}/static/dingding/public.js" type="text/javascript"></script>
<!-- 钉钉js -->
 <script src='${ctx}/static/dingding/dingtalk.js'></script> 
<title>日程</title>
<style type="text/css">
body{
		
    background-color: #f0eff4;
}
/*
a:focus,input:focus{
    -webkit-tap-highlight-color:rgba(0,0,0,0)  !important;
    -webkit-user-modify:read-write-plaintext-only   !important;
       
}

select,input,input[type=text]:focus, input[type=password]:focus {
 border: 0px;
 font-size: 14px;   
border: 0px solid #ccc !important;
    line-height: 40px !important;
    height: 50px !important;
     
     background-color:white !important;
      outline: none !important;
}
textarea{
 border: 0px;
 font-size: 14px;   
border: 0px solid #ccc !important;
    line-height: 24px !important;
 
     background-color:white !important;
      outline: none !important;
}
.span3{
line-height: 50px !important;
padding-left:5px !important;
font-size:16px !important;
color:#222222" 
}
.span9{
 
}

.nobootommargin{
margin-bottom: 0px;
}
.noupline{
    border-top-width: 0px !important;
}


*/
.colorspan{
width:1.5em  !important;
height:1.5em  !important;
display: block;
 float:left;
 
}
.hiddn{
	display:none;
}
.weui_cells{
background-color: white;

margin-bottom: 10px !important;
margin-top:0px  !important;
}
  .weui_label {
    width: 4em !important;;
} 
.weui_input,.weui_textarea{
font-size:15px !important;
color:#292828 !important;
}
</style>

<script type="text/javascript">


var _config = <%=com.techstar.sys.dingAPI.auth.AuthHelper.getConfig(request,"dingdingurl4")%>;
dd.config({
	agentId : _config.agentid,
	corpId : _config.corpId,
	timeStamp : _config.timeStamp,
	nonceStr : _config.nonceStr,
	signature : _config.signature,
	jsApiList : [ 'runtime.info', 'biz.contact.choose',
			'device.notification.confirm', 'device.notification.alert',
			'device.notification.prompt', 'biz.ding.post',
			'biz.util.openLink','biz.navigation.setRight','biz.navigation.setLeft' ]
});
function getCookie(name)
{
	var strCookie = document.cookie;
	var arrCookie = strCookie.split("; ");
	for(var i = 0; i < arrCookie.length; i++){
	var arr = arrCookie[i].split("=");
	if(name == arr[0]){
	return arr[1];
	}
	}
}
dd.ready(function(){
	
	dd.biz.navigation.setTitle({
        title: '日程管理',
        onSuccess: function(data) {
        },
        onFail: function(err) {
            log.e(JSON.stringify(err));
        }
    });
	if(getCookie("userid")=="${events.operationerid}"){
		
		//根据id判断按钮状态delect
		$('#delect').css("display","block");
		if('${events.isfinish}'!=='1'){
			$('#finish').css("display","block");
		}
		
		
		//右侧按钮
		
		dd.biz.navigation.setMenu({
        backgroundColor : "#ADD8E6",
        items : [
            {
                "id":"1",//字符串
            "iconId":"edit",//字符串，图标命名
              "text":"编辑"
            }
        ],
        onSuccess: function(data) {
        	window.location.href="${ctx}/calender/event?id=${events.id}&dd_nav_bgcolor=FF30A8A5";
		 },
        onFail: function(err) {
        }
    });
		
	}else{
		
		dd.biz.navigation.setRight({
		    show: false,//控制按钮显示， true 显示， false 隐藏， 默认true
		    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
		    text: '编辑',//控制显示文本，空字符串表示显示默认文本
		    onSuccess : function(result) {
		        //如果control为true，则onSuccess将在发生按钮点击事件被回调
		        /*
		        {}
		        */
		        
		    	window.location.href="${ctx}/calender/event?id=${events.id}&dd_nav_bgcolor=FF30A8A5";
		    },
		    onFail : function(err) {}
		});
	}
	dd.biz.navigation.setLeft({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    showIcon: true,//是否显示icon，true 显示， false 不显示，默认true； 注：具体UI以客户端为准
	    text: '主页',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	        /*
	{}
	*/
	        //如果control为true，则onSuccess将在发生按钮点击事件被回调
	    	window.location.href="${ctx}/calender/tab?dd_nav_bgcolor=FF30A8A5";
	    },
	    onFail : function(err) {}
	});
	
	//完成任务
	$('#finish').on('click', function () {
		$.ajax({
			url:'${ctx}/calender/finish',
			data:{
				id:'${events.id}'
				},
			type:'POST',
			dataType:'json',
			success:function(responseText){
				alert(responseText.message);
				window.location.href="${ctx}/calender/tab";
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				alert(XMLHttpRequest.status+XMLHttpRequest.readyState+textStatus);
			}
		});
	});

	//删除任务
	$('#delect').on('click', function () {
		$.ajax({
			url:'${ctx}/calender/delect',
			data:{
				id:'${events.id}'
				},
			type:'POST',
			dataType:'json',
			success:function(responseText){
				alert(responseText.message);
				window.location.href="${ctx}/calender/tab";
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				alert(XMLHttpRequest.status+XMLHttpRequest.readyState+textStatus);
			}
		});
	});
	
	
});

dd.error(function(err) {
	alert('dd error: ' + JSON.stringify(err));
});

//时间格式化
function formatToDate(cellvalue){
	if(cellvalue!=null){
		var date = new Date(cellvalue);// 或者直接new Date();
	    return date.format("yyyy-MM-dd hh:mm:ss");
	}
	else
		return "";
}
function formatToDay(cellvalue){
	if(cellvalue!=null&&cellvalue!=""){
		var date = new Date(cellvalue);// 或者直接new Date();
	    return date.format("yyyy-MM-dd hh:mm");
	}
	else
		return "";
}
function strToDate(str) {
 var tempStrs = str.split(" ");
 var dateStrs = tempStrs[0].split("-");
 var year = parseInt(dateStrs[0], 10);
 var month = parseInt(dateStrs[1], 10) - 1;
 var day = parseInt(dateStrs[2], 10);
 var timeStrs = tempStrs[1].split(":");
 var hour = parseInt(timeStrs [0], 10);
 var minute = parseInt(timeStrs[1], 10) - 1;
 var second = 11;
 var date = new Date(year, month, day, hour, minute, second);
 return date;
}
</script>
</head>
<body>

  <form id="eventForm_${uuid}"     
		action="${ctx}/calender/edit"
		method="POST" >
	<input type="hidden" id="id" name="id" value="${events.id}" />
	<input type="hidden" id="oper" name="oper" value="${oper}" />
	
  <div class="weui_cells weui_cells_form">
	<div class="weui_cell">
        <div class="weui_cell_hd"><label class="weui_label">日程标题</label></div>
        <div class="weui_cell_bd weui_cell_primary">
            <input class="weui_input" id="title" name="title" readonly="readonly" type="text"  value="${events.title}">
		
        </div>
    </div>
    </div>
    <div class="weui_cells weui_cells_form">
    <div class="weui_cell">
        <div class="weui_cell_hd"><label class="weui_label">开始时间</label></div>
        <div class="weui_cell_bd weui_cell_primary">
            <input class="weui_input" id="starttime" readonly="readonly" name="starttime" type="text"   value='<fmt:formatDate value="${events.starttime}" pattern="yyyy-MM-dd HH:mm"/>' >
		
        </div>
    </div>
    <div class='weui_cell ${events.selecttime==999?"nobootommargin":""}'>
        <div class="weui_cell_hd"><label class="weui_label">持续时间</label></div>
        <div class="weui_cell_bd weui_cell_primary">
         <select id="selecttime" disabled="true" class="weui_input" name="selecttime">
				<option value="0" ${(events.selecttime==0||oper=="add")?"selected='selected'":""} >全天</option>
				<option value="0.5" ${events.selecttime==0.5?"selected='selected'":""} >30分钟</option>
				<option value="1" ${events.selecttime==1?"selected='selected'":""} >1小时</option>
				<option value="2" ${events.selecttime==2?"selected='selected'":""} >2小时</option>
				<option value="3" ${events.selecttime==3?"selected='selected'":""} >3小时</option>
				<option value="4" ${events.selecttime==4?"selected='selected'":""} >4小时</option>
				<option value="8" ${events.selecttime==8?"selected='selected'":""} >8小时</option>
				<option value="999" ${events.selecttime==999?"selected='selected'":""} >自定义</option>
			</select>
        </div>
    </div>
    <div class='weui_cell ${events.selecttime==999?"":"hiddn"}'>
        <div class="weui_cell_hd"><label class="weui_label">结束时间</label></div>
        <div class="weui_cell_bd weui_cell_primary">
            <input class="weui_input" id="endtime" name="endtime" readonly="readonly" type="text"  value='<fmt:formatDate value="${events.endtime}" pattern="yyyy-MM-dd HH:mm"/>'>
        </div>
    </div>
    </div>
    <div class="weui_cells weui_cells_form">
    <div class='weui_cell '>
        <div class="weui_cell_hd"><label class="weui_label">日程内容</label></div>
        <div class="weui_cell_bd weui_cell_primary">
            <textarea rows="3" class="weui_textarea"  id="remark" name="remark" readonly="readonly" >${events.remark}</textarea>
		</div>
    </div>
    </div>
    <div class="weui_cells weui_cells_form">
    <div class='weui_cell '>
        <div class="weui_cell_hd"><label class="weui_label">参与人员</label></div>
        <div class="weui_cell_bd weui_cell_primary">
            <input class="weui_input" id="participantname" readonly="readonly" name="participantname" type="text"  value="${events.participantname}">
		</div>
    </div>
    </div>
    <div class="weui_cells weui_cells_form">
    <div class='weui_cell '>
        <div class="weui_cell_hd"><label class="weui_label">提醒时间</label></div>
        <div class="weui_cell_bd weui_cell_primary">
         	<input class="weui_input" id="remindertime"  name="remindertime" readonly="readonly" type="text"  value='<fmt:formatDate value="${events.remindertime}" pattern="yyyy-MM-dd HH:mm"/>'>
		</div>
    </div>
    </div>
    <div class="weui_cells weui_cells_form">
    <div class='weui_cell '>
        <div class="weui_cell_hd"><label class="weui_label">重要程度</label></div>
        <div class="weui_cell_bd weui_cell_primary">
         	<a class='colorspan   ' style="background-color:${events.backcolor};"  id="greencolor"  ></a>	
		 <span id="shuoming" style="margin-right:0px;color: #888889;font-size:12px;line-height:2em;">
		${(events.backcolor=="#3BA1BF"||oper=="add")?"不紧急不重要":""}
		${events.backcolor=="#0000FF"?"重要不紧急":""}
		${events.backcolor=="#FFA500"?"紧急不重要":""}
		 ${events.backcolor=="#CA413B"?"紧急重要":""}
		</span>
		</div>
    </div>
    </div>
   <div class="weui_cells weui_cells_form">
    <div class='weui_cell '>
        <div class="weui_cell_hd"><label class="weui_label">完成情况</label></div>
        <div class="weui_cell_bd weui_cell_primary">
         	<div class="weui_input" >${events.isfinish=="1"?"已完成":"未完成"}</div>
		</div>
    </div>
    </div>

  </form>
     <a class="weui_btn weui_btn_primary hiddn" id="finish">确认完成</a>
     <a class="weui_btn weui_btn_warn hiddn" id="delect">删除</a>
<script type="text/javascript">
/*if($("#remindertime").val()){
	$("#remindertime").val(formatToDate($("#remindertime").val()));
	}
	$("#starttime").val(formatToDate($("#starttime").val()));
	if($("#endtime").val()){
	$("#endtime").val(formatToDate($("#endtime").val()));
	}*/
</script>

</body>
</html>