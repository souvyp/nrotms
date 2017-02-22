var username;
var appcode;
var appname;

var inited;

var MISC_URL='/code/files/misc.chi';
var MISC_ACCOUNT='/code/account/misc.chi';

function editorFile(file){
	return file.match(/\.(php|asp|aspx|html|htm|cn|bn|pn|chi|txt|log|js|jsm|css|conf|json|xml|zlay|zmmp|zfrm|zwfl|cfg)$/i)!==null
}

function matchExt(file,ext){
	return file.indexOf('.'+ext)>0;
}

function showOption(){
	$('#optionsPanel').dialog('open');
}

function makeTree(){

	var url = MISC_URL+'?param=files';  
	$('#treeFiles').tree({
		url: url+'&path='+appcode,
		method: 'get',
		animate: true,
		checkbox:true,
		cascadeCheck:false,
		onlyLeafCheck:false,
		dnd:true,
		formatter:function(node){
			var s = node.text;
			if(node.folder){
				s = '<span style="font-weight:bold;">'+s+'</span>';
			}
			return s;
		},
		onLoadSuccess:function(e,data){
			if(!inited){
				inited=true;
				var root=$(this).tree('getRoot');
				$(root.target).find('.tree-checkbox').remove();
			}
		},
		onLoadError:function(e){
			
		},
		loadFilter: function(data){
			for(var i=0;i<data.length;i++){
				data[i].id=unescape(data[i].id);
				data[i].text=unescape(data[i].text);
				data[i].system=data[i].id.indexOf('data.conf')>=0;
			}
			if(!inited){
				return [{id:appcode,text:appname,folder:true,checkbox:false,children:data}];
			}
			else
				return data;
		},
		onBeforeDrop : function (target, source, point){
			
			if (!source.system && point === 'append'){
				var targetNode = $(this).tree('getNode', target);
				$(this).tree('expand', target);
				if (!targetNode.folder){
					return false;
				}else{
					var tThis= $(this);
					var parentNode=$('#treeFiles').tree('getParent',source.target);
					onlineContent(MISC_URL,{param:'move',from:source.id,folder:source.folder?1:0,to:targetNode.id},'html',function(html){
						var data=eval('('+html+')');
						if(data.error){
							alert(unescape(data.error));
						}
						else{
							
							var p=tThis.tree('pop',source.target);
							closeTab(p.id);
							p.id=unescape(data.path);
							tThis.tree('append',{parent: target,data:p});
							$(parentNode.target).find('.tree-file').removeClass('tree-file').addClass('tree-folder');
						}
					})
					return false;
				}
			}
			else return false;
		},
		onBeforeExpand:function(node){
			$("#treeFiles").tree("options").url = url+'&path='+node.id;                    
		},
		onContextMenu: function(e,node){
			e.preventDefault();
			$(this).tree('select',node.target);
			$('#mmTree').menu('show',{
				left: e.pageX,
				top: e.pageY
			});
        },
		onClick:treeClick
	})
}

function closeTab(tid){
	var tab=$('#ttTab').tabs('getTab', tid);
	if(tab&&tab.closable)
		$('#ttTab').tabs('close', tid);
}

function collapse(){
	var node = $('#treeFiles').tree('getSelected');
	$('#treeFiles').tree('collapse',node.target);
}
function expand(){
	var node = $('#treeFiles').tree('getSelected');
	$('#treeFiles').tree('expand',node.target);
}

