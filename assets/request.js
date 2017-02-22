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

function loadCSS( url ){ 
	var link = document.createElement( "link" ); 
	link.type = "text/css"; 
	link.rel = "stylesheet"; 
	link.href = url; 
	document.getElementsByTagName( "head" )[0].appendChild( link ); 
}; 

loadCSS('http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css');
loadCSS('/assets/plugins/jpList-master/css/vendor/normalize.css');
loadCSS('/assets/plugins/jpList-master/css/styles.min.css');
loadCSS('/assets/plugins/jpList-master/css/jplist-pages.min.css');
loadCSS('/assets/plugins/jpList-master/css/jplist-core.min.css');
loadCSS('/assets/plugins/jpList-master/css/jplist-textbox-control.min.css');
loadCSS('/assets/plugins/jpList-master/css/jplist-pagination-bundle.min.css');
loadCSS('/assets/plugins/jpList-master/css/jplist-history-bundle.min.css');
loadCSS('/assets/plugins/jpList-master/css/jplist-filter-toggle-bundle.min.css');
loadCSS('/assets/plugins/jpList-master/css/jplist-views-control.min.css');
loadCSS('/assets/plugins/jpList-master/css/jplist-preloader-control.min.css');
loadCSS('http://cdn.bootcss.com/jqueryui/1.11.4/jquery-ui.min.css');

loadCSS('/assets/plugins/bootstrap/css/bootstrap.min.css');
loadCSS('/assets/plugins/bootstrap/css/bootstrap-theme.min.css');
loadCSS('/assets/plugins/bootstrap/css/bootstrap-select.min.css');
loadCSS('/assets/plugins/uploadFile/uploadify.css');
loadCSS('/assets/plugins/jstree/dist/themes/default/style.min.css');
loadCSS('/assets/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css');
loadCSS('/assets/plugins/bootstrap-markdown/css/bootstrap-markdown.min.css');
loadCSS('/assets/plugins/plugins.css');
loadCSS('/assets/plugins/timeline/css/styles.css');
loadCSS('/assets/css/style.css','screen,print');

			
loadJSS(['/assets/js/jquery-1.11.1.min.js',
		'/assets/js/common.js',
		'/assets/js/template.js',
		'/assets/plugins/store/store.js',
		'http://cdn.bootcss.com/jqueryui/1.11.4/jquery-ui.min.js',
		'/assets/plugins/bootstrap/js/bootstrap.min.js',
		'/assets/plugins/jpList-master/js/jplist.min.js',
		'/assets/js/data-list-1.0.js',		
		'/assets/plugins/uploadFile/jquery.uploadify.js',
		'/assets/plugins/bootstrap/js/bootstrap.min.js',
		'/assets/plugins/bootstrap/js/bootstrap-select.min.js',
		'/assets/plugins/jstree/dist/jstree.min.js',
		'/assets/plugins/laydate/laydate.js',
		'/assets/js/droparea.js',
		'/assets/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js',
		'/assets/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js',
		'/assets/plugins/bootstrap-markdown/js/bootstrap-markdown.js',
		'/assets/js/form-calc-1.0.js',
		'/assets/js/verify-1.0.js',
		'/assets/js/table-form-data-1.0.js',
		'/assets/js/form-combo-1.0.js',
		'/assets/js/form-inputbox-1.0.js',
		'/assets/js/form-date-1.0.js',
		'/assets/js/form-dialogue-1.0.js',
		'/assets/js/form-file-1.0.js',
		'/assets/js/form-image-1.0.js',
		'/assets/js/form-textarea-1.0.js',
		'/assets/js/form-normal-1.0.js',
		'/assets/js/form-print-1.0.js',
		'/assets/js/form-button-1.0.js',
		'/assets/js/table-form-action-1.0.js',
		'/assets/js/table-form-1.0.1.js',
		'/assets/js/table-form-workflow-1.0.js',
		'/assets/plugins/jquery.PrintArea.js'],function(){
			if(reqeustDone)
				reqeustDone();
		}
);


