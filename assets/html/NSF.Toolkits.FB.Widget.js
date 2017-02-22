
/*
Depend on:
jquery-1.11.1.min.js or upon version
json2.js
NSF.js
NSF.System.js
NSF.Toolkits.FB.js

features list:
*/
///<reference path="../jquery/js/accounting.min.js">
///<reference path="../others/js/json2.js">
///<reference path="NSF.js">
///<reference path="NSF.System.js">
///<reference path="NSF.Toolkits.FB.js">

NSF.Toolkits.FB.Widget = function()
{
    //member fields

    //properties
    this.Name = "NSF.Toolkits.FB.Widget";
    this.Author = "Guo HongLiang";
    this.Version = "0.0.1";
    this.PublishDate = "2015-5-19";

    //no private functions

    //no methods

    //constructor
    function constructor()
    {
        //write your code here

        //please note that it is a private function, so you can call the public fields or methods only
        //do the private visiting in the following {}
    }
    {
        constructor();
    }
};

//静态方法
NSF.Toolkits.FB.Widget.Button = function ( cellOptions, srcObj, v, calculation )
{
    var _html = '<a href="javascript:void(0);"';
    _html += ' tar="' + cellOptions.target + '" ';
    _html += calculation;
    _html += ' class="button">';
    _html += $( srcObj ).html();
    _html += '</a>';

    var btn = $( _html );

    $( srcObj ).html( '' );

    if ( cellOptions.ExecuteCode == '#add#' )
    {
        Add();
    }
    else if ( cellOptions.ExecuteCode == '#clone#' )
    {
        Clone();
    }
    else if ( cellOptions.ExecuteCode == '#delete#' )
    {
        Delete();
    }
    else if ( cellOptions.ExecuteCode == '#clear#' )
    {
        Clear();
    }
    else if ( cellOptions.ExecuteCode == '#save#' )
    {
        Save();
    }
    else
    {
        Other();
    }
    function _action_clone( that, btn )
    {
        var row = $( 'tr[rowid="' + btn.attr( "tar" ) + '"]' );
        var nrow = _row_add( row, $( that ).parent(), "_cloned" );
        nrow.children( 'td' ).each( function ( index )
        {
            var v = $( that ).parent().children( 'td' ).eq( index ).find( '.edit' ).val();
            $( this ).attr( "v", v );

        } )
    }

	function Add()
	{
	    var that = this;
	    btn.appendTo( $( srcObj ) ).on( 'click', function ()
	    {
	        _action_add( that, $( srcObj ) );
	    } );
	}

	function Clone()
	{
	    var that = srcObj;
	    
	    btn.appendTo( $( srcObj ) ).on( 'click', function ()
	    {
	        _action_clone( that, $( srcObj ) );
	    } );
	}

	function Delete()
	{
	    var that = srcObj;
	    btn.appendTo( $( srcObj ) ).on( 'click', function ()
	    {
	        _action_delete( that, $( srcObj ) );
	    } );
	}

	function Clear()
	{
	    var that = srcObj;
	    btn.appendTo( $( srcObj ) ).on( 'click', function ()
	    {
	        _action_clear( that, $( srcObj ) );
	    } );
	}

	function Save()
	{
	    var that = srcObj;
	    btn.appendTo( $( srcObj ) ).on( 'click', function ()
	    {
	        SaveFormData( that, $( srcObj ) );
	    } )
	}

	function Other()
	{
	    var ws = ( cellOptions.ExecuteCode );
	    btn.appendTo( $( srcObj ) ).on( 'click', function ()
	    {
	        eval( ws );
	    } )
	}

	return;
};

NSF.Toolkits.FB.Widget.Text = function ( cellOptions, srcObj, v, calculation )
{
    var _html = '<input name="' + cellOptions.codename + '"';
    _html += ' value="' + v + '"';
    _html += ' placeholder="' + cellOptions.placeholder + '"';
    _html += calculation;
    _html += ' class="edit transparent"/>';
      
    $( _html ).appendTo( $( srcObj ) ); 
};

