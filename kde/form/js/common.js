var GRID_URL = '/code/grid.chi';
var FORM_URL = '/code/form.chi';
var MISC_URL = '/code/data/misc.chi';
var FILE_URL = '/code/files/misc.chi';

//两个参数，一个是cookie的名子，一个是值
function setCookie( name, value )
{
    var Days = 30; //此 cookie 将被保存 30 天
    var exp = new Date();    //new Date("December 31, 9998");
    exp.setTime( exp.getTime() + Days * 24 * 60 * 60 * 1000 );
    document.cookie = name + "=" + escape( value ) + ";expires=" + exp.toGMTString();
}

//取cookies函数
function getCookie( name )
{
    var arr = document.cookie.match( new RegExp( "(^| )" + name + "=([^;]*)(;|$)" ) );
    if ( arr != null ) return unescape( arr[2] ); return null;
}

//取得页面参数
String.prototype.GetValue = function ( para )
{
    var reg = new RegExp( "(^|&)" + para + "=([^&]*)(&|$)" );
    var r = this.substr( this.indexOf( "\?" ) + 1 ).match( reg );
    if ( r != null ) return unescape( r[2] ); return null;
}

function GetRequest( name )
{
    var str = location.href;
    var re = str.GetValue( name );
    if ( re && re != "" )
    {
        var i = re.indexOf( '#' );
        if ( i > 0 ) re = re.substring( 0, i );
    }
    return re;
}

function GetRequestJn()
{
    var str = location.href;
    var i = str.indexOf( '#' );
    if ( i > 0 )
        return str.substring( i + 1, i + 2 );
    else
        return null;
}

$.extend( {
    getUrlVars: function ()
    {
        var vars = [], hash;
        var hashes = window.location.href.slice( window.location.href.indexOf( '?' ) + 1 ).split( '&' );
        for ( var i = 0; i < hashes.length; i++ )
        {
            hash = hashes[i].split( '=' );
            vars.push( hash[0] );
            vars[hash[0]] = hash[1];
        }
        return vars;
    },
    getUrlVar: function ( name )
    {
        var v = $.getUrlVars()[name];
        if ( v )
        {
            var i = v.indexOf( '#' );
            if ( i > 0 ) v = v.substring( 0, i );
        }
        return v;
    },
    getUrlJn: function ( name )
    {
        var v = $.getUrlVars()[name];
        if ( v )
        {
            var i = v.indexOf( '#' );
            if ( i > 0 ) v = v.substring( i + 1, v.length );
        }
        return v;
    }
} );

function getUrlParam( name )
{
    var reg = new RegExp( "(^|&)" + name + "=([^&]*)(&|$)" ); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr( 1 ).match( reg );  //匹配目标参数
    if ( r != null ) return unescape( r[2] ); return null; //返回参数值
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
            } else if ( obj == null )
            {
                return 'null';

            } else
            {
                var string = [];
                for ( var property in obj ) string.push( THIS.JsonToString( property ) + ':' + THIS.JsonToString( obj[property] ) );
                return '{' + string.join( ',' ) + '}';
            }
        case 'number':
            return obj;
        case false:
            return obj;
    }
}

function JsonToStr( data )
{
    return JSON.stringify( data );
}

function StrToJson( data )
{
    return JSON.parse( data );
}

function StringToJson( json )
{
    return eval( '(' + json + ')' );
}

function DataToTree( data )
{

}

Array.prototype.RemoveIndex = function ( dx )
{
    if ( isNaN( dx ) || dx > this.length )
    {
        return false;
    }

    this.splice( dx, 1 );
}

String.prototype.replaceAll = function ( s1, s2 )
{
    return this.replace( new RegExp( s1, "gm" ), s2 );
}

String.prototype.right = function ( length_ )
{
    var _from = this.length - length_;
    if ( _from < 0 )
    {
        _from = 0;
    }

    return this.substring( this.length - length_, this.length );
};

$.fn.isVisible = function ()
{
    return this.css( 'display' ) != 'none';
}

function Log( e )
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
    return;
}

