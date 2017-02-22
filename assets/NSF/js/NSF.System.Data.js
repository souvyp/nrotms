/*
依赖项:
jQuery-1.10.2.js
NSF.js
NSF.System.js
NSF.System.Network.js
*/
///<reference path="NSF.js">
///<reference path="NSF.System.js">
///<reference path="NSF.System.Network.js">

define( function( require, exports, module ) {
	require('/assets/NSF/js/NSF.System.Network.js');
	
	var _template = require('/assets/NSF/js/template.js');
	exports.template = _template;							//提供一个接口
	
	NSF.System.Data = function ()
	{
		//properties
		this.Name = "NSF.System.Data";
		this.Author = "Guo HongLiang";
		this.Version = "0.0.1";
		this.PublishDate = "2014-9-1";

		//constructor
		function constructor()
		{
			//do nothing
		}
		{
			constructor();
		}
	};

	/*
	description：
		在字符串中尝试用Json项逐一进行替换
	parameter：
		str, 被替换字符串
	   json, Json
	returns：
		替换结果字符串
	*/
	NSF.System.Data.ReplaceJsonData = function ( str, json )
	{
		for ( var key in json )
		{
			str = str.ReplaceAll( '@' + key.toLowerCase() + '@', json[key] );
		}

		return str;
	};

	/*
	descripton:
		生成data这种数据访问方式的参数
	parameters:
		config, 定义为
			{ dsid : "dataset_id", page : 1, rows : 200, order : ""}
	returns:
		a json
	*/
	NSF.System.Data.GetDataParams = function ( config )
	{
		var _pml = [{}];
		_pml[0].namespace = 'protocol';
		_pml[0].cmd = 'data';
		_pml[0].version = 1;

		if ( config.id )
		{
			_pml[0].id = config.id;
		}
		var para = [];
		var pObj = {};

		_pml[0].paras = config.paras;
		if ( config.page )
		{
			var _pageJson = {};
			_pageJson.name = "page";
			_pageJson.value = config.page;

			_pml[0].paras.push( _pageJson );
		}
		if ( config.rows )
		{
			var _rowsJson = {};
			_rowsJson.name = "rows";
			_rowsJson.value = config.rows;

			_pml[0].paras.push( _rowsJson );
		}

		return _pml;
	};
	/*
	description:
		生成column这种数据访问方式的参数
	parameters:
		config, 定义为 
			{ dsid : "dataset_id"}
	returns:
		a json
	*/
	NSF.System.Data.GetDefineParams = function ( config )
	{
		var _pml = [{}];
		_pml[0].namespace = 'protocol';
		_pml[0].cmd = 'define';
		_pml[0].version = 1;

		if ( config.id )
		{
			_pml[0].id = config.id;
		}

		return _pml;

	};
	/*
	description: 
		获取记录
	parameters:
		  sUrl,  portal.cn的URL
		config, 配置信息, json格式的字符串
	  callback, 回调函数
				function(true/false, config_json, response_json)
	*/
	NSF.System.Data.RecordSet = function ( sUrl, config, callback )
	{
		//rows
		var jsonParams = NSF.System.Data.GetDataParams( config );

		var _cross = config.cross;

		if ( _cross == 'false' )
		{
			_cross = false;
		}
		else
		{
			_cross = true;
		}
		var _jsonParams = NSF.System.Json.ToString( jsonParams );
		sUrl += NSF.System.Definition.Interface( 'SystemData' );
		NSF.System.Network.Ajax( sUrl, _jsonParams, 'POST', _cross, function ( successed, data )
		{
			var _err = "";
			if ( successed && data[0] )
			{
				if ( data[0].result )
				{
					if ( callback )
					{
						if ( data[0].rs )
						{
							callback( data[0].result, config, data[0].rs );
						}
						else
						{
							if ( data.msg )
							{
								_err = data.msg;
							}
							else
							{
								_err = "server error!";
							}
						}
					}
					else
					{
						NSF.System.ThrowInfo( "NSF.System.Data.Rows, result: " );
						NSF.System.ThrowInfo( data.rows );
					}
				}
				else
				{
					if ( data.err )
					{
						_err = data.err;
					}
					else
					{
						_err = "unknown error!";
					}
				}
			}
			else
			{
				if ( data && data.err )
				{
					_err = data.err;
				}
				else
				{
					_err = "unknown error!";
				}
			}

			if ( _err != "" )
			{
				if ( callback )
				{
					callback( false, config, { err: _err } );
				}
				else
				{
					NSF.System.ThrowInfo( "NSF.System.Data.Rows, err: \n" + _err );
				}
			}
		} );
	};
	/*
	description: 
		获取列的定义
	parameters:
		  sUrl, grid.cn的URL
		config, 配置信息, json格式
	  callback, 回调函数
				function(true/false, config_json, response_json)
	*/
	NSF.System.Data.Definition = function ( sUrl, config, callback )
	{
		var jsonParams = NSF.System.Data.GetDefineParams( config );
		var _cross = config.cross;
		if ( _cross == 'false' )
		{
			_cross = false;
		}
		else
		{
			_cross = true;
		}
		sUrl += NSF.System.Definition.Interface( 'SystemData' );
		jsonParams = NSF.System.Json.ToString( jsonParams );
		NSF.System.Network.Ajax( sUrl, jsonParams, 'POST', _cross, function ( successed, data )
		{
			var _err = "";
			if ( successed && data[0] )
			{
				if ( data[0].result )
				{
					if ( callback )
					{
						if ( data[0].columns )
						{
							callback( data[0].result, config, data[0].columns );
						}
						else
						{
							if ( data.msg )
							{
								_err = data.msg;
							}
							else
							{
								_err = "server error!";
							}
						}
					}
					else
					{
						NSF.System.ThrowInfo( "NSF.System.Data.Columns, result: " );
						NSF.System.ThrowInfo( data.fields );
					}
				}
				else
				{
					if ( data.err )
					{
						_err = data.err;
					}
					else
					{
						_err = "unknown error!";
					}
				}
			}
			else
			{
				if ( data && data.err )
				{
					_err = data.err;
				}
				else
				{
					_err = "unknown error!";
				}
			}

			if ( _err != "" )
			{
				if ( callback )
				{
					callback( false, config, { err: _err } );
				}
				else
				{
					NSF.System.ThrowInfo( "NSF.System.Data.Columns, err: \n" + _err );
				}
			}
		} );
	};
	/*
	数据网格对象
	*/
	NSF.System.Data.Grid = function ()
	{
		//private member fields
		var __name = null;
		var __sender = null;
		var __rowscount = 0;
		var __pagesize = 0;
		var __pagination = null;
		var __print = null;

		var __pageBuilder = null;
		var __rowsBuilder = null;

		//properties
		this.Name = "NSF.System.Data.Grid";
		this.Author = "Guo HongLiang";
		this.Version = "0.0.2";
		this.PublishDate = "2014-10-9";
		
		//private functions
		function SubStat( container, sender, rows, i )
		{
			var _doSubitem = false;

			var _row = rows[i];
			var _rowNext = null;
			var _rowLast = null;
			if ( rows.length > ( i + 1 ) )
			{
				_rowNext = rows[i + 1];
				_rowLast = rows[i - 1];
			}
			var _rowCount = _rowCount;

			sender.find( "[" + NSF.System.Definition.Envoriment.DataSubStat + "]" ).each( function ( index )
			{
				var swSubStat = NSF.System.Json.ToJson( $( this ).attr( '"' + NSF.System.Definition.Envoriment.DataSubStat + '"' ) );

				var field = new NSF.System.Data.FieldProcessor();
				_doSubitem = field.SubStat( $( this ), _row, swSubStat, _rowNext, i, _rowCount );
			} );

			//添加小计行
			if ( _doSubitem )
			{
				var _html = $( sender.outerHTML() );

				//清除view-fld标记
				_html.find( '[' + NSF.System.Definition.Envoriment.DataField + ']' ).removeAttr( NSF.System.Definition.Envoriment.DataField );
				_html.removeAttr( "id" );

				//添加小计
				container.before( _html );

				//清理小计模板
				sender.find( '[' + NSF.System.Definition.Envoriment.DataSubStat + ']' ).text( '' );

				//重置小计完成标记 
				_doSubitem = false;

				//行计数+1
				_rowNo += 1;
				_subStatNO += 1;

				if ( __print )
				{
					//添加小计行后，处理分页打印
					__print.PrintPagination( __sender, _rowNo );
				}
			}
		}

		function Stat( sender, rows, i )
		{
			var _rowCount = rows.length;
			var _row = rows[i];
			var _rowNext = null;

			if ( rows.length > ( i + 1 ) )
			{
				_rowNext = rows[i + 1];
			}
			sender.find( '[' + NSF.System.Definition.Envoriment.DataStat + ']' ).each( function ( index )
			{
				var swStat = NSF.System.Json.ToJson( $( this ).attr( '"' + NSF.System.Definition.Envoriment.DataStat + '"' ) );

				var field = new NSF.System.Data.FieldProcessor();
				field.Stat( $( this ), _row, swStat, _rowNext, i, _rowCount );
			} );
		}

		this.RowsCbk = function ( cbk )
		{
			if ( cbk && typeof ( cbk ) == 'function' )
			{
				__rowsBuilder = cbk;
			}

			return;
		};

		this.PageCbk = function ( cbk )
		{
			if ( cbk && typeof ( cbk ) == 'function' )
			{
				__pageBuilder = cbk;
			}

			return;
		};

		this.RowsCount = function ()
		{
			return __rowscount;
		};

		this.PageSize = function ()
		{
			return __pagesize;
		};

		/*
		描述：配置分页信息
		*/
		this.Pagination = function ( sName, containerObj, eventHandler )
		{
			//分页信息只能配置一次
			if ( __pagination )
			{
				NSF.System.ThrowInfo( "NSF.System.Data.Grid, The pagination object has been configured!" );

				return;
			}
			__pagination = new NSF.System.Data.Pagination( sName, containerObj, eventHandler );
			return;
		};

		/*
		描述：配置打印信息
		*/
		this.Print = function ( container, header, footer, height, rows )
		{
			if ( __print )
			{
				NSF.System.ThrowInfo( "NSF.System.Data.Grid, The pagination object has been configured!" );

				return;
			}

			__print = new NSF.System.Data.PrintArea( container, header, footer, height, rows );

			return;
		};


		this.Show = function ( result, config, data )
		{
			
			
			if ( result && __sender )
			{
				var _stat = $( "#" + config.stat );
				var _subStat = $( "#" + config.subStat );
				var _doSubitem = false;

				var _rowNo = 0;				//当前行的序号[从1开始]
				var _subStatNo = 0;
				var _statNo = 0;

				var _totalRecs = 0;
				var datas = null;
				var data1 = null;

				if ( __print )
				{
					__print.Initialize( config.page, data.count, data.total );
				}

				if ( __pagination != null && data.length > 1 )
				{
					datas = data[1].rows;
					data1 = data[0].rows;
					_totalRecs = data1[0].Total_RecsAmount;
					//get total records amount
				}
				else
				{
					if ( data[0] )
					{
						datas = data[0].rows;
					}
					else
					{
						datas = [];
					}
				}


			   for ( var i = 0; i < datas.length; i++ ){
				   
				   var html = _template( config.model, datas[i]);				   
					
					html = $(html).addClass( config.rowIdentClass );		//添加标记便于删除
					
					if ( i % 2 == 0 ){										//按奇数行、偶数行指定样式
						html = $(html).addClass( config.oddClass );		 	//奇数行
					}else{
						html = $(html).addClass( config.evenClass );		//偶数行
					}
					
					__sender.before( html ) ;								//添加行
					_rowNo += 1;											//行计数+1
					
					if ( __print ){											//添加数据行后，处理分页打印
						__print.PrintPagination( __sender, _rowNo );
					}

					if ( _subStat ){										//小计
						SubStat( __sender, _subStat, datas, i );
					}
					
					if ( _stat ){											//总计
						Stat( _stat, datas, i );
					}
				}
				
				if ( __print ){												//设置总页数
					__print.SetPrintTotalPage( __sender, data.rows.length + _subStatNo );
				}

				//清理无用内容
				$( '[' + NSF.System.Definition.Envoriment.DataStat + ']' ).removeAttr( '[' + NSF.System.Definition.Envoriment.DataStat + ']' 		);
				if ( _subStat ){
					_subStat.remove();
				}

				if ( config.ev ){											//数据装载完成，执行load事件
					var __func = config.ev;
					if ( datas && datas.length > 0 ){
						__func = NSF.System.Data.ReplaceJsonData( __func, datas[0] );
					}
					
					__func.Eval();
				}
				
				__rowscount = _totalRecs;									//分页处理.total.count
				var _paras = config.paras;
				var _page = 0;
				for ( var k = 0; k < _paras.length; k++ ){
					if ( ( _paras[k].name ).toLowerCase() == 'rows' ){
						__pagesize = _paras[k].value;
					}else if ( ( _paras[k].name ).toLowerCase() == 'page' ){
						_page = _paras[k].value;
					}
				}
				
				if ( __pagesize < NSF.System.Definition.Envoriment.MaxRows && __rowscount > __pagesize ){
					if ( __pagination ){
						if ( __pagination.IsReady() ){
							__pagination.Show();
						}else{
							__pagination.Initialize( __pagesize, __rowscount, _page );
						}
					}else{
						NSF.System.ThrowInfo( "NSF.System.Data.Grid, the  pagination object is invalid!" );
					}
				}
			}
		};

		/*
		description:
			初始化grid对象
		parameters:
				sUrl, 远程接口的路径
				sName，当前标签定义的名称
				config, 配置信息,json格式字符串　
				sender, 需要格式化为数据网格对象的当前对象
		
		for details, please read the references of NSF.System.Data.Rows
		*/
		this.Initialize = function ( sUrl, sName, config, sender, json )
		{
			__name = sName;
			__sender = sender;

			//模板容器默认隐藏
			__sender.hide();

			if ( json )
			{
				var _json = NSF.System.Json.ToJson( json );

				if ( !( NSF.System.IsNull( _json.view_id ) ) )
				{
					NSF.System.Definition.Envoriment.DataIsland = _json.view_id;
				}

				if (!( NSF.System.IsNull( _json.view_fld ) ) )
				{
					NSF.System.Definition.Envoriment.DataField = _json.view_fld;
				}

				if ( !( NSF.System.IsNull( _json.view_stat ) ) )
				{
					NSF.System.Definition.Envoriment.DataStat = _json.view_stat;
				}

				if ( !( NSF.System.IsNull( _json.view_subStat ) ) )
				{
					NSF.System.Definition.Envoriment.DataSubStat = _json.view_subStat;
				}
			}


			if ( config )
			{
				config = NSF.System.Json.ToJson( config );
				
				//删除带有此标记的行
				if ( typeof ( config.rowIdentClass ) != "undefined" &&
							config.rowIdentClass != "" )
				{
					$( document ).find( '.' + config.rowIdentClass ).remove();
				}

				config.refObj = this;
				NSF.System.Data.RecordSet( sUrl, config, this.Show );
			}

			return;
		};

		//constructor
		function constructor()
		{
			__name = "";

			//please note that it is a private function, so you can call the public fields or methods only
			//do the private visiting in the following {}
		}
		{
			constructor();
		}
	};

	/*
	description: 
		分页对象
	parameters:
		sName，分页容器名称
		container, 分页容器
	depend: 
	css class: omitted
			active_li
			pagination
			prev
			next
			showrec
			PageSize 
			recamount
	example:
	*/
	NSF.System.Data.Pagination = function ( sName, container, eventHandler )
	{
		//private member fields
		var __name = null;
		var __container = null;
		var __controller = null;
		var __current = 0;
		var __pagesize = null;
		var __total = null;
		var __pageamount = null;
		var __eventHandler = null;

		//properties
		this.Name = "NSF.System.Data.Pagination";
		this.Author = "Guo HongLiang";
		this.Version = "0.0.1";
		this.PublishDate = "2014-10-8";

		//private functions
		function Point( refObj )
		{
			var _controler = $( '<li class="omitted">...</li>' );
			refObj.after( _controler );

			return _controler;
		}

		function Button( refObj, pageno )
		{
			if ( pageno != 0 )
			{
				var _html = '<li';
				if ( __current == pageno )
				{
					_html += ' class="active"';
				}
				_html += '><a href="javascript:void(0)"></a></li>'

				var _controler = $( _html );
				_controler.find( "a" ).attr( "onclick", __eventHandler + "("+ pageno +")" );
				_controler.find( "a" ).text( pageno );

				refObj.after( _controler );

				return _controler;
			}
			else
			{
				return null;
			}
		}

		function Next()
		{
			if ( __current >= __pageamount )
			{
				return __pageamount;
			}
			else
			{
				return __current + 1;
			}
		}

		function Prev()
		{
			if ( __current <= 1 )
			{
				return 1;
			}
			else
			{
				return __current - 1;
			}
		}

		function Buttons( refObj )
		{
			if ( __pageamount > 5 )
			{
				//计算上一页下一页
				var _prev = Prev();
				var _next = Next();
				//第一页
				var __ref = Button( refObj, 1 );
				//前一页
				if ( _prev > 1 )
				{
					if ( _prev - 1 != 1 )
					{
						__ref = Point( __ref );
					}

					__ref = Button( __ref, _prev );
				}

				//当前页
				if ( __current != 1 && __current != __pageamount )
				{
					__ref = Button( __ref, __current );
				}

				//下一页
				if ( _next != __pageamount )
				{
					__ref = Button( __ref, _next );

					//...
					if ( _next + 1 != __pageamount )
					{
						__ref = Point( __ref );
					}
				}

				//...
				Button( __ref, __pageamount );
				//最后一页
				if ( __pageamount != 1 &&
					__pageamount != _prev &&
					__pageamount != _next &&
					__pageamount != __current )
				{
					//Button( __ref, __pageamount );
				}
			}
			else
			{
				for ( var i = __pageamount; i >= 1; i-- )
				{
					Button( refObj, i );
				}
			}

			return;
		}

		//methods
		this.Current = function ( _t )
		{

			if ( !$.isNumeric( _t ) )
			{
				__current = 1;
			}
			else
			{
				try
				{
					__current = parseInt( _t, 10 );
				}
				catch ( e )
				{
					__current = 1;
				}
			}
			return __current;
		};

		this.Show = function ()
		{

			if ( __pageamount > 0 )
			{
				//计算上一页下一页
				var _prev = Prev();
				var _next = Next();
				//生成上一页(左箭头)下一页(右箭头)的地址
				__controller.find( "li.prev a" ).eq( 0 ).attr( "onclick", __eventHandler + "("+ _prev +")" );
				__controller.find( "li.next a" ).eq( 0 ).attr( "onclick", __eventHandler + "("+ _next +")" );

				if ( __controller.find( '.active' ).text() != '' )
				{
					__controller.find("li").not('li.prev,li.next,li.showrec').each( function (index)
					{
						$( this ).remove();
					} );
				}

				//开始添加页码
				Buttons( __controller.find( "li.prev" ) );

				//显示记录条数
				__controller.find( "li.showrec span.pagesize" ).text( __pagesize );
				__controller.find( "li.showrec span.recamount" ).text( __total );
			}
			else
			{
				this.Hidden();
			}

		   

			return;
		};

		this.hidden = function ()
		{
			if ( __container )
			{
				__container.remove();
			}

			return;
		};

		this.IsReady = function ()
		{
			if ( __pagesize && __total && __pageamount )
			{
				return true;
			}

			return false;
		};

		/*
		description:
			初始化分页对象
		parameters:
			pagesize, 每一页记录数
			total, 总记录数
		*/
		this.Initialize = function ( pagesize, total, page )
		{

			if ( !pagesize )
			{
				__pagesize = 20;
			}
			else
			{
				__pagesize = pagesize;
			}
			if ( !total )
			{
				__total = 0;
			}
			else
			{
				__total = total;
			}

			//计算当前页
			this.Current( page );

			//计算总页数
			__pageamount = __total / __pagesize;
			__pageamount = Math.ceil( __pageamount );
			if ( __pageamount <= 0 )
			{
				this.Hidden();
			}
			//显示分页控制器
			else if ( __controller )
			{
				this.Show();
			}

			return;
		};

		//constructor
		function constructor()
		{
			//write your code here
			__name = sName;
			__container = container;
			if ( __container )
			{
				__controller = __container.find( "ul.pagination" );
			}
			if (eventHandler == null || 
				typeof(eventHandler) == "undefined")
			{
				__eventHandler = "PageControlBtn_Click";
			}
			else
			{
				__eventHandler = eventHandler;
			}

			//please note that it is a private function, so you can call the public fields or methods only
			//do the private visiting in the following {}
		}
		{
			constructor();
		}
	};

	/*
	description: 
		数据表单对象
	parameter:
		none
	returns:
		nothing
	example:
	*/
	NSF.System.Data.Form = function ()
	{
		//private member fields
		var __name = null;
		var __sender = null;
		var __url = null;
		var __mode = 'insert';

		var __fields = null;

		//properties
		this.Name = "NSF.System.Data.Form";
		this.Author = "Guo HongLiang";
		this.Version = "0.0.2";
		this.PublishDate = "2014-10-9";

		//private functions
		function DropList( srcObj, field, selected )
		{
			var _html = '<select name="' + field.fieldname.toLowerCase() + '" placeholder="' + field.displayname + '">';

			var _linklist = field.linklist;
			var _linkarr = new Array();
			_linkarr = _linklist.split( "\r" );

			for ( var j = 0; j < _linkarr.length; j++ )
			{
				var _id = new Array();
				_id = _linkarr[j].split( "=" );

				_html += '<option value="' + _id[0] + '"';
				if ( selected && _id[0] == selected )
				{
					_html += ' selected';
				}
				_html += '>' + _id[1] + '</option>';
			}
			_html += '</select>';

			srcObj.html( _html );

			return;
		}

		function DataDropList( srcObj, config, field, selected )
		{
			NSF.System.Data.Rows( __url, config, 'combo', function ( succeed, jsonConfig, jsonData )
			{
				if ( succeed )
				{
					var _html = '<select name="' + field.fieldname.toLowerCase() + '" placeholder="' + field.displayname + '">';

					if ( jsonData )
					{
						for ( var j = 0; j < jsonData.length; j++ )
						{
							_html += '<option value ="' + jsonData[j].id + '"';
							if ( selected && jsonData[j].id == selected )
							{
								_html += ' selected';
							}
							_html += '>' + jsonData[j].text + '</option>';
						}
					}
					_html += '</select>';

					srcObj.html( _html );
				}
			} );
		}

		function FormObject( container, config, field, row )
		{
			var _html = '';
			var _fieldName = field.name.toLowerCase();
			//主键自动置为不可见
			if ( field.fldkeys )
			{
				field.edittype = 15;                //隐藏域
			}

			if ( field.edittype == 1 ||             //文本
			   field.edittype == 2 ||               //密码
			   field.edittype == 6 ||               //日期
			   field.edittype == 15 ||              //隐藏域
			   field.edittype == 16 )               //时间
			{
				_html = '<input class="form-control"';

				if ( field.edittype == 1 )
				{
					_html += ' type="text"';
				}
				else if ( field.edittype == 2 )
				{
					_html += ' type="password"';
				}
				else if ( field.edittype == 6 || field.edittype == 16 )
				{
					_html += ' type="text" onfocus="$(this).calendar()" readonly';
					_html += 'style="background:url(img/datePicker.gif) no-repeat right;"';
					if ( field.edittype == 6 )
					{
						_html += ' maxlength="10"';
					}
					else if ( field.edittype == 16 )
					{
						_html += ' maxlength="5"';
					}
				}
				else if ( field.edittype == 15 )
				{
					_html += ' type="hidden"';
				}

				_html += ' name="' + _fieldName + '" placeholder="' + field.displayname + '"';
				if ( row )
				{
					_html += ' value="' + row[_fieldName] + '"';
				}
				_html += '>';
			}
				//多行文本
			else if ( field.edittype == 3 )
			{
				_html += '<textarea class="form-control" name="' + _fieldName + '" placeholder="' + field.displayname + '">';
				if ( row )
				{
					_html += row[_fieldName];
				}
				_html += '</textarea>';
			}
				//列表
			else if ( field.edittype == 4 )
			{
				if ( row )
				{
					DropList( container, field, row[_fieldName] );
				}
				else
				{
					DropList( container, field, null );
				}
			}
				//数据列表
			else if ( field.edittype == 5 )
			{
				if ( row )
				{
					DataDropList( container, config, field, row[_fieldName] );
				}
				else
				{
					DataDropList( container, config, field, null );
				}
			}
				//文件
			else if ( field.edittype == 17 )
			{
				_html = '<input type="file" name="' + _fieldName + '" />';
			}
			else
			{
				//_html = field.displayname;
				_html = field.name;
			}

			//显示表单项
			if ( _html != '' )
			{
				container.html( _html );
			}

			return;
		}

		//methods
		/*
		description:
			获得当前选项值
		parameter: 
			mode, 有三个选项, insert, edit, query, 默认为insert
		returns:
			insert or edit or query
		comments:
			当实例被创建时，第一次调用这个方法
		*/
		this.Mode = function ( mode )
		{
			__mode = mode.toLowerCase();

			if ( __mode == 'insert' || 
				__mode == 'edit' || 
				__mode == 'query' )
			{
				return __mode;
			}
			else
			{
				__mode = 'insert';
			}

			return __mode;
		};

		this.Show = function ( config, fields, row )
		{
			if ( __sender )
			{
				__sender.find( '[' + NSF.System.Definition.Envoriment.DataField + ']' ).each( function ( index )
				{
					var swDef = $( this ).attr( NSF.System.Definition.Envoriment.DataField );
					var sw = NSF.System.Json.ToJson( swDef );

					if ( sw.method == 'form' )
					{
						//遍历字段列表
						for ( var i = 0; i < fields.length; i++ )
						{
							var field = fields[i];

							var fieldname = field.name.toLowerCase();

							if ( fieldname == sw.fld.toLowerCase() )
							{
								FormObject( $( this ), sw, field, row );

								//view-fld数据装载完成，执行load事件
								if ( sw.ev )
								{
									var __fun = sw.ev;
									var fieldvalue = field.displayname;

									if ( __fun != null )
									{
										__fun += '("' + fieldname + '","' + fieldvalue + '")';

										__fun.eval();
									}
								}
								break;
							}
						}
					}
					//container的样式
					if ( sw.trClass )
					{
						$( this ).addClass( sw.trClass );
					}
				} );

				//清除view-fld标记
				__sender.find( '[' + NSF.System.Definition.Envoriment.DataField + ']' ).removeAttr( NSF.System.Definition.Envoriment.DataField );
			}

			//数据装载完成，执行load事件
			if ( config.ev )
			{
				var __func = config.ev;

				if ( __func != "" )
				{
					__func += '();';
					__func.Eval();
				}
			}

			return;
		}

		this.ColumnsReady = function ( result, config, data )
		{
			var THIS = config.refObj;
			if ( result && data )
			{
				//缓存列定义
				__fields = data;
				if ( __mode == 'insert' )
				{
					THIS.Show( config, __fields, null );
				}
				else if ( __mode == 'edit' )
				{
					//Edit的参数在服务器端的view-id的filter中书写
					//NSF.System.Data.Rows( __url, config, 'rows', THIS.RowsReady );
					NSF.System.Data.RecordSet( __url, config, THIS.RowsReady );
				}
				else if ( __mode == 'query' )
				{
					/****************************************************************************/
					/*
					查询表单根据后台动态生成，Insert表单则在前台定义按需显示
					this.Show函数为按需显示模式
					*/
					THIS.Show( config, __fields, null );
					/****************************************************************************/
				}
			}

			return;
		};

		this.RowsReady = function ( result, config, data )
		{
			var THIS = config.refObj;
			if ( !__fields )
			{
				NSF.System.ThrowInfo( 'NSF.System.Data.Form.RowsReady, the columns definition is empty!' );

				return;
			}

			if ( result && data )
			{
				if ( __mode == 'edit' )
				{
					THIS.Show( config, __fields, data.rs );
				}
			}

			return;
		};

		/*
		description:
			初始化表单对象
		parameters:
			  sUrl, 该远程接口的路径
			 sName，data island name
			config, 配置作息
			sender, 当前需要被格式化为一个数据网格对象。
		
		for details, please read the references of NSF.System.Data.Columns
		*/
		this.Initialize = function ( sUrl, sName, config, sender, json )
		{
			__name = sName;
			__sender = sender;
			__url = sUrl;

			if ( json )
			{
				var _json = NSF.System.Json.ToJson( json );

				if ( !( NSF.System.IsNull( _json.view_id ) ) )
				{
					NSF.System.Definition.Envoriment.DataIsland = _json.view_id;
				}

				if ( !( NSF.System.IsNull( _json.view_fld ) ) )
				{
					NSF.System.Definition.Envoriment.DataField = _json.view_fld;
				}

				if ( !( NSF.System.IsNull( _json.view_stat ) ) )
				{
					NSF.System.Definition.Envoriment.DataStat = _json.view_stat;
				}

				if ( !( NSF.System.IsNull( _json.view_subStat ) ) )
				{
					NSF.System.Definition.Envoriment.DataSubStat = _json.view_subStat;
				}
			}

			if ( config )
			{
				config = NSF.System.Json.ToJson( config );

				config.refObj = this;

				NSF.System.Data.Definition( sUrl, config, this.ColumnsReady );
			}

			return;
		};

		//constructor
		function constructor()
		{
			__name = "";

			//please note that it is a private function, so you can call the public fields or methods only
			//do the private visiting in the following {}
		}
		{
			constructor();
		}
	};

	/*
	说明依赖项jquery.PrintArea.js
	说明依赖项版本号
	*/
	NSF.System.Data.PrintArea = function ( container, header, footer, height, pageRows )
	{
		//private member fields
		var __container = null;     //装载分页控制器的容器对象
		var __total = null;         //总记录条数
		var __controller = null;    //分页控制器
		var __pageamount = null;    //一共需要显示的页数
		var __current = 0;          //当前页

		var __header = null;        //页码的上侧间隙的高度
		var __footer = null;        //文件尾的高度
		var __pageRows = null;        //每页记录条数
		var __rowHeight = null;     //每条记录的高度(单位：像素)

		//properties
		this.Name = "NSF.System.Data.PrintArea";
		this.Author = "Guo HongLiang";
		this.Version = "0.0.1";
		this.PublishDate = "2014-12-2";

		//private functions
		function ResetUrlVar( sName, sValue )
		{
			var _url = window.location.href;
			var _re = eval( '/(' + sName + '=)([^&]*)/gi' );

			return _url.replace( _re, sName + '=' + sValue );
		}

		function GetPaginationUrl( pageno )
		{
			var _url = location.href;
			if ( _url.indexOf( "?" ) > -1 )
			{
				_url = ResetUrlVar( "zmPage", pageno );
			}
			else
			{
				_url += "?zmPage=" + pageno;
			}

			return _url;
		}

		function GetNextPageno( current, pageamount )
		{
			if ( current >= pageamount )
			{
				return pageamount;
			}
			else
			{
				return current + 1;
			}
		}

		function GetPrevPageno( current )
		{
			if ( current <= 1 )
			{
				return 1;
			}
			else
			{
				return current - 1;
			}
		}

		function BuildPaginationBtn( refObj, pageno, current )
		{
			if ( pageno != 0 )
			{
				var _html = '<li';
				if ( current == pageno )
				{
					_html += ' class="active_li"';
				}
				_html += '><a href="#"></a></li>'

				var _controler = $( _html );
				_controler.find( "a" ).attr( "href", GetPaginationUrl( pageno ) );
				_controler.find( "a" ).text( pageno );

				refObj.after( _controler );

				return _controler;
			}
			else
			{
				return null;
			}
		}

		function BuildPaginationPoints( refObj )
		{
			var _controler = $( '<li class="omitted">...</li>' );
			refObj.after( _controler );

			return _controler;
		}

		function BuildPaginationController( refObj, pageamount, current )
		{
			//计算上一页下一页
			var _prev = GetPrevPageno( current );
			var _next = GetNextPageno( current, pageamount );

			//第一页
			var __ref = BuildPaginationBtn( refObj, 1, current );

			//前一页
			if ( _prev > 1 )
			{
				//...
				if ( _prev - 1 != 1 )
				{
					__ref = BuildPaginationPoints( __ref );
				}

				__ref = BuildPaginationBtn( __ref, _prev, current );
			}

			//当前页
			if ( current != 1 && current != pageamount )
			{
				__ref = BuildPaginationBtn( __ref, current, current );
			}

			//下一页
			if ( _next != pageamount )
			{
				__ref = BuildPaginationBtn( __ref, _next, current );

				//...
				if ( _next + 1 != pageamount )
				{
					__ref = BuildPaginationPoints( __ref );
				}
			}

			//...

			//最后一页
			BuildPaginationBtn( __ref, pageamount, current );

			return;
		}

		//显示页码
		function ShowPageNo( container, pageNo, after, lastPage )
		{
			var _html = "<div style=\"width:" + setWidth() + "px;margin-top:" + __header + "px;\"></div><div style=\"width:" + setWidth() + "px; height:14px; text-align: center; font-size:14px;\">第 <span class=\"pageNo_Current\">" + pageNo + "</span> 页 共 <span class=\"pageNo_Total\"></span> 页</div>";
			if ( after )
			{
				container.after( _html );
			}
			else
			{
				container.before( _html );
			}
			return;
		}

		//换页符
		function ShowPageBreak( container )
		{
			container.before( "<div style=\"page-break-after: always;\"></div>" );

			return;
		}

		//计算总页数
		function getPageAmount( lastRowNo )
		{
			var _total = 0;

			//记录条数刚好是页大小的整数倍
			if ( lastRowNo % __pageRows == 0 )
			{
				_total = lastRowNo / __pageRows;

				//有文件尾要显示的话，总页数+1
				if ( __footer > 0 )
				{
					return _total + 1;
				}
				else
				{
					return _total;
				}
			}
			else
			{
				_total = Math.ceil( lastRowNo / __pageRows );
				//文件尾超出来了页面显示范围
				if ( ( _total * __pageRows * __rowHeight - lastRowNo * __rowHeight ) < __footer )
				{
					_total += 1;
				}

				return _total;
			}
		}

		this.ShowPagination = function ( current, pagesize, total )
		{
			var _container = $( "ul.pagination" );
			if ( _container )
			{
				current = parseInt( current, 10 );

				//计算总页数
				var _pageamount = total / pagesize;
				_pageamount = Math.ceil( _pageamount );

				if ( _pageamount > 0 )
				{
					//计算上一页下一页
					var _prev = GetPrevPageno( current );
					var _next = GetNextPageno( current, _pageamount );

					//生成上一页下一页的地址
					_container.find( "li.prev a" ).eq( 0 ).attr( "href", GetPaginationUrl( _prev ) );
					_container.find( "li.next a" ).eq( 0 ).attr( "href", GetPaginationUrl( _next ) );

					//开始添加页码
					if ( _pageamount > 5 )
					{
						BuildPaginationController( _container.find( "li.prev" ), _pageamount, current );
					}
					else
					{
						for ( var i = _pageamount; i >= 1; i-- )
						{
							BuildPaginationBtn( _container.find( "li.prev" ), i, current );
						}
					}
				}
				else
				{
					_container.find( "li.prev a" ).eq( 0 ).removeAttr( "href" );
					_container.find( "li.next a" ).eq( 0 ).removeAttr( "href" );
				}

				//显示记录条数
				_container.find( "li.showrec span.pagesize" ).text( pagesize );
				_container.find( "li.showrec span.recamount" ).text( total );
			}

			return;
		};

		this.HidePagination = function ()
		{
			var _container = $( "tr.pagination" );
			if ( _container )
			{
				_container.remove();
			}

			return;
		};

		//设置打印的页脚中的总页数
		this.SetPrintTotalPage = function ( container, rowNo )
		{
			var prevContainer = container.parent().prev();
			var nextContainer = container.parent().next();
			if ( __pageRows == null )
			{
				__pageRows = 0;
			}
			if ( !$.isNumeric( __pageRows ) )
			{
				__pageRows = 0;
			}
			__pageRows = ( __pageRows + '' ).ToInt();
			//var _total = Math.ceil(rowNo / __pageRows);

			//最后一页-文件尾

			var _total = getPageAmount( rowNo );
			//除数据外的所有空白高度
			var _margin = __rowHeight * ( __pageRows * _total - rowNo );
			var _pageHeight;
			var _pageMargin = __pageRows * __rowHeight;
			if ( _margin > _pageMargin )
			{
				__header = _margin - _pageMargin + __header;
				ShowPageNo( container, ( _total - 1 ), false, true );

				//换页符
				ShowPageBreak( container );

				//页头
				var _header = $( prevContainer.outerHTML() );

				_header.removeAttr( "id" );
				container.before( _header );

				__header = _margin - ( _margin - _pageMargin ) - __footer;
				ShowPageNo( nextContainer, _total, true, true );

				//显示总页数
				$( ".pageNo_Total" ).html( _total );

			}
			else if ( _margin == _pageMargin )
			{
				_pageHeight = _margin - __rowHeight - __footer;
				__header = _pageHeight + __header;

				//最后一页 页码
				ShowPageNo( nextContainer, _total, true, true );

				//显示总页数
				$( ".pageNo_Total" ).html( _total );
			}
			else
			{
				_pageHeight = _margin - __rowHeight - __footer;
				__header = _pageHeight + __header;

				//最后一页 页码
				ShowPageNo( nextContainer, _total, true, true );

				//显示总页数
				$( ".pageNo_Total" ).html( _total );
			}

			return;
		}

		//打印分页信息(包括：页码、分页符、页头)
		this.PrintPagination = function ( container, rowNo )
		{
			if ( __pageRows == null )
			{
				__pageRows = 0;
			}
			if ( !$.isNumeric( __pageRows ) )
			{
				__pageRows = 0;
			}
			__pageRows = ( __pageRows + '' ).ToInt();

			//页码
			if ( rowNo % __pageRows == 0 )
			{
				var _currPageNo = rowNo / __pageRows;
				ShowPageNo( container, _currPageNo, false, false );
			}

			if ( rowNo % __pageRows == 0 )
			{
				//换页符
				ShowPageBreak( container );

				//页头
				var _header = $( container.parent().prev().outerHTML() );
				_header.removeAttr( "id" );
				container.before( _header );
			}

			return;
		}

		this.Initialize = function ( page, count, tatal )
		{
			__header = header;
			__footer = footer;
			__pageRows = pageRows;
			__rowHeight = height;

			if ( !__total )
			{
				__total = 0;
			}
			else
			{
				__total = total;
			}

			//计算总页数
			__pageamount = __total / __pageRows;
			__pageamount = Math.ceil( __pageamount );

			if ( __pageamount <= 0 )
			{
				this.HidePagination();
			}
			else
			{
				//显示分页控制器
				this.ShowPagination( page, count, __total );
			}

			return;
		};

		//constructor
		function constructor()
		{
			//please note that it is a private function, so you can call the public fields or methods only
			//do the private visiting in the following {}
		}
		{
			constructor();
		}
	};

	NSF.System.Data.FieldProcessor = function ()
	{
		//properties
		this.Name = "NSF.System.Data.FieldProcessor";
		this.Author = "Guo HongLiang";
		this.Version = "0.0.1";
		this.PublishDate = "2015-3-24";

		this.Stat = function ( container, row, swStat, rowNext, i, rowCount )
		{
			if ( swStat.method == "sum" )
			{
				//累加
				var _stat = ( container.text() ).ToFloat();
				_stat += row[swStat.fld];

				if ( i == ( rowCount - 1 ) )
				{
					//执行格式化等函数
					if ( _stat.format )
					{
						var _func = sender.format + '("' + _stat + '")';

						_stat = _func.Eval();
					}
				}
				container.text( _stat );
			}
			else if ( swStat.method == "max" )
			{
				var _maxValue;

				if ( typeof ( container.attr( 'maxValue' ) ) == 'undefined' )
				{
					_maxValue = row[swStat.fld];
					container.attr( 'maxValue', _maxValue );
				}
				else
				{
					_maxValue = ( container.attr( 'maxValue' ) ).ToFloat();
					if ( _maxValue < row[swStat.fld] )
					{
						container.attr( 'maxValue', row[swStat.fld] );
					}
				}
				if ( rowNext != null )
				{
					container.text( container.attr( 'maxValue' ) );
				}
			}
			else if ( swStat.method == "min" )
			{
				var _minValue;

				if ( typeof ( container.attr( 'minValue' ) ) == 'undefined' )
				{
					_minValue = row[swStat.fld];
					container.attr( 'minValue', _minValue );
				}
				else
				{
					_minValue = ( container.attr( 'minValue' ) ).ToFloat();
					if ( _minValue > row[swStat.fld] )
					{
						container.attr( 'minValue', row[swStat.fld] );
					}
				}
				if ( rowNext != null )
				{
					container.text( container.attr( 'minValue' ) );
				}
			}
			else if ( swStat.method == "avg" )
			{
				var _stat = ( container.text() ).ToFloat();
				_stat += row[swStat.fld];

				container.text( _stat );

				if ( rowNext == null )
				{
					var _avg = _stat / rowCount;
					container.text( _avg.toFixed( 2 ) );
				}
			}
		};

		this.SubStat = function ( container, row, swSubStat, rowNext, i, rowCount )
		{
			if ( swSubStat.method == 'sum' )
			{
				var _sub = ( container.text() ).ToFloat();

				_sub += row[swSubStat.fld];

				if ( rowNext == null || i == ( rowCount - 1 ) || row[swSubStat.refFld] != rowNext[swSubStat.refFld] )
				{
					//执行格式化等函数
					if ( swSubStat.format )
					{
						var _func = swSubStat.format + '("' + _sub + '")';

						_sub = _func.Eval();
					}

					container.text( _sub );

					return true;
				}
				else
				{
					container.text( _sub );
				}
			}
			else if ( swSubStat.method == 'max' )
			{
				var _subStat = ( container.text() ).ToFloat();

				var _maxValue;

				if ( typeof ( container.attr( 'maxValue' ) ) == 'undefined' )
				{
					_maxValue = row[swSubStat.fld];
					container.attr( 'maxValue', _maxValue );
				}
				else
				{
					_maxValue = ( container.attr( 'maxValue' ) ).ToFloat();
					if ( _maxValue < row[swSubStat.fld] )
					{
						container.attr( 'maxValue', row[swSubStat.fld] );
					}
				}

				if ( rowNext == null || i == ( rowCount - 1 ) || row[swSubStat.refFld] != rowNext[swSubStat.refFld] )
				{
					container.text( container.attr( 'maxValue' ) );

					//删除avgAmount属性
					container.removeAttr( 'maxValue' );

					return true;
				}
			}
			else if ( swSubStat.method == 'min' )
			{
				var _minValue;

				if ( typeof ( container.attr( 'minValue' ) ) == 'undefined' )
				{
					_minValue = row[swSubStat.fld];
					container.attr( 'minValue', _minValue );
				}
				else
				{
					_minValue = ( container.attr( 'minValue' ) ).ToFloat();
					if ( _minValue > row[swSubStat.fld] )
					{
						container.attr( 'minValue', row[swSubStat.fld] );
					}
				}

				if ( rowNext == null || i == ( rowCount - 1 ) || row[swSubStat.refFld] != rowNext[swSubStat.refFld] )
				{
					container.text( container.attr( 'minValue' ) );

					//删除avgAmount属性
					container.removeAttr( 'minValue' );

					return true;
				}
			}
			else if ( swSubStat.method == 'avg' )
			{
				var _times = 0;

				if ( typeof ( container.attr( 'avgAmount' ) ) == 'undefined' )
				{
					_times = 1;

					container.attr( 'avgAmount', _times );
				}
				else
				{
					_times = container.attr( 'avgAmount' ).ToInt();
					_times += 1;

					container.attr( 'avgAmount', _times );
				}

				var _subTotal = ( container.text() ).ToFloat();
				_subTotal += row[swSubStat.fld];

				if ( rowNext == null || i == ( rowCount - 1 ) || row[swSubStat.refFld] != rowNext[swSubStat.refFld] )
				{
					_subTotal = _subTotal / _times;

					//执行格式化等函数
					if ( swSubStat.format )
					{
						var _func = swSubStat.format + '("' + _subTotal + '")';

						_subTotal = _func.Eval();
					}

					container.text( _subTotal.toFixed( 2 ) );

					//删除avgAmount属性
					container.removeAttr( 'avgAmount' );

					return true;
				}
				else
				{
					container.text( _subTotal );
				}
			}
		};

		//constructor
		function constructor()
		{
			//please note that it is a private function, so you can call the public fields or methods only
			//do the private visiting in the following {}
		}
		{
			constructor();
		}
	};

	function page1( page, a ) {
			$(a).closest('li').attr( "class", "active");
		}
		
});

