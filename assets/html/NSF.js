/*
Depend on:
jQuery-1.10.2.js or upon version
accouting.js
json2.js

features list:
*/
//<reference path="../jquery/js/accounting.min.js">
///<reference path="../others/js/json2.js">


/*String系统扩展*/
/*
description:
    从文件名中取得文件扩展名
parameter:
    none
returns:
    字符串文件扩展名
example:
*/
String.prototype.ExtFileName = function ()
{
    if ( this != "" )
    {
        return "." + this.replace( /.+\./, "" );
    }
    else
    {
        return "";
    }
};

/*
description:
    从文件路径中取得文件名
parameter:
    none
returns:
    字符串文件名
example:
*/
String.prototype.FileName = function ()
{
    if ( this != null )
    {
        var _filename = this.replace( /^.*[\\\/]/, '' )

        var name = _filename.split( "." );
        return name[0];
    }
    else
    {
        return "";
    }
};

/*
descriptin: 
    替换掉所有在一个字符串对象的中与目标字符串匹配的字符串
parameters:
    sSrc, 指定来自源字符串中需要被替换的字符串
    sDst, 指定替换源字符串的字符串
returns:
    字符串
*/
String.prototype.ReplaceAll = function ( sSrc, sDst )
{
    return this.replace( new RegExp( sSrc, "gm" ), sDst );
};

/*
description: 
    URL中的字符#后的字符串
parameters:
    bDecode, 是否需要解码，默认是
returns:
    #后的字符串
example:
*/
String.prototype.GetAnchorName = function ( bDecode )
{
    if ( bDecode == null || bDecode == undefined || bDecode )
    {
        return unescape( this.substr( this.indexOf( "#" ) + 1 ) );
    }
    else
    {
        return this.substr( this.indexOf( "#" ) + 1 );
    }
};

/*
description: 
    获得URL变量的集合
parameters:
    bDecode, 是否需要解码，默认是
returns:
    一个字符串数组，包含所有的URL变量
example:
*/
String.prototype.QueryStrings = function ( bDecode )
{
    var aVars = [], sHash;
    var aHashes = this.slice( this.indexOf( '?' ) + 1 ).split( '&' );

    for ( var i = 0; i < aHashes.length; i++ )
    {
        sHash = aHashes[i].split( '=' );

        aVars.push( sHash[0] );
        if ( bDecode == null || bDecode == undefined || bDecode )
        {
            aVars[sHash[0]] = unescape( sHash[1] );
        }
        else
        {
            aVars[sHash[0]] = sHash[1];
        }
    }

    return aVars;
};

/*
description: 
    得到一个URL变量
parameters:
    sName，URL的变量名称
    bDecode, 是否需要解码，默认是
returns:
    URL对应变量的值
example:
*/
String.prototype.QueryString = function ( sName, bDecode )
{
    return this.QueryStrings( bDecode )[sName];
};

/*
depend on accouting.js
*/
/*
description:
    将字符串格式化成科学计数法
parameter:
    none
returns:
    字符串
example:
*/
String.prototype.FormatNumber = function ()
{
    try
    {
        return accounting.formatNumber( parseFloat( this ), 2 );
    }
    catch ( e )
    {
        return this;
    }
};

/*
description:
    将一个字符串作为js代码执行
parameter:
    none
returns:
    一个对象
example:
*/
String.prototype.Eval = function ()
{
    try
    {
        var _func = this.toString();

        return eval( _func );
    }
    catch ( e )
    {
        if ( console )
        {
            console.log( 'Eval exception: \n' + e );
        }
        else
        {
            alert( 'Eval exception: \n' + e );
        }
    }

    return false;
};

/*
description: 
    获取字符串的第一个字符的ASCII编码
parameter:
    none
returns:
    ASCII编码
example:   
*/
String.prototype.ASCII = function ()
{
    return this.charCodeAt( 0 );
};

/*
description:  
    将指定的ASCII字符代码转换成相对应的字符
parameter:
    charcode, 需要转换的ASCII字符代码
returns:
    一个字符
example:
*/
String.prototype.FromASCII = function ( charcode )
{
    return String.fromCharCode( charcode );
};

