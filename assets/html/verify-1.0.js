var _vIter = 
{
	"mail" : 
	{
	    "pattern": /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i,
	    "message": "不是合法的邮箱，请重新填写!"
	},
	"url" : 
	{
	    "pattern": /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i,
	    "message": "不是合法的网址，请重新填写!"
	},
	'date':
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

function _VerifyRequired(srcObj, cnName)
{
	if (srcObj.val() == null || 
	srcObj.val().length == 0)
	{
		alert(cnName + "不能为空，请重新填写！");
		srcObj.focus();
		
		return false;
	}
	
	return true; 
}

function _VerifyMaxlength( srcObj, cnName, nSize )
{
	if (srcObj.val().length > nSize )
	{
		alert( cnName + '超过了限定字符，请重新填写！' );
		
		return false;
	}
	
	return true;
}

function _VerifyMaxRegExp( v, valueObj, srcObj, cnName )
{
	for (var _key in _vIter)
	{
		if (_key == v)
		{
			var reg = _vIter[_key].pattern;
			if ( !srcObj.val().match( reg ) )
			{
				alert( cnName + _vIter[_key].message );
				return false;
			}
		}
	}
	
	return true;
}

//执行表单验证操作
function _VerifyForm(srcObj)
{
	var _result = true;

	var _parent = srcObj.closest('.FormTable');
	if (_parent.length > 0)
	{
		_parent.find("[verify]").each(function(index)
		{
			var _obj = $(this);
			var _verifyStr = _obj.attr("verify");
			if (_verifyStr)
			{
				_verifyStr = unescape(_verifyStr);

				var _verify = StrToJson(_verifyStr);
				for (var _v in _verify)
				{
					if (_v == "required" && _verify[_v])
					{
						_result = _VerifyRequired( _obj, _verify["displayname"] ? _verify["displayname"] : _verify["codename"]);
					}
					else if (_v == "maxlength" && _verify[_v])
					{
					    _result = _VerifyMaxlength( _obj, _verify["displayname"] ? _verify["displayname"] : _verify["codename"], _verify["characterlength"] );
					}
					else
					{
						//此处改用正则表达式，写成通用函数
					    //正则表达式在JSON中统一定义
					    _result = _VerifyMaxRegExp( _v, _verify, _obj, _verify["displayname"] ? _verify["displayname"] : _verify["codename"] );
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
	}

	return _result;
}

//将配置应用到表单上
function _ConfigVerify(options)
{
	if (options.codename)
	{
		var _srcObj = $('[name="' + options.codename + '"]');
		if (_srcObj.length > 0)
		{
			var _verify = {};
			for (var _key in options)
			{
				if (_key.substr(0, 4) == "vfy_")
				{
					if (!_verify.displayname)
					{
						_verify.displayname = options.displayname;
						_verify.codename = options.codename;
						_verify.characterlength = options.characterlength;
					}
					_key = _key.replace( "vfy_", "" );

					eval('_verify.' + _key + ' = true;');
				}
			}
			
			var _verifyStr = JsonToStr(_verify);
			_verifyStr = escape(_verifyStr);
			
			_srcObj.attr( "verify", _verifyStr );
			
			_verifyStr = '';
		}
	}

	return;
}