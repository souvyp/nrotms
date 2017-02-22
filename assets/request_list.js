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

loadCSS('/assets/plugins/jpList-master/css/jplist.min.css');

loadCSS('http://cdn.bootcss.com/jqueryui/1.11.4/jquery-ui.min.css');
loadCSS('/assets/plugins/bootstrap/css/bootstrap.min.css');
loadCSS('/assets/css/style.css');

loadJSS( ['/assets/js/jquery-1.11.1.min.js',
        '/assets/NSF/js/NSF.0.0.3.min.js',
		'/assets/js/common.js',
		'/assets/js/template.js',
		'/assets/plugins/store/store.js',
		'http://cdn.bootcss.com/jqueryui/1.11.4/jquery-ui.min.js',
		'/assets/plugins/bootstrap/js/bootstrap.min.js',
		'/assets/plugins/jpList-master/js/jplist.min.js',	
		'/assets/js/data-list-1.0.js'],function(){
			if(reqeustDone)
				reqeustDone();
		});