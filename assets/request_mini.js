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

loadCss('/assets/plugins/jstree/dist/themes/default/style.min.css');
		
loadJSS(['/assets/js/jquery-1.11.1.min.js',
		'/assets/js/common.js',
		'/assets/plugins/store/store.js',
		'/assets/plugins/jstree/dist/jstree.min.js'],function(){
			if(reqeustDone)
				reqeustDone();
		}
);