function treeClick(node){
	if(node){
		if(!node.id){
			$('#ttTab').tabs('select', 1);
			makeFileList(node);
		}
		else if(node.folder){
			makeFileList(node);
		}
		else {
			var nid=node.id;
			/*if(matchExt(nid,'zlay')){
				var url='../layoutit/frame.chi?code='+escape(nid);
				addTab(nid,nid,'<div class="frame" style="height:'+($(window).height()-106)+'px;"><iframe src="'+url+'"></iframe></div>');
			}
			else if(matchExt(nid,'zmmp')){
				var url='../mindmap/frame.chi?code='+escape(nid);
				addTab(nid,nid,'<div class="frame" style="height:'+($(window).height()-106)+'px;"><iframe src="'+url+'"></iframe></div>');
			}
			else if(matchExt(nid,'zfrm')){
				var url='../form/frame.chi?code='+escape(nid);
				addTab(nid,nid,'<div class="frame" style="height:'+($(window).height()-106)+'px;"><iframe src="'+url+'"></iframe></div>');
			}
			else if(matchExt(nid,'zwfl')){
				var url='../workflow/frame.chi?code='+escape(nid);
				addTab(nid,nid,'<div class="frame" style="height:'+($(window).height()-106)+'px;"><iframe src="'+url+'"></iframe></div>');
			}
			else */
			if(editorFile(nid)){
				if(matchExt(nid,'cn')||matchExt(nid,'bn')||matchExt(nid,'pn'))
					$('#btnCompiler').show();
				else	
					$('#btnCompiler').hide();
				addTab(nid,nid,'<div fake="1"></div>',function(){
					if(window.onresize)window.onresize();
					makeFileInfo(node);
				})
			}else{
				makeFileList($('#treeFiles').tree('getParent',node.target));
			}
		}
		var nid=node.id;
		var n=$('#treeFiles').tree('find',nid);
		if(n){
			$('#treeFiles').tree('select',n.target);
		}
	}
}

function makeFileInfo(node){
	var div='<div class="fileTitle"><a href="/users/'+username+'/'+node.id+'" target="_blank">'+node.text+'</a></div>';
	div+='<p>Modified Date:'+DateFormat(node.LastWriteTime,'yy/mm/dd')+'</p>';
	div+='<p>File Size:'+renderSize(node.Size)+'</p>';
	$('#preview').html(div);
}

function uploadFile(button,fileObjName,w,text,queueFile,params,onStart,onComplete,onSuccess) {
	if(!w)w=60;
	$('#'+button).uploadify({
		'fileObjName':fileObjName,
		'auto'	   : true, 
		'swf'      : 'res/uploadify/uploadify.swf',
		'uploader' : MISC_URL,		
		'buttonText': text,
		'buttonClass':'uploadBtn',
		'width':w,
		'height':16,
		'formData' : params,
		'method' : 'post',
		removeCompleted: true,
		'queueID':	queueFile?queueFile:'',
		'onQueueComplete':function(){
			if(onComplete)
				onComplete();
		},
		'onDialogOpen':function(){

		},
		'onUploadStart':function(){
			if(onStart)
				onStart();
		},
		'onUploadSuccess': function(file,data,respone){
			if(onSuccess)onSuccess(file,data);
                   
        }
	});
};

function alert(msg){
	$.messager.alert('信息',msg);
}

$(function(){
	//init();

	setTimeout(function(){
		uploadFile('uploadFiles','filename',16,'','queueFile',{param:'import',folder:''},function(){
			var params={};
			var node = $('#treeFiles').tree('getSelected');
			var path='';
			if(node){
				path=node.id;
			}
			params.folder=path;
			var node = $('#treeFiles').tree('getSelected');
			if(node)
				$('#treeFiles').tree('expand',node.target);
			
			$('#uploadFiles').uploadify('settings','formData',params);
			$('#win-file').dialog({
				title:'上传文件',
				width:300,
				height:'auto',
				modal:true
			});
		},function(){
			$('#win-file').dialog('close');
		
			/*setTimeout(function(){
				var node = $('#treeFiles').tree('getSelected');
				if(node)
				$('#treeFiles').tree('expand',node.target);
			},500)*/

		},function(file,data){
			var node = $('#treeFiles').tree('getSelected');
			var path='';
			if(node)
				path=node.id;
			if(data=="1"){
				if(node&&node.folder){
					var d={}
					d.id=path+'\\'+file.name;
					d.text=file.name;
					d.CreationTime=file.creationdate;
					d.LastWriteTime=file.modificationdate;
					d.Size=file.size;
					$('#treeFiles').tree('append', {
						parent: (node?node.target:null),
						data: [d]
					});
				}
			}
			else
				alert('File('+path+file.name+') is exist!');
		});
	},500);

	$('#fileBrowser').delegate('li','click',function(){
		var nid=$(this).attr("nid");
		var n=$('#treeFiles').tree('find',nid);
		if(n){
			$('#treeFiles').tree('select',n.target);
			treeClick(n);
		}
	})
})


/*****************************tab**********************************/

