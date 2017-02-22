var MISC_URL='/code/data/misc.chi';
var MISC_FILE='/code/files/misc.chi';

function setCookie(name,value,time) {//两个参数，一个是cookie的名子，一个是值
    var Days = 30*24*60*60*1000; //此 cookie 将被保存 30 天
	if(time)Days=time*60*1000;
    var exp = new Date();    //new Date("December 31, 9998");
    exp.setTime(exp.getTime() + Days);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

function getCookie(name) {//取cookies函数        
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;
}

//取得页面参数
String.prototype.GetValue = function(para) {
    var reg = new RegExp("(^|&)" + para + "=([^&]*)(&|$)");
    var r = this.substr(this.indexOf("\?") + 1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}
function GetRequest(name) {
    var str = location.href;
    var re= str.GetValue(name); 
	if(re&&re!=""){
		var i=re.indexOf('#');
		if(i>0)re=re.substring(0,i);
	}
	return re;
}

$.extend({
    getUrlVars:function(){
         var vars=[],hash;
         var hashes=window.location.href.slice(window.location.href.indexOf( '?' ) + 1).split( '&' );
         for ( var    i = 0; i < hashes.length; i++)
          {
                hash = hashes[i].split( '=' );
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
           }
            return vars;
	},
     getUrlVar:function(name){
           return $.getUrlVars()[name];
	}
});

function getUrlParam(name)
{
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg);  //匹配目标参数
	if (r!=null) return unescape(r[2]); return null; //返回参数值
} 

function JsonToString (obj){   
	var THIS = this;    
	switch(typeof(obj)){   
		case 'string':   
			return '"' + obj.replace(/(["\\])/g, '\\$1') + '"';   
		case 'array':   
			return '[' + obj.map(THIS.JsonToString).join(',') + ']';   
		case 'object':   
			 if(obj instanceof Array){   
				var strArr = [];   
				var len = obj.length;   
				for(var i=0; i<len; i++){   
					strArr.push(THIS.JsonToString(obj[i]));   
				}   
				return '[' + strArr.join(',') + ']';   
			}else if(obj==null){   
				return 'null';   

			}else{   
				var string = [];   
				for (var property in obj) string.push(THIS.JsonToString(property) + ':' + THIS.JsonToString(obj[property]));   
				return '{' + string.join(',') + '}';   
			}   
		case 'number':   
			return obj;   
		case false:   
			return obj;   
	}   
}

function JsonToStr(data){
	return JSON.stringify(data);
}

function StrToJson(data){
	return JSON.parse(data);
}

function StringToJson(json){
	return eval('('+json+')');
}

function DataToTree(data){
	
}

Array.prototype.RemoveIndex = function(dx)
{
    if(isNaN(dx)||dx>this.length){return false;}
    this.splice(dx,1);
}
  
String.prototype.replaceAll  = function(s1,s2){  
	return this.replace(new RegExp(s1,"gm"),s2);
}

String.prototype.right = function (length_) {  
  
        var _from = this.length - length_;  
  
        if (_from < 0) _from = 0;  
  
        return this.substring(this.length - length_, this.length);  
  
};  

$.fn.isVisible = function() {return this.css('display') != 'none';}

function Log(e){
	console.log(e);
}

$(document).keydown(function(event){ 
	if(event.keyCode >= 37 && event.keyCode <= 40){ 
		return true;
	}
	else{
		if(window.event)event = window.event;
		var the =event.target || event.srcElement ;
		if( !( ( the.tagName== "INPUT" && the.type.toLowerCase() == "text" ) || the.tagName== "TEXTAREA" ) )
		{
			//$("#searchInput").focus();
		}
	}
});

/*
function alert(msg){
	$.messager.alert('提示',msg);
}
*/
function functionExist(funcName){
	try {  
		if(typeof(eval(funcName))=="function"){
		   return true;
		}
	}
	catch(e){
 //alert("not function"); 
	}
	return false;
}

function mask(text,id){
	var body=$('body');
	if(id)body=$('#'+id);
	if(body.children("div.datagrid-mask-msg").length==0){	
		if(!text)text='正在处理，请稍待。。。';
		$('<div class="datagrid-mask" style="display:block;z-index:9999;"></div>').appendTo(body);
		var msg=$('<div class="datagrid-mask-msg" style="display:block;z-index:9999;color: #000;"></div>').html(text).appendTo(body);
		msg.css("left",(body.width()-msg.outerWidth())/2);
	}
}

function unmask(id){
	var body=$('body');
	if(id)body=$('#'+id);
	body.children("div.datagrid-mask-msg").remove();
	body.children("div.datagrid-mask").remove();
}

function igEvent(event)
 {
		if(window.event)event = window.event;
		var the =event.target || event.srcElement ;
		if( !( ( the.tagName== "INPUT" && the.type.toLowerCase() == "text" ) || the.tagName== "TEXTAREA" ) )
		{
			return false;
		}
		return true ;			 	
 }
 //document.oncontextmenu=igEvent;
 document.onselectstart=igEvent;
	 
function get(url,param,type,handle,idlist,masked,async){
	if(idlist)idlist.html('<img src="images/loading.gif" />');
	$.ajax({
		type: "get",
		url: url,
		data:param,
		async:!async,
		dataType:type,
		ifModified:true,
		cache:true,
		beforeSend: function(XMLHttpRequest){
			if(masked)
				mask();
		},
		success: function(data, textStatus){
			if(idlist){
				var d=data.contents;
				if(d){
					for(var i=0;i<d.length;i++){
						if(idlist.length>i)
							idlist.eq(i).html(d[i]);
					}
				}
			}
			if(handle)handle(data);
		},
		complete: function(XMLHttpRequest, textStatus){
			if(masked)
				unmask();
		},
		error: function(){
			//请求出错处理
		}
	});
} 

function onlineContent(url,param,type,h){
	$.ajax({
		type: "post",
		url: url,
		data:param,
		dataType:type,
		beforeSend: function(XMLHttpRequest){
			mask();
		},
		success: function(data, textStatus){
			if(h)h(data);
		},
		complete: function(XMLHttpRequest, textStatus){
			unmask();
		},
		error: function(){
			//请求出错处理
		}
	});
} 
	
function addExtractParam(id,name,value){
	var ac = $("#"+id).data('autocompleter');
	if (ac && $.isFunction(ac.setExtraParam)) {
		ac.setExtraParam(name,value);
	} else {
		alert('Error setExtraParam');
	}
}

function ToInt(w){
	if(!w) return 0;
	return parseInt(w);
}
						
function readImgFile(input,h){ 
	var file = input.files[0]; 
	//这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件 
	if(!/image\/\w+/.test(file.type)){ 
		alert("请确保文件为图像类型"); 
		return false; 
	} 
	var reader = new FileReader(); 
	reader.readAsDataURL(file); 
	reader.onload = function(e){ 
		if(!this.result||this.result=="")
			alert("图像转换为图标错误，请重新选择图像!");
		else
			h(this.result); 
	} 
} 

$.fn.serializeObject = function()
{
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [o[this.name]];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};


function loadStyleString(css,id) {
    var style = document.createElement("style");
	if(id)style.id=id;
    style.type = "text/css";
    try {
        style.appendChild(document.createTextNode(css));
    } catch (ex) {
        style.styleSheet.cssText = css;
    }
    var head = document.getElementsByTagName("head")[0];
    head.appendChild(style);
}

function removeStyle(id){
	var style=document.getElementById(id);
	if(style){
		var p;
		if(p=style.parentNode)
			p.removeChild(style);
	}
}
//loadStyleString("body{background:red}");



function uuid() {
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";
 
    var uuid = s.join("");
    return uuid;
}

function guid() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
        return v.toString(16);
    });
}

function unid(len, radix) {
    var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
    var uuid = [], i;
    radix = radix || chars.length;
 
    if (len) {
      // Compact form
      for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random()*radix];
    } else {
      // rfc4122, version 4 form
      var r;
 
      // rfc4122 requires these characters
      uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
      uuid[14] = '4';
 
      // Fill in random data.  At i==19 set the high bits of clock sequence as
      // per rfc4122, sec. 4.1.5
      for (i = 0; i < 36; i++) {
        if (!uuid[i]) {
          r = 0 | Math.random()*16;
          uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
        }
      }
    }
 
    return uuid.join('');
}

