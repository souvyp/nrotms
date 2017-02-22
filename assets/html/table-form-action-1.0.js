
/*
	以下为吴健编写的代码，待研究，主要是弹出对话框的确定或者取消或者关闭按钮
*/


function getTableItemFromName(t,n){
	var itemObj=t.find('[name="'+n+'"]');
	if(itemObj.length==0)
		itemObj=t.find('input[name^="'+n+'+"]');
	return itemObj;
}

function selectTrRow(obj){
	var radio = $(obj).find('td:first-child input[name="approve"]');
	radio[0].checked=true;
}

function inputDlgValue(ddid){
	var check=$('#'+ddid).find('tbody tr.selected');
	if(check.length==1){		
		var inputprover=$('a[data-target="#win-'+ddid+'"]');	
		var calcs=inputprover.attr('pushValus');
		if(calcs){
			calcs=unescape(calcs);
			calcs=calcs.split(',');
			var table=inputprover.parents('table');
			for(var n=0;n<calcs.length;n++){
				var calc=calcs[n];
				var items=calc.split('=');
				var inputItem=getTableItemFromName(table,items[0]);
				if(inputItem.length==1){
					var tr=$('#'+ddid+' tr.selected');
					inputItem.val(tr.find('td:eq('+items[1]+')').text())
				}
			}
		}
		var input=inputprover.find('input[type="hidden"]');
		input.val(check.val());
		input.trigger('change');
		$('#win-'+ddid).modal('hide');
	}
	else{
		alert('请选择一行数据');
	}
}

function cleanDlginput(ddid){
	var inputprover=$('a[data-target="#win-'+ddid+'"]');	
	var calcs=inputprover.attr('pushValus');
	if(calcs){
		calcs=unescape(calcs);
		calcs=calcs.split(',');
		var table=inputprover.parents('table');
		for(var n=0;n<calcs.length;n++){
			var calc=calcs[n];
			var items=calc.split('=');
			var inputItem=getTableItemFromName(table,items[0]);
			if(inputItem.length==1){
				inputItem.val('')
			}
		}
	}
	var input=inputprover.find('input[type="hidden"]');
	input.val('');
	input.trigger('change');
	$('#win-'+ddid).modal('hide');
}

function inputTreeValue(obj){
	var tree=$(obj).parents('.popover').find('.mindMapTree');
	var inputprover=$(obj).parents('.popover').prev();	
	var instance = tree.jstree(true);
	var select=instance.get_selected(true);
	$( inputprover ).prev().val( select[0].id );

	var _str = '';
	if ( select[0] )
	{
	    for ( var i = 0; i < select[0].parents.length; i++ )
	    {
	        if ( select[0].parents.length == 1 )
	        {
	            _str += instance.get_text( select[0] );
	        }
	        else
	        {
	            var _len = select[0].parents.length;

	            if ( i == _len - 1 )
	            {
	                _str += instance.get_text( select[0] );
	            }
	            else
	            {
	                _str += instance.get_text( select[0].parents[_len - i - 2] );
	            }

	        }

	        if ( i < select[0].parents.length - 1 )
	        {
	            _str += '/';
	        }
	    }
	}

	//var _str = instance.get_text( select[0].parents[1] ) + "/";
	//_str += instance.get_text( select[0].parents[0] ) + "/" + instance.get_text( select[0] );

	$( inputprover ).val( _str );
	$(inputprover).trigger('change');
	$( inputprover ).popover( 'hide' );
	var _inputObj = $( obj ).parent().parent().parent().parent().find( 'input:eq(1)' );
	var _name = $( _inputObj ).attr( "name" );
	var _flt = select[0].id;
	_DoLinkedComboRefresh( _name, _flt )
	//_DoComboLinking( _inputObj );
}

function inputvalue(obj) {
	var table=$(obj).parents('.popover').find('table');
	var inputprover=$(obj).parents('.popover').prev();	
	var rowRadio=table.find("input[name='approve']:checked");
	
	$(inputprover).val(rowRadio.val());
	$(inputprover).trigger('change');
	$( inputprover ).popover( 'hide' );
}

function hideprover(obj) {
	var inputprover=$(obj).parents('.popover').prev();	
	$(inputprover).popover('hide');
}

function cleaninput(obj) {

	var inputprover=$(obj).parents('.popover').prev();	
	$(inputprover).val('');
	$(inputprover).prev().val('');
}

