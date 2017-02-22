
function createOnlyList(obj,_option){
	var FilterBox='';
	var SortFld='';
	
	var tHead='';
	var tBody='';
	tHead='					<td style="width:35px;"></td>\n';
	tBody='					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>\n';
	
	var table=$('<table>'+obj.jS.tables().html()+'</table>\n');
		
	var tdIndex = 0;
	table.find('tr:not([rowid]) td[fb-options]').each(function(){
		var ostr = $(this).attr("fb-options");

		options = eval('(' + unescape(ostr) + ')');
		
		if(options.displayname&&options.codename){
			tHead+='					<td class="title">'+options.displayname+'</td>\n';
			if(_option.dataButton==1&&tdIndex==0){
				tBody+='					<td class="title" fld="'+options.codename+'"><a href="javascript:;" onclick="openBlank(\'{{$value.id}}\')">{{$value.'+options.codename+'}}</a></td>\n';
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
		
		
	
	if(_option.dataButton==1){

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
	var	html="\n<!-- 模板开始-->\n"+
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
	
				
	var list="\n<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->\n"+
			//	"<div class=\"box\">\n"+
			//	"	<div class=\"center\">\n"+
				"		<div id=\"demo\" class=\"box jplist\">\n"+
				"			<!-- 手机自适应按钮 -->\n"+
				"			<div class=\"jplist-ios-button\"><i class=\"fa fa-sort\"></i>操作</div>\n"+
				"			<!-- 操作面板 -->\n"+
				"			<div class=\"jplist-panel box panel-top min_height\">\n";
		if(_option.dataButton==1){
			list += "				<button type=\"button\" class=\"form_sub\" onclick=\"openBlank();\">新增&nbsp;<i class=\"glyphicon glyphicon-plus-sign\"></i></button>\n";
			list += "				<button type=\"button\" class=\"jplist-reset-btn\" data-control-type=\"reset\" data-control-name=\"reset\" data-control-action=\"reset\">重置 &nbsp;<i class=\"fa fa-share\"></i></button>\n";
		
		}
				
		if(_option.datanavUp==1){
			list += "				<div class=\"jplist-drop-down\" data-control-type=\"items-per-page-drop-down\" data-control-name=\"paging\" data-control-action=\"paging\">\n"+
				"					<ul>\n"+
				"						<li><span data-number=\"3\"> 每页 3 个项目 </span></li>\n"+
				"						<li><span data-number=\"5\"> 每页 5 个项目 </span></li>\n"+
				"						<li><span data-number=\"10\" data-default=\"true\"> 每页 10 个项目 </span></li>\n"+
				"						<li><span data-number=\"50\"> 每页 50 个项目 </span></li>\n"+
				"					</ul>\n"+
				"				</div>\n";
		}
				
		SortFld ='						<li><span data-path="id" data-order="asc" data-type="number">排序</span></li>\n'+SortFld;
		SortFld ='				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">\n					<ul>\n'+SortFld+'					</ul>\n				</div>';
					
		list+=SortFld;
		var _sts='0';
		if(_option.workflow=="1")_sts="1";
		
		list+='\n			<div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="'+_sts+'" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>';
		list+='<button type="button" id="opt_status-search-button"></button></div>';
			
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
		if(_option.datanavDown==1){
			list +="			<!-- 手机自适应按钮 -->\n"+
			"			<div class=\"jplist-ios-button\"><i class=\"fa fa-sort\"></i>操作</div>\n"+
			"			<!-- 操作面板 -->\n"+
			"			<div class=\"jplist-panel box panel-bottom\" style=\"margin: 0 0 20px 0\">\n";
		
			list += "				<button type=\"button\" class=\"form_sub\" onclick=\"openBlank();\">新增&nbsp;<i class=\"glyphicon glyphicon-plus-sign\"></i></button>\n";
		
		
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
				"			</div>\n";
		}
		list+="		</div>\n"+
		"		<div class=\"clear\"></div>\n"+
		"<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				\n";

	return html+list;	
}


function createOnlyForm(obj,_option){

	var _extButtons='';
	if (_option.dataButton==1 && _operationData.length > 0){
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
	if(_option.dataButton==1){
		toolbarHtml+="\n<!--工具栏开始-->\n<div class=\"toolbar\">\n"+
					"	<div style=\"text-align:right;\" class=\"button_workflow\">\n"+_extButtons;
		if(_option.workflow=="1")
			toolbarHtml+='		<a class="btn btn-red" href="javascript:void(0);" style="display:none;" id="_WorkFlowTimeLine" onclick="changeDisplayPanel([\'.formcontainer\',\'.workflowcontainer\'])">流程</a>\n';
		toolbarHtml+='		<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($(\'#'+_option.tid+'\'))">打印</a>\n'+
					'		<a class="btn btn-red" href="javascript:void(0);" onclick="closeForm(this)">关闭</a>\n'+
					"	</div>\n"+
					"	<div class=\"clear\"></div>\n"+
					"	<div class=\"content_workflow\"></div>\n"+
					"</div>\n<!--工具栏结尾-->\n";
	}
	
	var _tableHtml=MakeTableFormOptions('<table>'+obj.jS.tables().html()+'</table>',toolbarHtml);
	var _cols = obj.jS.tables().find('colgroup col');
	var _tableWidth = 0;
	_cols.each(function(){
		_tableWidth+=$(this).width();
	})

	var html = '\n<div class="formcontainer" style="display:none;">\n';//' + _tableWidth + 'px
	html += '<!-- 表单开始-->\n <table class="FormTable Y_alter" style="width:' + _tableWidth + 'px;" id="' + _option.tid + '" path="' + _option.opath + '" code="' + _option.dcode + '">';

	html+=_tableHtml;
	html+=' </table>\n<!-- 表单结尾 -->\n';
	
	if(_option.workflow=="1"){
		html+='\n	<!-- 流程操作面板开始-->\n	<div class="content_workflow">\n		<label style="display:none;"><input type="radio" name="agree" value=0 checked="checked"/>同意</label>\n		<label style="display:none;"><input type="radio" name="agree" value=1 />不同意</label>';
		html+='\n		<textarea name="content" data-provide="markdown" rows="10" class="form-control"></textarea>\n	</div>\n	<!-- 流程操作面板结尾 -->\n';
		html+='</div>\n';
		html+='\n<!-- 流程日志开始-->\n<div class="workflowcontainer" title="流程" style="display:none;">\n'+
			'	<div style=\"text-align:right;\" class=\"button_workflow\">\n'+
			'		<a class="btn btn-red" href="javascript:void(0);" onclick="changeDisplayPanel([\'.formcontainer\',\'.workflowcontainer\'])">查看表单</a>\n'+
			'	</div>\n'+
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
	else
		html+='</div>\n';
	return html;	
}

function _DoCreateOptionsHtml(obj, _option)
{
	var code=fb_File.replace('/default.zfrm','');
	var i=code.indexOf('/');
	_option.opath=code;
	_option.dcode=code.substring(i+1,code.length);
	_option.tid=uuid();
	var html=generalHTMLHead(_option.code,_option.title);
	html+='</head>\n';
	if(_option.workflow=="1")
		html+='<body code="'+_option.dcode+'" workflow="1">\n';
	else
		html+='<body code="'+_option.dcode+'">';
	if(_option.inc=="1")
	html+='\n<!--额外的css开始-->\n<!--#include file="../inc/css.txt"-->\n<!--额外的css结尾-->\n';
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
	if(_option.inc=="1")			
		html+='\n<!--通用头部文件开始-->\n<!--#include file="../inc/head.txt"-->\n<!--通用头部文件结尾-->\n';
	
	if(_option.workflow=="1"){
		/*html+="\n<div class=\"pos margin40\">\n"+					
					"	<ul class=\"breadcrumb pull-left\">\n"+
					"		<li><a href=\"#\">首页</a> <!--<span class=\"divider\">/</span>--></li>\n"+
					"		<li><a href=\"#\">数据管理</a> <!--<span class=\"divider\">/</span>--></li>\n"+
					"		<li class=\"active\">"+_option.title+"</li>\n"+		
					"	</ul>\n"+
			
					"	<!-- 流程通用切换标签 -->\n"+
					"	<ul class=\"nav nav-tabs pull-right\" role=\"tablist\">\n"+
					"		<li role=\"presentation\"><a href=\"?opt=2\" role=\"2\">我的草稿</a></li>\n"+
					"		<li role=\"presentation\"><a href=\"?opt=1\" role=\"1\">我的送审</a></li>\n"+
					"		<li role=\"presentation\" class=\"active\"><a href=\"?opt=4\" role=\"4\">已完成</a></li>\n"+
					"	</ul>\n</div>\n";*/
	}
		
	if(_option.datalist=="1")
		html += createOnlyList(obj,_option);
	if(_option.form=="1")
		html += createOnlyForm(obj,_option);
	if(_option.inc=="1"){
		html+='\n<!--通用页尾开始-->\n'+
			'<!--#include file="../inc/footer.txt"-->\n'+
			'<!--通用页尾结尾-->\n';
	}
	
	if(_option.initData=="1"&&_option.initForm=="1"){
		html+='\n<script type="text/javascript">\n'+
			'	var reqeustDone = function(){		/*所有JS加载完成以后执行*/\n'+
			'		if ( typeof(initHeader) != "undefined" ) initHeader();					/*初始化页面通用头部*/\n'+
			'		if ( typeof(initFooter) != "undefined" ) initFooter();					/*初始化页面通用底部*/\n'+
			'		InitList($("#demo"),$("#demo .list"),$("#jplist-template").html(),"'+_option.dcode+'");\n'+
			'	}\n'+
		'</script>\n'+
		'<script src="/assets/request.js"></script>\n';
		if(_option.inc=="1"){
			html+='\n<!--其他JS开始-->\n'+
			'<!--#include file="../inc/js.txt"-->\n'+
			'<!--其他JS结尾-->\n';
		}
	}
	else if(_option.initData=="1"){
		html+='\n<script type="text/javascript">\n'+
			'	var reqeustDone = function(){		/*所有JS加载完成以后执行*/\n'+
			'		if ( typeof(initHeader) != "undefined" ) initHeader();					/*初始化页面通用头部*/\n'+
			'		if ( typeof(initFooter) != "undefined" ) initFooter();					/*初始化页面通用底部*/\n'+
			'		InitList($("#demo"),$("#demo .list"),$("#jplist-template").html(),"'+_option.dcode+'");\n'+
			'	}\n'+
		'</script>\n'+
		'<script src="/assets/request_list.js"></script>\n';
		if(_option.inc=="1"){
			html+='\n<!--其他JS开始-->\n'+
			'<!--#include file="../inc/js.txt"-->\n'+
			'<!--其他JS结尾-->\n';
		}
	}
	else if(_option.initForm=="1"){
		html+='\n<script type="text/javascript">\n'+
			'	var reqeustDone = function(){		/*所有JS加载完成以后执行*/\n'+
			'		setTimeout("initTableForm($(\'#' + _option.tid + '\'))",300);\n'+
			'	}\n'+
		'</script>\n'+
		'<script src="/assets/request_form.js"></script>\n';
		if(_option.inc=="1"){
			html+='\n<!--其他JS开始-->\n'+
			'<!--#include file="../inc/js.txt"-->\n'+
			'<!--其他JS结尾-->\n';
		}
	}
	else{
		html+='\n<script type="text/javascript">\n'+
			'	var reqeustDone = function(){		/*所有JS加载完成以后执行*/\n'+
			'		if ( typeof(initHeader) != "undefined" ) initHeader();					/*初始化页面通用头部*/\n'+
			'		if ( typeof(initFooter) != "undefined" ) initFooter();					/*初始化页面通用底部*/\n'+
			'	}\n'+
		'</script>\n'+
		'<script src="/assets/request_mini.js"></script>\n';
		if(_option.inc=="1"){
			html+='\n<!--其他JS开始-->\n'+
			'<!--#include file="../inc/js.txt"-->\n'+
			'<!--其他JS结尾-->\n';
		}
	}
	html+='</body>\n</html>';
	
	return html;
}

function createOptions(obj)
{
	var _height = 410;

	//判断是否有从表，自动处理对话框中的从表VML配置框
	obj.jS.tables().find('[rowid]').each(function()
	{
		var _tblName = $(this).attr("rowid");
		if (_tblName)
		{
			_OptionsCfgUI(_tblName);
			
			_height += 30;
		}
	});

	showModalWindow("生成选项",'createOptions',590, _height,function(){
		var _option=$('#createOptions form').serializeObject();
		var _html = _DoCreateOptionsHtml(obj, _option);

		if (_option.ndtOptions == "1")
		{
			//action2.js
			createOptionsNDT(obj, _option, _html);
		}
		else
		{
			var path=fb_File.replaceAll('default.zfrm',_option.code);
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
	});
}

function _OptionsCfgUI(tbl)
{
	var _exists = $('tr[name="trVmlCfgPrimary"]').parent().find( 'input[name="detailTbl"][value="' + tbl + '"]' );
	if (_exists.length == 0)
	{
		var _html = '';
		_html += '<tr>';
		_html += '	<td colspan="5" height="5"></td>';
		_html += '</tr>';
		_html += '<tr>';
		_html += '	<td align="center"><input type="text" name="detailTbl" size="10" value="' + tbl + '"></td>';
		_html += '	<td align="center"><input type="text" name="detailInsertVml" size="10"></td>';
		_html += '	<td align="center"><input type="text" name="detailUpdateVml" size="10"></td>';
		_html += '	<td align="center"><input type="text" name="detailQueryVml" size="10"></td>';
		_html += '	<td align="center"><input type="text" name="detailDeleteVml" size="10"></td>';
		_html += '</tr>';

		$('tr[name="trVmlCfgPrimary"]').after(_html);
	}
	
	return;
}