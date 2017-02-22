function setCookie(name,value) {//两个参数，一个是cookie的名子，一个是值
    var Days = 30; //此 cookie 将被保存 30 天
    var exp = new Date();    //new Date("December 31, 9998");
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

function getCookie(name) {//取cookies函数        
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;
}

function JsonToStr(data){
	return JSON.stringify(data);
}

function StrToJson(data){
	return JSON.parse(data);
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

//获取页面参数

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


$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		var i = this.name.indexOf('+');
		if (i > 0)
			this.name = this.name.substring(0, i);
		if (o[this.name]) {
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


function jsonKeyCount(obj) {
	var i = 0;
	for (var key in obj)
		i++;
	return i;
}

/*****************************************和数据库交互部分*********************************************/
var DATA_URL = '/code/data/misc.chi';
var GRID_URL = '/code/db/grid.chi';
var TABLE_URL = '/code/data/table.chi';
var FILE_URL = '/code/files/misc.chi';
var NODE_URL = '/code/net/notes.chi'

function OnlineData(param, h, url ,dataType,jsonp,retryCount,err) {
	if(!retryCount) retryCount=0;
	$.ajax({
		type: "post",
		url: url ? url : DATA_URL,
		data: param,
		dataType: dataType?dataType:'json',
		jsonp: jsonp?jsonp:null,  
		success: function(data, textStatus) {
			if (h)
			    h( data );
		},
		error: function(e) {
			if(retryCount<5){   //网络错误，最多重试5次
				//alert('网络错误，重试'+retryCount+'次');
				setTimeout(function(){
					OnlineData(param,h,url,dataType,jsonp,retryCount+1,err);
				},100);
			}
			else{
				if(err)err(e);
				console.log(url ? url : DATA_URL,'网络错误');
			}
		}
	});
}




/*******************************************waiting***********************************/
var waitDivID,waitInt=0;
var alertDivID;
function alert(msg){
	if(!alertDivID){	
		alertDivID=uuid();
		$('<div class="modal fade" id="'+alertDivID+'">'+
		  '<div class="modal-dialog">'+
			'<div class="modal-content">'+
			  '<div class="modal-header">'+
				'<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
				'<h4 class="modal-title">信息</h4>'+
			  '</div>'+
			  '<div class="modal-body">'+
				'<p>系统正在处理,请稍后...</p>'+
			  '</div>'+
			  '<div class="modal-footer">'+
				'<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>'+
			  '</div>'+
			'</div>'+
		  '</div>'+
		'</div>').appendTo($('body'));	
	};
	if(!msg)msg='系统正在处理,请稍后...';
	setTimeout(function(){
		$('#'+alertDivID+' .modal-body p').text(msg);
		$('#'+alertDivID).modal('show');
	},100);
}

var int_wait;

function Mask(){
	if(!waitDivID){	
		waitDivID=uuid();
		$('<div class="modal fade" id="'+waitDivID+'">'+
		  '<div class="modal-dialog">'+
			'<div class="modal-content">'+
			  '<div class="modal-body">'+
				'<div class="progress progress-striped active">'+ 
				   '<div class="progress-bar progress-success" style="width:50%"></div> '+
				  '</div>'+
			  '</div>'+
			
			'</div>'+
		  '</div>'+
		'</div>').appendTo($('body'));
		
		$('#'+waitDivID).on('show.bs.modal', function (e) {
			waitInt++;
		})
		$('#'+waitDivID).on('hidden.bs.modal', function (e) {
			waitInt--;
		})
	};

	if(waitInt==0)
		$('#'+waitDivID).modal('show');
}

function UnMask(){
	setTimeout(function(){
		if(waitInt>0)		
			$('#'+waitDivID).modal('hide');
		},300);
}

