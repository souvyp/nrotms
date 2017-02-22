/*
Depend on:
jquery-1.11.1.min.js or upon version
json2.js
NSF.js

features list:
*/
///<reference path="../jquery/js/accounting.min.js">
///<reference path="../others/js/json2.js">
///<reference path="NSF.js">

NSF.System = function()
{
    //member fields

    //properties
    this.Name = "NSF.System";
    this.Author = "Guo HongLiang";
    this.Version = "0.0.1";
    this.PublishDate = "2014-9-1";

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

NSF.System.Json = function ()
{
    //member fields

    //properties
    this.Name = "NSF.System.Json";
    this.Author = "Guo HongLiang";
    this.Version = "0.0.1";
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

/*JSON扩展*/
/*
description: 
    将JSON对象转换成字符串
parameters:
    需要转换的JSON对象
returns:
    JSON字符串
depend on:
    json2.js
*/
NSF.System.Json.ToString = function ( obj )
{
    if ( JSON )
    {
        try
        {
            return JSON.stringify( obj );
        }
        catch ( e )
        {
            return JsonToString( obj );
        }
    }
    else
    {       
        return JsonToString( obj ); 
    }

    function JsonToString( obj )
    {
        var THIS = this;
        switch ( typeof ( obj ) )
        {
            case 'string':
                return '"' + obj.replace( /(["\\])/g, '\\$1' ) + '"';
            case 'array':
                return '[' + obj.map( THIS.JsonToString ).join( ',' ) + ']';
            case 'object':
                if ( obj instanceof Array )
                {
                    var strArr = [];
                    var len = obj.length;

                    for ( var i = 0; i < len; i++ )
                    {
                        strArr.push( THIS.JsonToString( obj[i] ) );
                    }

                    return '[' + strArr.join( ',' ) + ']';
                }
                else if ( obj == null )
                {
                    return 'null';

                }
                else
                {
                    var string = [];
                    for ( var property in obj )
                    {
                        string.push( THIS.JsonToString( property ) + ':' + THIS.JsonToString( obj[property] ) );
                    }

                    return '{' + string.join( ',' ) + '}';
                }
            case 'number':
                return obj;
            case false:
                return obj;
        }
    }
};

/*
description: 
    将JSON字符串转换成JSON对象
parameters:
    需要转换的JSON字符串
returns:
    JSON对象
depend on:
    json2.js
*/
NSF.System.Json.ToJson = function ( str )
{
    if ( JSON )
    {
        try
        {
            return JSON.parse( str );
        }
        catch ( e )
        {
            return eval( '(' + str + ')' );
        }
    }
    else
    {
        return eval( '(' + str + ')' );
    }
};

/*
decription:
    加载脚本
parameter:
    id , 唯一标识码
    code ,  js中需要加载的代码
returns:
    true or false
example:
*/
NSF.System.LoadScript = function ( id, code )
{
    var oHead, oScript, result = false;

    if ( code != "" && code != null )
    {
        try
        {
            oHead = document.getElementsByTagName( "HEAD" ).item( 0 );
        }
        catch ( e )
        {
            oHead = null;
        }

        if ( oHead )
        {
            try
            {
                oScript = document.createElement( "script" );
            }
            catch ( e )
            {
                oScript = null;
            }

            if ( oScript )
            {
                try
                {
                    oScript.id = id;
                    oScript.type = "text/javascript";
                    oScript.defer = true;
                    oScript.text = code;
                    oHead.appendChild( oScript );

                    result = true;
                }
                catch ( e )
                {
                }
            }
        }
    }
    return result;
};

/*
description:
    函数是否存在
parameter:
    none
returns:
    true or false
example:
*/
NSF.System.FunctionExist = function ( str )
{
    try
    {
        if ( typeof ( eval( str ) ) == "function" )
        {
            return true;
        }
    }
    catch ( e )
    {
        return false;
    }

};

/*
description:
    参数是否为NULL
parameter:
    待判断的参数值
returns:
    true or false
example:
*/
NSF.System.IsNull = function ( val )
{
    try
    {
        if ( typeof ( val ) == "undefined" )
        {
            return true;
        }
        else if ( val == null )
        {
            return true;
        }

        return false;
    }
    catch ( e )
    {
        return true;
    }
};

/*
description:
    生成唯一编码
parameter:
    none
returns:
    字符串编码
example:
*/
NSF.System.uuid = function ()
{
    var s = [];
    var hexDigits = "0123456789abcdef";
    for ( var i = 0; i < 36; i++ )
    {
        s[i] = hexDigits.substr( Math.floor( Math.random() * 0x10 ), 1 );
    }
    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr(( s[19] & 0x3 ) | 0x8, 1 );  // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";

    var uuid = s.join( "" );
    return uuid;
};

/*
descriptions: 
    显示错误信息
parameters:
    sInfo, 错误和警告信息或日志
returns:
    nothing
example:
*/
NSF.System.ThrowInfo = function ( sInfo )
{
    var _debug = NSF.Config.Debug;

    if ( _debug )
    {
        try
        {
            if ( console )
            {
                console.log( sInfo );
            }
            else
            {
                alert( sInfo );
            }
        }
        catch ( e )
        {
            alert( 'error code: ' + e.number + '\ndescription: ' + e.description );
        }
    }

    return;
};

NSF.System.Definition = function()
{
    //member fields

    //properties
    this.Name = "NSF.System.Definition";
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

NSF.System.Definition.Interface = function(key)
{
    var _value = '';

    if (key == 'SystemData')
    {
        if (NSF.Config.Mode == 'JDT')
        {
            _value = 'portal.cn';
        }
        else
        {
            _value = 'portal.aspx';
        }
    }

    return _value;
};

NSF.System.Definition.Envoriment = 
{
    MaxRows: 65536,
    DataIsland : 'view-id',
    DataField : 'view-fld',
    DataStat: 'view-stat',
    DataSubStat: 'view-subStat'
};

//键盘键值表
NSF.System.Definition.KeyCode =
{
    BackSpace	:	8,
    Delete		:	46,
    Home		:	36,
    End			:	35,
    PageUp		:	33,
    PageDown	:	34,
    UpArrow		:	38,
    DownArrow	:	40,
    RightArrow	:	39,
    LeftArrow	:	37
};