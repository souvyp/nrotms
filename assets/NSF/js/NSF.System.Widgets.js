/*
Depend on:
jQuery-1.10.2.js
jquery.qrcode.js
qrcode.js
NSF.js
NSF.System.js
*/
///<reference path="NSF.js">
///<reference path="NSF.System.js">

NSF.System.Widgets = function ()
{
    //properties
    this.Name = "NSF.System.Widgets";
    this.Author = "Guo HongLiang";
    this.Version = "0.0.1";
    this.PublishDate = "2015-8-17";

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
parameters:
    container，容器的引用
    content，二维码中包含的内容
    _width, 宽度
    _height, 宽度
*/
NSF.System.Widgets.QRCode = function ( container, content, _width, _height )
{
    if ( NSF.Envoriment.Html5 )
    {
        container.qrcode( {
            render: "canvas",
            text: content,
            width: _width,
            height: _height
        } );
    }
    else
    {
        container.qrcode( {
            render: "table",
            text: content,
            width: _width,
            height: _height
        } );
    }

    return;
};