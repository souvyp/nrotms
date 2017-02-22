/**********************生成的页面的操作功能*********************************************/
function initTableForm(table,_readonly,_handle,mid){
	if(!table)table=$('.FormTable');

	Mask();
	table.closest('.formcontainer').show(); 
	var optionList=table.find('[f-options][name]');

	var cou=optionList.length;
	var icou=0;

	function _initMain(obj,e){
		icou++;
		if(icou==cou){
			_initTable(table);
			
			var defaults=table.find('td:eq(0)').attr('default');
			if(!defaults)
				defaults='';
			else 
				defaults = unescape(defaults);
			initTableFormData(table,mid,defaults,_readonly,function(){
				UnMask();
				if(_handle)_handle();
				if (self != top) { 
					$(parent.document.all("mainFrame")).height(document.body.scrollHeight); 
					$(parent.document.all("mainFrame")).width(document.body.scrollWidth);
					
				}
			});
		}
		if(!e){
			console.log('error:'+obj.getAttribute('name')+','+obj.getAttribute('title'));
		}
	}

	optionList.each(function(){
		var ostr = $(this).attr("f-options");
		var _option = eval('(' + ostr + ')');
		var that = this;
		if(_option.type=="combobox"){
			initCombobox(that,_option,function(e){_initMain(that,e)})
		}
		else if (_option.type == "richtext"){
			initTextarea(that,_option,function(e){_initMain(that,true);});
		}
		else if (_option.type == "checkbox" || _option.type == "radio" ){
			
			initInputBox(that,_option,function(e){_initMain(that,e)});
		}
		else if (_option.type == "dialogue") {
			initDialogue(that,_option,function(e){_initMain(that,e)});
		}
		else if(_option.type == "file") {
			initInputFile(that,_option,function(e){_initMain(that,e)});
		}
		//move to form-editor-1.0.js, and call it from requestDone function
		//else if (_option.type == "editor")
		//{
		//	initInputWebEditor(that,_option,function(e){_initMain(that,e)});
		//}
		else if(_option.type == "image") {
			initInputImage(that,_option,function(e){_initMain(that,e)});
		}
		else if(_option.type == "_button"){
			MakeButtonAction(that,function(e){_initMain(that,e)});
		}
		else if(_option.type == "_normal"){
			initNormal(that,_option,function(e){_initMain(that,e);})
		}
		else 
			_initMain(that,true);
		
	});
}

function initNrowList(nrow){
	nrow.find('[f-options]').each(function(){
		var ostr = $(this).attr("f-options");
		var _option = eval('(' + ostr + ')');
		var that = this;
	
		if(_option.type=="combobox"){
			initSelectControl(that);
		}
		else if (_option.type == "richtext"){
			initTextarea(that,_option);
		}
	});	
}

function clearTableData(table){
	table.find('[f-options][name]').each(function(){
		putInputValue($(this),null);
	})
}

function initTableData(table,data,_readonly,_handle){
	clearTableData(table);
	var code=table.attr("code");
	var master = data[code][0];
	var mrows = table.find('tr:not([rowid]):not([nrow])');
	for(key in master){
		var _input=mrows.find('[name="'+key+'"]');
		putInputValue(_input,master[key]);
	}
	
	var tr=table.find('tr[rowid]:hidden');
	tr.each(function(){
		var rowid=$(this).attr('rowid');
		if(table.find('tr[nrowid="'+rowid+'"]').length==0){
			var details=data[rowid];
			
			var ostr = $(this).attr("fb-options");
			var _option = eval('(' + unescape(ostr) + ')');
			var _irows=_option.initialRows?_option.initialRows:1;
			var i=0;
			if(details){			
				for(;i<details.length;i++){
					var nrow=_row_add($(this));
					
					var detail = details[i];

					for(key in detail){
						var _input=nrow.find('[name="'+key+'"]');
						putInputValue(_input,detail[key]);
					}
				}
				
			}
			for(;i<_irows;i++){
				_row_add($(this));
			}
		}
	});
	
	calcTable(table,null,true);
	
	if(_readonly){
		table.find('.uploadify').hide();
		table.find('tbody').find(".edit,.edit-list,.editarea").attr("disabled","disabled");
		table.find('tbody').find("a").each(function(){
			if($(this).hasClass('btn')){
			}
			else if($(this).hasClass('button'))
				$(this).parent().html('');
			else{
				var prt=$(this).parent();
				if(prt.attr("target")=="_blank")
					;
				else
					prt.html($(this).html());
			}
		});		
	}
	
	if(_handle)_handle(table);
}

