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
				$(this).parent().append('<script id="'+Code2EditorName(_option.code) +'" type="text/plain" style="width:100%;height:278px"></script>');
				$(this).hide();
				$(this).parent().attr('style','white-space: inherit;')
			}
		});
	}
}

function Code2EditorName(_code)
{
	return _code + '_Editor';
}

//更改为百度编辑器 2016-05-24 杨柳
function _initInputWebEditor(that , _option,_handle)
{
	var _name = Code2EditorName(_option.code);
	var ue = UE.getEditor(_name, {
		textarea : _option.code,
		autoClearinitialContent : false
	});
	//编辑器准备好以后，设置默认值
	ue.addListener( 'ready', function( editor ) 
	{
		$('textarea[name="' + _option.code + '"]').attr( "editorReady", "true");
	} );
	/*
	//第二种同步方法
	ue.addListener( 'contentChange', function() {
		$('textarea[name="' + _option.code + '"]').val( ue.getContent() );
	});
	*/
}

//循环同步所有Editor
function SyncEditors()
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
				SyncEditor(_option.code);
			}
		});
	}
}

//将Editor值同步到Textarea
function SyncEditor(_code)
{
	var _name = Code2EditorName(_code);
	var ue = UE.getEditor(_name);
	$('textarea[name="' + _code + '"]').val( ue.getContent() );
}

function InitialEditorContent(_object)
{
	try
	{
		var ostr = $(_object).attr("f-options");
		var _option = eval('(' + ostr + ')');
		var _code = _option.code;

		setTimeout( "_DoEditorContentInitialize('" + _code + "')", 500 );
	}
	catch(e)
	{
		//
	}
	
	return;
}

function _DoEditorContentInitialize(_code)
{
	console.log( "_DoEditorContentInitialize:" + _code );
	
	var _r = $('textarea[name="' + _code + '"]').attr( "editorReady");
	if (_r == 'true')
	{
		var _name = Code2EditorName(_code);
		var ue = UE.getEditor(_name);
		var _html = $('textarea[name="' + _code + '"]').val();
		if (_html)
		{
			ue.setContent(_html, false);
		}
	}
	else
	{
		setTimeout( "_DoEditorContentInitialize('" + _code + "')", 500 );
	}
}
