//脚本信息开始

var MSGTIMER = 20;
var MSGSPEED = 5;
var MSGOFFSET = 3;
var MSGHIDE = 3;

var validate = '';


var _vIter =
{
	"mail" : 
	{
	    "pattern": /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i,
	    "message": "不是合法的邮箱，请重新填写!"
	},
	"url" : 
	{
	    "pattern": /^(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i,
	    "message": "不是合法的网址，请重新填写!"//(https?|ftp):\/\/
	},
	'dateISO':
    {
        "pattern": /((^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(10|12|0?[13578])([-\/\._])(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(11|0?[469])([-\/\._])(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(0?2)([-\/\._])(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)([-\/\._])(0?2)([-\/\._])(29)$)|(^([3579][26]00)([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][0][48])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][0][48])([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][2468][048])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][2468][048])([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][13579][26])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][13579][26])([-\/\._])(0?2)([-\/\._])(29)$))/,
        "message": "不是合法的日期，请重新填写!"
    },
	'number':
    {
        "pattern": /^[+-]?(\d+(\.\d*)?|\.\d+)([Ee]-?\d+)?$/,
        "message": "只能输入数字，请重新填写!"
    },
	'digits':
    {
        "pattern": /^\d+$/,
        "message": "只能输入整数，请重新填写!"
    }
};

function _VerifyRequired(srcObj, valueObj, cnName)
{
	if (srcObj[0].tagName != 'SELECT') {
		if (srcObj.val() == null || srcObj.val().length == 0 ) {
			//alert(cnName + "不能为空，请重新填写！");
			//srcObj.focus();
			inlineMsg( srcObj, '' + valueObj.code + '', '' + cnName + '不能为空，请重新填写！', 2 );
			return false;
		}
	} else {
		if (srcObj.prev().val() == '' || srcObj.prev().val() == '0') {
			inlineMsg( srcObj, '' + valueObj.code + '', '' + cnName + '不能为空，请重新填写！', 2 );
			return false;
		}
	}
	return true; 
}

function _VerifyMaxlength( srcObj, valueObj, cnName, nSize )
{
	if (srcObj.val().length > nSize && srcObj.val().length != 0)
	{
		//alert( cnName + '超过了限定字符，请重新填写！' );
		inlineMsg( srcObj, '' + valueObj.code + '', '' + cnName + '超过了限定字符，请重新填写！', 2 );
		
		return false;
	}
	
	return true;
}

