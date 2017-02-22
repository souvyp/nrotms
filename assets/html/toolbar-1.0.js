

function FormatScope(scope)
{
	if (!scope)
	{
		return "all";
	}
	
	if (scope == "grid" || scope == "form" || scope == "all")
	{
		return scope;
	}
	else
	{
		return "all";
	}
}

//获取Toolbar的配置信息
//_mode，required, 待读取配置信息的工具栏模式
//tblId, required for the mode who's name is bar，Gird对像的编号
//返回值为配置信息的JSON
function getToolbarConfig(_mode, tblId)
{
	var opObj = null;

	if (_mode == "inline")
	{
		opObj = $('th[name="operate"][op-options]');
	}
	else if (_mode == "bar")
	{
		opObj = $('#' + tblId );
	}
	else
	{
		return null;
	}

	if (opObj)
	{
		var opDef = opObj.attr("op-options");
		if (opDef)
		{
			return StrToJson( unescape(opDef) );
		}
	}
	
	return null;
}

//toolbar按钮点击事件处理函数
//srcObj, 按钮对象
function toolbar_click_event_handler(srcObj)
{
	var __config = $(srcObj).attr("barCfg");
	var __tblId = $(srcObj).attr("tblId");
	var __barId = $(srcObj).attr("barId");
	
	if (!__config || !__tblId)
	{
		return false;
	}
	__config = unescape( __config );
	if (__config)
	{
		__config = StrToJson( __config );
	}
	
	if (!__barId)
	{
		__barId = "";
	}

	eval(__config.handler);
}

//生成toolbar按钮
//config, 配置Json; tblId, Grid对象编号；recId，记录编号
function makeToolbarItem(config, tblId, recId)
{
	var _html = "";
	var _type = (config.type ? config.type : "icon");
	var _mode = config.mode;

	if (!_mode)
	{
		return _html;
	}
	
	if (_type == "separator")
	{
		//toolbar-separator
	}
	else if (_type == "icon")
	{
		_html += '<div class="toolbar-icon"';
		_html += ' barId="';
		_html += uuid();
		_html += '"';

		if (config.image)
		{
			_html += ' style="background-image: url(\'';
			_html += config.image;
			_html += '\');"';
		}
		else
		{
			_html += ' style="background-image: url(\'';
			_html += '/projects/icons/65.png';
			_html += '\');"';
		}
		
		if (config.handler)
		{
			_html += ' barCfg="' + escape( JsonToStr( config ) ) + '"';
			_html += ' tblId="' + tblId + '"';
			_html += ' onclick="toolbar_click_event_handler(this)"';
		}
		
		if (config.tips)
		{
			_html += ' title="';
			_html += config.tips;
			_html += '"';
		}
		
		_html += '></div>';
	}
	
	return _html;
}

//生成顶部工具条
//tblId, required，Gird对像的编号
//container, optional, 工具条容器
//scope, required，作用域[grid/form]
function makeToolbar(tblId, container, scope)
{
	var _html = "";

	var opDef = getToolbarConfig( "bar", tblId);
	if (opDef)
	{
		if (opDef.toolbar)
		{
			_html = '<div class="toolbar_nav" style="white-space:nowrap">';
			if (opDef.buttons && opDef.buttons.length > 0)
			{
				for (var i = 0; i < opDef.buttons.length; i++)
				{
					var _btn = opDef.buttons[i];
					if ( _btn && _btn.mode == "bar" )
					{
						var _sc = FormatScope( _btn.scope );

						if ( _sc == 'all' || _sc == scope )
						{
							_html += makeToolbarItem( _btn, tblId, null );
						}
					}
				}
			}
			_html += "<div style='clear:both'></div></div>";
		}
	};

	if (container)
	{
		container.html( _html );
	}
	else
	{
		$("#" + tblId).before( _html );
	}
}

//生成行内工具条
//tdIndex, 工具条所在单元格的序号；tblId，Grid对象的编号
//scope, required，作用域[grid/form]
function makeInlineToolbar(tdIndex, tblId, scope)
{
	var columns_d = [];

	var opDef = getToolbarConfig( "inline", tblId);
	if (opDef)
	{
		if (opDef.inline)
		{
			columns_d.push(
			{
				"targets": [tdIndex],						// 目标列位置，下标从0开始
				"data": "id",								// 数据列名
				"render": function(data, type, full) 		// 返回自定义内容
				{
					var _html = '<div style="white-space:nowrap">';
					if (opDef.buttons && opDef.buttons.length > 0)
					{
						for (var i = 0; i < opDef.buttons.length; i++)
						{
							var _btn = opDef.buttons[i];
							if (_btn && _btn.mode == "inline")
							{
								var _sc = FormatScope( _btn.scope );

								if ( _sc == 'all' || _sc == scope )
								{
									_html += makeToolbarItem(_btn, tblId, full.id );
								}
							}
						}
					}
					_html += "</div>";
					
					return _html;
				}
			});
		}
	}
	
	return columns_d;
}

function DefaultToolBarItemFoco(config, tblId, barId)
{
	var _rows;
	
	if (config.mode == "bar")
	{
		_rows = getSelectedRows(tblId);
	}
	else if (config.mode == "inline")
	{
		_rows = $("[barId='" + barId + "']").closest("tr");
	}
	
	if (config.name == "add")
	{
		editTableRow( tblId );
		
		return true;
	}
	if ( _rows.length == 0)
	{
		alert("请指定待编辑或删除的记录！");
		return false;
	}

	if ( config.name == "edit" && _rows.length > 1)
	{
		alert("每次只能编辑一条数据！");
		return false;
	}
	
	if (config.name == "edit")
	{
		var _id = _rows.find("td:eq(0) input:eq(0)").val();
		
		editTableRow( tblId, _id );
		
		return true;
	}
	else if (config.name == "delete")
	{
		var _id = '';
		_rows.find("td input:eq(0)").each(function(index)
		{
			if (_id != '')
			{
				_id += ',';
			}
			_id += $(this).val();
		});
		
		DeleteRowTable( tblId, _id );
		
		return true;
	}
	else
	{
		return false;
	}
}