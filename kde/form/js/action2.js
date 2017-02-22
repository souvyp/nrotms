function createOptionsNDT(obj, _option, _html)
{
	if(_option.datalist=="1")
	{
		createOptionsNDTList(obj, _option, _html);
	}
	else if (_option.form=="1")
	{
		createOptionsNDTForm(obj, _option, _html);
	}
	else
	{
		alert("请选择待生成内容！");
	}
	
	return;
}

function createOptionsNDTForm(obj, _option, _html)
{
	var _vidInsert = _option.insertVml;
	var _vidUpdate = _option.updateVml;
	var _vidQuery = _option.queryVml;
	if (_vidInsert == null || _vidInsert == '')
	{
		return;
	}

	_html = __FormatNDTOptions( _option, _html );

	/*生成NDT配置信息*/
	var _tJson = { main : {} };
	_tJson.main.insertVml = _option.insertVml;
	_tJson.main.updateVml = _option.updateVml;
	_tJson.main.queryVml = _option.queryVml;
	if (_option.detailTbl)
	{
		if (typeof(_option.detailTbl) == "string")
		{
			var __j = {};

			//__j.detailTbl = _option.detailTbl;
			__j.insertVml = _option.detailInsertVml;
			__j.updateVml = _option.detailUpdateVml;
			__j.queryVml = _option.detailQueryVml;
			__j.deleteVml = _option.detailDeleteVml;
			
			//_tJson.detail.push( __j );
			_tJson[ _option.detailTbl ] = __j;
		}
		else
		{
			for (var i = 0; i < _option.detailTbl.length; i++)
			{
				var __j = {};

				//__j.detailTbl = _option.detailTbl[i];
				__j.insertVml = _option.detailInsertVml[i];
				__j.updateVml = _option.detailUpdateVml[i];
				__j.queryVml = _option.detailQueryVml[i];
				__j.deleteVml = _option.detailDeleteVml[i];
				
				//_tJson.detail.push( __j );
				
				_tJson[ _option.detailTbl[i] ] = __j;
			}
		}
	}
	
	/*添加NDT配置信息*/
	var _tH = '<!-- 表单开始-->';
	var _nH = '<!-- 表单开始-->\n<script language="javascript">\n\tvar __saveNdtCfg = \'' + JsonToStr(_tJson) + '\';\n</script>';
	_html = _html.replace( _tH, _nH );
	_html = _html.replace( 'data-post="/code/files/uploadify.chi?param=upload&amp;', 'data-post="/ImageUploader.aspx?' );

	var path=fb_File.replaceAll('default.zfrm',_option.code);
	path = path.replaceAll(".chi", ".aspx");
	
	PostContent( FILE_URL, { param: 'save', path: path , cont: _html }, 'json',true,function()
	{
		window.open('/users/'+$('body').attr('developer')+'/'+path) ;
	},function()
	{
		var myWindow=window.open() ;
		myWindow.document.write(_html); 
		myWindow.focus();		
	});
}

function createOptionsNDTList(obj, _option, _html)
{
	var _vid = _option.jpListDml;
	if (_vid == null || _vid == '')
	{
		return;
	}

	var _url = "/Widget.aspx?param=jplist&vid=";
	_url += _vid;
		
	//InitList中添加Url
	var _start = _html.indexOf( 'InitList(' );
	var _end = 0;
	if (_start != -1)
	{
		_end = _html.indexOf( ');', _start);
		if (_end != -1 && _end > _start )
		{
			var _str = _html.substring(_start, _end);
			var _str2 = _str + ', "' + _url + '");';

			_html = _html.replace( _str + ');', _str2 );
		}
	}
	
	_html = __FormatNDTOptions( _option, _html );

	//删除按钮的替换
	//_tH = escape('#deleteNDT#');
	//_nH = escape('var __vmlId = "test_areadel_0001";\n#deleteNDT#');
	//_html = _html.replace( _tH, _nH );
	
	var path=fb_File.replaceAll('default.zfrm',_option.code);
	path = path.replaceAll("index.chi", _option.dcode + ".aspx");
	path = path.replaceAll(".chi", ".aspx");
	
	PostContent( FILE_URL, { param: 'save', path: path , cont: _html }, 'json',true,function()
	{
		window.open('/users/'+$('body').attr('developer')+'/'+path) ;
	},function()
	{
		var myWindow=window.open() ;
		myWindow.document.write(_html); 
		myWindow.focus();		
	});

	return;
}

function __FormatNDTOptions( _option, _html )
{
	//页头
	var _tH = '<!--%@ CodeFile="inc/' + _option.code + '.cn" %-->';
	var _nH = '<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Environment.aspx.cs" Inherits="OTMS.Environment" %>';
	_html = _html.replace( _tH, _nH );
	
	//包含文件
	_tH = '<!--#include file="../inc/css.txt"-->';
	_nH = '<!--#include file="/Controls/CSS.aspx"-->';
	_html = _html.replace( _tH, _nH );

	_tH = '<!--#include file="../inc/head.txt"-->';
	_nH = '<!--#include file="/Controls/header.aspx"-->';
	_html = _html.replace( _tH, _nH );

	_tH = '<!--#include file="../inc/footer.txt"-->';
	_nH = '<!--#include file="/Controls/footer.aspx"-->';
	_html = _html.replace( _tH, _nH );
	
	_tH = '<!--#include file="../inc/js.txt"-->';
	_nH = '<!--#include file="/Controls/JS.aspx"-->';
	_html = _html.replace( _tH, _nH );
	
	return _html;
}