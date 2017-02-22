/*$.fn.panel.defaults = $.extend({},$.fn.panel.defaults,{onBeforeDestroy:function(){
		$(this).find(".combo-f").each(function () {
			$(this).combo("destroy");
		});	
		$(this).find(".searchbox-f").each(function () {
			$(this).searchbox("destroy");
		});		
	}
});*/
/*
function LoadFileValError(obj,val){   //接管easyui form load 问题
	//obj.next().find(".inputfile").val(val);
	//alert(val);
	obj.prev().val(val);
//	obj.filebox('setText', val);
	//alert(val);
}*/

(function( $ ){

		
	var methods = {

		init : function(options) {

			var eventListDefault = [];					//事件集合
			
			var defaults = {
				Url:'form.cn',
				NavUrl:'grid.cn',
				Path:'T_User',
				Code:'T_User',
				RealCode:'',
				Title:'测试',
				Icon:'',
				Width:'auto',
				Height:null,
				IsNew:false,
				Cols : 1,
				FindCols : 1,
				Datas:[],
				Operate:[],
				hasNav:false,
				itemWidth:150,
				ShortButton:false,
				postButton:'',
				inited:null,
				findForm:null,
				parentVal : null,
				Filter:'',
				IncForm:false,
				Grid:null,
				init:null,
				navLoaded:null,
				beforeLoad:null
			}
			
			var $this = this;
						
			var st = $.extend( true, defaults, options );
			var tt = new EasyForm(st);					//初始化EasyForm对象
			tt.InitForm($this);						//初始化表单
			$.data($this[0],'EasyForm',tt);
			return tt;
		},
		
		addEvent : function() {
			var tt = $.data(this[0],'EasyForm');
			return tt.addEvent();
			
		},
		getThis : function(){
			var tt = $.data(this[0],'EasyForm');
			return tt;
		},
		getDom : function(){
			var tt = $.data(this[0],'EasyForm');
			return tt.JDom;
		},
		load : function(data){
			var tt = $.data(this[0],'EasyForm');
			tt.form.form('load',data);
		},
		setParentVal : function(val){
			var tt = $.data(this[0],'EasyForm');
			tt.parentVal=val;
			tt.refreshFormItems(this);
		},
		setDef : function(val){
			var tt = $.data(this[0],'EasyForm');
			tt.Default=val;
		},
		destroy : function() {
			/*var tt = $.data(this[0],'EasyForm');
			if(tt.form&&tt.form.dialoged){
				tt.form.dialog('destroy');
				tt.form.remove();
			}
			if(tt.FindForm&&tt.FindForm.dialoged){
				tt.FindForm.dialog('destroy');
				tt.FindForm.remove();
			}
			//tt.destroyFormItems(this);
			//tt = null;*/
		
		}
	}
	
	function EasyForm(st) {
		this.Url=st.Url;
		this.NavUrl=st.NavUrl;
		this.Path=st.Path;
		this.Code=st.Code;
		this.RealCode=st.RealCode;
		this.Title=st.Title;
		this.Icon=st.Icon;
		this.Width=st.Width;
		this.Height=st.Height;
		this.Datas=st.Datas;
		this.IsNew=st.IsNew;
		this.Operate=st.Operate;
		this.Cols=st.Cols;
		this.FindCols=st.FindCols;
		this.hasNav=st.hasNav;
		this.postButton=st.postButton;
		this.inited=st.inited;
		this.findForm=st.findForm;
		this.itemWidth=st.itemWidth;
		this.parentVal=st.parentVal;
		this.Filter=st.Filter;
		this.ShortButton=st.ShortButton;
		this.IncForm=st.IncForm;
		this.Grid=st.Grid;
		this.init=st.init;
		this.navLoaded=st.navLoaded;
		this.beforeLoad=st.beforeLoad;
	}
	
	EasyForm.prototype = {
	
		constructor : EasyForm,
		
		InitForm : function($this) {	
			var datas=this.Datas;
			
			var items='';
			if(this.hasNav){
				items+='<div id="nav_'+this.RealCode+'" class="formToolbar"></div>'; 
			}
			else if(this.postButton){
				items+='<div class="formToolbar"><button>'+this.postButton+'</button></div>'; 
			}
			items+='<table class="formTable"><tr>';

			var cols=this.Cols;
			var cou=datas.length;
			
			function getNextEdit(inx){
				for(var w=inx+1;w<cou;w++){
					if(datas[w].editvisible){
						return datas[w];
					}
				}
				return null;
			}
			var j=1,n=1;
			for(var i=0;i<cou;i++){
				var fld=datas[i].fieldname.toLowerCase();
				var disable='';
				if(datas[i].readonly)disable='disabled="disabled"';
				if(datas[i].keys||datas[i].foreignkey||datas[i].edittype==18){ 
					if(datas[i].keys)this.key=fld;
					else if(datas[i].foreignkey) this.fkey=fld;
					items+='<input type="hidden" id="'+this.RealCode+'_fld_'+fld+'" name="'+fld+'"></input>';
				}

				if(datas[i].editvisible){
					var ety=datas[i].edittype;
					var w=Math.max(datas[i].editsize,this.itemWidth);
					var k=1;
					var wraped=true;
					if(cols>1){
						n++;
						wraped=j%cols==0;
						
						if(j%cols==0){
							k=(cols-j)*2+1;		
							wraped=true;
						}
						else{
							var nxd=getNextEdit(i);
							if(nxd){						
								if(nxd.singleline){
									wraped=true;
									k=(cols-j)*2+1;								
								}
							}
						}
						if(datas[i].singleline) {
							k=cols*2-1;
							wraped=true;
						}
					}
					else n=2;
					
					if(datas[i].singleline&&wraped&&cols>1)w=(this.itemWidth+45)*cols-5;
					
					j++;
					var disF=datas[i].displayname;
					disF=disF.replace('||','/');
					items+='<th>'+disF+':</th><td colspan='+k+'>';
					var pre='';
					var mId;
					if(ety==2) pre='type="password"';
					else if(ety==24) {pre='multiple';
						mId=this.RealCode+'_fld_'+fld+'_btn';
					}					
					else if(ety==7) pre='type="checkbox"';	
					else if(ety==17) pre='type="text"';
					if(ety==3||ety==14)
						items+='<textarea id="'+this.RealCode+'_fld_'+fld+'" tag='+ety+' name="'+fld+'" style="width:'+w+'px;height:100px" '+disable+'></textarea>';
					else if(ety==23)
						items+='<select id="'+this.RealCode+'_fld_'+fld+'" name="'+fld+'" style="width:'+w+'px;" '+disable+'></select>';
					else if(ety==17||ety==26){
						/*var ie = !-[1,];
						if( ie)  
							items+='<input type="file" '+pre+' id="'+this.RealCode+'_fld_'+fld+'" name="'+fld+'" style="width:'+w+'px;" class="input"></input>';
						else{
							var inputId=this.RealCode+'_fld_'+fld;
							var btnId=this.RealCode+'_btn_'+fld;
							var fname=fld;
							
							items+='<input type="file" ';
							if(ety==17)
								items+='name="'+fname+'" tag="file_'+inputId+'"';
							items+='class="file"/><span class="fileinput" style="width:'+w+'px;"><input class="inputfile" id="'+inputId+'" style="width:'+(w-18)+'px;"/><span id="'+btnId+'" class="btnfile"></span>';
							if(ety==26)
								items+='<input type="hidden" name="'+fname+'"></input>';							
							items+='</span>';

							$('#'+btnId).die().live('click',function(){ 
								
								var ie = !-[1,];  
								var file=$(this).parent().prev();
								file.unbind('change');
								file.bind('change',function(){
									var ta=$(this).next().children();
									readImgFile($(this).get(0),function(data){
										ta.eq(2).val(data);
									})
									ta.eq(0).val($(this).val());
								});
								if(ie){  	
									file.trigger('click').trigger('change');  
								}else{  
									file.trigger('click');  
								}   
								  
							});
						}  */
						items+='<input '+pre+' id="'+this.RealCode+'_fld_'+fld+'" name="'+fld+'" style="width:'+w+'px;" class="input" '+disable+'></input>';
					}
					else if(ety==24){
						items+='<input '+pre+' id="'+this.RealCode+'_fld_'+fld+'" name="'+fld+'" style="width:'+w+'px;" class="input" '+disable+'></input><button id="'+mId+'" class="btnfile"></button>';						
					}
					else if(ety==7)
						items+='<input '+pre+' id="'+this.RealCode+'_fld_'+fld+'" name="'+fld+'" style="width:16px;" value="1" class="input" '+disable+'></input>';
					else if(ety==11){
						var arr=datas[i].linklist.split(',');
						items+='<input name="'+arr[0]+'" type="hidden"></input><input '+pre+' id="'+this.RealCode+'_fld_'+fld+'" name="'+fld+'" style="width:'+w+'px;" class="input"></input>';
					}else 
						items+='<input '+pre+' id="'+this.RealCode+'_fld_'+fld+'" name="'+fld+'" style="width:'+w+'px;" class="input" '+disable+'></input>';
					items+='</td>';
					if(wraped/*&&n>1*/) {
						items+='</tr>\n<tr>';
						j=1;
					}
				}
			}
			j--;
			if(j<cols&&j>0)items+='<td colspan="'+((cols-j)*2)+'">&nbsp;</td>';
			items+='</tr></table>';
			items=items.replace('<tr></tr>','');
			
			$this.append($(items));			
			
			if(mId){
				createMulFiles('',mId);
			}
			this.makeFormItems($this);
			
			var tThis=this;

			if(this.postButton){
				$this.find(".formToolbar button").click(function(){
					SaveForm(tThis);
				});
			}	
			
			var operates=tThis.Operate;
			
			var buttons=[];
			var toolbar=[];
			for(var i=0;i<operates.length;i++){
				var button={
					id:$this.RealCode+'_opt_'+operates[i].code,
					text:operates[i].name,
					iconCls:operates[i].cssicon,
					handler:function(){		
						for(var i=0;i<operates.length;i++){
							if($this.RealCode+'_opt_'+operates[i].code==this.id){
								var __form=tThis;
								var script=makeScript(operates[i].description);
								eval(script);
							}
						}						
					}
				};
				if(operates[i].operatetype==3){
					if(tThis.ShortButton)
						button.text='';
					toolbar.push(button);
				}
				else if(operates[i].operatetype==1){
					if(tThis.hasNav){
						button.text='';
						toolbar.push(button);
					}
					else
						buttons.push(button);
				}
			}
			if(toolbar.length==0)toolbar=null;
			if(buttons.length==0)buttons=null;
			
			if(buttons&&tThis.ShortButton){
				var btnToolbarId=$this.RealCode+'_button_toolbar';
				var buttonToolbar='<div id="'+btnToolbarId+'" style="text-align:center;padding:5px">';
				for(var n=0;n<buttons.length;n++){	
					buttonToolbar+='<a href="javascript:void(0)">'+buttons[n].text+'</a>';
				}
				buttonToolbar+='</div>';
				$this.append($(buttonToolbar));
				$('#'+btnToolbarId+' a').each(function(inx){
					$(this).linkbutton({iconCls:buttons[inx].iconCls});
					$(this).click(function(){
						buttons[inx].handler();
					})
				});
				
			}
			tThis.form=$this;
			if(tThis.IsNew){
				tThis.isNews=tThis.IsNew;
				tThis.form.isNews=tThis.IsNew;
			}
			tThis.form.FormUrl=tThis.Url;
			this.InitFindForm($this);

			if(this.hasNav){
				this.navData($this,1,function(data){						
					$('#nav_'+tThis.RealCode).pagination({  
						total:data.total,  
						pageSize:1,
						pageList: [1],	
						displayMsg:'',
						afterPageText:'共'+data.total+'页',
						buttons: toolbar,
						onSelectPage:function(pageNumber, pageSize){
							tThis.navData($this,pageNumber,function(data){
								$('#nav_'+tThis.RealCode).pagination('refresh',{  
									total:data.total,
									afterPageText:'共'+data.total+'页'
								});
							});
						}
					});  
					
					$('#nav_'+tThis.RealCode+' .pagination-page-list').parent().next().remove();
					$('#nav_'+tThis.RealCode+' .pagination-page-list').parent().remove();
					//$('#nav_'+tThis.RealCode+' .pagination-page-list').parent().html('<label>'+tThis.Title+'</label>');
				});
			}
			else if(this.postButton){
				this.navData($this,1,function(data){
					//tThis.isNews=false;
					//$('#postButton_'+tThis.Code).html('');
				});
			}
			if(tThis.init)tThis.init(tThis);
			
		},
				
		InitFindForm:function ($this) {
			if(this.findForm){
				var datas=this.Datas;
				var items='<table class="formTable">';
				var cou=datas.length;
				var col=this.FindCols;
				var j=0;
				for(var i=0;i<cou;i++){
					if(datas[i].filtered||datas[i].paramfld){
					
						if(j%col==0){
							if(j>0)
								items+='</tr>';
							items+='<tr>';
						}
						j++;
						var fld=datas[i].fieldname.toLowerCase();
						var disF=datas[i].displayname;
						var ety=datas[i].edittype;
						var findCol=datas[i].findfld;
						var w=220;
						var disable="";
						if(!findCol)
							items+='<th>'+disF+':</th>';
						else{
							items+='<th><input type="checkbox" id="check_'+this.RealCode+'_fld_'+fld+'" onclick="changeFindState(this,'+ety+')" /><label for="check_'+this.RealCode+'_fld_'+fld+'">'+disF+'</label>:</th>';
							disable='disabled="disabled"';
						}
						if(ety==19||ety==23||ety==25||ety==5||ety==21||ety==4||ety==12)
							items+='<td colspan="2"><select FindId="'+this.RealCode+'_fld_'+fld+'" name="find_'+fld+'" '+disable+' style="width:'+w+'px;"></select>';
						else if((!datas[i].paramfld)&&(ety==6||ety==16||ety==3||ety==13)){ //日期,数值
							w=parseInt(w/2)-1;
							var sdate='<input FindId="'+this.RealCode+'_fld_'+fld+'" name="find_'+fld+'__start" '+disable+' style="width:'+w+'px;"></input>';
							items+='<td>'+sdate+'</td><td>'+sdate.replaceAll('__start','__end');
						}
						else
							items+='<td colspan="2"><input FindId="'+this.RealCode+'_fld_'+fld+'" name="find_'+fld+'" '+disable+' style="width:'+w+'px;" class="input"></input>';
						items+='</td>';
					}
				}
				j=j%col*3;
				if(j>0)items+='<td colspan="'+j+'"></td>';
				items+='</tr></table>';
				this.findForm.append($(items));
				this.makeFormItems($this,true);
			}
		},
		
		navData : function($this,page,h){
			var tThis=this;
			if(tThis.IsNew){
				get(tThis.Url,{param:'default',path:tThis.Path,__DataCode:tThis.Code},'json',function(data){	
					var row=data;
					data.total=0;
					$this.form('load',row);
					if(tThis.navLoaded)tThis.navLoaded(row,tThis.key);
					if(h)h(data);
				})
			}
			else
				get(tThis.NavUrl,{param:'data',rows:1,page:page,path:tThis.Path,code:tThis.Code,flt:tThis.Filter},'json',function(data){	
					var row=data.rows[0];
					$this.form('load',row);
					if(tThis.navLoaded)tThis.navLoaded(row,tThis.key);
					if(h)h(data);
				})
		},
		
		makeFormItems:function ($this,isFind){
			function ToInt(i){
				if(!i) return 0;
				return parseInt(i);
			}
			
			function Link(pdom,tdom){	
				/*var fdom=tdom;
				pdom.combobox({onSelect:function(record){
					fdom.attr("flt","parent_id='"+record["id"]+"'");
					fdom.combobox('clear');
					fdom.combobox('enable');
					fdom.combobox('reload');
				}});*/
				if(pdom&&tdom){
					$('#'+pdom).combobox({onSelect:function(record){
						var fdom=$('#'+tdom);
						fdom.attr("flt","parent_id='"+record["id"]+"'");
						fdom.combobox('clear');
						fdom.combobox('enable');
						fdom.combobox('reload');
					}})
				}
			}
			
			var tThis=this;
			var $dom=$this;
			var datas=tThis.Datas;
			var fields;
			if(tThis.Grid&&tThis.Grid.editable) fields= tThis.Grid.datagrid('getColumnFields',true).concat(tThis.Grid.datagrid('getColumnFields'));
			
			function makeEditor(editor,field,finded){
				if(fields){
					if(!editor.type)editor='text';
					for(var n=0; n<fields.length; n++){
						var col = tThis.Grid.datagrid('getColumnOption', fields[n]);
						if(col.editgrid&&fields[n]==field){
							fields.RemoveIndex(n);							
							col.editor=editor;
						}
					}
				}
			}
			
			for(var i=0;i<datas.length;i++){
				var wField=datas[i].fieldname.toLowerCase();
				var fld=tThis.RealCode+'_fld_'+wField;
				var field=$('#'+fld);
				var findCol=datas[i].findfld;
				if(isFind)field=$("[FindId='"+fld+"']");
				if(field.length>0){					
					var editor={};
					var options=null;
					var ety=datas[i].edittype;
					if(ety==1||ety==2||ety==3){
						options={type:ety==2?'password':'text',multiline:ety==3};
						if(datas[i].validtype!=""){							
							options.required=datas[i].required&&(!isFind)?true:false;
							options.validType=datas[i].validtype;
							options.disabled=findCol;
						}
						else if(datas[i].required)
							options.required=!isFind;
						options.disabled=findCol;
						options.editable=!datas[i].readonly;
						if(datas[i].editvisible){
							field.textbox(options);								
							makeEditor(editor,wField,isFind);		
						}										
					}
					
					else if(ety==4){
						var arr=datas[i].linklist.split('\r');
						var List=[];
						if(isFind){
							List.push({label:'',value:'全部'});
						}
						else{
							List.push({label:'zm_null',value:'---------'});
						}
						for(var j=0;j<arr.length;j++){
							var arr1=arr[j].split("=");
							List.push({
								label: arr1[0],
								value: arr1[1]
							})
						}
						options={  								
							valueField: 'label',
							textField: 'value',
							data: List,
							panelHeight:'auto',
							panelMaxHeight:100,
							required:datas[i].required  &&(!isFind),
							disabled:findCol							
						}; 
						
						field.combobox(options);
						editor.type='combobox';
						editor.options=options;
						makeEditor(editor,wField,isFind);		
					}
					else if(ety==5||ety==21||ety==12){
						
						var sql=datas[i].linklist;
						var idf="id";
						if(ety==21)idf="text";
						field.attr("field",wField);
						field.attr("sql",sql);
						field.attr("ety",ety);
						options={  
							url:tThis.NavUrl,  
							valueField:idf,  
							textField:'text',
							field:wField,
							panelHeight:'auto',
							panelMaxHeight:100,
							required:(!isFind)&&datas[i].required,
							disabled:ety==12,
							multiple:ety==21,
							separator:ety==21?'':',',
							onBeforeLoad:function(param){
								param.flt="";
								var flt=$(this).attr('flt');

								if(flt)
									param.flt=flt;
								else if(ToInt($(this).attr('ety'))==12){
									param.flt="0>1";
								}
								param.param = 'combo';
								param.code = tThis.Code;
								param.sql =$(this).attr('sql').replaceAll('@id@',tThis.parentVal);						
							},
							loadFilter: function(data){
								var wety=$(this).attr('ety');
								if(wety==21){
								}
								else{
									if(isFind){
										data.splice(0,0,{"id":"","text":"全部"});
									}
									else{
										
										data.splice(0,0,{"id":"zm_null","text":"---------"});
									}
								}
								return data;
							},
							onLoadSuccess:function(data){
								if(!$(this).attr('editor')){
									$(this).attr('editor',1);
									var e={};
									e.type='combobox';
									var o=StrToJson($(this).attr('options'));
									o.data=$(this).combobox('getData');
									
									e.options=o;
									makeEditor(e,o.field,isFind);	
								}		
							}
						}; 
												
						field.combobox(options);
						delete options['onBeforeLoad'];
						delete options['onLoadSuccess'];
						delete options['url'];
						field.attr('options',JsonToStr(options));
						if(ety==12){
							Link(tThis.RealCode+'_fld_'+datas[i-1].fieldname.toLowerCase(),field.attr('id'));
							
						}
					}
					else if(ety==6){	
						var em=datas[i].editmask;
						if(em==""||em.indexOf("hh")<0){
							options={  
								required:(!isFind)&&datas[i].required ,
								disabled:findCol
							};
							field.datebox(options);
							editor.type='datebox';
							editor.options=options;
							makeEditor(editor,wField,isFind);	
						}else{
							options={  
								required:(!isFind)&&datas[i].required,
								showSeconds: em.indexOf("ss")>0  									
							};
							field.datetimebox(options);
							editor.type='datebox';
							editor.options=options;
							makeEditor(editor,wField,isFind);	
						}
					}
					else if(ety==7){
						options={on:1,off:0,disabled:findCol};
						editor.type='checkbox';
						editor.options=options;
						makeEditor(editor,wField,isFind);	
					}
					else if(ety==17){
						field.filebox({
							buttonText: '选择文件'
						})
					}
					else if(ety==16){	
						options={  
							required: (!isFind)&&datas[i].required ,  
							showSeconds: true ,
							disabled:findCol							
						};
						field.timespinner(options);	
						editor.type='timespinner';
						editor.options=options;
						makeEditor(editor,wField,isFind);	
					}
					else if(ety==13){
						//$('#'+fld).removeClass("input");
						var lst=datas[i].linklist;
						var min,max,precision,prefix,suffix,groupSeparator;
						if(lst!=""){
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
						};
						options={  
							min:min,  
							max:max,
							precision:precision,
							suffix:suffix,
							prefix:prefix,
							groupSeparator:groupSeparator,
							required: (!isFind)&&datas[i].required,
							disabled:findCol
						};  
						field.numberbox(options);
						editor.type='numberbox';
						editor.options=options;
						makeEditor(editor,wField,isFind);	
					}
					else if(ety==14){
						//field.xheditor({tools:'mini'});
					}
					else if(ety==19){
						var sql=datas[i].linklist;
						sql=sql.replaceAll('@id@',tThis.parentVal);
						options={  
							url: tThis.NavUrl+'?param=tree&sql='+escape(sql),
							panelHeight:'auto',
							panelMaxHeight:100,
							field:wField,
							required: (!isFind)&&datas[i].required,
							disabled:findCol,
							onLoadSuccess:isFind?void(0):function(node, data){
								if(!$(this).attr('editor')){
									$(this).attr('editor',1);
									var e={};
									e.type='combotree';
									var o=StrToJson($(this).attr('options'));
									o.data=data;
									e.options=o;
									makeEditor(e,o.field,isFind);	
								}						
							}
						};
						field.combotree(options);	
						delete options['onLoadSuccess'];
						delete options['url'];
						var tree=field.combotree('tree');
						tree.attr('options',JsonToStr(options));
					}
					else if(ety==25){         
						field.attr("field",wField);
						var sql=datas[i].linklist;
						sql=sql.replaceAll('@id@',tThis.parentVal);
						var vt=datas[i].validtype;
						options={    
							required: (!isFind)&&datas[i].required,
							//editable:true,
							url:tThis.NavUrl+'?param=tree&sql='+escape(sql),
							panelHeight:'auto',		
							panelMaxHeight:100,
							cascadeCheck:vt.indexOf('leaf')<0,
							onlyLeafCheck:vt.indexOf('leaf')==0,
							multiple:true,
							checkbox:true,
							disabled:findCol,
							onLoadSuccess:isFind?void(0):function(node, data){
								if(!$(this).attr('editor')){
									$(this).attr('editor',1);
									var e={};
									e.type='combotree';
									var o=StrToJson($(this).attr('options'));
									o.data=data;
									e.options=o;
									makeEditor(e,o.field,isFind);	
								}					
							}
						};
						field.combotree(options);	
						delete options['onLoadSuccess'];
						delete options['url'];
						var tree=field.combotree('tree');
						tree.attr('options',JsonToStr(options));
					}
					else if(ety==23){
						var gridCode=datas[i].linklist;
						var tFld=fld;
						var twField=wField;
						var tField=$('#'+tFld);
						if(isFind)tField=$("[FindId='"+tFld+"']");
						tField.attr("field",wField);
						get(tThis.NavUrl,{param:'column',path:tThis.Path,code:gridCode},'json',function(data){
							var columns=[];
							var Keys='id';
							var Names='';
							var tData=data.fields;
							for(var i=0;i<tData.length;i++){
								var f=tData[i].fieldname.toLowerCase();
								if(tData[i].keys)
									Keys=f;
								if(tData[i].visible){
									if(Names=='')
										Names=f;
									columns.push({field:f,
										title:tData[i].displayname,
										width:tData[i].displaywidth,
										sortable:tData[i].sorted
									})
								}
							};
							options={
								panelWidth:500,
								idField:Keys,
								textField:Names,
								url:tThis.NavUrl+'?param=data&path='+tThis.Path+'&code='+gridCode,
								method: 'get',
								field:twField,
								columns:[columns],
								fitColumns: true,
								required: (!isFind)&&datas[i].required,
								onLoadSuccess:isFind?void(0):function(data){
									if(!$(this).attr('editor')){
										$(this).attr('editor',1);
										var e={};
										e.type='combogrid';
										var o=StrToJson($(this).attr('options'));
										o.data=data;
										e.options=o;
										makeEditor(e,o.field,isFind);	
									}						
								}
								
							};
							tField.combogrid(options);
							delete options['onLoadSuccess'];
							delete options['url'];							
							tField.attr('options',JsonToStr(options));
						});
					}
					else if(ety==11){
						options={  
							//required: (!isFind)&&datas[i].required ,  
							prompt:'请选择...',
							searcher:function(value,name){ 	
								//try{var $this=$(this);eval(fev)}catch(e){Log(e)};
								var $this=$(this);
								var lst=$this.attr('list');
								var arr=lst.split(',');
								if(arr.length==8){
									selectGrid(arr[1],arr[2],arr[3],ToInt(arr[4]),ToInt(arr[5]),function(rows){
											$this.prev().val(rows[0][arr[6]]);
											$this.searchbox('setValue',rows[0][arr[7]]);
											if(tThis.Grid){
												//tThis.Grid.updateRow({arr[7]:rows[0][arr[7]]});
											}
										}
									);
								}
							}							
						};
						field.searchbox(options);
						field.attr('list',datas[i].linklist);
						editor.type='searchbox';
						editor.options=options;
						makeEditor(editor,wField,isFind);	
					}
					var ev=datas[i].description;
					if(ev){
						var json=JsonToString(datas[i]);
						var ws="var data="+json+";\n";
						ws+='var fld="'+fld+'";\n';
						ws+='var code="'+tThis.Code+'";\n';
						ws+='var realCode="'+tThis.RealCode+'";\n';
						ws+=ev;
						try{
							eval(ws);
						}catch(e){
							Log(e);
						}
					}
					
				}
			}
		},	
		beforeLoad:function(){
		},
		refreshFormItems:function (){
			var tThis=this;
			var datas=tThis.Datas;
			for(var i=0;i<datas.length;i++){
				var fld=tThis.RealCode+'_fld_'+datas[i].fieldname.toLowerCase();
				var field=$('#'+fld);
				if(field.length>0){					
					var ety=datas[i].edittype;
					/*if(ety==12){
						field.combobox("disable"); 
					}
					else */if(ety==5||ety==21){

						field.combobox("reload"); 
					}
					else if(ety==19||ety==25){
						
						field.combotree("reload");  
					}			
				}
			}
		}	,
		destroyFormItems:function (){
			var tThis=this;
			var datas=tThis.Datas;
			for(var i=0;i<datas.length;i++){
				var fld=tThis.RealCode+'_fld_'+datas[i].fieldname.toLowerCase();
				var field=$('#'+fld);
				if(field.length>0){					
					var ety=datas[i].edittype;
					if(ety==4||ety==5||ety==21){
						//field.combobox("destroy"); 
					}
					
					else if(ety==6){	
						//field.datebox("destroy");						
					}
					else if(ety==16){	
						//field.timespinner("destroy");  
					}
					else if(ety==13){

						//field.numberbox("destroy");  
					}
					
					else if(ety==19||ety==25){
						
						//field.combotree("destroy");  
					}					
					else if(ety==23){						
						//field.combogrid("destroy");
					}
				}
			}
		},
		setParentVal : function(val){				
			this.parentVal=val;			
			this.refreshFormItems();
		}	
	}
		
	$.fn.EasyForm = function( method ) {
		if( methods[method] ) {
			return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ) );
		} else if ( typeof method === 'object' || !method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'No '+method+' method' );
		}
	};
})( jQuery );

