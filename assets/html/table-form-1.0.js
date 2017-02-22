/*
	_row_add(row, prow, css)   复制row对象，在prow后面新增一行
	row : 源行
	prow: 在prow后面插入    修正以后，此对象不需要(根据row对象，自动计算出位置）
	css: 新对象的class
	返回新行对象
*/

function _row_add(row, prow, css) {
	var nid = row.attr("rowid");
	var nrow = row.clone().removeAttr('rowid');
	if (css) nrow.addClass(css);
	nrow.attr("nrowid", nid);
	var idbtn=nrow.find('input[type="hidden"][name="id"]');
	if(idbtn.length==0)
		nrow.find('td:eq(0)').append('<input type = "hidden" name="id" value="'+uuid()+'" />');
	else
		idbtn.val(uuid());
	//nrow.insertAfter(prow);
	var rows=row.parent().find('[nrowid="'+nid+'"]');
	if(rows.length>1){
//		console.log(rows.eq(rows.length-1));
		nrow.insertAfter(rows.eq(rows.length-1));   //根据row对象，自动计算出位置
	}
	else
		nrow.insertAfter(prow);
	nrow.show();
	return nrow;
}

/*
	_action_add(that, btn)    新增行操作
	that : 多余的对象
	btn: 操作按钮
*/

function _action_add(that, btn) {
	var row = $('tr[rowid="' + btn.attr("tar") + '"]');
	var _cfg = row.attr('fb-options');
	_cfg = StrToJson(_cfg);
	if (!_cfg)
	{
		_cfg = {};
	}
			
	//maxrows
	var _maxRows = _cfg.maxrows;
	if (!_maxRows)
	{
		_maxRows = 10;
	}

	var _curRows = 0;
	var _rows = $('tr._added');
	if (_rows)
	{
		_curRows = _rows.length;
	}
	if (_curRows < _maxRows)
	{
		var table = _row2table(row);
		if (table)
		{
			var datas=table.attr("code");
			_empty_rows_add( row, row, "_added", datas, 1 );
		}
	}
}

/*
	_action_clone(that, btn)   根据btn按钮在后面复制一行
	that : btn所在的td
	btn: 按钮对象
*/

function _action_clone(that, btn) {
	var row = $('tr[rowid="' + btn.attr("tar") + '"]');
	var nrow = _row_add(row, $(that).parent(), "_cloned");
	nrow.children('td').each(function(index) {
		var v = $(that).parent().children('td').eq(index).find('.edit').val();
		$(this).attr("v", v);

	})
	_form_makeEditor(nrow, '');   //此调用需要优化，待优化
}

var _deleteRows=[];					//删除的行对象 ，全局变量需调整，建议绑定到table的dom对象上去 table._deleteRows;

function _action_delete(that, btn) {
	var tr=$(that).parent();
	var idbtn=tr.find('input[type="hidden"][name="id"]');
	if(idbtn.length==1)
		_deleteRows.push({name:tr.attr("nrowid"),id:idbtn.val()});
	tr.remove();
}

function _action_clear(that, btn) {
	var tr=$(that).parent();
	var idbtn=tr.find('input[type="hidden"][name="id"]');
	if(idbtn.length==1)
		_deleteRows.push({name:tr.attr("nrowid"),id:idbtn.val()});
	
	tr.find('input[type!="hidden"]:not([readonly])').val('');
	tr.find('select').val('');
}


/*
	_form_makeEditor(obj, tag ,_data,inited)  根据obj对象初始化table-form，递归调用
	obj:table tr对象
	tag:obj 下面的 tag 标识，用来查找需要初始化的对象 
	_data：初始化对象时对应的数据
	inited：是否为第一次调用
*/