function initTableFormData(table,mid,defaults,_readonly,_handle){
	var code=table.attr("code");
	var id;
	if(mid)
		id=mid;
	else{
		id=getUrlParam("id");
	}
	var ro = getUrlParam("ro");
	if(ro){
		_readonly = true;
	}

	if(id){		
		if (!__saveNdtCfg)
		{
			//CSDU
			var datas=code;
			table.find('tr[rowid]:hidden').each(function() {
				datas+=","+$(this).attr('rowid');
			});
			
			var queueList = table.find('.queue_list');
			if(queueList.length==1)
				datas+=',_files'; //获取文件列表
			var _workflow = $('body').attr('workflow');
			if(_workflow)
				datas+=',_workflow';  //获取工作流数据

			GetContent(TABLE_URL,{param:'datas',datas:datas,id:id},'json',false,function(data)
			{
				
				if(data.success!==false)
				{
					var _nodedata=data._workflow;

					if(_workflow&&_nodedata)
					{		
						delete data._workflow;
						if(_nodedata.length>0)					//有流程
						{
							try
							{
								makeWorkFlowTimeLine(table,$('.workflowcontainer'),_nodedata);  //用时间轴绘制流程图操作节点
								
								//初始化流程
								initWorkFlowFromData(table,data[code][0],_nodedata[0],function(result)
								{
									initTableData(table,data,true,_handle);
								}, function()
								{
									//alert('没有查看此数据的权限');//没有找到用户对应的节点
									//table.hide();
									//table.addClass("info").html('<tr><td>您没有查看此数据的权限<a href="javascript:history.go(-1);">点击返回</a></td></tr>');
									//setTimeout('history.go(-1);',1000);
									initTableData(table,data,true,_handle);									
								});
							}
							catch(e)
							{
								initTableData(table,data,_readonly,_handle);
							}
						}
						else
							initTableData(table,data,_readonly,_handle);
					}
					else
					{
						initTableData(table,data,_readonly,_handle);
					}
					
					if(queueList.length==1)
					{
						for(var i=0;i<data._files.length;i++)
						{
							var _file=data._files[i];
							var aFile = $('<a href="/uploads/'+_file.uid+'-'+_file.filename+'">'+_file.filename+'</a>');
							queueList.parent().find('.queue_list').append(aFile);
							aFile[0]._file=_file;
						}
					}			
				}
				else
				{
					alert('数据获取失败或您无权访问此数据!');
				}
			});
		}
		else
		{
			//NDT
			initTableFormDataNDT(table,id,defaults,_readonly,_handle);
		}
	}
	else{
		if(defaults){
			GetContent(TABLE_URL,{param:'default',def:defaults},'json',false,function(data){
				var mdata={};
				data.id=uuid();
				mdata[code]=[data];
				
				initTableData(table,mdata,_readonly,_handle);
			});
		}else{
			var mdata={};
			var data={id:uuid()}
			mdata[code]=[data];
			initTableData(table,mdata,_readonly,_handle);
		}
	}
}


