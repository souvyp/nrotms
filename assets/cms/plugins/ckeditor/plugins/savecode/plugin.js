var commandName = 'Savecode';

/**
 * Plugin definition
 */
CKEDITOR.plugins.add('savecode', {
    icons : 'savecode',
    lang  : ['zh-cn'],
    init  : function (editor) {
        var plugin = this;

        // if there is no user settings
        // create an empty object
        if (editor.config.savecode === undefined) {
            editor.config.savecode = {};
        }

        // Register the command.
            editor.addCommand( commandName,{
                exec : function( editor )
                {
				
					if(editor.checkDirty()){
						var elem=editor.element.$;
						var mode=elem.getAttribute('mode');
				
						if(mode==2)  {
							var html=editor.getData();
							
							/*var params={param:'change',id:elem.getAttribute('id'),path:window.location.pathname,html:html};//存储块状文件
							var cont=JSON.stringify( params );
							 $.ajax({
								 type: "post",
								 url: 'code/template.chi',
								 data: params,
								 dataType: "json",
								 success: function(result){
									if( result&&result.success ){
										alert('保存成功!');
									}else	
										alert('保存失败!');
								}
							 });*/
							 
							html=$('<div>'+html+'</div>').html();  //修改当前页面
							var ohtml=elem.oraginHtml;							
							var nhtml=ohtml.replace($(ohtml).html(),html);
							var oldnhtml=nhtml;
							var params={param:'save',path:window.location.pathname,ohtml:ohtml,nhtml:nhtml};
							var cont=JSON.stringify( params );
							 $.ajax({
								 type: "post",
								 url: 'code/template.chi',
								 data: params,
								 dataType: "json",
								 success: function(result){
									if( result&&result.success ){
										elem.oraginHtml=oldnhtml;
										alert('保存成功!');
									}else	
										alert('保存失败!');
								}
							 });
						}
					}
                }
            });

        // add the button in the toolbar
        editor.ui.addButton('savecode', {
            label   : editor.lang.savecode.title,
            command : commandName,
            toolbar : 'savecode'
        });
		
    }
});
