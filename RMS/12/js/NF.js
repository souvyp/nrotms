/*NF.min.js*/
// string 扩展   180行﻿
String.prototype.ExtFileName = function() {
	if(this != "") {
		return "." + this.replace(/.+\./, "");
	} else {
		return "";
	}
};
String.prototype.FullFileName = function() {
	if(this != null) {
		var _filename = this.replace(/^.*[\\\/]/, '')
		return _filename;
	} else {
		return "";
	}
};
String.prototype.FileName = function() {
	if(this != null) {
		var _filename = this.replace(/^.*[\\\/]/, '')
		var name = _filename.split(".");
		return name[0];
	} else {
		return "";
	}
};
String.prototype.ReplaceAll = function(sSrc, sDst) {
	return this.replace(new RegExp(sSrc, "gm"), sDst);
};
String.prototype.GetAnchorName = function(bDecode) {
	if(bDecode == null || bDecode == undefined || bDecode) {
		return unescape(this.substr(this.indexOf("#") + 1));
	} else {
		return this.substr(this.indexOf("#") + 1);
	}
};
String.prototype.QueryStrings = function(bDecode) {
	var aVars = [],
		sHash, sValue;
	var aHashes = this.slice(this.indexOf('?') + 1).split('&');
	for(var i = 0; i < aHashes.length; i++) {
		sHash = aHashes[i].split('=');
		if(sHash.length > 1) {
			aVars.push(sHash[0]);
			sValue = sHash[1];
			if(sValue.indexOf('#') != -1) {
				sValue = sValue.substr(0, sValue.indexOf('#'));
			}
			if(bDecode == null || bDecode == undefined || bDecode) {
				aVars[sHash[0]] = unescape(sValue);
			} else {
				aVars[sHash[0]] = sValue;
			}
		}
	}
	return aVars;
};
String.prototype.QueryString = function(sName, bDecode) {
	return this.QueryStrings(bDecode)[sName];
};
String.prototype.FormatNumber = function() {
	try {
		return accounting.formatNumber(parseFloat(this), 2);
	} catch(e) {
		return this;
	}
};
String.prototype.Eval = function() {
	try {
		var _func = this.toString();
		return eval(_func);
	} catch(e) {
		if(console) {
			console.log('Eval exception: \n' + e);
		} else {
			alert('Eval exception: \n' + e);
		}
	}
	return false;
};
String.prototype.ASCII = function() {
	return this.charCodeAt(0);
};
String.prototype.FromASCII = function(charcode) {
	return String.fromCharCode(charcode);
};
String.prototype.Reverse = function() {
	return this.split("").reverse().join("");
};
String.prototype.Left = function(n) {
	return this.slice(0, n);
};
String.prototype.Right = function(n) {
	return this.slice(this.length - n);
};
String.prototype.ByteLen = function() {
	return this.replace(/[^x00-xff]/g, "--").length;
};
String.prototype.Replace = function(oldStr, newStr) {
	return this.replace(oldStr, newStr);
};
String.prototype.LTrim = function() {
	return this.replace(/^\s+/, "");
};
String.prototype.RTrim = function() {
	return this.replace(/\s+$/g, "");
};
String.prototype.ToDBC = function(sourcestr) {
	var endvalue = '';
	for(var charati = 0; charati < sourcestr.length; charati++) {
		endvalue += String.fromCharCode(sourcestr.charCodeAt(charati) + 65248);
	}
	return endvalue;
};
String.prototype.RepeatTimes = function(str) {
	return this.split(str).length - 1;
};
String.prototype.ExistsDBC = function() {
	var value = this.match(/[^\x00-\xff]/ig);
	if(value != null) {
		return true;
	} else {
		return false;
	}
};
String.prototype.XMLEncode = function(str) {
	str = $.trim(str);
	str = str.replace("&", "&amp;");
	str = str.replace("<", "&lt;");
	str = str.replace(">", "&gt;");
	str = str.replace("'", "&apos;");
	str = str.replace("\"", "&quot;");
	return str;
};
String.prototype.IsInt = function(intValue) {
	var reg = /^[-|+]?[1-9]*$/;
	return reg.test(intValue);
};
String.prototype.IsDate = function() {
	var reg = /^[\d]{4}([-|/])([0]?[1-9]|[1][0-2])([-|/])([0]?[1-9]|[1-2]\d|[3][0-1])$/;
	return reg.test(this);
};
String.prototype.IsIP = function() {
	var reg = /^(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)$/;
	return reg.test(this);
};
String.prototype.IsNumeric = function(num) {
	var reg = /^([+-]?)\d*\.?\d+$/;
	return reg.test(num);
};
String.prototype.IsTime = function() {
	var reg = /^([0-1]\d|2[0-3]):[0-5]\d:[0-5]\d$/;
	return reg.test(this);
};
String.prototype.IsDateTime = function() {
	var reg = /^[\d]{4}([-|/])([0]?[1-9]|[1][0-2])([-|/])([0]?[1-9]|[1-2]\d|[3][0-1])\s([0-1]\d|2[0-3]):[0-5]\d:[0-5]\d$/;
	return reg.test(this);
};
String.prototype.ToFloat = function() {
	var _float = 0;
	try {
		_float = parseFloat(this);
	} catch(e) {
		_float = 0;
	}
	if(isNaN(_float)) {
		_float = 0;
	}
	return _float;
};
String.prototype.ToInt = function() {
	var _int = 0;
	try {
		_int = parseInt(this);
	} catch(e) {
		_int = 0;
	}
	if(isNaN(_int)) {
		_int = 0;
	}
	return _int;
};
//math 扩展    237行
Math.Random = function(min, max) {
	var _min = 0;
	var _max = 0;
	try {
		_min = parseFloat(min);
		_max = parseFloat(max);
	} catch(e) {
		_min = 0;
		_max = 0;
	}
	if(isNaN(_min) || isNaN(_max)) {
		_min = 0;
		_max = 0;
	}
	return parseInt(Math.random() * (_max - _min + 1) + _min);
};
Math.Max = function(array) {
	var i = array[0];
	for(var n = 0; n < array.length; n++) {
		try {
			array[n] = parseFloat(array[n]);
			i = parseFloat(i);
			if(array[n] > i) {
				i = array[n];
			}
		} catch(e) {
			array[n] = 0;
			i = 0;
		}
		if(isNaN(array[n]) || isNaN(i)) {
			i = 0;
		}
	}
	return i;
};
Math.Min = function(array) {
	var i = array[0];
	for(var n = 0; n < array.length; n++) {
		try {
			array[n] = parseFloat(array[n]);
			i = parseFloat(i);
			if(array[n] < i) {
				i = array[n];
			}
		} catch(e) {
			array[n] = 0;
			i = 0;
		}
		if(isNaN(array[n]) || isNaN(i)) {
			i = 0;
		}
	}
	return i;
};
//同上   374
Date.prototype.DateAdd = function(strInterval, NumDay, dtDate) {
	var _numDay = parseInt(NumDay);
	var _date;
	if(dtDate != null) {
		var tmpdate, tmptime;
		tmpdate = dtDate.split(" ")[0];
		tmptime = dtDate.split(" ")[1];
		if(tmptime != null) {
			var dtTmp = new Date(dtDate.replace(/-/g, "/"));
		} else {
			var dtTmp = new Date(dtDate.replace(/-/g, "/"));
		}
	} else {
		dtTmp = new Date();
	}
	if(isNaN(dtTmp)) {
		dtTmp = new Date();
	}
	switch(strInterval) {
		case "s":
			_date = new Date(Date.parse(dtTmp) + (1000 * _numDay));
			return _date;
		case "n":
			_date = new Date(Date.parse(dtTmp) + (60000 * _numDay));
			return _date;
		case "h":
			_date = new Date(Date.parse(dtTmp) + (3600000 * _numDay));
			return _date;
		case "d":
			_date = new Date(Date.parse(dtTmp) + (86400000 * _numDay));
			return _date;
		case "w":
			_date = new Date(Date.parse(dtTmp) + ((86400000 * 7) * _numDay));
			return _date;
		case "m":
			_date = new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + _numDay, dtTmp.getDate());
			return _date;
		case "y":
			_date = new Date((dtTmp.getFullYear() + _numDay), dtTmp.getMonth(), dtTmp.getDate());
			return _date;
	}
};
Date.prototype.DaySpan = function(startDate, endDate) {
	var d1 = new Date(startDate.replace(/-/g, "/"));
	var d2 = new Date(endDate.replace(/-/g, "/"));
	var time = d2.getTime() - d1.getTime();
	return parseInt(time / (1000 * 60 * 60 * 24));
};
Date.prototype.GetTime = function(str) {
	var _date;
	if(str != "") {
		_date = new Date(str);
	} else {
		_date = new Date();
	}
	var _str = _date.toTimeString();
	var _time = _str.split(" ")[0];
	return _time;
};
Date.prototype.GetDate = function(str) {
	var _date;
	if(str != "") {
		_date = new Date(str);
	} else {
		_date = new Date();
	}
	var _str = _date.toLocaleDateString();
	var _dateStr = _date.ToString(_str);
	return _dateStr;
};
Date.prototype.IsWeekend = function(year) {
	var weektype = 2;
	var currentdate;
	if(year != null) {
		if(year.indexOf("/") != -1) {
			currentdate = new Date(year.split("/")[0], year.split("/")[1] - 1, year.split("/")[2]);
		} else {
			currentdate = new Date(year.split("-")[0], year.split("-")[1] - 1, year.split("-")[2]);
		}
		if(parseInt(currentdate.getDay()) == 0) {
			return(true);
		} else {
			if(parseInt(currentdate.getDay()) == 6) {
				return true;
			}
		}
	}
	return false;
};
Date.prototype.TimeSpan = function(startDateTime, endDateTime) {
	var regTime = /(\d{4})-(\d{1,2})-(\d{1,2})( \d{1,2}:\d{1,2})/g;
	var interval = Math.abs(Date.parse(startDateTime.replace(regTime, "$2-$3-$1$4")) - Date.parse(endDateTime.replace(regTime, "$2-$3-$1$4"))) / 1000;
	var h = Math.floor(interval / 3600);
	var m = Math.floor(interval % 3600 / 60);
	return h + "小时" + m + "分钟";
};
Date.prototype.IsLead = function(year) {
	var leadyear;
	if(year % 4 == 0 && year % 100 != 0) {
		return true;
	} else if(year % 400 == 0) {
		return true;
	} else {
		return false;
	}
};
Date.prototype.AddDaies = function(date, days) {
	var date = new Date(Date.parse(date.replace(/\-/g, '/')));
	var interTimes = days * 24 * 60 * 60 * 1000;
	var _date = new Date(Date.parse(date) + interTimes);
	return _date;
};
Date.prototype.AddSeconds = function(date, seconds) {
	var date = new Date(Date.parse(date.replace(/\-/g, '/')));
	var interTimes = seconds * 1000;
	var _date = new Date(Date.parse(date) + interTimes);
	return _date;
};
Date.prototype.AddMSeconds = function(date, mseconds) {
	var date = new Date(Date.parse(date.replace(/\-/g, '/')));
	var interTimes = parseInt(mseconds);
	var _date = new Date(Date.parse(date) + interTimes);
	return _date;
};
Date.prototype.ToString = function(str) {
		var _date;
		if(str != null) {
			var arr = str.split(/年|月|日|:/);
			_date = arr[0] + "-" + arr[1] + "-" + arr[2];
		}
		if(_date.IsDate()) {
			return _date;
		} else {
			return "";
		}
	}
	// 同上   483