function addTab(code,title,content,h){
	if(title.indexOf('\\')==0)
		title=title.substring(1,title.length);
	var tab=$('#ttTab').tabs('getTab', title);
	if(tab){
		var i=$('#ttTab').tabs('getTabIndex', tab);
		$('#ttTab').tabs('select', i);
	}
	else{
		$('#ttTab').tabs('add',{
			title:title,
			cache:false,
			plain:true,
			style:{padding:'5px'},
			id:code,
			content:content,
			closable: true
		});
	}
	if(h)h();
}

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

function makeFileList(node){
	try{
		var children=$('#treeFiles').tree('getChildren',node.target);
	}catch(e){
		$('#treeFiles').tree('expand',node.target);
		return;
	}
	if(node.state=="open"||children.length>0){
		var nid=node.id;
		$('#ttTab').tabs('select', 1);
		$('#fileBrowser').attr("nid",node.id);
		setTabTitle(1,nid?nid:appname);
		var ul='<ul>';
		
		for(var i=0;i<children.length;i++){
			var child=children[i];
			var parent=$('#treeFiles').tree('getParent',child.target);

			if(parent.id==nid){
				var cls=child.folder?' class="folder"':'';
				ul+='<li'+cls+' nid="'+child.id+'">';
				if (child.folder||editorFile(child.id))
					ul+='<div class="fileTitle"><a href="#">'+child.text+'</a></div>';
				else 
					ul+='<div class="fileTitle"><a href="/users/'+username+'/'+child.id+'" target="_blank">'+child.text+'</a></div>';
				ul+='<p>Modified Date:'+DateFormat(child.LastWriteTime,'yy/mm/dd')+'</p>';
				if(!child.folder)
					ul+='<p>File Size:'+renderSize(child.Size)+'</p>';
				else
					ul+='<p>Folder</p>';
				ul+='</li>';
			}
		}
		ul+='</ul>';
		$('#fileBrowser').html(ul);
	}
}
/*****************************user**********************************/

function submitLoginForm(){
	mask();
	$('#FormLogin').form('submit', {
		url: MISC_ACCOUNT,
		onSubmit: function(){
			var isValid = $(this).form('validate');
			if (!isValid){
				unmask();	
			}
			return isValid;	
		},
		success: function(data){
			unmask();
			
			var d=StrToJson(data);
			if(d.success){					
				$('#win-Login').dialog('close');
				
				username=d.name;
				$('#user').text(d.name);
			}
			else
				alert(d.error);
		},
		complete: function(XMLHttpRequest, textStatus){
			unmask();	
		},
		error: function(){
			unmask();	
		}
	})
	
}
function clearLoginForm(){
	$('#FormLogin').form('clear');
}
	
function UserLogout(){
	mask();
	get(MISC_ACCOUNT,{cmd:"logout"},'html',function(){
		unmask();
		window.location.href="/";
	})
}
	
function init(){
	inited=false;
	if(username){
		$('#user').text(username);
		if(appname){
			$('#file-list').panel('setTitle',appname);
			setTabTitle(1,appname);
			makeTree();
		}
	}
	else{
		$('#win-Login').dialog('open');
	}
}


/************************file***********************************/
function addit(){
	var node = $('#treeFiles').tree('getSelected');
	if(!node||(node&&node.folder)){
			$.messager.prompt('信息', '请输入文件名称:', function(r){
				if (r){
					var path='';
					if(node)path=node.id;
					onlineContent(MISC_URL,{param:'addFile',file:path+'\\'+r,name:r},'html',function(html){
						var d=eval('('+html+')');
						if(d.error)
							alert(unescape(d.error));
						else{
							d.id=unescape(d.id);
							d.text=unescape(d.text);
							$('#treeFiles').tree('expand',node?node.target:null);
							$('#treeFiles').tree('append', {
								parent: (node?node.target:null),
								data: [d]
							});
						}
					})
				}
			});
	}
}

function addfolder(){
	var node = $('#treeFiles').tree('getSelected');
	if(!node||(node&&node.folder)){
		$.messager.prompt('信息', '请输入文件夹名称:', function(r){
			if (r){
				var path='';
				if(node)path=node.id;
				onlineContent(MISC_URL,{param:'addFolder',folder:path+'\\'+r,name:r},'html',function(html){
					var d=eval('('+html+')');
					if(d.error)
						alert(unescape(d.error));
					else{
						d.id=unescape(d.id);
						d.text=unescape(d.text);
						$('#treeFiles').tree('append', {
							parent: (node?node.target:null),
							data: [d]
						});
					}
				})
			}
		});
	}
}

