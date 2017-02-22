
function exportSheet(that ){
	var _ts = that.jS.tables();
	var data=_ts.html();
	var link = document.createElement("a");
	var si=fb_File.indexOf('/');
	var ei=fb_File.lastIndexOf('/');
	link.download = fb_File.substring(si+1,ei)+'.zfrm';
	link.href = "data:text/plain;base64," + btoa(unescape(encodeURIComponent(data)));
	document.body.appendChild(link);
	link.click();
	link.parentNode.removeChild(link);
}


function importSheet(that ){
	if(!that.input){
		that.input=document.createElement("input");
		that.input.type = "file";

		that.input.onchange = function(e) {
			var file = e.target.files[0];
			if (!file) { return; }

			var reader = new FileReader();
			reader.onload = function() { 
				sheetOperation( reader.result );
			//	console.log(reader.result);
			//	console.log(file.name) 
			}
			reader.onerror = function() { console.log(reader.error); }
			reader.readAsText(file);
		}.bind(this);
	}
	that.input.click();
}

function saveSheet(that )
{
	var _ts = that.jS.tables();
	//_ts.find('td:hidden').remove();
	var _t=_ts.html();
	if(fb_File){
		PostContent( FILE_URL, { param: 'save', path: fb_File , cont: _t }, 'json', true, function ( data )
		{
			TDformula();
			PostContent( FILE_URL, { param: 'save', path: fb_File+'.opt' , cont: JsonToStr(_operationData) }, 'json', true, function ( data )
			{
				
			})
		})
	}
}
		
function openSheet( that )
{
	if(fb_File){

		GetContent( FILE_URL, { param: 'file', path: fb_File }, 'html', true, function ( html )
					{
						if(html)
							sheetOperation( html );
							GetContent( FILE_URL, { param: 'file', path: fb_File+'.opt' }, 'json', true, function ( data ){
								_operationData = data;
								initOpertaionToolbuttons();
							})
					},function(){
					
					})
	}
}

function CreateToolbarConfig()
{
	var _hidden = true;
	var _toolbar = false;
	var _inlinebar = false;

	cfg_toolbar = {};
	cfg_toolbar.buttons = [];

	if (_operationData.length > 0)
	{
		_hidden = false;

		for (var i = 0; i < _operationData.length; i++)
		{
			var _operation = _operationData[i];
			if (_operation)
			{
				if (_operation.mode == "bar" && !_toolbar)
				{
					_toolbar = true;
				}
				if (_operation.mode == "inline" && !_inlinebar)
				{
					_inlinebar = true;
				}
				
				var _button = {};
				_button.name = _operation.oname;
				_button.type = _operation.type;
				_button.mode = _operation.mode;
				_button.handler = _operation.handler;
				_button.image = _operation.image;
				_button.scope = _operation.scope;
				_button.tips = _operation.tips;
				
				cfg_toolbar.buttons.push( _button );
			}
		}
	}
	
	cfg_toolbar.hidden = _hidden;
	cfg_toolbar.inline = _inlinebar;
	cfg_toolbar.toolbar = _toolbar;

	return;
}

