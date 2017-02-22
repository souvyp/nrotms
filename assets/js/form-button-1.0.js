
function MakeButtonAction(_btn,_handle){
	var table=$(_btn).closest('table');
	var tar=$(_btn).attr("tar");
	if(tar)
		_btn.row=table.find('tr[rowid="'+tar+'"]');
	_btn.td=$(_btn).closest('td');
	$(_btn).on('click', function() {
		var that=this;
		var _execute = $(_btn).attr('executecode');
		_execute = unescape(_execute);
		console.log(_execute);
		var ws = makeDefaultEvent(_execute);
		try{
			eval(ws);
		}
		catch(e){
			console.log(e);
		}
	});
	if(_handle)_handle(true);
}

function initToolbarButton(table){
	table.find('.toolbar a[ev]').each(function(){
		this.td=$(this).closest('td');
		var _btn=this;
		$(_btn).on('click', function() {
			var that=this;
			var _execute = $(_btn).attr('ev');
			_execute = unescape(_execute);
			
			var ws = makeDefaultEvent(_execute);
			try{
				eval(ws);
			}
			catch(e){
				console.log(e);
			}
		});
	})
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
	var nrow = row.clone().removeAttr( 'rowid' );
	/*if ( $( 'table' ).find( 'td[name="button"]' ).length > 1 )
	{
	    nrow.find( 'td[name="button"]' ).html( '<a href="javascript:void(0);" tar="TMS_OrderGoods" name="delete" class="button edit" executecode="%23delete%23" f-options="{\'code\':\'delete\',\'type\':\'_button\',\'etype\':\'\',\'len\':\'\'}" verify="{}">删除</a>' );
	}*/

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
	
	initNrowList(nrow);
	
	return nrow;
}


/*
	_action_clone(row, btn)   根据btn按钮在后面复制一行
	row : btn所在的row
	btn: 按钮对象
*/

function _action_clone(row, btn) {
	var prow = btn.closest('tr');
	var nrow = _row_add(prow,prow,"_cloned");
	var idbtn=nrow.find('input[type="hidden"][name="id"]');
	idbtn.val( uuid() );
}

var _deleteRows=[];					//删除的行对象 ，全局变量需调整，建议绑定到table的dom对象上去 table._deleteRows;

function _action_delete(row, btn) {
	var prow = btn.closest('tr');
	var keyname = "id";
	if (prompt)
	{
		var keyname = prow.attr( "nrowkey");
		if (!keyname)
		{
			keyname = "id";
		}
	}

	var idbtn=prow.find('input[type="hidden"][name="' + keyname + '"]');
	if(idbtn.length==1){
		if(idbtn.val().length<16)
			_deleteRows.push({name:prow.attr("nrowid"),id:idbtn.val()});
	}
	prow.remove();
}

function _action_clear(row, btn) {	
	var prow = btn.closest('tr');
	var idbtn=prow.find('input[type="hidden"][name="id"]');
	if(idbtn.length==1)
		if(idbtn.val().length<16)
			_deleteRows.push({name:prow.attr("nrowid"),id:idbtn.val()});
	
	prow[0].isDirty=false;
	prow.find('input[type!="hidden"]:not([readonly])').val('');
	prow.find('select').each(function(){
		if(this.inited)
			$(this).selectpicker('val','');
		else	
			$(this).val('');
	})
	calcTable(prow.closest('table'));
}

function makeDefaultEvent(script){
	script=script.replaceAll('#add#','_row_add(that.row);');
	script=script.replaceAll('#save#','PostFormDataToDB(that);');
	script=script.replaceAll('#saveNDT#','PostFormDataToNDT(that, __saveNdtCfg);');
	script=script.replaceAll('#clone#','_action_clone(that.row,$(that));');
	script=script.replaceAll('#delete#','_action_delete(that.row, $(that));');
	script=script.replaceAll('#deleteNDT#','_action_deleteNDT(that.row, $(that));');
	script=script.replaceAll('#clear#','_action_clear(that.row, $(that));');
	script=script.replaceAll('#print#','printTable(that);');
	return script;
}

function PostFormDataToDB(that){
	var table=$(that.td).closest('table');
	SaveFormData(table, $(that));
}

function PostFormDataToNDT(that, config)
{
	var table=$(that.td).closest('table');
	SaveFormDataNDT(table, $(that), config);
}