
var __CREATESQL;

function makeStructs1(table) { //自动生成数据库字段配置
	var name = table.attr("code");
	table.find('tr[rowid]').hide();
	var struct = {};
	__CREATESQL = '';
	var options = table.find('tr:visible td[fb-options]');
	struct.master = {
		name: name,
		data: makeStruct(options, name)
	};
	struct.details = [];
	_form_makeEditor(table, 'tr:visible ');
	table.find('tr[rowid]:hidden').each(function() {
		var data = makeStruct($(this).find('td[fb-options]'), $(this).attr("rowid"), true, name);
		struct.details.push({
			name: $(this).attr("rowid"),
			data: data
		});
		var row = $(this);
		if (table.find('tr[nrowid="' + row.attr('rowid') + '"]').length == 0) {
			var nrow = _row_add(row, row, "_added");
			_form_makeEditor(nrow, '');
		}
	})

	//console.log(__CREATESQL);
	//var str=JSON.stringify(struct);
	OnlineData({
		param: 'exesql',
		sql: __CREATESQL
	},function(data){
		if(data.success){
			alert('数据库结构生成成功!');
		}
	});
	//OnlineData({param:'ft',data:str},function(){},TABLE_URL);
	//OnlineData({param:'exesql',sql:"exec chi_form_tb '"+str+"'"});
	//return struct;
}


function makeStructs(table){
	var name = table.attr("code");
	table.find('tr[rowid]').hide();
	var struct = {};
	__CREATESQL = '';
	$('.formcontainer').show();
	var options = table.find('tr:visible td .edit[f-options]');

	struct.master = {
		name: name,
		data: makeStruct(options, name)
	};
	struct.details = [];
	table.find('tr[rowid]:hidden').each(function() {
		var data = makeStruct($(this).find('td .edit[f-options]'), $(this).attr("rowid"), true, name);
		struct.details.push({
			name: $(this).attr("rowid"),
			data: data
		});
	})

	OnlineData({
		param: 'exesql',
		sql: __CREATESQL
	},function(data){
		if(data.success){
			alert('数据库结构生成成功!');
		}
	});
}

function makeStruct(options, name, isDetail, masterName) {
	struct = [];
	if (__CREATESQL !== "")
		__CREATESQL += "\n";
	//__CREATESQL+="DROP TABLE [dbo].["+name+"];\n";
	__CREATESQL += "if not exists (select * from sysobjects where type='U' and name='" + name + "')\n";
	__CREATESQL += "begin\n"
	__CREATESQL += "CREATE TABLE [dbo].[" + name + "](\n";
	__CREATESQL += "[Id] [BIGINT] IDENTITY(1,1) NOT NULL,\n";
	
	var csql = '';
	
	if (isDetail){
		__CREATESQL += "[dId] [BIGINT] NULL,\n";
	}
	else{
		__CREATESQL += "[opt_user] [NVARCHAR] (50),\n";
		csql += "if not exists (select * from syscolumns where id=object_id('" + name + "') and name='opt_user') \nbegin\n"
		csql += "ALTER TABLE [" + name + "] ADD [opt_user]  [NVARCHAR] (50);\n";
		csql += "end\n";
		//csql +="EXEC sp_dropextendedproperty 'MS_Description', 'SCHEMA', dbo, 'table',"+name+", 'column','opt_user'\n"
		//csql +="EXEC sp_addextendedproperty 'MS_Description', '操作用户', 'SCHEMA', dbo, 'table', '"+name+"', 'column', 'opt_user'\n";
		__CREATESQL += "[opt_status] [int] default 0,\n";
		/*csql += "if not exists (select * from syscolumns where id=object_id('" + name + "') and name='opt_status') \nbegin\n"
		csql += "ALTER TABLE [" + name + "] ADD [opt_status]  [int];\n";
		csql += "end\n";
		csql +="ALTER TABLE "+name+" ADD  CONSTRAINT [DF_"+name+"_opt_status]  DEFAULT ((0)) FOR [opt_status]\n";*/
	}
	
	options.each(function() {
		try {
			var fbO = $(this).attr("f-options");
			var data = eval('(' + fbO + ')');
			var fld = {};
			var sql = '';
			fld.cn = data.code;
			fld.desc = $(this).attr('title');
			if (fld.cn) {
				var ct = data.type;
				if (ct !== "_button" && data.etype!=="viewcalculation") {
					fld.cl = data.len;
					
					if (ct == "number") {
						fld.ct = "n";
						sql = '[FLOAT]';
					} else if (ct == "richtext") {
						fld.ct = "t";
						sql = '[NTEXT]';
					} else if (ct == "date") {
						fld.ct = "d";
						sql = '[DATETIME]';
					} 
					else if (ct == "combobox" || ct =="dialogue" || ct == "checkbox" || ct == "radio" || ct == "_normal") {
						fld.ct = "c";
						var ocn = fld.cn;
						
						fld.cn = fld.cn+"_id";
						if(data.multiple || ct == "checkbox" || ct == "_normal")
							sql = '[VARCHAR] ('+(fld.cl ? fld.cl : 50)+')';
						else
							sql = '[BIGINT]';
						csql +=makeFieldSQL(name,fld,sql);
						fld.cn = ocn;
						sql = '[NVARCHAR] (' + (fld.cl ? fld.cl : 50) + ')';
					}
					else {
						fld.ct = "c";
						sql = '[NVARCHAR] (' + (fld.cl ? fld.cl : 50) + ')';
					}
					
					csql +=makeFieldSQL(name,fld,sql);
					
					struct.push(fld);
				}
			}
		} catch (e) {
			console.log(fbO);
		}
	})
	__CREATESQL += 'PRIMARY KEY (id));';
	if (isDetail){
		__CREATESQL += "ALTER TABLE [dbo].[" + name + "]  WITH CHECK ADD  CONSTRAINT [FK_experience_" + masterName + "_" + name + "] FOREIGN KEY([dId]) REFERENCES [" + masterName + "] ([Id])  on delete cascade on update cascade";
	}
	__CREATESQL += "\nend else begin \n"
	__CREATESQL += csql;
	__CREATESQL += "\nend;"
	
		//判断表的存在性： 
		//select count(*) from sysobjects where type='U' and name='你的表名' 
		//判断字段的存在性： 
		//select count(*) from syscolumns where id = (select id from sysobjects where type='U' and name='你的表名') and name = '你要判断的字段名' 
	return struct;
}

function makeFieldSQL(name,fld,sql){
	__CREATESQL += '[' + fld.cn + '] ' + sql + ' NULL,\n';
	var csql = "if not exists (select * from syscolumns where id=object_id('" + name + "') and name='" + fld.cn + "') \nbegin\n"
	csql += "ALTER TABLE [" + name + "] ADD [" + fld.cn + '] ' + sql + ' NULL;\n';
	csql += "end\n";
	console.log(fld);
	if(fld.desc){
		csql +="EXEC sp_dropextendedproperty 'MS_Description', 'SCHEMA', dbo, 'table','"+name+"', 'column','"+fld.cn+"'\n"
		csql +="EXEC sp_addextendedproperty 'MS_Description', '"+fld.desc+"', 'SCHEMA', dbo, 'table', '"+name+"', 'column', '"+fld.cn+"'\n";
	}
	return csql;
}