Array.prototype.IndexOf = function(index) {
	for(var i = 0; i < this.length; i++) {
		if(parseInt(this[i]) === index) {
			return i;
		}
	}
	return -1;
};
Array.prototype.LastIndexOf = function(index) {
	var l = this.length;
	for(var i = l - 1; i >= 0; i--) {
		if(parseInt(this[i]) === index) {
			return i;
		}
	}
	return -1;
};
Array.prototype.RemoveAt = function(dx) {
	this.splice(dx, 1);
	return this;
};
Array.prototype.InsertAt = function(index, obj) {
	this.splice(index, 0, obj);
	return this;
};
Array.prototype.RemoveItem = function(obj) {
	var index = this.IndexOf(obj);
	var result = null;
	if(index >= 0) {
		result = this.RemoveAt(index);
	}
	return result;
};
Array.prototype.RemoveRepeat = function(m) {
	var k = 0,
		j = 0,
		n = 0;
	var array = new Array();
	for(var i = 0; i < m; i++) {
		for(j = i + 1; j < m; j++) {
			if(this[i] == this[j]) {
				this[i] = null;
			}
		}
	}
	for(var i = 0; i < m; i++) {
		if(this[i]) {
			array[k++] = this[i];
		}
	}
	return array;
};
Array.prototype.RemoveLeft = function(num) {
	this.splice(0, num);
	return this;
};
Array.prototype.RemoveRight = function(num) {
	this.splice(this.length - num, num);
	return this;
};
Array.prototype.Left = function(len) {
	return this.slice(0, len);
};
Array.prototype.Right = function(len) {
	if(len >= this.length) {
		return this.concat();
	}
	return this.slice(this.length - len, this.length);
};
Array.prototype.Mid = function(start, len) {
	return this.slice(start, start + len);
};
Array.prototype.RandomItem = function() {
	var lownum = 1;
	var upnum = this.length;
	var t = parseInt(upnum - lownum + 1) * Math.random() + lownum;
	return this[parseInt(t) - 1];
};
Array.prototype.RandomSort = function() {
	return this.sort(function() {
		return Math.random() * new Date % 3 - 1;
	});
};
Array.prototype.RandomItems = function(lownum, upnum, count) {
	if(count > (upnum - lownum + 1)) {
		count = upnum - lownum + 1;
	}
	var res = new Array();
	for(var i = 0; i < count; i++) {
		var t = parseInt(upnum - lownum + 1) * Math.random() + lownum;
		if(numberindexOf(res, this[parseInt(t)]) != -1) {
			i--;
		} else {
			res.push(this[parseInt(t)]);
		}
	}
	return res;

	function numberindexOf(source, findnum) {
		var l = source.length;
		for(var i = 0; i < l; i++) {
			if(source[i] === findnum) {
				return i
			}
		}
		return -1;
	}
};