/*
description: 
    反转字符串
parameter:
    none
returns:
   字符串
example:
*/
String.prototype.Reverse = function ()
{
    return this.split( "" ).reverse().join( "" );
};

/*
description:  
    从左边取得指定长度的字符串
parameter:
    n, 指定的长度
returns:
    字符串
example:
*/
String.prototype.Left = function ( n )
{
    return this.slice( 0, n );
};

/*
description:   
    从右边取得指定长度的字符串
parameter:
    n,指定的长度
returns:
    字符串
example:
*/
String.prototype.Right = function ( n )
{
    return this.slice( this.length - n );
};

/*
description:  
    取得字符串的字节长度
parameter:
    none
returns:
    字节长度
example:
*/
String.prototype.ByteLen = function ()
{
    return this.replace( /[^x00-xff]/g, "--" ).length;
};

/*
description:  
    在源字符串中搜索到一个指定的字符串，并用另一指定字符串替换它
parameter:
    oldStr , 原来的被替换的字符串
    newStr , 新的用来替换的字符串
returns:
    字符串
example:
*/
String.prototype.Replace = function ( oldStr, newStr )
{
    return this.replace( oldStr, newStr );
};

/*
description:
    去掉文本左边的空格
parameter:
    none
returns:
    字符串
example:
*/
String.prototype.LTrim = function ()
{
    return this.replace( /^\s+/, "" );
};

/*
description:
    去掉文本右边的空格
parameter:
    none
returns:
    字符串
example:
*/
String.prototype.RTrim = function ()
{
    return this.replace( /\s+$/g, "" );
};

/*
description:   
    将半角字符转换为全角字符
parameter:
    sourcestr,需要转换的字符串
returns:
    字符串
example:
*/
String.prototype.ToDBC = function ( sourcestr )
{
    var endvalue = '';

    for ( var charati = 0; charati < sourcestr.length; charati++ )
    {
        endvalue += String.fromCharCode( sourcestr.charCodeAt( charati ) + 65248 );
    }

    return endvalue;
};

/*
description:    
    计算一个字符在一个字符串中出现的次数
parameter:
    char,需要计算出现次数的字符
returns:
    次数
example:
*/
String.prototype.RepeatTimes = function ( char )
{
    return this.split( char ).length - 1;
};

/*
description:    
    判断字符串中是否存在全角或中文字符
parameter:
    none
returns:
    true or false
example:
*/
String.prototype.ExistsDBC = function ()
{
    var value = this.match( /[^\x00-\xff]/ig );

    if ( value != null )
    {
        return true;
    }
    else
    {
        return false;
    }
};


/*
description:   
    对字符进行XML编码
parameter:
    str , 需要进行XML编码的字符
returns:
    字符串
example:
*/
String.prototype.XMLEncode = function ( str )
{
    str = $.trim( str );
    str = str.replace( "&", "&amp;" );
    str = str.replace( "<", "&lt;" );
    str = str.replace( ">", "&gt;" );
    str = str.replace( "'", "&apos;" );
    str = str.replace( "\"", "&quot;" );

    return str;
};

/*
数据验证
*/
/*
description:
    判断一个数字是否为整形、正整数或负整数
parameter:
    none
returns:
    true or false
example:
*/
String.prototype.IsInt = function ( intValue )
{
    var reg = /^[-|+]?[1-9]*$/;

    return reg.test( intValue );
};

/*
description:
    判断传入的变量值是否为标准日期型值
parameter:
    none
returns:
    true or false
example:
*/
String.prototype.IsDate = function ()
{
    var reg = /^[\d]{4}([-|/])([0]?[1-9]|[1][0-2])([-|/])([0]?[1-9]|[1-2]\d|[3][0-1])$/;

    return reg.test( this );
};

/*
description:
    判断传入的变量值是否为合法的IP地址
parameter:
    none
returns:
    true or false
example:
*/
String.prototype.IsIP = function ()
{
    var reg = /^(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)$/;

    return reg.test( this );
};


