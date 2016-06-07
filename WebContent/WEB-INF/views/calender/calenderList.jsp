<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %> 

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset='utf-8' />
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
 <link href='${ctx}/static/dingding/fullcalendar.css' rel='stylesheet' />
<link href='${ctx}/static/dingding/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='${ctx}/static/dingding/moment.min.js'></script>
<script src='${ctx}/static/dingding/jquery.min.js'></script>
<script src='${ctx}/static/dingding/fullcalendar.js'></script>
<script src='${ctx}/static/dingding/hammer.min.js'></script>
    <script src='${ctx}/static/dingding/lang-all.js'></script>
    <!-- 公用方法 -->
<script src="${ctx}/static/dingding/public.js" type="text/javascript"></script>
<!-- 钉钉js -->
 <script src='${ctx}/static/dingding/dingtalk.js'></script>
 <link href="${ctx}/static/dingding/weui.min.css" rel="stylesheet" type="text/css" />
 
 <style>
.fc-left h2{
 padding-top: 10px;
 font-size: smaller;
 }
 /*.fc-right{
 width: 50%;
 }
 .fc-right .fc-button-group{
     float: right !important;
 }*/  
 .eventlisth{
 width:100%;
 overflow-x: scroll;
 
 }
 .fc-unthemed th, .fc-unthemed td, .fc-unthemed thead, .fc-unthemed tbody, .fc-unthemed .fc-divider, .fc-unthemed .fc-row, .fc-unthemed .fc-popover {
    
}
.fc-view-container{
background-color: #F7F7F7  !important;
}
  .fc-state-default {
            background-color: #30A8A5 !important;
                color: #FFF !important;
                background-image: none  !important;
                    width: 50px;
                    height:35px !important;
        }
        .fc-state-down, .fc-state-active {
              background-color: #30A8A5 !important;
                color: #FFF !important;
        }
        .fc-toolbar {
        margin:0px 0px 0px 0px !important;
        background-color: #30A8A5; color: white; color: white;
        padding-bottom: 10px;
        }
         .fc-toolbar .fc-center .fc-left {
            line-height: 28px;
        }

        .fc-event-container {
        
        }
         
         /*.fc-basic-view .fc-body*/
        .fc-month-view .fc-body .fc-row {
        height:42px  !important;
        }
        .fc-month-view .fc-body .fc-row .fc-bg {
        height:42px  !important;
        }
        .fc-basic-view .fc-body .fc-row {
            min-height:21px;
        }

        .fc-basicDay-view .fc-body .fc-event{
            font-size:14px  !important;
        }
        .fc-basicDay-view .fc-body .fc-event .fc-title{
            white-space: pre-wrap;
        }
        .fc-basicDay-view .fc-body .fc-content{
            line-height: 30px;
        }
        .fc-center h2 {
            font-size: smaller;
        }
        body{
            font-size:smaller  !important;
        }
        .delline{
        	text-decoration:line-through;
        }
        /* .circle {
            width: 40px;
            height: 40px;
            background: #30A8A5;
            border-radius:50%;
            text-align:center;
            
            line-height: 37px   !important;
        	color: white;
            position:absolute;
            bottom:20px;
            right:10px;
            font-size: 20px;
            box-shadow: 3px 6px 20px #888888;
            font-weight: 600;
        }*/
          .circle123 {
            width: 50px;
            height: 45px;
            background: #30A8A5;
            border-radius:50%;
            text-align:center;
                padding-top:5px;
        	color: white;
            position:absolute;
            bottom:20px;
            right:10px;
            font-size: 25px;
            box-shadow: 3px 6px 20px #888888;
            font-weight: 600;
            z-index:999;
			
        }
 </style>
<script>
var _config = <%=com.techstar.sys.dingAPI.auth.AuthHelper.getConfig(request,"1")%>;
dd.config({
	agentId : _config.agentid,
	corpId : _config.corpId,
	timeStamp : _config.timeStamp,
	nonceStr : _config.nonceStr,
	signature : _config.signature,
	jsApiList : [ 'runtime.info', 'biz.contact.choose',
			'device.notification.confirm', 'device.notification.alert',
			'device.notification.prompt', 'biz.ding.post',
			'biz.util.openLink','biz.navigation.setRight','biz.navigation.setLeft',
			'device.notification.showPreloader','device.notification.hidePreloader','biz.navigation.close' ]
});