/*
	function initDroparea(_droparea) 初始化文件对象
*/
function initDroparea(_droparea) {
	var w = _droparea.data('width');
	var h = _droparea.data('height');
	_droparea.droparea({
		'instructions': '拖动文件到此处<br />或点击此处',
		'over': '将文件放在此处',
		'nosupport': 'No support for the File API in this web browser',
		'noimage': '不支持的文件类型!',
		'uploaded': '上传完成',
		'maxsize': '10', //Mb
		'init': function(result) {
			//console.log('custom init',result);
		},
		'start': function(area) {
			area.find('.error').remove();
		},
		'error': function(result, input, area) {
			$('<div class="error">').html(result.error).prependTo(area);
			return 0;
			//console.log('custom error',result.error);
		},
		'complete': function(result, file, input, area) {
			if ((/image/i).test(file.type)) {
				initImages(area,result.path + result.filename);
			}
			else
				alert('不支持的文件类型!');
			//console.log('custom complete',result);
		}
	});
	
	var img=_droparea.attr('data-file');
	if(img){
		var area=_droparea.parents('.droparea');
		area.find('.instructions').html('');
		initImages(area,img);
	}
	function initImages(area,img){
		area.find('img').remove();
			//area.data('value',result.filename);
			$('<img>', {
				'src': img
			}).css({
				"maxWidth": w,
				"maxHeight": h
			}).appendTo(area);
			var attFile=area.find('input[type="hidden"][name="'+_droparea.attr('name')+'"]');
			if(attFile.length==0){	
				attFile=$('<input type="hidden" name="'+_droparea.attr('name')+'" />');
				attFile.appendTo(area);
			}
			attFile.val(img);
	}
}



/*2015/05/21 下拉菜单代码整理 郭红亮*/
/*
options, 配置项
urldata, 数据
val, 默认值
flt, 筛选值
*/
function _ShowComboWithUrlData( options, urldata, val, flt )
{
	var selects = '';
	var _DataID=options.optValue;
	var _DataValue=options.optText;
	
	selects += '<option value="">请选择</option>';
	var rows=makeRemoteData(urldata);
	if(rows.length>0)
	{						
		if(!_DataID)
		{
			var n=0;
			for(var key in rows[0])
			{
				if(n==0) 
					_DataID=key;
				else if(n==1)
				{
					_DataValue=key;
					break;
				}

				n++;
			}							
		}

		if(!_DataValue)
			_DataValue=_DataID;

		for(var i=0 ; i<rows.length;i++)
		{
			var _show = true;

			//按联动要求过滤选项
			if (options.linkfield)
			{
				var _curVal = rows[i][options.linkfield];
				if (_curVal )
				{
					if (flt == _curVal)
					{
						_show = true;
					}
					else
					{
						_show = false;
					}
				}
			}
			
			if (_show)
			{
				selects += '<option value="' + rows[i][_DataID] + '"';
				if (val == rows[i][_DataID])
					selects += ' selected';
				selects += ' >' + rows[i][_DataValue] + '</option>';
			}
		}
	}

	return selects;
}
/*2015/05/21 下拉菜单代码整理 郭红亮*/

/*2015/05/20 联动菜单 郭红亮*/
function _DoComboLinking( obj )
{
	if (obj)
	{
		var _name = $(obj).attr("name");
		if (_name)
		{
			_name = _name.substr(0, _name.length - 3);
			var _flt = $(obj).val();
			if (!_flt)
			{
				_flt = '';
			}

			_DoLinkedComboRefresh( _name, _flt )
			//判断当前对像是否是某表联动菜单的父对像
			//$('select[linkcombo="' + _name + '"]').each(function(index)
			//{
			//	//重新生成下拉菜单项
			//	var _target = $(this);
			//	var options = _target.attr("fb-options");
				
			//	if (options)
			//	{
			//		options = unescape(options);
			//		options = StrToJson(options);

			//		if(options.datasourcetype=="url")
			//		{
			//			var url = options.datasourcetsetting;
			//			_target.attr("disabled",true);

			//			OnlineData({},function(data)
			//			{
			//				_target.children().remove();
			//				var selects = _ShowComboWithUrlData(options, data, '', _flt);

			//				$(selects).appendTo(_target);
			//				_target.removeAttr( "disabled" );

			//				//触发onchange事件，刷新下一级联动列表
			//				_target.trigger('change');
			//			},url);
			//		}
			//	}
			//});
		}
	}
}

