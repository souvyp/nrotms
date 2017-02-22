function MakeExtractAttrs(_option,_readOnly){
	var extractAttr='';  //扩展属性
	if(_option.workflowFlag&&_option.workflowFlag!=="0"){ //流程标志
		extractAttr+=' workflowFlag="'+_option.workflowFlag+'"';
	}
	if(_option.displayname){
		extractAttr+=' title="'+_option.displayname+'"';
	}
	if(_readOnly||_option.readOnly)	//只读标志
		extractAttr+=' readOnly="readOnly"';
	if(_option.edittype!=="editable"&&_option.setting){
		extractAttr+=' calculation="'+escape(encode(_option.setting))+'"';
		if(_option.edittype=="creatcalculation") extractAttr+=' ct="3"';
		//else 
		//	calculation+='readOnly="readOnly"';
	}
	
	if(_option.conditionhiding==2&&_option.conditionhidingcontent){ //隐藏标志（1：隐藏，2：按条件隐藏）
		extractAttr+=' hiddincalc="'+escape(encode(_option.conditionhidingcontent))+'"';
		if(_option.hiddinRow)  //隐藏整行
			extractAttr+='hiddinRow="'+_option.hiddinRow+'"';
	}
	if(extractAttr!==""){
		extractAttr +=' oc="'+_option.codetype+'"' //字段类型
	}
	
	if(_option.conditionhiding==1){  //隐藏标志
		extractAttr +=' style="display:none;"';
	} 
	if(extractAttr.length<10) 
		extractAttr = '';

	return extractAttr;
}

function MakeEditorGroup(_option,_arrs,_ext){
	//var rid = uuid();
	var n = _option.codename;
	var checks='<div class="edit form-control" name="' + n + '" type="' + _option.codetype + '">';		
	for (var i = 0; i < _arrs.length; i++) {
		
		checks += '<label';
		if(_option.datasourcetype=="url"){
			checks+=' style="display:none"';
		}
		checks += '><input type="' + _option.codetype + '" name="' + n + '" value="' + $.trim(_arrs[i]["id"]) + '"'+_ext+' class="edit-list transparent" ';
		
		checks +='/>';
		checks += $.trim(_arrs[i]["text"]) + '</label>';
	}
	checks+='</div>';
	return checks;
}
/*
function TrigerDateEvent(that,options){
	options.choose=function(dates){
		$(that).trigger('change');
	};
	laydate(options);
}*/

function MakeEditorDate(_option,_ext){
	var dateformate= 'YYYY-MM-DD hh:mm:ss';
	if(_option.dateformat)dateformate=_option.dateformat;
	var laydate="{format: '"+dateformate+"'";
	if(_option.istime)
		laydate+=",istime:"+_option.istime; 
	
	if(_option.festival)
		laydate+=",festival:true"; 
	if(_option.dateMin)
		laydate+=",min:"+_option.dateMin; 
	if(_option.dateMax)
		laydate+=",max:"+_option.dateMax;
	if(_option.istoday)
		laydate+=",istoday:true"; 
	laydate+='}';

	var _html = '<input name="' + _option.codename + '" placeholder="'+_option.placeholder+'"' +_ext+' class="laydate-icon edit"';
	if (!_option.readOnly || ( _option.readOnly && _option.readOnly !== "on" ) ){
		_html += ' onclick="TrigerDateEvent(this,'+laydate+')"';
	}
	_html += '/>';
	return _html;
}



function MakeEditorComboBox(_option,_arrs,_ext){
    var _eHtml = '';
	_eHtml +='<input type="hidden" name="' + _option.codename + '" />';//show-tick form-control
	_eHtml += '<select name="' + _option.codename + '_id" ' + _ext + ' class="edit transparent selectCarr show-tick form-control"  data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);" >';
	
	_eHtml += '<option value="&nbsp;">---------------------------</option>';
	
	if(_arrs.length>0){
		var _group = _arrs[0]["group"];
		var _group_old='';
		for (var i = 0; i < _arrs.length; i++) {
			if(_group){
				if(_group_old!==$.trim(_arrs[i]["group"])){
					if(_group_old!=="")
						_eHtml +='</optgroup>';
					_group_old=$.trim(_arrs[i]["group"]);
					_eHtml +='<optgroup label="'+_group_old+'">';
				}
			}

			if ( _option.datasourcetype == 'vml' )
			{
			    _eHtml += '<option value="' + $.trim( _arrs[i].id ) + '">';
			    _eHtml += $.trim( _arrs[i].name ) + '</option>';
			}
			else
			{
			    _eHtml += '<option value="' + $.trim( _arrs[i]["id"] ) + '">';
			    _eHtml += $.trim( _arrs[i]["text"] ) + '</option>';
			}
		}
		if(_group)
			_eHtml +='</optgroup>';
	}

	_eHtml += '</select>';

	return _eHtml;

}

