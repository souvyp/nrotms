var unipre='__uni__';
var parentWidth=220;


function makeUniCode(code,pre){
	/*var i=0;
	if(!pre)pre=unipre;
	var iid=pre+code;
	var c=iid;
	var p=$('#'+iid);
	while(p.length>0){
		i++;
		c=iid+i;
		p=$('#'+c);
	}
	return c;*/
	if(!pre)pre=unipre;
	return pre+uuid();
}

function showUrl(code,title,url){
	currNode=null;
	showContent(code,code,title,'<div class="easyui-panel" data-options="fit:true,border:true"><iframe src="'+url+'" width="100%" height="100%" style="border:0px;"></iframe></div>');
}

function showGrid(path,code,title,flt,pval,def,findCol,findGrid){	
	var c=makeUniCode(code);
	showContent(c,code,title,'<div class="easyui-panel" data-options="fit:true,border:true"><div id="'+c+'"></div></div>',function(){
		newGrid(c,path,code,title,flt,pval,def,null,null,false,findCol,findGrid);
	});
}

function showWindow(cont,title,w,h,handle,okHandle,cancelHandle){
	var c=makeUniCode('','win');
	var content='<div id="__win__'+c+'">'+cont+'</div>';
	 
	$(content).appendTo($('body'));

	var b=$('#__win__'+c);
	b.dialog({title:title,modal:true,width:w,height:h,resizable:false,onOpen:function(){
			if(handle)handle('__win__'+c);
		},
		onClose:function(){	
			b.dialog('destroy');
			b.remove();
		},buttons:okHandle?[
						{
							text:'确定',
							iconCls:'icon-ok',
							handler:function(){	
								
								if(okHandle)okHandle('__win__'+c);
								else b.dialog('close');
							}
						},{
							text:'取消',
							iconCls:'icon-cancel',
							handler:function(){	
								
								if(cancelHandle)cancelHandle('__win__'+c);
								else b.dialog('close');
							}
						}
				]:null});
	
}

function selectGrid(path,code,title,w,h,handle){

	var c=makeUniCode(code);
	var content='<div id="__win__'+c+'" code="__win__'+code+'"><div style="height:100%;width:100%;border:none;" id="'+c+'" code="'+code+'"></div></div>';
	
	$(content).appendTo($('body'));

	var b=$('#__win__'+c);
	b.window({title:title,modal:true,width:w,height:h,onClose:function(){	
		$('#'+c).EasyGrid('destroy');
		b.window('destroy');
		b.remove();
	}});
	

	newGrid(c,path,code,title,'','','',function(grid){
		grid.addToolbarItem(["-",{"text":"确定","iconCls":"icon-ok",handler:function(){
			var rows=grid.getSelections();
			if(rows.length<1) alert('请选择!');
			else{
				handle(rows);
				b.window('close');
			}}}])
		},null,true);

}

function childGrid(mainGrid,code,title,w,h,path){

	var c=makeUniCode(code);
	var content='<div id="__win__'+c+'" code="__win__'+code+'"><div style="height:100%;width:100%;border:none;" id="'+c+'" code="'+code+'"></div></div>';
	
	$(content).appendTo($('body'));

	var b=$('#__win__'+c);

	var rows=mainGrid.getSelections();
	if(rows.length!==1){
		alert('请选择一行进行操作！');
	}
	else{
		var pid=rows[0][mainGrid.Keys];
		if(!path)path=mainGrid.Path;
		b.window({title:title,modal:true,width:w,height:h,onClose:function(){	
			$('#'+c).EasyGrid('destroy');
			b.window('destroy');
			b.remove();
		}});
		
		newGrid(c,path,code,title,'',pid);
	}
}

function showForm(path,code,title,flt,nav,cols){	 
	var c=makeUniCode(code);
	showContent(c,code,title,'<div class="easyui-panel" data-options="fit:true,border:true"><form id="__form__'+c+'" method="post"  enctype="multipart/form-data" style="height:100%;width:100%;"></form></div>',function(){
		newForm('__form__'+c,path,code,title,flt,nav,cols,150);
	});
}
	
