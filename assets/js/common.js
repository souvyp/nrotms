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
	return eval('('+data+')');// JSON.parse(data);
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

function GetRequestJn(){
	var str = location.href;
    var i=str.indexOf('#');
	if(i>0)
		return str.substring(i+1,i+2);
	else
		return null;
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

Date.prototype.format = function(format){ 
	var o = { 
	"M+" : this.getMonth()+1, //month 
	"d+" : this.getDate(), //day 
	"h+" : this.getHours(), //hour 
	"m+" : this.getMinutes(), //minute 
	"s+" : this.getSeconds(), //second 
	"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
	"S" : this.getMilliseconds() //millisecond 
	} 
	
	if(/(y+)/.test(format)) { 
		format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	} 

	for(var k in o) { 
		if(new RegExp("("+ k +")").test(format)) { 
			format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
		} 
	} 
	return format; 
}


Date.prototype.Format = function (fmt) { //author: meizz 
	var o = {
		"M+": this.getMonth() + 1, //月份 
		"d+": this.getDate(), //日 
		"h+": this.getHours(), //小时 
		"m+": this.getMinutes(), //分 
		"s+": this.getSeconds(), //秒 
		"q+": Math.floor((this.getMonth() + 3) / 3), //季度 
		"S": this.getMilliseconds() //毫秒 
	};
	if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for (var k in o)
	if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}

/*****************************************和数据库交互部分*********************************************/
var DATA_URL = '/code/data/misc.chi';
var GRID_URL = '/code/db/grid.chi';
var TABLE_URL = '/code/data/table.chi';
var FILE_URL = '/code/files/misc.chi';
var NODE_URL = '/code/net/notes.chi'

function OnlineData( param, h, url, dataType, jsonp, retryCount, err, _method )
{
    if ( url.indexOf( '.json' ) != -1 )
    {
        _method = 'get';
    }
	if (typeof(_method) == "undefined")
	{
		_method = "post";
	}
	if (_method != "get" && _method != "post" && _method != "put")
	{
		_method = "post";
	}
	if(!retryCount) retryCount=0;
	$.ajax({
		type: _method,
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
				console.log(url ? url : DATA_URL,param,'网络错误');
			}
		}
	});
}



function GetContent(url,param,type,masked,sucHandle,errHandle){
	$.ajax({
		type: "get",
		url: url,
		data:param,
		dataType:type,
		ifModified:true,
		cache:true,
		beforeSend: function(XMLHttpRequest){
			if(masked)
				mask();
		},
		success: function(data, textStatus){
			if(sucHandle)sucHandle(data);
		},
		complete: function(XMLHttpRequest, textStatus){
			if(masked)
				unmask();
		},
		error: function(){
			if(errHandle)errHandle();
		}
	});
} 

function PostContent(url,param,type,masked,sucHandle,errHandle){
	$.ajax({
		type: "post",
		url: url,
		data:param,
		dataType:type,
		beforeSend: function(XMLHttpRequest){
			if(masked)
				mask();
		},
		success: function(data, textStatus){
			if(sucHandle)sucHandle(data);
		},
		complete: function(XMLHttpRequest, textStatus){
			if(masked)
				unmask();
		},
		error: function(){
			if(errHandle)errHandle();
		}
	});
} 





/*********************************************functions*******************************************/

function myShowModalDialog(url, width, height, fn) {
    if (navigator.userAgent.indexOf("Chrome") > 0) {
        window.returnCallBackValue354865588 = fn;
        var paramsChrome = 'height=' + height + ', width=' + width + ', top=' + (((window.screen.height - height) / 2) - 50) +
            ',left=' + ((window.screen.width - width) / 2) + ',toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no';
        window.open(url, "newwindow", paramsChrome);
    }
    else {
        var params = 'dialogWidth:' + width + 'px;dialogHeight:' + height + 'px;status:no;dialogLeft:'
                    + ((window.screen.width - width) / 2) + 'px;dialogTop:' + (((window.screen.height - height) / 2) - 50) + 'px;';
        var tempReturnValue = window.showModalDialog(url, "", params);
        fn.call(window, tempReturnValue);
    }
}
function myReturnValue(value) {
    if (navigator.userAgent.indexOf("Chrome") > 0) {
        window.opener.returnCallBackValue354865588.call(window.opener, value);
    }
    else {
        window.returnValue = value;
    }
}