function MakeEditorComboVml( _option, _ext )
{
    var _eHtml;
    var _jsonPara = NSF.System.Json.ToJson( _option.datasourcetsetting );
    NSF.System.Data.RecordSet( "/", _jsonPara, function ( result, config, data )
    {
        if ( result )
        {
            var _rows = data[0].rows;

            if ( _option.linkfield && _option.linkfield != "" && _option.linkcombo && _option.linkcombo != "" )
            {
                _eHtml = MakeEditorComboBox( _option, [], _ext );
            }
            else
            {
                _eHtml = MakeEditorComboBox( _option, _rows, _ext );
            }

        }
    } );
    return _eHtml;
}

function MakeEditorComboTree(_option,_ext){
	var _eHtml='<input type="text" data-toggle="modal" data-target="#win-Common-Dialog" readOnly="readOnly" '+_ext+' class="edit form-control transparent" name="' + _option.codename +'" /> ';
	return _eHtml;		
}

function MakeEditorWebEditor(_td, _option, _ext)
{
	var _eHtml = '<textarea name="' + _option.codename + '" ' + _ext + ' style="width: '+ Math.max(($(_td).width() - 4), 700) + 
	'px;height:' + Math.max($(_td).height() - 4,100) + 'px;visibility:hidden;" class="edit form-control transparent"></textarea>';

	return _eHtml;
}

function MakeEditorImage(_td,_option,_ext){
	var _droparea = $('<input type="file" '+_ext+' class="edit form-control droparea spot" name="' + _option.codename +
		'" data-post="/code/files/uploadify.chi?param=upload&filename='+_option.codename+'" data-width="' + Math.max(($(_td).width() - 4), 50) +
		'" data-height="' + Math.max($(_td).height() - 4,50) + '" data-crop="true" data-file="" />');
	return _droparea;
}

function MakeEditorFile(_td,_option,_ext){
	var _eHtml = '';
	if(_option.characterlength)
		_eHtml+='<input name="'+_option.codename+'"  type="file" multiple="false" >';
	else{
		_eHtml = '<div class="queue"></div>';
		_eHtml+='<input id="'+_option.codename+'_upload" name="'+_option.codename+'" type="file" class="edit form-control"  multiple="true">';
		_eHtml+='<div class="queue_list"></div>';
	}
	return _eHtml;
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
	
	var btn = '<input type="hidden" name="'+_option.codename+'_id"'+_ext+' />';
	btn += '<input type="text" data-toggle="popover" data-html="true" readOnly="readOnly"  class="edit form-control transparent" name="' + _option.codename +'" data-placement="'+fm_popover_postion+'" data-original-title="" />';

	return btn;
}

function MakeNormal(_td,_option){
	var _eHtml = '';
	if(_option.constControl=="address"){
		if(_option.province=="1"){
			_eHtml+='<select name="'+_option.codename+'_province"  class="loc_province selectCarr show-tick"  data-live-search="true" ></select>';
		}
		if(_option.city=="1"){
			_eHtml+='<select name="'+_option.codename+'_city"  class="loc_city selectCarr show-tick" data-live-search="true" ></select>';
		}
		if(_option.district=="1"){
			_eHtml+='<select name="'+_option.codename+'_town"  class="loc_town selectCarr show-tick"  data-live-search="true"></select>';
		}
		if(_option.address=="1"){
			_eHtml+='<input type="text" name="'+_option.codename+'_addr" class="loc_addr edit transparent" style="width: auto;"/>';
		}
	}
	return '<div class="edit transparent" name="'+_option.codename+'_id" type="_normal"><input type="hidden" name="'+_option.codename+'_id" /><input type="hidden" name="'+_option.codename+'" />'+_eHtml+'</div>';
}