jQuery.fn.outerHTML = function() {
	return jQuery("<p>").append(this.eq(0).clone()).html();
};
$.fn.serializeObject = function() {
	var _out = {};
	var _in = this.serializeArray();
	$.each(_in, function() {
		if(_out[this.name] !== undefined) {
			if(!_out[this.name].push) {
				_out[this.name] = [_out[this.name]];
			}
			_out[this.name].push(this.value || '');
		} else {
			_out[this.name] = this.value || '';
		}
	});
	return _out;
};
jQuery.fn.shake = function(intShakes, intDistance, intDuration, foreColor) {
	this.each(function() {
		if(foreColor && foreColor != "null") {
			$(this).css("color", foreColor);
		}
		$(this).css("position", "relative");
		for(var x = 1; x <= intShakes; x++) {
			$(this).animate({
				left: (intDistance * -1)
			}, (((intDuration / intShakes) / 4)));
			$(this).animate({
				left: intDistance
			}, ((intDuration / intShakes) / 2));
			$(this).animate({
				left: 0
			}, (((intDuration / intShakes) / 4)));
			$(this).css("color", "");
		}
	});
	return this;
};
$.extend({});
// 以上都可以说成是 可有可无
//
window.NF = function() {};
NF.Name = "NF Javascript Framework";
NF.Author = "Guo HongLiang";
NF.Version = "0.1.4";
NF.PublishDate = "2014-9-1";
NF.UrlVars = function() {
	this.Name = "NF.UrlVars";
	this.Author = "Guo HongLiang";
	this.Version = "0.1.4";
	this.PublishDate = "2014-10-14";

	function constructor() {} {
		constructor();
	}
};
NF.UrlVars.Exists = function(sName, url) {
	var _url;
	if(url != "" && url != null) {
		_url = url;
	} else {
		_url = window.location.href;
	}
	if(-1 == _url.indexOf("?" + sName + "=") &&
		-1 == _url.indexOf("&" + sName + "=")) {
		return false;
	} else {
		return true;
	}
};
NF.UrlVars.Get = function(sName, url) {
	if(NF.UrlVars.Exists(sName, url)) {
		return NF.UrlVars.List(url)[sName];
	} else {
		return "";
	}
};
NF.UrlVars.Set = function(sName, sValue, sUrl) {
	var _url = '';
	if(sUrl && sUrl != "") {
		_url = sUrl;
	} else {
		_url = window.location.href;
	}
	if(NF.UrlVars.Exists(sName, _url)) {
		var _re = eval('/([&|?]' + sName + '=)([^&]*)/gi');
		if(_url.indexOf("&" + sName + "=") == -1) {
			return _url.replace(_re, "?" + sName + '=' + sValue);
		} else {
			return _url.replace(_re, "&" + sName + '=' + sValue);
		}
	} else {
		if(_url.indexOf("?") != -1) {
			return _url + "&" + sName + '=' + sValue;
		} else {
			return _url + "?" + sName + '=' + sValue;
		}
	}
};
NF.UrlVars.List = function(url) {
	if(url != "" && url != null) {
		return url.QueryStrings();
	} else {
		return window.location.href.QueryStrings();
	}
};
NF.UrlVars.Json = function(url) {
	var _vars = NF.UrlVars.List(url);
	var _json = {};
	for(var i = 0; i < _vars.length; i++) {
		var _name = _vars[i];
		if(_name) {
			_json[_name.toLowerCase()] = _vars[_name];
		}
	}
	return _json;
};
NF.UrlVars.Remove = function(sName, sUrl) {
	var _url = '';
	var _array;
	if(sUrl && sUrl != "") {
		_url = sUrl;
	} else {
		_url = window.location.href;
	}
	if(NF.UrlVars.Exists(sName, _url)) {
		var _value = NF.UrlVars.Get(sName, _url);
		if(_url.indexOf("?" + sName) != -1) {
			if(_url.indexOf("?" + sName + '=' + _value + "&") != -1) {
				return _url.replace("?" + sName + '=' + _value + "&", "?");
			} else {
				return _url.replace("?" + sName + '=' + _value, "");
			}
		} else if(_url.indexOf("&" + sName) != -1) {
			return _url.replace("&" + sName + '=' + _value, "");
		}
	} else {
		if(_url.indexOf('?') != -1) {
			_array = _url.split('?');
			return _url.replace('?' + _array[1], "");
		}
	}
};
NF.Envoriment = function() {
	this.Name = "NF.Envoriment";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.1";
	this.PublishDate = "2015-8-18";

	function constructor() {} {
		constructor();
	}
};
NF.Envoriment.Html5 = function() {
	if(window.applicationCache) {
		return true;
	} else {
		return false;
	}
};
NF.Config = function() {
	this.Name = "NF.Config";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.1";
	this.PublishDate = "2014-9-30";

	function constructor() {} {
		constructor();
	}
};
NF.Config.Mode = 'ZM';
NF.Config.Debug = false;