function previewForm(obj){
	CreateToolbarConfig();

	var html='<!DOCTYPE html><html><head><title>编辑表单</title>\n'+
		'<link rel="stylesheet" href="/assets/plugins/bootstrap/css/bootstrap.min.css" >\n'+
		'<link rel="stylesheet" href="/assets/plugins/bootstrap/css/bootstrap-theme.min.css" >\n'+
		
		'<link rel="stylesheet" href="/assets/css/style.css">\n'+
		
		'<script src="/assets/js/jquery-1.10.2.min.js" type="text/javascript"></script>\n'+
		'<script src="/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>\n'+
		
		'<link href="/assets/plugins/bootstrap-fileinput/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />\n'+
        '<script src="/assets/plugins/bootstrap-fileinput/js/fileinput.js" type="text/javascript"></script>\n'+
		
		'<script src="/assets/js/common.js" type="text/javascript"></script>\n'+
		'<script src="/assets/plugins/laydate/laydate.js" type="text/javascript"></script>\n'+
		'<script src="/assets/js/droparea.js" type="text/javascript"></script>\n'+
		
		'<link href="/assets/plugins/DataTables-1.10.6/media/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />\n'+				
		'<link href="/assets/plugins/DataTables-1.10.6/extensions/bootstrap/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />\n'+
		'<link href="/assets/plugins/DataTables-1.10.6/extensions/ColVis/css/dataTables.colVis.css" rel="stylesheet" type="text/css" />\n'+	
		'<link href="/assets/plugins/DataTables-1.10.6/extensions/Responsive/css/dataTables.responsive.css" rel="stylesheet" type="text/css" />\n'+		
		'<script src="/assets/plugins/DataTables-1.10.6/media/js/jquery.dataTables.min.js" type="text/javascript"></script>\n'+
		'<script src="/assets/plugins/DataTables-1.10.6/extensions/Responsive/js/dataTables.responsive.min.js" type="text/javascript"></script>\n'+
		'<script src="/assets/plugins/DataTables-1.10.6/extensions/bootstrap/dataTables.bootstrap.js" type="text/javascript"></script>\n'+
		'<script src="/assets/plugins/DataTables-1.10.6/extensions/ColVis/js/dataTables.colVis.js" type="text/javascript"></script>\n'+		
		'<script src="/assets/plugins/DataTables-1.10.6/extensions/Scroller/js/dataTables.scroller.min.js" type="text/javascript"></script>\n'+	

		'<script src="/assets/plugins/jstree/dist/jstree.min.js" type="text/javascript"></script>\n'+
		'<link href="/assets/plugins/jstree/dist/themes/default/style.min.css" rel="stylesheet" type="text/css" />\n'+	
		
		'<script src="/assets/js/data-table-1.0.js" type="text/javascript"></script>\n'+
		'<script src="/assets/js/toolbar-1.0.js" type="text/javascript"></script>\n'+
		'<script src="/assets/js/form-calc-1.0.js" type="text/javascript"></script>\n' + 
		'<script src="/assets/js/table-form-data-1.0.js" type="text/javascript"></script>\n' + 
		'<script src="/assets/js/table-form-1.0.js" type="text/javascript"></script>\n' + 
		'<script src="/assets/js/verify-1.0.js" type="text/javascript"></script>\n'+		
		'<script src="/assets/js/template.js" type="text/javascript"></script>\n' +
		'<script src="/assets/js/table-form-workflow-1.0.js" type="text/javascript"></script>\n';
		
	if($(obj).attr("tag")=="2")
		html+='<script src="/assets/js/table-form-struct-1.0.js" type="text/javascript"></script>\n';
	
	html+='</head><body>\n';
	var code=fb_File.replace('/default.zfrm','');
	var i=code.indexOf('/');
	code=code.substring(i+1,code.length);
	var id=uuid();
	html+='<table class="FormTable" code="'+code+'" id="'+id+'"';
	if (!cfg_toolbar.hidden && cfg_toolbar.toolbar)
	{
		html += ' op-options="';
		html += escape(JsonToStr(cfg_toolbar));
		html += '"';
	}
	html += '>\n';
	html+=obj.jS.tables().html();
	html+='</table>\n<script>\nsetTimeout("';
	if($(obj).attr("tag")=="1")
		html+='initTableForm($(\'#'+id+'\'));';
	else if($(obj).attr("tag")=="2"){
		html+='makeStructs($(\'#'+id+'\'));';
	}
	html+='",100);\n</script>\n</body></html>';

	var path=fb_File.replace('.zfrm','_edit.html');
	PostContent( FILE_URL, { param: 'save', path: path , cont: html }, 'json',true,function(){
		window.open('/users/'+$('body').attr('developer')+'/'+path) ;
	},function(){		
		var myWindow=window.open() ;
		myWindow.document.write(html); 
		myWindow.focus();
	
	});
}

function makeTableTHead(table)
{
	var thead={};

	table.find('tr:not([rowid]) td[fb-options]').each(function()
	{
		var ostr = $(this).attr("fb-options");
		options = eval('(' + unescape(ostr) + ')');
		
		var _name='';
		if ( options.codename && 
			options.displayname && 
			options.codetype && 
			options.codetype !== "_button" )
		{
			_name=options.codename;
		}
		if(_name!=="")
		{
			var _head = {};
			_head.displayname = options.displayname;
			_head.searchable = (options.retrieve == 'on' ? true : false);
			_head.sortable = (options.sort == 'on' ? true : false);

			thead[_name] = _head;
		}
	});
	return thead;
}