dd.ready(function(){
	
	  
	//记录选择时间
	var lastSelectTime='';
	var defulttime=new Date();
	lastSelectTime=formatToDateyymmdd(defulttime);
	//设置列表高度
	$("#eventlisth").height(($(window).height()-50)/2);
	
	dd.device.notification.showPreloader({
	    text: "加载中..", //loading显示的字符，空表示不显示文字
	    showIcon: true, //是否显示icon，默认true
	    onSuccess : function(result) {
	        /*{}*/
	    },
	    onFail : function(err) {}
	});
	dd.biz.navigation.setTitle({
        title: '日程管理',
        onSuccess: function(data) {
        },
        onFail: function(err) {
            log.e(JSON.stringify(err));
        }
    });
	//设置右侧按钮
	/*dd.biz.navigation.setRight({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    text: '添加',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	        addevent();
	    	
	    },
	    onFail : function(err) {}
	});*/
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
        	addevent();
        },
        onFail: function(err) {
        }
    });
	
	//设置左侧按钮
	dd.biz.navigation.setLeft({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    showIcon: true,//是否显示icon，true 显示， false 不显示，默认true； 注：具体UI以客户端为准
	    text: '钉钉',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	        
	    	dd.biz.navigation.close({
			    onSuccess : function(result) {
			      },
			    onFail : function(err) {}
			});
	    },
	    onFail : function(err) {}
	});
	
	dd.runtime.permission.requestAuthCode({
	    corpId: _config.corpId,
	    onSuccess: function(result) {
	    	//$('#keyword').val(result.code);
	    	//alert('authcode: ' + result.code);
	    	$('#calendar').fullCalendar({
				header: {right: 'month,agendaWeek,basicDay'},
				lang: 'zh-cn',
				contentHeight: ($(window).height()-50)/2,
			    handleWindowResiz:true,
				selectable: true,
				selectHelper: false,
				//默认选择日期
				defaultDate: '${starttime}',
				 //左侧时间格式，以及开始结束时间
				axisFormat: 'HH:mm',
				//event时间格式
				timeFormat: 'HH:mm',
				minTime: '7:00',
				maxTime: '23:00',
			    //去掉全天
				allDaySlot: false,
			    //列格式
				columnFormat:{
			    month: 'ddd', // Mon
			    week: 'ddd     DD', // Mon 9/7
			    day: 'dddd     MM月DD日' // Monday 9/7 
				},
				windowResize: function(view) {
				    $('#calendar').fullCalendar({
				    	contentHeight: ($(window).height()-50)/2
				    });
				},
				viewDisplay:function(view){
				    if (view.name == "basicDay") {
				        $('#calendar').fullCalendar({
				        	contentHeight: $(window).height()-50,
				        	
				        });
				        $("#eventlisth").height(0);
				    } else if (view.name == "agendaWeek") {
				        $('#calendar').fullCalendar({
				        	contentHeight: $(window).height()-50,
				        });
				        $("#eventlisth").height(0);
				    } else if (view.name == "month") {
				        $('#calendar').fullCalendar({
				        	contentHeight: ($(window).height()-50)/2,
				        });
				        $("#eventlisth").height(($(window).height()-50)/2);
				    }
				},
				eventAfterRender: function (event, element, view) {//数据绑定上去后添加相应信息在页面上
				    var fstart = event.start.toString().replace("GMT+0000","GMT+0800");
				    var fend = event.end.toString().replace("GMT+0000","GMT+0800");
				   // alert(fstart+fend);
				    var confbg = '';
				        confbg = confbg + '<span class="fc-event-bg"></span>';
				        if (view.name == "basicDay" && formatToDateyymmdd(fstart)<formatToDateyymmdd(fend)) {//按日
				            var evtcontent = '<a>';
				            evtcontent = evtcontent + confbg; evtcontent = evtcontent + '<span class="fc-time">'+formatToDatehm(fstart)+'至'+formatToDatehm(fend)+'</span>';
				            evtcontent = evtcontent + '<span class="fc-title">'+event.title+'</span>';
				            evtcontent = evtcontent +  '</a>';
				            element.html(evtcontent);
				        }
				
				},
				select: function( startDate, endDate ){
					var view = $('#calendar').fullCalendar('getView');
					if(view.name == "month"){
						
						getdayevent(formatToDateyymmdd(startDate.toString().replace("GMT+0000","GMT+0800")));
					}
					//window.location.href="${ctx}/calender/daylist?time="+start.unix();
					
				},
				eventClick:function(calEvent, jsEvent, view){
					 var view = $('#calendar').fullCalendar('getView');
						if(view.name == "month"){
							getdayevent(formatToDateyymmdd(calEvent.start.toString().replace("GMT+0000","GMT+0800")));
						}else{
							lookevents(calEvent.constraint);
						}
				   // window.location.href="${ctx}/calender/daylist?time="+calEvent.start.unix();
				},
				editable: false,
				eventLimit: true, // allow "more" link when too many events
				events:function(start, end, timezone, callback) {
					getlist(start, end, timezone, callback,result.code);
					dd.device.notification.hidePreloader({
					    onSuccess : function(result) {
					        /*{}*/
					    },
					    onFail : function(err) {}
					});
				}
			});
	    	$(".fc-agendaWeek-button").on('click', function () {
	    		
	    		  $('#calendar').fullCalendar('option', 'contentHeight', $(window).height()-50);
	    		  $("#eventlisth").height(0);
			});
	    	$(".fc-basicDay-button").on('click', function () {
	    		
	    		  $('#calendar').fullCalendar('option', 'contentHeight', $(window).height()-50);
	    		  $("#eventlisth").height(0);
			});
	    	$(".fc-month-button").on('click', function () {
	    		
	    		  $('#calendar').fullCalendar('option', 'contentHeight', ($(window).height()-50)/2);
	    		  $("#eventlisth").height(($(window).height()-50)/2);
			});
	    },
	    onFail : function(err) {}

	});
	//创建一个新的hammer对象并且在初始化时指定要处理的dom元素
      var hammertime = new Hammer(document.getElementById("calendar"));
         //添加事件
        hammertime.on("swipeleft", function (e) {
        	$('#calendar').fullCalendar("next");
        	 var view = $('#calendar').fullCalendar('getView');
			 if(view.name == "month"){
	        	   var selectdate=$('#calendar').fullCalendar("getDate").toString().replace("GMT+0000","GMT+0800");
	               var now=new Date();
	               var sdate=new Date(selectdate);
	        	   if(now.format("yyyyMM")==sdate.format("yyyyMM")){
	        		   $('#calendar').fullCalendar("today"); 
	        	   }
			 }
      	});
        hammertime.on("swiperight", function (e) {
        	$('#calendar').fullCalendar("prev");
        	 var view = $('#calendar').fullCalendar('getView');
			 if(view.name == "month"){
	        	   var selectdate=$('#calendar').fullCalendar("getDate").toString().replace("GMT+0000","GMT+0800");
	               var now=new Date();
	               var sdate=new Date(selectdate);
	        	   if(now.format("yyyyMM")==sdate.format("yyyyMM")){
	        		   $('#calendar').fullCalendar("today"); 
	        	   }
			 }
        });
       // downhammertime.on("swipeup",function(){.......})
        
      //创建一个新的hammer对象并且在初始化时指定要处理的dom元素
      var beforX;
       var beforY;
       var isBegin=true;
        var hammeraddbutton = new Hammer(document.getElementById("addbutton"));
        //添加事件
       hammeraddbutton.on("pan", function (e) {
        	 //alert('123');
        	 //$("#addbutton").bottom="500px";
        	//alert($("#addbutton").css("bottom")+"偏移"+e.deltaX);
        	 //alert($("#addbutton").css("right")+"偏移"+e.deltaY);
        	 if(isBegin){
        		 beforX=parseInt($("#addbutton").css("right").replace("px", ""));
        		 beforY=parseInt($("#addbutton").css("bottom").replace("px", ""));
        		 isBegin=false;
        	 }
        	var endY=beforY-parseInt(e.deltaY);
        	var endX=beforX-parseInt(e.deltaX);
        	//alert(endX+","+endY);
        	//$("#addbutton").css("bottom",endX+"px");
        	//$("#addbutton").css("right",endY+"px");
        	//alert(endY+"-"+$(window).height()+"-"+endX+"-"+endX)
        	if(parseInt(endY)>0&&parseInt(endX)>0&&parseInt(endY)+100<parseInt($(window).height())&&parseInt(endX)+50<parseInt($(window).width())){
        		$("#addbutton").css("bottom",endY+"px");
            	$("#addbutton").css("right",endX+"px");
        	}
        	
        	// alert($("#addbutton").html());
        	 //.style.top='50px';
        });
       hammeraddbutton.on("panend", function (e) { 
    	   isBegin=true;
       });
       
      
});