function deleteNode(node){
	if(!node.system)
		onlineContent(MISC_URL,{param:'delete',name:node.id,folder:node.folder},'html',function(data){
			$('#treeFiles').tree('remove', node.target);
			if(!node.folder){
				var title=node.id;
				if(title.indexOf('\\')==0)
					title=title.substring(1,title.length);
				var tab=$('#ttTab').tabs('getTab', title);
				if(tab){
					var i=$('#ttTab').tabs('getTabIndex', tab);
					$('#ttTab').tabs('close', i);
				}
			}
		});		

}
	
function removeit(all){
	if(all){
		var nodes = $('#treeFiles').tree('getChecked');
		var s = '';
		if(nodes.length>0){
			$.messager.confirm('确认','确实要删除所选 '+nodes.length+' 个文件吗?',function(r){
					if (r){
						for(var i=0; i<nodes.length; i++){
							var node=nodes[i];
							deleteNode(node);
						}
					}
				});
		}
	}
	else{
		var node = $('#treeFiles').tree('getSelected');
		if(node){
			if(node.id!==appcode)
				$.messager.confirm('确认','确实要删除文件 ('+node.text+') 吗?',function(r){
					if (r){
						deleteNode(node);	
					}
				});
		}
	}
	
}

function renameIt(){
	var node = $('#treeFiles').tree('getSelected');
	if(node){
		if(node.id!==appcode&&!node.system)
			$.messager.prompt('重命名', '请输入新名称:', function(r){
				if (r){
					var nnode=node;
					onlineContent(MISC_URL,{param:'rename',oldF:node.id,newF:r},'html',function(html){
						var d=eval('('+html+')');
						if(d.error){
							alert(unescape(d.error));
						}
						else{
							var path='';
							closeTab(nnode.id);
							if(nnode){
								path=nnode.id;
								var i=path.lastIndexOf('\\');
								if(i>0)
									path=path.substring(0,i);
							}
							nnode.text=r;
							nnode.id=path+'\\'+r;
							$('#treeFiles').tree('update', {
								target: nnode.target,
								id:nnode.id,
								text:nnode.text
							});

						}
					})
				}
			})
	}
}

/***************************************user********************************************/
function InitPage(mode,user,code,name){
	username=user;
	appcode=code;
	appname=unescape(name);
	init();
}

/***************************************preview*****************************************/
function showPreview(){
	if($('#preview').isVisible()){
		$('#preview').hide();
	}
	else{
		$('#preview').show();
	}
}

/*********************************************project***********************************/
function showProject(){
	$('#win-Project').dialog('open');
}

function submitProjectForm(){
	var pcode=$('#FormProject input[name="projectCode"]').val();
	var pname=$('#FormProject input[name="projectName"]').val();
	var pconn=$('#FormProject input[name="dataConnection"]').val();
	var ppath=$('#FormProject input[name="dataPath"]').val();
	var pdesc=$('#FormProject [name="projectDesc"]').val();
	var cont='{"code":"'+pcode+'","name":"'+escape(pname)+'","conn":"'+escape(pconn)+'","path":"'+escape(ppath)+'","desc":"'+escape(pdesc)+'"}';
	mask();
	onlineContent(MISC_URL,{param:'addFolder',folder:pcode,fileName:'data.conf',cont:cont},'json',function(data){
		unmask();
		if(!data.error){
			appcode=pcode;
			appname=unescape(pname);
			$('#win-Project').dialog('close');
			init();
		}
		else{
			alert(unescape(data.error));
		}
	});		
}

function openProj(nid){
	var pcode=unescape(nid).replace('\\','');
	$('#win-Open').dialog('close');	
	mask();
	onlineContent(MISC_URL,{param:'file',path:pcode+'\\data.conf'},'json',function(data){
		unmask();
		closeProject();
		appcode=pcode;
		appname=unescape(data.name);
		
		init();
	});		

}

function openProject(){

	onlineContent(MISC_URL,{param:'files'},'json',function(data){
		var html='';
		for(var i=0;i<data.length;i++){
			if(data[i].folder)
				html+='<li><a href="#" onclick="openProj(\''+escape(data[i].id)+'\')" >'+unescape(data[i].text)+'</a></li>';
		}
		$('#win-Open ul.files').html(html);
		$('#win-Open').dialog('open');
	});		

}