function _VerifyTextarea( vfy_textarea1, srcObj, valueObj, cnName, nSize )
{
	if(vfy_textarea1){
		var _n = vfy_textarea1.replaceAll( '\n', '' );
		//var _t = (_n.replaceAll( '\t', '' )).replace( /\s+/g, "" );
		var _t = _n.replaceAll( '\t', '' );
		var _valiObj = $.parseJSON( _t.replace( /\'/g, "\"" ) );
		if ( srcObj.val().length != 0 )
		{
			var _reg = new RegExp( _valiObj.pattern, 'i' );
			if ( !srcObj.val().match( _reg ) )
			{
				inlineMsg( srcObj, '' + valueObj.code + '', '' + cnName + _valiObj.message + '', 2 );
				return false;
			}
		}
	}
    return true;
}

function _VerifyMaxRegExp( v, valueObj, srcObj )
{
	for (var _key in _vIter)
	{
		if (_key == v && srcObj.val().length != 0)
		{
			var reg = _vIter[_key].pattern;
			if ( !srcObj.val().match( reg ) )
			{
			    //alert( cnName + _vIter[_key].message );
			    inlineMsg( srcObj,  '' + valueObj.code + '', '' + _vIter[_key].message + '', 2 );
				return false;
			}
		}
	}
	
	return true;
}

//执行表单验证操作
function _VerifyForm(table)
{
	var _result = true;

	table.find('tr:not([rowid])').find("[verify][verify!='{}']").each(function(index)
	{
		var _obj = $(this);
		var tr= _obj.closest('tr');
		if(tr.attr('nrowid')){
			if(!tr[0].isDirty)
				return true;
		}
		var _verifyStr = _obj.attr("verify");

		if (_verifyStr)
		{
			var _verify = StrToJson(_verifyStr);
			for (var _v in _verify)
			{
				if (_v == "required" && _verify[_v])
				{
					_result = _VerifyRequired( _obj, _verify, _verify["title"] );
				}
				else if (_v == "maxlength" && _verify[_v])
				{
					_result = _VerifyMaxlength( _obj, _verify, _verify["title"] , _verify["length"] );
				}
				else if ( _v == "textarea1" && _verify[_v] )
				{
					_result = _VerifyTextarea( _verify["validate"], _obj, _verify, _verify["title"] , _verify["length"] );
				}
				else
				{
					//此处改用正则表达式，写成通用函数
					//正则表达式在JSON中统一定义
					_result = _VerifyMaxRegExp( _v, _verify, _obj );
				}
				
				if (!_result)
				{
					//break
					return false;
					
					//the sentence return; means continue
				}
			}			
		}
	});

	return _result;
}


//将配置应用到表单上 
function _ConfigVerify(options)
{
	var _verify = {};
	for (var _key in options)
	{
		if (_key.substr(0, 4) == "vfy_")
		{
			if (!_verify.title)
			{
				_verify.title = options.displayname?options.displayname:options.codename;
				_verify.length = options.characterlength;
				if ( options.vfy_textarea ){
				    _verify.validate = options.vfy_textarea[1];
				}
			}
			_key = _key.replace( "vfy_", "" );

			eval('_verify.' + _key + ' = true;');
		}
	}
	
	return _verify;
}

//构建的div,设置属性和褪色的函数调用
function inlineMsg( srcObj, target, string, autohide )
{
    var msg;
    var msgcontent;
    if ( !document.getElementById( 'msg' ) )
    {
        msg = document.createElement( 'div' );
        msg.id = 'msg';
        msgcontent = document.createElement( 'div' );
        msgcontent.id = 'msgcontent';
        document.body.appendChild( msg );
        msg.appendChild( msgcontent );
        msg.style.filter = 'alpha(opacity=0)';
        msg.style.opacity = 0;
        msg.alpha = 0;
    } else
    {
        msg = document.getElementById( 'msg' );
        msgcontent = document.getElementById( 'msgcontent' );
    }
    msgcontent.innerHTML = string;
    msg.style.display = 'block';
    var msgheight = msg.offsetHeight;
    //var targetdivs = document.getElementsByName( target );
    var targetdiv = '';
    if ( srcObj[0].localName == 'select' )
    {
        targetdiv = srcObj.next()[0];//srcObj[0]
    }
    else
    {
        targetdiv = srcObj[0];
    }

	//var targetdiv = targetdivs[i];
	targetdiv.focus();
	var targetheight = targetdiv.offsetHeight;
	var targetwidth = targetdiv.offsetWidth;
	var topposition = topPosition( targetdiv ) - ( ( msgheight - targetheight ) / 2 );// + MSGOFFSET+ targetheight ;
	var leftposition = leftPosition( targetdiv ) + targetwidth + MSGOFFSET - targetwidth;
	//var msgW=Math.max(Math.min($(window).width()-leftposition-MSGOFFSET-250 ,250),50);


	
	msg.style.top = topposition + 'px';
	msg.style.left = leftposition + 'px';

	//$(msg).width(msgW);
	clearInterval( msg.timer );
	msg.timer = setInterval( "fadeMsg(1)", MSGTIMER );
	if ( !autohide )
	{
		autohide = MSGHIDE;
	}
	window.setTimeout( "hideMsg()", ( autohide * 1000 ) );
	
}

// 隐藏表单警报　//
function hideMsg( msg )
{
    var msg = document.getElementById( 'msg' );
    if ( !msg.timer )
    {
        msg.timer = setInterval( "fadeMsg(0)", MSGTIMER );
    }
}

// 面对这个消息框 / /
function fadeMsg( flag )
{
    if ( flag == null )
    {
        flag = 1;
    }
    var msg = document.getElementById( 'msg' );
    var value;
    if ( flag == 1 )
    {
        value = msg.alpha + MSGSPEED;
    } else
    {
        value = msg.alpha - MSGSPEED;
    }
    msg.alpha = value;
    msg.style.opacity = ( value / 100 );
    msg.style.filter = 'alpha(opacity=' + value + ')';
    if ( value >= 99 )
    {
        clearInterval( msg.timer );
        msg.timer = null;
    } else if ( value <= 1 )
    {
        msg.style.display = "none";
        clearInterval( msg.timer );
    }
}

// 计算元素的位置相对于浏览器的左边 //
function leftPosition( target )
{
    var left = 0;
    if ( target.offsetParent )
    {
        while ( 1 )
        {
            left += target.offsetLeft;
            //left = target.offsetLeft;
            if ( !target.offsetParent )
            {
                break;
            }
            target = target.offsetParent;
        }
    } else if ( target.x )
    {
        left += target.x;
    }
    return left;
}

// 计算元素的位置相对于浏览器窗口的顶部//
function topPosition( target )
{
    var top = 0;
    if ( target.offsetParent )
    {
        while ( 1 )
        {
            //top += target.offsetTop;
            top += target.offsetTop;
            if ( !target.offsetParent )
            {
                break;
            }
            target = target.offsetParent;
        }
    } else if ( target.y )
    {
        top += target.y;
    }
    return top;
}

// 预加载的箭头 //
if ( document.images )
{
    arrow = new Image( 31, 7 );
    arrow.src = "/assets/img/msg_arrow.gif";
}