//判断当前对象是否是某表联动菜单的父对像
function _DoLinkedComboRefresh( name, flt )
{
    $( 'select[linkcombo="' + name + '"]' ).each( function ( index )
    {
        //重新生成下拉菜单项
        var _target = $( this );
        var options = _target.attr( "fb-options" );

        if ( options )
        {
            options = unescape( options );
            options = StrToJson( options );

            if ( options.datasourcetype == "url" )
            {
                var url = options.datasourcetsetting;
                _target.attr( "disabled", true );

                OnlineData( {}, function ( data )
                {
                    _target.children().remove();
                    var selects = _ShowComboWithUrlData( options, data, '', flt );

                    $( selects ).appendTo( _target );
                    _target.removeAttr( "disabled" );

                    //触发onchange事件，刷新下一级联动列表
                    _target.trigger( 'change' );
                }, url );
            }
        }
    } );
}

/*2015/05/20 联动菜单 郭红亮*/


/**********************生成的页面的操作功能*********************************************/
$(function(){
	initTableForm();
});

function initTableForm(table,_handle){
	Mask();
	if(!table)
		table=$('.FormTable');
	var optionList=table.find('td[fb-options]');
	var cou=optionList.length;
	var icou=0;
	var defaults='';
	optionList.each(function() {	
		var that=this;
		
		var ostr = $(that).attr("fb-options");
		var _option = eval('(' + unescape(ostr) + ')');
		var _extract = 	MakeExtractAttrs(_option);
		
		if(_option.edittype=='editable'){
			var setting=_option.setting;
			if(setting){
				if(defaults!=="")defaults+='\n';
				defaults+=_option.codename+'='+setting;
			}
		}
		
		if (_option.codetype == "checkbox" || _option.codetype == "radio" ||_option.codetype == "combobox") {
			var url = _option.datasourcetsetting; //根据url补充动态数据到对象
			if(url){
				var _DataID=_option.optValue;
				var _DataValue=_option.optText;
				OnlineData({},function(data){	
					var _level = _option.datasourcetype=="tree"?2:1;
					var rows=makeRemoteData(data,_level);
					if(rows.length>0){						
						
						if(_level!==2&&!_DataID){
							var n=0;
							for(var key in rows[0]){
								if(n==0) 
									_DataID=key;
								else if(n==1){
									_DataValue=key;
									break;
								}
								n++;
							}							
						}
						if(!_DataValue)_DataValue=_DataID;
						var _arrs=[];
						for(var i=0 ; i<rows.length;i++){
							if(_level==2)
								_arrs.push({id:rows[i]["id"],text:rows[i]["text"],group:rows[i]["group"]});
							else
								_arrs.push({id:rows[i][_DataID],text:rows[i][_DataValue]});
						}
						var _html='';
						if (_option.codetype == "checkbox" || _option.codetype == "radio" ) {
							_html=MakeEditorGroup(_option,_arrs,_extract);
						}
						else  if(_option.codetype == "combobox"){
							_html=MakeEditorComboBox(_option,_arrs,_extract);
						}
						$(that).html(_html);
					}
					CheckActionCount();					
					
				},url,null,null,null,function(){
					CheckActionCount();	
				});
			}
			else
				CheckActionCount();	
		}
		else if(_option.codetype == "_button"){
			var _btn=$(that).find(".button")[0];
			_btn.td=that;
			MakeButtonAction(_btn);
			CheckActionCount();
		}
		else if (_option.codetype == "dialogue") {
			CheckActionCount();	
			if(_option.modalWindow){

			}
			else{
				var data_content='';
				if(_option.datasourcetype=="frame"){
					data_content = '<iframe src="'+_option.datasourcetsetting+'" />';
				}
				else if(_option.datasourcetype=="tree"){
					data_content = '<div style="width:500px;height:300px;overflow:auto;"><div class="mindMapTree"></div></div>';
				}
				
				data_content += '<div align="center" style="padding-top:10px;">  ';
				data_content += '<button class="btn btn-sm btn-default " type="button" onclick="inputTreeValue(this)" full>确定</button>  ';
				data_content += '<button class="btn btn-sm btn-default" type="button" onclick="hideprover(this)">取消</button>  ';
				data_content += '<button class="btn btn-sm btn-default cleaninput" type="button" onclick="cleaninput(this)">清空</button>  ';
				data_content += '</div>  ';
				
				var popover = $(that).find('[data-toggle="popover"]');
				popover.attr('data-content', data_content);
				popover.popover();
				
				var url = _option.datasourcetsetting;
				
				function makeTreePopover(){
					var treeData=that.treeData; 
					//console.log(treeData);
					$(that).find('.mindMapTree').jstree({
						"checkbox" : {
						  "keep_selected_style" : true
						}, 
						'core' : {
							'data' : treeData,
							'force_text' : false,
							'themes' : {
								'responsive' : true,
							}
						},
						"plugins" : [ "wholerow" ]
					  });
					
				}
				popover.on('show.bs.popover', function () {
					if(!that.treeData || true){  //为什么无效?
					
						OnlineData( {}, function ( data ){
							that.treeData = data.root ? data.root : data;
							makeTreePopover();
						},url);
							
					}else
						makeTreePopover();
				})
			}
		}
		else
			CheckActionCount();
	});
	
	function CheckActionCount(){
		icou++;
		if(icou==cou){
			UnMask();
			initTableFormData(table,null,defaults);
			if(_handle)_handle(table);
		}
	}
}