NSF.Toolkits.FB.Widget.Number = function ( cellOptions, srcObj, v, calculation )
{
    var _html = '<input name="' + cellOptions.codename + '"';
    _html += ' value="' + v + '"';
    _html += ' placeholder="' + cellOptions.placeholder + '"';
    _html += calculation;
    _html += ' class="edit transparent"/>';
    
    $( _html ).appendTo( $( srcObj ) );
};

NSF.Toolkits.FB.Widget.Combobox = function ( cellOptions, srcObj, v, calculation )
{
    var selects = '<input type="hidden" name="' + cellOptions.codename + '" />';
    selects += '<select name="' + cellOptions.codename + '';
    selects += '_id" ' + calculation + '"';
    selects += calculation;
    selects += 'class="edit transparent" onchange="pushDisplayValue(this)">';

    if ( cellOptions.datasourcetype == 'url' )
    {
        URL();
    }
    else if ( cellOptions.datasourcetype == 'list' )
    {
        List();
    }
    else if ( cellOptions.datasourcetype == 'tree' )
    {
        Tree();
    }

    function List()
    {
        var arrs = cellOptions.datasourcetsetting.split( '\n' );
        arrs = ['中国银行', '建设银行'];
        selects += '<option value="">请选择</option>';
        for ( var i = 0; i < arrs.length; i++ )
        {
            selects += '<option value="' + arrs[i] + '"';
            if ( v == arrs[i] )
            {
                selects += ' selected';

            }
			selects += ' >' + arrs[i] + '</option>';
        }
        selects += '</select>';
        $( selects ).appendTo( $( srcObj ) );
    }
    
    function URL()
    {
        var that = srcObj;
        var url = cellOptions.datasourcetsetting;
        var _DataID = cellOptions.optValue;
        var _DataValue = cellOptions.optText;
        $( '<img src="loading.gif" class="waiting" />' ).appendTo( $( that ) );
        OnlineData( {}, GetUrlData, url );
    }

    function Tree()
    {
        var that = srcObj;
        var url = cellOptions.datasourcetsetting;
        var _DataID = cellOptions.optValue;
        var _DataValue = cellOptions.optText;
        var ddID=uuid();
        var data_content='<div class="mindMapTree"></div>';
        var btn = '<input type="text" data-toggle="modal" data-target="#win-' + ddID + '"';
        btn += 'readOnly="readOnly" ' + calculation + ' value="' + v + '" class="edit transparent"';
        btn += 'pushValus="' + escape( cellOptions.pushValus ) + '" name="' + cellOptions.codename + '" /> ';
        $( btn ).appendTo( $( that ) );

        $('<div class="modal fade text-center" id="win-'+ddID+'" style="z-index:1041;">'+
              '<div class="modal-dialog" style="display: inline-block; width: auto;">'+
                '<div class="modal-content">'+
                  '<div class="modal-header">'+
                    '<button type="button" class="close" data-dismiss="modal" aria-label="Close">'+
                    '   <span aria-hidden="true">&times;</span></button>'+
                    '<h4 class="modal-title">信息</h4>'+
                  '</div>'+
                  '<div class="modal-body" style="text-align:left;min-width:500px;min-height:300px;max-width:' +
                  ( $( window ).width() - 200 ) + 'px;max-height:' + ( $( window ).height() - 200 ) +
                  'px;overflow:auto;">' + data_content +
                  '</div>'+
                  '<div class="modal-footer">'+
                    '<button class="btn btn-sm btn-default " type="button" onclick="inputDlgTreeValue(\''+ddID+'\')">确定</button>  '+
                    '<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>'+
                    '<button class="btn btn-sm btn-default cleaninput" type="button" onclick="cleanDlgTreeValue(this)">清空</button>  '+
                  '</div>'+
                '</div>'+
              '</div>'+
            '</div>').appendTo($(that));
					
        $('#win-'+ddID).on('show.bs.modal', function (e) {
            if(!$(this).attr('table-gened')){
                $(this).attr('table-gened',1);
                var thatDlg=this;
                OnlineData( {}, GetTreeData, url )
            }
        });
    }

    function GetUrlData( data )
    {
        selects += '<option value="">请选择</option>';
        var rows = makeRemoteData( data );
        if ( rows.length > 0 )
        {
            if ( !_DataID )
            {
                var n = 0;
                for ( var key in rows[0] )
                {
                    if ( n == 0 )
                        _DataID = key;
                    else if ( n == 1 )
                    {
                        _DataValue = key;
                        break;
                    }
                    n++;
                }
            }
            if ( !_DataValue ) _DataValue = _DataID;

            for ( var i = 0 ; i < rows.length; i++ )
            {
                selects += '<option value="' + rows[i][_DataID] + '"';
                if ( v == rows[i][_DataID] )
                    selects += ' selected';
                selects += ' >' + rows[i][_DataValue] + '</option>';
            }
            selects += '</select>';

        }
        $( that ).find( '.waiting' ).remove();
        $( selects ).appendTo( $( that ) );
    }

    function GetTreeData( data )
    {
        var instance = $( thatDlg ).find( '.mindMapTree' ).jstree( {
            "checkbox": {
                "keep_selected_style": true
            },
            'core': {
                'data': data.root ? data.root : data,
                'force_text': false,
                'themes': {
                    'responsive': true,
                }
            },
            "plugins": ["wholerow"]
        } );
    }
};

