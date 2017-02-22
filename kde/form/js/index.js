var _targetURL = '';
var initDiged = false;
var inittrDiged = false;
var cfg_toolbar = {};

function mask( text, id )
{
/*	$( "#dialog-waiting" ).dialog( {
		modal: true
	} );*/
}

$.sheet.preLoad( './' );

function unmask( id )
{
	//$( "#dialog-waiting" ).dialog( "close" );
}

function onResize()
{
//	$( '#sheetParent' ).css( 'top', $( '.toolbar' ).height()+5).width( $( window ).width() - 2 ).height( $( window ).height() - $( '.toolbar' ).height() + 10 );

//$('#sheetParent').width($(window).width()-2);
	//	$('#sheetParent').width($(window).width()-2).height($(window).height() - $('#menu').height()-$('nav').height()-10)
}

function getResourceKey(key){
	return __fbResArrayCN[key];
}		

$( function ()
{
	//国际化
	

	$( '[resource]' ).each( function ()
	{
		$( this ).text(getResourceKey($( this ).attr( 'resource' )));
	} );
	
	$('[title]').each(function(){
		$( this ).attr('title', getResourceKey($( this ).attr( 'title' )) );
	})
	
	document.title=getResourceKey('formbuilder');
	//国际化
	window.onresize = onResize;
	/*$( '#massagedialog' ).dialog( {
		autoOpen: false,//如果设置为true，则默认页面加载完毕后，就自动弹出对话框；相反则处理hidden状态。 
		bgiframe: true, //解决ie6中遮罩层盖不住select的问题  
		width: 300,
		title: 'message',
		resizable: false,
		modal: true,//这个就是遮罩效果   
		buttons: [{
			text:getResourceKey("Ok"),
			click: function ()
			{
				$( this ).dialog( "close" );
			}
		}]
	} );*/

	var tables = '';
	
	createTable( 10, 5, $( '#sheetParent' ) );
	$( ".toolbar .icons li.ui-state-default" ).hover(
		function ()
		{
			$( this ).addClass( "ui-state-hover" );
		},
		function ()
		{
			$( this ).removeClass( "ui-state-hover" );
		}
	);

	$( '.cpButton' ).colorpicker(
	{
		showOn: 'both',
		color: "#ffffff",
		displayIndicator: false,
		strings: "主题颜色,标准颜色,网页历史颜色"
	} )
	.on( 'change.color', function ( evt, color )
	{
		$( this ).parent().prev().find('.color').attr( 'style', 'background:' + color );
		$( this ).parent().parent().removeClass( "ui-state-hover" );
		var title = $( this ).parent().parent().attr( 'font-title' );
		var that = $( '#sheetParent' )[0];
		if ( 'Font Color' == title )
		{
			title = 'color';
		}
		else if ( 'Background Color' == title )
		{
			title = 'background-color';
		}
		else if ( 'border color' == title )
		{
			title = 'border-color';
		}
		that.jS.cellChangeStyle( title, color );
	} );
} );



function createTable( rowCount, cellCount, parent )
{
	if ( !parent ) parent = $( 'body' );

	$( parent ).html( '' );
	var table = $( '<table cellpadding="0" cellspacing="0" class="table"></table>' );
	var index = 0;
	for ( var i = 0; i < rowCount; i++ )
	{
		var tr = $( '<tr></tr>' );
		for ( var j = 0; j < cellCount; j++ )
		{
			var td = $( '<td></td>' );
			$( tr ).append( td );
		}
		$( table ).append( tr );
	}
	$( parent ).append( table );
	sheetOperation();
}