function initTableData(table,data,isPosted){

	var code=table.attr("code");
	var master = data[code][0];
	var mrows = table.find('tr:not([rowid]):not([nrow])');
	for(key in master){
		var _input=mrows.find('[name="'+key+'"]');
		_input.val(master[key]);
	}
	
	var tr=table.find('tr[rowid]:hidden');
	tr.each(function(){
		var rowid=$(this).attr('rowid');
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
					_input.val(detail[key]);
				}
			}
			
		}
		for(;i<_irows;i++){
			_row_add($(this));
		}
	});
	
	calcTable(table);
}

function initTableFormData(table,mid,defaults){
	var code=table.attr("code");
	table.attr('path','trend/'+code);
	var id;
	if(mid)
		id=mid;
	else{
		id=getUrlParam("id");
	}
	
	if(id){
		var datas=code;
		table.find('tr[rowid]:hidden').each(function() {
			datas+=","+$(this).attr('rowid');
		});
		
		datas+=',_workflow';  //获取工作流数据
		OnlineData({param:'datas',datas:datas,id:id},function(data){
			var _nodedata=data._workflow;

			if(_nodedata){			
				delete data._workflow;
				
				if(_nodedata.length==1){					//有流程
					_nodedata=_nodedata[0];	
					
					initWorkFlowFromData(table,_nodedata, 	//初始化流程
							function(result){
								initTableData(table,data,true);
							},
							function(){
								//alert('没有查看此数据的权限');//没有找到用户对应的节点
								//table.hide();
								table.addClass("info").html('<tr><td>您没有查看此数据的权限<a href="javascript:history.go(-1);">点击返回</a></td></tr>');
								//setTimeout('history.go(-1);',1000);
							}
						)
					
				}
				else
					initTableData(table,data,false);
			}
			else
				initTableData(table,data,false);
			
			
		},TABLE_URL);
	}
	else{
		if(defaults){
			OnlineData({param:'default',def:defaults},function(data){
				var mdata={};
				data.id=uuid();
				mdata[code]=[data];
				
				initTableData(table,mdata,false);
			},TABLE_URL);
		}
		
	}

	
	table.find('tbody').delegate(".edit,.edit-list,.editarea","change",function(){
		calcTable(table,this);
		$(this).parents('tr')[0].isDirty=true;
	});
}

	
/************************************对应table-form-1.0.1.js的按钮操作********************************/
/*
	_row_add(row, prow, css)   复制row对象，在prow后面新增一行
	row : 源行
	prow :　插入prow 之后
	css: 新对象的class
	返回新行对象
*/

function _row_add(row,prow, css) {
	var nid = row.attr("rowid");
	var nrow = row.clone().removeAttr('rowid');

	if (css) nrow.addClass(css);
	nrow.attr("nrowid", nid);
	var idbtn=nrow.find('input[type="hidden"][name="id"]');
	if(idbtn.length==0)
		nrow.find('td:eq(0)').append('<input type = "hidden" name="id" value="'+uuid()+'" />');
	else
		idbtn.val(uuid());
	if(prow){ //插入到原始行后面
		nrow.insertAfter(prow);
	}
	else{
		var rows=row.parent().find('[nrowid="'+nid+'"]');
		if(rows.length>0){
			nrow.insertAfter(rows.eq(rows.length-1));   //根据row对象，计算出最后一行的位置插入
		}
		else 
			nrow.insertAfter(row);
	}
	
	nrow.find('.button').each(function(){
		this.td=$(this).parent()[0];
		MakeButtonAction(this);
	});
	nrow.show();
	return nrow;
}

