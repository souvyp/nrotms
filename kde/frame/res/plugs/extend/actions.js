
function uploadFile(button,fileObjName,w,text,queueFile,params,onStart,onComplete) {
	if(!w)w=60;
	$('#'+button).uploadify({
		'fileObjName':fileObjName,
		'auto'	   : true, 
		'swf'      : '../res/plugs/extend/uploadify/uploadify.swf',
		'uploader' : UPLOAD_URL,		
		'buttonText': text?text:'添加新文件',
		'buttonClass':'uploadBtn',
		'width':w,
		'height':24,
		'formData' : params,
		'method' : 'post',
		removeCompleted: true,
		'queueID':	queueFile?queueFile:'',
		'onQueueComplete':function(){
			if(onComplete)
				onComplete();
		},
		'onUploadStart':function(){
			if(onStart)
				onStart();
		}
	});
};

function addFiles($this,$grid,filename,w,param){
	var button=$this.attr('id');
	var tt=$grid.EasyGrid('getThis');
	var params;

	try{params=eval('('+tt.Default+')');}catch(e){params={}};
	if(!params)params={};

	if(tt.parentVal)
		params[tt.parentId]=tt.parentVal;
	params.isnew='true';
	params.__DataCode=tt.Code;
	params.Path=tt.Path;
	params.param='save';
	if(param){
		for(var key in param){
			params[key]=param[key];
		}
	}
	uploadFile(button,filename,w,$this.text(),'queueFile',params,function(){
			var params;
			try{params=eval('('+tt.Default+')');}catch(e){params={}};
			if(tt.parentVal)
				params[tt.parentId]=tt.parentVal;
			$('#'+button).uploadify('settings','formData',params);
			$('#win-file').dialog({
				title:'列表 - '+$this.text(),
				width:300,
				height:'auto',
				modal:true
			});
		},function(){
			tt.refresh();
			$('#win-file').dialog('close');
		}
	);	
}