function MakeEditorFromOption(_td,_option,_readOnly){
	var _eHtml='';
	
	var verify = _ConfigVerify(_option);
	
	var f_opts = {code:_option.codename,type:_option.codetype,etype:_option.edittype,len:_option.characterlength};
			
	if(!_option.placeholder)_option.placeholder='';
	
	var _extract = 	MakeExtractAttrs(_option,_readOnly);
	
	if (_option.codetype == "text") {
		_eHtml ='<input name="' + _option.codename + '" placeholder="'+_option.placeholder+'"'+_extract+' class="edit form-control transparent" />';
	} 
	else if (_option.codetype == "number") {
		_eHtml ='<input name="' + _option.codename + '" placeholder="'+_option.placeholder+'"'+_extract+' class="edit form-control transparent" />';
	} 
	else if (_option.codetype == 'richtext') {
		_eHtml ='<textarea name="' + _option.codename + '" class="edit form-control transparent"'+_extract+' placeholder="'+_option.placeholder+'"></textarea>';
	} 
	else if (_option.codetype == 'date') {
		_eHtml =MakeEditorDate(_option,_extract);
	}
	else if (_option.codetype == "image") {
		_eHtml =MakeEditorImage(_td,_option,_extract);
	}
	else if (_option.codetype == "editor")
	{
		_eHtml = MakeEditorWebEditor(_td, _option, _extract);
	}
	else if(_option.codetype == "file") {
		_eHtml =MakeEditorFile(_td,_option,_extract);
	}
	else if (_option.codetype == "checkbox" || _option.codetype == "radio") {
		f_opts.cls=_option.datasourcetype;
		f_opts.url=_option.datasourcetsetting;
		f_opts.id=_option.optValue;
		f_opts.text=_option.optText;
		if(_option.datasourcetype=="list"){
			var arrs = _option.datasourcetsetting.split('\n');
			var _arrs=[];
			for(var i=0;i<arrs.length; i++){
				var _arr=arrs[i].split('=');
				if(_arr.length==2)
					_arrs.push({id:_arr[0],text:_arr[1]});
				else
					_arrs.push({id:arrs[i],text:arrs[i]});
			}
		    _eHtml = '<div class="groupedit">'+MakeEditorGroup(_option,_arrs,_extract)+'</div>';
		}
		else{
			_eHtml = '<div class="groupedit">'+MakeEditorGroup(_option,[{id:'',text:''}],_extract)+'</div>';
		}
	} 
	else if (_option.codetype == "combobox") {
		if(_option.datasourcetype=="list"){
			var arrs = _option.datasourcetsetting.split('\n');
			var _arrs=[];
			for(var i=0;i<arrs.length; i++){
				var _arr=arrs[i].split('=');
				if(_arr.length==2)
					_arrs.push({id:_arr[0],text:_arr[1]});
				else
					_arrs.push({id:i,text:arrs[i]});
			}
			_eHtml = MakeEditorComboBox(_option,_arrs,_extract);
		}
		else if(_option.datasourcetype=="url"){
			
			f_opts.cls=_option.datasourcetype;
			f_opts.url=escape(_option.datasourcetsetting);
			f_opts.id=_option.optValue;
			f_opts.text=_option.optText;
			f_opts.linkfield= _option.linkfield;
			f_opts.linkcombo=_option.linkcombo;
			
			_eHtml = MakeEditorComboBox(_option,[],_extract);
		}
		else if(_option.datasourcetype=="tree"){
			_eHtml = MakeEditorComboTree(_option,_extract);
		}
		else if ( _option.datasourcetype == "vml" )
		{
		    f_opts.cls = _option.datasourcetype;
		    f_opts.vml = escape( _option.datasourcetsetting );
		    f_opts.id = _option.optValue;
		    f_opts.text = _option.optText;
		    f_opts.linkfield = _option.linkfield;
		    f_opts.linkcombo = _option.linkcombo;

		    _eHtml = MakeEditorComboVml( _option, [], _extract );
		}
	}
	else if (_option.codetype == "dialogue") {
		f_opts.cls=_option.datasourcetype;
		f_opts.url=escape(_option.datasourcetsetting);
		f_opts.vals=_option.pushValus;
		f_opts.outputurl=_option.outputurl;
		f_opts.optionsson=_option.optionsson;
		f_opts.modalWindow=_option.modalWindow;
		f_opts.multiple=_option.multiple;
		if(_option.modalWindow){
			var tdHtml = $(_td).html();
			if(tdHtml=="")
				_eHtml = '<input type="text" onclick="showModalWindow(this)" '+_extract+ ' class="edit form-control transparent" name="'+_option.codename+'" />';
			else
				_eHtml = '<a href="javascript:void(0);" onclick="showModalWindow(this)" '+_extract+ ' class="edit"><input type="hidden" name="'+_option.codename+'" />'+$(_td).html()+'</a>';
			_eHtml +=MakeEditorDialogue(_option);
		}
		else{
			_eHtml = MakeEditorPopover(_option,_extract);			
		}
	
	}
	else if(_option.codetype == "_button"){
		_eHtml = MakeTdButton(_td,_option);
	}
	else if(_option.codetype == "_normal"){
		_eHtml = MakeNormal(_td,_option);
	}
	if(_eHtml){
		var oHtml=$.trim($(_td).html());
		if(oHtml!==""){
			if(oHtml.indexOf('{{FB}}')>=0){
				var _th = oHtml.split('{{FB}}');
				_eHtml='<table class="innerTable"><tr><td>'+_th[0]+'</td><td>'+_eHtml+'</td>';
				if(_th.length>0)_eHtml+='<td>'+_th[1]+'</td>';
				_eHtml+='</table>';
			}
			//_eHtml=oHtml.replace('{{FB}}','<div class="innerEdit">'+_eHtml+'</div>');
		}
		$(_td).html(_eHtml);
		$(_td).find('.edit').attr('f-options',JsonToStr(f_opts)).attr('verify',JsonToStr(verify));
	}
}