function changeFindState(obj,ety){
	var pid=$(obj).attr("id").replace("check_","");
	var disable="disable";
	if($(obj).attr("checked"))disable="enable";
	if(ety==19||ety==23||ety==25||ety==5||ety==21||ety==4||ety==12)
		$("[FindId='"+pid+"']").combobox(disable)
	else if(ety==6)
		$("[FindId='"+pid+"']").datebox(disable)
	else if(ety==16)
		$("[FindId='"+pid+"']").timespinner(disable)		
	else if(ety==13)
		$("[FindId='"+pid+"']").numberbox(disable);
	else{
		if(disable=="disable"){
			$("[FindId='"+pid+"']").attr("disabled","disabled");
		}
		else
			$("[FindId='"+pid+"']").removeAttr("disabled");
	}
		//$("[FindId='"+pid+"']").validatebox(disable);
}

/**
 * checkbox - jQuery EasyUI
 *	@author ____′↘夏悸
 */
(function ($) {
	
	var STYLE = {
		checkbox : {
			cursor : "pointer",
			background : "transparent url('data:image/gif;base64,R0lGODlhDwAmAKIAAPr6+v///+vr68rKyvT09Pj4+ICAgAAAACH5BAAAAAAALAAAAAAPACYAAANuGLrc/mvISWcYJOutBS5gKIIeUQBoqgLlua7tC3+yGtfojes1L/sv4MyEywUEyKQyCWk6n1BoZSq5cK6Z1mgrtNFkhtx3ZQizxqkyIHAmqtTsdkENgKdiZfv9w9bviXFxXm4KP2g/R0uKAlGNDAkAOw==') no-repeat center top",
			verticalAlign : "middle",
			height : "19px",
			width : "18px",
			display : "block"
		},
		span : {
			"float" : "left",
			display : "block",
			margin : "0px 4px",
			marginTop : "5px"
		},
		label : {
			marginTop : "6px",
			marginRight : "8px",
			display : "block",
			"float" : "left",
			//fontSize : "16px",
			cursor : "pointer"
		}
	};
	
	function rander(target) {
		var jqObj = $(target);
		jqObj.css('display', 'inline-block');
		var Checkboxs = jqObj.find('input[type=checkbox]');
		Checkboxs.each(function () {
			var jqCheckbox = $(this);
			var jqWrap = $('<span/>').css(STYLE.span);
			var jqLabel = $('<label/>').css(STYLE.label);
			var jqCheckboxA = $('<a/>').data('lable', jqLabel).css(STYLE.checkbox).text(' ');
			var labelText = jqCheckbox.data('lable', jqLabel).attr('label');
			jqCheckbox.hide();
			jqCheckbox.after(jqLabel.text(labelText));
			jqCheckbox.wrap(jqWrap);
			jqCheckbox.before(jqCheckboxA);
			if (jqCheckbox.prop('checked')) {
				jqCheckboxA.css('background-position', 'center bottom');
			}
			
			jqLabel.click(function () {
				(function (ck, cka) {
					ck.prop('checked', !ck.prop('checked'));
					ck.change();
					var y = 'top';
					if (ck.prop('checked')) {
						y = 'bottom';
					}
					cka.css('background-position', 'center ' + y);
				})(jqCheckbox, jqCheckboxA);
			});
			
			jqCheckboxA.click(function () {
				$(this).data('lable').click();
			});
		});
	}
	
	$.fn.checkbox = function (options, param) {
		if (typeof options == 'string') {
			return $.fn.checkbox.methods[options](this, param);
		}
		
		options = options || {};
		return this.each(function () {
			if (!$.data(this, 'checkbox')) {
				$.data(this, 'checkbox', {
					options : $.extend({}, $.fn.checkbox.defaults, options)
				});
				rander(this);
			} else {
				var opt = $.data(this, 'checkbox').options;
				$.data(this, 'checkbox', {
					options : $.extend({}, opt, options)
				});
			}
		});
	};
	
	function check(jq, val, check) {
		var ipt = jq.find('input[value=' + val + ']');
		if (ipt.length) {
			ipt.prop('checked', check).each(function () {
				$(this).data('lable').click();
			});
		}
	}
	
	$.fn.checkbox.methods = {
		getValue : function (jq) {
			var checked = jq.find('input:checked');
			var val = {};
			checked.each(function () {
				var kv = val[this.name];
				if (!kv) {
					val[this.name] = this.value;
					return;
				}
				
				if (!kv.sort) {
					val[this.name] = [kv];
				}
				val[this.name].push(this.value);
			});
			return val;
		},
		check : function (jq, vals) {
			if (vals && typeof vals != 'object') {
				check(jq, vals);
			} else if (vals.sort) {
				$.each(vals, function () {
					check(jq, this);
				});
			}
		},
		unCheck : function (jq, vals) {
			if (vals && typeof vals != 'object') {
				check(jq, vals, true);
			} else if (vals.sort) {
				$.each(vals, function () {
					check(jq, this, true);
				});
			}
		},
		checkAll : function (jq) {
			jq.find('input').prop('checked', false).each(function () {
				$(this).data('lable').click();
			});
		},
		unCheckAll : function (jq) {
			jq.find('input').prop('checked', true).each(function () {
				$(this).data('lable').click();
			});
		}
	};
	
	$.fn.checkbox.defaults = {
		style:STYLE
	};
	
	if ($.parser && $.parser.plugins) {
		$.parser.plugins.push('checkbox');
	}
})(jQuery);

