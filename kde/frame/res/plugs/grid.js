(function( $ ){

	var methods = {

		init : function(options) {

			var eventListDefault = [];					//事件集合
			
			var defaults = {
				IsGrid:true,
				Url:'grid.cn',
				FormUrl:'',
				Path:'T_User',
				Code:'T_User',
				RealCode : '',
				Title:'',
				FormTitle:'',
				Icon:'',
				Width:'auto',
				Height:null,
				IncForm:true,
				FormCols:1,
				FindCols:1,
				FindGrid:false,
				Datas:[],
				Operate:[],
				SingleSelect:true,
				ShortButton:false,
				IsWindow:false,
				InitEvent:null,
				showTimes:false,
				pageSize : 20,
				parentId : null,
				parentVal : null,
				formatter : null,
				styler : null,
				hasCheckBox : false,
				fit:true,
				Filter:'',
				Default:null,
				init:null,
				onClickRow:null,
				onDblClickRow:null,
				onRowContextMenu:null,
				onLoadSuccess:null
			}
			
			var $this = this;
						
			var st = $.extend( true, defaults, options );
			var tt = new EasyGrid(st);				//初始化EasyGrid对象
			tt.InitGrid($this);						//初始化表格
			if(tt.InitEvent) tt.InitEvent();
			$.data($this[0],'EasyGrid',tt);
			return tt;
		},
		
		addEvent : function() {
			var tt = $.data(this[0],'EasyGrid');
			return tt.addEvent();
			
		},
		
		destroy : function(){ 
			var tt = $.data(this[0],'EasyGrid');
			if(tt){
				if(tt.form&&tt.form.dialoged){
					tt.form.dialog('destroy');
					tt.form.remove();
				}
				if(tt.FindForm&&tt.FindForm.dialoged){
					tt.FindForm.dialog('destroy');
					tt.FindForm.remove();
				}

				tt.tmenu.menu('destroy');
				tt.tmenu.remove();
				tt.optMenu.menu('destroy');
				tt.optMenu.remove();
				
				removeStyle('style-'+tt.RealCode);
				
				var searchid=tt.RealCode+'_search_find';
				//$('#mm_'+searchid).prev().remove();
				if($('#mm_'+searchid).length>0)
					$('#mm_'+searchid).menu("destroy");
				if($('#'+searchid).length>0)	
					$('#'+searchid).searchbox("destroy");				
			}
			//tt.JDom.datagrid('destroy');
		},
		resize : function(w,h){
			var tt = $.data(this[0],'EasyGrid');
			if(tt&&tt.JDom){
				if(w){
					tt.JDom.datagrid('resize', {
								width:w,
								height:h
					})
				}
				else{
					tt.JDom.datagrid('resize');
				}
			}
		},
		clear : function(){
			var tt = $.data(this[0],'EasyGrid');
			tt.JDom.datagrid('loadData', [])
		},
		getThis : function(){
			var tt = $.data(this[0],'EasyGrid');
			return tt;
		},
		getDom : function(){
			var tt = $.data(this[0],'EasyGrid');
			return tt.JDom;
		},
		setParentVal : function(val){
			var tt = $.data(this[0],'EasyGrid');
			if(tt){
				tt.parentVal=val;
				var flt="";
				if(val)
					flt=tt.parentId+"='"+val+"'";
				else
					flt=tt.parentId+" is null";

				if(tt.oldFilter!=="")
					tt.Filter=tt.oldFilter+' and '+flt;
				else
					tt.Filter=flt;
					
				tt.refreshFormItems(function(){
					tt.JDom.datagrid('reload', {
						flt: tt.Filter
					});
					if(tt.IncForm&&tt.ef){
						tt.ef.setParentVal(val);
					}
				});		
			}			
		},
		getFilter : function(){
			var tt = $.data(this[0],'EasyGrid');
			return tt.oldFilter;
		},
		filter : function(flt,def){
			var tt = $.data(this[0],'EasyGrid');
			tt.filter(flt,def,true);
		},
		setDef : function(def){
			var tt = $.data(this[0],'EasyGrid');
			tt.Default=def;
			
		}
	}
	
	function EasyGrid(st) {
		this.IsGrid=true;
		this.Url=st.Url;
		this.FormUrl=st.FormUrl;
		this.Path=st.Path;
		this.Code=st.Code;
		this.RealCode=st.RealCode;
		this.Title=st.Title;
		this.FormTitle=st.FormTitle;
		this.Icon=st.Icon;
		this.fit=st.fit;
		this.ShortButton=st.ShortButton;
		this.Width=st.Width;
		this.Height=st.Height;
		this.IncForm=st.IncForm;
		this.FormCols=st.FormCols;
		this.FindCols=st.FindCols;
		this.FindGrid=st.FindGrid;
		this.Datas=st.Datas;
		this.Operate=st.Operate;
		this.SingleSelect=st.SingleSelect;
		this.pageSize=st.pageSize,
		this.IsWindow=st.IsWindow;		
		this.InitEvent = st.InitEvent;
		this.showTimes = st.showTimes;
		this.formatter = st.formatter;
		this.styler = st.styler;
		this.hasCheckBox = st.hasCheckBox;
		this.Filter=st.Filter;
		this.oldFilter=st.Filter;
		this.Default=st.Default;
		this.parentVal=st.parentVal;
		this.init=st.init;
		this.onClickRow=st.onClickRow;
		this.onDblClickRow=st.onDblClickRow;
		this.onRowContextMenu=st.onRowContextMenu;
		this.onLoadSuccess=st.onLoadSuccess;
	}
	
	EasyGrid.prototype = {
	
		constructor : EasyGrid,
		
		InitGrid : function($this) {	
			var tThis=this;
			tThis.JDom=$this;
			
			if(tThis.RealCode=="")tThis.RealCode=tThis.Code;
			var datas=tThis.Datas;
			var frozenColumns=[];
			if(!tThis.SingleSelect)
				frozenColumns.push({field:'ck',checkbox:true});
				
			var columns=[];
			var gcolumns=[];
			
			var operates=tThis.Operate;
			tThis.tmenu = $('<div style="width:100px;"></div>');
			tThis.optMenu=$('<div style="width:100px;"></div>');
			tThis.JDom.append(tThis.tmenu);
			tThis.JDom.append(tThis.optMenu);
			tThis.editable=false;
			var cou=datas.length;
			var cgn="";		
			tThis.FindFields=[];
			for(var i=0;i<cou;i++){
				var field=datas[i].fieldname.toLowerCase();
				
				if(datas[i].filtered&&(datas[i].edittype==1||datas[i].edittype==17)){
					tThis.FindFields.push(field+','+datas[i].displayname);
				}
				if(datas[i].keys){
					tThis.Keys=field;
					//frozenColumns.push({field:field,hidden:true});
				}
				else if(datas[i].foreignkey){
					tThis.parentId=field;
					if(tThis.parentVal){
						if(tThis.Filter=="")
							tThis.Filter=field+"='"+tThis.parentVal+"'";
						else
							tThis.Filter=tThis.Filter+ ' and ' +field+"='"+tThis.parentVal+"'"
					}
					//else
					//	tThis.Filter=field+" is null";
				}
				else if(datas[i].visible){
					if(datas[i].editgrid)
						tThis.editable=true;
					var fmt=function(value,row,index){
						if(this.edittype==2){
							value='******';
						}
						else if(this.edittype==4||this.edittype==5||this.edittype==19||this.edittype==23||this.edittype==12){
							var arr=this.list;
							if(arr){
								for(var n=0;n<arr.length;n++){
									var pw=arr[n];
									if(pw[0]==value){									
										value=pw[1];
										break;
									}
								}
							}
						}
						else if(this.edittype==13){
							var lst=this.list;
							var min,max,precision,prefix,suffix,groupSeparator;
							if(lst&&lst!=""){
								var arr=lst.split('\r');
								for(var j=0;j<arr.length;j++){
									var arr1=arr[j].split("=");
									if(arr1[0]=="min")min=ToInt(arr1[1]);
									else if(arr1[0]=="max")max=ToInt(arr1[1]);
									else if(arr1[0]=="precision")precision=ToInt(arr1[1]);
									else if(arr1[0]=="prefix")prefix=arr1[1];
									else if(arr1[0]=="suffix")suffix=arr1[1];
									else if(arr1[0]=="group")groupSeparator=arr1[1];
								}
							
								try{
									value=parseFloat(value).toFixed(precision);
								}
								catch(e){
									value='0';
								}
							};
							return value;
						}
						if(tThis.formatter)
							return tThis.formatter(this,value,row,index);
						return value;
					};	
					if(datas[i].edittype==4){
						datas[i].list=[];
						var arr=datas[i].linklist.split('\r');
						for(var n=0;n<arr.length;n++){
							var p=arr[n].indexOf('=');
							datas[i].list.push([arr[n].substring(0,p),arr[n].substring(p+1,arr[n].length-p+1)]);
						}
					}
					else if(datas[i].edittype==5||datas[i].edittype==19||datas[i].edittype==12){						
						var sql=datas[i].linklist;
						sql=sql.replaceAll('@id@',tThis.parentVal);
						get(tThis.Url,{param:'combo',code:tThis.Code,path:tThis.Path,sql:sql},'json',function(data){
							datas[i].list=[];
							if(data.length>0){
								var k=0;
								var dk,dt;
								for(var key in data[0]){
									if(k==0)dk=key;
									else if(k==1)dt=key;
									if(k>1)break;
									k++;
								}
								for(var n=0;n<data.length;n++)
									datas[i].list.push([data[n][dk],data[n][dt]]);
							}
						},null,null,true);
					}
					else if(datas[i].edittype==23){
						var c=datas[i].linklist;
						get(tThis.Url,{param:'data',path:tThis.Path,code:c},'json',function(d){
							datas[i].list=[];
							var data=d.rows;
							if(data.length>0){
								var k=0;
								var dk,dt;
								for(var key in data[0]){
									if(k==0)dk=key;
									else if(k==1)dt=key;
									if(k>1)break;
									k++;
								}
								for(var n=0;n<data.length;n++)
									datas[i].list.push([data[n][dk],data[n][dt]]);
							}
						},null,null,true);
					}
					else if(datas[i].edittype==13||datas[i].edittype==7){
						datas[i].list=datas[i].linklist;
					}
					
					var disF=datas[i].displayname;
					if(datas[i].locked)
						frozenColumns.push({field:field,
							title:disF,
							width:Math.min(Math.max(datas[i].displaywidth,80),500),
							sortable:datas[i].sorted,
							mask:datas[i].editmask,
							edittype:datas[i].edittype,
							linklist:datas[i].linklist,
							editgrid:datas[i].editgrid,
							list:datas[i].list,
							perspective:datas[i].perspective,
							formatter:fmt
						})
					else{
						if(disF.indexOf('||')>0){
							var arr=disF.split('||');
							disF=arr[1];							
							if(cgn!==arr[0]){
								cgn=arr[0];			
								var n=0;
								for(var j=i;j<cou;j++){
									var disCF=datas[j].displayname;
									if(disCF.indexOf('||')>0){
										arr=disCF.split('||');
										if(arr[0]==cgn){
											columns.push({field:datas[j].fieldname.toLowerCase(),
												title:arr[1],
												width:Math.min(Math.max(datas[j].displaywidth,80),200),
												sortable:datas[j].sorted,
												mask:datas[j].editmask,
												hidden:datas[j].findfld,
												edittype:datas[j].edittype,
												list:datas[j].list,
												linklist:datas[j].linklist,
												editgrid:datas[j].editgrid,
												perspective:datas[j].perspective,
												rowspan:2,
												formatter:fmt
											});
											n++;
										}
										else break;
									}
									else break;
								}
								gcolumns.push({title:cgn,colspan:n});
							}
						}
						else{
							
							gcolumns.push({field:field,
								title:datas[i].displayname,
								width:Math.min(Math.max(datas[i].displaywidth,80),200),
								sortable:datas[i].sorted,
								mask:datas[i].editmask,
								hidden:datas[i].findfld,
								edittype:datas[i].edittype,
								list:datas[i].list,
								editgrid:datas[i].editgrid,
								linklist:datas[i].linklist,
								perspective:datas[i].perspective,
								formatter:fmt,
								rowspan:2
							});
						}
						$('<div iconCls="icon-ok"/>').html('<span tag="'+field+'">'+disF+'</span>').appendTo(tThis.tmenu);
					
					}
				}
			};
			
			tThis.initColumnMenu();
			tThis.buttons=[];
			tThis.optMenu.menu({});
			var toolbar=[];
			var buttonInits=[];
			var iconcss='';
			for(var i=0;i<operates.length;i++){
				var rid=tThis.RealCode+'_opt_'+operates[i].code;
				var css=operates[i].cssicon;
				if(!css&&operates[i].img){
					css='icon-'+rid;
					if(iconcss!=="")iconcss+='\n';
					iconcss+="."+css+"{background:url("+operates[i].img+");background-size:16px 16px;background-repeat:no-repeat;}"
				}
				var button={
					id:rid,
					text:operates[i].name,
					iconCls:css,
					handler:function(){		
						for(var i=0;i<operates.length;i++){
							if(tThis.RealCode+'_opt_'+operates[i].code==this.id){
								var __grid=tThis;
								var script=makeScript(operates[i].description);
								var ostr="$this=$('#"+this.id+"');\n$grid=$('#"+tThis.RealCode+"');\n";
								eval(ostr+script);
							}
						}						
					}
				};
				
				if(operates[i].init){
					button.init=operates[i].init;
					buttonInits.push(button);
				}
				if(operates[i].operatetype==0){
					if(!button.init)
						tThis.optMenu.menu('appendItem',button);
					if(tThis.ShortButton)
						button.text='';
					toolbar.push(button);
				}
				else if(operates[i].operatetype==1)
					tThis.buttons.push(button);
			}
			if(iconcss!==""){	
				loadStyleString(iconcss,'style-'+tThis.RealCode);
			}
			var c=[];
			c.push(gcolumns);
			if(columns.length>0)
				c.push(columns);
				
			tThis.editIndex=undefined;
			
			tThis.rows;
			
			tThis.JDom.datagrid({
				title:tThis.IsWindow?tThis.Title:null,
				//iconCls:tThis.icon,
				width:tThis.Width,
				height:tThis.Height,
				
				singleSelect: tThis.SingleSelect,
				ctrlSelect:!tThis.SingleSelect,
				//nowrap: true,
				autoRowHeight: false,
				//striped: true,
				//collapsible:true,
				fitColumns: tThis.ShortButton, 
				fit:tThis.fit,
				border:false,//tThis.ShortButton,
				showFooter:true,
				url:tThis.Url+'?param=data&path='+tThis.Path+'&code='+tThis.Code,
				queryParams:{flt: tThis.Filter},
				remoteSort: true,
				frozenColumns:[frozenColumns],
				columns:c,
				pagination:true,
				pageSize:tThis.pageSize,
				pageList:[20,100,200,500,1000],
				rownumbers:true,
				//view:cardview,
				toolbar:toolbar,
				autoRowHeight:false,
				onDblClickRow:tThis.onDblClickRow,
				onSelectAll:function(rows){
					if(tThis.editable&&!tThis.JDom.oping){
						for(var n=0;n<rows.length;n++)
							tThis.JDom.datagrid('beginEdit', n);
						}
				},
				onUnselectAll:function(rows){
					if(tThis.editable&&!tThis.JDom.oping){
						tThis.JDom.oping=true;
						for(var n=0;n<rows.length;n++){
							tThis.JDom.datagrid('endEdit', n);
							tThis.JDom.datagrid('uncheckRow',n);
						}
						tThis.JDom.oping=false;
					}
				},
				onSelect:function(rowIndex, rowData){
					if(tThis.editable&&!tThis.JDom.oping){
						tThis.JDom.oping=true;
						var rows=tThis.rows;
						var srows=tThis.JDom.datagrid('getSelections');
						for(var n=0;n<rows.length;n++){												
							tThis.JDom.datagrid('endEdit',n);
							tThis.JDom.datagrid('uncheckRow',n);
						}
						
						for(var n=0;n<srows.length;n++){
							var inx=tThis.JDom.datagrid('getRowIndex',srows[n]);
							tThis.JDom.datagrid('checkRow',inx);
							tThis.JDom.datagrid('beginEdit', inx);							
						}
						tThis.JDom.oping=false;
					}
				},
				onUnselect:function(rowIndex, rowData){
					if(tThis.editable&&!tThis.JDom.oping){
						tThis.JDom.datagrid('endEdit', rowIndex);
					}
				},
				onAfterEdit:function(rowIndex, rowData, changes){
					if(changes&&!$.isEmptyObject(changes)){
						changes[tThis.Keys]=rowData[tThis.Keys];
						get(tThis.FormUrl+'?param=save&path='+tThis.Path+'&__DataCode='+tThis.Code,
							changes,'json',function(data){
								tThis.updateRow(data.rows[0],rowIndex);
								//Log(data);
							}
						);
					}
				},
				onClickRow:tThis.onClickRow,
				onRowContextMenu:function(e, rowIndex, rowData){
					e.preventDefault();
					if(!tThis.ShortButton){						
						tThis.clearSelections();
						tThis.selectRow(rowIndex);
						if(tThis.onRowContextMenu)
							tThis.onRowContextMenu(e,field);
						else{
							tThis.optMenu.menu('show', {
								left:e.pageX,
								top:e.pageY
							});
						}
					}
				},
				onHeaderContextMenu: function(e, field){
					e.preventDefault();
					if(!tThis.ShortButton){
						tThis.tmenu.menu('show', {
							left:e.pageX,
							top:e.pageY
						});
					}
				},
				onLoadSuccess: function (data) {  
					if(tThis.editable)
						tThis.rows=tThis.JDom.datagrid('getRows');;
					if(!tThis.noInited){
						tThis.noInited=true;
						var pager=tThis.JDom.datagrid('getPager');
						var display=pager.children().eq(1);
						if(!tThis.ShortButton){
							$('<div class="pagination-time-info"></div>').insertBefore(display);
							display.show();
						}
						else{
						/*	var l=pager.children().eq(0).find(".pagination-page-list").parent();
							l.next().hide();
							l.hide();*/
						}
						if(tThis.init)tThis.init(data);
					
					
						var toolbar = tThis.JDom.parent().prev("div.datagrid-toolbar").find('table:last-child');
						var searchid=tThis.RealCode+'_search_find';
						var mm='<div id="mm_'+searchid+'" style="width:120px;">';
						for(var i=0;i<tThis.FindFields.length;i++){						
							var btns=tThis.FindFields[i].split(',');
							if(i==0)
								mm+='<div data-options="name:\''+btns[0]+'\'">'+btns[1]+'</div>';
							else
								mm+='<div data-options="name:\''+btns[0]+'\'">'+btns[1]+'</div>';  
						}
						mm+='</div>';
						
						if(toolbar.children("a").length>0)
							$('<span class="searchboxWrap"><input id="'+searchid+'"></input>'+mm+'</span><div class="datagrid-btn-separator"></div>').insertBefore(toolbar.children("a").get(0));
						else
							toolbar.find("tbody td:first-child").before('<td><span class="searchboxWrap"><input id="'+searchid+'"></input>'+mm+'</span></td>');
							//$('<span class="searchboxWrap"><input id="'+searchid+'"></input>'+mm+'</span>').appendTo(toolbar);

						$('#'+searchid).searchbox({  
							width:200,
							searcher:function(value,name){ 
								if(value!=""){
									var w=name+" like '%"+value+"%'";
									tThis.filter(w,null,true);
								}
								else{
									tThis.filter('',null,true);
								}								
							},    
							menu:'#mm_'+searchid,
							prompt:'请输入关键字'  
						}); 
					}	
					if(tThis.onLoadSuccess){
						tThis.onLoadSuccess(data);
					}
					if(tThis.showTimes){
						tThis.showTimes(data.time);
					}
					else if(data.time&&!tThis.ShortButton){
						var pager=tThis.JDom.datagrid('getPager');
						var display=pager.find('.pagination-time-info');
						display.html(',服务器耗时'+(data.time).toFixed(0)+'毫秒');
					}	
				}
			});	
			
			tThis.Columns=tThis.JDom.datagrid('options').columns;  
			if(tThis.IncForm&&!tThis.form){
				setTimeout(function(){tThis.initFormDialog(300,200)},200); //创建表单需要占用较多资源，线程执行
			}
			for(var i=0;i<buttonInits.length;i++){
				var ostr="$this=$('#"+buttonInits[i].id+"');\n$grid=$('#"+tThis.RealCode+"');\n";
				var script=ostr+buttonInits[i].init;
				setTimeout(function(){eval(script);},200); 
			};
		},

		initColumnMenu : function(){
			var tThis=this;
			tThis.tmenu.menu({
				onClick: function(item){
					
					if (item.iconCls=='icon-ok'){
						
						var name=$(item.target.firstChild.firstChild).attr("tag");
						tThis.JDom.datagrid('hideColumn', name);
						tThis.tmenu.menu('setIcon', {
							target: item.target,
							iconCls: 'icon-empty'
						});
					} else {
						var name=$(item.target.firstChild.firstChild).attr("tag");
						tThis.JDom.datagrid('showColumn', name);
						tThis.tmenu.menu('setIcon', {
							target: item.target,
							iconCls: 'icon-ok'
						});
					}
				}
			});
		},
		
		refreshFormItems:function(handle){
			var tThis=this;
			var cols=tThis.Columns[0];//tThis.JDom.datagrid('options').columns;  
			var j=0;
			for(var i=0; i<cols.length; i++){				
				if(cols[i].edittype==5||cols[i].edittype==19){
					var sql=cols[i].linklist;
					if(sql.indexOf('@id@')>0){
						sql=sql.replaceAll('@id@',tThis.parentVal);
						get(tThis.Url,{param:'combo',code:tThis.Code,path:tThis.Path,sql:sql},'json',function(data){
							j++;
							cols[i].list=[];
							if(data.length>0){
								var k=0;
								var dk,dt;
								for(var key in data[0]){
									if(k==0)dk=key;
									else if(k==1)dt=key;
									if(k>1)break;
									k++;
								}
								for(var n=0;n<data.length;n++)
									cols[i].list.push([data[n][dk],data[n][dt]]);
							}
							if(j==cols.length&&handle)
								handle();
							
						},null,null,true);
					}
					else {
						j++;
						if(j==cols.length&&handle)
							handle();
					}
				}else 
				{
					j++;
					if(j==cols.length&&handle)
						handle();
				}
			}						
		},
		initFormDialog :function(w,h){
			if(this.IncForm&&!this.form){
				if(this.FindGrid)
					this.FindForm=$('<form method="post" enctype="multipart/form-data" tag="findForm"></form>');
				else
					this.FindForm=$('<form method="post" enctype="multipart/form-data" tag="findForm" style="display:none;"></form>');
				this.form = $('<form method="post" enctype="multipart/form-data" tag="editForm" style="display:none;"></form>');
				this.form.Url=this.FormUrl;
				this.JDom.append(this.form);
				this.JDom.editable=this.editable;
				
				if(this.FindGrid){
					var $this=this;
					var toolbar = this.JDom.parent().prev("div.datagrid-toolbar");
					var find=$('<table><tr><td></td><td><a href="#"></a><br/><a href="#"></a></td></tr></table>');
					find.find('td:eq(0)').append(this.FindForm);
					/*find.find('a:eq(0)').linkbutton({iconCls:'icon-search',text:'查询',
						onClick:function(){		
							var flt=$this.genFindFilter();
							$this.filter(flt,null,true);
						}
					});
					find.find('a:eq(1)').linkbutton({iconCls:'icon-reset',text:'重置',
						onClick:function(){		
							$this.FindForm.get(0).reset();
							var flt=$this.genFindFilter();
							$this.filter(flt,null,true);
						}
					});*/
					toolbar.prepend('<hr style="border:none;border-top:1px solid #dddddd;" />');
					toolbar.prepend(find);
					
				}
				else
					this.JDom.append(this.FindForm);	
				this.ef=this.form.EasyForm({
					Url:this.FormUrl,
					NavUrl:this.Url,
					Path:this.Path,
					Code:this.Code,
					RealCode:this.RealCode,
					Title:this.FormTitle,
					Icon:this.Icon,
					Width:w,
					Height:h,
					parentVal:this.parentVal,					
					Datas:this.Datas,
					Cols:this.FormCols,
					findForm:this.FindForm,
					FindCols:this.FindCols,
					Grid:this.JDom
				});
			};
		},
		
		showGridDialog:function(){	
			if(!this.JDom.dialoged){
				this.JDom.dialoged=true;
				this.JDom.dialog({title:this.FormTitle,modal:true,buttons:this.buttons});
			}
			this.JDom.dialog('open');	
			
		},
				
		showFindDialog:function(item){	
			var $this=this;
			if($this.FindGrid){
				var flt=$this.genFindFilter();
				var params=$this.genFindParams();
				$this.filter(flt,null,true,params);
			}
			else{
			
				if(!$this.FindForm.dialoged){
					$this.FindForm.dialoged=true;
					$this.FindForm.show();
					$this.FindForm.dialog({title:$this.FormTitle+' - 查询',modal:true,buttons:[
							{
								text:'确定',
								iconCls:'icon-ok',
								handler:function(){	
									$this.FindForm.dialog('close');
									var flt=$this.genFindFilter();
									var params=$this.genFindParams();
									$this.filter(flt,null,true,params);
									
								}
							},{
								text:'取消',
								iconCls:'icon-cancel',
								handler:function(){	
									$this.FindForm.dialog('close');
								}
							}
					],resizable:true});
				}
				$this.FindForm.dialog('open');
			}
		},
		
		genFindFilter:function(){
			var $this=this;
			var datas=this.Datas;
			var cou=datas.length;
			var flt='';
			for(var i=0;i<cou;i++){
				
				if(datas[i].filtered){
					
					var fld=datas[i].fieldname.toLowerCase();
					var Mfld=$this.RealCode+'_fld_'+fld;
					var ety=datas[i].edittype;
					var fty=datas[i].fieldtype;
					var field=$this.FindForm.find("[FindId='"+Mfld+"']");
					
					if(datas[i].findfld){
						if($("#check_"+Mfld).attr("checked"))
							this.JDom.datagrid("showColumn",fld);
						else
							this.JDom.datagrid("hideColumn",fld);
					}
					
					if(ety==13){
						var sv=field.eq(0).numberbox('getValue');
						var ev=field.eq(1).numberbox('getValue');	
						if(fty==1){
							if(sv!="")flt+=" and "+fld+">="+sv;
							if(ev!="")flt+=" and "+fld+"<="+ev;
						}
						else{
							if(sv!="")flt+=" and "+fld+">='"+sv+"'";
							if(ev!="")flt+=" and "+fld+"<='"+ev+"'";
						}
					}
					else if(ety==4||ety==5||ety==21){
						var val=field.combobox('getValue');
						if(val)flt+=" and "+fld+"='"+val+"'";
					}
					else if(ety==23){
						var val=field.combogrid('getValue');
						if(val)flt+=" and "+fld+"='"+val+"'";
					}
					else if(ety==19||ety==24){
						var val=field.combotree('getValue');
						if(val)flt+=" and "+fld+"='"+val+"'";
					}
					else if(ety==6||ety==16){ //日期
						var sv=field.eq(0).datebox('getValue');
						var ev=field.eq(1).datebox('getValue');						
						if(sv)flt+=" and "+fld+">='"+sv+"'";
						if(ev)flt+=" and "+fld+"<='"+ev+"'";
						
					}
					else if(ety==1||ety==2||ety==3){
						var val=field.textbox('getValue');
						if(val)flt+=" and "+fld+" like '%"+val+"%'";
					}
					else{
						var val=field.val();
						if(val)flt+=" and "+fld+" like '%"+val+"%'";
					}
				}
			}
			if(flt!="")flt=flt.replace(" and ","");

			return flt;
		},
		
		genFindParams:function(){
			var $this=this;
			var datas=this.Datas;
			var cou=datas.length;
			var param='';
			for(var i=0;i<cou;i++){
				
				if(datas[i].paramfld){
					
					var fld=datas[i].fieldname.toLowerCase();
					var Mfld=$this.RealCode+'_fld_'+fld;
					var ety=datas[i].edittype;
					var fty=datas[i].fieldtype;
					var field=$this.FindForm.find("[FindId='"+Mfld+"']");
					
					param+=',';
					
					if(ety==1||ety==2||ety==3){
						var val=field.textbox('getValue');
						if(val)param+=fld+"="+val;
					}
					else if(ety==13){
						var val=field.numberbox('getValue');
						if(val)param+=fld+"="+val;
					}
					else if(ety==4||ety==5||ety==21){
						var val=field.combobox('getValue');
						if(val)param+=fld+"="+val;
					}
					else if(ety==23){
						var val=field.combogrid('getValue');
						if(val)param+=fld+"="+val;
					}
					else if(ety==19||ety==24){
						var val=field.combotree('getValue');
						if(val)param+=fld+"="+val;
					}
					else if(ety==6||ety==16){ //日期
						var val=field.datebox('getValue');
						if(val)param+=fld+"="+val;						
					}
					else{
						var val=field.val();
						if(val)param+=fld+"="+val;	
					}
					
				}
			}
			if(param!=="")param=param.replace(',','');
			return param;
		},
		
		showFormDialog:function(item){	

			if(!this.form.dialoged){
				this.form.dialoged=true;
				this.form.show();
				this.form.dialog({title:this.FormTitle,doSize:true,closable:true,modal:true,buttons:this.buttons,resizable:true/*,onClose:function(){$(this).dialog('destroy');}*/});
			}
			this.form.dialog('open');
			
			if(!item)AddForm(this);
			else {
				this.form.form('clear');
				this.form.isNews="";
			}				
			if(item){
				var datas=this.Datas;
				for(var i=0;i<datas.length;i++){
					var field=datas[i].fieldname.toLowerCase();
					
					var ety=datas[i].edittype;
					var fld=this.RealCode+'_fld_'+field;
					
					if(!datas[i].editvisible){
						var val=item[field];
						$('#'+fld).val(val);	
					}
					else if(ety==1||ety==2||ety==3){
						var v=item[field];
						$('#'+fld).textbox('setValue', v);
					}
					else if(ety==6){
						var val=item[field];
						if(val){
							if(val.indexOf(':')>0)
								$('#'+fld).datetimebox('setValue', val);	
							else
								$('#'+fld).datebox('setValue', val);	
						}
					}
					else if(ety==7){
						if(item[field]=="1")
							$('#'+fld).attr("checked",true);
						else
							$('#'+fld).attr("checked",false);
					}
					else if(ety==13){
						$('#'+fld).numberbox('setValue', item[field]);
					}
					else if(ety==23){
						$('#'+fld).combogrid('setValue', item[field]);
					}
					else if(ety==19||ety==24){
						$('#'+fld).combotree('setValue', item[field]);
					}
					else if(ety==4||ety==5||ety==21||ety==12){						
						if(ety==12){
							var pfld=this.RealCode+'_fld_'+datas[i-1].fieldname.toLowerCase();
							var pval=$('#'+pfld).combobox('getValue');
							$('#'+fld).attr('flt',"parent_id='"+pval+"'");
							var tFld=fld;
							var tVal=item[field];
							$('#'+fld).combobox('enable');
							/*$('#'+fld).combobox({onLoadSuccess:function(){
								alert(tFld);
								$('#'+tFld).combobox('setValue',tVal);
							}})*/
							$('#'+fld).combobox('reload');
							$('#'+tFld).combobox('setValue',tVal);
							
						}
						else if(ety==21){
							var v=item[field];
							$('#'+fld).combobox('setValue', v);
						}
						else
							$('#'+fld).combobox('setValue', item[field]);
					}
					else if(ety==14){
						if(!$('#'+fld).inited){
							$('#'+fld).inited=true;
							$('#'+fld).xheditor({tools:'mini'});
						}
						$('#'+fld).val(item[field]);
					}
					else if(ety==17||ety==26){
						//$('#'+fld).val(item[field]);
						var v=item[field];
						$('#'+fld).filebox('setText', v);
					}
					else if(ety==11){
						$('#'+fld).prev().val('zmnone');
						$('#'+fld).searchbox('setValue',item[field]);
					}
					else if(ety==25){
						var val=item[field];
						if(val!=""){
							var arr=val.split(",");
							$('#'+fld).combotree('setValues', arr);
						}
					}
					else {
						var val=item[field];
						$('#'+fld).val(val);						
					}
				}
			}	
		},
		
		refresh : function(){
			this.JDom.datagrid('reload');
		},
		
		getSelected : function(){
			return this.JDom.datagrid('getSelected');
		},
		
		getSelections : function(){
			return this.JDom.datagrid('getSelections');
		},
		
		clearSelections: function(){
			this.JDom.datagrid('clearSelections');
		},
				
		selectRow : function(inx){
			this.JDom.datagrid('selectRow',inx);
		},
		
		selectRecord :function(code){
			this.JDom.datagrid('selectRecord',code);
		},
		
		unselectRow : function(inx){
			this.JDom.datagrid('unselectRow',inx);
		},
		
		updateRow : function(data,rowIndex){
			var row=this.JDom.datagrid('getSelected');
			if(!rowIndex)
				rowIndex=this.JDom.datagrid('getRowIndex',row);
			this.JDom.datagrid('updateRow',{
				index: rowIndex,
				row: data
			});
		},
		
		mergeCells : function(inx,field,rows,cols){
			this.JDom.datagrid('mergeCells',{
				index:inx,
				field:field,
				rowspan:rows,
				colspan:cols
			});
		},
		filter : function(flt,def,clr,params){
			var tt = this;
			tt.oldFilter=flt;
			var pFlt="";
			if(tt.parentId&&tt.parentVal){
				pFlt=tt.parentId+"='"+tt.parentVal+"'";
				if(tt.oldFilter!=="")
					tt.Filter=tt.oldFilter+' and '+pFlt;
				else
					tt.Filter=pFlt;
			}
			else 
				tt.Filter=tt.oldFilter;
			tt.JDom.datagrid('reload', {
				flt: tt.Filter,
				ps:params
			});
			if(def)
				tt.Default=def;
			if(clr){
				var searchid=tt.RealCode+'_search_find';
				if($('#'+searchid).length>0)	
						$('#'+searchid).searchbox("clear");	
			}
		},
		
		addToolbarItem:function(buttons){
			this.JDom.datagrid("addToolbarItem",buttons)
		},
		exportXls: function(){
			var w=this.JDom.datagrid("getExcelXml",{"title":"export"});
			
			var a = document.createElement('a');
			var blob = new Blob([w], {'type':'application\/octet-stream'});
			a.href = window.URL.createObjectURL(blob);
			a.download = 'export.xls';
			a.click();
		}
	}
		
	$.fn.EasyGrid = function( method ) {
		if( methods[method] ) {
			return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ) );
		} else if ( typeof method === 'object' || !method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'No '+method+' method' );
		}
	};
})( jQuery );