/*
decription:
    判断传入的变量值是否为合法的数字
parameter:
    num , 源数据
returns:
    true or false
example:
*/
String.prototype.IsNumeric = function ( num )
{
    var reg = /^([+-]?)\d*\.?\d+$/;

    return reg.test( num );
};

/*
description:
    判断传入的变量值是否为标准时间值
parameter:
    none
returns:
    true or false
example:
*/
String.prototype.IsTime = function ()
{
    var reg = /^([0-1]\d|2[0-3]):[0-5]\d:[0-5]\d$/;

    return reg.test( this );
};

/*
description:
    判断传入的变量值是否标准日期时间型值
parameter:
    none
returns:
    true or false
example:
*/
String.prototype.IsDateTime = function ()
{
    var reg = /^[\d]{4}([-|/])([0]?[1-9]|[1][0-2])([-|/])([0]?[1-9]|[1-2]\d|[3][0-1])\s([0-1]\d|2[0-3]):[0-5]\d:[0-5]\d$/;

    return reg.test( this );
};

/*
description:
    将字符串对象转换成浮点型数据
parameter:
    none
returns:
    a float or 0
example:
*/
String.prototype.ToFloat = function ()
{
    var _float = 0;
    try
    {
        _float = parseFloat( this );
    }
    catch ( e )
    {
        _float = 0;
    }

    if ( isNaN( _float ) )
    {
        _float = 0;
    }

    return _float;
};

/*
description:
    将字符串对象转换成整型数据
parameter:
    none
returns:
    an integer or 0
*/
String.prototype.ToInt = function ()
{
    var _int = 0;

    try
    {
        _int = parseInt( this );
    }
    catch ( e )
    {
        _int = 0;
    }

    if ( isNaN( _int ) )
    {
        _int = 0;
    }

    return _int;
};

/*
Math扩展：
    Math对象不是对象的类，因此没有构造函数
    无需创建它，把 Math 作为对象使用就可以调用其所有属性和方法
*/
/*
decription:
    取得一个指定范围内的随机数
parameter:
    min , 开始值
    max , 结束值
returns:
    number
example:
*/
Math.Random = function ( min, max )
{
    var _min = 0;
    var _max = 0;

    try
    {
        _min = parseFloat( min );
        _max = parseFloat( max );
    }
    catch ( e )
    {
        _min = 0;
        _max = 0;
    }

    if ( isNaN( _min ) || isNaN( _max ) )
    {
        _min = 0;
        _max = 0;
    }

    return  parseInt( Math.random() * (_max - _min + 1 ) + _min );   
};

/*
decription:
    指定数组内最大值
parameter:
    array, 数组
returns:
    i , 最大值
example:
*/
Math.Max = function ( array )
{
    var i = array[0];

    for ( var n = 0 ; n < array.length ; n++ )
    {
        try
        {
            array[n] = parseFloat( array[n] );
            i = parseFloat( i );
            if ( array[n] > i )
            {
                i = array[n];
            }
        }
        catch ( e )
        {
            array[n] = 0;
            i = 0;
        }

        if ( isNaN( array[n] ) || isNaN( i ) )
        {
            i = 0;
        }
    }

    return i;

};

/*
description:
    指定数组内最小值
parameter:
    array，数组
returns:
    i , 最小值
example:
*/
Math.Min = function ( array )
{
    var i = array[0];

    for ( var n = 0 ; n < array.length ; n++ )
    {
        try
        {
            array[n] = parseFloat( array[n] );
            i = parseFloat( i );
            if ( array[n] < i )
            {
                i = array[n];
            }
        }
        catch ( e )
        {
            array[n] = 0;
            i = 0;
        }

        if ( isNaN( array[n] ) || isNaN( i ) )
        {
            i = 0;
        }

    }
    return i;
};