function RowFormatter(col,value,row,index){
	if(col.mask=="progress"){
		if (value<0){
			return '<div style="width:100%;color:white">' +
					'<div style="width:' + Math.min(100,(0-value)) + '%;background:green;" align="right">' + value + '%' + '</div>'
					'</div>';
		}
		else if(value==""||value=="0"){
			return '<div style="color:white">-</div>'
		}
		return '<div style="width:100%;color:white">' +
					'<div style="width:' + Math.min(100,value) + '%;background:red;">' + value + '%' + '</div>'
					'</div>';
	}
	else if(col.edittype=="7"){
		var arr=col.list;
		if(arr){	
			var pw=arr.split(",");
			if(pw.length>value)
				return pw[value];
			else
				return value;
		}
		else{
			if(value=="1")
				return '是';
			else
				return '否';
		}
	}
	else if(col.mask=="img"){
		if(value){
			var img='';
			try{
			if(value.indexOf("data:")>=0)
				img= '<img src="'+value+'" />';
			else
				img= '<img src="/uploads/'+value+'" />';
			return '<a href="#" class="imgwrap">'+img+'</a>';
			}catch(e){
				return '';
			}
		}
		else
			return '';
	}
	else if(col.mask=="file"){
		if(value){
			var v=value.toLowerCase();
			if(v.indexOf('http://')>=0)
				return '<a href="'+value+'" alt="" target="_blank">'+value+'</a>';
			else
				return '<a href="/uploads/'+value+'" alt="" target="_blank">'+value+'</a>';
		}
		return '';
	}
	return value;
}

function unescapeData(data){
	for(var i=0;i<data.length;i++){
		for(var key in data[i])
			data[i][key]=unescape(data[i][key]);
	}
	return data;
}

function newGrid(id,path,code,title,flt,pval,def,handle,clickHandle,single,FindCols,FindGrid){
	var tar=$('#'+id);
	var w=tar.width();
	var h=tar.parent().height();
	if(h==0) 
		h='auto';
	else {
		var _h=tar.parent().attr("_h");
		if(_h)h-=_h;
	}
	if(!flt){
		flt=tar.attr("flt");
	}
	if(!def){
		def=tar.attr("def");
		if(!def)def="";
	}
	if(!flt)flt="";
	mask('',id);	
	get(GRID_URL,{param:'column',path:path,code:code},'json',function(data){
		unmask(id);
		var j=0;
		var isTree=false;
		for(var i=0;i<data.fields.length;i++){
			if(data.fields[i].editvisible)
				j++;
			if(data.fields[i].edittype==18)
				isTree=true;
		}
		var cols=Math.ceil(j/10);

		if(!isTree){
			tar.attr('isGrid',1);
			tar.EasyGrid({
				Url:GRID_URL,
				FormUrl:FORM_URL,
				Path:path,
				Code:code,
				RealCode:id,
				ShortButton:tar.attr("shortbtn"),
				//Title:title,
				FormTitle:title,
				Icon:'',
				Width:'auto',
				Height:h,
				IncForm:true,
				FindCols:FindCols?FindCols:1,
				FindGrid:FindGrid?true:false,
				parentVal:pval,
				FormCols:cols,
				Datas:data.fields,
				Operate:data.operate,
				SingleSelect:single?true:false,
				IsWindow:false,
				pageSize:20,
				Filter:flt,
				Default:def,
				onClickRow:function(rowIndex, rowData){
					if(clickHandle)clickHandle(this,rowIndex, rowData);
				},
				onDblClickRow:function(){
				},
				init:function(data){

				},
				onLoadSuccess:function(data){
					if(handle)handle(this,data);
				},
				formatter:function(col,value,row,index){
					
					return RowFormatter(col,value,row,index);
				}
			});	
		}
		else{	
			tar.attr('isTree',1);
			tar.EasyTree({
				Url:GRID_URL,
				FormUrl:FORM_URL,
				Path:path,
				Code:code,
				RealCode:id,
				ShortButton:tar.attr("shortbtn"),
				//Title:title,
				FormTitle:title,
				Icon:'',
				Width:'auto',
				Height:h,
				IncForm:true,
				FormCols:cols,
				Datas:data.fields,
				Operate:data.operate,
				SingleSelect:true,//single?true:false,
				IsWindow:true,
				pageSize:20,
				onClickRow:function(row){
					if(clickHandle)clickHandle(this,row);
				},
				onLoadSuccess:function(data){
					
					if(handle)handle(this,data);
				},
				formatter:function(col,value,row,index){
					
					return RowFormatter(col,value,row,index);
				}
			})
		}
	});
}

