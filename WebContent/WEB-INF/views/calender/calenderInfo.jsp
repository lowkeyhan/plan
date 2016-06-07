<%@ page contentType="text/html;charset=UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %> 

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<script src='${ctx}/static/dingding/jquery.min.js'></script>
<link href="${ctx}/static/dingding/weui.min.css" rel="stylesheet" type="text/css" />
<!-- form，表单提交-->
<script src="${ctx}/static/jquery-form/jquery.form.js" type="text/javascript"></script>
  <!-- 公用方法 -->
<script src="${ctx}/static/dingding/public.js" type="text/javascript"></script>
<!-- 钉钉js -->
 <script src='${ctx}/static/dingding/dingtalk.js'></script> 
<title>日程</title>
<style type="text/css">
body{
    background-color: #f0eff4;
}

.colorselect{
box-shadow:inset 0 2px 4px rgba(0, 0, 0, 0.5), 0 1px 2px rgba(0, 0, 0, 0.5);

}
.weui_icon_success_no_circle:before {
    color: #FFFFFF  !important;
}
.colorspan{
width:1.5em  !important;
height:1.5em  !important;
display: block;
 float:left;
 margin-left:10px;
 
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

function allsubmit(ishome){
	$("#goadddialog").hide();
	$("#gohomedialog").hide();
	if($("#title").val()==""){
		alert("请填写标题");
		
	}else if($("#starttime").val()==""){
		alert("请选择开始时间");
	}else{
	$("#eventForm_${uuid}").ajaxSubmit({
		type : 'post',
		dataType : 'json',
		data : {
		},
		beforeSubmit : function(formData, jqForm, options) {
			$('#submit_${uuid}').prop("disabled", true);
		},
		success : function(responseText, statusText, xhr, $form) {
			if (responseText.success) {
					alert(responseText.message);
					if(ishome=="home"){
						gohome();
					}else{
						addnewevent();
					}
			} else {
				alert(responseText.message);
				$('#submit_${uuid}').prop("disabled", false);
			}
		},
		error : function(xhr, textStatus, errorThrown) {
			alert("系统错误"+xhr.status+textStatus);
			$('#submit_${uuid}').prop("disabled", false);
		}
	});
	}
}

var _config = <%=com.techstar.sys.dingAPI.auth.AuthHelper.getConfig(request,"3")%>;
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

dd.ready(function(){
	dd.biz.navigation.setTitle({
        title: '钉钉日程',
        onSuccess: function(data) {
        },
        onFail: function(err) {
            log.e(JSON.stringify(err));
        }
    });
	//右侧按钮
	dd.biz.navigation.setMenu({
        backgroundColor : "#ADD8E6",
        items : [
            {
                "id":"1",//字符串
            "iconId":"add",//字符串，图标命名
              "text":"添加"
            }
        ],
        onSuccess: function(data) {
        	$("#goadddialog").show();
        },
        onFail: function(err) {
        }
    });
	dd.biz.navigation.setLeft({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    showIcon: true,//是否显示icon，true 显示， false 不显示，默认true； 注：具体UI以客户端为准
	    text: '主页',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	    	$("#gohomedialog").show();
	    },
	    onFail : function(err) {}
	});
	
	//选择开始时间
	 $('#starttime').on('click', function () {
		 var date;
		 if( $('#starttime').val()){
			 date=strToDate($('#starttime').val());
		 }else{
			date = new Date();
		 }
		 var time=date.format("yyyy/MM/dd hh:mm:11");
		 dd.biz.util.datetimepicker({
			    format: 'yyyy/MM/dd HH:mm:ss',
			    value: time, //默认显示
			    onSuccess : function(result) {
			        //onSuccess将在点击完成之后回调
			        /*{
			            value: "2015-06-10 09:50"
			        }
			        */
			        $('#starttime').val(result.value);
			        //选择结束后计算结束时间
			        setendtime(2);
			    },
			    onFail : function() {}
			});
		});
	 
	 //选择结束时间
	 $('#endtime').on('click', function () {
		var date;
		//获得初始值
		 if( $('#endtime').val()){
			 date=strToDate($('#endtime').val());
		 }else if($('#starttime').val()){
			 date=strToDate($('#starttime').val());
			 date.setHours(date.getHours()+1);
		 }else{date = new Date();}
		 
		 var time=date.format("yyyy/MM/dd hh:mm:11");
		 //调用dingding时间选择器
		 dd.biz.util.datetimepicker({
			    format: 'yyyy/MM/dd HH:mm:ss',
			    value: time, //默认显示
			    onSuccess : function(result) {
			     
			        $('#endtime').val(result.value);
			    },
			    onFail : function() {}
			});
		});
	 
	 //选择提醒时间
	 $('#remindertime').on('click', function () {
			var date;
			 if( $('#remindertime').val()){
				 date=strToDate($('#remindertime').val());
			 }else{
				date = new Date();
			 }
			 var time=date.format("yyyy/MM/dd hh:mm:11");
			 dd.biz.util.datetimepicker({
				    format: 'yyyy/MM/dd HH:mm:11',
				    value: time, //默认显示
				    onSuccess : function(result) {
				     
				        $('#remindertime').val(result.value);
				        //获得时间后直接调用ding页面
				        addDing();
				    },
				    onFail : function() {}
				});
			});
	 
	function addDing() {
		 var data= $('#remindertime').val();
		 if(data==''){
			 alert('请选择提醒时间'); 
		 }else{
			 var useridlist='${userid}';
			 if($('#participantid').val()){
				 useridlist=useridlist+','+$('#participantid').val();
			 }
		 dd.biz.ding.post({
			    users :  useridlist.split(","),//用户列表，工号
			    corpId: 'dingdf1938a231e0f276', //企业id
			    type: 0, //钉类型 1：image  2：link
			    alertType: 0,
			    alertDate: {"format":"yyyy/MM/dd HH:mm:ss","value":$('#remindertime').val()},
			    attachment: {
			        images: [''],
			    }, //附件信息
			    text: $('#title').val()+$('#remark').val(), //消息
			    onSuccess : function() {
			    //onSuccess将在点击发送之后调用
			    },
			    onFail : function() {}
			});
		 }
		};
	
	//选择人员
	$('#participantname').on('click', function () {
		 var useridlist='';
		 if($('#participantid').val()){
			 useridlist=$('#participantid').val();
		 }
		 dd.biz.contact.choose({
			  startWithDepartmentId: 0, //-1表示打开的通讯录从自己所在部门开始展示, 0表示从企业最上层开始，(其他数字表示从该部门开始:暂时不支持)
			  multiple: true, //是否多选： true多选 false单选； 默认true
			  users:  useridlist.split(","), //默认选中的用户列表，userid；成功回调中应包含该信息
			  corpId: 'dingdf1938a231e0f276', //企业id
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
				  $('#participantname').val(names.substring(0,names.length-1));
				  $('#participantid').val(nameids.substring(0,nameids.length-1));
			  },
			  onFail : function(err) {}
			});;
		});
//dd结束	 
});