function sheetOperation( html )
{
	onResize();

	if ( html )
		$( '#sheetParent' ).html( '<table cellpadding="0" cellspacing="0" class="table">' + html + '</table>' );
	var sheetOrig = $( '#sheetParent' ).sheet( {
		menuLeft: function ()
		{
			var that = this;

			$( '#sheetParent,.iconsli a,#Menus a,.iconsli select,.menus div[onclick],.menu-item[onclick]' ).each( function ()
			{
				this.jS = that;
			} );

			return false;
		},
		sheetCellEdit: function ( e, jS, cell )
		{
			var fontfamily = cell.td.css( 'font-family' );
			fontfamily = fontfamily.split( ',' );
			var fontsize = cell.td.css( 'font-size' );
			var borderwidth = cell.td.css( 'border-width' );
			borderwidth = borderwidth.split( ' ' );
			var borderstyle = cell.td.css( 'border-style' );
			var fontcolor = cell.td.css( 'color' );
			var background = cell.td.css( 'background' );
			var bordercolor = cell.td.css( 'border-color' );
			var verticalalign = cell.td.css( 'vertical-align' );
			var cellType = cell.cellType;
			var tds = jS.highlighted();
			var className = cell.td[0].className;
			var colspan = cell.td.attr( 'colspan' );
			var rowspan = cell.td.attr( 'rowspan' );
			if ( parseInt( colspan ) > 1 || parseInt( rowspan ) > 1 )
			{
				$( '[title="Merge Cells"]' ).addClass( 'ui-state-select' );
			}
			else
			{
				$( '[title="Merge Cells"]' ).removeClass( 'ui-state-select' );
				$( 'div' ).removeClass( 'combobox-item-selected' );
				
			}

			var classNames = className.split( ' ' );

			var hasClass;
			$( '[set]' ).each( function ()
			{
				$( this ).removeClass( 'ui-state-select' );
				for ( var i = 0; i < classNames.length; i++ )
				{
					var hasClass = $( this ).attr( 'set' );
					if ( hasClass == classNames[i] )
					{
						$( this ).addClass( 'ui-state-select' );
					}
				}
			} );
			$( '[vertical-align]' ).each( function ()
			{
				$( this ).removeClass( 'ui-state-select' );

				var hasClass = $( this ).attr( 'vertical-align' );
				// hasClass = $( this ).className.match( className[i] );

				if ( hasClass == verticalalign )
				{
					$( this ).addClass( 'ui-state-select' );
				}
			} );
			//找到要改的容器	

	
			$( "select[showT='font-size']" ).next().find( '.textbox-text' ).val( fontsize );
			$( "select[showT='font-family']" ).next().find( '.textbox-text' ).val( fontfamily[0] );
			if(borderwidth.length > 1)
			$( "select[showT='border-Width']" ).next().find( '.textbox-text' ).val( borderwidth[2] );			
			else
			$( "select[showT='border-Width']" ).next().find( '.textbox-text' ).val( borderwidth );
			$( "select[showT='border-Style']" ).next().find( '.textbox-text' ).val( borderstyle );
			$( 'li[title="文字颜色"]' ).find( '.color' ).attr( 'style', 'background:' + fontcolor );
			$( 'li[title="背景颜色"]' ).find( '.color' ).attr( 'style', 'background:' + background );
			$( 'li[title="边框颜色"]' ).find( '.color' ).attr( 'style', 'background:' + bordercolor );
			var cell = '';
			if ( cellType == null )
			{
				cell = 'Remove Format';
			}
			else
			{
				cell = changeCase( cellType );
			}

			$( "select[showT='Format']" ).next().find( '.ui-selectmenu-text' ).text( cell );

		},
		formulaFunctions: {
			DATA: function ( arg )
			{
				//this = the parser's cell object object
				console.log( arg );
				return arg; //can return a string
				return { //can also return an object {value: '', html: ''}
					value: arg,
					html: $( 'What the end user will see on the cell this is called in' )
				}
			}
		}
	} );
	
	TDformula();
	
	/*$('.jSTdMenu').each(function(){
				console.log($(this).html() );
	})*/
}


function changeCase( str )
{
	var index;
	var tmpStr;
	var tmpChar;
	var preString;
	var postString;
	var strlen;
	tmpStr = str.toLowerCase();
	strLen = tmpStr.length;
	if ( strLen > 0 )
	{
		for ( index = 0; index < strLen; index++ )
		{
			if ( index == 0 )
			{
				tmpChar = tmpStr.substring( 0, 1 ).toUpperCase();
				postString = tmpStr.substring( 1, strLen );
				tmpStr = tmpChar + postString;
			}
			else
			{
				tmpChar = tmpStr.substring( index, index + 1 );
				if ( tmpChar == " " && index < ( strLen - 1 ) )
				{
					tmpChar = tmpStr.substring( index + 1, index + 2 ).toUpperCase();
					preString = tmpStr.substring( 0, index + 1 );
					postString = tmpStr.substring( index + 2, strLen );
					tmpStr = preString + tmpChar + postString;
				}
			}
		}
	}
	return tmpStr;
}


