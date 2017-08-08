DingTalkPC.config({
		agentId : authconfig.agentid,
		corpId : authconfig.corpId,
		timeStamp : authconfig.timeStamp,
		nonceStr : authconfig.nonceStr,
		signature : authconfig.signature,
		jsApiList : [ 'runtime.info', 'biz.contact.choose','device.notification.toast',
						'device.notification.confirm', 'device.notification.alert','biz.contact.complexChoose',
						'device.notification.prompt', 'biz.ding.post',
						'biz.util.openLink','biz.navigation.setRight','biz.navigation.setLeft',
						'device.notification.showPreloader','device.notification.hidePreloader','biz.navigation.close' ]
});

function changepeople(clickinputobj,idobj){
	clickinputobj.on('click', function () {
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

function changedept(clickinputobj,idobj){
	clickinputobj.on('click', function () {
		 var deptidlist='';
		 if(idobj.val()){
			 deptidlist=idobj.val();
		 }
		 dd.biz.contact.complexChoose({
			  startWithDepartmentId: 0, //-1表示从自己所在部门开始, 0表示从企业最上层开始，其他数字表示从该部门开始
			  selectedUsers: [], //预选用户
			  corpId: authconfig.corpId, //企业id
			  onSuccess: function(data) {
			
				  var names='';
				  var nameids='';
				  var dept=data.departments;
					  for(var i=0; i<dept.length; i++)  
					  {  
						  names=names+ dept[i].name+",";
						  nameids=nameids+dept[i].id+",";
					  }  
					  clickinputobj.val(names.substring(0,names.length-1));
					  idobj.val(nameids.substring(0,nameids.length-1));
			  },
			  onFail : function(err) {}
			});
		});
}



/**弹出成功信息
 * @param message 信息
 */
function successalert(message){
	DingTalkPC.device.notification.toast({
		    type: 'success', //toast的类型  success, error
		    text: message, //提示信息
		    duration: 2, //显示持续时间，单位秒，最短2秒，最长5秒
		    delay: 0, //延迟显示，单位秒，默认0, 最大限制为10
		    onSuccess : function(result) {
		        /*{}*/
		    },
		    onFail : function(err) {}
		});
}
/**弹出错误信息
 * @param message 信息
 */
function erroralert(message){
	DingTalkPC.device.notification.toast({
		type: 'error', //toast的类型  success, error
		    text: message, //提示信息
		    duration: 2, //显示持续时间，单位秒，最短2秒，最长5秒
		    delay: 0, //延迟显示，单位秒，默认0, 最大限制为10
		    onSuccess : function(result) {
		        /*{}*/
		    },
		    onFail : function(err) {}
		});
}
function gohome(){
	location.href="${ctx}/pcplan/index";
}
function getTime(ts) {    
    var t,y,m,d,h,i,s;  
    t = ts ? new Date(ts) : new Date();  
    y = t.getFullYear();  
    m = t.getMonth()+1;  
    d = t.getDate();  
    h = t.getHours();  
    i = t.getMinutes();  
    s = t.getSeconds();  
    // 可根据需要在这里定义时间格式  
    return y+'-'+(m<10?'0'+m:m)+'-'+(d<10?'0'+d:d)+' '+(h<10?'0'+h:h)+':'+(i<10?'0'+i:i)+':'+(s<10?'0'+s:s);  
}  