function openBlank(url,name,iWidth,iHeight,newW){

	if(url){
		 name = name?name:'未命名';                           //网页名称，可为空;
		 iWidth = iWidth ?  iWidth : window.screen.availWidth -30;                        //弹出窗口的宽度;
		 iHeight = iHeight ? iHeight : window.screen.availHeight - 80;                       //弹出窗口的高度;
		 var iTop = 2;// (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
		 var iLeft = 2;// (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
		
	//	myShowModalDialog(url,iWidth,iHeight,function(){alert(100)});
		 var result=  window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,fullscreen=yes,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
		 
		 var that=window;
		  window.onfocus=function (){result.focus();};
		  window.onclick=function (){result.focus();};
		  result.onclose=function(){
				if ( typeof(RefreshData) != "undefined" )
					RefreshData();	
					
				};
		  result.onbeforeunload=function(){
				if ( typeof(RefreshData) != "undefined" )
					RefreshData();	 
		 };
			 
	}
	else{
		var formcontainer=$('.formcontainer');
		if(formcontainer.length==1){
			$('#demo').hide();
			var table=$('.formcontainer .FormTable[code]');
			if(!table[0].inited){
				//if($('body').attr('workflow'))
					table[0].oldHtml=table.html();
				table[0].inited=true;
				var mid=url;
				setTimeout(function(){
					
					initTableForm(table,false,null,mid);
				},100)
			}
			else{
				$('.formcontainer').show();
				var mid=url;
				if(table[0].oldHtml){
					table.html(table[0].oldHtml);
					setTimeout(function(){					
						initTableForm(table,false,null,mid);
					},100)
				}
				else{
					var defaults=table.find('td:eq(0)').attr('default');
					if(!defaults)
						defaults='';
					else 
						defaults = unescape(defaults);
					
					initTableFormData(table,mid,defaults);
				}
			}
		}
		else{
			/*$('#win-Common-Dialog .content').height(iHeight);
			$('#win-Common-Dialog .content').width(iWidth);*/
			$('#win-Common-Dialog .content').html('<iframe id="mainFrame" src="'+url+'" />');
			$('#win-Common-Dialog').modal('show');
			$('#win-Common-Dialog').on('hidden.bs.modal',function(e){
				if ( typeof(RefreshData) != "undefined" )
				//if (RefreshData && RefreshData instanceof Function)
						RefreshData();	
			});
			/*var iframe = document.getElementById("mainFrame");  
			if (iframe.attachEvent) {  
				iframe.attachEvent("onload", function() {  
					var doc=$(this).prop('contentWindow').document;
					$(this).height($(doc).height());
				});  
			} else {  
				iframe.onload = function() {  
					var doc=$(this).prop('contentWindow').document;
					$(this).height($(doc).height());
				};  
			} 
			if (self != top) { 
				
				parent.ShowOverModal();
				
			} */
		}
	}
}

function closeBlank(){
	$('#win-Common-Dialog').modal('hide');
}

function ShowOverModal(){
	if($('.ShowOverModal').length==0)
		$('<div class="ShowOverModal"></div>').appendTo('body').show();
	else	
		$('.ShowOverModal').show();
}

function HideOverModal(){
	$('.ShowOverModal').hide();
}
/*
$(function(){
	if($('#win-Common-Dialog').length==1){		
		$('#win-Common-Dialog').on('show.bs.modal',function(e){
				if (self != top) { 
					var frm = $(parent.document.all("mainFrame"));
					frm.height(Math.max(frm.height(),$(this).find('.content').height())); 
				}
			});
		$('#win-Common-Dialog').on('hide.bs.modal',function(e){
				if (self != top) { //在iframe中	
					parent.HideOverModal();
				}
			});
	}
});*/

function closeForm( obj )
{
    var _code = $( 'body' ).attr( 'code' );
    if ( typeof ( _code ) != 'undefined' )
    {
        location.href = '/' + _code + '.aspx';
    }
    else
    {
        var demo = $( '#demo' );
        if ( demo.length == 1 )
        {
            demo.show();
            $( '.formcontainer' ).hide();
            if ( typeof ( RefreshData ) != "undefined" )
                RefreshData();
        }
        else
        {
            if ( self != top )
            { //在iframe中	
                window.parent.closeBlank();
            }
            else
                window.close();
        }
    }
	
}

/*  封装bootstrap modal

// 四个选项都是可选参数
Modal.alert(
  {
    msg: '内容',
    title: '标题',
    btnok: '确定',
    btncl:'取消'
  });

// 如需增加回调函数，后面直接加 .on( function(e){} );
// 点击“确定” e: true
// 点击“取消” e: false
Modal.confirm(
  {
    msg: "是否删除角色？"
  })
  .on( function (e) {
    alert("返回结果：" + e);
  });
 */ 

 

