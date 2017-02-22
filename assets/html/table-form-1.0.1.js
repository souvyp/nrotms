function MakeExtractAttrs(_option){
	var extractAttr='';  //扩展属性
	if(_option.workflowFlag){ //流程标志
		extractAttr+=' workflowFlag="'+_option.workflowFlag+'"';
	}
	if(_option.readOnly)	//只读标志
		extractAttr+=' readOnly="readOnly"';
	if(_option.edittype!=="editable"&&_option.setting){
		extractAttr+=' calculation="'+escape(_option.setting)+'"';
		if(_option.edittype=="creatcalculation") extractAttr+=' ct="3"';
		//else 
		//	calculation+='readOnly="readOnly"';
	}
	
	if(_option.conditionhiding==2&&_option.conditionhidingcontent){ //隐藏标志（1：隐藏，2：按条件隐藏）
		extractAttr+=' hiddincalc="'+escape(_option.conditionhidingcontent)+'"';
		if(_option.hiddinRow)  //隐藏整行
			extractAttr+='hiddinRow="'+_option.hiddinRow+'"';
	}
	if(extractAttr!==""){
		extractAttr +=' oc="'+_option.codetype+'"' //字段类型
	}
	if(_option.conditionhiding==1){  //隐藏标志
		extractAttr +=' style="display:none;"';
	} 
	return extractAttr;
}

function MakeEditorGroup(_option,_arrs,_ext){
	var rid = uuid();
	var checks='';		
	for (var i = 0; i < _arrs.length; i++) {
		var n = _option.codename;
		//if (_option.codetype == "radio") n = n + '+' + rid;
		checks += '<label ><input type="' + _option.codetype + '" name="' + n + '" value="' + $.trim(_arrs[i]["id"]) + '"'+_ext+' class="edit-list transparent" />';
		checks += $.trim(_arrs[i]["text"]) + '</label>';
	}
	return checks;
}

function MakeEditorDate(_option,_ext){
	var dateformate= 'YYYY-MM-DD hh:mm:ss';
	if(_option.dateformat)dateformate=_option.dateformat;
	var laydate="laydate({format: '"+dateformate+"'";
	laydate+=",istime:"+_option.istime; 
	if(_option.festival)
		laydate+=",festival:true"; 
	if(_option.dateMin)
		laydate+=",min:"+_option.dateMin; 
	if(_option.dateMax)
		laydate+=",max:"+_option.dateMax;
	if(_option.istoday)
		laydate+=",istoday:true"; 
	laydate+='})';
	return '<input name="' + _option.codename + '" placeholder="'+_option.placeholder+'"' +_ext+' class="laydate-icon edit" onclick="'+laydate+'" />';
	
}

function MakeEditorComboBox(_option,_arrs,_ext){
	var _eHtml = '<input type="hidden" name="'+_option.codename+'" />';
	_eHtml += '<select name="' + _option.codename + '_id" '+_ext+' class="edit transparent" onchange="pushDisplayValue(this);" ';
	if (_option.linkfield){
		_eHtml += ' linkfield="' + _option.linkfield + '"';
	}
	if (_option.linkcombo){
		_eHtml += ' linkcombo="' + _option.linkcombo + '"';
	}
	_eHtml += '>';
	
	if(_arrs.length>0){
		var _group = _arrs[0]["group"];
		var _group_old='';
		_eHtml += '<option value="">-------------------------</option>';
		for (var i = 0; i < _arrs.length; i++) {
			if(_group){
				if(_group_old!==$.trim(_arrs[i]["group"])){
					if(_group_old!=="")
						_eHtml +='</optgroup>';
					_group_old=$.trim(_arrs[i]["group"]);
					_eHtml +='<optgroup label="'+_group_old+'">';
				}
			}
			_eHtml += '<option value="' + $.trim(_arrs[i]["id"]) + '">';
			_eHtml += $.trim(_arrs[i]["text"]) + '</option>';
		}
		if(_group)
			_eHtml +='</optgroup>';
	}
	_eHtml += '</select>';
	return _eHtml;

}

function MakeEditorComboTree(_option,_ext){
	var _eHtml='<input type="text" data-toggle="modal" data-target="#win-Common-Dialog" readOnly="readOnly" '+_ext+' class="edit transparent" name="' + _option.codename +'" /> ';
	return _eHtml;		
}

function MakeEditorImage(_td,_option,_ext){
	var _droparea = $('<input type="file" '+_ext+' class="droparea spot" name="' + _option.codename +
		'" data-post="/code/files/uploadify.chi?param=upload&filename='+_option.codename+'" data-width="' + Math.max(($(_td).width() - 4), 50) +
		'" data-height="' + ($(_td).height() - 4) + '" data-crop="true" data-file=""/>');
	return _droparea;
}