$( document ).keydown( function ( event )
{
    if ( event.keyCode >= 37 && event.keyCode <= 40 )
    {
        return true;
    }
    else
    {
        if ( window.event ) event = window.event;
        var the = event.target || event.srcElement;
        if ( !( ( the.tagName == "INPUT" && the.type.toLowerCase() == "text" ) || the.tagName == "TEXTAREA" ) )
        {
            //$("#searchInput").focus();
        }
    }
} );
document.onselectstart = igEvent;
function functionExist( funcName )
{
    try
    {
        if ( typeof ( eval( funcName ) ) == "function" )
        {
            return true;
        }
    }
    catch ( e )
    {
        //alert("not function"); 
    }

    return false;
}

function mask( text, id )
{
    var body = $( 'body' );
    if ( id ) body = $( '#' + id );
    if ( body.children( "div.mask-msg" ).length == 0 )
    {
        if ( !text ) text = '正在处理，请稍待。。。';
        $( '<div class="mask" style="display:block;z-index:9999;"></div>' ).appendTo( body );
        var msg = $( '<div class="mask-msg" style="display:block;z-index:9999;"></div>' ).html( text ).appendTo( body );
        msg.css( "left", ( body.width() - msg.outerWidth() ) / 2 );
    }
}

function unmask( id )
{
    var body = $( 'body' );
    if ( id ) body = $( '#' + id );
    body.children( "div.mask-msg" ).remove();
    body.children( "div.mask" ).remove();
}

function igEvent( event )
{
    if ( window.event ) event = window.event;
    var the = event.target || event.srcElement;
    if ( !( ( the.tagName == "INPUT" && the.type.toLowerCase() == "text" ) || the.tagName == "TEXTAREA" ) )
    {
        return false;
    }
    return true;
}



function GetContent( url, param, type, masked, sucHandle, errHandle )
{
    $.ajax( {
        type: "get",
        url: url,
        data: param,
        dataType: type,
        ifModified: true,
        cache: true,
        beforeSend: function ( XMLHttpRequest )
        {
            if ( masked )
                mask();
        },
        success: function ( data, textStatus )
        {
			 if ( masked )
                unmask();
            if ( sucHandle ) sucHandle( data );
        },
        complete: function ( XMLHttpRequest, textStatus )
        {
            if ( masked )
                unmask();
        },
        error: function ()
        {
			 if ( masked )
                unmask();
            if ( errHandle ) errHandle();
        }
    } );
}

function PostContent( url, param, type, masked, sucHandle, errHandle )
{
    $.ajax( {
        type: "post",
        url: url,
        data: param,
        dataType: type,
        beforeSend: function ( XMLHttpRequest )
        {
            if ( masked )
                mask();
        },
        success: function ( data, textStatus )
        {
            if ( sucHandle ) sucHandle( data );
        },
        complete: function ( XMLHttpRequest, textStatus )
        {
            if ( masked )
                unmask();
        },
        error: function ()
        {
            if ( errHandle ) errHandle();
        }
    } );
}

function ToInt( w )
{
    var _int = 0;
    try
    {
        _int = parseInt( w );
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
}

function readImgFile( input, h )
{
    var file = input.files[0];
    //这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件 
    if ( !/image\/\w+/.test( file.type ) )
    {
        alert( "请确保文件为图像类型" );
        return false;
    }

    var reader = new FileReader();
    reader.readAsDataURL( file );
    reader.onload = function ( e )
    {
        if ( !this.result || this.result == "" )
        {
            alert( "图像转换为图标错误，请重新选择图像!" );
        }
        else
        {
            h( this.result );
        }
    }
}

$.fn.serializeObject = function ()
{
    var o = {};
    var a = this.serializeArray();
    $.each( a, function ()
    {
        if ( o[this.name] !== undefined )
        {
            if ( !o[this.name].push )
            {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push( this.value || '' );
        }
        else
        {
            o[this.name] = this.value || '';
        }
    } );
    return o;
};


function loadStyleString( css, id )
{
    var style = document.createElement( "style" );
    if ( id ) style.id = id;
    style.type = "text/css";
    try
    {
        style.appendChild( document.createTextNode( css ) );
    } catch ( ex )
    {
        style.styleSheet.cssText = css;
    }
    var head = document.getElementsByTagName( "head" )[0];
    head.appendChild( style );
}

function removeStyle( id )
{
    var style = document.getElementById( id );
    if ( style )
    {
        var p;
        if ( p = style.parentNode )
            p.removeChild( style );
    }
}

function uuid()
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
}