function TDformula()
{
	$( 'td[formula]' ).each( function ()
	{
		var that = $( '#sheetParent' );
		var cell = that.setCellFormula( $( this ).attr( 'formula' ), this.parentNode.rowIndex, this.cellIndex, 0 );
	} )
}


function settingrowatt1( js )
{


	$( ".tabsed" ).tabs( {
		disabled: [1],
		active: 0
	} );

	var that = js;
	if ( !initDiged )
	{

		initDiged = true;
		$( '#settingrowsattrdialog' ).dialog( {
			autoOpen: false,//如果设置为true，则默认页面加载完毕后，就自动弹出对话框；相反则处理hidden状态。 
			bgiframe: true, //解决ie6中遮罩层盖不住select的问题  
			width: 550,
			title: getResourceKey('data property'),
			resizable: false,
			modal: true,//这个就是遮罩效果   
			buttons: [{
				text:getResourceKey("Ok"),
				click: function ()
				{
					var _json = {}

					$( '#settingrowsattrdialog [data]' ).each( function ()
					{
						var type = $( this ).attr( 'fb-type' );
						var value = '';
						value = typechoiceget( type, this )
						if ( value )
						{

							_json[$( this ).attr( 'data' )] = value;
						}


					} );

					if ( _json )
					{
						var option = JSON.stringify( _json );
						option = option.replace( /"(\w+)":/g, "$1:" );
						that.settingrowsattr( 'fb-options', option,null,'{'+_json.codename+'}' );
					}
					
					
					
					$( this ).dialog( "close" );
				}},
				{text:getResourceKey("Cancel"),
				click: function ()
				{
					$( this ).dialog( "close" );
				}
			}]
		} );
	}
	var option = that.gettingrowsattr( 'fb-options' );

	if ( option )
	{

		var json = eval( "(" + option + ")" );

		if ( json['codetype'] )
		{
			settabs( json['codetype'], $( '#settingrowsattrdialog ' ) );
		}
		$( '#settingrowsattrdialog [data]' ).each( function ()
		{

			var data = $( this ).attr( 'data' );
			var type = $( this ).attr( 'fb-type' );
			if ( json.hasOwnProperty( data ) )
			{

				typechoiceset( type, json[data], $( this ) );
			}
			else
			{
				typechoiceset( type, '', $( this ) )
			}

		} )
	}
	else
	{
		settabs( '', $( '#settingrowsattrdialog ' ) );
		$( '#settingrowsattrdialog [data]' ).each( function ()
		{
			var type = $( this ).attr( 'fb-type' );
			typechoiceset( type, '', $( this ) );
		} );
	}
	
	$('#tabs-1 [name="conditionhiding"]').trigger('change');
	$( '#settingrowsattrdialog' ).dialog( "open" );

}
function signcss( style, value )
{
	$( '[' + style + ']' ).each( function ()
	{
		if ( $( this ).attr( style ) == value )
		{
			$( this ).addClass( 'ui-state-select' );
		}
		else
		{
			$( this ).removeClass( 'ui-state-select' );
		}

	} );
}
function sign( setClass, removeClass )
{
	$( '[set="' + setClass + '"]' ).each( function ()
	{
		if ( $( this ).hasClass( 'ui-state-select' ) )
		{
			$( this ).removeClass( 'ui-state-select' );
		}
		else
		{
			$( this ).addClass( 'ui-state-select' );
		}

	} )
	if ( removeClass )
	{
		var removeClasss = removeClass.split( ' ' )
		for ( var i = 0; i < removeClasss.length; i++ )
		{
			$( '[set="' + removeClasss[i] + '"]' ).removeClass( 'ui-state-select' );
		}
	}

}

