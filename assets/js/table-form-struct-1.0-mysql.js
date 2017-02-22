
var __CREATESQL;

function makeStructs1(table) { //自动生成数据库字段配置
	var name = table.attr("code");
	table.find('tr[rowid]').hide();
	var struct = {};
	__CREATESQL = '';
	var options = table.find('tr:visible [f-options]');
	struct.master = {
		name: name,
		data: makeStruct(options, name)
	};
	struct.details = [];
	_form_makeEditor(table, 'tr:visible ');
	table.find('tr[rowid]:hidden').each(function() {
		var data = makeStruct($(this).find('[f-options]'), $(this).attr("rowid"), true, name);
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
	var options = table.find('tr:visible [f-options]');

	struct.master = {
		name: name,
		data: makeStruct(options, name)
	};
	struct.details = [];
	table.find('tr[rowid]:hidden').each(function() {
		var data = makeStruct($(this).find('[f-options]'), $(this).attr("rowid"), true, name);
		struct.details.push({
			name: $(this).attr("rowid"),
			data: data
		});
	})

	name = name.toUpperCase();
	
	OnlineData({
		param: 'exesql',
		sql: "DROP TABLE IF EXISTS `"+name+"`;\n"
	},function(data){
		if(data.success){
			OnlineData({
				param: 'exesql',
				sql: __CREATESQL
			},function(data){
				if(data.success){
					alert('数据库结构生成成功!');
				}
			});
		}
	});
	
	
}

function makeStruct(options, name, isDetail, masterName) {
	struct = [];
	if (__CREATESQL !== "")
		__CREATESQL += "\n";
	
	name = name.toUpperCase();
	
	//__CREATESQL += "DROP TABLE IF EXISTS `"+name+"`;\n";
	__CREATESQL += "CREATE TABLE IF NOT EXISTS `" + name + "`\n";
	__CREATESQL += "(`id` INT(20) not null AUTO_INCREMENT COMMENT '自增主键',\n";
	
	
	var csql = '';
	
	if (isDetail){
		__CREATESQL += "`dId` int(20) not null COMMENT '外键',\n";
	}
	else{
		__CREATESQL += "`opt_user` VARCHAR(50) COMMENT '操作用户',\n";
		
		csql += "SELECT IFNULL(`opt_user`, '') INTO @colName FROM information_schema.columns WHERE table_name = '"+name+"' AND column_name = 'opt_user'";
		csql += "IF @colName = '' THEN\n"
		csql += "ALTER TABLE `" + name + "` ADD `opt_user`  VARCHAR (50);\n";
		csql += "END IF;\n";

		/*csql += "if not exists (select * from syscolumns where id=object_id('" + name + "') and name='opt_user') \nbegin\n"
		csql += "ALTER TABLE [" + name + "] ADD [opt_user]  [NVARCHAR] (50);\n";
		csql += "end\n";
		__CREATESQL += "[opt_status] [int],\n";
		csql += "if not exists (select * from syscolumns where id=object_id('" + name + "') and name='opt_status') \nbegin\n"
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
			if (fld.cn) {
				var ct = data.type;
				if (ct !== "_button" && data.etype!=="viewcalculation") {
					fld.cl = data.len;
					
					if (ct == "number") {
						fld.ct = "n";
						sql = 'FLOAT(20,5)';
					} else if (ct == "richtext") {
						fld.ct = "t";
						sql = 'TEXT';
					} else if (ct == "date") {
						fld.ct = "d";
						sql = 'DATETIME';
					} 
					else if (ct == "combobox" || ct =="dialogue"){
						fld.ct = "c";
						var ocn = fld.cn;
						fld.cn = fld.cn+"_id";
						sql = 'VARCHAR (50)';
						csql +=makeFieldSQL(name,fld,sql,$(this).attr('title')+'ID');
						fld.cn = ocn;
						sql = 'VARCHAR (' + (fld.cl ? fld.cl : 50) + ')';
					}
					else if(ct == "_normal"){
						var names = $(this).find("[name]");
						for(var i=0;i<names.length;i++){
							fld.cn =names.eq(i).attr('name');
							console.log(names[i])
							sql = 'VARCHAR (50)';
							csql +=makeFieldSQL(name,fld,sql,$(this).attr('title'));
						}
					}
					else {
						fld.ct = "c";
						sql = 'VARCHAR (' + (fld.cl ? fld.cl : 50) + ')';
					}
					
					if(ct !== "_normal"){
					
						csql +=makeFieldSQL(name,fld,sql,$(this).attr('title'));
						
						struct.push(fld);
					}
				}
			}
		} catch (e) {
			console.log(fbO);
		}
	})
	__CREATESQL += 'PRIMARY KEY (`id`)) ENGINE=INNODB CHARSET=gb2312 COLLATE=gb2312_chinese_ci;';
	
	if (isDetail){
		//__CREATESQL += "ALTER TABLE [" + name + "]  WITH CHECK ADD  CONSTRAINT [FK_experience_" + masterName + "_" + name + "] FOREIGN KEY([dId]) REFERENCES [" + masterName + "] ([Id])  on delete cascade on update cascade";
	}
	
	//__CREATESQL += csql;
	
		//判断表的存在性： 
		//select count(*) from sysobjects where type='U' and name='你的表名' 
		//判断字段的存在性： 
		//select count(*) from syscolumns where id = (select id from sysobjects where type='U' and name='你的表名') and name = '你要判断的字段名' 
	return struct;
}

function makeFieldSQL(name,fld,sql,dis){
	__CREATESQL += '`' + fld.cn + '` ' + sql +' NULL COMMENT \''+dis+'\',\n';
	
	var csql = "SELECT IFNULL(`"+fld.cn+"`, '') INTO @colName FROM information_schema.columns WHERE table_name = '"+name+"' AND column_name = '"+fld.cn+"'";
	csql += "IF @colName = '' THEN\n"
	csql += "ALTER TABLE `" + name + "` ADD `"+fld.cn+"`  VARCHAR (50);\n";
	csql += "END IF;\n";
		
	return csql;
}