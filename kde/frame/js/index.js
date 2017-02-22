var currNode;

var MISC_FILE='/code/files/misc.chi';
var MISC_URL='/code/data/misc.chi';
var MISC_ACCOUNT='/code/account/misc.chi';
var MINDMAP = 'mind.zmmp';
var ORGMAP = 'org.data';


function Wrap_data(pmis,_data){
	for(var i=_data.length-1;i>=0;i--){
		if(_data[i].status=="no"){
			_data.splice(i,1);
		}
		else{
			if(_data[i].children){				
				Wrap_data(pmis,_data[i].children);
			}
		}
	}
}

function makeTree(pmis){
	$('#treeFunction').tree({
		//url : MISC_URL+'?param=functions',
		url : MISC_FILE+'?param=file&path='+$('body').attr("path")+'/'+MINDMAP,
		method : 'get',
		animate : true,
		dnd : pmis ? false : true,
		formatter : function(node){
			var s = node.text;
			if (node.children){
				//s += '&nbsp;<span style=\'color:blue\'>(' + node.children.length + ')</span>';
				s = '<span style="font-weight:bold;">'+s+'</span>';
			}

			return s;
		},
		loadFilter: function(data,parent){
			var rdata=data.root.children;
			Wrap_data(pmis,rdata);
			return rdata;
		},
		onLoadError:function(e){
			
		},
		onLoadSuccess:function(e,data)
		{
			makeShortCut(data);
			
			currNode=$('#treeFunction').tree('getRoot');
		},
		onClick: function(o)
		{
			
			if(!o.children)
			{
				currNode=o;
				if(o.others&&o.others["12"])
				{
					var scriptCode=o.others["12"];
					eval(scriptCode);
				}
				else{
					showGrid($('body').attr('path')+'/'+o.id+'/base',o.id,o.text);
				}
			}
		},
		onContextMenu: function(e,node)
		{
			e.preventDefault();
			$(this).tree('select',node.target);
			if(!pmis){
				$('#mmTree').menu('show',
				{
					left: e.pageX,
					top: e.pageY
				});
			}
		}
	})
}

function loadStyleString(css,id) {
	if(css!==""){
		var nid='v_style_'+id;
		if(!document.getElementById(nid)){
			var style = document.createElement("style");
			style.id=nid;
			style.type = "text/css";
			try {
				style.appendChild(document.createTextNode(css));
			} catch (ex) {
				style.styleSheet.cssText = css;
			}
			var head = document.getElementsByTagName("head")[0];
			head.appendChild(style);
		}
	}
}

function removeStyle(id){
	var style=document.getElementById(id);
	if(style){
		var p;
		if(p=style.parentNode)
			p.removeChild(style);
	}
}

function alert(text){
	$.messager.alert('提示',text);
}

function collapse(obj){
	var t;
	if(obj){
		var t=$('#__tree__'+$(obj).attr('code'));
	}
	else{
		t=$('#treeFunction');		
	}
	var node = t.tree('getSelected');
	if(node)
		t.tree('collapse',node.target);
}
function expand(obj){
	var t;
	if(obj){
		var t=$('#__tree__'+$(obj).attr('code'));
	}
	else{
		t=$('#treeFunction');		
	}
	var node = t.tree('getSelected');
	if(node)
		t.tree('expand',node.target);
}

function makeShortCut(data){
	if($('#Menus').length>0){
		for(var i=0;i<data.length;i++){
			if(data[i].children){
				makeShortCut(data[i].children);
			}
			else if(data[i].photo){
				var m=$('<a href="javascript:;" tag="'+data[i].id+'">'+data[i].text+'</a>');
			
				$('#Menus').append(m);
				m.linkbutton({
					plain:true,
					iconCls:"mem-icon-treeFunction-"+data[i].id,
					onClick:function(){
						var node=$('#treeFunction').tree('find',$(this).attr("tag"));
						if(node)node.target.click();
					}
				});
			}	
		}
		makeTreePhoto(data,'treeFunction');
	}
	
	
}