/*日期处理*/
/*
description:
    计算在指定日期上添加指定的时间单位后的日期值
parameter:
    strInterval , 时间间隔单位
    NumDay ， 添加的单位时间数
    dtDate ， 指定时间
returns:
    新的日期
example:
*/
Date.prototype.DateAdd = function ( strInterval, NumDay, dtDate )
{
    var _numDay = parseInt( NumDay );
    var _date;
    if ( dtDate != null )
    {
        var tmpdate, tmptime;
        tmpdate = dtDate.split( " " )[0];
        tmptime = dtDate.split( " " )[1];
        if ( tmptime != null )
        {
            var dtTmp = new Date( dtDate.replace( /-/g, "/" ) );
        }
        else
        {
            var dtTmp = new Date( dtDate.replace( /-/g, "/" ) );
        }
    }
    else
    {
        dtTmp = new Date();

    }

    if ( isNaN( dtTmp ) )
    {
        dtTmp = new Date();
    }
    switch ( strInterval )
    {
        case "s":
            _date = new Date( Date.parse( dtTmp ) + ( 1000 * _numDay ) );
            return _date;
        case "n":
            _date = new Date( Date.parse( dtTmp ) + ( 60000 * _numDay ) );
            return _date;
        case "h":
            _date = new Date( Date.parse( dtTmp ) + ( 3600000 * _numDay ) );
            return _date;
        case "d":
            _date = new Date( Date.parse( dtTmp ) + ( 86400000 * _numDay ) );
            return _date;
        case "w":
            return new Date( Date.parse( dtTmp ) + ( ( 86400000 * 7 ) * _numDay ) );
            return _date;
        case "m":
            var _date = new Date( dtTmp.getFullYear(), ( dtTmp.getMonth() ) + _numDay, dtTmp.getDate() );
            return _date;
        case "y":
            _date = new Date(( dtTmp.getFullYear() + _numDay ), dtTmp.getMonth(), dtTmp.getDate() );
            return _date;
    }
};

/*
description:
    计算两个字符(YYYY-MM-DD)日期相隔天数
parameter:
    startDate , 第一个日期
    endDate , 第二个日期
returns:
    number , 天数
example:
*/
Date.prototype.DaySpan = function ( startDate, endDate )
{
    var d1 = new Date( startDate.replace( /-/g, "/" ) );
    var d2 = new Date( endDate.replace( /-/g, "/" ) );
    var time = d2.getTime() - d1.getTime();

    return parseInt( time / ( 1000 * 60 * 60 * 24 ) );
};

/*
description:
    取得当前日期或用户输入日期的时间部分
parameteer:
    str , 需要判断的日期字符串
returns:
    time
example:
*/
Date.prototype.GetTime = function ( str )
{
    var _date;
    if ( str != "" )
    {
         _date = new Date( str );
    }
    else
    {
         _date = new Date();
    }

    var _str = _date.toTimeString();
    var _time = _str.split( " " )[0];

    return _time;
};

/*
description:
    取得当前日期或用户输入日期的日期部分
parameteer:
    str , 需要判断的日期字符串
returns:
    date
example:
*/
Date.prototype.GetDate = function ( str )
{
    var _date;
    if ( str != "" )
    {
        _date = new Date( str );
    }
    else
    {
        _date = new Date();
    }

    var _str = _date.toLocaleDateString();
    var _dateStr = _date.ToString( _str );

    return _dateStr;
};

/*
description:
    判断当前日期是否是周末
parometer:
    none
returns:
    true or false
example:
*/
Date.prototype.IsWeekend = function ( year )
{
    var weektype = 2;
    var currentdate;
    if ( year != null )
    {
        if ( year.indexOf( "/" ) != -1 )
        {
            currentdate = new Date( year.split( "/" )[0], year.split( "/" )[1] - 1, year.split( "/" )[2] );
        }
        else
        {
            currentdate = new Date( year.split( "-" )[0], year.split( "-" )[1] - 1, year.split( "-" )[2] );
        }

        if ( parseInt( currentdate.getDay() ) == 0 )
        {
            return ( true );
        }
        else
        {
            if ( parseInt( currentdate.getDay() ) == 6 )
            {
                return true;
            }
        }
    }

    return false;
};