NSF.Toolkits.FB.Widget.CheckboxRadio = function ( cellOptions, srcObj, v, calculation )
{
    var checks = '';
    var va = v.split( ',' );

    if ( cellOptions.datasourcetype == 'list' )
    {
        List();
    }
    else if ( cellOptions.datasourcetype == 'url' )
    {
        URL();
    }

    function List()
    {
        var arrs = cellOptions.datasourcetsetting.split( '\n' );
        var rid = uuid();

        for ( var i = 0; i < arrs.length; i++ )
        {
            var cid = uuid();
            checks += '<span class=item>';
            var n = cellOptions.codename;

            if ( cellOptions.codetype == "radio" )
            {
                n = n + '+' + rid;

            }

            checks += '<input type="' + cellOptions.codetype + '"';
            checks += 'id="' + cid + ';"';
            checks += 'name="' + n + '"';
            checks += 'value="' + arrs[i] + '"' + calculation + ' class="edit-list transparent" ';

            if ( va.indexOf( arrs[i] ) >= 0 )
            {
                checks += ' checked';

            }
            checks += '/><label for="' + cid + '" >' + arrs[i] + '</label></span>';
        }
        $( checks ).appendTo( $( srcObj ) );
    }

    function URL()
    {
        var that = srcObj;
        var url = cellOptions.datasourcetsetting;
        var _DataID = cellOptions.optValue;
        var _DataValue = cellOptions.optText;
        var _opt = options;
        $( '<img src="/assets/img/loading.gif" class="waiting" />' ).appendTo( $( that ) );
        OnlineData( {}, GetUrlData( data ), url );
    }

    function GetUrlData( data )
    {
        var rid = uuid();
        var rows = makeRemoteData( data );
        if ( rows.length > 0 )
        {
            if ( !_DataID )
            {
                var n = 0;
                for ( var key in rows[0] )
                {
                    if ( n == 0 )
                        _DataID = key;
                    else if ( n == 1 )
                    {
                        _DataValue = key;
                        break;
                    }
                    n++;
                }
            }
            if ( !_DataValue )
            {
                _DataValue = _DataID;
            }

            for ( var i = 0 ; i < rows.length; i++ )
            {
                var cid = uuid();
                checks += '<span class=item>';
                var n = _opt.codename;

                if ( _opt.codetype == "radio" )
                {
                    n = n + '+' + rid;
                }

                checks += '<input type="' + _opt.codetype + '" id="' + cid + '"';
                checks += 'name="' + n + '" value="' + rows[i][_DataID] + '"' + calculation + '';
                checks += 'class="edit-list transparent"';

                if ( va.indexOf( rows[i][_DataValue] ) >= 0 )
                {
                    checks += ' checked';

                }
                checks += '/><label for="' + cid + '" >' + rows[i][_DataValue] + '</label></span>';
            }
        }
        $( that ).find( '.waiting' ).remove();
        $( checks ).appendTo( $( that ) );
    }
};