/*NF.System.min.js*/
﻿
NF.System = function() {
	this.Name = "NF.System";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.1";
	this.PublishDate = "2014-9-1";

	function constructor() {} {
		constructor();
	}
};
NF.System.Json = function() {
	this.Name = "NF.System.Json";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.1";
	this.PublishDate = "2014-10-14";

	function constructor() {} {
		constructor();
	}
};
NF.System.Json.ToString = function(obj) {
	if(JSON) {
		try {
			return JSON.stringify(obj);
		} catch(e) {
			return JsonToString(obj);
		}
	} else {
		return JsonToString(obj);
	}

	function JsonToString(obj) {
		var THIS = this;
		switch(typeof(obj)) {
			case 'string':
				return '"' + obj.replace(/(["\\])/g, '\\$1') + '"';
			case 'array':
				return '[' + obj.map(THIS.JsonToString).join(',') + ']';
			case 'object':
				if(obj instanceof Array) {
					var strArr = [];
					var len = obj.length;
					for(var i = 0; i < len; i++) {
						strArr.push(THIS.JsonToString(obj[i]));
					}
					return '[' + strArr.join(',') + ']';
				} else if(obj == null) {
					return 'null';
				} else {
					var string = [];
					for(var property in obj) {
						string.push(THIS.JsonToString(property) + ':' + THIS.JsonToString(obj[property]));
					}
					return '{' + string.join(',') + '}';
				}
			case 'number':
				return obj;
			case false:
				return obj;
		}
	}
};
NF.System.Json.ToJson = function(str) {
	if(JSON) {
		try {
			return JSON.parse(str);
		} catch(e) {
			return eval('(' + str + ')');
		}
	} else {
		return eval('(' + str + ')');
	}
};
NF.System.LoadScript = function(id, code) {
	var oHead, oScript, result = false;
	if(code != "" && code != null) {
		try {
			oHead = document.getElementsByTagName("HEAD").item(0);
		} catch(e) {
			oHead = null;
		}
		if(oHead) {
			try {
				oScript = document.createElement("script");
			} catch(e) {
				oScript = null;
			}
			if(oScript) {
				try {
					oScript.id = id;
					oScript.type = "text/javascript";
					oScript.defer = true;
					oScript.text = code;
					oHead.appendChild(oScript);
					result = true;
				} catch(e) {}
			}
		}
	}
	return result;
};
NF.System.FunctionExist = function(str) {
	try {
		if(typeof(eval(str)) == "function") {
			return true;
		}
	} catch(e) {
		return false;
	}
};
NF.System.IsNull = function(val) {
	try {
		if(typeof(val) == "undefined") {
			return true;
		} else if(val == null) {
			return true;
		}
		return false;
	} catch(e) {
		return true;
	}
};
NF.System.uuid = function() {
	var s = [];
	var hexDigits = "0123456789abcdef";
	for(var i = 0; i < 36; i++) {
		s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
	}
	s[14] = "4";
	s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);
	s[8] = s[13] = s[18] = s[23] = "-";
	var uuid = s.join("");
	return uuid;
};
NF.System.ThrowInfo = function(sInfo) {
	var _debug = NF.Config.Debug;
	if(_debug) {
		try {
			if(console) {
				console.log(sInfo);
			} else {
				alert(sInfo);
			}
		} catch(e) {
			alert('error code: ' + e.number + '\ndescription: ' + e.description);
		}
	}
	return;
};
NF.System.Definition = function() {
	this.Name = "NF.System.Definition";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.1";
	this.PublishDate = "2014-9-30";

	function constructor() {} {
		constructor();
	}
};
NF.System.Definition.Interface = function(key) {
	var _value = '';
	if(key == 'SystemData') {
		if(NF.Config.Mode == 'JDT') {
			_value = 'portal.cn';
		} else {
			_value = 'portal.aspx';
		}
	}
	return _value;
};
NF.System.Definition.Envoriment = {
	MaxRows: 65536,
	DataIsland: 'view-id',
	DataField: 'view-fld',
	DataStat: 'view-stat',
	DataSubStat: 'view-subStat'
};
NF.System.Definition.KeyCode = {
	BackSpace: 8,
	Delete: 46,
	Home: 36,
	End: 35,
	PageUp: 33,
	PageDown: 34,
	UpArrow: 38,
	DownArrow: 40,
	RightArrow: 39,
	LeftArrow: 37
};

/*NF.System.Network.min.js*/
﻿
NF.System.Network = function() {
	this.Name = "NF.System.Network";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.1";
	this.PublishDate = "2014-9-1";

	function constructor() {} {
		constructor();
	}
};
NF.System.Network.Ajax = function(url, params, type, cross, callback) {
	if(!type) {
		type = "GET";
	}
	if(type != "GET" && type != "POST") {
		type = "GET";
	}
	$.ajax({
		async: false,
		url: url,
		dataType: (cross ? "jsonp" : "json"),
		jsonp: (cross ? 'callback' : ''),
		type: type,
		data: params,
		error: function(reqObj, status, err) {
			if(callback) {
				callback(false, '{ "status" : "' + status + '", "err" : "' + err + '" } ');
			} else {
				NF.System.ThrowInfo('status: ' + status + '\nerr: ' + err);
			}
		},
		success: function(data) {
			if(callback) {
				callback(true, data);
			} else {
				NF.System.ThrowInfo(data);
			}
		}
	});
};

/*NF.System.Data.min.js*/
﻿
NF.System.Data = function() {
	this.Name = "NF.System.Data";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.1";
	this.PublishDate = "2014-9-1";

	function constructor() {} {
		constructor();
	}
};
NF.System.Data.ReplaceJsonData = function(str, json) {
	for(var key in json) {
		str = str.ReplaceAll('@' + key.toLowerCase() + '@', json[key]);
	}
	return str;
};
NF.System.Data.GetDataParams = function(config) {
	var _pml = [{}];
	_pml[0].namespace = 'protocol';
	_pml[0].cmd = 'data';
	_pml[0].version = 1;
	if(config.id) {
		_pml[0].id = config.id;
	}
	var para = [];
	var pObj = {};
	_pml[0].paras = config.paras;
	if(config.page) {
		var _pageJson = {};
		_pageJson.name = "page";
		_pageJson.value = config.page;
		_pml[0].paras.push(_pageJson);
	}
	if(config.rows) {
		var _rowsJson = {};
		_rowsJson.name = "rows";
		_rowsJson.value = config.rows;
		_pml[0].paras.push(_rowsJson);
	}
	return _pml;
};
NF.System.Data.GetDefineParams = function(config) {
	var _pml = [{}];
	_pml[0].namespace = 'protocol';
	_pml[0].cmd = 'define';
	_pml[0].version = 1;
	if(config.id) {
		_pml[0].id = config.id;
	}
	return _pml;
};
NF.System.Data.RecordSet = function(sUrl, config, callback) {
	var jsonParams = NF.System.Data.GetDataParams(config);
	var _cross = config.cross;
	if(_cross == 'false') {
		_cross = false;
	} else {
		_cross = true;
	}
	var _jsonParams = NF.System.Json.ToString(jsonParams);
	sUrl += NF.System.Definition.Interface('SystemData');
	NF.System.Network.Ajax(sUrl, _jsonParams, 'POST', _cross, function(successed, data) {
		var _err = "";
		if(successed && data[0]) {
			if(data[0].result) {
				if(callback) {
					if(data[0].rs) {
						callback(data[0].result, config, data[0].rs);
					} else {
						if(data.msg) {
							_err = data.msg;
						} else {
							_err = "server error!";
						}
					}
				} else {
					NF.System.ThrowInfo("NF.System.Data.Rows, result: ");
					NF.System.ThrowInfo(data.rows);
				}
			} else {
				if(data.err) {
					_err = data.err;
				} else {
					_err = "unknown error!";
				}
			}
		} else {
			if(data && data.err) {
				_err = data.err;
			} else {
				_err = "unknown error!";
			}
		}
		if(_err != "") {
			if(callback) {
				callback(false, config, {
					err: _err
				});
			} else {
				NF.System.ThrowInfo("NF.System.Data.Rows, err: \n" + _err);
			}
		}
	});
};
NF.System.Data.Definition = function(sUrl, config, callback) {
	var jsonParams = NF.System.Data.GetDefineParams(config);
	var _cross = config.cross;
	if(_cross == 'false') {
		_cross = false;
	} else {
		_cross = true;
	}
	sUrl += NF.System.Definition.Interface('SystemData');
	jsonParams = NF.System.Json.ToString(jsonParams);
	NF.System.Network.Ajax(sUrl, jsonParams, 'POST', _cross, function(successed, data) {
		var _err = "";
		if(successed && data[0]) {
			if(data[0].result) {
				if(callback) {
					if(data[0].columns) {
						callback(data[0].result, config, data[0].columns);
					} else {
						if(data.msg) {
							_err = data.msg;
						} else {
							_err = "server error!";
						}
					}
				} else {
					NF.System.ThrowInfo("NF.System.Data.Columns, result: ");
					NF.System.ThrowInfo(data.fields);
				}
			} else {
				if(data.err) {
					_err = data.err;
				} else {
					_err = "unknown error!";
				}
			}
		} else {
			if(data && data.err) {
				_err = data.err;
			} else {
				_err = "unknown error!";
			}
		}
		if(_err != "") {
			if(callback) {
				callback(false, config, {
					err: _err
				});
			} else {
				NF.System.ThrowInfo("NF.System.Data.Columns, err: \n" + _err);
			}
		}
	});
};
NF.System.Data.Grid = function() {
	var __name = null;
	var __sender = null;
	var __rowscount = 0;
	var __pagesize = 0;
	var __pagination = null;
	var __print = null;
	var __pageBuilder = null;
	var __rowsBuilder = null;
	this.Name = "NF.System.Data.Grid";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.2";
	this.PublishDate = "2014-10-9";

	function SubStat(container, sender, rows, i) {
		var _doSubitem = false;
		var _row = rows[i];
		var _rowNext = null;
		var _rowLast = null;
		if(rows.length > (i + 1)) {
			_rowNext = rows[i + 1];
			_rowLast = rows[i - 1];
		}
		var _rowCount = _rowCount;
		sender.find("[" + NF.System.Definition.Envoriment.DataSubStat + "]").each(function(index) {
			var swSubStat = NF.System.Json.ToJson($(this).attr('"' + NF.System.Definition.Envoriment.DataSubStat + '"'));
			var field = new NF.System.Data.FieldProcessor();
			_doSubitem = field.SubStat($(this), _row, swSubStat, _rowNext, i, _rowCount);
		});
		if(_doSubitem) {
			var _html = $(sender.outerHTML());
			_html.find('[' + NF.System.Definition.Envoriment.DataField + ']').removeAttr(NF.System.Definition.Envoriment.DataField);
			_html.removeAttr("id");
			container.before(_html);
			sender.find('[' + NF.System.Definition.Envoriment.DataSubStat + ']').text('');
			_doSubitem = false;
			_rowNo += 1;
			_subStatNO += 1;
			if(__print) {
				__print.PrintPagination(__sender, _rowNo);
			}
		}
	}

	function Stat(sender, rows, i) {
		var _rowCount = rows.length;
		var _row = rows[i];
		var _rowNext = null;
		if(rows.length > (i + 1)) {
			_rowNext = rows[i + 1];
		}
		sender.find('[' + NF.System.Definition.Envoriment.DataStat + ']').each(function(index) {
			var swStat = NF.System.Json.ToJson($(this).attr('"' + NF.System.Definition.Envoriment.DataStat + '"'));
			var field = new NF.System.Data.FieldProcessor();
			field.Stat($(this), _row, swStat, _rowNext, i, _rowCount);
		});
	}
	this.RowsCbk = function(cbk) {
		if(cbk && typeof(cbk) == 'function') {
			__rowsBuilder = cbk;
		}
		return;
	};
	this.PageCbk = function(cbk) {
		if(cbk && typeof(cbk) == 'function') {
			__pageBuilder = cbk;
		}
		return;
	};
	this.RowsCount = function() {
		return __rowscount;
	};
	this.PageSize = function() {
		return __pagesize;
	};
	this.Pagination = function(sName, containerObj, eventHandler) {
		if(__pagination) {
			NF.System.ThrowInfo("NF.System.Data.Grid, The pagination object has been configured!");
			return;
		}
		__pagination = new NF.System.Data.Pagination(sName, containerObj, eventHandler);
		return;
	};
	this.Print = function(container, header, footer, height, rows) {
		if(__print) {
			NF.System.ThrowInfo("NF.System.Data.Grid, The pagination object has been configured!");
			return;
		}
		__print = new NF.System.Data.PrintArea(container, header, footer, height, rows);
		return;
	};
	this.Show = function(result, config, data) {

		if(result && __sender) {
			var _stat = $("#" + config.stat);
			var _subStat = $("#" + config.subStat);
			var _doSubitem = false;

			var _rowNo = 0; //当前行的序号[从1开始]
			var _subStatNo = 0;
			var _statNo = 0;

			var _totalRecs = 0;
			var datas = null;
			var data1 = null;

			if(__print) {
				__print.Initialize(config.page, data.count, data.total);
			}

			if(__pagination != null && data.length > 1) {
				datas = data[1].rows;
				data1 = data[0].rows;
				_totalRecs = data1[0].Total_RecsAmount;
				//get total records amount
			} else {
				if(data[0]) {
					datas = data[0].rows;
				} else {
					datas = [];
				}
			}

			for(var i = 0; i < datas.length; i++) {

				var html = _template(config.model, datas[i]);

				html = $(html).addClass(config.rowIdentClass); //添加标记便于删除

				if(i % 2 == 0) { //按奇数行、偶数行指定样式
					html = $(html).addClass(config.oddClass); //奇数行
				} else {
					html = $(html).addClass(config.evenClass); //偶数行
				}

				__sender.before(html); //添加行
				_rowNo += 1; //行计数+1

				if(__print) { //添加数据行后，处理分页打印
					__print.PrintPagination(__sender, _rowNo);
				}

				if(_subStat) { //小计
					SubStat(__sender, _subStat, datas, i);
				}

				if(_stat) { //总计
					Stat(_stat, datas, i);
				}
			}

			if(__print) { //设置总页数
				__print.SetPrintTotalPage(__sender, data.rows.length + _subStatNo);
			}

			//清理无用内容
			$('[' + NSF.System.Definition.Envoriment.DataStat + ']').removeAttr('[' + NSF.System.Definition.Envoriment.DataStat + ']');
			if(_subStat) {
				_subStat.remove();
			}

			if(config.ev) { //数据装载完成，执行load事件
				var __func = config.ev;
				if(datas && datas.length > 0) {
					__func = NSF.System.Data.ReplaceJsonData(__func, datas[0]);
				}

				__func.Eval();
			}

			__rowscount = _totalRecs; //分页处理.total.count
			var _paras = config.paras;
			var _page = 0;
			for(var k = 0; k < _paras.length; k++) {
				if((_paras[k].name).toLowerCase() == 'rows') {
					__pagesize = _paras[k].value;
				} else if((_paras[k].name).toLowerCase() == 'page') {
					_page = _paras[k].value;
				}
			}

			if(__pagesize < NSF.System.Definition.Envoriment.MaxRows && __rowscount > __pagesize) {
				if(__pagination) {
					if(__pagination.IsReady()) {
						__pagination.Show();
					} else {
						__pagination.Initialize(__pagesize, __rowscount, _page);
					}
				} else {
					NSF.System.ThrowInfo("NSF.System.Data.Grid, the  pagination object is invalid!");
				}
			}
		}
	};

	this.Initialize = function(sUrl, sName, config, sender, json) {
		__name = sName;
		__sender = sender;
		__sender.hide();
		if(json) {
			var _json = NF.System.Json.ToJson(json);
			if(!(NF.System.IsNull(_json.view_id))) {
				NF.System.Definition.Envoriment.DataIsland = _json.view_id;
			}
			if(!(NF.System.IsNull(_json.view_fld))) {
				NF.System.Definition.Envoriment.DataField = _json.view_fld;
			}
			if(!(NF.System.IsNull(_json.view_stat))) {
				NF.System.Definition.Envoriment.DataStat = _json.view_stat;
			}
			if(!(NF.System.IsNull(_json.view_subStat))) {
				NF.System.Definition.Envoriment.DataSubStat = _json.view_subStat;
			}
		}
		if(config) {
			config = NF.System.Json.ToJson(config);
			if(typeof(config.rowIdentClass) != "undefined" &&
				config.rowIdentClass != "") {
				$(document).find('.' + config.rowIdentClass).remove();
			}
			config.refObj = this;
			NF.System.Data.RecordSet(sUrl, config, this.Show);
		}
		return;
	};

	function constructor() {
		__name = "";
	} {
		constructor();
	}
};
NF.System.Data.Pagination = function(sName, container, eventHandler) {
	var __name = null;
	var __container = null;
	var __controller = null;
	var __current = 0;
	var __pagesize = null;
	var __total = null;
	var __pageamount = null;
	var __eventHandler = null;
	this.Name = "NF.System.Data.Pagination";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.1";
	this.PublishDate = "2014-10-8";

	function Point(refObj) {
		var _controler = $('<li class="omitted">...</li>');
		refObj.after(_controler);
		return _controler;
	}

	function Button(refObj, pageno) {
		if(pageno != 0) {
			var _html = '<li';
			if(__current == pageno) {
				_html += ' class="active"';
			}
			_html += '><a href="javascript:void(0)"></a></li>'
			var _controler = $(_html);
			_controler.find("a").attr("onclick", __eventHandler + "(" + pageno + ")");
			_controler.find("a").text(pageno);
			refObj.after(_controler);
			return _controler;
		} else {
			return null;
		}
	}

	function Next() {
		if(__current >= __pageamount) {
			return __pageamount;
		} else {
			return __current + 1;
		}
	}

	function Prev() {
		if(__current <= 1) {
			return 1;
		} else {
			return __current - 1;
		}
	}

	function Buttons(refObj) {
		if(__pageamount > 5) {
			var _prev = Prev();
			var _next = Next();
			var __ref = Button(refObj, 1);
			if(_prev > 1) {
				if(_prev - 1 != 1) {
					__ref = Point(__ref);
				}
				__ref = Button(__ref, _prev);
			}
			if(__current != 1 && __current != __pageamount) {
				__ref = Button(__ref, __current);
			}
			if(_next != __pageamount) {
				__ref = Button(__ref, _next);
				if(_next + 1 != __pageamount) {
					__ref = Point(__ref);
				}
			}
			Button(__ref, __pageamount);
			if(__pageamount != 1 &&
				__pageamount != _prev &&
				__pageamount != _next &&
				__pageamount != __current) {}
		} else {
			for(var i = __pageamount; i >= 1; i--) {
				Button(refObj, i);
			}
		}
		return;
	}
	this.Current = function(_t) {
		if(!$.isNumeric(_t)) {
			__current = 1;
		} else {
			try {
				__current = parseInt(_t, 10);
			} catch(e) {
				__current = 1;
			}
		}
		return __current;
	};
	this.Show = function() {
		if(__pageamount > 0) {
			var _prev = Prev();
			var _next = Next();
			__controller.find("li.prev a").eq(0).attr("onclick", __eventHandler + "(" + _prev + ")");
			__controller.find("li.next a").eq(0).attr("onclick", __eventHandler + "(" + _next + ")");
			if(__controller.find('.active').text() != '') {
				__controller.find("li").not('li.prev,li.next,li.showrec').each(function(index) {
					$(this).remove();
				});
			}
			Buttons(__controller.find("li.prev"));
			__controller.find("li.showrec span.pagesize").text(__pagesize);
			__controller.find("li.showrec span.recamount").text(__total);
		} else {
			this.Hidden();
		}
		return;
	};
	this.hidden = function() {
		if(__container) {
			__container.remove();
		}
		return;
	};
	this.IsReady = function() {
		if(__pagesize && __total && __pageamount) {
			return true;
		}
		return false;
	};
	this.Initialize = function(pagesize, total, page) {
		if(!pagesize) {
			__pagesize = 20;
		} else {
			__pagesize = pagesize;
		}
		if(!total) {
			__total = 0;
		} else {
			__total = total;
		}
		this.Current(page);
		__pageamount = __total / __pagesize;
		__pageamount = Math.ceil(__pageamount);
		if(__pageamount <= 0) {
			this.Hidden();
		} else if(__controller) {
			this.Show();
		}
		return;
	};

	function constructor() {
		__name = sName;
		__container = container;
		if(__container) {
			__controller = __container.find("ul.pagination");
		}
		if(eventHandler == null ||
			typeof(eventHandler) == "undefined") {
			__eventHandler = "PageControlBtn_Click";
		} else {
			__eventHandler = eventHandler;
		}
	} {
		constructor();
	}
};
NF.System.Data.Form = function() {
	var __name = null;
	var __sender = null;
	var __url = null;
	var __mode = 'insert';
	var __fields = null;
	this.Name = "NF.System.Data.Form";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.2";
	this.PublishDate = "2014-10-9";

	function DropList(srcObj, field, selected) {
		var _html = '<select name="' + field.fieldname.toLowerCase() + '" placeholder="' + field.displayname + '">';
		var _linklist = field.linklist;
		var _linkarr = new Array();
		_linkarr = _linklist.split("\r");
		for(var j = 0; j < _linkarr.length; j++) {
			var _id = new Array();
			_id = _linkarr[j].split("=");
			_html += '<option value="' + _id[0] + '"';
			if(selected && _id[0] == selected) {
				_html += ' selected';
			}
			_html += '>' + _id[1] + '</option>';
		}
		_html += '</select>';
		srcObj.html(_html);
		return;
	}

	function DataDropList(srcObj, config, field, selected) {
		NF.System.Data.Rows(__url, config, 'combo', function(succeed, jsonConfig, jsonData) {
			if(succeed) {
				var _html = '<select name="' + field.fieldname.toLowerCase() + '" placeholder="' + field.displayname + '">';
				if(jsonData) {
					for(var j = 0; j < jsonData.length; j++) {
						_html += '<option value ="' + jsonData[j].id + '"';
						if(selected && jsonData[j].id == selected) {
							_html += ' selected';
						}
						_html += '>' + jsonData[j].text + '</option>';
					}
				}
				_html += '</select>';
				srcObj.html(_html);
			}
		});
	}

	function FormObject(container, config, field, row) {
		var _html = '';
		var _fieldName = field.name.toLowerCase();
		if(field.fldkeys) {
			field.edittype = 15;
		}
		if(field.edittype == 1 ||
			field.edittype == 2 ||
			field.edittype == 6 ||
			field.edittype == 15 ||
			field.edittype == 16) {
			_html = '<input class="form-control"';
			if(field.edittype == 1) {
				_html += ' type="text"';
			} else if(field.edittype == 2) {
				_html += ' type="password"';
			} else if(field.edittype == 6 || field.edittype == 16) {
				_html += ' type="text" onfocus="$(this).calendar()" readonly';
				_html += 'style="background:url(img/datePicker.gif) no-repeat right;"';
				if(field.edittype == 6) {
					_html += ' maxlength="10"';
				} else if(field.edittype == 16) {
					_html += ' maxlength="5"';
				}
			} else if(field.edittype == 15) {
				_html += ' type="hidden"';
			}
			_html += ' name="' + _fieldName + '" placeholder="' + field.displayname + '"';
			if(row) {
				_html += ' value="' + row[_fieldName] + '"';
			}
			_html += '>';
		} else if(field.edittype == 3) {
			_html += '<textarea class="form-control" name="' + _fieldName + '" placeholder="' + field.displayname + '">';
			if(row) {
				_html += row[_fieldName];
			}
			_html += '</textarea>';
		} else if(field.edittype == 4) {
			if(row) {
				DropList(container, field, row[_fieldName]);
			} else {
				DropList(container, field, null);
			}
		} else if(field.edittype == 5) {
			if(row) {
				DataDropList(container, config, field, row[_fieldName]);
			} else {
				DataDropList(container, config, field, null);
			}
		} else if(field.edittype == 17) {
			_html = '<input type="file" name="' + _fieldName + '" />';
		} else {
			_html = field.name;
		}
		if(_html != '') {
			container.html(_html);
		}
		return;
	}
	this.Mode = function(mode) {
		__mode = mode.toLowerCase();
		if(__mode == 'insert' ||
			__mode == 'edit' ||
			__mode == 'query') {
			return __mode;
		} else {
			__mode = 'insert';
		}
		return __mode;
	};
	this.Show = function(config, fields, row) {
		if(__sender) {
			__sender.find('[' + NF.System.Definition.Envoriment.DataField + ']').each(function(index) {
				var swDef = $(this).attr(NF.System.Definition.Envoriment.DataField);
				var sw = NF.System.Json.ToJson(swDef);
				if(sw.method == 'form') {
					for(var i = 0; i < fields.length; i++) {
						var field = fields[i];
						var fieldname = field.name.toLowerCase();
						if(fieldname == sw.fld.toLowerCase()) {
							FormObject($(this), sw, field, row);
							if(sw.ev) {
								var __fun = sw.ev;
								var fieldvalue = field.displayname;
								if(__fun != null) {
									__fun += '("' + fieldname + '","' + fieldvalue + '")';
									__fun.eval();
								}
							}
							break;
						}
					}
				}
				if(sw.trClass) {
					$(this).addClass(sw.trClass);
				}
			});
			__sender.find('[' + NF.System.Definition.Envoriment.DataField + ']').removeAttr(NF.System.Definition.Envoriment.DataField);
		}
		if(config.ev) {
			var __func = config.ev;
			if(__func != "") {
				__func += '();';
				__func.Eval();
			}
		}
		return;
	}
	this.ColumnsReady = function(result, config, data) {
		var THIS = config.refObj;
		if(result && data) {
			__fields = data;
			if(__mode == 'insert') {
				THIS.Show(config, __fields, null);
			} else if(__mode == 'edit') {
				NF.System.Data.RecordSet(__url, config, THIS.RowsReady);
			} else if(__mode == 'query') {
				THIS.Show(config, __fields, null);
			}
		}
		return;
	};
	this.RowsReady = function(result, config, data) {
		var THIS = config.refObj;
		if(!__fields) {
			NF.System.ThrowInfo('NF.System.Data.Form.RowsReady, the columns definition is empty!');
			return;
		}
		if(result && data) {
			if(__mode == 'edit') {
				THIS.Show(config, __fields, data.rs);
			}
		}
		return;
	};
	this.Initialize = function(sUrl, sName, config, sender, json) {
		__name = sName;
		__sender = sender;
		__url = sUrl;
		if(json) {
			var _json = NF.System.Json.ToJson(json);
			if(!(NF.System.IsNull(_json.view_id))) {
				NF.System.Definition.Envoriment.DataIsland = _json.view_id;
			}
			if(!(NF.System.IsNull(_json.view_fld))) {
				NF.System.Definition.Envoriment.DataField = _json.view_fld;
			}
			if(!(NF.System.IsNull(_json.view_stat))) {
				NF.System.Definition.Envoriment.DataStat = _json.view_stat;
			}
			if(!(NF.System.IsNull(_json.view_subStat))) {
				NF.System.Definition.Envoriment.DataSubStat = _json.view_subStat;
			}
		}
		if(config) {
			config = NF.System.Json.ToJson(config);
			config.refObj = this;
			NF.System.Data.Definition(sUrl, config, this.ColumnsReady);
		}
		return;
	};

	function constructor() {
		__name = "";
	} {
		constructor();
	}
};
NF.System.Data.PrintArea = function(container, header, footer, height, pageRows) {
	var __container = null;
	var __total = null;
	var __controller = null;
	var __pageamount = null;
	var __current = 0;
	var __header = null;
	var __footer = null;
	var __pageRows = null;
	var __rowHeight = null;
	this.Name = "NF.System.Data.PrintArea";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.1";
	this.PublishDate = "2014-12-2";

	function ResetUrlVar(sName, sValue) {
		var _url = window.location.href;
		var _re = eval('/(' + sName + '=)([^&]*)/gi');
		return _url.replace(_re, sName + '=' + sValue);
	}

	function GetPaginationUrl(pageno) {
		var _url = location.href;
		if(_url.indexOf("?") > -1) {
			_url = ResetUrlVar("zmPage", pageno);
		} else {
			_url += "?zmPage=" + pageno;
		}
		return _url;
	}

	function GetNextPageno(current, pageamount) {
		if(current >= pageamount) {
			return pageamount;
		} else {
			return current + 1;
		}
	}

	function GetPrevPageno(current) {
		if(current <= 1) {
			return 1;
		} else {
			return current - 1;
		}
	}

	function BuildPaginationBtn(refObj, pageno, current) {
		if(pageno != 0) {
			var _html = '<li';
			if(current == pageno) {
				_html += ' class="active_li"';
			}
			_html += '><a href="#"></a></li>'
			var _controler = $(_html);
			_controler.find("a").attr("href", GetPaginationUrl(pageno));
			_controler.find("a").text(pageno);
			refObj.after(_controler);
			return _controler;
		} else {
			return null;
		}
	}

	function BuildPaginationPoints(refObj) {
		var _controler = $('<li class="omitted">...</li>');
		refObj.after(_controler);
		return _controler;
	}

	function BuildPaginationController(refObj, pageamount, current) {
		var _prev = GetPrevPageno(current);
		var _next = GetNextPageno(current, pageamount);
		var __ref = BuildPaginationBtn(refObj, 1, current);
		if(_prev > 1) {
			if(_prev - 1 != 1) {
				__ref = BuildPaginationPoints(__ref);
			}
			__ref = BuildPaginationBtn(__ref, _prev, current);
		}
		if(current != 1 && current != pageamount) {
			__ref = BuildPaginationBtn(__ref, current, current);
		}
		if(_next != pageamount) {
			__ref = BuildPaginationBtn(__ref, _next, current);
			if(_next + 1 != pageamount) {
				__ref = BuildPaginationPoints(__ref);
			}
		}
		BuildPaginationBtn(__ref, pageamount, current);
		return;
	}

	function ShowPageNo(container, pageNo, after, lastPage) {
		var _html = "<div style=\"width:" + setWidth() + "px;margin-top:" + __header + "px;\"></div><div style=\"width:" + setWidth() + "px; height:14px; text-align: center; font-size:14px;\">第 <span class=\"pageNo_Current\">" + pageNo + "</span> 页 共 <span class=\"pageNo_Total\"></span> 页</div>";
		if(after) {
			container.after(_html);
		} else {
			container.before(_html);
		}
		return;
	}

	function ShowPageBreak(container) {
		container.before("<div style=\"page-break-after: always;\"></div>");
		return;
	}

	function getPageAmount(lastRowNo) {
		var _total = 0;
		if(lastRowNo % __pageRows == 0) {
			_total = lastRowNo / __pageRows;
			if(__footer > 0) {
				return _total + 1;
			} else {
				return _total;
			}
		} else {
			_total = Math.ceil(lastRowNo / __pageRows);
			if((_total * __pageRows * __rowHeight - lastRowNo * __rowHeight) < __footer) {
				_total += 1;
			}
			return _total;
		}
	}
	this.ShowPagination = function(current, pagesize, total) {
		var _container = $("ul.pagination");
		if(_container) {
			current = parseInt(current, 10);
			var _pageamount = total / pagesize;
			_pageamount = Math.ceil(_pageamount);
			if(_pageamount > 0) {
				var _prev = GetPrevPageno(current);
				var _next = GetNextPageno(current, _pageamount);
				_container.find("li.prev a").eq(0).attr("href", GetPaginationUrl(_prev));
				_container.find("li.next a").eq(0).attr("href", GetPaginationUrl(_next));
				if(_pageamount > 5) {
					BuildPaginationController(_container.find("li.prev"), _pageamount, current);
				} else {
					for(var i = _pageamount; i >= 1; i--) {
						BuildPaginationBtn(_container.find("li.prev"), i, current);
					}
				}
			} else {
				_container.find("li.prev a").eq(0).removeAttr("href");
				_container.find("li.next a").eq(0).removeAttr("href");
			}
			_container.find("li.showrec span.pagesize").text(pagesize);
			_container.find("li.showrec span.recamount").text(total);
		}
		return;
	};
	this.HidePagination = function() {
		var _container = $("tr.pagination");
		if(_container) {
			_container.remove();
		}
		return;
	};
	this.SetPrintTotalPage = function(container, rowNo) {
		var prevContainer = container.parent().prev();
		var nextContainer = container.parent().next();
		if(__pageRows == null) {
			__pageRows = 0;
		}
		if(!$.isNumeric(__pageRows)) {
			__pageRows = 0;
		}
		__pageRows = (__pageRows + '').ToInt();
		var _total = getPageAmount(rowNo);
		var _margin = __rowHeight * (__pageRows * _total - rowNo);
		var _pageHeight;
		var _pageMargin = __pageRows * __rowHeight;
		if(_margin > _pageMargin) {
			__header = _margin - _pageMargin + __header;
			ShowPageNo(container, (_total - 1), false, true);
			ShowPageBreak(container);
			var _header = $(prevContainer.outerHTML());
			_header.removeAttr("id");
			container.before(_header);
			__header = _margin - (_margin - _pageMargin) - __footer;
			ShowPageNo(nextContainer, _total, true, true);
			$(".pageNo_Total").html(_total);
		} else if(_margin == _pageMargin) {
			_pageHeight = _margin - __rowHeight - __footer;
			__header = _pageHeight + __header;
			ShowPageNo(nextContainer, _total, true, true);
			$(".pageNo_Total").html(_total);
		} else {
			_pageHeight = _margin - __rowHeight - __footer;
			__header = _pageHeight + __header;
			ShowPageNo(nextContainer, _total, true, true);
			$(".pageNo_Total").html(_total);
		}
		return;
	}
	this.PrintPagination = function(container, rowNo) {
		if(__pageRows == null) {
			__pageRows = 0;
		}
		if(!$.isNumeric(__pageRows)) {
			__pageRows = 0;
		}
		__pageRows = (__pageRows + '').ToInt();
		if(rowNo % __pageRows == 0) {
			var _currPageNo = rowNo / __pageRows;
			ShowPageNo(container, _currPageNo, false, false);
		}
		if(rowNo % __pageRows == 0) {
			ShowPageBreak(container);
			var _header = $(container.parent().prev().outerHTML());
			_header.removeAttr("id");
			container.before(_header);
		}
		return;
	}
	this.Initialize = function(page, count, tatal) {
		__header = header;
		__footer = footer;
		__pageRows = pageRows;
		__rowHeight = height;
		if(!__total) {
			__total = 0;
		} else {
			__total = total;
		}
		__pageamount = __total / __pageRows;
		__pageamount = Math.ceil(__pageamount);
		if(__pageamount <= 0) {
			this.HidePagination();
		} else {
			this.ShowPagination(page, count, __total);
		}
		return;
	};

	function constructor() {} {
		constructor();
	}
};
NF.System.Data.FieldProcessor = function() {
	this.Name = "NF.System.Data.FieldProcessor";
	this.Author = "Guo HongLiang";
	this.Version = "0.0.1";
	this.PublishDate = "2015-3-24";
	this.Normal = function(value, sw, container) {
		if(sw.method == 'show') {
			var _fldValue = value[sw.fld];
			if(sw.format) {
				var _cmd = sw.format + '("' + _fldValue + '")';
				_fldValue = _cmd.Eval();
			}
			container.html(_fldValue);
		} else if(sw.method == 'template') {
			if(sw.template) {
				var _tHtml = sw.template;
				_tHtml = NF.System.Data.ReplaceJsonData(_tHtml, value);
				container.html(_tHtml);
			}
		} else if(sw.method == 'calc') {
			if(sw.execute) {
				var _func = sw.execute + "('" + NF.System.Json.ToString(value) + "')";
				container.text(_func.Eval())
			}
		} else if(sw.method == 'attr') {
			var _fldValue = value[sw.fld];
			if(sw.format) {
				var _func = sw.format + '("' + _fldValue + '")';
				_fldValue = _func.Eval();
			}
			container.attr(sw.attr, _fldValue);
		}
	};
	this.Stat = function(container, row, swStat, rowNext, i, rowCount) {
		if(swStat.method == "sum") {
			var _stat = (container.text()).ToFloat();
			_stat += row[swStat.fld];
			if(i == (rowCount - 1)) {
				if(_stat.format) {
					var _func = sender.format + '("' + _stat + '")';
					_stat = _func.Eval();
				}
			}
			container.text(_stat);
		} else if(swStat.method == "max") {
			var _maxValue;
			if(typeof(container.attr('maxValue')) == 'undefined') {
				_maxValue = row[swStat.fld];
				container.attr('maxValue', _maxValue);
			} else {
				_maxValue = (container.attr('maxValue')).ToFloat();
				if(_maxValue < row[swStat.fld]) {
					container.attr('maxValue', row[swStat.fld]);
				}
			}
			if(rowNext != null) {
				container.text(container.attr('maxValue'));
			}
		} else if(swStat.method == "min") {
			var _minValue;
			if(typeof(container.attr('minValue')) == 'undefined') {
				_minValue = row[swStat.fld];
				container.attr('minValue', _minValue);
			} else {
				_minValue = (container.attr('minValue')).ToFloat();
				if(_minValue > row[swStat.fld]) {
					container.attr('minValue', row[swStat.fld]);
				}
			}
			if(rowNext != null) {
				container.text(container.attr('minValue'));
			}
		} else if(swStat.method == "avg") {
			var _stat = (container.text()).ToFloat();
			_stat += row[swStat.fld];
			container.text(_stat);
			if(rowNext == null) {
				var _avg = _stat / rowCount;
				container.text(_avg.toFixed(2));
			}
		}
	};
	this.SubStat = function(container, row, swSubStat, rowNext, i, rowCount) {
		if(swSubStat.method == 'sum') {
			var _sub = (container.text()).ToFloat();
			_sub += row[swSubStat.fld];
			if(rowNext == null || i == (rowCount - 1) || row[swSubStat.refFld] != rowNext[swSubStat.refFld]) {
				if(swSubStat.format) {
					var _func = swSubStat.format + '("' + _sub + '")';
					_sub = _func.Eval();
				}
				container.text(_sub);
				return true;
			} else {
				container.text(_sub);
			}
		} else if(swSubStat.method == 'max') {
			var _subStat = (container.text()).ToFloat();
			var _maxValue;
			if(typeof(container.attr('maxValue')) == 'undefined') {
				_maxValue = row[swSubStat.fld];
				container.attr('maxValue', _maxValue);
			} else {
				_maxValue = (container.attr('maxValue')).ToFloat();
				if(_maxValue < row[swSubStat.fld]) {
					container.attr('maxValue', row[swSubStat.fld]);
				}
			}
			if(rowNext == null || i == (rowCount - 1) || row[swSubStat.refFld] != rowNext[swSubStat.refFld]) {
				container.text(container.attr('maxValue'));
				container.removeAttr('maxValue');
				return true;
			}
		} else if(swSubStat.method == 'min') {
			var _minValue;
			if(typeof(container.attr('minValue')) == 'undefined') {
				_minValue = row[swSubStat.fld];
				container.attr('minValue', _minValue);
			} else {
				_minValue = (container.attr('minValue')).ToFloat();
				if(_minValue > row[swSubStat.fld]) {
					container.attr('minValue', row[swSubStat.fld]);
				}
			}
			if(rowNext == null || i == (rowCount - 1) || row[swSubStat.refFld] != rowNext[swSubStat.refFld]) {
				container.text(container.attr('minValue'));
				container.removeAttr('minValue');
				return true;
			}
		} else if(swSubStat.method == 'avg') {
			var _times = 0;
			if(typeof(container.attr('avgAmount')) == 'undefined') {
				_times = 1;
				container.attr('avgAmount', _times);
			} else {
				_times = container.attr('avgAmount').ToInt();
				_times += 1;
				container.attr('avgAmount', _times);
			}
			var _subTotal = (container.text()).ToFloat();
			_subTotal += row[swSubStat.fld];
			if(rowNext == null || i == (rowCount - 1) || row[swSubStat.refFld] != rowNext[swSubStat.refFld]) {
				_subTotal = _subTotal / _times;
				if(swSubStat.format) {
					var _func = swSubStat.format + '("' + _subTotal + '")';
					_subTotal = _func.Eval();
				}
				container.text(_subTotal.toFixed(2));
				container.removeAttr('avgAmount');
				return true;
			} else {
				container.text(_subTotal);
			}
		}
	};

	function constructor() {} {
		constructor();
	}
};

NF.System.Attach = function() {
	this.Name = "NF.System.Json";
	this.Author = "S";
	this.Version = "0.0.1";
	this.PublishDate = "2016-11-15";

	function constructor() {} {
		constructor();
	}
};
NF.System.Attach.GetUrl = function(url) {
	var _arrUrl = url.substring(8);
	var _start = _arrUrl.indexOf("/");　　
	var _relUrl = _arrUrl.substring(_start);
	if(_relUrl.indexOf("?") != -1) {　　　　　　
		_relUrl = _relUrl.split("?")[0];　　　
		_relUrl = _relUrl.substring(1);　
	}　
	return _relUrl;
};
NF.System.Attach.style_add = function(a, b) {
	var c, d, e;
	try {
		c = a.toString().split(".")[1].length;
	} catch(f) {
		c = 0;
	}
	try {
		d = b.toString().split(".")[1].length;
	} catch(f) {
		d = 0;
	}
	return e = Math.pow(10, Math.max(c, d)), (style_mul(a, e) + style_mul(b, e)) / e;
};
NF.System.Attach.style_sub = function(a, b) {
	var c, d, e;
	try {
		c = a.toString().split(".")[1].length;
	} catch(f) {
		c = 0;
	}
	try {
		d = b.toString().split(".")[1].length;
	} catch(f) {
		d = 0;
	}
	return e = Math.pow(10, Math.max(c, d)), (style_mul(a, e) - style_mul(b, e)) / e;
};
NF.System.Attach.style_mul = function(a, b) {
	var c = 0,
		d = a.toString(),
		e = b.toString();
	try {
		c += d.split(".")[1].length;
	} catch(f) {}
	try {
		c += e.split(".")[1].length;
	} catch(f) {}
	return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
};
NF.System.Attach.style_div = function(a, b) {
	var c, d, e = 0,
		f = 0;
	try {
		e = a.toString().split(".")[1].length;
	} catch(g) {}
	try {
		f = b.toString().split(".")[1].length;
	} catch(g) {}
	return c = Number(a.toString().replace(".", "")), d = Number(b.toString().replace(".", "")), style_mul(c / d, Math.pow(10, f - e));
};
NF.System.Attach.fontSize = function(className, num) {
	$('.' + className).css('font-size', num);
};
NF.System.Attach.countInput = function(className) {
	var text = $('.' + className).val();
	var counter = text.length;
	return counter;
};
NF.System.Attach.countText = function(className) {
	var text = $('.' + className).text();
	var counter = text.length;
	return counter;
};

NF.System.Attach.Seach = function(dml) {
	$(document).find('.searchButBack').on("click", function() {
		var mark = $(this).parents('.ListSeach');
		var endusername = mark.find('input[name="EndUserName"]').val();
		var CustomerName = mark.find('input[name="CustomerName"]').val();
		var Code = mark.find('input[name="Code"]').val();
		var pactcode = mark.find('input[name="PactCode"]').val();
		var createtime = mark.find('input[name="CreateTime"]').val();
		$('ul[name="AllList"]').attr('view-id', '{ id:dml,cross:"false", rowIdentClass:"AllList", paras:[{"name":"rows","value":10},{"name":"page","value":1},{"name":"endusername","value":"' + endusername + '"},{"name":"CustomerName","value":"' + CustomerName + '"},{"name":"Code","value":"' + Code + '"},{"name":"pactcode","value":"' + pactcode + '"},{"name":"createtime","value":"' + createtime + '"}]}');
		getData();
	});

	function getData() {
		var _AllList = new NF.System.Data.Grid();
		_AllList.Pagination("first-ds-pag", $("div[name='first-ds-pag']"), "page");
		_AllList.Initialize("/", "AllList", $("ul[name='AllList']").attr("view-id"), $("ul[name='AllList']"));

	}
};

//引用  NF.System.Attach.print_div(), 
//然后再打印的开始复制<!--startprint-->,结束为<!--endprint-->,
//打印按钮执行preview() 方法即可,
//如果你是打印一段DIV,请用这两个注释包含住DIV即可
NF.System.Attach.print_div = function() {
	bdhtml = window.document.body.innerHTML;
	sprnstr = "<!--startprint-->";
	eprnstr = "<!--endprint-->";
	prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
	prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
	window.document.body.innerHTML = prnhtml;
	window.print();
}

function fontSizeBig(className) {
	if(className == null) {
		var a = $('html');
	} else {
		var a = $('.' + className);
	}
	var currentFontSize = a.css('font-size');
	var currentFontSizeNum = parseFloat(currentFontSize, 10);
	var newFontSize = currentFontSizeNum * 1.2;
	a.css('font-size', newFontSize);
	return false;
}

function fontSizeSma(className) {
	if(className == null) {
		var a = $('html');
	} else {
		var a = $('.' + className);
	}
	var currentFontSize = a.css('font-size');
	var currentFontSizeNum = parseFloat(currentFontSize, 10);
	var newFontSize = currentFontSizeNum * 0.8;
	a.css('font-size', newFontSize);
	return false;
}

function style_mul(a, b) {
	var c = 0,
		d = a.toString(),
		e = b.toString();
	try {
		c += d.split(".")[1].length;
	} catch(f) {}
	try {
		c += e.split(".")[1].length;
	} catch(f) {}
	return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
};