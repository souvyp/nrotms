var __customWorkFlowURL = '/code/data/table.chi?param=lists&data=';
var __customURL = '/code/data/table.chi?param=list&data=';

/*
	makeRemoteData(data)	  		  	//将data格式化成表单标准的json对象
	data: 待处理的json对象

	返回结果：//json格式对象

*/

function makeRemoteData(data,level){
	var rows;
	
	if(data["@timestamp"]){	//notes
		var entry=data.data;
		rows=[];
		for(var i=0;i<entry.length;i++){
			var row={};
			if(entry[i].entrydata){
			    for ( var j = 0; j < entry[i].entrydata.length; j++ )
			    {
			        if ( entry[i].entrydata[j]['text'] )
			        {
			            row[entry[i].entrydata[j]['@name']] = entry[i].entrydata[j]['text']['0'];
			        }
			        else if ( entry[i].entrydata[j]['number'] )
			        {
			            row[entry[i].entrydata[j]['@name']] = entry[i].entrydata[j]['number']['0'];
			        }
				}
			}
			rows.push(row);
		}
		
	}
	else if(data.root){ //mindmap
		rows=data.root.children; 
		if(level==2){
			var grows=[];
			for(var i=0;i<rows.length;i++){
				var child=rows[i].children;
				if(child){
					for(var j=0;j<rows[i].children.length;j++){
						var row=rows[i].children[j];
						row.group=rows[i].text;
						grows.push(row);
					}
				}
			}
			rows=grows;
		}
	}
	else if(data.data)
		rows = data.data;		//zimo	
	else if (data.rows)
		rows = data.rows;		//zimo
	else
		rows=data;

	return rows;
}


function InitList(_list,_listInner,_template,_code,_url,_type,_handle){
	var cou=_list.find('.jplist-drop-down [options]').length;
	if(cou==0)
		makeList(_list,_listInner,_template,_code,_url,_type,_handle);
	else{
		var icou=0;
		_list.find('.jplist-drop-down [options]').each(function(){
			var ostr = $(this).attr("options");
			options = eval('(' + unescape(ostr) + ')');
			
			var url = options.datasourcetsetting;
			var that=this;

			OnlineData({},function(data){

				var _DataID=options.optValue;
				var _DataValue=options.optText;
				var li='';
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

					if(!_DataValue)
						_DataValue=_DataID;

					for(var i=0 ; i<rows.length;i++){
						li+='<li><span data-path="'+rows[i][_DataID]+'">'+rows[i][_DataValue] +'</span></li>';
					}
					$(that).append(li);	
				}
				
				icou++;
				if(icou==cou){
					makeList(_list,_listInner,_template,_code,_url,_type,_handle);
				}
			},url);
		})
	}
};

function makeList(_list,_listInner,_template,_code,_url,_type,_handle){	

	var _defURL=__customURL;
	if($('body').attr('workflow'))
		_defURL=__customWorkFlowURL;
	var _opt = getUrlParam('opt');
	if(!_opt)_opt='';
	var $list = _listInner
				, $template = template.compile(_template);
			_list.jplist({
				itemsBox: '.list'
				, itemPath: '.list-item'
				, panelPath: '.jplist-panel'
				, dataSource: {
				type: 'server'
				, server: {
					ajax: {
						url: _url?_url:_defURL+_code+'&opt='+_opt
						, dataType: _type?_type:'json'
						, type: 'POST'
						}	
					/*, serverOkCallback: function(responseText, statuses){
						console.log(responseText,statuses);
						return {};
					}	*/					
				}			
				
				, render: function (dataItem, statuses) {
					if(_handle){
						
						var data = dataItem.responseText;
						var dataTemplate = eval('('+data+')');
						$list.html($template(dataTemplate));
						_handle(dataItem.responseText,$template);
					}
					else if(!_url){
						var data = dataItem.responseText;
						var dataTemplate = eval('('+data+')');
						$list.html($template(dataTemplate));
					}
					else if(_url.indexOf('notes.chi')>0){
						var data = dataItem.responseText;
						var dataNotes = eval('('+data+')');
						var rData = makeRemoteData(dataNotes);
					//	rData={count:dataNotes.count,data:rData};
						$list.html($template(rData));
					}
					else
					{
						var data = dataItem.responseText;
						var dataTemplate = eval('('+data+')');
						$list.html($template(dataTemplate));
					}
					
					/*
					由子框架的高宽决定对话框的高度，有点小Bug
					*/
					if (self != top)
					{ 
						var frm=parent.document.all("win-Common-Dialog");
						if(!frm.inited){
							frm.inited=true;
							var maxH =Math.max(300,Math.min(document.body.scrollHeight,$(parent.document).height()-100));
							var maxW =Math.min(document.body.scrollWidth,$(parent.document).width()-100);
							$(frm).find('.content').height(maxH+30); 
							$(frm).find('.content iframe').height(maxH); 
							$(frm).find('.content').width(maxW+20); 
							$(frm).find('.content iframe').width(maxW); 	
						}						
					}
				}
			}
		});
		

		$list.delegate('tr', 'click',function (e) {
				
			if($(this).parent()[0].tagName!=="THEAD"){
				
				if(e.target.tagName=="TD"){
					$list.find('tr').removeClass('selected');
					var checkbox= $(this).find('td:first-child input[type="checkbox"]');
					if(checkbox.length==1){
						checkbox[0].checked=!checkbox[0].checked;
						if(checkbox[0].checked)
						$(this).addClass('selected');
					}
					else {
						var radio= $(this).find('td:first-child input[type="radio"]'); 

						if(radio.length==1){
							radio[0].checked=true;
							$(this).addClass('selected');
						}  
					}
				}
			}
			if(e.target.tagName=="BUTTON"){
				var btn=e.target;
				var ev = makeScript($(btn).attr('ev'));
				try{
					_keyid = $(this).find('td:first-child input').val();
					_sts=$(btn).attr('sts');
					if(!_sts)_sts='';
					eval(ev);
				}
				catch(e){
					console.log(e);
				}
				
			}
		});
}

