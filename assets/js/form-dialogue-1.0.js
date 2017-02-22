/***************************************initDialogue*******************************/

function initDialogue(that,_option,_handle){
	if(_option.modalWindow){

	}
	else{
		var data_content='';
		if(_option.cls=="frame"){
			data_content = '<iframe src="'+unescape(_option.url)+'" />';
		}
		else if(_option.cls=="tree"){
			data_content = '<div style="width:470px;height:300px;overflow:auto;border: 1px solid #ddd; border-radius: 5px;"><div class="mindMapTree"></div></div>';
		}
		
		data_content += '<div align="center" style="padding-top:10px;">  ';
		data_content += '<button class="btn btn-sm btn-default ok" type="button" onclick="inputTreeValue(this)" full>确定</button>  ';
		data_content += '<button class="btn btn-sm btn-default" type="button" onclick="hideprover(this)">取消</button>  ';
		data_content += '<button class="btn btn-sm btn-default cleaninput" type="button" onclick="cleaninput(this)">清空</button>  ';
		data_content += '</div>  ';
		
		var popover;
		if($(that).attr("data-toggle")=="popover") 
			popover = $(that);
		else	
			popover=$(that).find('[data-toggle="popover"]');
		popover.attr('data-content', data_content);
		if(_option.outputurl=="on")popover.attr('fullPath',true);
		if(_option.optionsson=="on")popover.attr('leafOnly',true);
		if(_option.multiple=="on")popover.attr('multiple',true);
		
		popover.popover();
		var multiple='';
		var plugins = [ "wholerow" ]
		if(_option.multiple)plugins.push("checkbox");
		function makeTreePopover(data){
			var mmt=popover.parent().find('.mindMapTree');
			mmt.jstree({
				"checkbox" : {
				  "keep_selected_style" : true
				}, 
				'core' : {
					'data' : data,
					'force_text' : false,
					'themes' : {
						'responsive' : true,
					},
					dblclick_toggle:true
				},
				"plugins" : plugins
			  });
			  
			 
			 mmt.on("dblclick.jstree",
				 function(evt, data){
					inputTreeValue($(this).parent().parent().find('.ok')[0]);
				 }
			);
			
		}
		popover.on('show.bs.popover', function () {
			var data=$(that).data("mmt");  //记住获取到的数据
			if(!data){  
				GetContent(unescape( _option.url),{},'json',false,function(data){	
					var data=data.root ? data.root : data;
					$(that).data("mmt",data);
					makeTreePopover(data);
				});
					
			}else
				setTimeout(function(){
					makeTreePopover(data);
				},100);
		})
	}
	if(_handle)_handle(true);
}

/**************************************popover action************************************/

function inputTreeValue(obj){
	var popover = $(obj).closest('.popover');
	var tree=popover.find('.mindMapTree');
	var inputprover=$(obj).closest('.popover').prev();	
	var instance = tree.jstree(true);
	var select=instance.get_selected(true);
	if(select&&select.length<0)
		return ;
	var _str = '';
	var _str1 = '';
	if(inputprover.attr('multiple')){
		for(var n=0;n<select.length;n++){
			if(_str!==""){
				_str+=',';
				_str1+=',';
			}
			_str1+=select[n].id;
			_str+=instance.get_text( select[n] );
		}
	}
	else{
		_str1=select[0].id ;
		
		//是否输出全路径
		var _fullPath = false;
		if ( inputprover.attr("fullPath"))
		{
			if (inputprover.attr("fullPath").toLowerCase() == "true")
			{
				_fullPath = true;
			}
		}
		//是否只允许选择叶子节点
		if ( inputprover.attr("leafOnly") )
		{
			if (inputprover.attr("leafOnly").toLowerCase() == "true" && 
				select[0].children.length > 0)
			{
				//$( inputprover ).popover( 'hide' );
				popover.find('.msg').html('只能选择叶子节点!');
				return;
			}
		}


		if ( select[0] )
		{
			if (_fullPath)
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
			else
			{
				_str = instance.get_text( select[0] );
			}
		}

		//var _str = instance.get_text( select[0].parents[1] ) + "/";
		//_str += instance.get_text( select[0].parents[0] ) + "/" + instance.get_text( select[0] );
	}
	$( inputprover ).val( _str );
	$( inputprover ).prev(). val(_str1);
	$(inputprover).trigger('change');
	$( inputprover ).popover( 'hide' );

	//commented by guohongling, 2015-05-27
	//根据tree的返回值联动select，没有通用配置，暂时注释
	var _inputObj = $( obj ).parent().parent().parent().parent().find( 'input:eq(1)' );
	var _name = $( _inputObj ).attr( "name" );
	var _flt = select[0].id;
	_DoLinkedComboRefresh( _name, _flt )
	_DoComboLinking( _inputObj );
}


function hideprover(obj) {
	var inputprover=$(obj).closest('.popover').prev();	
	$(inputprover).popover('hide');
}


function cleaninput(obj) {

	var inputprover=$(obj).closest('.popover').prev();	
	$(inputprover).val('');
	$(inputprover).prev().val('');
}


/*************************************modal*****************************/

