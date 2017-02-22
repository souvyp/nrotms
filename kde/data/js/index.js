
function SaveMsg(){
	var enc = new mxCodec(mxUtils.createXmlDocument());
	var node = enc.encode(editor.graph.getModel());
	var content = mxUtils.getPrettyXml(node);
	onlineContent(MISC_URL,{param:'saveMsg',id:'data',path:userpath+'/'+base,val:content},'json',function(data){
		alert('保存成功!');
	})
}


function LoadMsg()
{
	clearGraph()
	onlineContent(MISC_URL,{param:'loadMsg',path:userpath+'/'+base},'html',function(data){
		LoadXml(data)
	})
};

function clearGraph(){
	LoadXml(' ')
}

function LoadXml(data)
{
	var xml=data;
	if(xml.length<10)
		xml='<mxGraphModel><root><mxCell id="0"/><mxCell id="1" parent="0"/></root></mxGraphModel>';
	var xmlDocument = mxUtils.parseXml(xml);
	if(xmlDocument.documentElement != null && xmlDocument.documentElement.nodeName == 'mxGraphModel'){
		/*for(var i=0;i<operationImg.length;i++)
		{
			operationImg[i].destroy();
		}*/
		operationImg=[];
		
		var decoder = new mxCodec(xmlDocument);
		var node = xmlDocument.documentElement;	
		var graph = editor.graph;
		var model=graph.getModel();
		decoder.decode(node, model);	
		var parent = graph.getDefaultParent();	
		var childCount = model.getChildCount(parent);
		for (var i=0; i < childCount; i++)
		{
			var child = model.getChildAt(parent, i);
			if (mxUtils.isNode(child.value)){
				if(child.value.nodeName.toLowerCase()=='opimg'){
					var img=new mxImage(child.value.getAttribute('img'), 16, 16);					
					img.title=child.value.getAttribute('name');
					img.opimg=child.value;
					img.code=child.value.getAttribute('parentcode');
					img.v=child;
					operationImg.push(img);	
				}
			}
		}
		graph.refresh();
	}
};

function doPutIcon(obj){
	$('#oimg').attr('src',$(obj).attr("src"));
	
	$(":input[name='ocssIcon']").val($(obj).attr("css"));
	$('#win-Icons').window('close');
}

function doSearchIcon(){
	$('#win-Icons').window('open');		
}

function clearIcons(){
	$.messager.confirm('确认', '确实要清除所有图标吗?):', function(r){
				if (r){
				onlineContent(MISC_URL,{param:'clearicons'},'json',function(data){
					initIcons();
				})}
	})
}
function genIconCss(){
	var css='';
	$('#win-Icons img').each(function(){
		if(css!=="")css+='\n';
		var url=$(this).attr("src");
		css+='.'+$(this).attr("css")+'{\nbackground:url(\''+url+'\') no-repeat;background-size:16px 16px;\n}';
	})
	onlineContent(MISC_URL,{param:'saveicons',icons:css},'json',function(data){
	})
}

function initIcons(inited){
	onlineContent(MISC_URL,{param:'icons'},'json',function(d){
		var icons='';
		if(d){
			var data=d;
			var path=upath;
			for(var i=0;i<data.length;i++){
				var v=data[i].Path;
				if(v!=="icons.css"){
					var css=hex_md5(v);
					icons+='<img src="/'+path+'/common/icons/'+v+'" css="icon-'+css+'" onclick="doPutIcon(this)"/>';
				}
			}
		}
		icons+='<div id="uploadify-queue"></div>';
		$('#win-Icons').html(icons);	
		if(inited)
			uploadFile();
	})
}

$(function(){
	newGraph(document.getElementById('graphContainer'),
		document.getElementById('sidebarContainer'),
		document.getElementById('outlineContainer'),
		document.getElementById('toolbarContainer'));
	LoadMsg();
	
	pathInit();
	
	initIcons(true);
	
	
});	

function alert(text){
	$.messager.alert('提示',text);
}

function loadPaths(){
	onlineContent(MISC_URL,{param:'loadPath',path:userpath},'html',function(data){
		var arr=data.split(",");
		var addView=$('#dataPath').children("option:last-child").prev();
		for(var i=0;i<arr.length;i++){
			var str=arr[i].trim();
			if(str!=="")
				addView.before($('<option>', {
							text: str,
							value : str
						}));
		}
	});
}

function pathInit(){
	LoadMsg();
}
function clearData(){
	get(MISC_URL,{param:'clear',path:userpath+'/'+base},'json',function(data){
		alert("清除成功!");
	})
}

function HideButton(){
	var h=$('#HideButton').attr("hide");
	if(h=="1"){
		h='0';
		$('#HideButton').attr("hide",h);
	}
	else{
		h='1';
		$('#HideButton').attr("hide",h);
	}
	for(var i=0;i<operationImg.length;i++){
		operationImg[i].hide=h;
	}
	editor.graph.refresh();
}

function chooseFile(obj){								
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

function genSQL(){
	$.messager.prompt('自动生成SQL', '请输入数据库表名:', function(r){
		if (r){				
			onlineContent(MISC_URL,{param:'gensql',table:r,conn:$('[name="fConnection"]').val()},'html',function(data){
				if(!data||data.length<10){
					alert('自动生成失败!');
				}
				else{
					var i=data.indexOf('/****************INSERT*************************/');
					var s=data.substring(0,i);
					data=data.replace(s,'');
					$(":input[name='fSelectSQL']").val(s.replace('/****************SELECT*************************/','').trim());
					i=data.indexOf('/****************UPDATE*************************/');
					s=data.substring(0,i);
					data=data.replace(s,'');
					$(":input[name='fInsertSQL']").val(s.replace('/****************INSERT*************************/','').trim());
					i=data.indexOf('/****************DELETE*************************/');
					s=data.substring(0,i);
					data=data.replace(s,'');
					$(":input[name='fUpdateSQL']").val(s.replace('/****************UPDATE*************************/','').trim());
					$(":input[name='fDeleteSQL']").val(data.replace('/****************DELETE*************************/','').trim());
				}
			});
		}
	});
}

function propertyList(obj){
	var url='property'+$(obj).val()+'.json';
	get(url,null,"json",function(data){
		$('#property-Link').propertygrid('loadData',data);
	})
}


function uploadFile() {
	$('#uploadIcons').uploadify({
		'auto'	   : true, 
		'swf'      : 'uploadify/uploadify.swf',
		'uploader' : '/code/files/uploadify.chi',		
		'buttonText': '',
		'buttonClass':'uploadBtn',
		'width':16,
		'height':16,
		'method' : 'post',
		removeCompleted: true,
		'queueID':	'uploadify-queue',
		'onQueueComplete':function(){
			initIcons();
		},
		'onUploadStart':function(){
			
		}
	});
};