function makeScript(ev){
    var script = unescape( ev );
	script = script.replaceAll('#add#','AddRowTable(_code)');
	script = script.replaceAll('#edit#','EditRowTable(_code,_keyid)');
	script = script.replaceAll('#delete#','DeleteRowTable(_code,_keyid,_sts)');
	script = script.replaceAll('#deleteNDT#','DeleteRowTableNDT(_code,_keyid,_sts,__vmlId)');
	return script;
}

function RefreshData(sts){
	if(sts==0)sts="0";
	if(sts)
		$('input[data-button="#opt_status-search-button"]').val(sts);
	setTimeout(function(){		
		$('#opt_status-search-button').click();
	},100);
}

function DeleteRowTableNDT(_code,_keyid,_sts,__vmlId)
{
	Modal.confirm(
	{
		msg: "是否删除数据？"
	}).on( function (e)
	{
		if(e)
		{
			Modal.wait(
			{
				msg: "请等待..."
			}).on( function (e)
			{
				var _pml = [{}];
				_pml[0].namespace = 'protocol';
				_pml[0].cmd = 'data';
				_pml[0].id = __vmlId;
				_pml[0].version = 1;
				_pml[0].paras = [{}];
				_pml[0].paras[0].name = "id";
				_pml[0].paras[0].value = _keyid;
				
				//do delete
				OnlineData(JsonToStr(_pml), function(data)
				{
					if(data[0].result==true)
					{
						RefreshData();
					}
					Modal.hide();
				},"/Portal.aspx");
			});
		}
	});
}

function DeleteRowTable(_code,_keyid,_sts){
	Modal.confirm(
  {
    msg: "是否删除数据？"
  })
  .on( function (e) {
		//alert("返回结果：" + e);
	   if(e){
		   Modal.wait(
		  {
			msg: "请等待..."
		  })
		  .on( function (e) {
				OnlineData({param: 'delete',data: _code,ids:_keyid,sts:_sts}, 
					function(data) {
						if(data.success==true){
							RefreshData();
						}
						 Modal.hide();
					}
					
				,TABLE_URL);
		  })
	   }
	});
}

function EditRowTable(_code,_keyid){
	window.location.href="./edit.chi?id="+_keyid;
}

function AddRowTable(_code){

	window.location.href="./edit.chi";
}

//全选取消全选
function checkDataAll(obj){
    var table=$(obj).parents('table');
    table.find('tbody tr td:first-child input[type="checkbox"]').each(function(){
		this.checked = obj.checked;
	});
}

function selectTrData(){
	var	tr = [];
	$(".jptable input[name='id']:checked").each(function(){
		tr.push($(this).closest('tr'));
	})
	if (tr.length > 0)
	{
		return tr;
	}
	else
	{
		tr = $('.jptable tr.selected');
		if(tr.length==1){
			return [tr];
		}
		else
			alert('请选择至少一行');
	}
}
