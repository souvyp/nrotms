String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {  
	if (!RegExp.prototype.isPrototypeOf(reallyDo)) {  
		return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);  
	} else {  
		return this.replace(reallyDo, replaceWith);  
	}  
}  


//mode: 1-代码管理员 2-内容管理员
function initAdmin(adminUser,mode){  
	if(mode==2){
		document.write('<script src="plugins/ckeditor/ckeditor.js"><\/script>');
		/*var dataModal='<div id="dataModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="dataModalLabel" aria-hidden="true">';
		dataModal+='<div class="modal-header">';
		dataModal+='<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>';
		dataModal+='<h3 id="dataModalLabel">数据</h3>';
		dataModal+='</div>';
		dataModal+='<div class="modal-body">';
		dataModal+='<iframe src="about:blank;" style="width:100%;height:100%;">';
		dataModal+='</iframe>';
		dataModal+='</div>';
		dataModal+='</div>';
		
		$('body').append(dataModal);
		
		$('#dataModal').on('shown', function () {
			var dataid=$(this).attr('data-id');
			if(dataid){
				$.ajax({
					 type: "get",
					 url: 'code/data.chi',
					 data: {param:'conf',dataid:dataid},
					 dataType: "json",
					 success: function(result){
						if(result.success)
							$('#dataModal').find('iframe').attr('src','/kde/frame/inner.chi?code=trend&oid='+result.path+'&ocode='+result.code+'&otext='+result.title);
					}
				 })
					
			}
		});
		
		$('#dataModal').on('hidden', function () {
			$('#dataModal').find('iframe').attr('src','about:blank');
		});*/
		
		$('[client-id]').each(function(){
			this.oraginHtml=this.outerHTML;
			//console.log(this.oraginHtml);
			this.setAttribute('mode',mode);
			$(this).attr('contenteditable',true);
			$(this).show();
		})
		
		loadStyleString('.cke_focus{box-shadow: 0 0 8px rgba(103, 166, 217, 1);}','cke_focus');
		initData(adminUser);
	}
	else if(mode==1){
		document.write('<link rel="stylesheet" href="plugins\/codemirror\/lib\/codemirror.css">');		
		document.write('<script src="plugins\/codemirror\/lib\/codemirror.js"><\/script>');
		document.write('<script src="plugins\/codemirror\/mode\/xml\/xml.js"><\/script>');
		document.write('<script src="plugins\/codemirror\/mode\/javascript\/javascript.js"><\/script>');
		document.write('<script src="plugins\/codemirror\/mode\/css\/css.js"><\/script>');
		document.write('<script src="plugins\/codemirror\/mode\/htmlmixed\/htmlmixed.js"><\/script>');
		$(function(){
			$('[server-id]').each(function(){
				var oldH=this.outerHTML;;
				var id='text_'+$(this).attr('server-id');
				$(this).html('<textarea id="'+id+'" style="width:100%;height:100%;min-height:30px;min-width:30px;border:1px solid #ddd;">'+$(this).html()+'</textarea><button onclick="saveCode(this)">保存</button>');
				var editor = CodeMirror.fromTextArea(document.getElementById(id), {
				  lineNumbers: true
				});
				var btn=$(this).find('button:eq(0)')[0];
				btn.editor=editor;
				btn.oldH=oldH;
			});
		});
		loadStyleString('.CodeMirror{border: 1px solid #ddd;}','text_focus');
	}
}

function saveCode(btn){
	var ohtml=btn.oldH;
	var nhtml=ohtml.replace($(ohtml).html(),btn.editor.getValue());
	var oldnhtml=nhtml;
	if(ohtml!==nhtml){
		var params={param:'save',path:window.location.pathname,ohtml:ohtml,nhtml:nhtml};
		var cont=JSON.stringify( params );
		 $.ajax({
			 type: "post",
			 url: 'code/template.chi',
			 data: params,
			 dataType: "json",
			 success: function(result){
				if( result&&result.success ){
					btn.oraginHtml=oldnhtml;
					alert('保存成功!');
				}else	
					alert('保存失败!');
			}
		 });
	}
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

function getUrlParam(name)
{
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg);  //匹配目标参数
	if (r!=null) return decodeURI(r[2]); return null; //返回参数值
} 

function initData(user){
	$('[server-id]').each(function(){
		var source=$(this).html();	
		var serverid=$(this).attr('server-id');
		var ev=$(this).attr('ev');
		if(source&&serverid){
			var that=this;			
			$.ajax({
				 type: "get",
				 url: '/code/cms/data.chi',
				 data: {param:"data",dataid:serverid,id:getUrlParam('id')},
				 dataType: "json",
				 success: function(result){
					if(result&&result.success){			
						source=source.replaceAll(' &lt; ',' < ');
						source=source.replaceAll(' &gt; ',' > ');
						var render = template.compile(source);
						var html = render(result);
						$(that).html(html);
						$(that).show();
						if(ev)eval(ev);
					}
				}
			})
			
		}
	})
}

