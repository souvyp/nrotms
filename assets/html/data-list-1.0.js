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


function InitList(_list,_listInner,_template,_code,_url){
	var cou=_list.find('.jplist-drop-down [options]').length;
	if(cou==0)
		makeList(_list,_listInner,_template,_code,_url);
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
					makeList(_list,_listInner,_template,_code,_url);
				}
			},url);
		})
	}
};

function makeList(_list,_listInner,_template,_code,_url){	
	var _opt = getUrlParam('opt');
	if(!_opt)_opt='';
	var $list = _listInner
				, template = Handlebars.compile(_template);
			_list.jplist({
				itemsBox: '.list'
				, itemPath: '.list-item'
				, panelPath: '.jplist-panel'
				, dataSource: {
				type: 'server'
				, server: {
					ajax: {
						url: _url?_url:'/code/data/table.chi?param=list&data='+_code+'&opt='+_opt
						, dataType: 'json'
						, type: 'POST'
						}				
				}				
				, render: function (dataItem, statuses) {
					if(!_url){

						$list.html(template(dataItem.content));
					}
					else{
						var data = dataItem.responseText;
						var dataNotes = eval('('+data+')');
						var rData = makeRemoteData(dataNotes);
						$list.html(template(rData));
					}
				}
			}
		});
		

		$list.delegate('tr', 'click',function (e) {
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
			else if(e.target.tagName=="BUTTON"){
				var btn=e.target;
				var ev = makeScript($(btn).attr('ev'));
				try{
					_keyid = $(this).find('td:first-child input').val();
					eval(ev);
				}
				catch(e){
					console.log(e);
				}
				
			}
		});
}

function makeScript(ev){
	var script = unescape(ev);
	script = script.replaceAll('#add#','AddRowTable(_code)');
	script = script.replaceAll('#edit#','EditRowTable(_code,_keyid)');
	script = script.replaceAll('#delete#','DeleteRowTable(_code,_keyid)');
	return script;
}

function RefreshData(){
	setTimeout(function(){
		$('#demo').find('button.jplist-reset-btn').click();
	},300);
}

function DeleteRowTable(_code,_keyid){
	OnlineData({param: 'delete',data: _code,ids:_keyid}, 
		function(data) {
			if(data.success==true){
				RefreshData();
			}
		}
	,TABLE_URL);
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

function selectRadioData(){
	var tr = $('.jptable tr.selected');
	if(tr.length==1){
		return tr;
	}
	else
		alert('请选择一行');
}