function _form_makeEditor(obj, tag ,_data,inited) {
	if (tag !== "") {   //如果tab不为空，标识是table
		obj.find('tr[rowid]').each(function() {
			var rowid = $(this).attr('rowid');
			$(this).hide();                      //隐藏所有的有rowid标识的行
		})
	} 
	var nid;									//主单的唯一标识
	var ftd = obj.find('td:eq(0)');
	if (ftd.length == 1 ){				//在table的第一个tr的第一个td里面增加一个name=id的隐藏对象用来存储主键(id)值

		if(_data){
			nid=_data.id;
		}
		if(!nid)nid=uuid();
		var idbtn=obj.find('input[type="hidden"][name="id"]');
		if(idbtn.length==0)
			ftd.append('<input type = "hidden" name="id" value="'+nid+'" />');
		else	
			idbtn.val(nid);

	}
			
	var defaults='';
	obj.find(tag + 'td[fb-options]').each(function() {		//根据fb-options自动生成对象
		var ostr = $(this).attr("fb-options");
		options = eval('(' + unescape(ostr) + ')');
		var v = $(this).attr('v');
		if(_data&&options.codename){
			v=_data[options.codename.toLowerCase()];
		}
		if (!v) {
			v = '';
		}
		
		$(this).removeAttr('v');
		$(this).removeAttr('fb-options');
		if(!options.placeholder)options.placeholder='';
		//console.log(options.codetype)
		var calculation='';
		if(options.workflowFlag){calculation+=' workflowFlag="'+options.workflowFlag+'"';}
		if(options.readOnly)calculation+=' readOnly="readOnly"';
		if(options.edittype!=="editable"&&options.setting){
			calculation+=' calculation="'+escape(options.setting)+'"';
			if(options.edittype=="creatcalculation") calculation+=' ct="3"';
			//else 
			//	calculation+='readOnly="readOnly"';
		}
		
		if(options.conditionhiding==2&&options.conditionhidingcontent){
			calculation+=' hiddincalc="'+escape(options.conditionhidingcontent)+'"';
			if(options.hiddinRow)
				calculation+='hiddinRow="'+options.hiddinRow+'"';
		}
		if(calculation!==""){
			calculation +=' oc="'+options.codetype+'"'
		}
		if(options.conditionhiding==1){
			calculation +=' style="display:none;"';
		}
		if (options.codetype == "_button") {
			var btn = $('<a href="javascript:void(0);" tar="' + options.target + '" '+calculation+' class="button">' + $(this).html() + '</a>');
			$(this).html('');
			if (options.ExecuteCode == "#add#") {
				var that = this;
				btn.appendTo($(this)).on('click', function() {
					_action_add(that, $(this));
				});
			} else if (options.ExecuteCode == "#clone#") {
				var that = this;

				btn.appendTo($(this)).on('click', function() {
					_action_clone(that, $(this));

				});
			} else if (options.ExecuteCode == "#delete#")
			{
				var that = this;
				btn.appendTo($(this)).on('click', function()
				{
					_action_delete(that, $(this));
				});
			}
			else if (options.ExecuteCode == "#clear#")
			{
				var that = this;
				btn.appendTo($(this)).on('click', function()
				{
					_action_clear(that, $(this));
				});
			}
			else if (options.ExecuteCode == "#save#") {
				var that = this;
				btn.appendTo($(this)).on('click', function() {
					SaveFormData(that, $(this));
				})
			} else if (options.ExecuteCode == "#postwf#") {
				var that = this;
				btn.appendTo($(this)).on('click', function() {
					postToWF($(that).parents('table'), $(this));
				})
			}else {
				var ws = (options.ExecuteCode);
				btn.appendTo($(this)).on('click', function() {
					eval(ws);
				})
			}
		} else if (options.codetype == "text") {
			$('<input name="' + options.codename + '" value="' + v + '" placeholder="'+options.placeholder+'"'+calculation+' class="edit transparent"/>').appendTo($(this));
		} else if (options.codetype == "number") {
			$('<input name="' + options.codename + '" value="' + v + '" placeholder="'+options.placeholder+'"'+calculation+' class="edit transparent"/>').appendTo($(this));
		} else if (options.codetype == "combobox") {
			var selects = '<input type="hidden" name="'+options.codename+'" />';
			selects += '<select name="' + options.codename + '_id" '+calculation+' class="edit transparent" onchange="pushDisplayValue(this);';
			/*2015/05/20 联动菜单 郭红亮*/
			selects += '_DoComboLinking( this );'
			selects += '"';
			if (options.linkfield)
			{
				selects += ' linkfield="' + options.linkfield + '"';
			}
			if (options.linkcombo)
			{
				selects += ' linkcombo="' + options.linkcombo + '"';
			}
			if (options.linkfield && options.linkcombo)
			{
				var _opt = JsonToStr(options);
				_opt = escape( _opt );

				selects += ' fb-options="';
				selects += _opt;
				selects += '"';
			}
			/*2015/05/20 联动菜单 郭红亮*/
			selects += '>';
		
			if(options.datasourcetype=="list"){
				var arrs = options.datasourcetsetting.split('\n');
				
				selects += '<option value="">请选择</option>';
				for (var i = 0; i < arrs.length; i++) {
					selects += '<option value="' + arrs[i] + '"';
					if (v == arrs[i])
						selects += ' selected';
					selects += ' >' + arrs[i] + '</option>';
				}	
				selects += '</select>';
				$(selects).appendTo($(this));
			}
			else if(options.datasourcetype=="url"){
				/*2015/05/21 下拉菜单代码整理 郭红亮*/
				if (options.linkfield && options.linkcombo)
				{
					//联动菜单不处理初始显示
					selects += '<option value="">请选择</option>';
					selects += '</select>';
					$(selects).appendTo($(this));
				}
				else
				{
					var that=this;
					var url = options.datasourcetsetting;
					$('<img src="/assets/img/loading.gif" class="waiting" />').appendTo($(that));

					OnlineData({},function(data)
					{
					    selects += _ShowComboWithUrlData( options, data, v );
						
						selects += '</select>';

						$(that).find('.waiting').remove();
						
						$(selects).appendTo($(that));					
					},url);
				}
				/*2015/05/21 下拉菜单代码整理 郭红亮*/
			}
			else if(options.datasourcetype=="tree"){
				var that=this;
				var url = options.datasourcetsetting;
				var _DataID=options.optValue;
				var _DataValue=options.optText;
				var ddID=uuid();
				var data_content='<div class="mindMapTree"></div>';
				var btn='<input type="text" data-toggle="modal" data-target="#win-'+ddID+'" readOnly="readOnly" '+calculation+' value="'+v+'" class="edit transparent" pushValus="'+escape(options.pushValus)+'" name="' + options.codename +'" /> ';
				$(btn).appendTo($(that));
				$('<div class="modal fade text-center" id="win-'+ddID+'" style="z-index:1041;">'+
					  '<div class="modal-dialog" style="display: inline-block; width: auto;">'+
						'<div class="modal-content">'+
						  '<div class="modal-header">'+
							'<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
							'<h4 class="modal-title">信息</h4>'+
						  '</div>'+
						  '<div class="modal-body" style="text-align:left;min-width:500px;min-height:300px;max-width:'+($(window).width()-200)+'px;max-height:'+($(window).height()-200)+'px;overflow:auto;">'+data_content+
						  '</div>'+
						  '<div class="modal-footer">'+
							'<button class="btn btn-sm btn-default " type="button" onclick="inputDlgTreeValue(\''+ddID+'\')">确定</button>  '+
							'<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>'+
							'<button class="btn btn-sm btn-default cleaninput" type="button" onclick="cleanDlgTreeValue(this)">清空</button>  '+
						  '</div>'+
						'</div>'+
					  '</div>'+
					'</div>').appendTo($(that));
					
					$('#win-'+ddID).on('show.bs.modal', function (e) {
						if(!$(this).attr('table-gened')){
							$(this).attr('table-gened',1);
							var thatDlg=this;
							OnlineData({},function(data){
								var instance = $(thatDlg).find('.mindMapTree').jstree({
								"checkbox" : {
								  "keep_selected_style" : true
								}, 
								'core' : {
									'data' : data.root?data.root:data,
									'force_text' : false,
									'themes' : {
										'responsive' : true,
									}
								},
								"plugins" : [ "wholerow" ]
							  });
							},url)
						}
					});
			}
			
		} else if (options.codetype == "checkbox" || options.codetype == "radio") {
			var checks = '';
			var va=v.split(',');
			if(options.datasourcetype=="list"){
				var arrs = options.datasourcetsetting.split('\n');
				var rid = uuid();
				
				for (var i = 0; i < arrs.length; i++) {
					var cid = uuid();
					checks += '<span class=item>';
					var n = options.codename;
					if (options.codetype == "radio") n = n + '+' + rid;
					checks += '<input type="' + options.codetype + '" id="' + cid + '" name="' + n + '" value="' + arrs[i] + '"'+calculation+' class="edit-list transparent" ';
					if (va.indexOf(arrs[i])>=0)
						checks += ' checked';
					checks += '/><label for="' + cid + '" >' + arrs[i] + '</label></span>';
				}
				$(checks).appendTo($(this));
			}
			else if(options.datasourcetype=="url"){
				
				var that=this;
				var url = options.datasourcetsetting;
				var _DataID=options.optValue;
				var _DataValue=options.optText;
				var _opt=options;
				$('<img src="/assets/img/loading.gif" class="waiting" />').appendTo($(that));
				OnlineData({},function(data){
					var rid = uuid();
					var rows=makeRemoteData(data);
					if(rows.length>0){						
						if(!_DataID){
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
						for(var i=0 ; i<rows.length;i++){
							var cid = uuid();
							checks += '<span class=item>';
							var n = _opt.codename;
							if (_opt.codetype == "radio") n = n + '+' + rid;
							checks += '<input type="' + _opt.codetype + '" id="' + cid + '" name="' + n + '" value="' + rows[i][_DataID] + '"'+calculation+' class="edit-list transparent"' ;
							if (va.indexOf(rows[i][_DataValue])>=0)
								checks += ' checked';
							checks += '/><label for="' + cid + '" >' + rows[i][_DataValue] + '</label></span>';
						}
					
					}
					$(that).find('.waiting').remove();
					$(checks).appendTo($(that));					
					
				},url);
			}
		} else if (options.codetype == 'date') {
			var dateformate= 'YYYY-MM-DD hh:mm:ss';
			if(options.dateformat)dateformate=options.dateformat;
			var laydate="laydate({format: '"+dateformate+"'";
			laydate+=",istime:"+options.istime; 
			if(options.festival)
				laydate+=",festival:true"; 
			if(options.dateMin)
				laydate+=",min:"+options.dateMin; 
			if(options.dateMax)
				laydate+=",max:"+options.dateMax;
			if(options.istoday)
				laydate+=",istoday:true"; 
			laydate+='})';
			$('<input name="' + options.codename + '" placeholder="'+options.placeholder+'" value="'+v+'"'+calculation+' class="laydate-icon edit" onclick="'+laydate+'" />').appendTo($(this));
		} else if (options.codetype == 'richtext') {
			$('<textarea name="' + options.codename + '" class="editarea"'+calculation+' placeholder="'+options.placeholder+'">'+v+'</textarea>').width($(this).width() - 4).height($(this).height() - 4).appendTo($(this));
		} else if (options.codetype == "image") {
			var _droparea = $('<input type="file" '+calculation+' class="droparea spot" name="' + options.codename +
				'" data-post="/code/files/uploadify.chi?param=upload&filename='+options.codename+'" data-width="' + Math.max(($(this).width() - 4), 50) +
				'" data-height="' + ($(this).height() - 4) + '" data-crop="true" data-file="'+v+'"/>');
			_droparea.appendTo($(this));
			initDroparea(_droparea);
		} else if (options.codetype == "file") {	
			var FileInput=$('<div class="form-group"><input name="'+options.codename+'" multiple class="file edit" '+calculation+' type="file"></div>');
			FileInput.appendTo($(this));
			$(this).addClass("fileContainer");
			FileInput.find('.file').fileinput({
				uploadUrl: '#', // you must set a valid URL here else you will get an error
				//allowedFileExtensions : ['jpg', 'png','gif'],
				overwriteInitial: false,
				maxFileSize: 1000,
				maxFilesNum: 10,
				//allowedFileTypes: ['image', 'video', 'flash'],
				slugCallback: function(filename) {
					return filename.replace('(', '_').replace(']', '_');
				}
			});
		
		} else if (options.codetype == "dialogue") {
			if(options.modalWindow){
				var ddID=uuid();
				var btn = '<a href="#" data-toggle="modal" data-target="#win-'+ddID+'" '+calculation+ ' pushValus="'+escape(options.pushValus)+'"><input type="hidden" name="'+options.codename+'" />'+$(this).html()+'</a>';
				$(this).html('');
				//<input type="text" data-toggle="modal" data-target="#win-'+ddID+'" readOnly="readOnly" '+calculation+' value="'+v+'" class="edit transparent" pushValus="'+escape(_options.pushValus)+'" name="' + options.codename +'" /> ';
			
				var that=this;
				var url = options.datasourcetsetting;
				var _options=options;
								

				var code=url.split('/');
				code = code[1];



				OnlineData({param:"file",path:url+'/default.head'},function(head){

					var data_content = '';		
					
					data_content += '<table class="table" cellspacing="0" width="100%" code="'+code+'" id="'+ddID+'"> ';
					data_content += '<thead>';
					data_content += '<tr>';
					//data_content +='<th fld="id">#</th>'+head;
					data_content += head;
					data_content += '</tr>';
					data_content += '</thead>';
					data_content += '<tbody>';

					data_content += '</tbody>';

					data_content += '</table>';
					$(btn).appendTo($(that));				
					
					$(that).find('.waiting').remove();
					
					$('<div class="modal fade text-center" id="win-'+ddID+'" style="z-index:1041">'+
					  '<div class="modal-dialog" style="display: inline-block; width: auto;">'+
						'<div class="modal-content">'+
						  '<div class="modal-header">'+
							'<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
							'<h4 class="modal-title">信息</h4>'+
						  '</div>'+
						  '<div class="modal-body" style="max-width:'+($(window).width()-200)+'px;max-height:'+($(window).height()-200)+'px;overflow:auto;">'+data_content+
						  '</div>'+
						  '<div class="modal-footer">'+
							'<button class="btn btn-sm btn-default " type="button" onclick="inputDlgValue(\''+ddID+'\')">确定</button>  '+
							'<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>'+
							'<button class="btn btn-sm btn-default cleaninput" type="button" onclick="cleanDlginput(\''+ddID+'\')">清空</button>  '+
						  '</div>'+
						'</div>'+
					  '</div>'+
					'</div>').appendTo($(that));
					
					$('#win-'+ddID).on('show.bs.modal', function (e) {
						var cal=_options.pushFilter;
						var v='';
						if(cal){
							var v=calcItem($(that).parents('table'),$(that),cal);
						}
						if(!$(this).attr('table-gened')){
							$(this).attr('table-gened',1);
							$('#'+ddID).attr("fld",v);
							makeDataTableList($('#'+ddID),2);	
						}
						else
							makeDataTableFilter($('#'+ddID),v);
					});
				},FILE_URL,'html');
			}
			else{
				var btn = '<input type="hidden" name="'+options.codename+'_id" /><input type="text" data-toggle="popover" data-html="true" readOnly="readOnly" '+calculation+' value="'+v+'" class="edit transparent" name="' + options.codename +'" data-placement="buttom"';
				btn += 'data-original-title=""  ';
				btn += '/> ';
				
				var that=this;
				var url = options.datasourcetsetting;
			//	$('<img src="/assets/img/loading.gif" class="waiting" />').appendTo($(that));
				var _options=options;
				

				OnlineData({},function(head){
					
					var fm_popover_postion = "";
					var max_width,max_height;
					switch (parseInt(_options.windowType)) {
						case 1:
							fm_popover_postion = "left";
							max_width=500;
							max_height=500;
							break;
						case 2:
							fm_popover_postion = "right";
							max_width=500;
							max_height=500;
							break;
						case 3:
							fm_popover_postion = "top";
							max_width=1000;
							max_height=320;
							break;
						case 4:
							fm_popover_postion = "bottom";
							max_width=1000;
							max_height=320;
							break;
						default:
							break;

					}
					var data_content = '';		
					
					if(_options.datasourcetype=="url"){
						data_content += '<div class="popoverinner"><table class="table table-bordered table-hover table-condensed"> ';
						data_content += '<thead>';
						data_content += '<tr>';
						data_content += '<th>#</th>';
						var ds = data.data[1].fields;
						//var ds = head.root.children;
						var fields=[];
						for(var i=0;i<ds.length;i++){
							if(ds[i].keys){
								fields.splice(0,0,ds[i]);
							}
							else if(ds[i].visible){
								fields.push(ds[i]);
								data_content += '<th>'+ds[i].displayname+'</th>';
							}
						}

						data_content += '</tr>';
						data_content += '</thead>';
						data_content += '<tbody>';

						var rows=data.data[0].rows;
						for(var i=0;i<rows.length;i++){
							data_content += '<tr onclick="selectTrRow(this)">';
							for(var j=0;j<fields.length;j++){
								if(j==0)
									data_content += '<td><input type="radio" value="'+rows[i][fields[1].fieldname.toLowerCase()]+'" name="approve"/></td>';
								else
									data_content += '<td>'+rows[i][fields[j].fieldname.toLowerCase()]+'</td>';
							}
							data_content += '</tr>';
						}
						data_content += '</tbody>';

						data_content += '</tr>  ';
						data_content += '</table></div>';
					}
					else
						data_content='<div style="width:500px;height:300px;overflow:auto;"><div class="mindMapTree"></div></div>';
					data_content += '<div align="center" style="padding-top:10px;">  ';
					data_content += '<button class="btn btn-sm btn-default " type="button" onclick="inputTreeValue(this)" full>确定</button>  ';
					data_content += '<button class="btn btn-sm btn-default" type="button" onclick="hideprover(this)">取消</button>  ';
					data_content += '<button class="btn btn-sm btn-default cleaninput" type="button" onclick="cleaninput(this)">清空</button>  ';
					data_content += '</div>  ';
					$(btn).appendTo($(that));				
					
					$(that).find('.waiting').remove();
					
					var popover = $(that).find('[data-toggle="popover"]');
					popover.attr('data-content', data_content);
					popover.attr('data-placement', fm_popover_postion);
					popover.popover();
					if(_options.datasourcetype=="tree"){
						function makeTreePopover(){
							var treeData=that.treeData;
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
							
							if(!that.treeData||true){
							
							    OnlineData( {}, function ( data )
							    {
							        that.treeData = data.root ? data.root : data;
									makeTreePopover();
								},url);
									
							}else
								makeTreePopover();
						})
					}

				},url);
			}

		}
		if(options.edittype=='editable'){
			var setting=options.setting;
			if(setting){
				if(defaults!=="")defaults+='\n';
				defaults+=options.codename+'='+setting;

			}
		}
		
		_ConfigVerify(options);
	});

	calcDefault(obj,nid,defaults);
	
}