function newTreeList(id,path,code,title,flt,pval,def,handle,clickHandle){
	var tar=$('#'+id);
	var w=tar.width();
	var h=tar.parent().height();
	if(h==0) 
		h='auto';
	else {
		var _h=tar.parent().attr("_h");
		if(_h)h-=_h;
	}
	if(!flt){
		flt=tar.attr("flt");
	}
	if(!flt)flt="";

	mask('',id);
	get(GRID_URL,{param:'column',path:path,code:code},'json',function(data){
		unmask(id);
		var j=0;
		var isTree=false;
		for(var i=0;i<data.fields.length;i++){
			if(data.fields[i].editvisible)
				j++;
			if(data.fields[i].edittype==18)
				isTree=true;
		}
		var cols=Math.ceil(j/10);
		tar.attr('isList',1);
		tar.EasyList({
			Url:GRID_URL,
			FormUrl:FORM_URL,
			Code:code,
			Path:path,
			Title:title,
			FormTitle:title,
			ShortButton:true,
			Width:'auto',
			Height:h,
			IncForm:true,
			FormCols:cols,
			Datas:data.fields,
			Operate:data.operate,
			onLoadSuccess:function(){
				
				if(handle)handle();
			},
			onClickRow:function(node){
				if(clickHandle)clickHandle(node);
			}
		});
	})
}

function newForm(id,path,code,title,flt,nav,cols,itemWidth,handle,isNew){
	var tar=$("#"+id);
	var w=tar.width();
	var h=tar.height();
	if(h<100) h=100;
	
	if(!flt){
		flt=tar.attr("flt");
	}
	if(!flt)flt="";
	
	mask('',id);
	get(GRID_URL,{param:'column',path:path,code:code},'json',function(data){
		unmask(id);
		tar.EasyForm({
			Url:FORM_URL,
			NavUrl:GRID_URL,
			IsNew:isNew,
			Path:path,
			Code:code,
			RealCode:id,
			Title:title,
			Icon:'',
			Width:'auto',
			Height:h,
			itemWidth:itemWidth,
			IncForm:true,
			Cols:cols,
			Datas:data.fields,
			Operate:data.operate,
			SingleSelect:false,
			IsWindow:false,
			ShortButton:tar.attr("shortbtn"),
			hasNav:nav,
			postButton:null,
			pageSize:20,
			Filter:flt,
			init:function(f){
				
				if(handle)handle(f);
			}
		});	
		
	});
}


function makeLayout(layout,c,className){
	var content='<div class="easyui-layout '+className+'" data-options="fit:true">';
	for(var i=0;i<layout.length;i++){		
		content+='<div data-options="region:\''+layout[i].position+'\'';
		if(layout[i].split)
			content+=',split:true';
		if(!layout[i].border)
			content+=',border:false';
		content+='"';
		var style="";
		if(layout[i].width)style+='width:'+layout[i].width+'px;';
		if(layout[i].height)style+='height:'+layout[i].height+'px;';
		if(layout[i].style)style+=layout[i].style;
		content+=' style="'+style+'">';
		
		var shortbtn='';
		if(layout[i].shortbtn)shortbtn='shortbtn="1"';
		if(layout[i].show==="layout")
			content+=makeLayout(layout[i].layout,c,'');
		else{
			var uc=makeUniCode(layout[i].code);
			layout[i].id=uc;
			c.push(layout[i]);
			if(layout[i].show=="form")
				content+='<div class="easyui-panel" data-options="fit:true"><form id="'+uc+'" method="post" enctype="multipart/form-data" '+shortbtn+'></form></div>';
			else if(layout[i].show=="tabs")
				content+='<div id="'+uc+'"></div>';
			else if(layout[i].show=="accordion")
				content+='<div class="easyui-accordion" data-options="multiple:false,border:true,fit:true" id="'+uc+'"></div>';
			else
				content+='<div class="easyui-panel" data-options="fit:true"><div id="'+uc+'" '+shortbtn+'></div></div>';
		}
		
		content+='</div>';
	}
	content+='</div>';
	return content;
}

