
var __CREATESQL;

function makeStructs(table) { //自动生成数据库字段配置
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

function makeStruct(options, name, isDetail, masterName) {
	struct = [];
	if (__CREATESQL !== "")
		__CREATESQL += "\n";
	//__CREATESQL+="DROP TABLE [dbo].["+name+"];\n";
	__CREATESQL += "if not exists (select * from sysobjects where type='U' and name='" + name + "')\n";
	__CREATESQL += "begin\n"
	__CREATESQL += "CREATE TABLE [" + name + "](\n";
	__CREATESQL += "[Id] [int] IDENTITY(1,1) NOT NULL,\n";
	if (isDetail) __CREATESQL += "[dId] [int] NULL,\n";
	var csql = '';
	options.each(function() {
		try {
			var fbO = $(this).attr("fb-options");
			var data = eval('(' + fbO + ')');
			var fld = {};
			var sql = '';

			fld.cn = data.codename;
			if (fld.cn) {
				var ct = data.codetype;
				if (ct !== "_button" && data.edittype!=="viewcalculation") {
					fld.cl = data.characterlength;
					if (ct == "number") {
						fld.ct = "n";
						sql += '[FLOAT]';
					} else if (ct == "richtext") {
						fld.ct = "t";
						sql += '[NTEXT]';
					} else if (ct == "date") {
						fld.ct = "d";
						sql += '[DATETIME]';
					} else {
						fld.ct = "c";
						sql += '[NVARCHAR] (' + (fld.cl ? fld.cl : 50) + ')';
					}
					__CREATESQL += '[' + fld.cn + '] ' + sql + ' NULL,\n';
					csql += "if not exists (select * from syscolumns where id=object_id('" + name + "') and name='" + fld.cn + "') \nbegin\n"
					csql += "ALTER TABLE [" + name + "] ADD [" + fld.cn + '] ' + sql + ' NULL;\n';
					csql += "end\n";
					struct.push(fld);
				}
			}
		} catch (e) {
			console.log(fbO);
		}
	})
	__CREATESQL += 'PRIMARY KEY (id));';
	if (isDetail){
		__CREATESQL += "ALTER TABLE [" + name + "]  WITH CHECK ADD  CONSTRAINT [FK_experience_" + masterName + "_" + name + "] FOREIGN KEY([dId]) REFERENCES [" + masterName + "] ([Id])  on delete cascade on update cascade";
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