/**
 * allows for downloading of grid data (store) directly into excel
 * Method: extracts data of gridPanel store, uses columnModel to construct XML excel document,
 * converts to Base64, then loads everything into a data URL link.
 *
 * @author		Animal		<extjs support team>
 *
 */
 
/*
用法：

$('#tt').datagrid("getExcelXml",{})
*/

$.extend($.fn.datagrid.methods,{
    getExcelXml: function(jq, param) {
        var cellType = [];
        var cellTypeClass = [];
        var headerXml = '';
        var visibleColumnCountReduction = 0;
		var cfs = $(jq).datagrid('getColumnFields');
        var colCount = cfs.length;
        for (var i = 0; i < colCount; i++) {
            if (cfs[i] != '') {
                var w = $(jq).datagrid('getColumnOption',cfs[i]).width;

                if (cfs[i] === ""){
					cellType.push("None");
                	cellTypeClass.push("");
					++visibleColumnCountReduction;
                }
                else
                {
					cellType.push("String");
                    cellTypeClass.push("");
                    headerXml += '<th>' + $(jq).datagrid('getColumnOption',cfs[i]).title + '</th>';
                }
            }
        }
        var visibleColumnCount = cellType.length - visibleColumnCountReduction;

		
		var rows = $(jq).datagrid('getRows');
	
        // Generate worksheet header details.
        var t = headerXml;

        // Generate the data rows from the data in the Store
        //for (var i = 0, it = this.store.data.items, l = it.length; i < l; i++) {
        for (var i = 0, it = rows, l = it.length; i < l; i++) {
            t += '<tr>';
            var cellClass = (i & 1) ? 'odd' : 'even';
            r = it[i];
            var k = 0;
			
            for (var j = 0; j < colCount; j++) {
                //if ((cm.getDataIndex(j) != '')
                if (cfs[j] != '') {
					var co = $(jq).datagrid('getColumnOption',cfs[j]);
					
                    //var v = r[cm.getDataIndex(j)];
                    var v = r[cfs[j]];
                    if (cellType[k] !== "None") {
                        t += '<td class="' + cellClass + cellTypeClass[k] + '">';
						/*var clist=$(jq).datagrid('getColumnOption',cfs[j]).list;
						if(clist){
							for(var n=0;n<clist.length;n++){
								var arr=clist[n];
								if(arr[0]===v){
									t += arr[1];
									break;
								}
							}
						}
						else*/
						if(co&&co.formatter){	
							
							t+=co.formatter(v,it[i],i);						
						}
                       /* else if (cellType[k] == 'DateTime') {
                            t += v.format('Y-m-d');
                        } */else {
                            t += v;
                        }
                        t +='</td>';
                    }
                    k++;
                }
            }
            t += '</tr>';
        }

        return  '<Table>' + t + '</Table>';
    }
});