function previewTable(obj){
	CreateToolbarConfig();

	var html='<!DOCTYPE html><html><head><title>数据表格</title>\n'+
		'<link rel="stylesheet" href="/assets/plugins/bootstrap/css/bootstrap.min.css" >\n'+
		'<link rel="stylesheet" href="/assets/plugins/bootstrap/css/bootstrap-theme.min.css" >\n'+	
		'<script src="/assets/js/jquery-1.10.2.min.js" type="text/javascript"></script>\n'+
		'<script src="/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>\n'+
		'<script src="/assets/js/common.js" type="text/javascript"></script>\n'+
		'<link href="/assets/plugins/DataTables-1.10.6/media/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />\n'+
		'<link href="/assets/plugins/DataTables-1.10.6/extensions/bootstrap/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />\n'+
		'<link href="/assets/plugins/DataTables-1.10.6/extensions/ColVis/css/dataTables.colVis.css" rel="stylesheet" type="text/css" />\n'+
		'<link href="/assets/plugins/DataTables-1.10.6/extensions/Responsive/css/dataTables.responsive.css" rel="stylesheet" type="text/css" />\n'+
		'<script src="/assets/plugins/DataTables-1.10.6/media/js/jquery.dataTables.min.js" type="text/javascript"></script>\n'+
		'<script src="/assets/plugins/DataTables-1.10.6/extensions/Responsive/js/dataTables.responsive.min.js" type="text/javascript"></script>\n'+
		'<script src="/assets/plugins/DataTables-1.10.6/extensions/bootstrap/dataTables.bootstrap.js" type="text/javascript"></script>\n'+
		'<script src="/assets/plugins/DataTables-1.10.6/extensions/ColVis/js/dataTables.colVis.js" type="text/javascript"></script>\n'+
		'<script src="/assets/plugins/DataTables-1.10.6/extensions/Scroller/js/dataTables.scroller.min.js" type="text/javascript"></script>\n'+

		'<script src="/assets/js/data-table-1.0.js" type="text/javascript"></script>\n'+
		'<script src="/assets/js/toolbar-1.0.js" type="text/javascript"></script>\n'+
		'<link rel="stylesheet" href="/assets/css/style.css">';

		html+='</head><body>';

		var code=fb_File.replace('/default.zfrm','');
		console.log(code);
		var i=code.indexOf('/');
		code=code.substring(i+1,code.length);
		var id=uuid();
		html+='<table class="table table-striped table-bordered hover" cellspacing="0" width="100%" code="'+code+'" id="'+id+'"';
		if (!cfg_toolbar.hidden && cfg_toolbar.toolbar)
		{
			html += ' op-options="';
			html += escape(JsonToStr(cfg_toolbar));
			html += '"';
		}
		html += '>\n';
		//html+=obj.jS.tables().html();
		var table=$('<table>'+obj.jS.tables().html()+'</table>\n');
		var thead=makeTableTHead(table);
		var head='';
		for(var key in thead){
			var _opt = {};
			_opt.searchable = thead[key].searchable;
			_opt.sortable = thead[key].sortable;
			
			var _opt_str = JsonToStr(_opt);
			_opt_str = escape(_opt_str);
			
			head+='<th fld="'+key.toLowerCase()+'" fb-options="' + _opt_str + '">'+thead[key].displayname+'</th>\n';
		}
		if (!cfg_toolbar.hidden && cfg_toolbar.inline)
		{
			head += '<th name="operate" op-options="';
			head += escape(JsonToStr(cfg_toolbar));
			head += '">操作</th>\n';
		}
		html+='<thead><tr><th fld="id"><input type="checkbox" onclick="checkDataAll(this)" /></th>'+head+'</tr></thead>\n';
		html+='</table>\n<script>\nsetTimeout("';
		html+='makeDataTableList($(\'#'+id+'\'), 1);';
		html+='",100);\n</script>\n</body></html>';
		
	
		var path=fb_File.replace('.zfrm','.html');
		PostContent( FILE_URL, { param: 'save', path: fb_File.replace('.zfrm','.head') , cont: head }, 'json',true,function(){
			
		});
		PostContent( FILE_URL, { param: 'save', path: path , cont: html }, 'json',true,function(){
			window.open('/users/'+$('body').attr('developer')+'/'+path) ;
		},function(){		
			var myWindow=window.open() ;
			myWindow.document.write(html); 
			myWindow.focus();
		
		});
}


function operations(){
	showModalWindow("数据集",'formOperation',450,500,function(){});
}


function showModalWindow(title, content, width, height,okF,DeleteF)
{
	var win;
	if(typeof(content)=="string")
		win=document.getElementById(content);
	else{
		win=document.createElement('div');
		$(win).html(content);
	}
	$(win).show();
	var buttons=[];
	if(DeleteF!=null){
		buttons.push({
			text:'删除',
			disabled:DeleteF==null,
			iconCls:'icon-delete',
			handler:function(){
				DeleteF();
				if(typeof(content)=="string")
					$(win).dialog('close');
				else
					$(win).dialog('destroy');
			}
		})
	}
	buttons.push({
			text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				if(typeof(content)=="string"){
					
					if(!$('#'+content+' form').form('validate')){
						alert('内容没有填写完整!');
						return;
					};			
				}
				if(okF&&okF()){
					if(typeof(content)=="string")
						$(win).dialog('close');
					else
						$(win).dialog('destroy');
				}
			}
		},{
			text:'取消',
			iconCls:'icon-cancel',
			handler:function(){
				if(typeof(content)=="string")
					$(win).dialog('close');
				else
					$(win).dialog('destroy');
			}
		});
	$(win).dialog({
		width: width,
		height: height,
		collapsible:true,
		//minimizable:true,
		//maximizable:true,
		//resizable:true,
		title:title,
		modal:true,
		buttons:buttons
	});
	$(win).dialog('open');
};

