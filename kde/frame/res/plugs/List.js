(function( $ ){

	var methods = {

		init : function(options) {

			var eventListDefault = [];					//事件集合
			
			var defaults = {
				IsList:true,
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
			var tt = new EasyList(st);				//初始化EasyList对象
			tt.InitList($this);						//初始化表格
			if(tt.InitEvent) tt.InitEvent();
			$.data($this[0],'EasyList',tt);
			return tt;
		},
		
		addEvent : function() {
			var tt = $.data(this[0],'EasyList');
			return tt.addEvent();
			
		},
		
		destroy : function(){ 
			var tt = $.data(this[0],'EasyList');
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
			}
		},
		resize : function(w,h){
			var tt = $.data(this[0],'EasyList');
			if(tt&&tt.JDom){
				tt.Tree.tree('resize', {
							width:w,
							height:h
				})
			}
		},
		clear : function(){
			var tt = $.data(this[0],'EasyList');
			tt.Tree.tree('loadData', [])
		},
		getThis : function(){
			var tt = $.data(this[0],'EasyList');
			return tt;
		},
		getDom : function(){
			var tt = $.data(this[0],'EasyList');
			return tt.JDom;
		},
		setParentVal : function(val){
			var tt = $.data(this[0],'EasyList');
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
				
			/*tt.refreshFormItems(function(){
				tt.Tree.datagrid('reload', {
					flt: tt.Filter
				});
				if(tt.IncForm){
					tt.ef.setParentVal(val);
				}
			});		*/	
		},
		filter : function(flt){
			var tt = $.data(this[0],'EasyList');
			tt.Filter=flt;
			tt.oldFilter=flt;
			tt.Tree.tree('reload', {
				flt: flt
			});
		}
	}
	
	function EasyList(st) {
		this.IsList=true;
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
		this.oldFilter=st.Filter;
		this.Default=st.Default;
		this.parentVal=st.parentVal;
		this.init=st.init;
		this.onClickRow=st.onClickRow;
		this.onDblClickRow=st.onDblClickRow;
		this.onRowContextMenu=st.onRowContextMenu;
		this.onLoadSuccess=st.onLoadSuccess;
	}
	
	EasyList.prototype = {
	
		constructor : EasyList,
		
		InitList : function($this) {	
			var tThis=this;
			tThis.JDom=$this;
			
			if(tThis.RealCode=="")tThis.RealCode=tThis.Code;
			var datas=tThis.Datas;

			var isDnd=false;
			var operates=tThis.Operate;
			tThis.tmenu = $('<div style="width:100px;"></div>');
			tThis.JDom.append(tThis.tmenu);
			var cou=datas.length;
			tThis.columns=[];	
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
				else if(datas[i].edittype==18){
					isDnd=datas[i].required;
				}
				else if(datas[i].visible){
					tThis.columns.push(field);
					var fmt=function(value,row,index){
						function ToInt(w){
							if(!w) return 0;
							return parseInt(w);
						}
						if(this.edittype==4||this.edittype==5||this.edittype==19||this.edittype==23){
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
					else if(datas[i].edittype==5||datas[i].edittype==19){						
						var sql=datas[i].linklist;
						sql=sql.replaceAll('@id@',tThis.parentVal);
						get(tThis.Url,{param:'combo',path:tThis.Path,sql:sql},'json',function(data){
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
					else if(datas[i].edittype==13){
						datas[i].list=datas[i].linklist;
					}	
				}
			};
			
			tThis.buttons=[];
			tThis.tmenu.menu({});
			var toolbar=[];
			for(var i=0;i<operates.length;i++){
				var button={
					id:tThis.RealCode+'_opt_'+operates[i].code,
					text:operates[i].name,
					iconCls:operates[i].cssicon,
					ev:operates[i].description,
					handler:function(){
						var ev=this.ev;
						if(!ev){
							for(var j=0;j<operates.length;j++){
								if(tThis.RealCode+'_opt_'+operates[j].code==this.id){
									ev=operates[j].description;
									break;
								}
							}	
						}
						var __grid=tThis;
						var script=makeScript(ev);
						var ostr="$grid=$('#"+tThis.RealCode+"');\n";
						eval(ostr+script);						
					}
				};
				if(operates[i].operatetype==0){
					toolbar.push(button);
					tThis.tmenu.menu('appendItem',button);
				}
				else if(operates[i].operatetype==1){
					tThis.buttons.push(button);					
				}
			}

			tThis.Panel=tThis.JDom;//$('<div></div>').appendTo(tThis.JDom);
			
			tThis.Panel.panel({
				tools:toolbar,			
				maximized:true,
				border:false,
				title:tThis.Title,	
				width:tThis.Width,
				height:tThis.Height,
				content:'<ul></ul>'
			});

			tThis.JDom.parent().find('.panel-tool a').each(function(index){
				if(toolbar[index].ev)
					this.ev=toolbar[index].ev;
			})
			
			tThis.Tree=tThis.Panel.find('ul:eq(0)');
			tThis.Tree.tree({
				animate:true,
				dnd:isDnd,
				onDrop:function(target,source,point){
					
					var parent=tThis.Tree.tree('getNode',target);
					if(parent&&parent.id){
						get(tThis.FormUrl,{param:'saveTree',path:tThis.Path,__DataCode:tThis.Code,id:source.id,parent:parent.id},'json',function(data){
							
						})
					}
				},
				onDblClickRow:tThis.onDblClickRow,
				onClick:tThis.onClickRow,
				onContextMenu: function(e,node){
					if(tThis.onRowContextMenu)
						tThis.onRowContextMenu(e,node);
					else{
						e.preventDefault();
						$(this).tree('select',node.target);
						tThis.tmenu.menu('show',{
							left: e.pageX,
							top: e.pageY
						});
					}
				},
				formatter:function(node){
					return node[tThis.columns[0]];
				}
			});	
			
			tThis.refreshData();
			
			if(tThis.IncForm&&!tThis.form){
				setTimeout(function(){tThis.initFormDialog(300,200)},200); //创建表单需要占用较多资源，线程执行
			}
		},
		refreshData : function(){
			var tThis=this;
			get(tThis.Url,{param:'treeList',path:tThis.Path,code:tThis.Code},'json',function(data){
				tThis.Tree.tree({data:data});
				if(tThis.onLoadSuccess)tThis.onLoadSuccess(data);
			})
		},
		
		initFormDialog :function(w,h){
			if(this.IncForm&&!this.form){
				this.FindForm=$('<form method="post" enctype="multipart/form-data" tag="findForm" style="display:none;"></form>');
				this.form = $('<form method="post" enctype="multipart/form-data" tag="editForm" style="display:none;"></form>');
				this.form.Url=this.FormUrl;
				this.JDom.append(this.form);
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
					findForm:this.FindForm
				});
			};
		},
		
				
		showFindDialog:function(item){	
			var $this=this;
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
								if(flt!==""){
									if($this.Filter)
										flt+=" and "+$this.Filter;
								}
								else 
									flt=$this.Filter;
								$this.JDom.tree('reload', {
									flt: flt
								});
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

					if(ety==13){
						var sv=field.eq(0).numberbox('getValue');
						var ev=field.eq(1).numberbox('getValue');	
						if(fty==1){
							if(sv!="")flt+=" and "+fld+">"+sv;
							if(ev!="")flt+=" and "+fld+"<"+ev;
						}
						else{
							if(sv!="")flt+=" and "+fld+">'"+sv+"'";
							if(ev!="")flt+=" and "+fld+"<'"+ev+"'";
						}
					}
					else if(ety==4||ety==5||ety==21){
						var val=field.combobox('getValue');
						if(val!="")flt+=" and "+fld+"='"+val+"'";
					}
					else if(ety==23){
						var val=field.combogrid('getValue');
						if(val!="")flt+=" and "+fld+"='"+val+"'";
					}
					else if(ety==19||ety==24){
						var val=field.combotree('getValue');
						if(val!="")flt+=" and "+fld+"='"+val+"'";
					}
					else if(ety==6||ety==16){ //日期
						var sv=field.eq(0).datebox('getValue');
						var ev=field.eq(1).datebox('getValue');						
						if(sv!="")flt+=" and "+fld+">'"+sv+"'";
						if(ev!="")flt+=" and "+fld+"<'"+ev+"'";
						
					}
					else{
						var val=field.val();
						if(val!="")flt+=" and "+fld+" like '%"+val+"%'";
					}
				}
			}
			if(flt!="")flt=flt.replace(" and ","");

			return flt;
		},
		
		showFormDialog:function(item,parentID){	
			if(!this.form.dialoged){
				this.form.dialoged=true;
				this.form.show();
				this.form.dialog({title:this.FormTitle,doSize:true,closable:true,modal:true,buttons:this.buttons,resizable:true/*,onClose:function(){$(this).dialog('destroy');}*/});
			}
			this.form.dialog('open');
			this.form.parentID=null;
			if(!item)AddForm(this,parentID);
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
		refresh:function(){
			this.refreshData();
		},
		getSelected : function(){
			return this.Tree.tree('getSelected');
		},
		
		getSelections : function(){
			return this.Tree.tree('getSelected');
		},
		
		clearSelections: function(){
			this.Tree.tree('clearSelections');
		},				
		select : function(id){
			this.Tree.tree('select',id);
		},
		unselect : function(id){
			this.Tree.tree('unselect',id);
		},
		find:function(id){
			return this.Tree.tree('find',id);
		},
		update : function(id,row){
			var node=this.find(id);
			if(node){
				var data=row;
				data.target=node.target;
				this.Tree.tree('update',data);
				/*for(var i=0;i<this.columns.length;i++){
					node[this.columns[i]]=row[this.columns[i]];
				}
				var c=this.columns[0];
				this.Tree.tree('update',{
										target: node.target,
										c:row[c]
									});*/
			}
		},
		remove : function(id){
			this.Tree.tree('remove',id);
		},
		getChildren : function(id){	
			var node=this.find(id);
			if(node){
				if(this.Tree.tree('isLeaf',node.target))
					return null;
				else
					return this.Tree.tree('getChildren',node.target);
			}
			else
				return null;
		}
	}
		
	$.fn.EasyList = function( method ) {
		if( methods[method] ) {
			return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ) );
		} else if ( typeof method === 'object' || !method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'No '+method+' method' );
		}
	};
})( jQuery );