function makeScript(script){
	if(script&&script!=""){
		script=script.replaceAll('&quot;','"');
		return makeDefaultEvent(script);
	}
	return '';
}

function makeDefaultEvent(script){
	script=script.replaceAll('#add#','if(typeof(__grid)=="object")AddGrid(__grid);else AddForm(__form);');
	script=script.replaceAll('#edit#','EditGrid(__grid)');
	script=script.replaceAll('#addChild#','AddTree(__grid)');
	script=script.replaceAll('#delete#','if(typeof(__grid)=="object")DeleteGrid(__grid);else DeleteForm(__form);');
	script=script.replaceAll('#post#','if(typeof(__grid)=="object")postForm(__grid.form,__grid.Path,__grid.Code,__grid);else SaveForm(__form);');
	script=script.replaceAll('#search#','search(__grid)');
	script=script.replace('#import(xls)#','ImportXls(__grid)');
	script=script.replace('#export(xls)#','ExportXls(__grid)');
	script=script.replace('childGrid(','childGrid(__grid,');
	return script;
}

function search(grid){
	grid.showFindDialog();
}

function AddGrid(grid){
	grid.showFormDialog();
}

function EditGrid(grid){
	var rows=grid.getSelections();
	if(grid.IsList){
		if(!rows)
			alert('请选择一行进行操作！');
		else
			grid.showFormDialog(rows);
	}
	else{
		if(!rows||rows.length!==1){
			alert('请选择一行进行操作！');
		}
		else{
			grid.showFormDialog(rows[0]);
		}
	}
}

function AddTree(grid){
	var rows=grid.getSelections();
	if(grid.IsList){
		if(!rows)
			alert('请选择父节点！');
		else{
			var node=grid.getSelected();
			if(node.isLeaf)
				alert('子节点不能新增下级节点');
			else
				grid.showFormDialog(null,rows.id);
		}
	}
	else{
		if(rows.length!==1){
			alert('请选择父节点！');
		}
		else{
			var node=grid.getSelected();
			if(node.isLeaf)
				alert('子节点不能新增下级节点');
			else
				grid.showFormDialog(null,rows[0].id);
		}
	}
}
function ExecuteSQL(grid,sql){
	mask();
	var url=grid.FormUrl;
	if(!url)url=grid.Url;
	get(url,{param:'execsql',sql:sql},'json',function(data){
		unmask();	
		if(data.msg)
			alert(data.msg);
		else if(grid.FormUrl){
			grid.refresh();
		}
	})
}

function DeleteGrid(grid){
	function deletegrid(){
		$.messager.confirm('删除确认', '确实要进行删除操作?', function(r){
				if (r){
					
					var ids = [];
					for(var i=0;i<rows.length;i++){
						ids.push(rows[i][grid.Keys]);
					}
					var idList="'"+ids.join("','")+"'";
					mask();
					get(grid.Url,{param:'delete',path:grid.Path,code:grid.Code,key:grid.Keys,ids:idList},'json',function(data){
						unmask();	
						if(data.msg)
							alert(data.msg);
						else{
							if(grid.IsTree){	
								grid.remove(wid);
							}
							else{
								grid.refresh();
							}
						}
					})
				}
			});
	}
	
	var rows=grid.getSelections();
	if(grid.IsList){
		if(!rows)
			alert('请至少选择一行！');
		else{
			var wid=rows[grid.Keys];
			var cld=grid.getChildren(wid);
			if(cld&&cld.length>0){
				alert('请先删除子节点！');
			}
			else {
				rows=[rows];
				deletegrid();
			}
		}
	}
	else{
		if(rows.length<1){
			alert('请至少选择一行！');
		}
		else{
			var wid=rows[0][grid.Keys];
			if(grid.IsTree){
				
				grid.expand(wid,function(){
					var cld=grid.getChildren(wid);
					if(cld&&cld.length>0){
						alert('请先删除子节点！');
					}
					else {
						deletegrid();
					}
				});
				
			}
			else deletegrid();
			
		}
	}
}

function AddForm(form,parentID){

	form.form.form('clear');
	form.isNews=true;
	form.form.isNews=true;
	form.form.parentID=parentID;
	mask();
	var code=form.Code;

	var ta=$('textarea');
	for(var i=0;i<ta.length;i++){
		if($(ta[i]).attr('tag')==14){
			if(!$(ta[i]).inited){
				$(ta[i]).inited=true;
				$(ta[i]).xheditor({tools:'mini'});
			}
		}
		else $(ta[i]).val();
	}
	var url=form.Url;
	if(form.FormUrl)url=form.FormUrl
	get(url,{param:'default',path:form.Path,__DataCode:code,"parentID":parentID,"fkey":form.parentVal},'json',function(data){
		unmask();	
		var def={};
		if(form.Default)
			def=StringToJson(form.Default);
		for(var key in def){
			var Lkey=key.toLowerCase();
			data[Lkey]=def[key];
			var field=form.RealCode+'_fld_'+Lkey;
			try{
				$('#'+field).attr('disabled','disabled');
			}catch(e){};
			try{
				$('#'+field).combobox('disable');
			}catch(e){};
			try{
				$('#'+field).numberbox('disable');
			}catch(e){};
			try{
				$('#'+field).datebox('disable');
			}catch(e){};
			try{
				$('#'+field).timespinner('disable');
			}catch(e){};
		}	
		form.form.form('load',data);
		if(form.navLoaded){
			form.navLoaded(null,form.key);
		}
	});
	
}