function setComponentFlt(c,pval,flt,data){
	for(var i=0;i<c.length;i++){
		if(c[i].show=="tabs"){
			setComponentFlt(c[i].tabs,pval,flt);
		}
		else if(c[i].detail&&c[i].maked){
			if(c[i].show=="grid"){
				if(pval)
					$('#'+c[i].id).EasyGrid('setParentVal',pval);
				if(flt)
					$('#'+c[i].id).EasyGrid('filter',flt);
			}
			else if(c[i].show=="treeGrid"){
				if(pval)
					$('#'+c[i].id).EasyTree('setParentVal',pval);
				if(flt)
					$('#'+c[i].id).EasyTree('filter',flt);
			}
			else if(c[i].show=="form"){
				if(pval)
					$('#'+c[i].id).EasyForm('setParentVal',pval);
				if(flt)
					$('#'+c[i].id).EasyForm('filter',flt);
			}
			else if(c[i].show=="function"){
				var cont=','+data[c[i].masterKey.toLowerCase()]+',';

				c[i].pval=pval;
				var tree='__permission__'+c[i].id;
				var roots = $('#' + tree).tree('getRoots');
				makeFunctionVal($('#' + tree),roots,cont);
				
				/*for ( var j = 0; j < roots.length; j++) {  
					var node = $('#' + tree).tree('find', roots[j].id);
					
					if(cont.indexOf(','+roots[j].id+',')>=0)				
						$('#' + tree).tree('check', node.target); 
					else
						$('#' + tree).tree('uncheck', node.target); 
						var ddtree=$('#' + tree).tree('getData',node.target);
						console.log(ddtree);
				}  */
				
				
			}
		}
	}
}

function makeFunctionVal(t,data,cont){	
	for(var i=0;i<data.length;i++){
		var node = t.tree('find', data[i].id);
		if(cont.indexOf(','+data[i].id+',')>=0)				
			t.tree('check', node.target); 
		else
			t.tree('uncheck', node.target); 
		if(data[i].children){
			makeFunctionVal(t,data[i].children,cont);
		}	
	};
}