function MakeEditorDialogue(_option){
	return '';
}

function MakeEditorPopover(_option,_ext){
	var fm_popover_postion = "bottom";
	switch (parseInt(_option.windowType)) {
		case 1:
			fm_popover_postion = "left";
			break;
		case 2:
			fm_popover_postion = "right";
			break;
		case 3:
			fm_popover_postion = "top";
			break;
		case 4:
			fm_popover_postion = "bottom";
			break;
		default:
			break;

	}
	
	var btn = '<input type="hidden" name="'+_option.codename+'_id" /><input type="text" data-toggle="popover" data-html="true" readOnly="readOnly" '+_ext+' class="edit transparent" name="' + _option.codename +'" data-placement="'+fm_popover_postion+'" data-original-title=""  />';
	return btn;
}

function MakeEditorFromOption(_td){
	var _eHtml='';
	var ostr = $(_td).attr("fb-options");
	var _option = eval('(' + unescape(ostr) + ')');
	
	if(!_option.placeholder)_option.placeholder='';
	
	var _extract = 	MakeExtractAttrs(_option);
	
	if (_option.codetype == "text") {
		_eHtml ='<input name="' + _option.codename + '" placeholder="'+_option.placeholder+'"'+_extract+' class="edit transparent" />';
	} 
	else if (_option.codetype == "number") {
		_eHtml ='<input name="' + _option.codename + '" placeholder="'+_option.placeholder+'"'+_extract+' class="edit transparent" />';
	} 
	else if (_option.codetype == 'richtext') {
		_eHtml ='<textarea name="' + _option.codename + '" class="editarea"'+_extract+' placeholder="'+_option.placeholder+'"></textarea>';
	} 
	else if (_option.codetype == 'date') {
		_eHtml =MakeEditorDate(_option,_extract);
	}
	else if (_option.codetype == "image") {
		_eHtml =MakeEditorImage(_td,_option,_extract);
	}
	else if (_option.codetype == "checkbox" || _option.codetype == "radio") {
		if(_option.datasourcetype=="list"){
			var arrs = _option.datasourcetsetting.split('\n');
			var _arrs=[];
			for(var i=0;i<arrs.length; i++){
				_arrs.push({id:arrs[i],text:arrs[i]});
			}
			_eHtml = '<div class="groupedit">'+MakeEditorGroup(_option,_arrs,_extract)+'</div>';
		}
	} 
	else if (_option.codetype == "combobox") {
		if(_option.datasourcetype=="list"){
			var arrs = _option.datasourcetsetting.split('\n');
			var _arrs=[];
			for(var i=0;i<arrs.length; i++){
				_arrs.push({id:arrs[i],text:arrs[i]});
			}
			_eHtml = MakeEditorComboBox(_option,_arrs,_extract);
		}
		else if(_option.datasourcetype=="url"){
			_eHtml = MakeEditorComboBox(_option,[],_extract);
		}
		else if(_option.datasourcetype=="tree"){
			_eHtml = MakeEditorComboTree(_option,_extract);
		}
	}
	else if (_option.codetype == "dialogue") {
		if(_option.modalWindow){
			_eHtml = '<a href="javascript:void(0);" onclick="showModalWindow(this)" '+_extract+ '><input type="hidden" name="'+_option.codename+'" />'+$(_td).html()+'</a>';
			_eHtml +=MakeEditorDialogue(_option);
		}
		else{
			_eHtml = MakeEditorPopover(_option);			
		}
	}
	else if(_option.codetype == "_button"){
		_eHtml = MakeTdButton(_td,_option);
	}
	return _eHtml;
}

function MakeTableTds(table){
	var td0=table.find('td:not([fb-options])').eq(0);
	td0.append('<input type="hidden" name="id" />');
	
	table.find('td[fb-options]').each(function() {	
		var eHtml=MakeEditorFromOption(this);
		if(eHtml)
			$(this).html(eHtml);
	});
}

function MakeTableFormOptions(_tableHtml){
	var table=$(_tableHtml);
	MakeTableTds(table);	
	table.find('tr[rowid]').hide();
	return table.html();
}


/**********************对应table-form-action.1.0.1.js的操作************************************/

function MakeTdButton(_td,_option){	
	var href = $(_td).find('a');
	if(href.length==0)
		return '<a href="javascript:void(0);" tar="' + _option.target + '" class="button">' + $(_td).html() + '</a>';
	else{
		href.addClass("button").attr("tar",_option.target);
		return $(_td).html();
	}	
}
