/*
Depend on:
jQuery-1.10.2.js
NSF.js
NSF.System.js
*/
///<reference path="NSF.js">
///<reference path="NSF.System.js">

NSF.System.Converter = function ()
{
    
    //properties
    this.Name = "NSF.System.Converter";
    this.Author = "Guo HongLiang";
    this.Version = "0.0.1";
    this.PublishDate = "2015-2-5";

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
    converter the html content to doc file
parameters:
 _html   导出项带标签内容
 _css    导出项所含CSS样式
 _name   传入自定义指定文件名称
returns:

example:
*/
NSF.System.Converter.ToDoc = function ( _html, _css, _name )
{
    //word文档的头部
    function Header()
    {
        var str = "";
        str += '<html xmlns:o="urn:schemas-microsoft-com:office:office"';
        str += 'xmlns:w="urn:schemas-microsoft-com:office:word"';
        str += 'xmlns="http://www.w3.org/TR/REC-html40">';
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

    //style样式
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

    //生成整个网页代码
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

    //word文档的底部
    function Footer( )
    {
        return '</body></html>';
    }

    //刷新生成word文档
    function Flush( str )
    {
        var a = document.createElement( 'a' );
        var blob = new Blob( [str], { 'type': 'application\/msword' } );
        a.href = window.URL.createObjectURL( blob );
        a.download = '' + _name + '.doc';
        a.click();

        return;
    }

    //constructor
    function constructor()
    {
        //please note that it is a private function, so you can call the public fields or methods only
        //do the private visiting in the following {}
        var __content = Generator();

        Flush( __content );
    }
    {
        constructor();
    }
};

/*
description:
    converter the html content to xls file
parameters:
	srcObj 导出项内容
	 _name 导出项 自定义名称
returns:

example:
*/
NSF.System.Converter.ToXls = function() {   
    var idTmr;

    function  getExplorer() {       //判断浏览器类型   
        var explorer = window.navigator.userAgent ;
        //ie 
        if (explorer.indexOf("MSIE") >= 0) {
            return 'ie';
        }
        //firefox 
        else if (explorer.indexOf("Firefox") >= 0) {
            return 'Firefox';
        }
        //Chrome
        else if(explorer.indexOf("Chrome") >= 0){
            return 'Chrome';
        }
        //Opera
        else if(explorer.indexOf("Opera") >= 0){
            return 'Opera';
        }
        //Safari
        else if(explorer.indexOf("Safari") >= 0){
            return 'Safari';
        }
    }

    function Cleanup() {
        window.clearInterval(idTmr);
        CollectGarbage();
    }

    var tableToExcel = (function() {
      var uri = 'data:application/vnd.ms-excel;base64,',
      template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
        base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) },
        format = function(s, c) {
            return s.replace(/{(\w+)}/g,
            function(m, p) { return c[p]; }) }
        return function(table, name) {
        if (!table.nodeType) table = document.getElementById(table)
        var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
        window.location.href = uri + base64(format(template, ctx))
      }
    })();

    this.method1 = function(tableid) {                                     //将整个表格拷贝到Excel中
        if (getExplorer()=='ie') {
            var curTbl = document.getElementById(tableid);
            var oXL = new ActiveXObject("Excel.Application");       //创建AX对象Excel
            
            var oWB = oXL.Workbooks.Add();                          //获取Workbook对象
            var xlsheet = oWB.Worksheets(1);                        //激活当前Sheet
            var sel = document.body.createTextRange();  
            sel.moveToElementText(curTbl);                          //将表格中的内容移到TextRange中
            sel.select();                                           //全选TextRange内容
            sel.execCommand("Copy");                                //复制TextRange中内容
            xlsheet.Paste();                                        //粘贴到活动的Excel中
            oXL.Visible = true;                                     //设置excel可见属性    

            try {
                var fname = oXL.Application.GetSaveAsFilename("Excel.xls", "Excel Spreadsheets (*.xls), *.xls");
            } catch (e) {
                print("Nested catch caught " + e);
            } finally {
                oWB.SaveAs(fname);

                oWB.Close(savechanges = false);
                //xls.visible = false;
                oXL.Quit();
                oXL = null;
                //结束excel进程，退出完成
                //window.setInterval("Cleanup();",1);
                idTmr = window.setInterval("Cleanup();", 1);
            }
        }
        else {
            tableToExcel(tableid);
        }
    }
};