/*
description:
    取得两个日期的时间间隔
parameter:
    startDateTime , 开始日期时间
    endDateTime　，　结束日期时间
returns:
    h , 小时
    m , 分钟
example:
*/
Date.prototype.TimeSpan = function ( startDateTime, endDateTime )
{
    var regTime = /(\d{4})-(\d{1,2})-(\d{1,2})( \d{1,2}:\d{1,2})/g;
    var interval = Math.abs( Date.parse( startDateTime.replace( regTime, "$2-$3-$1$4" ) ) - Date.parse( endDateTime.replace( regTime, "$2-$3-$1$4" ) ) ) / 1000;
    var h = Math.floor( interval / 3600 );
    var m = Math.floor( interval % 3600 / 60 );

    return h + "小时" + m + "分钟" ;
};

/*
description:
    判断当年是不是闰年
parameter:
    year , 输入的年份
returns:
    true or false
example:
*/
Date.prototype.IsLead = function ( year )
{
    var leadyear;
    if ( year % 4 == 0 && year % 100 != 0 )
    {
        return true;
    }
    else if ( year % 400 == 0 )
    {
        return true;
    }
    else
    {
        return false;
    }
};

/*
description:
    日期(YYYY-MM-DD)和天数相加(减)等于第二个日期
parameter:
    date,YYYY-MM-DD格式的字符串
    days ,  相加（减）的天数
returns:
    一个新的日期
example:
*/
Date.prototype.AddDaies = function ( date, days )
{
    var date = new Date( Date.parse( date.replace( /\-/g, '/' ) ) );
    var interTimes = days * 24 * 60 * 60 * 1000;
    var _date = new Date( Date.parse( date ) + interTimes );

    return _date;
};

/*
description:
    日期(YYYY-MM-DD HH:MM:SS)和秒钟数相加(减)等于第二个日期
parameter:
    datetime , YYYY-MM-DD HH:MM:SS格式的字符串
    seconds , 秒数
returns:
    一个新的日期
example:
*/
Date.prototype.AddSeconds = function ( date, seconds )
{
    var date = new Date( Date.parse( date.replace( /\-/g, '/' ) ) );
    var interTimes = seconds * 1000;
    var _date = new Date( Date.parse( date ) + interTimes );

    return _date;
};

/*
description:
    日期(YYYY-MM-DD HH:MM:SS)和毫秒钟数相加(减)等于第二个日期
parameter:
    datetime ,YYYY-MM-DD HH:MM:SS格式的字符串
    mseconds , 毫秒数
returns:
    一个新的日期
example:
*/
Date.prototype.AddMSeconds = function ( date, mseconds )
{
    var date = new Date( Date.parse( date.replace( /\-/g, '/' ) ) );
    var interTimes = parseInt( mseconds );
    var _date = new Date( Date.parse( date ) + interTimes );

    return _date;
};

/*
description:
    将带有年月日的字符串转换为日期时间格式
parameter:
    str , 需要转换的日期字符串
returns:
    字符串
example:
*/
Date.prototype.ToString = function ( str )
{
    var _date;

    if ( str != null )
    {
        var arr = str.split( /年|月|日|:/ );

        _date = arr[0] + "-" + arr[1] + "-" + arr[2];
    }
    if ( _date.IsDate() )
    {
        return _date;
    }
    else
    {
        return "";
    }
}


/*数组*/
/*
description:
    取得数组值在数组中第一次出现的位置
parameter:
    str , 需要判断的字符串数组
    index , 需要判断的值
returns:
    pos , 位置
example:
*/
Array.prototype.IndexOf = function ( index )
{
    for ( var i = 0; i < this.length ; i++ )
    {
        if ( parseInt( this[i] ) === index )
        {
            return i;
        }
    }

    return -1;
};