/*
	calcDefault(obj,nid,defaults)  根据obj对象，计算出默认值
	obj：待计算默认值的对象
	nid：数据的id，如果nid为GUID格式，标识是新增的行。
	defaults:默认值的公式字符串
*/
	
function calcDefault(obj,nid,defaults){
	if(nid&&nid.length>10&&defaults){
		var _obj=obj;
		OnlineData({param:'def',def:defaults}, function(html){
			if(html){
					var arr=html.split('\n');
					for(var i=0;i<arr.length;i++){
						var arr1=arr[i].split('=');
						var t=getTableItemFromName($(_obj),arr1[0]);
						if(t.length==1)
							t.val(arr1[1]);
						else {
							for(var j=0;j<t.length;j++){
								var arr2=arr1[1].split(',');
								if(arr2.indexOf(t.eq(j).val())>=0)
									t[j].checked=true;
							}
						}
					}
					
				}
			}, TABLE_URL ,'html');
	}
}


/*
	以下为吴健编写的代码，待研究，主要是弹出对话框的确定或者取消或者关闭按钮
*/
function pushDisplayValue(select){
	$(select).prev().val($(select).find("option:selected").text());
}

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
	                if ( select[0].text.indexOf( "span" ) != -1 )
	                {
	                    _str += select[0].text.split( '>' )[1].split( '<' )[0];
	                }
	                else
	                {
	                    _str += instance.get_text( select[0] );
	                }
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

