function initInputWebEditor()
{
	var _tbl = $('.FormTable');
	if (_tbl.length > 0)
	{
		var _lst = _tbl.find( 'textarea[f-options][name]' );
		_lst.each(function()
		{
			var ostr = $(this).attr("f-options");
			var _option = eval('(' + ostr + ')');
			var that = this;
			if (_option.type == "editor")
			{
				_initInputWebEditor(that,_option);
			}
		});
	}
}

function _initInputWebEditor(that , _option,_handle)
{
	KindEditor.ready( function ( K )
    {
        var editor1 = K.create( 'textarea[name="' + _option.code + '"]:first', {
            cssPath: '/assets/kindeditor/plugins/code/prettify.css',
            uploadJson: '/ImageUploader.aspx',
            allowFileManager: false,
            afterCreate: function ()
            {
                var self = this;
                K.ctrl( document, 13, function ()
                {
                    self.sync();
					
					var _form = $('textarea[name="' + _option.code + '"]').closest( 'form' );
					if (_form.length > 0)
					{
						_form[0].submit();
					}
                } );
                K.ctrl( self.edit.doc, 13, function ()
                {
                    self.sync();
					
					var _form = $('textarea[name="' + _option.code + '"]').closest( 'form' );
					if (_form.length > 0)
					{
						_form[0].submit();
					}
                } );
            },
			afterBlur : function()
			{
				//将内容同步到textarea
				//API Reference: http://www.kindsoft.net/docs/editor.html#sync
				this.sync();

				return;
			}
        } );
        prettyPrint();
    } );

	if(_handle)_handle(true);
}