var cardview = $.extend({}, $.fn.datagrid.defaults.view, {  
	renderRow: function(target, fields, frozen, rowIndex, rowData){  
		var cc = [];  
		cc.push('<td colspan=' + fields.length + ' style="padding:10px 5px;border:0;">');  
		if (!frozen){  
			//var aa = rowData.itemid.split('-');  
			//var img = 'shirt' + aa[1] + '.gif';  
			var img='/img/focus_01.jpg';
			cc.push('<img src="images/' + img + '" style="width:150px;float:left">');  
			cc.push('<div style="float:left;margin-left:20px;">');  
			for(var i=0; i<fields.length; i++){  
				var copts = $(target).datagrid('getColumnOption', fields[i]);  
				cc.push('<p><span class="c-label">' + copts.title + ':</span> ' + rowData[fields[i]] + '</p>');  
			}  
			cc.push('</div>');  
		}  
		cc.push('</td>');  
		return cc.join('');  
	}  
});  

$.extend($.fn.datagrid.methods, {  
	addToolbarItem: function(jq, items){  
		return jq.each(function(){  
			var toolbar = $(this).parent().prev("div.datagrid-toolbar");
			var toolbarTr=toolbar.find('table tbody tr');
			for(var i = 0;i<items.length;i++){
				var item = items[i];
				if(item === "-"){
					toolbarTr.append('<td><div class="datagrid-btn-separator"></div></td>');
				}else{
					var btn=$("<td><a href=\"javascript:void(0)\"></a></td>");
					btn[0].onclick=eval(item.handler||function(){});
					btn.css("float","left").appendTo(toolbarTr).linkbutton($.extend({},item,{plain:true}));
				}
			}
			toolbar = null;
		});  
	},
	removeToolbarItem: function(jq, param){  
		return jq.each(function(){  
			var btns = $(this).parent().prev("div.datagrid-toolbar").children("a");
			var cbtn = null;
			if(typeof param == "number"){
				cbtn = btns.eq(param);
			}else if(typeof param == "string"){
				var text = null;
				btns.each(function(){
					text = $(this).data().linkbutton.options.text;
					if(text == param){
						cbtn = $(this);
						text = null;
						return;
					}
				});
			} 
			if(cbtn){
				var prev = cbtn.prev()[0];
				var next = cbtn.next()[0];
				if(prev && next && prev.nodeName == "DIV" && prev.nodeName == next.nodeName){
					$(prev).remove();
				}else if(next && next.nodeName == "DIV"){
					$(next).remove();
				}else if(prev && prev.nodeName == "DIV"){
					$(prev).remove();
				}
				cbtn.remove();	
				cbtn= null;
			}						
		});  
	} 				
});
/*
用法：

$('#tt').datagrid("addToolbarItem",[{"text":"xxx"},"-",{"text":"xxxsss","iconCls":"icon-ok"}])

$('#tt').datagrid("removeToolbarItem","GetChanges")//根据btn的text删除

$('#tt').datagrid("removeToolbarItem",0)//根据下标删除
*/