/*
	_table_make_width(table, w) 根据w，重新计算table-form的宽度
*/

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

/*
	郭红亮
*/

function _empty_rows_add(row, prow, css, datas, amount)
{
	for (var i = 0; i < amount; i++)
	{
		var nrow = _row_add(row, prow, css);
		_form_makeEditor(nrow, '',datas[row.attr('rowid')],true);
	}

	var _table = _row2table(row);
	if (_table)
	{
		calcTable(_table);
	}

	return;
}

function _row2table(row)
{
	if (!row)
	{
		return null;
	}
	
	return row.closest("table");
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

	if ( urldata.root )
	{
	    var rows = urldata.root.children;
	    for ( var i = 0 ; i < rows.length; i++ )
	    {
	        selects += '<option value="' + rows[i].id + '"';
	        selects += ' >' + rows[i].text + '</option>';
	    }
	}
	else
	{
	    var rows = makeRemoteData( urldata );
	    if ( rows.length > 0 )
	    {
	        if ( !_DataID )
	        {
	            var n = 0;
	            for ( var key in rows[0] )
	            {
	                if ( n == 0 )
	                    _DataID = key;
	                else if ( n == 1 )
	                {
	                    _DataValue = key;
	                    break;
	                }

	                n++;
	            }
	        }

	        if ( !_DataValue )
	            _DataValue = _DataID;

	        for ( var i = 0 ; i < rows.length; i++ )
	        {
	            var _show = true;

	            //按联动要求过滤选项
	            if ( options.linkfield )
	            {
	                var _curVal = rows[i][options.linkfield];
	                if ( _curVal )
	                {
	                    if ( flt == _curVal )
	                    {
	                        _show = true;
	                    }
	                    else
	                    {
	                        _show = false;
	                    }
	                }
	            }

	            if ( _show )
	            {
	                selects += '<option value="' + rows[i][_DataID] + '"';
	                if ( val == rows[i][_DataID] )
	                    selects += ' selected';
	                selects += ' >' + rows[i][_DataValue] + '</option>';
	            }
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





/*
	initTableFormData(table,datas,isPosted)  根据datas配置信息 ，初始化table-form 对象
	
	isPosted:表单是否提交
	以下都是初始化table的函数
*/
function initTableFormData(table,datas,isPosted) {
	var code=table.attr("code");
	if(datas[code])
		_form_makeEditor(table, 'tr:not([rowid]) ',datas[code][0],true);
	else
		_form_makeEditor(table, 'tr:not([rowid]) ',true);

	table.find('tr[rowid]:hidden').each(function() {
		var row = $(this);
		if (table.find('tr[nrowid="' + row.attr('rowid') + '"]').length == 0) {
			var _data=datas[row.attr('rowid')];
			var _cfg = row.attr('fb-options');
			_cfg = StrToJson(_cfg);
			if (!_cfg)
			{
				_cfg = {};
			}
			
			//初始行数在此处添加
			var _initRows = _cfg.initialRows;
			if (!_initRows)
			{
				_initRows = 1;
			}

			//maxrows
			var _maxRows = _cfg.maxrows;
			if (!_maxRows)
			{
				_maxRows = 10;
			}
			if (_initRows > _maxRows)
			{
				_initRows = _maxRows;
			}

			if(_data&&_data.length>0){
				for(var i=0;i<_data.length;i++){
					var nrow = _row_add(row, row, "_added");
					_form_makeEditor(nrow, '',_data[i],true);
				}
				
				if (_data.length < _initRows)
				{
					_empty_rows_add( row, row, "_added", datas, _initRows - _data.length );
				}
			}
			else{
				_empty_rows_add( row, row, "_added", datas, _initRows );
			}
		}
	});
}

function initTableForm(table,mid) { //初始化表单
	var code=table.attr("code");
	table.attr('path','trend/'+code);
	var id;
	if(mid)
		id=mid;
	else
	{
		id=getUrlParam("id");
	}

	if (table)
	{
		var tblId = table.attr("id");
		makeToolbar(tblId, null, 'form');
	}

	if(id){
		var datas=code;
		table.find('tr[rowid]').each(function() {
			var row = $(this);
			if (table.find('tr[nrowid="' + row.attr('rowid') + '"]').length == 0) {
				datas+=","+row.attr('rowid');
			}
		});
		
		datas+=',_workflow';  //获取工作流数据
		OnlineData({param:'datas',datas:datas,id:id},function(data)
		{
			var _nodedata=data._workflow;
			if(_nodedata){			
				delete data._workflow;
				
				if(_nodedata.length==1){					//有流程
					_nodedata=_nodedata[0];	
					
					initWorkFlowFromData(table,_nodedata, 	//初始化流程
							function(result){
								//console.log(result);
								initTableFormData(table,data,true);
							},
							function(){
								alert('没有查看此数据的权限');//没有找到用户对应的节点
								table.hide();
							}
						)
						
					/*OnlineData({param:'sessions',sessions:'orga,dept,user'},function(sessions){
						var _rdata=sessions;
						
						initWorkFlowFromData(table,_nodedata,_rdata, 	//初始化流程
							function(result){
								//console.log(result);
								initTableFormData(table,data,true);
							},
							function(){
								alert('没有查看此数据的权限');//没有找到用户对应的节点
								table.hide();
							}
						)
					},TABLE_URL);*/
					
				}
				else
					initTableFormData(table,data,false);
			}
			else
				initTableFormData(table,data,false);
			
			
			
			calcTable(table);
		},TABLE_URL);
	}
	else
		initTableFormData(table,{},false);


		
	calcTable(table);
	
	table.find('tbody').delegate(".edit,.edit-list,.editarea","change",function(){
		calcTable(table,this);
	});
}

function initTableFromCode(_form,_path,mid){

	OnlineData({param:'file',path:_path},function(html){
		if(html){
			_form.html(html);
			if(_form.attr('widthtar')){
				var master=$(_form.attr('widthtar'));
				if(master.length==1)
					_table_make_width(_form,master.width());
			}
			initTableForm(_form,mid);
		}
	},FILE_URL,'html')
}