function DeleteForm(form){
	mask();
	get(form.NavUrl,{param:'delete',path:form.Path,code:form.Code,key:form.key,ids:"'"+$('#'+form.Code+'_fld_'+form.key).val()+"'"},'json',function(data){
		unmask();	
		//form.navData(null,1);
	})		
}


function SaveForm(form){
	postForm(form.form,form.Path,form.Code,null,function(data){
		var isNews=form.isNews;
		if(isNews){
			$('#'+form.RealCode+'_fld_'+form.key).val(data.id);
			form.isNews=false;
			var opt=$('#nav_'+form.RealCode).pagination('options');
			$('#nav_'+form.RealCode).pagination('refresh',{  
				total:opt.total+1,
				pageNumber:opt.total+1,
				afterPageText:' 条/ 共'+(opt.total+1)+'条记录'
			});
			form.navLoaded(data.rows[0],form.key);
		}
	});
}

function postForm(form,path,code,grid,h){
	mask();	
	var ta=$('textarea');
	for(var i=0;i<ta.length;i++){
		$(ta[i]).val();
	}
	var isNewItem=form.isNews;
	form.form('submit', {
		url: form.FormUrl+'?param=save&isnew='+isNewItem+'&path='+path+'&__DataCode='+code,
		onSubmit: function(){
			var isValid = $(this).form('validate');
			if (!isValid){
				unmask();	
			}
			return isValid;	
		},
		success: function(data){
			unmask();	
			try{
				var data = eval('(' + data + ')');
				if(data.success){
					form.isNews=false;
					if(data.msg)
						alert(data.msg);
					else{
						if(grid){
							if(grid.IsTree){
								if(form.parentID!=""){
									var d=data.rows[0];
									var pid=d.id;
									if(form.isNews){
										grid.refresh(form.parentID);
										//grid.expand();
									}
									else{
										delete d["id"];			
										grid.update(pid,d);
									}
								};
							}
							else if(grid.IsGrid){
								if(isNewItem)
									grid.refresh();
								else{
									grid.updateRow(data.rows[0]);
								}
							}
							else if(grid.IsList){
								var d=data.rows[0];
								var pid=d.id;
								if(isNewItem)
									grid.refresh();
								else{
									delete d["id"];	
									grid.update(pid,d);
								}
							}
						}
						if(h)
							h(data);
						else {
							form.dialog('close');
						}
					}
				}
			}
			catch(e){
				try{
				if(grid)grid.refresh();
				}catch(e){}
				//alert('b');
				form.dialog('close');
			}
		},
		complete: function(XMLHttpRequest, textStatus){
			unmask();	
		},
		error: function(){
			unmask();	
		}
	});
}


function postFindForm(form,path,code,grid){
	mask();	
	form.form('submit', {
		url: form.FormUrl+'?param=find&path='+path+'&__DataCode='+code,
		success: function(data){
			unmask();	
			
		},
		complete: function(XMLHttpRequest, textStatus){
			unmask();	
		},
		error: function(){
			unmask();	
		}
	});
}

function ImportXls(grid){
	var body=$('body');
	var form=$('<form method="post" enctype="multipart/form-data" style="display:none;"></form>').appendTo(body);
	var file=$('<input type="file" name="file_path" class="file"/>').appendTo(form);
	var ie = !-[1,];  
	file.bind('change',function(){
		mask();	
		form.form('submit', {
			url: grid.FormUrl+'?param=import&path='+grid.Path+'&__DataCode='+grid.Code,
			success: function(data){
				unmask();					
				file.remove();
				form.remove();
				var d=jQuery.parseJSON(data);
				alert(d.msg);
			},
			complete: function(XMLHttpRequest, textStatus){
				unmask();	
			},
			error: function(){
				unmask();	
			}
		})
	});
	if(ie){  	
		file.trigger('click').trigger('change');  
	}else{  
		file.trigger('click');  
	}   	
}

function ExportXls(grid){
	grid.exportXls();
	/*
	mask();
	get(grid.Url,{param:'data',path:grid.Path,code:grid.Code},'json',function(data){
		unmask();	
		Json2CSV(data.rows);
	})		*/
}

function Json2CSV(objArray)
{
  var 
	getKeys = function(obj){
	  var keys = [];
	  for(var key in obj){
		keys.push(key);
	  }
	  return keys.join();
	}//, objArray = format_json(objArray)
	, array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray
	, str = ''
  ;

  for (var i = 0; i < array.length; i++) {
	var line = '';
	for (var index in array[i]) {
	  if(line != '') line += ','
   
	  line += array[i][index];
	}

	str += line + '\r\n';
  }

  str = getKeys(objArray[0]) + '\r\n' + str;

  var a = document.createElement('a');
  var blob = new Blob([str], {'type':'application\/octet-stream'});
  a.href = window.URL.createObjectURL(blob);
  a.download = 'export.csv';
  a.click();
  return true;
}

function DownloadJSON2CSV(objArray)
{
	var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;

	var str = '<table>';
	for (var i = 0; i < array.length; i++) {
		var line = '<tr>';

		for (var index in array[i]) {
			line += '<td>'+array[i][index] + '</td>';
		}

		line.slice(0,line.Length-1); 

		str += line + '</tr>';
	}
	str+='</table>';
	window.location = "data:text/csv;charset=utf-8;filename=data.csv,"+encodeURIComponent(str);
	//window.open("data:text/csv;charset=utf-8," + encodeURIComponent(str))
}