function settingrowtratt1( js )
{
	var that = js;
	if ( !inittrDiged )
	{
		inittrDiged = true;
		$( '#settingrowsTRattrdialog ' ).find( '.tabsed' ).tabs( { selected: 0 } );
		$( '#settingrowsTRattrdialog' ).dialog( {
			autoOpen: false,//如果设置为true，则默认页面加载完毕后，就自动弹出对话框；相反则处理hidden状态。 
			bgiframe: true, //解决ie6中遮罩层盖不住select的问题  
			width: 300,
			title: 'data propertyTR',
			resizable: false,
			modal: true,//这个就是遮罩效果   
			buttons: [{
				text:getResourceKey("Ok"),
				click: function ()
				{
					var _json = {}
					$( '#settingrowsTRattrdialog [data]' ).each( function ()
					{
						var type = $( this ).attr( 'fb-type' );
						var data = $( this ).attr( 'data' );
						var value = '';
						value = typechoiceget( type, this );

						if ( value )
						{

							that.settingrowsTRattr( data, value );

						}
						else
						{

							that.settingrowsTRattr( data, '' );
						}

					} );

					$( this ).dialog( "close" );
				}},
				{text:getResourceKey("Cancel"),
				click: function ()
				{
					$( this ).dialog( "close" );
				}
			}]
		} );
	}

	$( '#settingrowsTRattrdialog [data]' ).each( function ()
	{

		var data = $( this ).attr( 'data' );
		var type = $( this ).attr( 'fb-type' );
		var option = that.gettingrowsTRattr( data );
		if ( option )
		{
			typechoiceset( type, option, $( this ) );
		}
		else
		{
			typechoiceset( type, '', $( this ) );
		}

	} )
	$( '#settingrowsTRattrdialog' ).dialog( "open" );
	initDiged = false;
}
function typechoiceset( type, value, obj )
{
	switch ( type )
	{
		case 'checkbox':{
			$( obj ).prop( 'checked', value );
			break;
		}
		case 'radio':{
			if( $( obj ).val()==value)
				$( obj ).prop( 'checked', true );
			else
				$( obj ).prop( 'checked', false );
			break;
			
		}
		default:{
			$( obj ).val( value );
			break;
		}
	}
}
function typechoiceget( type, obj ){
	switch ( type ){
		case 'checkbox':
			return $( obj ).prop( 'checked' );
		case 'radio':{
			if($( obj).prop( 'checked' ))
				return $( obj).val(); 
			else
				return '';
		}
		default:
			return $( obj ).val();
	}
}

function settabs( value, thistab )
{
	
	$( thistab ).find( 'div:eq(2)' ).html( '' );

	$( '[tabstow]' ).each( function ()
	{

		var tabstow = $( this ).attr( 'tabstow' );
		if(tabstow&&value){
			if ( tabstow.indexOf(value)>=0 )
			{
				$( thistab ).find( 'div:eq(2)' ).html( $( this ).html() );
				var $tabs = $( '.tabsed:eq(0)' ).tabs();
				$tabs.tabs( 'enable', 1 );
			}
		}
		
	} )
}

function merge( obj )//合并成功的单元格标记
{
	var jS = obj;
	var issuc = jS.merge();

	if ( issuc )
	{
		$( '[title="Merge Cells"]' ).addClass( 'ui-state-select' );
	}
}