/*
	_action_clone(row, btn)   根据btn按钮在后面复制一行
	row : btn所在的row
	btn: 按钮对象
*/

function _action_clone(row, btn) {
	var prow = btn.parents('tr').eq(0);
	var nrow = _row_add(prow,prow,"_cloned");
	var idbtn=nrow.find('input[type="hidden"][name="id"]');
	idbtn.val(uuid());
}

var _deleteRows=[];					//删除的行对象 ，全局变量需调整，建议绑定到table的dom对象上去 table._deleteRows;

function _action_delete(row, btn) {
	var prow = btn.parents('tr').eq(0);
	var idbtn=prow.find('input[type="hidden"][name="id"]');
	if(idbtn.length==1){
		if(idbtn.val().length<16)
			_deleteRows.push({name:prow.attr("nrowid"),id:idbtn.val()});
	}
	prow.remove();
}

function _action_clear(row, btn) {	
	var prow = btn.parents('tr').eq(0);
	var idbtn=prow.find('input[type="hidden"][name="id"]');
	if(idbtn.length==1)
		if(idbtn.val().length<16)
			_deleteRows.push({name:prow.attr("nrowid"),id:idbtn.val()});
	
	prow[0].isDirty=false;
	prow.find('input[type!="hidden"]:not([readonly])').val('');
	prow.find('select').val('');
}

function MakeButtonAction(_btn){
	var table=$(_btn.td).parents('table').eq(0);
	var _option=$(_btn.td).attr('fb-options');
	_option=eval('('+_option+')');
	_btn.row=table.find('tr[rowid="'+$(_btn).attr("tar")+'"]');
	if (_option.ExecuteCode == "#add#") {
		$(_btn).on('click', function() {
			_row_add(this.row);
		});
	} 
	else if (_option.ExecuteCode == "#clone#") {

		$(_btn).on('click', function() {
			_action_clone(this.row,$(this));

		});
	} 
	else if (_option.ExecuteCode == "#delete#"){
		$(_btn).on('click', function(){
			_action_delete(this.row, $(this));
		});
	}
	else if (_option.ExecuteCode == "#clear#")
	{
		$(_btn).on('click', function()
		{
			_action_clear(this.row, $(this));
		});
	}
	else if (_option.ExecuteCode == "#save#") {
		$(_btn).on('click', function() {
			SaveFormData(table, $(this));
		})
	} else if (_option.ExecuteCode == "#postwf#") {
		$(_btn).on('click', function() {
			postToWF(table, $(this));
		})
	}else {
		var ws = (_option.ExecuteCode);
		$(_btn).on('click', function() {
			var _that = this;
			eval(ws);
		})
	}
}



/********************************actions***********************************/
function pushDisplayValue(select){
	var opt = $(select).find("option:selected");

	if(opt.parent()[0].tagName=='OPTGROUP'){
		$(select).prev().val(opt.parent().attr('label')+'/'+opt.text());
	}
	else{
		$(select).prev().val(opt.text());
	}
}

function showModalWindow(btn){
	var _option=$(btn).parent().attr('fb-options');
	_option=eval('('+_option+')');
	
	if(_option.datasourcetype=="frame"){
		$('#win-Common-Dialog .content').html('<iframe src="'+_option.datasourcetsetting+'" />');
		
		$('#win-Common-Dialog .okButton').on('click',function(){
			var frame=$('#win-Common-Dialog .content iframe');
	
			var tr = frame[0].contentWindow.selectRadioData(); 
			
			
			$(btn).find('input[type="hidden"]').val(tr.find('[name="id"]').val());
			
			var btnTr=$(btn).parents('tr').eq(0);
			
			var pushValus=_option.pushValus;
			var arrs = pushValus.split(',');
			for(var i=0;i<arrs.length;i++){
				var arr=arrs[i].split('=');
				var td = tr.find('[fld="'+arr[1]+'"]');
				if(td.length==1){
					btnTr.find('[name="'+arr[0]+'"]').val(td.html());
				}
			}
			
			$('#win-Common-Dialog').modal('hide');
		})
		
		$('#win-Common-Dialog').modal('show');
	}
}