function generalHTMLHead(code,title){
	var html="<!--%@ CodeFile=\"inc/"+code+".cn\" %-->\n"+
				"<!doctype html>\n"+
				"<html>\n"+
				"<head>		\n"+
				"<title>"+title+"</title>\n"+
				"<meta charset=\"utf-8\" />\n"+
				"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />\n";
	return html;
}

function createList(obj){

	var code=fb_File.replace('/default.zfrm','');
	var i=code.indexOf('/');
	code=code.substring(i+1,code.length);
	var list = '';
	var html=generalHTMLHead('index','数据列表');
				
	var tag = $(obj).attr('tag');
	
	var FilterBox='';
	var SortFld='';
	
	var tHead='';
	var tBody='';
	if(tag==1){
		tHead='					<td style="width:35px;"><input type="checkbox" onclick="checkDataAll(this)"/></td>\n';
		tBody='					<td style="width:35px"><input type="checkbox" fld="id" value="{{$value.id}}"/></td>\n';
	}
	else if(tag==2){
		tHead='					<td style="width:35px;"></td>\n';
		tBody='					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>\n';
	}
	else{
		tHead='					<td style="width:35px;"></td>\n';
		tBody='					<td style="width:35px"><input type="radio" name="id" fld="id" value="{{$value.id}}"/></td>\n';
	}
	
	var table=$('<table>'+obj.jS.tables().html()+'</table>\n');
		
	var tdIndex = 0;
	table.find('tr:not([rowid]) td[fb-options]').each(function(){
		var ostr = $(this).attr("fb-options");

		options = eval('(' + unescape(ostr) + ')');
		
		if(options.displayname&&options.codename){
			tHead+='					<td class="title">'+options.displayname+'</td>\n';
			if((tag==2||tag==1)&&tdIndex==0){
				tBody+='					<td class="title" fld="'+options.codename+'"><a href="javascript:;" onclick="openBlank(\'edit.chi?id={{$value.id}}&rd=1\')">{{$value.'+options.codename+'}}</a></td>\n';
			}
			else
				tBody+='					<td class="title" fld="'+options.codename+'">{{$value.'+options.codename+'}}</td>\n';
			tdIndex++;
		}
		
		
		
		if(options.sort == 'on' ){
			if (options.codetype == "number"){
				SortFld+='						<li><span data-path="'+options.codename+'" data-order="asc" data-type="number">'+options.displayname+' A-Z</span></li>\n';
				SortFld+='						<li><span data-path="'+options.codename+'" data-order="desc" data-type="number">'+options.displayname+' Z-A</span></li>\n';					
			}
			else{					
				SortFld+='						<li><span data-path="'+options.codename+'" data-order="asc" data-type="text">'+options.displayname+' A-Z</span></li>\n';
				SortFld+='						<li><span data-path="'+options.codename+'" data-order="desc" data-type="text">'+options.displayname+' Z-A</span></li>\n';
			}
		}
		
		if(options.retrieve == 'on'){
			if(options.codetype == "text"){
				FilterBox+='\n				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">'+options.displayname+':</div><![endif]-->';
				FilterBox+='<input data-path="'+options.codename+'" '; 
				FilterBox+='data-button="#'+options.codename+'-search-button" ';
				FilterBox+='type="text" value="" placeholder="'+options.displayname+'" '; 
				FilterBox+='data-control-type="textbox" ';
				FilterBox+='data-control-name="'+options.codename+'" ';
				FilterBox+='data-control-action="filter" /> ';
									
				FilterBox+='<button type="button" id="'+options.codename+'-search-button">';
				FilterBox+='<i class="fa fa-search"></i>';
				FilterBox+='</button>';
				FilterBox+='</div>';
			}
			else if (options.codetype == "combobox"){
				FilterBox+='				<div class="jplist-drop-down" data-control-type="filter-drop-down" data-control-name="'+options.codename+'"	data-control-action="filter">';
				
				if(options.datasourcetype=="list"){
					FilterBox+='<ul><li><span data-path="default">'+(options.displayname?options.displayname:options.codename)+'</span></li>'; //在页面内获取数据
					var arrs = options.datasourcetsetting.split('\n');
					for (var i = 0; i < arrs.length; i++) {
						FilterBox+='<li><span data-path="'+arrs[i]+'">'+arrs[i] +'</span></li>';
					}	
				}
				else if(options.datasourcetype=="url"){
					FilterBox+='<ul options="'+escape(ostr)+'"><li><span data-path="default">'+(options.displayname?options.displayname:options.codename)+'</span></li>'; //在页面内获取数据
				}
				
				/*var options = $(this).find('select option');
				var len =options.length;
				for(var i=0;i<options.length;i++){
					FilterBox+='<li><span data-path="'+options[i].value+'">'+options[i].text +'</span></li>';
				}*/
				FilterBox+='</ul>';
				FilterBox+='</div>';
			}
		}
	});
		
		
	
	if(tag==1){

		if (_operationData.length > 0){
			tHead+='			<td class="title" title="操作">';
			tBody+='			<td class="title">\n';	
			for (var i = 0; i < _operationData.length; i++){
				var _operation = _operationData[i];
				if (_operation){
					if(_operation.scope=="grid"){
						if (_operation.mode == "bar"){
							tHead+='<button type="button" style="background-image: url(\''+_operation.image+'\')" title="'+_operation.tips+'" ev="'+escape(_operation.handler)+'"></button>';
						}
						if (_operation.mode == "inline"){
							tBody+='<button type="button" style="background-image: url(\''+_operation.image+'\')" title="'+_operation.tips+'" ev="'+escape(_operation.handler)+'"></button>';
						}
					}
				}
			}
			tHead+='</td>';
			tBody+='</td>';
		}
	}
		
		
	html+="</head>\n<body>\n";
	if(tag==2||tag==1){
		html+='\n<!--额外的css开始-->\n<!--#include file="../inc/css.txt"-->\n<!--额外的css结尾-->\n';
	}
	html+="\n<!-- 模板开始-->\n"+
				'<script id="jplist-template" type="text/x-template">\n'+
				'<div class="list-item box jplist-panel tabbtn">\n'+	
				'	<div class=""><!-- block right -->\n'+
				'		<table class="jptable">\n'+
				'			<thead>\n'+
				'				<tr class="trtitle">\n'+tHead+
				'				</tr>\n'+
				'			</thead>\n'+
				'			<tbody>\n'+				
				'			{{each data}}\n'+
                '				<tr>\n'+tBody+
				'				</tr>\n'+
				'			{{/each}}\n'+
				'			</tbody>\n'+
				'		</table>\n'+
				'	</div>\n'+
				'</div>\n'+
				'</script>\n<!-- 模板结尾 -->\n';

		html+="\n<!-- 通用对话框开始-->\n<div class=\"modal fade text-center\" id=\"win-Common-Dialog\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" aria-hidden=\"true\">\n"+
				"	<div class=\"modal-dialog modal-lg\">\n"+
				"		<div class=\"modal-content\">\n"+
				"			<div class=\"modal-body\">\n"+
				"				<div class=\"content\">\n"+
				"				</div>\n"+
				"			</div>\n"+
				"		</div>\n"+
				"	</div>\n"+
				"</div>\n<!-- 通用对话框结尾 -->\n";				
				
		list+="\n<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 演示开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->\n"+
			//	"<div class=\"box\">\n"+
			//	"	<div class=\"center\">\n"+
				"		<div id=\"demo\" class=\"box jplist\">\n"+
				"			<!-- 手机自适应按钮 -->\n"+
				"			<div class=\"jplist-ios-button\"><i class=\"fa fa-sort\"></i>操作</div>\n"+
				"			<!-- 操作面板 -->\n"+
				"			<div class=\"jplist-panel box panel-top min_height\">\n";
		if(tag==2||tag==1){
			list += "				<button type=\"button\" class=\"form_sub\" onclick=\"openBlank('edit.chi');\">新增&nbsp;<i class=\"glyphicon glyphicon-plus-sign\"></i></button>\n";
		}
				
		list += "				<button type=\"button\" class=\"jplist-reset-btn\" data-control-type=\"reset\" data-control-name=\"reset\" data-control-action=\"reset\">重置 &nbsp;<i class=\"fa fa-share\"></i></button>\n"+
				"				<div class=\"jplist-drop-down\" data-control-type=\"items-per-page-drop-down\" data-control-name=\"paging\" data-control-action=\"paging\">\n"+
				"					<ul>\n"+
				"						<li><span data-number=\"3\"> 每页 3 个项目 </span></li>\n"+
				"						<li><span data-number=\"5\"> 每页 5 个项目 </span></li>\n"+
				"						<li><span data-number=\"10\" data-default=\"true\"> 每页 10 个项目 </span></li>\n"+
				"						<li><span data-number=\"50\"> 每页 50 个项目 </span></li>\n"+
				"					</ul>\n"+
				"				</div>\n";
				
		SortFld ='						<li><span data-path="id" data-order="asc" data-type="number">排序</span></li>\n'+SortFld;
		SortFld ='				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">\n					<ul>\n'+SortFld+'					</ul>\n				</div>';
					
		list+=SortFld;
		list+=FilterBox;
		
		
		list+="\n				<!-- 分页结果 -->\n"+
		"				<div class=\"jplist-label\" data-type=\"第 {current} 页共 {pages} 页\" data-control-type=\"pagination-info\" data-control-name=\"paging\" data-control-action=\"paging\"></div>\n"+

		"				<!-- 分页操作 -->\n"+
		"				<div class=\"jplist-pagination\" data-control-type=\"pagination\" data-control-name=\"paging\" data-control-action=\"paging\"></div>\n"+

		"				<!-- 加载数据时显示 -->\n"+
		"				<div class=\"jplist-hide-preloader jplist-preloader\" data-control-type=\"preloader\" data-control-name=\"preloader\" data-control-action=\"preloader\">"+
		"<img src=\"/assets/plugins/jpList-master/img/common/ajax-loader-line.gif\" alt=\"加载中...\" title=\"加载中...\" /></div>\n";
		
		list+='			</div>\n';
		
		list+="			<div style=\"min-height:300px;\">\n				<!-- 异步加载内容 -->\n"+
			"				<div class=\"list box text-shadow\"></div>\n"+
			"				<!-- no result found -->\n"+
			"				<div class=\"text-pos box jplist-no-results text-shadow align-center jplist-hidden\">\n"+
			"					<p>没有数据</p>\n"+
			"				</div>\n"+
			"			</div>\n";
		if(tag==1){
			list +="			<!-- 手机自适应按钮 -->\n"+
			"			<div class=\"jplist-ios-button\"><i class=\"fa fa-sort\"></i>操作</div>\n"+
			"			<!-- 操作面板 -->\n"+
			"			<div class=\"jplist-panel box panel-bottom\" style=\"margin: 0 0 20px 0\">\n";
		
			list += "				<button type=\"button\" class=\"form_sub\" onclick=\"openBlank('edit.chi');\">新增&nbsp;<i class=\"glyphicon glyphicon-plus-sign\"></i></button>\n";
		
		
			list +="				<div class=\"jplist-drop-down left\" data-control-type=\"items-per-page-drop-down\"	data-control-name=\"paging\"	data-control-action=\"paging\""+
				" data-control-animate-to-top=\"true\">\n"+
				"					<ul>\n"+
				"						<li><span data-number=\"3\"> 每页 3 个项目 </span></li>\n"+
				"						<li><span data-number=\"5\"> 每页 5 个项目 </span></li>\n"+
				"						<li><span data-number=\"10\" data-default=\"true\"> 每页 10 个项目 </span></li>\n"+
				"						<li><span data-number=\"50\"> 每页 50 个项目 </span></li>\n"+
				"					</ul>\n"+
				"				</div>\n"+
			
			SortFld+

				"			\n				<!-- 分页结果 -->\n"+
				"				<div class=\"jplist-label\"	data-type=\"{start} - {end} / {all}\" data-control-type=\"pagination-info\"	data-control-name=\"paging\" data-control-action=\"paging\"></div>\n";
				
				list+="				<!-- 分页操作 -->\n"+
				"				<div class=\"jplist-pagination\" data-control-type=\"pagination\" data-control-name=\"paging\"	data-control-action=\"paging\" data-control-animate-to-top=\"true\"></div>\n"+
				"</div>\n";
		}
			list+="		</div>\n"+

			"<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 演示结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				\n"+
			"<div class=\"clear\"></div>\n";
			if(tag==2||tag==1){
				html+='\n<!--通用头部文件开始-->\n'+
				'<!--#include file="../inc/head.txt"-->\n'+
				'<!--通用头部文件结尾-->\n';
				if(tag==1){
					html+="\n<div class=\"pos margin40\">\n"+					
						"	<ul class=\"breadcrumb pull-left\">\n"+
						"		<li><a href=\"#\">首页</a> <!--<span class=\"divider\">/</span>--></li>\n"+
						"		<li><a href=\"#\">数据管理</a> <!--<span class=\"divider\">/</span>--></li>\n"+
						"		<li class=\"active\">数据列表</li>\n"+		
						"	</ul>\n"+
				
						"	<!-- 流程通用切换标签 -->\n"+
						"	<ul class=\"nav nav-tabs pull-right\" role=\"tablist\">\n"+
						"		<li role=\"presentation\"><a href=\"?opt=2\" role=\"2\">我的草稿</a></li>\n"+
						"		<li role=\"presentation\"><a href=\"?opt=1\" role=\"1\">我的送审</a></li>\n"+
						"		<li role=\"presentation\" class=\"active\"><a href=\"?opt=4\" role=\"4\">已完成</a></li>\n"+
						"	</ul>\n</div>\n"+list;
				}
				else
					html+=list;
				html+='\n<!--通用页尾开始-->\n'+
				'<!--#include file="../inc/footer.txt"-->\n'+
				'<!--通用页尾结尾-->\n';
			}
			else
				html+=list;
			
			html+='\n<script type="text/javascript">\n'+
				'	var reqeustDone = function(){		/*所有JS加载完成以后执行*/\n'+
				'		//initHeader();					/*初始化页面通用头部*/\n'+
				'		//initFooter();					/*初始化页面通用底部*/\n'+
				'		InitList($("#demo"),$("#demo .list"),$("#jplist-template").html(),"'+code+'");\n'+
				'	}\n'+
			'</script>\n'+
			'<script src="/assets/request_list.js"></script>\n';
			if(tag==2||tag==1){
				html+='\n<!--其他JS开始-->\n'+
				'<!--#include file="../inc/js.txt"-->\n'+
				'<!--其他JS结尾-->\n';
			}
			html+="\n</body>\n"+
			"</html>";

			var path='';
			if(true||tag==1||tag==2){
				path=fb_File.replaceAll('default.zfrm','index.chi');
			}
			else{
				path=fb_File.replaceAll('default.zfrm','select.chi');
			}
			PostContent( FILE_URL, { param: 'save', path: path , cont: html }, 'json',true,function(){
				window.open('/users/'+$('body').attr('developer')+'/'+path) ;
			},function(){		
				var myWindow=window.open() ;
				myWindow.document.write(html); 
				myWindow.focus();
			
			});
			
}