/*
description:
    取得数组值在数组中的最后一次出现的位置
parameter:
    str , 需要判断的字符串数组
    index , 需要判断的值
returns:
    i , 位置
example:
*/
Array.prototype.LastIndexOf = function ( index )
{
    var l = this.length;
    for ( var i = l - 1; i >= 0; i-- )
    {
        if ( parseInt( this[i] ) === index )
        {
            return i;
        }
    }

    return -1;
};

/*
description:
    从数组的指定位置删除一个元素
parameter:
    str , 需要判断的字符串数组
    dx , 指定的位置
returns:
    一个数组
example:
*/
Array.prototype.RemoveAt = function ( dx )
{
    this.splice( dx, 1 );

    return this;
};

/*
description:
    在数组指定位置插入一个元素
parameter:
    str , 需要判断的字符串数组
    index , 指定的位置
    obj , 需要插入的值
returns:
    一个数组
example:
*/
Array.prototype.InsertAt = function ( index, obj )
{
    this.splice( index, 0, obj );

    return this;
};

/*
description:
    从数组中移除某一元素
parameter:
    str , 需要判断的字符串数组
    obj , 需要移除的值
returns:
    一个数组
example:
*/
Array.prototype.RemoveItem = function ( obj )
{
    var index = this.IndexOf( obj );
    var result = null;

    if ( index >= 0 )
    {
        result = this.RemoveAt( index );
    }

    return result;
};

/*
description:
    删除指定个数的数组中的重复并返回从0开始的数组项
parameter:
    str , 需要判断的字符串数组
    m , Array对象的数据项的长度
returns:
    一个数组
example:
*/
Array.prototype.RemoveRepeat = function ( m )
{
    var k = 0, j = 0, n = 0;
    var array = new Array();

    for ( var i = 0; i < m; i++ )
    {
        for ( j = i + 1; j < m; j++ )
        {
            if ( this[i] == this[j] )
            {
                this[i] = null;
            }
        }
    }

    for ( var i = 0; i < m; i++ )
    {
        if ( this[i] )
        {
            array[k++] = this[i];
        }
    }

    return array;
};

/*
description:
    从数组的左边移除指定个数的元素
parameter:
    str , 需要判断的字符串数组
    num , 指定移除的个数
returns:
    一个数组
example:
*/
Array.prototype.RemoveLeft = function ( num )
{
    this.splice( 0, num );

    return this;
};

/*
description:
    从数组的右边移除指定个数的元素
parameter:
    str , 需要判断的字符串数组
    num , 指定移除的个数
returns:
    一个数组
example:
*/
Array.prototype.RemoveRight = function ( num )
{
    this.splice( this.length - num, num );

    return this;
};

/*
description:
    将原Array对象的左边的几项作为新的Array对象返回
parameter:
    str , 需要判断的字符串数组
    len , 需要取得的Array项的长度
returns:
    一个数组
example:
*/
Array.prototype.Left = function (len )
{
    return this.slice( 0, len );
};

/*
description:
    将原Array对象的右边的几项作为新的Array对象返回
parameter:
    str , 需要判断的字符串数组
    len , 需要取得的Array项的长度
returns:
    一个数组
example:
*/
Array.prototype.Right = function ( len )
{
    if ( len >= this.length )
    {
        return this.concat();
    }

    return this.slice( this.length - len, this.length );
};

/*
description:
    从原Array对象的中取得指的几项作为新的Array对象返回
parameter:
    str , 需要判断的字符串数组
    start , 从原Array开始取值的位置
    len , 需要取得Array项的长度
returns:
    一个数组
example:
*/
Array.prototype.Mid = function ( start, len )
{
    return this.slice( start, start + len );
};

/*
description:
    从数组中随机取得一个元素
parameter:
    str , 需要判断的字符串数组
returns:
    一个元素(数组项)
example:
*/
Array.prototype.RandomItem = function ()
{
    var lownum = 1;
    var upnum = this.length;
    var t = parseInt( upnum - lownum + 1 ) * Math.random() + lownum;

    return this[parseInt( t ) - 1];
};