dd.error(function(err) {
	alert('dd error: ' + JSON.stringify(err));
});


function formatToDate(cellvalue){
	if(cellvalue!=null){
		var date = new Date(cellvalue);// 或者直接new Date();
	    return date.format("yyyy/MM/dd hh:mm:ss");
	}
	else
		return "";
}


function strToDate(str) {
 var tempStrs = str.split(" ");
 var dateStrs = tempStrs[0].split("/");
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

/*
 * 根据持续时间获得结束时间
 *Isopentime 1:选择持续时间出发，自定义会弹出时间选择。2：选择开始时间触发，不弹。
 */
function setendtime(Isopentime){
	if($("#selecttime").val()==999&&Isopentime==1){
		$("#endtime").click();
		$("#endtimediv").removeClass("hiddn");
	}else{
		var sdate;
		if($("#starttime").val()==""){
			return null;
		}else{
			sdate=new Date($("#starttime").val());
		}
		if($("#selecttime").val()==0.5){
			sdate.setMinutes(sdate.getMinutes()+30);
			$("#endtime").val(sdate.format("yyyy/MM/dd hh:mm:ss"));
			$("#endtimediv").addClass("hiddn");
		}else if($("#selecttime").val()==0){
			$("#endtime").val("");
			$("#endtimediv").addClass("hiddn");
		}else if($("#selecttime").val()!=999){
			sdate.setHours(sdate.getHours()+parseInt($("#selecttime").val()));
			
			$("#endtime").val(sdate.format("yyyy/MM/dd hh:mm:ss"));
			$("#endtimediv").addClass("hiddn");
		}
	}
}

//时间重要程度选择
function setcolor(color){
	//alert(color);
	if(color=="green"){
		$("#backcolor").val("#3BA1BF");
		$('#greencolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.5), 0 1px 2px rgba(0, 0, 0, 0.5)");
		$('#bluecolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#orangecolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#redcolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#greencolor').html("<i class=\"weui_icon_success_no_circle\"><\/i>");
		$('#bluecolor').html("");
		$('#orangecolor').html("");
		$('#redcolor').html("");
		$('#shuoming').html("不紧急不重要");
	}else if(color=="blue"){
		$("#backcolor").val("#0000FF");
		$("#greencolor").css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#bluecolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.5), 0 1px 2px rgba(0, 0, 0, 0.5)");
		$('#orangecolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#redcolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#bluecolor').html("<i class=\"weui_icon_success_no_circle\"><\/i>");
		$('#greencolor').html("");
		$('#orangecolor').html("");
		$('#redcolor').html("");
		$('#shuoming').html("重要不紧急");
	}else if(color=="orange"){
		$("#backcolor").val("#FFA500");
		$("#greencolor").css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#bluecolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#orangecolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.5), 0 1px 2px rgba(0, 0, 0, 0.5)");
		$('#redcolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#orangecolor').html("<i class=\"weui_icon_success_no_circle\"><\/i>");
		$('#greencolor').html("");
		$('#bluecolor').html("");
		$('#redcolor').html("");
		$('#shuoming').html("紧急不重要");
	}else if(color=="red"){
		$("#backcolor").val("#CA413B");
		$("#greencolor").css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#bluecolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#redcolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.5), 0 1px 2px rgba(0, 0, 0, 0.5)");
		$('#orangecolor').css("box-shadow","inset 0 2px 4px rgba(0, 0, 0, 0.2), 0 1px 2px rgba(0, 0, 0, 0.2)");
		$('#redcolor').html("<i class=\"weui_icon_success_no_circle\"><\/i>");
		$('#greencolor').html("");
		$('#bluecolor').html("");
		$('#orangecolor').html("");
		$('#shuoming').html("紧急重要");
	}
}

//返回主页
function gohome(){
	var time="";
	if("${events.starttime}"!==""){
		time=(new Date('${events.starttime}')).format("yyyy-MM-dd");
	}
	window.location.href="${ctx}/calender/tab?dd_nav_bgcolor=FF30A8A5&starttime="+time;
}
function addnewevent(){
	var time="";
	if("${events.starttime}"!==""){
		time=formatToDate('${events.starttime}');
	}
	window.location.href="${ctx}/calender/event?dd_nav_bgcolor=FF30A8A5&starttime="+time;
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
            <input class="weui_input" id="title" name="title" type="text"  value="${events.title}">
		</div>
    </div>
    </div>
	
	 <div class="weui_cells weui_cells_form">
	<div class="weui_cell">
        <div class="weui_cell_hd"><label class="weui_label">开始时间</label></div>
        <div class="weui_cell_bd weui_cell_primary">
            <input class="weui_input" id="starttime" readonly="readonly" name="starttime" type="text"  value='<fmt:formatDate value="${events.starttime}" pattern="yyyy/MM/dd HH:mm:ss"/>'>
		</div>
    </div>
    
    <div class='weui_cell ${events.selecttime==999?"nobootommargin":""}' id="selecttimediv" >
        <div class="weui_cell_hd"><label class="weui_label">持续时间</label></div>
        <div class="weui_cell_bd weui_cell_primary">
           <select id="selecttime" onchange="setendtime(1)" class="weui_input" name="selecttime">
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
    
    <div class='weui_cell ${events.selecttime==999?"":"hiddn"}' id="endtimediv" >
        <div class="weui_cell_hd"><label class="weui_label">结束时间</label></div>
        <div class="weui_cell_bd weui_cell_primary">
            <input class="weui_input" id="endtime" name="endtime" readonly="readonly" type="text"  value='<fmt:formatDate value="${events.endtime}" pattern="yyyy/MM/dd HH:mm:ss"/>'>
		</div>
    </div>
    
    </div>
    
     <div class="weui_cells weui_cells_form">
	<div class="weui_cell">
        <div class="weui_cell_hd"><label class="weui_label">日程内容</label></div>
        <div class="weui_cell_bd weui_cell_primary">
            <textarea rows="3" class="weui_textarea"   id="remark" name="remark" >${events.remark}</textarea>
		</div>
    </div>
    </div>
    
      <div class="weui_cells weui_cells_form">
	<div class="weui_cell">
        <div class="weui_cell_hd"><label class="weui_label">参与人员</label></div>
        <div class="weui_cell_bd weui_cell_primary">
           <input class="weui_input" id="participantname" name="participantname" readonly="readonly" type="text"  value="${events.participantname}">
			<input id="participantid" name="participantid" type="hidden" class=" input nowrite" value="${events.participantid}">
		
		</div>
    </div>
    </div>
    
    <div class="weui_cells weui_cells_form">
	<div class="weui_cell">
        <div class="weui_cell_hd"><label class="weui_label">提醒时间</label></div>
        <div class="weui_cell_bd weui_cell_primary">
           <input class="weui_input" id="remindertime" name="remindertime" readonly="readonly" type="text"  value='<fmt:formatDate value="${events.remindertime}" pattern="yyyy/MM/dd HH:mm:ss"/>'>
		
		</div>
    </div>
    </div>
    
     <div class="weui_cells weui_cells_form">
	<div class="weui_cell">
        <div class="weui_cell_hd"><label class="weui_label">重要程度</label></div>
        <div class="weui_cell_bd weui_cell_primary">
           <a class='colorspan   ${(events.backcolor=="#3BA1BF"||oper=="add")?"colorselect":""}' style="background-color:#3BA1BF;" onclick="setcolor('green');" id="greencolor"  >${(events.backcolor=="#3BA1BF"||oper=="add")?"<i class='weui_icon_success_no_circle'></i>":""}</a>	
		 <a class='colorspan  ${events.backcolor=="#0000FF"?"colorselect":""}' style="background-color:#0000FF;" onclick="setcolor('blue');"  id="bluecolor"   >${events.backcolor=="#0000FF"?"<i class='weui_icon_success_no_circle'></i>":""}</a>					
		<a class='colorspan  ${events.backcolor=="#FFA500"?"colorselect":""}' style="background-color:#FFA500;" onclick="setcolor('orange');"  id="orangecolor"  >${events.backcolor=="#FFA500"?"<i class='weui_icon_success_no_circle'></i>":""}</a>				
		<a class='colorspan  ${events.backcolor=="#CA413B"?"colorselect":""}' style="background-color:#CA413B;" onclick="setcolor('red');"  id="redcolor"   >${events.backcolor=="#CA413B"?"<i class='weui_icon_success_no_circle'></i>":""}</a>		
		<span id="shuoming" style="margin-right:0px;color: #888889;font-size:12px;line-height:2em;">
		${(events.backcolor=="#3BA1BF"||oper=="add")?"不紧急不重要":""}
		${events.backcolor=="#0000FF"?"重要不紧急":""}
		${events.backcolor=="#FFA500"?"紧急不重要":""}
		 ${events.backcolor=="#CA413B"?"紧急重要":""}
		</span>

		<input id="backcolor" name="backcolor" type="hidden" class=" input nowrite" value="${events.backcolor}">
		
		</div>
    </div>
    </div>
	
	
	
	
	
	
  </form>
  <div style="margin: 0 auto;width: 100%;">
  <input type="button" id="submit_${uuid}" onclick="allsubmit('home');"  class="weui_btn weui_btn_primary" value="&nbsp;&nbsp;提&nbsp;&nbsp;交&nbsp;&nbsp;" />	
   <input type="button" id="submit_${uuid}" onclick=" gohome();"  class="weui_btn weui_btn_default" value="&nbsp;&nbsp;取&nbsp;&nbsp;消&nbsp;&nbsp;" />		
  					
</div>
 <!--BEGIN 弹出是否保存添加新页-->
    <div class="weui_dialog_confirm" id="goadddialog" style="display: none;">
        <div class="weui_mask"></div>
        <div class="weui_dialog">
            <div class="weui_dialog_hd"><strong class="weui_dialog_title">是否保存当前日程</strong></div>
            <div class="weui_dialog_bd"></div>
            <div class="weui_dialog_ft">
                <a href="javascript:;" onclick="addnewevent();" class="weui_btn_dialog default">否</a>
                <a href="javascript:;" onclick="allsubmit('');" class="weui_btn_dialog primary">是</a>
            </div>
        </div>
    </div>
    <!--END dialog1-->
     <!--BEGIN 弹出是否保存返回主页-->
    <div class="weui_dialog_confirm" id="gohomedialog" style="display: none;">
        <div class="weui_mask"></div>
        <div class="weui_dialog">
            <div class="weui_dialog_hd"><strong class="weui_dialog_title">是否保存当前日程</strong></div>
            <div class="weui_dialog_bd"></div>
            <div class="weui_dialog_ft">
                <a href="javascript:;" onclick="gohome();" class="weui_btn_dialog default">否</a>
                <a href="javascript:;" onclick="allsubmit('home');" class="weui_btn_dialog primary">是</a>
            </div>
        </div>
    </div>
    <!--END dialog1-->
</body>
</html>