function showModalWindow(btn, titleStr, valueObj, addiParams, evSubmit){
	var _option=$(btn).attr('f-options');
	_option=eval('('+_option+')');
	
	var _value;
	
	var _sup = '';
	if (valueObj)
	{
		_sup = valueObj.val();
		if (typeof(_sup) == 'undefined')
		{
			_sup = '';
		}
	}
	
	if(_option.cls=="frame"){
		var table = $(btn).closest("table");
		var data=wrapFormData(table,true,true);
		var _url = calcTemplate( unescape( _option.url ), data );
		
		var _html = "				<div class=\"dialogue-header\" style=\"background-color:#f27302;position:relative;margin-left:10px;margin-right:10px;margin-top:20px; margin-bottom:20px;\">\n" +
			"                   <p style=\"text-align:left;background-color:white;margin-left:3px;padding-left:10px; color:#666; font-size:14px;\">" + titleStr + "</p>\n" +
			"                   <div style=\"position:absolute;top:-6px; right:0;\">\n" +
			"					    <button type=\"button\" class=\"btn btn-default pull-right\" data-dismiss=\"modal\" aria-label=\"Close\" title=\"关闭\" style=\"box-shadow:none;text-shadow:none;\"><span aria-hidden=\"true\" class=\"\">关闭</span><span class=\"glyphicon glyphicon-remove\" style=\"margin-left:2px;color:#888;\"></span></button>\n" +
			"					    <button type=\"button\" class=\"btn btn-default pull-right okButton footKeepBtn\" style=\"margin-right:10px;box-shadow:none;text-shadow:none;\" aria-label=\"OK\" title=\"确定\" ><span aria-hidden=\"true\" class=\"\">确定</span><span class=\"glyphicon glyphicon-ok\" style=\"margin-left:2px;\"></span></button>\n" +
			"                   </div>\n" +
			"				</div>\n" +
			"<iframe src='" + _url + "?value=" + _sup;
		if (addiParams && addiParams != "")
		{
			_html += "&" + addiParams;
		}
		_html += "' />";
		$( '#win-Common-Dialog .content' ).html( _html );			
		$('#win-Common-Dialog .okButton').unbind('click');
		$('#win-Common-Dialog .okButton')[0]._btn=btn;
		$('#win-Common-Dialog .okButton')[0]._option=_option;
		/*
		var iframe = '';
		iframe = $('iframe').contents().find('#demo .jptable');
		iframe.find('tr').click(function()
		{
			var thatBtn=$('#win-Common-Dialog .okButton')[0]._btn;
			var thatOption=$('#win-Common-Dialog .okButton')[0]._option;
			Assignment(thatBtn,thatOption);
		});
		*/
		$('#win-Common-Dialog .okButton').bind('click',function()
		{
			var thatBtn=this._btn;
			var thatOption=this._option;
			Assignment(thatBtn,thatOption);
		});	
		$('#win-Common-Dialog').modal('show');
		function Assignment(thatBtn,thatOption)
		{
			var frame=$('#win-Common-Dialog .content iframe');
	
			var tr = frame[0].contentWindow.selectTrData(); 
			if (!tr)
			{
				return;
			}
			
			function GetTrVals(fld)
			{
				var _v = '';
				for(var n=0;n<tr.length;n++)
				{
					var _tr=tr[n];
					if(_v !== "")
						_v+=",";
					if(fld=="id")
						_v+=_tr.find('[name="'+fld+'"]').val();
					else
						_v+=_tr.find('[fld="'+fld+'"]').html();
				}
				return _v;
			};
			
			$(thatBtn).find('input[type="hidden"]').val(GetTrVals('id'));
			
			var btnTr=$(thatBtn).closest('tr');
			if(!btnTr.attr("nrowid"))
			{
				btnTr=table.find("tr:not([nrowid]):not(rowid)");
			}

			var pushValus=thatOption.vals;
			if(pushValus)
			{
				var arrs = pushValus.split(',');
				for(var i=0;i<arrs.length;i++)
				{
					var arr=arrs[i].split('=');
					var _v = GetTrVals(arr[1]);
					
					if( arr[1] == 'id' )
					{
						_value = _v;
					}
					
					if(_v)
					{
						btnTr.find( '[name="' + arr[0] + '"]' ).val( _v );
						var _select;
						_select = btnTr.find( '[name="' + arr[0] + '"]' ).next();
						_select.find('option').each( function ()
						{
							if ( _select.attr( 'name' ).split( '_' )[0] == arr[0] )
							{
								if ( $( this ).val() == _v )
								{
									$( this ).attr( 'selected', 'selected' );
									$( this ).parent().next().find( 'button' ).attr( 'title', $( this ).text() );
									$( this ).parent().next().find( '.filter-option' ).text( $( this ).text() );
									pushDisplayValue( $( this ).parent() );
									_DoComboLinking( $( this ).parent() );
								}
							}
								
						} );
					}
					else
						btnTr.find('[name="'+arr[0]+'"]').val('');
				}
			}
			
			//执行OK按钮的回调函数
			//该回调必须返回True或False
			if (evSubmit)
			{
				if (evSubmit(_value))
				{
					$('#win-Common-Dialog').modal('hide');
				}
				else
				{
					$('#win-Common-Dialog').modal('hide');
					$(btn).closest('tr').remove();
				}
			}
			else
			{
				$('#win-Common-Dialog').modal('hide');
			}
		}
	}
}

function selectTrRow( obj )
{
	var radio = $(obj).find('td:first-child input[name="approve"]');
	radio[0].checked=true;
}