/*********************************杨柳*************************************************/
/*
	descripton:
	设置下拉框，下拉内容的样式
*/
function formatItem(row)
{
	var s = '<div style="position:relative;top:15px;background:#000;width: 100%;height: '+ row.text +'"></div><br/>';
	return s;
}
function forborder(row)
{ 
	var s = '<div style="position:relative;top:15px;border-bottom:3px black '+ row.text +'"></div><br/>';
	return s;
}
function fontSize(row)
{
	var s = '<div style="font-size:'+ row.text +'">'+ row.text +'</div>';
	return s;
}
function FontFamily(row)
{
	var s = '<div style="height:5px;padding-top:3px;font-size:14px;font-family:'+ row.text +'">'+ row.text +'</div><br/>';
	return s;
}
/*
	end
*/
$(function()
{
	$('.iconsli .easyui-combobox').combo(
	{
		onChange:function(newValue, oldValue){
			var showt=$(this).attr('showt');			
			var that=this;
			if ( showt == 'Format' )
			{
				that.jS.cellTypeToggle( newValue );
			}
			else
			{
				that.jS.cellChangeStyle( showt, newValue );
			}
			if( showt == 'border-Type')
			{
				$('td.ui-state-highlight').attr('style',newValue);
			}
		}
	});
	//表格属性
	$('#comboProperty').combo(
	{
		onChange:function(newValue)
		{
			//$('.window-shadow').css('height','initial');
			$( '#controlProperty' ).html('');
			var controlProperty=$( '[tabstow*="'+newValue+'"]' );
			if(controlProperty.length==1){
				var html=controlProperty.html();
				$( '#controlProperty' ).html( html );
				$('#settingrowatt .easyui-tabs').tabs('enableTab', 1);
			}
			else
				$('#settingrowatt .easyui-tabs').tabs('disableTab', 1);
						
		}
	});
	//按条件隐藏
	$('#settingrowatt input[name="conditionhiding"]').change(function(){
		if($('#settingrowatt input[name="conditionhiding"]:checked').val()==2)
		{
			$('#settingrowatt input[name="conditionhidingcontent"]').prevAll('input').removeAttr('disabled');
		}
		else
		{
			$('#settingrowatt input[name="conditionhidingcontent"]').prevAll('input').val('');
			$('#settingrowatt input[name="conditionhidingcontent"]').prevAll('input').attr('disabled','disabled');
		}
		if($('#settingrowatt input[name="conditionhiding"]:checked').val()==0)
		{
			$('#show').show();
		}
		else
		{
			$('#show').hide();
		}
		
	} );
	//当前域信息配置为显示时 显示 只读，检索，排序
	
	//下拉类型控件 show hide 选择
	$('#controlProperty').change(function()
	{
		selectname();
	});
	
	$('.tabs-inner').click(function()
	{
		selectname();
	});
	function selectname()
	{
		var selectname = $('#controlProperty select[name="datasourcetype"]').val();
		
		if( selectname == 'list')
		{
			$('.cnt').hide();
		}
		else if( selectname == 'url')
		{
			$('.cnt').show();
			$('.dialog_url').hide();
		}
		else if( selectname == 'tree')
		{
			$('.cnt').hide();
			$('.prov').show();
		}
		else if ( selectname == 'vml' )
		{
		    $( '.cnt' ).show();
		}
	}
});

//判断下拉类型 控件中 数据联动 两个输入框 输入条件是否达到要求
function linkInput()
{
	var _linkfield = $('#controlProperty input[name="linkfield"]').val();
	var _linkcombo = $('#controlProperty input[name="linkcombo"]').val();
	if(_linkfield !='' && _linkcombo !=''){}
	else if(_linkfield =='' && _linkcombo ==''){}
	else
	{
		if(_linkfield == '')
		{
			alert('请填写数据联动字段!')
		}
		else if(_linkcombo == '')
		{
			alert('请填写数据联动父对象!')
		}
		$('#settingrowatt').dialog('open');
	}
}
function link( obj )
{
	var jS = obj;
	 $.messager.prompt('超链接', '请输入超链接', function(href){
		if (href){
		   var cell = ( ( jS.obj.tdActive()[0] || {} ).jSCell || {} ),
				args = [],
				doubleQuote = String.fromCharCode( 34 );

			if ( !href )
			{
				return false;
			}

			cell.calcLast = 0;
			args.push( doubleQuote + href + doubleQuote );

			if ( cell.value )
			{
				args.push( doubleQuote + cell.value + doubleQuote );
				cell.value = '';
			}

			cell.formula = 'HYPERLINK(' + args.join( ',' ) + ')';

			jS.setDirty( true );
			jS.calcDependencies.call( cell );
		}
	});

}

	
function saveProperty(dlgID,that){
	var data=$('#'+dlgID+' form').serializeObject();
	$('#'+dlgID).dialog('close');
	return JsonToStr(data);
}
//行属性
function settingrowtratt( that ){	
	var option=that.gettingrowsTRattr('fb-options');
	
	var box=$('#settingrowsTRattrdialog form');
	box[0].reset();
	if(option){
		var data = StrToJson(option);
		for(var key in data){
			var input=box.find('input[name="'+key+'"]');
			if(input.attr('type')=="checkbox"||input.attr('type')=="radio") {
				if(data[key])
					input[0].checked = true;
			}
			else
				input.val(data[key]);
		}
	}
	$('#settingrowsTRattrdialog').dialog({
		buttons:[{
				text:'确定',
				handler:function(){
					var option=saveProperty('settingrowsTRattrdialog',that);
					that.settingrowsTRattr( 'fb-options', option );
					var data = StrToJson(option);
					that.settingrowsTRattr( 'rowid', data.rowid );
					
				}
			},{
				text:'取消',
				handler:function(){$('#settingrowsTRattrdialog').dialog('close')}
			}]
	});
	$('#settingrowsTRattrdialog').dialog('open');
}