NSF.Toolkits.FB.Widget.Date = function ( cellOptions, srcObj, v, calculation )
{
    var dateformate = 'YYYY-MM-DD hh:mm:ss';

    if ( cellOptions.dateformat )
    {
        dateformate = cellOptions.dateformat;
    }

    var laydate = "laydate({format: '" + dateformate + "'";
    laydate += ",istime:" + cellOptions.istime;

    if ( cellOptions.festival )
    {
        laydate += ",festival:true";
    }
    if ( cellOptions.dateMin )
    {
        laydate += ",min:" + cellOptions.dateMin;
    }
    if ( cellOptions.dateMax )
    {
        laydate += ",max:" + cellOptions.dateMax;
    }
    if ( cellOptions.istoday )
    {
        laydate += ",istoday:true";

    }
    laydate += '})';
       
    var _html = '<input name="' + cellOptions.codename + '"';
    _html += ' placeholder="' + cellOptions.placeholder + '"';
    _html += ' value="' + v + '"';
    _html += calculation;
    _html += ' class="laydate-icon edit"';
    _html += ' onclick="' + laydate + '" />';
    
    $( _html ).appendTo( $( srcObj ) );
};

NSF.Toolkits.FB.Widget.Richtext = function ( cellOptions, srcObj, v, calculation )
{
    var _html = '<textarea name="' + cellOptions.codename + '" class="editarea"' + calculation + '';
    _html += ' placeholder="' + cellOptions.placeholder + '">' + v + '</textarea>';

    $( _html ).width( $( srcObj ).width() - 4 ).height( $( srcObj ).height() - 4 ).appendTo( $( srcObj ) );
};

NSF.Toolkits.FB.Widget.Image = function ( cellOptions, srcObj, v, calculation )
{
    var _droparea = '<input type="file" ' + calculation + ' class="droparea spot" name="' + cellOptions.codename;
    _droparea += ' data-post="/code/files/uploadify.chi?param=upload&filename=' + cellOptions.codename + '"';
    _droparea += ' data-width="' + Math.max(( $( this ).width() - 4 ), 50 );
    _droparea += ' data-height="' + ( $( this ).height() - 4 ) + '" data-crop="true" data-file="' + v + '"/>';

    $( _droparea ).appendTo( $( srcObj ) );
    initDroparea( $( _droparea ) );

    function initDroparea( _droparea )
    {
        var w = _droparea.data( 'width' );
        var h = _droparea.data( 'height' );
        _droparea.droparea( {
            'instructions': '拖动文件到此处<br />或点击此处',
            'over': '将文件放在此处',
            'nosupport': 'No support for the File API in this web browser',
            'noimage': '不支持的文件类型!',
            'uploaded': '上传完成',
            'maxsize': '10', //Mb
            'init': function ( result )
            {
                //console.log('custom init',result);
            },
            'start': function ( area )
            {
                area.find( '.error' ).remove();
            },
            'error': function ( result, input, area )
            {
                $( '<div class="error">' ).html( result.error ).prependTo( area );
                return 0;
                //console.log('custom error',result.error);
            },
            'complete': function ( result, file, input, area )
            {
                if ( ( /image/i ).test( file.type ) )
                {
                    initImages( area, result.path + result.filename );
                }
                else
                    alert( '不支持的文件类型!' );
                //console.log('custom complete',result);
            }
        } );

        var img = _droparea.attr( 'data-file' );
        if ( img )
        {
            var area = _droparea.parents( '.droparea' );
            area.find( '.instructions' ).html( '' );
            initImages( area, img );
        }
        function initImages( area, img )
        {
            area.find( 'img' ).remove();
            //area.data('value',result.filename);
            $( '<img>', {
                'src': img
            } ).css( {
                "maxWidth": w,
                "maxHeight": h
            } ).appendTo( area );

            var attFile = area.find( 'input[type="hidden"][name="' + _droparea.attr( 'name' ) + '"]' );
            if ( attFile.length == 0 )
            {
                attFile = $( '<input type="hidden" name="' + _droparea.attr( 'name' ) + '" />' );
                attFile.appendTo( area );
            }
            attFile.val( img );
        }
    }
};

