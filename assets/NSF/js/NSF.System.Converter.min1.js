
NSF.System.Converter = function ()
{
this.Name = "NSF.System.Converter";
this.Author = "Guo HongLiang";
this.Version = "0.0.1";
this.PublishDate = "2015-2-5";
function constructor()
{
}
{
constructor();
}
};
NSF.System.Converter.ToDoc = function ( _html, _css, _name )
{
function Header()
{
var str = "";
str += '<html xmlns:o="urn:schemas-microsoft-com:office:office"';
str += 'xmlns:w="urn:schemas-microsoft-com:office:word"';
str += 'xmlns="http:
str += '<head>';
str += '<meta http-equiv=Content-Type  content="text/html; charset=gb2312" >';
str += '<title></title>';
str += '<!--[if gte mso 9]>';
str += '<xml>';
str += '<w:WordDocument>';
str += '<w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>';
str += '<w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery>';
str += '<w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery>';
str += '<w:DocumentKind>DocumentNotSpecified</w:DocumentKind>';
str += '<w:DrawingGridVerticalSpacing>7.8 磅</w:DrawingGridVerticalSpacing>';
str += '<w:PunctuationKerning></w:PunctuationKerning>';
str += '<w:View>Web</w:View>';
str += '<w:Compatibility>';
str += '<w:DontGrowAutofit/>';
str += '<w:BalanceSingleByteDoubleByteWidth/>';
str += '<w:DoNotExpandShiftReturn/>';
str += '<w:UseFELayout/>';
str += '</w:Compatibility>';
str += '<w:Zoom>0</w:Zoom>';
str += '</w:WordDocument>';
str += '</xml>';
str += '<![endif]-->';
str += Style();
str += '</head><body>';
return str;
}
function Style()
{
var str = "";
if ( _css != null && _css != "" )
{
str += '<style>';
str += _css;
str += '</style>';
}
return str;
}
function Generator()
{
var str = Header();
if ( _html != null && _html != "" )
{
str += _html;
}
str += Footer();
return str;
}
function Footer( )
{
return '</body></html>';
}
function Flush( str )
{
var a = document.createElement( 'a' );
var blob = new Blob( [str], { 'type': 'application\/msword' } );
a.href = window.URL.createObjectURL( blob );
a.download = '' + _name + '.doc';
a.click();
return;
}
function constructor()
{
var __content = Generator();
Flush( __content );
}
{
constructor();
}
};
NSF.System.Converter.ToXls = function ( srcObj, _name )
{
var str = srcObj.outerHTML();
var a = document.createElement( 'a' );
var blob = new Blob( [str], { 'type': 'application\/octet-stream' } );
a.href = window.URL.createObjectURL( blob );
a.download = _name + '.xls';
a.click();
return;
};