//单元格属性
function settingrowatt( that ){

	if(!$('#settingrowatt').attr('initDiged')){
		$('#settingrowatt').attr('initDiged',true);
		$('#settingrowatt').dialog({
			onOpen:function(){
				$('#tab_rowattr').tabs('disableTab', 1);
				$('#tab_rowattr').tabs('select',0);
				$('#settingrowatt textarea[name="conditionhidingcontent"]').attr('disabled','disabled');
				var option=that.gettingrowsattr('fb-options');	
				var box=$('#settingrowatt form');
				//box[0].reset();
				box.form('clear');
				box[0].reset();
				if(option){
				    var data = StringToJson( option );
				    if ( typeof ( data.vfy_textarea ) == 'undefined' )
				    {
				        $( '#settingrowatt textarea[name="vfy_textarea1"]' ).hide();
				    }
				    else
				    {
				        $( '#settingrowatt textarea[name="vfy_textarea1"]' ).show();
				    }
					$( '#controlProperty' ).html('');
					var controlProperty=$( '[tabstow="'+data.codetype+'"]' );
					if(controlProperty.length==1){
						$( '#controlProperty' ).html( controlProperty.html() );
						$('#tab_rowattr').tabs('enableTab', 1);
					};
					console.log(data);
					box.form('load',data);
				}
			},
			buttons:[{
					text:'确定',
					handler:function(){
						var option=saveProperty('settingrowatt',that);
						that.settingrowsattr( 'fb-options', option );
						linkInput();
					}
				},{
					text:'取消',
					handler:function(){$('#settingrowatt').dialog('close')}
				}]
		});
	}
	$('#settingrowatt').dialog('open');
}
//移除 radio
/* var tempradio= null;    
function check(checkedRadio)    
{    
	if(tempradio== checkedRadio){  
		tempradio.checked=false;  
		tempradio=null;  
		$('#show').hide();
	  }   
	   else{  
		    tempradio= checkedRadio;  
			$('#show').show();
		}  
 } */
 
/* toolbar 功能*/
 var _operationData=[];
 var _currentCode;
 
 function getToolbuttonsText( _name, _mode )
 {
	if (!_name)
	{
		_name = '';
	}
	if (!_mode)
	{
		_mode = '';
	}
	
	return _name + '(' + _mode + ')';
 }
 
 function initOpertaionToolbuttons(){
	for(var i=0;i<_operationData.length;i++){
		 $('#mm1').menu('appendItem', {
				text: getToolbuttonsText( _operationData[i].oname, _operationData[i].mode )/*,
				iconCls: 'icon-ok'*/
		});
	}
 }
 
 function addOpertaion(){
	_currentCode=null;
	$('#operationForm form').form('reset');	
	$('#operationForm').dialog('open');
 }
 
 
 function editOpertaion(item){
	var _name = '', _mode = '';
	_name = item.text.substr(0, item.text.indexOf('('));
	_mode = item.text.replace( _name, '' );
	_mode = _mode.replace( '(', '' );
	_mode = _mode.replace( ')', '' );

	_currentCode = getOpertaion( _name, _mode );
	if(_currentCode){
		$('#operationForm form').form('load',_currentCode);
		$('#operationForm').dialog('open');
	}
 }
  
 function getOpertaion(_name, _mode)
 {
	var data;

	for(var i=0;i<_operationData.length;i++)
	{
		if(_name == _operationData[i].oname && 
		   _mode == _operationData[i].mode )
		{
			data = _operationData[i];
			break;
		}
	}

	return data;
 }
 