function _initTable(table){
	initToolbarButton(table);
	
	table.find( 'tbody' ).delegate( ".edit,.edit-list", "change", function ()
	{
	    //$( this ).prev().val( $( this ).find( 'option:selected' ).val() );
		if(!this._stopchange){
			calcTable(table,this);
			$(this).closest('tr')[0].isDirty=true;
		}
	});
	

	/*if($('body').attr('autowidth')){
		window.onresize = function(){
			//var w=$(window).width();
			//console.log(w);
			//if(parent){
			//	w=$(parent.document.all("mainFrame")).width();	
			//}
			//w=Math.max(500,w-15);
			var w=$('.viewFramework-product-body').width()-5;
			_table_make_width(table,w);
			table.closest('.formcontainer').find('.content_workflow').width(w);
			
		};
		setTimeout('window.onresize();',300);
	}*/
}
/********************************************通用函数*****************************************/

function _table_make_width(table, w) { //自动列宽
	var tw = table.width();
	if (tw > 0) {
		w-=10;
		table.width(w);
		table.find("colgroup col").each(function() {
			$(this).width($(this).width() * w / tw);
			var area = table.find(".editarea");
			area.width(area.parent().width() - 4);
		})
	}
}

function getTableItemFromName(t,n){
	var itemObj=t.find('[name="'+n+'"]');
	if(itemObj.length==0)
		itemObj=t.find('input[name^="'+n+'+"]');
	return itemObj;
}

function putInputValue(_input,_val){
    var t = _input.attr( 'type' );
	if(t == "radio"){
		for(var i=0;i<_input.length;i++){
			if(_input[i].value==_val){
				_input[i].checked = true;
				break;
			}
		}
	}
	else if(t == "checkbox"){
		for(var i=0;i<_input.length;i++){
			if(_val&&(","+_val+",").indexOf(","+_input[i].value+",")>=0){
				_input[i].checked = true;
			}
		}
	}
	else if (t == "file"){
		_input.attr('data-file',_val);
		initDroparea(_input,true);
	}
	else if( t== "_normal"){
		if(_val){
			var _arr = _val.split('-');
			if(_input[0].inited){
				if(_arr.length>0)
					_input.find('select.loc_province').selectpicker('val', _arr[0]);
				if(_arr.length>1)
					_input.find('select.loc_city').selectpicker('val', _arr[1]);
				if(_arr.length>2)
					_input.find('select.loc_town').selectpicker('val', _arr[2]);
			}
		}
	}
	else if(_input.length==1)
	{ 
		var that=_input[0];
	    t = that.tagName.toLowerCase();

		if(!_val)_val='';
		_input.val(_val);
		
		if( t == "select" ){
			try{
				if(_input.is(':hidden')){
					if(_input[0].inited){
						that._stopchange=true;						
						_input.selectpicker('val',_val);
						that._stopchange=null;
					}
					else
						_input.val(_val);
				}
				
			}
			catch(e){
				console.log(e);
			}
			/*var _btn=_input.next().find('.selectpicker');
			_btn.attr('title',_val);
			_btn.find('.filter-option').text(_val);*/
		}
		else if ( t == "textarea" )
		{
			try
			{
				var oc = _input.attr("oc");
				if (oc == "editor")
				{
					if (typeof(KindEditor) == "undefined")
					{
						InitialEditorContent( _input );
					}
					else
					{
						KindEditor.html(_input, _input.val());
					}
				}
				_input.text(_input.val());
			}
			catch(e)
			{
				console.log(e);
			}
		}

		//select控件需主动触发onchange事件		
		/*if (t == "select")
		{
			_input.trigger( 'change' );
		}*/
	}
}


function getInputText(_input){
	var t=_input.attr('type');

	if(t == "radio"){
		for(var i=0;i<_input.length;i++){
			if(_input[i].checked){
				return _input[i].value;
			}
		}
	}
	else if(t == "checkbox"){
		var _val='';
		for(var i=0;i<_input.length;i++){
			if(_input[i].checked){
				if(_val!=="")_val+=',';
				_val+=_input[i].value;
			}
		}
		return _val;
	}
	/*else if(t == "select"){
		  return _input.find("option:selected").text();
	}*/
	else{
		return	_input.val();
	}
}