NSF.Toolkits.FB.Widget.File = function ( cellOptions, srcObj, v, calculation )
{
    var _html = '<div class="form-group">';
    _html += '<input name="' + cellOptions.codename + '" multiple class="file edit" ' + calculation + ' type="file">';
    _html += '</div>';

    var FileInput = $( _html );
    FileInput.appendTo( $( srcObj ) );

    $( srcObj ).addClass( "fileContainer" );
    FileInput.find( '.file' ).fileinput( {
        uploadUrl: '#', // you must set a valid URL here else you will get an error
        //allowedFileExtensions : ['jpg', 'png','gif'],
        overwriteInitial: false,
        maxFileSize: 1000,
        maxFilesNum: 10,
        //allowedFileTypes: ['image', 'video', 'flash'],
        slugCallback: function ( filename )
        {
            return filename.replace( '(', '_' ).replace( ']', '_' );
        }
    } );
};

NSF.Toolkits.FB.Widget.Dialogue = function ( cellOptions, srcObj, v, calculation )
{
    if ( cellOptions.modalWindow )
    {
        var ddID = uuid();
        var btn = '<a href="#" data-toggle="modal" ';
            btn += 'data-target="#win-' + ddID + '" ';
            btn += calculation + ' pushValus="' + escape( cellOptions.pushValus ) + '">';
            btn += '<input type="hidden" name="' + cellOptions.codename + '" />' + $( srcObj ).html() + '</a>';

        $( srcObj ).html( '' );
        //<input type="text" data-toggle="modal" data-target="#win-'+ddID+'" readOnly="readOnly" '+calculation+' value="'+v+'" class="edit transparent" pushValus="'+escape(_options.pushValus)+'" name="' + options.codename +'" /> ';

        var that = srcObj;
        var url = cellOptions.datasourcetsetting;
        var _options = cellOptions;

        var code = url.split( '/' );
        code = code[1];
        OnlineData( { param: "file", path: url + '/default.head' }, GetHead1, FILE_URL, 'html' );
    }
    else
    {
        var btn = '<input type="hidden" name="' + cellOptions.codename + '_id" />';
        btn += '<input type="text" data-toggle="popover" data-html="true" readOnly="readOnly" ' + calculation + '';
        btn += 'value="' + v + '" class="edit transparent" name="' + cellOptions.codename + '" data-placement="buttom"';
        btn += 'data-original-title=""  ';
        btn += '/> ';

        var that = this;
        var url = cellOptions.datasourcetsetting;
        //	$('<img src="/assets/img/loading.gif" class="waiting" />').appendTo($(that));
        var _options = cellOptions;

        OnlineData( {}, GetHead2, url );
    }

    function GetHead1( head )
    {
        var data_content = '';

        data_content += '<table class="table" cellspacing="0" width="100%" code="' + code + '" id="' + ddID + '"> ';
        data_content += '<thead>';
        data_content += '<tr>';
        //data_content +='<th fld="id">#</th>'+head;
        data_content += head;
        data_content += '</tr>';
        data_content += '</thead>';
        data_content += '<tbody>';
        data_content += '</tbody>';
        data_content += '</table>';
        $( btn ).appendTo( $( that ) );

        $( that ).find( '.waiting' ).remove();

        $( '<div class="modal fade text-center" id="win-' + ddID + '" style="z-index:1041">' +
          '<div class="modal-dialog" style="display: inline-block; width: auto;">' +
            '<div class="modal-content">' +
              '<div class="modal-header">' +
                '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                '<h4 class="modal-title">信息</h4>' +
              '</div>' +
              '<div class="modal-body" style="max-width:' + ( $( window ).width() - 200 ) +
              'px;max-height:' + ( $( window ).height() - 200 ) + 'px;overflow:auto;">' + data_content +
              '</div>' +
              '<div class="modal-footer">' +
                '<button class="btn btn-sm btn-default " type="button" onclick="inputDlgValue(\'' + ddID + '\')">确定</button>  ' +
                '<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>' +
                '<button class="btn btn-sm btn-default cleaninput" type="button" onclick="cleanDlginput(\'' + ddID + '\')">清空</button>  ' +
              '</div>' +
            '</div>' +
          '</div>' +
        '</div>' ).appendTo( $( that ) );

        $( '#win-' + ddID ).on( 'show.bs.modal', function ( e )
        {
            var cal = _options.pushFilter;
            var v = '';
            if ( cal )
            {
                var v = calcItem( $( that ).parents( 'table' ), $( that ), cal );
            }
            if ( !$( this ).attr( 'table-gened' ) )
            {
                $( this ).attr( 'table-gened', 1 );
                $( '#' + ddID ).attr( "fld", v );
                makeDataTableList( $( '#' + ddID ), 2 );
            }
            else
            {
                makeDataTableFilter( $( '#' + ddID ), v );
            }
        } );
    }

    function GetHead2( head )
    {
        var fm_popover_postion = "";
        var max_width, max_height;
        switch ( parseInt( _options.windowType ) )
        {
            case 1:
                fm_popover_postion = "left";
                max_width = 500;
                max_height = 500;
                break;
            case 2:
                fm_popover_postion = "right";
                max_width = 500;
                max_height = 500;
                break;
            case 3:
                fm_popover_postion = "top";
                max_width = 1000;
                max_height = 320;
                break;
            case 4:
                fm_popover_postion = "bottom";
                max_width = 1000;
                max_height = 320;
                break;
            default:
                break;

        }
        var data_content = '';

        if ( _options.datasourcetype == "list" )
        {
            data_content += '<div class="popoverinner"><table class="table table-bordered table-hover table-condensed"> ';
            data_content += '<thead>';
            data_content += '<tr>';
            data_content += '<th>#</th>';
            var ds = data.data[1].fields;
            var fields = [];
            for ( var i = 0; i < ds.length; i++ )
            {
                if ( ds[i].keys )
                {
                    fields.splice( 0, 0, ds[i] );
                }
                else if ( ds[i].visible )
                {
                    fields.push( ds[i] );
                    data_content += '<th>' + ds[i].displayname + '</th>';
                }
            }

            data_content += '</tr>';
            data_content += '</thead>';
            data_content += '<tbody>';

            var rows = data.data[0].rows;
            for ( var i = 0; i < rows.length; i++ )
            {
                data_content += '<tr onclick="selectTrRow(this)">';
                for ( var j = 0; j < fields.length; j++ )
                {
                    if ( j == 0 )
                    {
                        data_content += '<td><input type="radio"';
                        data_content += 'value="' + rows[i][fields[1].fieldname.toLowerCase()] + '" name="approve"/></td>';
                    }
                    else
                    {
                        data_content += '<td>' + rows[i][fields[j].fieldname.toLowerCase()] + '</td>';
                    }
                }
                data_content += '</tr>';
            }
            data_content += '</tbody>';
            data_content += '</tr>  ';
            data_content += '</table></div>';
        }
        else
        {
            data_content = '<div style="width:500px;height:300px;overflow:auto;"><div class="mindMapTree"></div></div>';
        }
        data_content += '<div align="center" style="padding-top:10px;">  ';
        data_content += '<button class="btn btn-sm btn-default " type="button" onclick="inputTreeValue(this)">确定</button>  ';
        data_content += '<button class="btn btn-sm btn-default" type="button" onclick="hideprover(this)">取消</button>  ';
        data_content += '<button class="btn btn-sm btn-default cleaninput" type="button" onclick="cleaninput(this)">清空</button>  ';
        data_content += '</div>  ';
        $( btn ).appendTo( $( that ) );

        $( that ).find( '.waiting' ).remove();

        var popover = $( that ).find( '[data-toggle="popover"]' );
        popover.attr( 'data-content', data_content );
        popover.attr( 'data-placement', fm_popover_postion );
        popover.popover();
            
        if ( _options.datasourcetype == "tree" )
        {
            function makeTreePopover()
            {
                var treeData = that.treeData;
                $( that ).find( '.mindMapTree' ).jstree( {
                    "checkbox": {
                        "keep_selected_style": true
                    },
                    'core': {
                        'data': treeData,
                        'force_text': false,
                        'themes': {
                            'responsive': true,
                        }
                    },
                    "plugins": ["wholerow"]
                } );
            }
            popover.on( 'show.bs.popover', function ()
            {
                if ( !that.treeData || true )
                {
                    OnlineData( {}, function ( data )
                    {
                        that.treeData = data.root ? data.root : data;
                        makeTreePopover();
                    }, url );

                }
                else
                {
                    makeTreePopover();
                }
            } );
        }
    }
};