dd.error(function(err) {
	alert('sdfs');
	alert('dd error: ' + JSON.stringify(err));
});
	
	
	function getlist(start, end, timezone, callback,code) {
	 	$.ajax({
			url:'${ctx}/calender/list',
			data:{
				viewStart:start.unix(),
				viewEnd:end.unix(),
				code:code
				},
			type:'POST',
			dataType:'json',
			success:function(responseText){
				var events = [];
				$.each(responseText.userdata,function(i,n){	
					var color="#3BA1BF";
					if($(this).attr('backcolor')!=""&$(this).attr('backcolor')!=null){
						color=$(this).attr('backcolor');
					}
					events.push({
                        title:  $(this).attr('title'),
                        id: formatToDateyymmdd($(this).attr('starttime')),
                        start:formatToDate($(this).attr('starttime')),
                        end:formatToDate($(this).attr('endtime')),
                        constraint:$(this).attr('id'),
                        backgroundColor: color,
                        addname:$(this).attr('operationer'),
                        selecttime:$(this).attr('selecttime'),
                        isfinish:$(this).attr('isfinish')
                    });
					
					
				});
				
                callback(events);
                //alert($('#calendar').fullCalendar("getDate"));
               //解决时区问题
                var selectdate=$('#calendar').fullCalendar("getDate").toString().replace("GMT+0000","GMT+0800");
               
                getdayevent(formatToDateyymmdd(selectdate));
    	    	
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				alert(XMLHttpRequest.status+XMLHttpRequest.readyState+textStatus);
			}
		});
	 	
    };
    //获得选择日期的事件
    function getdayevent(selectdate){
    	//记录选择时间
    	lastSelectTime=selectdate;
    	$("#eventlisth").empty();
    	var eventlist=$('#calendar').fullCalendar('clientEvents');
    	//循环获得选择时间内的日程
    	$.each(eventlist,function(i,n){
    		 var startdate=n.start.toString().replace("GMT+0000","GMT+0800");
    		 var enddate=n.end.toString().replace("GMT+0000","GMT+0800");
    		 if(selectdate>=formatToDateyymmdd(startdate)&&selectdate<=formatToDateyymmdd(enddate)){
    			 var timeStr=formatToDatehm(startdate)+"至"+formatToDatehm(enddate);
    			 var delline="";
    			 var eventstats="";
    			 var nowdate=new Date();
    			 var ed=new Date(enddate);
    			 //判断是否完成
    			 if(n.isfinish=="1"){
    				 delline="delline";
    				 eventstats="<i class=\"weui_icon_success\"></i>";
    			 }else if(nowdate.format("yyyyMMddhhmm")>ed.format("yyyyMMddhhmm")){
    				 eventstats="<i class=\"weui_icon_info_circle\"></i>";
    			 }
    			 //是否是全天时间
    			 if(n.selecttime=="0"){
    				 timeStr="全天";
    			 }else if(formatToDateyymmdd(startdate)==formatToDateyymmdd(enddate)){
    				 timeStr=formatToDatestr(startdate,"hh:mm")+"至"+formatToDatestr(enddate,"hh:mm");
    			 }
    			 //添加日程展示div
    			 var eventhtml="<div class=\"eventline\" onclick=\"lookevents('"+n.constraint+"');\"  ><div class=\"eventtime\" >"+timeStr+"<div  class=\"eventname\" >"+n.addname+"</div><div  class=\"eventcolor\" style=\"background-color:"+n.backgroundColor+"\" ></div></div><div class=\"eventtitle "+delline+"\">"+eventstats+n.title+"</div></div>";
    			 $("#eventlisth").append(eventhtml);
    		 }
    		
		});
    }
    
    //查看选择的日程
    function lookevents(id){
    	window.location.href="${ctx}/calender/eventview?id="+id+"&dd_nav_bgcolor=FF30A8A5";
    }
    function addevent(){
    	var time= lastSelectTime.substr(0,4)+'/'+ lastSelectTime.substr(4,2)+'/'+ lastSelectTime.substr(6,2)+' 08:00:00';
        window.location.href="${ctx}/calender/event?dd_nav_bgcolor=FF30A8A5&starttime="+time;
    }
    
    //时间格式化
    function formatToDateyymmdd(cellvalue){
		if(cellvalue!=null){
			var date = new Date(cellvalue);// 或者直接new Date();
		    return date.format("yyyyMMdd");
		}
		else
			return "";
	};
	function formatToDatestr(cellvalue,formatstr){
		if(cellvalue!=null){
			var date = new Date(cellvalue);// 或者直接new Date();
		    return date.format(formatstr);
		}
		else
			return "";
	};
	function formatToDatehm(cellvalue){
		if(cellvalue!=null){
			var date = new Date(cellvalue);// 或者直接new Date();
		    return date.format("yyyy-MM-dd hh:mm");
		}
		else
			return "";
	};
	function formatToday(cellvalue){
		if(cellvalue!=null&&cellvalue!=""){
			var date = new Date(cellvalue);// 或者直接new Date();
		    return date.format("yyyy-MM-dd");
		}
		else
			return "";
	};
	function formatToDate(cellvalue){
		if(cellvalue!=null&&cellvalue!=""){
			var date = new Date(cellvalue);// 或者直接new Date();
		    return date.format("yyyy-MM-dd hh:mm:ss");
		}
		else
			return "";
	};