/**
 * JQuery扩展方法，用户对JQuery EasyUI的DataGrid控件进行操作。
 */
$.fn.extend({
	/**
	 * 修改DataGrid对象的默认大小，以适应页面宽度。
	 * 
	 * @param heightMargin
	 *            高度对页内边距的距离。
	 * @param widthMargin
	 *            宽度对页内边距的距离。
	 * @param minHeight
	 *            最小高度。
	 * @param minWidth
	 *            最小宽度。
	 * 
	 */
	resizeDataGrid : function(heightMargin, widthMargin, minHeight, minWidth) {
		var height = $(document.body).height() - heightMargin;
		var width = $(document.body).width() - widthMargin;

		height = height < minHeight ? minHeight : height;
		width = width < minWidth ? minWidth : width;

		$(this).datagrid('resize', {
			height : height,
			width : width
		});
	}
});

/*
$.extend($.fn.datagrid.defaults.editors, {   
    text: {   
        init: function(container, options){   
            var input = $('<input type="text" class="datagrid-editable-input">').appendTo(container);   
            return input;   
        },   
        getValue: function(target){   
            return $(target).val();   
        },   
        setValue: function(target, value){   
            $(target).val(value);   
        },   
        resize: function(target, width){   
            var input = $(target);   
            if ($.boxModel == true){   
                input.width(width - (input.outerWidth() - input.width()));   
            } else {   
                input.width(width);   
            }   
        }   
    }
});  
*/