function newComponent(data,c,pval){
	data.maked=true;
	if(data.show=="tree"){

		newTreeList(data.id,data.path,data.code,data.title,data.flt,'','',function(){
				if(data.master){
					makeComponent(c,false,'unselected');
				}
			},function(node){
			if(data.master){
				setComponentFlt(c,node.id,null,node);	
			}
		});
	}
	else if(data.show=="grid"){
		newGrid(data.id,data.path,data.code,data.title,data.flt,pval,null,function(){
				if(data.master){
					makeComponent(c,false,'unselected');
				}
			},
			function(g,rowIndex, rowData){
				if(data.master){
					var p;
					if(rowData)
						p=rowData;
					else
						p=rowIndex;
					setComponentFlt(c,p.id,null,p);
				}
				
			},data.single,data.findCols,data.findGrid);
	}
	else if(data.show=="form"){
		newForm(data.id,data.path,data.code,data.title,data.flt,true,data.cols,parentWidth,function(f){
			if(data.master){
				f.navLoaded=function(data,key){	
					if(data){	
						var p=key;
						if(data)p=data[key];
						setComponentFlt(c,p,null,data);
						makeComponent(c,false,p);
					}
				}
				
			}
		},data.isnew)
	}
	else if(data.show=="panel"){
		$('#'+data.id).panel({
				href:data.url,
				border:false
		});
	}
	else if(data.show=="tabs"){

		$('#'+data.id).tabs({  
			border:true,  
			plain:true,
			fit:true,
			tabPosition:data.tabposition
		});

		for(var j=0;j<data.tabs.length;j++){
			var tabid=data.id+"-"+data.tabs[j].code;
			var d=data.tabs[j];
			
			if(data.tabs[j].sql){
				var sql=d.sql;
				var inx=j;
				var lt=d.listType;
				
				get(GRID_URL,{param:'combo',sql:sql},'json',function(rows){
					if(lt=="tab"){
						for(var n=0;n<rows.length;n++){
							var tab=$('#'+data.id).tabs('add',{
								title:rows[n].text,
								content:n==0?'<div id="'+tabid+'" pgid="'+tabid+'"  flt="'+d.sqlField+'=\''+rows[n].id+'\'" def="{'+d.sqlField+':\''+rows[n].id+'\'}" fld="'+d.sqlField+'" pid="'+rows[n].id+'"></div>':'<div fake="1" pgid="'+tabid+'" tag="'+inx+'" fld="'+d.sqlField+'" pid="'+rows[n].id+'"></div>',
								selected:n==0,
								closable:false
							});
							
							if(n==0){
								d.id=tabid;
								newComponent(d,c,pval);	
							}
						}
						
						$('#'+data.id).tabs({onSelect:function(title,index){							
							var pp = $('#'+data.id).tabs('getSelected');
							var cont=pp.panel('options').content;
							if(cont&&cont.indexOf(' fake="1" ')>0){
								var tabPanel = pp.panel('panel');  
								tabPanel.hide();
								var fld=$(cont).attr('fld');
								var pid=$(cont).attr('pid');
								var pgid=$(cont).attr('pgid');
								$('#'+pgid).EasyGrid('filter',fld+"='"+pid+"'",'{'+fld+':"'+pid+'"}');
								var n=$(cont).attr('tag');
								$('#'+data.id).tabs('getTab',parseInt(n)).panel('panel').show();
							}
							else {
								var pgid=$(cont).attr('pgid');
								
								if(pgid){
									var fld=$(cont).attr('fld');
									var pid=$(cont).attr('pid');
									var pgid=$(cont).attr('pgid');
									$('#'+pgid).EasyGrid('filter',fld+"='"+pid+"'",'{'+fld+':"'+pid+'"}');
								}
							}
						}})
						//$('#'+data.id).tabs('select',0);
					}
					else
					{
						var menuid='mm-'+tabid;
						var menu='<div id="'+menuid+'">';
						for(var n=0;n<rows.length;n++){
							menu+='<div nid="'+rows[n].id+'">'+rows[n].text+'</div>';
						}
						menu+='</div>';
						
						$(menu).appendTo($('#'+tabid).parent());
						var p = $('#'+data.id).tabs().tabs('tabs')[inx];
						var mb = p.panel('options').tab.find('a.tabs-inner');
						mb.menubutton({
							menu:'#'+menuid
						}).click(function(){
							$('#'+data.id).tabs('select',inx);
						});
					}
				})
			}else{
				$('#'+data.id).tabs('add',{
					title:d.title,
					//tabWidth:112,
					content:'<div id="'+tabid+'"></div>',
					//selected: j==0,
					closable:false
				});
				d.id=tabid;		
				$('#'+data.id).tabs('select',0);
				newComponent(d,c,pval);			
			}
		}
		
	}
	else if(data.show=="groupButton"){
		var sql=data.sql;
		get(GRID_URL,{param:'combo',sql:sql},'json',function(rows){
			var buttons='<div style="padding:5px;background:#f4f4f4;">';
			for(var n=0;n<rows.length;n++){
				buttons+='<a href="#" class="easyui-linkbutton" data-options="toggle:true,group:\'g1\'" nid="'+rows[n].id+'">'+rows[n].text+'</a>';
			}
			buttons+='</div>';
			$('#'+data.id).panel({
				content:buttons,
				border:false,
				plain:true,
				fit:true
			})
		});
	}
	else if(data.show=="accordion"){
		mask();
		get(GRID_URL,{param:'data',path:data.path,code:data.code,fl:data.flt},'json',function(d){	
			unmask();
			var cont='';
			var cat='';
			var rows=d.rows;

			var n=0;
			SortData(rows,'groupname');
			for(var i=0;i<rows.length;i++){
				var img="";
				var cls='';
				if(i==0)cls='active';
				if(rows[i].img){
					img='<img src="../'+rows[i].img+'"/>';
				}
				if(cat!==rows[i].groupname){
					cat=rows[i].groupname;
					if(i>0){						
						cont+='</ul>';
						$('#'+data.id).accordion('add',{
							title:cat,
							content:cont,
							selected:n==0
						});
						n++;
					}
					cont='<ul class="category">';
					cont+='<li><a href="#" class="'+cls+'" iid="'+rows[i].id+'">'+img+rows[i].name+'</a></li>';	
				}else{
					cont+='<li><a href="#" class="'+cls+'" iid="'+rows[i].id+'">'+img+rows[i].name+'</a></li>';
				}
			}
			makeComponent(c,false,rows[0].id);
			$('#'+data.id+' .category li a').live('click',function(){
				$('#'+data.id+' .category .active').removeClass('active');
				$(this).addClass('active');			
				var p=$(this).attr("iid");
				setComponentFlt(c,p);
			})
		})
	}
	else if(data.show=="function"){
		var tree='__permission__'+data.id;
		var toolbar=[{
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						if(!data.pval){
							alert('请选择一条记录!');
						}
						else{
							var nodes = $('#'+tree).tree('getChecked',['checked','indeterminate']);
							var s = '';
							for(var i=0; i<nodes.length; i++){
								if (s != '') s += ',';
								s += nodes[i].id;
							}
							var pdata;
							for(var i=0;i<c.length;i++){
								if(c[i].master){
									pdata=c[i];
									break;
								}
							}
							if(pdata){
							
								var param='{id:"'+data.pval+'",'+data.masterKey+':"'+s+'"}';
								var tar=$('#'+pdata.id);
								onlineContent(GRID_URL+'?param=save&isnew=&path='+pdata.path+'&__DataCode='+pdata.code,StringToJson(param),'json',function(d){
									
									var dd= d;//eval('(' + d + ')');
									
									if(dd.msg)
										alert(dd.msg);
									else if(pdata.show=="tree"){
										var grid=tar.EasyList('getThis');
										var d=dd.rows[0];
										delete d["id"];
										grid.update(data.pval,d);
									}
									else if(pdata.show=="grid"){
										var grid=tar.EasyGrid('getThis');
										if(!grid){
											grid=tar.EasyTree('getThis');										
											grid.update(data.pval,dd.rows[0]);
										}
										else
											grid.updateRow(dd.rows[0]);
										
									}
									alert('保存成功!');
								})
							}
						}
					}
				}];
		$('#'+data.id).panel({
			border:false,
			tools:toolbar,
			
			title:'功能权限',
			fit:true,
			content:'<ul id="'+tree+'" class="easyui-tree" data-options="url:\''+MISC_URL+'?param=functions\',method:\'get\',animate:true,checkbox:true,cascadeCheck:true"></ul>'
		});
	}
}