function makeTreePhoto(data,treeId){
	var class_icons='';
	for(var i=0;i<data.length;i++){
		if(data[i].children){
			makeTreePhoto(data[i].children,treeId);
		}
		if(data[i].photo){
			if(class_icons!=="")class_icons+='\n';
			class_icons+=".mem-icon-"+treeId+'-'+data[i].id+"{background:url("+data[i].photo+");background-size:16px 16px;background-repeat:no-repeat;}";
			var node = $('#'+treeId).tree('find',data[i].id);	
			$('#'+treeId).tree('update', {
				target: node.target,
				iconCls: "mem-icon-"+treeId+'-'+data[i].id
			});
		}
	}
	loadStyleString(class_icons,treeId);
}

function fileClick(obj){
	var ie = !-[1,];  
	var file=$(obj).parent().prev();
	file.unbind('change');
	file.bind('change',function(){
		var ta=$(this).next().children();
		readImgFile($(this).get(0),function(data){
			ta.eq(0).val(data);
		})
		//ta.eq(0).val($(this).val());
	});
	if(ie){  	
		file.trigger('click').trigger('change');  
	}else{  
		file.trigger('click');  
	}   
}

function showContent(realCode,code,title,content,h){
	var wc=realCode;
	if(currNode)wc=currNode.id;

	if($('div[node="'+wc+'"]').length>0){
		var i=$('#ttTab').tabs('getTabIndex', $('div[node="'+wc+'"]'));
		$('#ttTab').tabs('select', i);
	}
	else{	
		var t=title;
		var cls='';
		if(!t&&currNode){
			t=currNode.text;
			cls=currNode.iconCls;
		}
		$('#ttTab').tabs('add',{
			title:t,
			iconCls:cls,
			cache:false,
			plain:true,
			style:{padding:'5px'},
			id:'__tab__'+realCode,
			content:content,
			closable: true
		});
		$('#__tab__'+realCode).attr("node",wc);
		
		if($('#treeFunction').length==1){
			var n=$('#treeFunction').tree('find',wc);
			if(n)$('#treeFunction').tree('select',n.target);
		}
		else{
			if($('#ttTab').tabs('tabs').length==1){
				$('#ttTab').tabs('hideHeader');
			}
			else
				$('#ttTab').tabs('showHeader');
		}
		if(h)h();
		
	}
}

function fullScreen() { 
	var el = document.documentElement; 
	var rfs = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullScreen; 

	if (typeof rfs != "undefined" && rfs) { 
		rfs.call(el); 
		} else if (typeof window.ActiveXObject != "undefined") { 
		// for Internet Explorer 
		var wscript = new ActiveXObject("WScript.Shell"); 
		if (wscript != null) { 
		wscript.SendKeys("{F11}"); 
	} 
	} 

} 

function destroyTab(gridid){
	//setTimeout(function(){
			if($('#'+gridid).attr('isTree'))
				$('#'+gridid).EasyTree("destroy");
			else if($('#'+gridid).attr('isGrid'))
				$('#'+gridid).EasyGrid("destroy");
			else if($('#'+gridid).attr('isList'))
				$('#'+gridid).EasyList("destroy");
				
		//},500);
}


$(function(){
	if(!$('body').attr('isInner')){
		parentWidth=Math.min($('#ttTab').width()/3-70,250);
		$('#ttTab').tabs({
			onBeforeClose:function(title,index){
				var currTab = $('#ttTab').tabs('getSelected');
				currTab.find("div[id^="+unipre+"]").each(function () {
					var gridid=$(this).attr('id');
					destroyTab(gridid);
				});	
				//currTab.hide();
				//return false;
			},
			onClose:function(){
				//alert('a');
				var tab = $('#ttTab').tabs('getSelected');
				if (tab){
					var index = $('#ttTab').tabs('getTabIndex', tab);
					if(index==1)
						$('#ttTab').tabs('select',0);
				}
			},
			onSelect:function(title,index){  
				var currTab = $('#ttTab').tabs('getSelected');
				var node = currTab.attr("node");
				if(node){
					var n=$('#treeFunction').tree('find',node);
					if(n)
						$('#treeFunction').tree('select',n.target);
				}
				else{
					$('#treeFunction').tree('select',null);
				}
			}
		});
		
		if(typeof JSON == 'undefined'){

		   $('head').append($("<script type='text/javascript' src='js/json2.js'>"));

		}
		
		makeTree();
	}
	else{
		var oid=getUrlParam('oid');
		var ocode=getUrlParam('ocode');
		if(!ocode)ocode=oid;
		var otext=getUrlParam('otext');
		showGrid($('body').attr('path')+'/'+oid+'/base',ocode,otext);
	}

});