//时间格式式化
function strToDate(str) {
 var tempStrs = str.split(" ");
 var dateStrs = tempStrs[0].split("-");
 var year = parseInt(dateStrs[0], 10);
 var month = parseInt(dateStrs[1], 10) - 1;
 var day = parseInt(dateStrs[2], 10);
 var timeStrs = tempStrs[1].split(":");
 var hour = parseInt(timeStrs [0], 10);
 var minute = parseInt(timeStrs[1], 10) - 1;
 var second = 0;
 var date = new Date(year, month, day, hour, minute, second);
 return date;
}
</script>
<style>

	body {
		margin: 0px auto 0px auto;
		padding: 0;
		font-size: 14px;
		background-color: #EFF0F0;
	}

	#calendar {
		
		margin: 0 auto;
	}
.eventtime{
margin-left:10px;
margin-right:10px;
border-bottom:1px solid #EDEDED; 
height:30px;
line-height:30px;
color: #888889;
}
.eventtitle{
margin-left:10px;margin-right:10px; 
line-height:40px;
    font-size: 16px;
    color:#565656;
  word-break: break-all
}
.eventline{
background-color:#FEFEFE; 
border:1px solid #FBFBFB;
border-left:0px;border-right:0px; 
margin-left:0px;margin-right:0px;margin-top:10px;
/*height:70px
height:auto;
overflow:auto;*/
}
.eventcolor{
    float: right;
    height: 20px;
    width: 20px;
    margin-top: 5px;
}
.eventname{

    float: right;
    
}
</style>
</head>
<body>

	<div id='calendar'></div>
<div id='eventlisth' class='eventlisth'>

</div>
<div id='addbutton' class='circle123' onclick="addevent()" >+</div>
</body>
</html>