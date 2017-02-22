/***************************************initInputFile*******************************/

function initInputFile(that,_option,_handle){
	var fileInput=$('#'+_option.code+'_upload');
	var uid=uuid();
	var _that=$(that).parent();
	fileInput.uploadify({
		'buttonText': '选择文件',
		'swf'      : '/assets/plugins/uploadFile/uploadify.swf',
		'uploader' : '/code/files/uploadify.chi',
		/*'onQueueComplete' : function(file){
			console.log(file);
		},*/
		'formData'     : {
			'param' : '_file',
			'token'     : uid
		},
		'onUploadComplete' : function(file) {
			var queueList=_that.find('.queue_list');
			queueList[0].isDirty = true;
			var aFile = $('<a href="/uploads/'+uid+'-'+file.name+'" target="_blank">'+file.name+'</a>');
			queueList.append(aFile);
			file.uid=uid;
			aFile[0]._file=file;
		}
	});
	
	if(_handle)_handle(true);
}