function createEditForm(obj){
		var html=generalHTMLHead('index','数据编辑');
			
		var code=fb_File.replace('/default.zfrm','');
		var _tag=$(obj).attr("tag");
		if(_tag=="3")
			code=fb_File.replace('/default.zfrm','');
		var i=code.indexOf('/');
		code=code.substring(i+1,code.length);
		
		var tid=uuid();
		if(_tag=="1")
			html+='</head>\n<body workflow="1">\n';
		else	
			html+='</head>\n<body>\n';
	//	html+='\n<!--额外的css开始-->\n<!--#include file="../inc/css.txt"-->\n<!--额外的css结尾-->\n';
		
		var _extButtons='';
		if (_operationData.length > 0){
			for (var i = 0; i < _operationData.length; i++){
				var _operation = _operationData[i];
				if (_operation){
					if (_operation.scope=="form"&&_operation.mode == "bar"){
						_extButtons+='<a class="btn btn-red" href="javascript:void(0);" ev="'+escape(_operation.handler)+'">'+_operation.tips+'</a>\n';
					}					
				}
			}
		}
		
		var toolbarHtml='';
		if(_tag=="1"||_tag=="4"){
			toolbarHtml+="\n<!--工具栏开始-->\n<div class=\"toolbar\">\n"+
						"	<div style=\"text-align:right;\" class=\"button_workflow\">\n"+_extButtons;
			if(_tag=="1")
				toolbarHtml+='		<a class="btn btn-red" href="javascript:void(0);" style="display:none;" id="_WorkFlowTimeLine" onclick="changeDisplayPanel([\'.formcontainer\',\'.workflowcontainer\'])">流程</a>\n';
			toolbarHtml+='		<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($(\'#'+tid+'\'))">打印</a>\n'+
						'		<a class="btn btn-red" href="javascript:void(0);" onclick="closeForm(this)">关闭</a>\n'+
						"	</div>\n"+
						"	<div class=\"clear\"></div>\n"+
						"	<div class=\"content_workflow\"></div>\n"+
						"</div>\n<!--工具栏结尾-->\n";
		}
		

		html+="\n<!-- 通用对话框开始-->\n<div class=\"modal fade text-center\" id=\"win-Common-Dialog\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" aria-hidden=\"true\" style=\" display:none;\">\n"+
				"	<div class=\"modal-dialog modal-lg\" style=\"display: inline-block; width: auto;\">\n"+
				"		<div class=\"modal-content\">\n"+
				"			<div class=\"modal-body\">\n"+
				"				<div>\n"+
				"					<button type=\"button\" class=\"btn btn-default pull-right\" data-dismiss=\"modal\" aria-label=\"Close\" title=\"关闭\"><span aria-hidden=\"true\" class=\"glyphicon glyphicon-remove-circle\"></span></button>\n"+
				"					<button type=\"button\" class=\"btn btn-default pull-right okButton\" style=\"margin-right:10px;\" aria-label=\"OK\" title=\"确定\"><span aria-hidden=\"true\" class=\"glyphicon glyphicon-ok-circle\"></span></button>\n"+
				"				</div>\n"+
				"				<div class=\"content\">\n"+
				"				</div>\n"+
				"			</div>\n"+
				"		</div>\n"+
				"	</div>\n"+
				"</div>\n<!-- 通用对话框结尾 -->\n";

		
		/*html+='\n<!--通用头部文件开始-->\n'+
				'<!--#include file="../inc/head.txt"-->\n'+
				'<!--通用头部文件结尾-->\n';*/
		var _tableHtml=MakeTableFormOptions('<table>'+obj.jS.tables().html()+'</table>',toolbarHtml);
		var _cols = obj.jS.tables().find('colgroup col');
		var _tableWidth = 0;
		_cols.each(function(){
			_tableWidth+=$(this).width();
		})

		html+='\n<div class="formcontainer" style="display:none;">\n';
		html+='\n<!-- 表单开始-->\n<table class="FormTable" style="width:'+_tableWidth+'px;" id="'+tid+'" code="'+code+'">\n';

		html+=_tableHtml;
		html+='</table>\n<!-- 表单结尾 -->\n';
		
		if(_tag=="1"){
			html+='\n	<!-- 流程操作面板开始-->\n	<div class="content_workflow">\n		<label style="display:none;"><input type="radio" name="agree" value=0 checked="checked"/>同意</label>\n		<label style="display:none;"><input type="radio" name="agree" value=1 />不同意</label>';
			html+='\n		<textarea name="content" data-provide="markdown" rows="10" class="form-control"></textarea>\n	</div>\n	<!-- 流程操作面板结尾 -->\n';
			html+='</div>\n';
			html+='\n<!-- 流程日志开始-->\n<div class="workflowcontainer" title="流程" style="display:none;">\n'+
				"	<ul class=\"timeline\">\n"+
				' 		{{each rows}}\n'+
				'			{{if $index%2 == 0}}\n'+
				"				<li>\n"+			
				'			{{else}}\n'+
				"				<li class=\"timeline-inverted\">\n"+
				'			{{/if}}\n'+
				"					<div class=\"tl-circ\"></div>\n"+	
				"					<div class=\"timeline-panel\">\n"+
				"						<div class=\"tl-heading\">\n"+
				"							<h4>{{$value.username}}</h4>\n"+
				"							<p><small class=\"text-muted\"><i class=\"glyphicon glyphicon-time\"></i>{{$value.time}}</small></p>\n"+
				"						</div>\n"+
				"						<div class=\"tl-body\">\n"+
				"							<p>{{$value.content}}</p>\n"+
				"						</div>\n"+
				"					</div>\n"+
				"				</li>\n"+
				'		{{/each}}\n'+
			'	</ul>\n	<div class="WorkFlowPhoto" title="流程"></div>\n</div>\n<!-- 流程日志结尾 -->\n';
		}	
		
		html+='\n<script type="text/javascript">\n'+
			  '	var reqeustDone = function(){		 /*所有JS加载完成以后执行*/\n';

		if(_tag=="2"){
			html+='		loadJS("/assets/js/table-form-struct-1.0.js",function(){\n';
			html+='				setTimeout("makeStructs($(\'#'+tid+'\'))",300);\n';
			html+='		});\n';
		}
		else if(_tag=="3"){
			html+='		setTimeout("initTableForm($(\'#'+tid+'\'),true,function(){printTable($(\'#'+tid+'\'))})",300);\n';
		}
		else{
			html+='		setTimeout("initTableForm($(\'#' + tid + '\'))",300);\n';
		}
		html+='	}\n</script>\n';
		html+='<script src="/assets/request_form.js"></script>\n';

		html+='\n</body>\n</html>';

		var path=fb_File.replaceAll('default.zfrm','edit.chi');
		if(_tag=="3")
			path=fb_File.replaceAll('default.zfrm','print.chi');
		PostContent( FILE_URL, { param: 'save', path: path , cont: html }, 'json',true,function(){
				window.open('/users/'+$('body').attr('developer')+'/'+path) ;
			},function(){		
				var myWindow=window.open() ;
				myWindow.document.write(html); 
				myWindow.focus();
			
		});
}

function createDataTableList(obj){
	var _tableHtml='<table>'+obj.jS.tables().html()+'</table>';
	var table=$(_tableHtml);
	table.find('td[fb-options]').each(function(){
		if($(this).css('display')=="none"){
			$(this).removeAttr('fb-options');
		}
	});
	
	
	table.find('td[fb-options]').each(function() {	
	    var eHtml = MakeEditorFromOption( this, _readOnly );
		if(eHtml)
			$(this).html(eHtml);
	} );
	console.log(_tableHtml);
}