/**
 * radio - jQuery EasyUI
 *	@author ____′↘夏悸
 */
(function ($) {
	var STYLE = {
		radio : {
			cursor : "pointer",
			background : "transparent url('data:image/gif;base64,R0lGODlhDwAmANUAAP////z8/Pj4+Ovr6/v7++7u7uPj493d3ff39/Ly8vT09ICAgPX19a+vr+Li4urq6vn5+fr6+v39/dXV1efn5+bm5uTk5ODg4N7e3v7+/vHx8fDw8O3t7e/v74eHh+Hh4c3NzdfX1+np6eXl5cDAwNra2t/f38/Pz/Pz8/b29sbGxsHBwc7OzsLCwujo6NHR0by8vL29vcXFxb+/v7m5udPT09jY2MPDw7u7u7i4uNLS0uzs7AAAAAAAAAAAAAAAACH5BAAAAAAALAAAAAAPACYAAAb/QIBwSCwaj0VGSIbLzUAXQfFDap1KjktJVysMHTHQ4WKgPAqaymQDYJBYh4/FNSgkGIjBgRC6YRwjIjsddwIRAQ4cKi8GFSIcGygphgEBBRYwB2ZoCggQBJUBCBg0FHV3nqChBAcrFYQMlKGVAgYnJpKyswEJDwYTqbuhAwoQEw+qwgoDEgAbNhzCAQoiUkIaGAYdCAQCCQMD1kMEBSMmBxbEzUjs7e7v8EJKTE5Q4kJUVlhaXF5CYGLIbEqzps2bOHNO4dHDxw+gAgIyREBAKdGiRgUMNPDQwICqS5nMQGiwoGSDDJVGlaqTwUPJBR4AVGLlihABkiZRBqh1S1IELY0cDUio1OtXKgkZAGQYWomYMWTSpjFzBk0aNXHYtHHzBu4eAHLm0KmLR5ZIEAA7') no-repeat center top",
			verticalAlign : "middle",
			height : "19px",
			width : "18px",
			display : "block"
		},
		span : {
			"float" : "left",
			display : "block",
			margin : "0px 4px",
			marginTop : "5px"
		},
		label : {
			marginTop : "6px",
			marginRight : "8px",
			display : "block",
			"float" : "left",
			//fontSize : "16px",
			cursor : "pointer"
		}
	};
	
	function rander(target) {
		var jqObj = $(target);
		jqObj.css('display', 'inline-block');
		var radios = jqObj.find('input[type=radio]');
		var checked;
		
		radios.each(function () {
			var jqRadio = $(this);
			var jqWrap = $('<span/>').css(STYLE.span);
			var jqLabel = $('<label/>').css(STYLE.label);
			var jqRadioA = $('<a/>').data('lable', jqLabel).addClass("RadioA").css(STYLE.radio).text(' ');
			var labelText = jqRadio.data('lable', jqLabel).attr('label');
			jqRadio.hide();
			jqRadio.after(jqLabel.text(labelText));
			jqRadio.wrap(jqWrap);
			jqRadio.before(jqRadioA);
			if (jqRadio.prop('checked')) {
				checked = jqRadioA;
			}
			
			jqLabel.click(function () {
				(function (rdo) {
					rdo.prop('checked', true);
					rdo.change();
					radios.each(function () {
						var rd = $(this);
						var y = 'top';
						if (rd.prop('checked')) {
							y = 'bottom';
						}
						rd.prev().css('background-position', 'center ' + y);
					});
				})(jqRadio);
			});
			
			jqRadioA.click(function () {
				$(this).data('lable').click();
			});
		});
		checked.css('background-position', 'center bottom');
	}
	
	$.fn.radio = function (options, param) {
		if (typeof options == 'string') {
			return $.fn.radio.methods[options](this, param);
		}
		
		options = options || {};
		return this.each(function () {
			if (!$.data(this, 'radio')) {
				$.data(this, 'radio', {
					options : $.extend({}, $.fn.radio.defaults, options)
				});
				rander(this);
			} else {
				var opt = $.data(this, 'radio').options;
				$.data(this, 'radio', {
					options : $.extend({}, opt, options)
				});
			}
		});
	};
	
	$.fn.radio.methods = {
		getValue : function (jq) {
			var checked = jq.find('input:checked');
			var val = {};
			if (checked.length)
				val[checked[0].name] = checked[0].value;
			
			return val;
		},
		check : function (jq, val) {
			if (val && typeof val != 'object') {
				var ipt = jq.find('input[value=' + val + ']');
				ipt.prop('checked', false).data('lable').click();
			}
		}
	};
	
	$.fn.radio.defaults = {
		style : STYLE
	};
	
	if ($.parser && $.parser.plugins) {
		$.parser.plugins.push('radio');
	}
	
})(jQuery);