function makeComponent(c,master,pval){
	
	if(master)
		for(var i=0;i<c.length;i++){
			if(!c[i].maked&&c[i].master&&master){
				newComponent(c[i],c,'');
			}
		}
	else{
		for(var i=0;i<c.length;i++){
			if(c[i].master)
				;
			else if(!c[i].maked){
				newComponent(c[i],c,pval);
			}
		}
	}
}

function showComplex(data){	
	var code=data.code;
	var c=[];
	var content=makeLayout(data.layout,c,'');	
	currNode=null;
	showContent(code,code,data.title,content);
	makeComponent(c,true);
}




/*********************************************************************************/
function showDetail($gridid,title,cols){
	var grid=$grid.EasyGrid('getThis');
	var rows=grid.getSelections();
	var pid='';
	if(grid.IsList){
		if(!rows)
			alert('请选择一行进行操作！');
		else{
			pid=rows[grid.Keys];
		}
	}
	else{
		if(!rows||rows.length!==1){
			alert('请选择一行进行操作！');
		}
		else{
			pid=rows[0][grid.Keys];
		}
	}
	currNode=null;
	showForm(grid.Path,grid.Code,title,grid.Keys+"='"+pid+"'",true,cols);
}


function permissionTree(){
	currNode=null;
	showContent('__cont__permission','__cont__permission','功能权限','<div class="easyui-panel" data-options="fit:true,border:true"><ul id="__permission" class="easyui-tree" data-options="url:\''+MISC_URL+'?param=functions\',method:\'get\',animate:true,checkbox:true,cascadeCheck:false"></ul></div>');
	
}