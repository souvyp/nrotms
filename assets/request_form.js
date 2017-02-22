function loadJS(url, success) {
	var domScript = document.createElement('script');
	domScript.src = url;
	success = success || function(){};
	//domScript.onload = domScript.onreadystatechange = function() {
	if(navigator.userAgent.indexOf("MSIE")>0){
	domScript.onreadystatechange = function(){
	  if('loaded' === this.readyState || 'complete' === this.readyState){
		success();
		this.onload = this.onreadystatechange = null;
		this.parentNode.removeChild(this);
	  }
	}
	}else{
	domScript.onload = function(){
	  success();
	  this.onload = this.onreadystatechange = null;
	  this.parentNode.removeChild(this);
	}
	}
	document.getElementsByTagName('head')[0].appendChild(domScript);
}


function loadJSS(urls, success) {
	var nurl = urls[0];
	loadJS(nurl,function(){
		urls.splice(0,1);
		if(urls.length>0){
			loadJSS(urls,success);
		}
		else if(success){
			success();
		}
	});
}

function loadCss( url ,media){ 
	var link = document.createElement( "link" ); 
	link.type = "text/css"; 
	link.rel = "stylesheet"; 
	if (media) link.media = media;
		//link.setAttribute("media", media);
	link.href = url; 
	document.getElementsByTagName( "head" )[0].appendChild( link ); 
}; 

loadCss('/assets/plugins/bootstrap/css/bootstrap.min.css');
loadCss('/assets/plugins/bootstrap/css/bootstrap-chinese-region.min.css');
loadCss('/assets/plugins/bootstrap/css/bootstrap-theme.min.css');
loadCss('/assets/plugins/bootstrap/css/bootstrap-select.min.css');
loadCss('/assets/plugins/uploadFile/uploadify.css');
loadCss('/assets/plugins/jstree/dist/themes/default/style.min.css');
loadCss('/assets/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css');
loadCss('/assets/plugins/bootstrap-markdown/css/bootstrap-markdown.min.css');
loadCss('/assets/plugins/plugins.css');
loadCss('/assets/plugins/timeline/css/styles.css');
loadCss('/assets/css/style.css','screen,print');
//loadCss('/assets/kindeditor/themes/default/default.css');
//loadCss('/assets/kindeditor/plugins/code/prettify.css');

loadJSS( ['/assets/js/jquery-1.11.1.min.js',
        '/assets/NSF/js/NSF.0.0.3.min.js',
		'/assets/js/common.js',
		'/assets/plugins/uploadFile/jquery.uploadify.js',
		'/assets/plugins/bootstrap/js/bootstrap.min.js',
		'/assets/plugins/bootstrap/js/bootstrap-chinese-region.min.js',
		'/assets/js/template.js',
		'/assets/plugins/store/store.js',
		'/assets/plugins/bootstrap/js/bootstrap-select.min.js',
		'/assets/plugins/jstree/dist/jstree.min.js',
		'/assets/plugins/laydate/laydate.js',
		'/assets/js/droparea.js',
		'/assets/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js',
		'/assets/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js',
		'/assets/plugins/bootstrap-markdown/js/bootstrap-markdown.js',
		//'/assets/kindeditor/kindeditor.js',
		//'/assets/kindeditor/lang/zh_CN.js',
		//'/assets/kindeditor/plugins/code/prettify.js',
		'/assets/Ueditor/ueditor.config.js',
		'/assets/Ueditor/ueditor.all.js',
		'/assets/Ueditor/lang/zh-cn/zh-cn.js',
		'/assets/js/form-calc-1.0.js',
		'/assets/js/verify-1.0.js',
		'/assets/js/table-form-data-1.0.js',
		'/assets/js/table-form-data-1.0-ndt.js',
		'/assets/js/form-combo-1.0.js',
		'/assets/js/form-inputbox-1.0.js',
		'/assets/js/form-date-1.0.js',
		'/assets/js/form-dialogue-1.0.js',
		'/assets/js/form-file-1.0.js',
		'/assets/js/form-image-1.0.js',
		'/assets/js/form-editor-2.0.js',
		'/assets/js/form-textarea-1.0.js',
		'/assets/js/form-normal-1.0.js',
		'/assets/js/form-print-1.0.js',
		'/assets/js/form-button-1.0.js',
		'/assets/js/table-form-action-1.0.js',
		'/assets/js/table-form-action-1.0-ndt.js',
		'/assets/js/table-form-1.0.1.js',
		'/assets/js/table-form-workflow-1.0.js',
		'/assets/js/drag.js',
		'/assets/plugins/jquery.PrintArea.js',
        "/js/login.js",
        "/js/login-ui.js",
        "/PMS/city/js/public.js"
		], function ()
{
			if(reqeustDone)
				reqeustDone();
		}
);