function getLayoutHtml(){
	var html='<!DOCTYPE html><html><head><link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.2/css/bootstrap.min.css">'+
			'<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">'+
			'<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>'+
			'<script src="http://cdn.bootcss.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>'+
			'<link href="//libs.baidu.com/fontawesome/4.0.3/css/font-awesome.min.css" rel="stylesheet">'+
			'<link rel="stylesheet" href="assets/css/base.css">'+
			'</head><body>';
	html+=$("#downloadModal textarea").val();
	html+='</body></html>';
	return html;
}

function previewProject(){	
	if(appcode){
		var url='';
		var node = $('#treeFiles').tree('getSelected');
		if(matchExt(node.id,'zfrm'))
			url='../form/preview/form.chi?code='+escape(node.id);
		else if(matchExt(node.id,'zlay')){
			/*var myWindow=window.open() ;
			downloadLayoutSrc();
			myWindow.document.write(getLayoutHtml()); 
			myWindow.focus();*/
		}
		else
			url='/users/'+username+'/'+appcode;
		if(url!=='')
			window.open(url) ;
	}
}

function deleteProject(){
	if(appcode)
		$.messager.confirm('确认','确实要删除项目 '+appname+' 吗?',function(r){
			if (r){
				onlineContent(MISC_URL,{param:'delete',name:appcode,folder:true},'json',function(data){
					closeProject();
				})
			}
		});
}

function closeProject(){
	if(appcode){
		$('#treeFiles').tree('loadData',[]);
		var tablist = $('#ttTab').tabs('tabs');
        for(var i=tablist.length-1;i>=2;i--){
            $('#ttTab').tabs('close',i);
        }
		$('#fileBrowser').html('');
	}
}

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
		if(index>1)
			$('#ttTab').tabs('close',index);
    });
    //关闭所有标签页
    $("#closeall").bind("click",function(){
        var tablist = $('#ttTab').tabs('tabs');
        for(var i=tablist.length-1;i>1;i--){
            $('#ttTab').tabs('close',i);
        }
    });
    //关闭非当前标签页（先关闭右侧，再关闭左侧）
    $("#closeother").bind("click",function(){
        var tablist = $('#ttTab').tabs('tabs');
        var tab = $('#ttTab').tabs('getSelected');
        var index = $('#ttTab').tabs('getTabIndex',tab);
        for(var i=tablist.length-1;i>index;i--){
			if(i>1)
				$('#ttTab').tabs('close',i);
        }
        var num = index-1;
        for(var i=num;i>=0;i--){
			if(i>1)
				$('#ttTab').tabs('close',i);
        }
    });
    //关闭当前标签页右侧标签页
    $("#closeright").bind("click",function(){
        var tablist = $('#ttTab').tabs('tabs');
        var tab = $('#ttTab').tabs('getSelected');
        var index = $('#ttTab').tabs('getTabIndex',tab);
        for(var i=tablist.length-1;i>index;i--){
			if(i>1)
				$('#ttTab').tabs('close',i);
        }
    });
    //关闭当前标签页左侧标签页
    $("#closeleft").bind("click",function(){
        var tab = $('#ttTab').tabs('getSelected');
        var index = $('#ttTab').tabs('getTabIndex',tab);
        var num = index-1;
		for(var i=num;i>1;i--){
			$('#ttTab').tabs('close',i);
        }
    });
         
});

/*****************************************URL********************************************/

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
		var n=$('#treeFunction').tree('find',wc);
		if(n)$('#treeFunction').tree('select',n.target);
		if(h)h();
	}
}

function showUrl(url){
	//newWin =window.open(url+'?file=aaaa','newWin','height='+$(window).height()+',width='+$(window).width()+',top=0,left=0,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no')
	$('#editorDiv').hide();
	var tab = $('#ttTab').tabs('getSelected');
	var html='<div fake="1" style="min-height:800px;height:'+$(window).height()+'px;"><iframe src="'+url+'" width="100%" height="100%" style="border:0px;"></iframe></div>';
	tab.html(html);
	//currNode=null;
	//showContent(code,code,title,'<div class="easyui-panel" data-options="fit:true,border:true"><iframe src="'+url+'" width="100%" height="100%" style="border:0px;"></iframe></div>');
}