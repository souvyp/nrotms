/*
Depend on:
jQuery-1.10.2.js
NSF.js
NSF.System.js
*/
///<reference path="NSF.js">
///<reference path="NSF.System.js">

NSF.System.Network = function ()
{
    //properties
    this.Name = "NSF.System.Network";
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

parameters:
    url, URL地址
    params, 一个JSON对象包含所有的AJAX参数
    type, HTTP请求的方法，如GET或POST，默认值是GET
    cross, true/false, 请求是否跨域
    callback, 用下面的定义函数
    function(true/false, response json)
returns:

example:
*/
NSF.System.Network.Ajax = function (url, params, type, cross, callback)
{
    if ( !type )
    {
        type = "GET";
    }
    if ( type != "GET" && type != "POST" )
    {
        type = "GET";
    }
    $.ajax(
    {
        async: false,
        url: url,
        dataType: (cross ? "jsonp" : "json"),
        jsonp: (cross ? 'callback' : ''),
        type: type,
        data: params,
        error: function (reqObj, status, err)
        {
            if (callback)
            {
                callback(false, '{ "status" : "' + status + '", "err" : "' + err + '" } ');
            }
            else
            {
                NSF.System.ThrowInfo( 'status: ' + status + '\nerr: ' + err );
            }
        },
        success: function (data)
        {
            if ( callback )
            {
                callback( true, data );
            }
            else
            {
                NSF.System.ThrowInfo( data );
            }
        }
    });
};