/*
description:
    对数组的元素进行随机排序
parameter:
    str , 需要判断的字符串数组
returns:
    一个数组
example:
*/
Array.prototype.RandomSort = function ()
{
    return this.sort( function ()
    {
        return Math.random() * new Date % 3 - 1;
    } );
};

/*
description:
    从数组中随机抽取指定的个数的项组成新数组
parameter:
    str , 需要判断的字符串数组
    lownum , 开始截取的下标位置
    upnum , 结束截取的下标位置
    count ,　项的个数
returns:
    一个数组
example:
*/
Array.prototype.RandomItems = function ( lownum, upnum, count )
{
    if ( count > ( upnum - lownum + 1 ) )
    {
        count = upnum - lownum + 1;
    }

    var res = new Array();
    for ( var i = 0; i < count; i++ )
    {
        var t = parseInt( upnum - lownum + 1 ) * Math.random() + lownum;
        if ( numberindexOf( res, this[parseInt( t )] ) != -1 )
        {
            i--;
        }
        else
        {
            res.push( this[parseInt( t )] );
        }
    }

    return res;

    function numberindexOf( source, findnum )
    {
        var l = source.length;

        for ( var i = 0; i < l; i++ )
        {
            if ( source[i] === findnum )
            {
                return i
            }
        }

        return -1;
    }
};

/*
jQuery对像扩展函数
*/
/*
description:
    取当前对象的HTML(包括当前对像在内）
parameter:
    obj , 需要获取html的对象
returns:
    html
example:
*/
jQuery.fn.outerHTML = function ()
{
    return jQuery( "<p>" ).append( this.eq( 0 ).clone() ).html();
};

/*
description:
    序列化对象
parameter:
    none
returns:
    object
example:
*/
$.fn.serializeObject = function ()
{
    var _out = {};
    var _in = this.serializeArray();

    $.each( _in, function ()
    {
        if ( _out[this.name] !== undefined )
        {
            if ( !_out[this.name].push )
            {
                _out[this.name] = [_out[this.name]];
            }
            _out[this.name].push( this.value || '' );
        }
        else
        {
            _out[this.name] = this.value || '';
        }
    } );

    return _out;
};

/*
description:
    动画闪动
parameter:
    intShakes,      闪动
    intDistance,    距离
    intDuration,    持续时间
    foreColor,      前景色
returns:
    object
example:
*/
jQuery.fn.shake = function ( intShakes, intDistance, intDuration, foreColor )
{
    this.each( function ()
    {
        if ( foreColor && foreColor != "null" )
        {
            $( this ).css( "color", foreColor );
        }

        $( this ).css( "position", "relative" );
        for ( var x = 1; x <= intShakes; x++ )
        {
            $( this ).animate( { left: ( intDistance * -1 ) }, ( ( ( intDuration / intShakes ) / 4 ) ) );
            $( this ).animate( { left: intDistance }, ( ( intDuration / intShakes ) / 2 ) );
            $( this ).animate( { left: 0 }, ( ( ( intDuration / intShakes ) / 4 ) ) );
            $( this ).css( "color", "" );
        }
    } );

    return this;
};

//jQuery扩展API
$.extend(
{
    //
} );

window.NSF = function ()
{
    //
};

NSF.Name = "NS Javascript Framework";
NSF.Author = "Guo HongLiang";
NSF.Version = "0.1.4";
NSF.PublishDate = "2014-9-1";

NSF.UrlVars = function ()
{
    //member fields

    //properties
    this.Name = "NSF.UrlVars";
    this.Author = "Guo HongLiang";
    this.Version = "0.1.4";
    this.PublishDate = "2014-10-14";

    //no private functions

    //no methods

    //constructor
    function constructor()
    {
        //write your code here

        //please note that it is a private function, so you can call the public fields or methods only
        //do the private visiting in the following {}
    }
    {
        constructor();
    }
};

/*
description:
    判断指定的URL变量是否存在
parameter:
    url,    URL地址
    sName , 需要判断的变量名称
returns:
    true or false
example;
*/
NSF.UrlVars.Exists = function ( sName, url )
{
    var _url;
    if ( url != "" )
    {
        _url = url;
    }
    else
    {
        var _url = window.location.href;
    }
    if ( -1 == _url.indexOf( "?" + sName + "=" ) &&
        -1 == _url.indexOf( "&" + sName + "=" ) )
    {
        return false;
    }
    else
    {
        return true;
    }
};