function MakeTableTds(table,_readOnly){
	var td0=table.find('td').eq(0);
	var defaults='';
	table.find('td[fb-options]').each(function() {	
		var ostr = $(this).attr("fb-options");
		var _option = eval('(' + ostr + ')');
		if(_option.edittype=='editable'){
			var setting=_option.setting;
			if(setting){
				if(defaults!=="")defaults+='\n';
				defaults+=_option.codename+'='+setting;
			}
		}
	    MakeEditorFromOption( this, _option,_readOnly );
		//$(this).attr('title',_option.displayname);
		$(this).removeAttr('fb-options');
	});
	td0.attr('default',escape(defaults));	
}

function MakeTableFormOptions(_tableHtml,_toolbar){
	var table=$(_tableHtml);
	table.find('td').each(function(){
		if($(this).css('display')=="none"){
			$(this).remove();
		}
	});
	var cols=table.find('colgroup col').length;
	$('<tr><td colspan="'+cols+'"><input type="hidden" name="id" />'+_toolbar+'</td></tr>').insertBefore(table.find('tr:eq(0)'));
	MakeTableTds(table);	
	table.find( 'tr[rowid]' ).hide();
	table.find('.ui-state-highlight').removeClass('ui-state-highlight');
	//table.find('td').attr('bgcolor','#FFF');
	return  $(table.viewSource(true)).html();
}


/**********************对应table-form-action.1.0.1.js的操作************************************/

/***************************************加密****************************************/
var encodeNumber = 6521;
function encode(code) {
	return code;
	code = code.replace(/[\r\n]+/g, '');
	code = code.replace(/'/g, "\\'");
	var tmp = code.match(/\b(\w+)\b/g);
	tmp.sort();
	var dict = [];
	var i, t = '';
	for(var i=0; i<tmp.length; i++) {
	if(tmp[i] != t) dict.push(t = tmp[i]);
	}
	var len = dict.length;
	var ch;
	for(i=0; i<len; i++) {
	ch = num(i);
	code = code.replace(new RegExp('\\b'+dict[i]+'\\b','g'), ch);
	if(ch == dict[i]) dict[i] = '';
	}
	return "eval(function(p,a,c,k,e,d){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]e(c);k=[function(e){return d[e]}];e=function(){return'\\\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\\\b'+e(c)+'\\\\b','g'),k[c]);return p}("
	+ "'"+code+"',"+encodeNumber+","+len+",'"+ dict.join('')+"'.split(''),0,{}))";
}

function num(c) {
	return(c<encodeNumber?'':num(parseInt(c/encodeNumber)))+((c=c%encodeNumber)>35?String.fromCharCode(c+29):c.toString(36));
}



function run(code) {
	eval(code);
}

function decode(code) {
	code = code.replace(/^eval/, '');
	return eval(code);
}

function MakeTdButton(_td,_option){	
	var _e=encode(_option.ExecuteCode);
	if(_option.innerText){
		$(_td).html(_option.innerText);
		var href = $(_td).find('a');
		href.addClass("edit").addClass("innerButton").attr("tar",_option.target).attr("href","javascript:void(0);").attr("executecode",escape(_e));
		return $(_td).html();
	}
	else{
		var href = $(_td).find('a');		
		if(href.length==0)
			return '<a href="javascript:void(0);" tar="' + _option.target + '" name="'+_option.codename+'" class="button edit" executecode="'+escape(_e)+'">' + $(_td).html() + '</a>';
		else{
			href.addClass("button").attr('name',_option.codename).attr("tar",_option.target).attr("href","javascript:void(0);");
			return $(_td).html();
		}	
	}
}