/*参数定义：
        datas 要排序的数组，其中每个元素是一个JSON对象{}
        field 要排序的元素的字段名，将使用该字段进行排序
        type  排序类型，如果为"down"则为降序排序,否则升序
    */
function SortData(datas, field, type) {
	SortFun.field = field;
	datas.sort(SortFun);
	if (type == "down") {
		datas.reverse();
	}
}
function SortFun(data1, data2) {
	if (data1[SortFun.field] > data2[SortFun.field]) {
		return 1;
	}
	else if (data1[SortFun.field] < data2[SortFun.field]) {
		return -1;
	}
	return 0;
}

function FileExt(file){
	return /\.[^\.]+$/.exec(FileExt);
}

/***************格式化*************************/

Date.prototype.format =function(format)
{
	var o = {
	"M+" : this.getMonth()+1, //month
	"d+" : this.getDate(),    //day
	"h+" : this.getHours(),   //hour
	"m+" : this.getMinutes(), //minute
	"s+" : this.getSeconds(), //second
	"q+" : Math.floor((this.getMonth()+3)/3),  //quarter
	"S" : this.getMilliseconds() //millisecond
	}
	if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
	(this.getFullYear()+"").substr(4- RegExp.$1.length));
	for(var k in o)if(new RegExp("("+ k +")").test(format))
	format = format.replace(RegExp.$1,
	RegExp.$1.length==1? o[k] :
	("00"+ o[k]).substr((""+ o[k]).length));
	return format;
}
	
function DateFormat(s,f){
	var date=new Date(s);
	return date.format(f); 
}

function  roundFun(numberRound,roundDigit)   //处理金额 -by hailang  
{   
   if(numberRound>=0) {   
         var   tempNumber   =   parseInt((numberRound   *   Math.pow(10,roundDigit)+0.5))/Math.pow(10,roundDigit);   
         return   tempNumber;   
    }else{   
     numberRound1=-numberRound   
     var   tempNumber   =   parseInt((numberRound1   *   Math.pow(10,roundDigit)+0.5))/Math.pow(10,roundDigit);   
     return   -tempNumber;   
    }   
} 
function renderSize(value, p, record){
  if(null==value||value==''){
    return "0 Bytes";
  }
  var unitArr = new Array("Bytes","KB","MB","GB","TB","PB","EB","ZB","YB");
  var index=0;

  var srcsize = parseFloat(value);
  var quotient = srcsize;
  while(quotient>1024){
    index +=1;
   quotient=quotient/1024;
  }
  return roundFun(quotient,2)+" "+unitArr[index];
}