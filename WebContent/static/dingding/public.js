//日期转化 主要在列表中使用 
Date.prototype.format = function(format) {
    var o = {"M+" : this.getMonth() + 1,"d+" : this.getDate(),"h+" : this.getHours(),"m+" : this.getMinutes(),"s+" : this.getSeconds(),"q+" : Math.floor((this.getMonth() + 3) / 3),"S" : this.getMilliseconds()
	};
	if (/(y+)/.test(format)) {
	    format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
	    if (new RegExp("(" + k + ")").test(format)) {
		format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
	    }
	}
	return format;
};

function defaultAsNull(str,defaultStr){
	if(!str || $.trim(str)==''){
		return defaultStr?defaultStr:'';
	}else{
		return str;
	}
}

//设置弹出框居中
function setBoxCenter(_boxId,_boxWidth,_boxHeight,_currWindow)
{
	if(!_currWindow){
		_currWindow = window;
	}
  var obox=_currWindow.document.getElementById(_boxId);
  if (obox !=null && obox.style.display !="none")
  {
  	if(!_boxWidth){
			_boxWidth = $('#'+_boxId).width();
		}
		if(!_boxHeight){
			_boxHeight = $('#'+_boxId).height();
		}
		
      var oLeft,oTop;
      if (_currWindow.innerWidth)
      {
          oLeft=_currWindow.pageXOffset+(_currWindow.innerWidth-_boxWidth)/2 +"px";
          oTop=_currWindow.pageYOffset+(_currWindow.innerHeight-_boxHeight)/2 +"px";
      }
      else
      {
          var dde=_currWindow.document.documentElement;
          oLeft=dde.scrollLeft+(dde.offsetWidth-_boxWidth)/2 +"px";
          oTop=dde.scrollTop+(dde.offsetHeight-_boxHeight)/2 +"px";
      }
      
      obox.style.left=oLeft;
      obox.style.top=oTop;
      //问题1、居左、居上存在问题，有可能相对定位的父容器是负值，不在当前屏幕区域；
      //问题2、其本身定位在那个位置，比如margin为负值等样式属性会有影响
      $(obox).css('margin','0 0 0 0');
  }
}

var excludeFileSuffixs=[".exe",".com",".bat",".msi",".vbs",".js",".cmd",".scr",".dll"];//非法文件后缀名
var includePictureFileSuffixs=['.jpe','.jpg','.jpeg','.bmp','.gif','.png','.ico'];//有效图片文件后缀名
/**
 * 
 * @param fileName 文件名【字符串】，不能为空
 * @param includeFileSuffixs 用于校验文件后缀名是否有效【字符串数组】,可以为空
 * @returns {Number} 返回结果（解释如下）：0、1、2、3、4
 */
function validateFileSuffix(fileName,includeFileSuffixs){
	if(!fileName || typeof fileName !='string' || $.trim(fileName)==""){
		return 1;//文件名不存在
	}
	
	var fileSuffix=fileName.substring(fileName.lastIndexOf('.'),fileName.length); 
	if(!fileSuffix || $.trim(fileSuffix)==""){
		return 2;//文件后缀名不存在
	}
	
	if(excludeFileSuffixs){
		if(typeof excludeFileSuffixs=='object' && excludeFileSuffixs instanceof Array && excludeFileSuffixs.length>0){
			for(var i=0; i<excludeFileSuffixs.length; i++){
				if(excludeFileSuffixs[i] && typeof excludeFileSuffixs[i]=='string' && $.trim(excludeFileSuffixs[i])!=""){
					if(fileSuffix.toLowerCase()==excludeFileSuffixs[i].toLowerCase()){
						return 3;//非法文件后缀名
					}else{
						continue;
					}
				}else{
					throw "System parameter config error!";
				}
			}
		}else{
			throw "System parameter config error!";
		}
	}	
	
	if(includeFileSuffixs){
		if(typeof includeFileSuffixs=='object' && includeFileSuffixs instanceof Array && includeFileSuffixs.length>0){
			for(var i=0; i<includeFileSuffixs.length; i++){
				if(includeFileSuffixs[i] && typeof includeFileSuffixs[i]=='string' && $.trim(includeFileSuffixs[i])!=""){
					if(fileSuffix.toLowerCase()==includeFileSuffixs[i].toLowerCase()){
						break;
					}else{
						if(i==includeFileSuffixs.length-1){
							return 4;//不是有效的文件后缀名
						}else{
							continue;
						}
					}
				}else{
					throw "Function parameter error!";
				}
			}
		}else{
			throw "Function parameter error!";
		}
	}	
	
	return 0;//合格的文件后缀名
}

function formatToDate(cellvalue){
	if(cellvalue!=null){
		var date = new Date(cellvalue);// 或者直接new Date();
	    return date.format("yyyy-MM-dd hh:mm:ss");
	}else{
		return "";
	}
}