$('<!-- system modal start -->\n'+
	'<div id="ycf-alert" class="modal">\n'+
	  '<div class="modal-dialog modal-sm">\n'+
		'<div class="modal-content">\n'+
		  '<div class="modal-header">\n'+
			'<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>\n'+
			'<h5 class="modal-title"><i class="fa fa-exclamation-circle" style="background-color: #f27302; padding-left: 3px; height: 20px; line-height: 20px; margin-bottom: 25px;"></i> <span style="padding-left:8px;font-family:\'微软雅黑\';">[Title]</span></h5>\n'+
		  '</div>\n'+
		  '<div class="modal-body small">\n'+
			'<p>[Message]</p>\n'+
		  '</div>\n'+
		  '<div class="modal-footer" >\n'+
			'<button type="button" class="btn btn-primary btn-sm ok" data-dismiss="modal">[BtnOk]</button>\n'+
			'<button type="button" class="btn btn-default btn-sm cancel" data-dismiss="modal">[BtnCancel]</button>\n'+
		  '</div>\n'+
		'</div>\n'+
	  '</div>\n'+
	'</div>\n'+
'<!-- system modal end -->\n').appendTo('body');

  window.Modal = function () {
    var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm');
    var alr = $("#ycf-alert");
    var ahtml = alr.html();

    //关闭时恢复 modal html 原样，供下次调用时 replace 用
    //var _init = function () {
    //	alr.on("hidden.bs.modal", function (e) {
    //		$(this).html(ahtml);
    //	});
    //}();

    /* html 复原不在 _init() 里面做了，重复调用时会有问题，直接在 _alert/_confirm 里面做 */


    var _alert = function (options) {
      alr.html(ahtml);	// 复原
      alr.find('.ok').removeClass('btn-success').addClass('btn-primary');
      alr.find('.cancel').hide();
      _dialog(options);

      return {
        on: function (callback) {
          if (callback && callback instanceof Function) {
            alr.find('.ok').click(function () { callback(true) });
          }
        }
      };
    };

    var _confirm = function (options) {
      alr.html(ahtml); 
      alr.find('.ok').removeClass('btn-primary').addClass('btn-success');
      alr.find('.cancel').show();
      _dialog(options);

      return {
        on: function (callback) {
          if (callback && callback instanceof Function) {
            alr.find('.ok').click(function () { callback(true) });
            alr.find('.cancel').click(function () { callback(false) });
          }
        }
      };
    };
	
	var _wait = function (options) {
      alr.html(ahtml);	
      alr.find('.modal-footer').hide();
      _dialog(options);

      return {
        on: function (callback) {
          if (callback && callback instanceof Function) {
				callback(true);
          }
        }
      };
    };
	var _hide = function (options) {
      alr.modal('hide');
    };
	
	var _select = function (options) {
      alr.html(ahtml);	
	  alr.find('.modal-header button:eq(0)').hide(); 
      alr.find('.modal-footer .cancel').hide();
      _dialog(options);

      return {
        on: function (callback) {
          if (callback && callback instanceof Function) {
				alr.find('.ok').click(function () { callback(true) });
          }
        }
      };
    };
	var _hide = function (options) {
      alr.modal('hide');
    };
	
    var _dialog = function (options) {
      var ops = {
        msg: "提示内容",
        title: "操作提示",
        btnok: "确定",
        btncl: "取消"
      };

      $.extend(ops, options);

   //   console.log(alr);

      var html = alr.html().replace(reg, function (node, key) {
        return {
          Title: ops.title,
          Message: ops.msg,
          BtnOk: ops.btnok,
          BtnCancel: ops.btncl
        }[key];
      });
      
      alr.html(html);
      alr.modal({
        width: 500,
        backdrop: self != top?false:'static'
      });	  
    }

    return {
      alert: _alert,
      confirm: _confirm,
	  wait: _wait,
	  hide: _hide,
	  select:_select
    }

  }();


function Mask(txt){
	Modal.wait({
		msg: txt?txt: "正在获取远程数据，请稍候...",
        title: "请稍候..."
	});
}

function UnMask(){
	Modal.hide();
}

function alert(m){
	Modal.wait({
		msg: m?m:'未知信息',
        title: "温馨提示"
	});
}

function Logout(){
	GetContent('/code/users/user.chi?cmd=logout',{},'html',false,function(){
		location.href='../assets/login/';
	})
}

function openBlank( id )
{
    if ( typeof ( id ) != 'undefined' )
    {
        //编辑
        var _href = location.href.split( '/' )[3].split( '.' )[0] + '_edit.aspx?id=' + id + '';
        location.href = _href;
    }
    else
    {
        //新增
        var _href = location.href.split( '/' )[3].split( '.' )[0] + '_edit.aspx';
        location.href = _href;
    }
}