/*
description:
    获取指定URL变量的值
parameter:
    url ,   URL地址
    sName , 需要获取值的变量名称
returns:
    一个字符串值
example:
*/
NSF.UrlVars.Get = function ( sName, url )
{
    if ( NSF.UrlVars.Exists( sName, url ) )
    {
        return NSF.UrlVars.List( url )[sName];
    }
    else
    {
        return "";
    }
};

/*
description:
    替换指定的URL变量的值或设置变量及值
parameter:
    sName , 指定需要替换的变量名称
    sValue ,　给定新的变量值
    sUrl，Url地址
returns:
    Url字符串
example:
*/
NSF.UrlVars.Set = function ( sName, sValue, sUrl )
{
    var _url = '';
    if ( sUrl && sUrl != "" )
    {
        _url = sUrl;
    }
    else
    {
        _url = window.location.href;
    }
    if ( NSF.UrlVars.Exists( sName, _url ) )
    {
        var _re = eval( '/([&|?]' + sName + '=)([^&]*)/gi' );

        if ( _url.indexOf( "&" + sName + "=" ) == -1 )
        {
            return _url.replace( _re, "?" + sName + '=' + sValue );
        }
        else
        {
            return _url.replace( _re, "&" + sName + '=' + sValue );
        }
    }
    else
    {
        if ( _url.indexOf( "?" ) != -1 )
        {
            return _url + "&" + sName + '=' + sValue;
        }
        else
        {
            return _url + "?" + sName + '=' + sValue;
        }
    }
};

/*
description:
    获取URL变量的集合
parameter:
    url,  URL地址
returns:
    变量名组成的集合
example:
*/
NSF.UrlVars.List = function ( url )
{
    if ( url != "" )
    {
        return url.QueryStrings();
    }
    else
    {
        return window.location.href.QueryStrings();
    }
};

/*
description:
    删除指定变量名及其对应的值
parameter:
    sName, 需要删除的指定变量名
    sUrl,  URL地址
returns:
    url
example:
*/
NSF.UrlVars.Remove = function ( sName , sUrl )
{
    var _url = '';
    var _array;

    if ( sUrl && sUrl != "" )
    {
        _url = sUrl;
    }
    else
    {
        _url = window.location.href;
    }
    if ( NSF.UrlVars.Exists( sName, _url ) )
    {
        var _value = NSF.UrlVars.Get( sName, _url );

        if (  _url.indexOf("?" + sName )!= -1 )
        {
            if ( _url.indexOf( "?" + sName + '=' + _value + "&" ) != -1 )
            {
                return _url.replace( "?" + sName + '=' + _value + "&", "?" );
            }
            else
            {
                return _url.replace( "?" + sName + '=' + _value ,"");
            }
        }
        else if ( _url.indexOf( "&" + sName ) != -1 )
        {
            return _url.replace( "&" + sName + '=' + _value, "" );
        }
    }
    else
    {
        if ( _url.indexOf( '?' ) != -1 )
        {
            _array = _url.split( '?' );

            return _url.replace( '?' + _array[1], "" );
        }
    }
};

NSF.Config = function ()
{
    this.Name = "NSF.Config";
    this.Author = "Guo HongLiang";
    this.Version = "0.0.1";
    this.PublishDate = "2014-9-30";

    //no private functions
    //no methods
    //constructor
    function constructor()
    {
        //write your code here

        //please note that it is a private function, so you can call the public fields or methods only
        //do the private visiting in the following {}
    }
    {
        constructor();
    }
};

/*
description: 
    run mode
options:
    ZM, zmSDK
    NF, .Net Framework
*/
NSF.Config.Mode = 'ZM';

/*
description:
    run DeBug
options:
    true
    false
*/
NSF.Config.Debug = false;