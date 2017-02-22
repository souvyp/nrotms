(function( $ ){
	
	var methods = {

		init : function(options) {

			var eventListDefault = [];					//事件集合
			
			var defaults = {
				IsTree:true,
				Url:'grid.cn',
				FormUrl:'form.cn',
				Path:'T_User',
				Code:'T_User',
				RealCode:'',
				Title:'',
				FormTitle:'',
				Icon:'',
				Width:'auto',
				Height:null,
				IncForm:true,
				ShortButton:false,
				FormCols:1,
				Datas:[],
				Operate:[],
				SingleSelect:true,
				IsWindow:false,
				InitEvent:null,
				showTimes:false,
				pageSize : 20,
				formatter : null,
				styler : null,
				hasCheckBox : false,
				Filter:'',
				init:null,
				onClickRow:null,
				onDblClickRow:null,
				onRowContextMenu:null,
				onLoadSuccess:null
			}
			
			var $this = this;
						
			var st = $.extend( true, defaults, options );
			var tt = new EasyTree(st);					//初始化EasyTree对象
			tt.InitGrid($this);						//初始化表格
			$.data($this[0],'EasyTree',tt);
			if(tt.InitEvent) tt.InitEvent();
			return tt;
		},
		
		addEvent : function() {
			var tt = $.data(this[0],'EasyTree');
			return tt.addEvent();
			
		},
		
		destroy : function() {
			var tt = $.data(this[0],'EasyTree');
			if(tt&&tt.form){
				if(tt.form.dialoged){
					tt.form.dialog('destroy');
					tt.form.remove();
				}
			}
			if(tt/*&&tt.tmenu.showed*/){
				tt.tmenu.menu('destroy');
				tt.tmenu.remove();
				tt.optMenu.menu('destroy');
				tt.optMenu.remove();
			}
		},
		resize : function(w,h){
			var tt = $.data(this[0],'EasyTree');
			if(tt&&tt.JDom){				
				if(w){
					tt.JDom.treegrid('resize', {
								width:w,
								height:h
					})
				}
				else{
					tt.JDom.treegrid('resize');
				}
			}
		},
		clear : function(){
			var tt = $.data(this[0],'EasyTree');
			tt.JDom.treegrid('loadData', [])
		},
		getThis : function(){
			var tt = $.data(this[0],'EasyTree');
			return tt;
		},
		getDom : function(){
			var tt = $.data(this[0],'EasyTree');
			return tt.JDom;
		},
		filter : function(flt){
			var tt = $.data(this[0],'EasyTree');
			tt.Filter=flt;
			tt.JDom.treegrid('reload');
		}
	}
	
	function EasyTree(st) {
		this.IsTree=true;
		this.Url=st.Url;
		this.FormUrl=st.FormUrl;
		this.Path=st.Path;
		this.Code=st.Code;
		this.RealCode=st.RealCode;
		this.Title=st.Title;
		this.FormTitle=st.FormTitle;
		this.Icon=st.Icon;
		this.ShortButton=st.ShortButton;
		this.Width=st.Width;
		this.Height=st.Height;
		this.IncForm=st.IncForm;
		this.FormCols=st.FormCols;
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
		this.init=st.init;
		this.onClickRow=st.onClickRow;
		this.onDblClickRow=st.onDblClickRow;
		this.onRowContextMenu=st.onRowContextMenu;
		this.onLoadSuccess=st.onLoadSuccess;
	}
	
	EasyTree.prototype = {
	
		constructor : EasyTree,
		
		InitGrid : function($this) {	
			var tThis=this;
			tThis.JDom=$this;
			
			var datas=tThis.Datas;
			var frozenColumns=[];
			//if(!tThis.SingleSelect)
			//	frozenColumns.push({field:'ck',checkbox:true});
				
			var columns=[];
			var gcolumns=[];
			
			tThis.columns=columns;
			tThis.frozenColumns=frozenColumns;
			
			var operates=tThis.Operate;
			tThis.tmenu = $('<div style="width:100px;"></div>');
			tThis.optMenu=$('<div style="width:100px;"></div>');
			tThis.JDom.append(tThis.tmenu);
			tThis.JDom.append(tThis.optMenu);
			var cou=datas.length;
			var cgn="";		
			for(var i=0;i<cou;i++){
				var field=datas[i].fieldname.toLowerCase();
				if(datas[i].keys){
					tThis.Keys=field;
					//frozenColumns.push({field:field,hidden:true});
				}
				else if(datas[i].visible){
					var fmt=function(value,row,index){
						if(this.edittype==4||this.edittype==5){
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
					else if(datas[i].edittype==5||datas[i].edittype==19||datas[i].edittype==23){						
						var sql=datas[i].linklist;
						get(tThis.Url,{param:'combo',sql:sql},'json',function(data){
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
					
					var disF=datas[i].displayname;
					if(datas[i].locked)
						frozenColumns.push({field:field,
							title:disF,
							width:Math.min(Math.max(datas[i].displaywidth,80),500),
							sortable:datas[i].sorted,
							mask:datas[i].editmask,
							edittype:datas[i].edittype,
							list:datas[i].list,
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
												edittype:datas[j].edittype,
												list:datas[i].list,
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
								edittype:datas[i].edittype,
								list:datas[i].list,
								formatter:fmt,
								rowspan:2//,
							//	editor:eval("({type:'combobox',options:{valueField:'productid',textField:'name',data:products,required:true}})")
							});
						}
						$('<div iconCls="icon-ok"/>').html('<span tag="'+field+'">'+disF+'</span>').appendTo(tThis.tmenu);
					
					}
				}
			};
			
			tThis.initColumnMenu();
			tThis.optMenu.menu({});
			tThis.buttons=[];
			var toolbar=[];
			for(var i=0;i<operates.length;i++){
				var button={
					id:tThis.RealCode+'_opt_'+operates[i].code,
					text:operates[i].name,
					iconCls:operates[i].cssicon,
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
				if(operates[i].operatetype==0){
					tThis.optMenu.menu('appendItem',button);
					//if(tThis.ShortButton)button.text='';
					toolbar.push(button);
				}
				else if(operates[i].operatetype==1)
					tThis.buttons.push(button);
			}
			if(toolbar.length==0)toolbar=null;
			var c=[];
			c.push(gcolumns);
			if(columns.length>0)
				c.push(columns);
			tThis.JDom.treegrid({
				title:tThis.IsWindow?tThis.Title:null,
				width:tThis.Width,
				height:tThis.Height,
				singleSelect: tThis.SingleSelect,
				idField:tThis.Keys,
				treeField:tThis.frozenColumns[0].field,
				showFooter:false,/*!tThis.ShortButton,*/
				url:tThis.Url+'?param=treedata&path='+tThis.Path+'&code='+tThis.Code,
				remoteSort: false,
				animate:true,
				border:tThis.ShortButton,
				frozenColumns:[frozenColumns],
				columns:c,
				pagination:tThis.ShortButton,
				rownumbers:true,
				fitColumns: true, 
				fit:true,
				toolbar:toolbar,
				onDblClickRow:tThis.onDblClickRow,
				onClickRow:tThis.onClickRow,
				onContextMenu:function(e, row){

					e.preventDefault();
					
					if(tThis.onRowContextMenu)
						tThis.onRowContextMenu(e,row);
					else{
						tThis.select(row.id);
						tThis.optMenu.menu('show', {
							left:e.pageX,
							top:e.pageY
						});
					}
				},
				onHeaderContextMenu: function(e, field){
					e.preventDefault();
					tThis.tmenu.showed=true;
					tThis.tmenu.menu('show', {
						left:e.pageX,
						top:e.pageY
					});
				},
				onLoadSuccess: function (row,data) { 
					if(data.count){
						var fld;
						if(tThis.frozenColumns.length>0)fld=tThis.frozenColumns[0].field;
						else fld=tThis.columns[0].field;
						if(tThis.showTimes){
							tThis.showTimes(data.time);
						}
						var footer=eval('({"'+fld+'":"共 '+data.count+' 条记录","iconCls":"icon-sum"})');		
						tThis.JDom.treegrid('reloadFooter',[footer]);
					}
					if(!tThis.noInited){
						tThis.noInited=true;
						if(tThis.init)tThis.init(tThis);
					}
					if(tThis.onLoadSuccess){
						tThis.onLoadSuccess(data);
					}
					if(tThis.showTimes){
						tThis.showTimes(data.time);
					}
				}
			});	
			
			if(tThis.IncForm&&!tThis.form){
				setTimeout(function(){tThis.initFormDialog(300,200)},200); //创建表单需要占用较多资源，线程执行
			}
		},

		initColumnMenu : function(){
			var tThis=this;
			tThis.tmenu.menu({
				onClick: function(item){
					
					if (item.iconCls=='icon-ok'){
						
						var name=$(item.target.firstChild.firstChild).attr("tag");
						tThis.JDom.treegrid('hideColumn', name);
						tThis.tmenu.menu('setIcon', {
							target: item.target,
							iconCls: 'icon-empty'
						});
					} else {
						var name=$(item.target.firstChild.firstChild).attr("tag");
						tThis.JDom.treegrid('showColumn', name);
						tThis.tmenu.menu('setIcon', {
							target: item.target,
							iconCls: 'icon-ok'
						});
					}
				}
			});
		},
		
		initFormDialog :function(w,h){
			if(this.IncForm&&!this.form){
				this.form = $('<form method="post" enctype="multipart/form-data" tag="editForm" style="display:none;"></form>');
				this.form.Url=this.FormUrl;
				this.JDom.append(this.form);
				this.form.EasyForm({
					Url:this.FormUrl,
					Path:this.Path,
					Code:this.Code,
					RealCode:this.RealCode,
					Title:this.FormTitle,
					Icon:this.Icon,
					Width:w,
					Height:h,					
					Datas:this.Datas,
					Cols:this.FormCols
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
				
		showFormDialog:function(item,parentID){		
			if(!this.form.dialoged){
				this.form.dialoged=true;
				this.form.show();
				this.form.dialog({title:this.FormTitle,modal:true,buttons:this.buttons});
			}
			
			this.form.dialog('open');
			this.form.parentID=null;
			if(!item)AddForm(this,parentID);
			else this.form.isNews="";
			if(item){
				var datas=this.Datas;
				for(var i=0;i<datas.length;i++){
					var field=datas[i].fieldname.toLowerCase();
					var ety=datas[i].edittype;
					var fld=this.RealCode+'_fld_'+field;
					if(ety==6){
						var val=item[field];
						if(val!=""){
							if(val.indexOf(':')>0)
								$('#'+fld).datetimebox('setValue', val);	
							else
								$('#'+fld).datebox('setValue', val);	
						}
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
					else if(ety==4||ety==5||ety==21){
						$('#'+fld).combobox('setValue', item[field]);
					}
					else if(ety==14){
						if(!$('#'+fld).inited){
							$('#'+fld).inited=true;
							$('#'+fld).xheditor({tools:'mini'});
						}
						$('#'+fld).val(item[field]);
					}
					else if(ety==17){
						$('#'+fld).val(item[field]);
					}
					else {
						var val=item[field];
						if(val!=""){	
							$('#'+fld).val(val);	
						}				
					
					}
				}
			}
			
		},
		
		refresh : function(id){
			if(!id)
				this.JDom.treegrid('reload');
			else{
				//this.JDom.treegrid('expand', id);
				this.JDom.treegrid('reload', id);
			}
		},
		collapse:function(n){			
			if (!n){
				var node=this.JDom.treegrid('getSelected');
				this.JDom.treegrid('collapse', node[this.Keys]);
			}
			else
				this.JDom.treegrid('collapse', n);
		},
		expand : function(n,h){
			var node;
			if(n)
				node=this.JDom.treegrid('find',n);
			else
				node=this.JDom.treegrid('getSelected');
			if(h){
				if(node.state=="closed"){
					var oldLoad=this.onLoadSuccess;
					this.onLoadSuccess=function(row){
						h();
						this.onLoadSuccess=oldLoad;
					}
				}
				else
					h();
			}
			if (node){
				this.JDom.treegrid('expand', node[this.Keys]);
			};
		},
		collapseAll:function(){
			var node = this.JDom.treegrid('getSelected');
			if (node){
				this.JDom.treegrid('collapseAll', node[this.Keys]);
			} else {
				this.JDom.treegrid('collapseAll');
			}
		},
		expandAll:function (){
			var node = this.JDom.treegrid('getSelected');
			if (node){
				this.JDom.treegrid('expandAll', node[this.Keys]);
			} else {
				this.JDom.treegrid('expandAll');
			}
		},
		toggle : function(id){
			this.JDom.treegrid('toggle',id);
		},
		getSelected : function(){
			return this.JDom.treegrid('getSelected');
		},
		
		getSelections : function(){
			return this.JDom.treegrid('getSelections');
		},
		
		clearSelections: function(){
			this.JDom.treegrid('clearSelections');
		},				
		select : function(id){
			this.JDom.treegrid('select',id);
		},
		unselect : function(id){
			this.JDom.treegrid('unselect',id);
		},
		update : function(id,row){
			this.JDom.treegrid('update',{
									id:id,
									row:row
								});
		},
		remove : function(id){
			this.JDom.treegrid('remove',id);
		},
		getChildren : function(id){
			return this.JDom.treegrid('getChildren',id);
		}
	}
		
	$.fn.EasyTree = function( method ) {
		if( methods[method] ) {
			return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ) );
		} else if ( typeof method === 'object' || !method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'No '+method+' method' );
		}
	};
})( jQuery );