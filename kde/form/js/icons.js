
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
				PostContent(MISC_URL,{param:'clearicons'},'json',true,function(data){
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
	PostContent(MISC_URL,{param:'saveicons',icons:css},'json',true,function(data){
	})
}

function initIcons(inited){
	PostContent(MISC_URL,{param:'icons'},'json',true,function(d){
		var icons='';
		if(d){
			var data=d;
			var path='users/'+$('body').attr('developer');
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


function uploadFile() {
	$('#uploadIcons').uploadify({
		'auto'	   : true, 
		'swf'      : 'uploadify/uploadify.swf',
		'uploader' : '/code/files/uploadify.chi',		
		'buttonText': '',
		'buttonClass':'uploadBtn',
		'width':16,
		'height':18,
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

$(function(){

	initIcons(true);
	
	
});	