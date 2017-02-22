
/*
	makeRemoteData(data)	  		  	//将data格式化成表单标准的json对象
	data: 待处理的json对象

	返回结果：//json格式对象

*/

function makeRemoteData(data,level){
	var rows;

	if(data.root){
		rows=data.root.children; //mindmap
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
	else if(data.viewentry){	//notes
		var entry=data.viewentry;
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
	else
		rows=data;

	return rows;
}

/*
	makeData(obj)	  		  	//将指定的obj对象格式化为标准json对象
	obj: 待序列化的对象

	返回结果：//json格式对象

*/

function makeData(obj) {
	var form = $('<form></form');
	obj.wrap(form);
	var data = obj.parent().serializeObject();
	for(var key in data){
		 if(data[key] instanceof Array) 
		 {
			data[key]=data[key].join(',');
		 }
	}
	obj.unwrap();
	return data;
}

/*
	wrapFormData(table)	  		  //将表单内容格式化为标准json对象
	table: table-form 对象
	convert:是否转换为template识别对象
	返回结果：//格式			  //格式:[{name:"表名",data:{表单数据}},{name:"表名",data:{表单数据}}]
								  //第一个对象标识主表，其他的有name标识都为从表，主表的主键为id（自增列），从表的外键为did（bigint)

*/

function wrapFormData(table,convert,onlyMain){
	var name = table.attr("code");
	var datas = [];
	var master = {};
	table.find('tr:not([rowid]):not([nrow])').each(function() {
		var code=$(this).attr('rowid');
		if(!code) code=$(this).attr('nrowid');
		if(!code){
			var wdata = makeData($(this));
			for (var key in wdata)
				master[key] = wdata[key];
		}
	});
	var data = {};
	data.name = name;
	data.data = master;
	datas.push(data);

	if(!onlyMain){
		var detail = [];
		var orgCode = '';
		table.find('tr[nrowid]').each(function() {
			var code = $(this).attr("nrowid");

			if (code&&this.isDirty) {
				if (orgCode == "") orgCode = code;
				if (orgCode !== code) {
					var data = {};
					data.name = orgCode;
					data.data = detail;
					datas.push(data);
					detail = [];
					orgCode = code;
				}
				var wdata = makeData($(this));
				var d = {}
				for (var key in wdata)
					d[key] = wdata[key];
				detail.push(d);
			}
		})
		var data = {};
		if(orgCode!==""){
		data.name = orgCode;
		data.data = detail;
		datas.push(data);
		}
	}
	if(convert){
		var wdata=datas[0].data;
		for(var i=1;i<datas.length;i++){
			wdata[datas[i].name]=datas[i].data;
		}
		return wdata;
	}
	else{
		var queueList=table.find('.queue_list');
		if(queueList.length==1&&queueList[0].isDirty){
			var AttFiles = [];
			queueList.find('a').each(function(){
				AttFiles.push({
					id : this._file.id,
					name : name,
					filestatus : this._file.filestatus,
					index : this._file.index,
					filename : this._file.name,
					uid : this._file.uid,
					size : this._file.size,
					type : this._file.type,
					creationdate : (new Date(this._file.creationdate)).format("yyyy-MM-dd hh:mm:ss"),
					modificationdate :  (new Date(this._file.modificationdate)).format("yyyy-MM-dd hh:mm:ss")
				})
				
				
			})
			datas.push({name:'_files',data:AttFiles});
		}
		
		
		return datas;
	}
}

/*
	SaveFormData(table, btn)  //保存按钮操作函数
	table: table 对象
	that: 保存按钮对象
*/

function SaveFormData(table, that) { 

	if($(that).attr('btn-clicked'))
	{
		return;
	}
	
	var _chk = _VerifyForm(table);
	if (!_chk)
	{
		return;
	}

	$(that).attr('btn-clicked','1');
	//setTimeout(function(){$(that).removeAttr('btn-clicked');},500);
	
	var datas=wrapFormData(table);

	datas.push({"delete":_deleteRows});
	
	SaveDataToDB(datas,function(data){
		$(that).removeAttr('btn-clicked');
		if(data.success==true){
			var keys=data.keyid;
			var keyV ='';
			if(keys){
				var keyArr = keys.split(",");
				for(var i=0;i<keyArr.length;i++){
					keyV = keyArr[i].split('=');
					$('input[type="hidden"][name="id"][value="'+keyV[0]+'"]').val(keyV[1]);
				}
			}
			
			datas[0].data.id=keyV[1];
			if($('body').attr('workflow'))
				initWorkFlow(table,null,datas[0].data);  //初始化流程
			alert('保存成功!');
		}
		else{
			alert(unescape(data.errors));
		}
	});
}

/*
	SaveDataToDB(datas,_handle)   //将表单内容保存到数据库
	datas: 数据对象				  //格式:[{name:"表名",data:{表单数据}},{name:"表名",data:{表单数据}},{"delete":{name:"表名",id:"主键数据"}}]
								  //第一个对象标识主表，其他的有name标识都为从表，主表的主键为id（自增列），从表的外键为did（bigint)
								  //标识是"delete"对象的标识需要删除的内容
	_handle(data) 				  //data标识服务器返回的结果
*/

function SaveDataToDB(datas,_handle,params){     
	var pms = {param: 'save',data: JSON.stringify(datas)};
	if(params){
		for(var key in params){
			pms[key]=params[key];
		}
	}
	Mask('正在提交数据,请稍候...');
	OnlineData(pms, function(data) {
		UnMask();
		if(_handle)_handle(data);
		
	}, TABLE_URL);
}


function FindTableDetailNames(table){
	var res='';
	table.find('tr[rowid]').each(function() {
		var code = $(this).attr("rowid");
		if (code) {
			if(res!=="")res+=',';
			res+=code;
		}
	})
	return res;
}