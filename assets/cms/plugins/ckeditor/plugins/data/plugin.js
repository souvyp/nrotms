var DatacommandName = 'data';

/**
 * Plugin definition
 */
CKEDITOR.plugins.add('data', {
    icons : 'data',
    lang  : ['zh-cn'],
    init  : function (editor) {
        var plugin = this;

        // if there is no user settings
        // create an empty object
        if (editor.config.data === undefined) {
            editor.config.data = {};
        }

        // Register the command.
            editor.addCommand( DatacommandName,{
                exec : function( editor )
                {
					
						var elem=editor.element.$;
						var mode=elem.getAttribute('mode');
						var dataid=elem.getAttribute('server-id');
						if(dataid&&(mode=="2"||mode=="3"))  {
							$('#dataModal').attr('data-id',dataid);
							$('#dataModal').modal('show');						
						}

                }
            });

        // add the button in the toolbar
        editor.ui.addButton('data', {
            label   : editor.lang.data.title,
            command : DatacommandName,
            toolbar : 'data'
        });
		
    }
});
