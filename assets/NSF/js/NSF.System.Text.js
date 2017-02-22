/*
Depend on:
jquery-1.11.1.min.js
NSF.js
NSF.System.js
*/
///<reference path="NSF.js">
///<reference path="NSF.System.js">

NSF.System.Text = function ()
{
    //properties
    this.Name = "NSF.System.Text";
    this.Author = "Guo HongLiang";
    this.Version = "0.0.1";
    this.PublishDate = "2014-9-1";

    //constructor
    function constructor()
    {
        //do nothing
    }
    {
        constructor();
    }
};

/*
description:
    ��һ��utf16 ���͵��ַ���ת��Ϊutf8 
parameter:
    str , ��Ҫת�����ַ���
returns:
    ����Ϊutf8���ַ���
example:
*/
NSF.System.Text.UTF16To8 = function ( str )
{
    var out = "", i, len = str.length, c;

    for ( i = 0; i < len; i++ )
    {

        c = str.charCodeAt( i );

        if ( ( c >= 0x0001 ) && ( c <= 0x007F ) )
        {
            out += str.charAt( i );
        }
        else if ( c > 0x07FF )
        {
            out += window.String.fromCharCode( 0xE0 | ( ( c >> 12 ) & 0x0F ) );
            out += window.String.fromCharCode( 0x80 | ( ( c >> 6 ) & 0x3F ) );
            out += window.String.fromCharCode( 0x80 | ( ( c >> 0 ) & 0x3F ) );
        }
        else
        {
            out += window.String.fromCharCode( 0xC0 | ( ( c >> 6 ) & 0x1F ) );
            out += window.String.fromCharCode( 0x80 | ( ( c >> 0 ) & 0x3F ) );
        }
    }

    return out;
};

/*
description:
    ��һ��utf8 ���͵��ַ���ת��Ϊutf16
parameter:
    str , ��Ҫת�����ַ���
returns:
    ����Ϊutf16���ַ���
example:
*/
NSF.System.Text.UTF8To16 = function ( str )
{
    var out = "", i = 0, len = str.length, c;
    var char2, char3;

    while ( i < len )
    {
        c = str.charCodeAt( i++ );
        switch ( c >> 4 )
        {
            case 0: case 1: case 2: case 3: case 4: case 5: case 6: case 7:
                out += str.charAt( i - 1 );
                break;
            case 12: case 13:
                char2 = str.charCodeAt( i++ );
                out += window.String.fromCharCode(( ( c & 0x1F ) << 6 ) | ( char2 & 0x3F ) );
                alert( out );
                break;
            case 14:
                char2 = str.charCodeAt( i++ );
                char3 = str.charCodeAt( Si++ );
                out += window.String.fromCharCode(( ( c & 0x0F ) << 12 ) | ( ( char2 & 0x3F ) << 6 ) | ( ( char3 & 0x3F ) << 0 ) );
                alert( out );
                break;
        }
    }
    return out;
};
