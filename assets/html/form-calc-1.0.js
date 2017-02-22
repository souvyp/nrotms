/*
	calcItem(table,obj,cal) 	//计算table内的obj对象的数值，计算公式为cal ，现行模式
	table: table-form 对象
	obj：需要计算的对象
	cal：计算公式				//格式{字段名}标识主表的字段，[{从表的标识.从表的字段}]标识从表的字段，{从表的标识.从表的字段}标识同一行的数值
								//所有的{}标志的结果都为数组,例如var arr={name} 标识 var arr=["test"],var arr=[{detail.name}] 标识 var arr=[1,2]
	返回计算结果
*/

function calcItem(table,obj,cal){
	var calReal=cal;
	var items=cal.split(/[{}]/);

	for(var i=1;i<items.length;i=i+2){
		var item=items[i];
		var j=item.indexOf('.');
		if(j<0){
			var itemObj=table.find('tr:not([nrowid]) [name="'+item+'"]');
			if(itemObj.length==0){
				itemObj=table.find('tr:not([nrowid]) input[name^="'+item+'+"]:checked');
			}
			if(itemObj.length==1){
				var oc=obj.attr('oc');
				var v=itemObj.val();
				if(oc!=="number")oc='"';
				else {
					oc="";
					if(v=="")v="0";
				}
				calReal=calReal.replace('{'+item+'}','['+v+oc+']');
			}
		}
		else if(j>0){
			var arr=item.split('.');
			var vals='';
			if(arr[0].substring(0,1)=="["){
				var itemObj=table.find('tr[nrowid="'+arr[0].replace('[','')+'"] [name="'+arr[1].replace(']','')+'"]');
				if(itemObj.length==0){
					itemObj=table.find('tr[nrowid="'+arr[0].replace('[','')+'"] [name^="'+arr[1].replace(']','')+'+"]:checked');
				}
			}
			else{
				var ptr=obj.parents('tr');
				var itemObj=ptr.find('[name="'+arr[1].replace(']','')+'"]');
				if(itemObj.length==0){
					itemObj=ptr.find('[name^="'+arr[1].replace(']','')+'+"]:checked');
				}
				if(arr[1]=="RowNumber"){
					vals='RowNumber';
					var ptrID=ptr.attr('nrowid');
					var n=1;
					table.find('tr[nrowid="'+ptrID+'"]').each(function(){
						if(this==ptr[0])
							calReal=n;
						n++;
					});
				}
			}
			
			if(vals!=="RowNumber"){
				for(var n=0;n<itemObj.length;n++){
					if(vals!=="")vals+=',';
					var v=itemObj.eq(n).val();
					var oc=obj.attr('oc');
					if(oc!=="number")oc='"';
					else {
						oc="";
						if(v=="")v="0";
					}
					vals+=oc+v+oc;
				}
				
				calReal=calReal.replace('{'+item+'}','['+vals+']');
			}
				
		}
	}
	var v='';
	try{
	//	console.log(calReal);
		v=eval(calReal);
	}catch(e){
		console.log(e,calReal);
		v='';
	}
	return v;
}

/*
	calcTable1(table,obj) //根据table内容进行计算
	table: table-form 对象
	obj:触发计算事件的对象
*/

function calcTable(table,obj){
	table.find('[calculation]').each(function(){			//有calculation标识的对象，将计算结果赋值到对象
		if(obj){
			if($(this).attr('name')==$(obj).attr('name')){
				return;
			}
		}
		var cal=unescape($(this).attr("calculation"));
		var v=calcItem(table,$(this),cal);
		if(!v)
			$(this).val('');
		else
			$(this).val(v);
		if($(this).attr('ct')=="3")$(this).removeAttr('calculation');
	})
	
	table.find('[hiddincalc]').each(function(){			//有hiddincalc标识的对象,根据计算结果进行隐藏或显示
		var cal=unescape($(this).attr("hiddincalc"));
		var ho=$(this);
		var v=calcItem(table,ho,cal);	
		if($(this).attr('ct')=="3")$(this).removeAttr('calculation');		
		if($(this).attr('hiddinRow')=="true")ho=$(this).parents('tr');  //有hiddinRow标识的表示整行需要隐藏
		if(!v)
			ho.hide();
		else	
			ho.show();
	})
}


/*
	getTableItemFromName(t,n) //根据n（name）属性，找到t(table-form)对应的对象
	t: table-form 对象
	n: 对象的name
	返回对象
*/

function getTableItemFromName(t,n){
	var itemObj=t.find('[name="'+n+'"]');
	if(itemObj.length==0)
		itemObj=t.find('input[name^="'+n+'+"]');
	return itemObj;
}


/*
	calcTemplate(source,data,ev) //根据data内容使用template进行计算
	source : 模板的内容
	data: 模板的数据
	ev: 模板结果是否使用eval函数
	返回计算结果
*/

function calcTemplate(source,data,ev){
	var render = template.compile(source); 		
	var result = render(data);
	if(ev){
		try{
			return eval(result);
		}
		catch(e){
			console.log('error:'+result);
			return null;
		}
	}
	else
		return result;
}

/*
	calcTable(table) //根据table内容进行计算
	table: table-form 对象


function calcTable(table){
	var data=wrapFormData(table,true);
	table.find('[calculation]').each(function(){			//有calculation标识的对象，将计算结果赋值到对象
		var _calc=unescape($(this).attr("calculation"));
		var v=calcTemplate(_calc,data,true);
		$(this).val(v);
		if(!$(this).attr('readOnly')||$(this).attr('ct')=="3")$(this).removeAttr('calculation');		
	})
	
	table.find('[hiddincalc]').each(function(){			//有hiddincalc标识的对象,根据计算结果进行隐藏或显示
		var _calc=unescape($(this).attr("hiddincalc"));
		var ho=$(this);
		var v=calcTemplate(_calc,data,true);
		//var v=calcItem(table,ho,cal);	
		if($(this).attr('ct')=="3")$(this).removeAttr('calculation');		
		if($(this).attr('hiddinRow')=="true")ho=$(this).parents('tr');  //有hiddinRow标识的表示整行需要隐藏
		if(v==true)
			ho.hide();
		else	
			ho.show();
	})
}*/