function getOpertaionIndex(_name, _mode)
{
	var j=-1;

	for(var i=0;i<_operationData.length;i++)
	{
		if(_name == _operationData[i].oname && 
		   _mode == _operationData[i].mode )
		{
			j = i;
			break;
		}
	}

	return j;
 }
 
 function delOpertaionBtn()
 {
	if(_currentCode)
	{
		var i=getOpertaionIndex(_currentCode.oname, _currentCode.mode);
		if(i>=0)
		{
			var item = $('#mm1').menu('findItem', getToolbuttonsText( _currentCode.oname, _currentCode.mode ) );
			$('#mm1').menu('removeItem', item.target);		
			_operationData.splice(i,1);
		}
	}	
	$('#operationForm').dialog('close');	
 }

 function addOpertaionBtn(){
	var data=$('#operationForm form').serializeObject();

	//获取图片Src
	var oimg = $('img[name="oimg"]').attr('src');
	data.image = oimg;
	cfg_toolbar = data;

	//生成图片class
	var icon_sl = data.oname+1;

	if(_currentCode){
		var i=getOpertaionIndex(_currentCode.oname, _currentCode.mode);
		if(i>=0){
			/*
			if( data.oname == _currentCode.oname && 
				data.mode == _currentCode.mode )
			{
				if(getOpertaion( data.oname, data.mode)){
					alert('名称'+data.oname+'(' + data.mode + ')已经存在');
					return;
				}
			}
			*/
			_operationData[i] = data;
			var item = $('#mm1').menu('findItem', getToolbuttonsText( _currentCode.oname, _currentCode.mode ) );
			$('#mm1').menu('setText', {
				target:item.target,
				text: getToolbuttonsText( data.oname, data.mode )
			});			
		}
		else	
			return;
	}
	else {
		if(getOpertaion(data.oname, data.mode)){
			alert('名称'+data.oname+'(' + data.mode + ')已经存在');
			return;
		}
		else{
			_operationData.push(data);
			$('#mm1').menu('appendItem', {
				text: getToolbuttonsText( data.oname, data.mode ),
				iconCls: icon_sl
			});
		}
	}

	//给相应样式 增加图片地址
	$('.'+ icon_sl).css('background-image','url('+data.image+')');
	$('.'+ icon_sl).css('background-size',16+'px');

	$('#operationForm').dialog('close');
 }
 window.onload = function()
 {
	//下拉属性控件内 选择省市区 赋值给文本框
	$(".prov input[type='radio']").click(function()
	{
		var checked = $(this).val();
		$(".prov input").removeAttr("checked");
		$("input:radio[value='"+ checked +"']").attr("checked");
		var _data = "http://www.csdu.net/code/files/misc.chi?param=file&path=trend/"+ checked +".data";
		jsonAjax(_data);
		$('#controlProperty textarea[name="datasourcetsetting"]').val(_data);
	} );
 }

 function jsonAjax(data)
 {
	$.ajax(
	{
        async : false, 
        url : data,
        dataType : "json",
		type: "POST",
		success : function(data){
			var _datas = JSON.stringify(data.rows[0]);
			console.log(_datas[1]);
		}
	});	
 }
//校验选项
 function _vCheckbox( obj )
 {
     var _checked = $( obj ).is( ':checked' );
     var _tableObj = $( obj ).parent().parent().parent();

     if ( _checked )
     {
         if ( $( obj ).attr( 'name' ) == 'vfy_textarea' )
         {
             _tableObj.find( 'textarea[name="vfy_textarea1"]' ).show();
             _tableObj.find( 'input[type="checkbox"]' ).each( function ()
             {
                 $( this ).removeAttr( 'checked' );
                 $( this ).attr( 'disabled', 'disabled' );
             } );
             $( obj ).removeAttr( 'disabled' );
             $( obj ).prop( 'checked', 'checked' );
         }
     }
     else
     {
         _tableObj.find( 'textarea[name="vfy_textarea1"]' ).hide();
         _tableObj.find( 'input[type="checkbox"]' ).removeAttr( 'disabled' );
         $( obj ).removeAttr( 'checked' );
     }
 }