function setTabTitle(index,title){
	if(title){
		if(title.indexOf('\\')==0)
			title=title.substring(1,title.length);
		var tab=$('#ttTab').tabs("getTab",index);
		$('#ttTab').tabs('update', {
			tab: tab,
			options: {
				title: title
			}
		});
	}
}


/*menu*/

$(function(){
             	
	$('#ttTab').tabs({
		onContextMenu:function(e, title,index){
			e.preventDefault();
			if(index>0){
				$('#rcmenu').menu('show', {
					left: e.pageX,
					top: e.pageY
				});
			}
		}
	});
    //关闭当前标签页
    $("#closecur").bind("click",function(){
        var tab = $('#ttTab').tabs('getSelected');
        var index = $('#ttTab').tabs('getTabIndex',tab);
		if(index>0)
			$('#ttTab').tabs('close',index);
    });
    //关闭所有标签页
    $("#closeall").bind("click",function(){
        var tablist = $('#ttTab').tabs('tabs');
        for(var i=tablist.length-1;i>0;i--){
            $('#ttTab').tabs('close',i);
        }
    });
    //关闭非当前标签页（先关闭右侧，再关闭左侧）
    $("#closeother").bind("click",function(){
        var tablist = $('#ttTab').tabs('tabs');
        var tab = $('#ttTab').tabs('getSelected');
        var index = $('#ttTab').tabs('getTabIndex',tab);
        for(var i=tablist.length-1;i>index;i--){
			if(i>0)
				$('#ttTab').tabs('close',i);
        }
        var num = index-1;
        for(var i=num;i>=0;i--){
			if(i>0)
				$('#ttTab').tabs('close',i);
        }
    });
    //关闭当前标签页右侧标签页
    $("#closeright").bind("click",function(){
        var tablist = $('#ttTab').tabs('tabs');
        var tab = $('#ttTab').tabs('getSelected');
        var index = $('#ttTab').tabs('getTabIndex',tab);
        for(var i=tablist.length-1;i>index;i--){
			if(i>0)
				$('#ttTab').tabs('close',i);
        }
    });
    //关闭当前标签页左侧标签页
    $("#closeleft").bind("click",function(){
        var tab = $('#ttTab').tabs('getSelected');
        var index = $('#ttTab').tabs('getTabIndex',tab);
        var num = index-1;
		for(var i=num;i>0;i--){
			$('#ttTab').tabs('close',i);
        }
    });
         
});

function OrganizeContent(nid,code,title){
	showUrl(code,title,'../organization/?code='+escape(nid));
}

function MindMap(nid,code,title){
	showUrl(code,title,'../mindmap/frame.chi?code='+escape(nid));
}

function MapContent(code,title){
	var cont='<div id="test" class="easyui-layout" data-options="fit:true">'+
                '<div data-options="region:\'east\',split:true,border:true" style="width:250px"><ul id="tree'+code+'"></ul></div>'+
                '<div data-options="region:\'center\',border:true"><ul class="easyui-datalist"><li value="AL">Alabama</li> <li value="AK">Alaska</li></ul></div>'+
            '</div>';
	showContent(code,code,title,cont);
	
	$('#tree'+code).tree({
		url: MISC_FILE+'?param=file&path='+$('body').attr("path")+'/'+ORGMAP,
		method: 'get',
		animate: true,
		dnd:false,
		loadFilter: function(data){
			return WrapData('',data);
		},
		onLoadSuccess:function(e,data)
		{
			makeTreePhoto(data,'tree'+code);
		}
	})
}