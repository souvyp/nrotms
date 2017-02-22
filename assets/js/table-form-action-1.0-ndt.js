function initTableFormDataNDT(table,id,defaults,_readonly,_handle)
{
	var config = StrToJson(__saveNdtCfg);

	var _input = $('tr:not([nrowid]) input[type="hidden"][name="id"]');
	putInputValue( _input, id );

	var _pmls = [];
	var _opp = {};
	var _nTbl = 0;
	for (var _cfg in config)
	{
		var _pml = {};
		_pml.namespace = 'protocol';
		_pml.cmd = 'data';
		_pml.version = 1;
		_pml.id = config[_cfg].queryVml;
		_pml.paras = [{}];

		if (  _pml.id != 'company_reading' )
		{
		    if ( _cfg == "main" )
		    {
		        _pml.paras[0].name = "id";
		    }
		    else
		    {
		        _pml.paras[0].name = "did";
		    }
		    _pml.paras[0].value = id;
		}
		
		
		_pmls.push( _pml );
		
		_opp[_nTbl] = _cfg;
		_nTbl++;
	}

	PostContent( "/Portal.aspx", JsonToStr(_pmls), 'json', false, function(data)
	{
		if (data && data.length > 0)
		{
			for (var i = 0; i < data.length; i++)
			{
				var _rs = data[i];
				if (_rs.result)
				{
					var _t = _opp[i];
					if (_t == "main")
					{
						initMainTableDataNDT(table,_rs,_readonly,_handle);
					}
					else
					{
						initDetailsTableDataNDT(table,_rs,_readonly,_handle, _t);
					}
				}
			}
		}
	});
}

function initDetailsTableDataNDT(table,data,_readonly,_handle, tblName)
{
	var tr=table.find('tr[rowid="' + tblName + '"]:hidden');
	tr.each(function(){
		var rowid=tblName;
		if ( table.find( 'tr[nrowid="' + rowid + '"]' ).length == 0 )
		{
		    if ( data.rs.length != 0 )
		    {
		        var details = data.rs[0].rows;

		        var ostr = $( this ).attr( "fb-options" );
		        var _option = eval( '(' + unescape( ostr ) + ')' );
		        var _irows = _option.initialRows ? _option.initialRows : 1;
		        var i = 0;
		        if ( details )
		        {
		            for ( ; i < details.length; i++ )
		            {
		                var nrow = _row_add( $( this ) );

		                var detail = details[i];

		                for ( key in detail )
		                {
		                    var _input = nrow.find( '[name="' + key + '"]' );

		                    if ( $( _input ).parent().find( 'select' ).length == 0 )
		                    {
		                        putInputValue( _input, detail[key] );
		                    }
		                    else
		                    {
		                        $( _input ).parent().find( 'select option' ).each( function ()
		                        {
		                            if ( $( this ).val() == detail[key] )
		                            {
		                                $( this ).attr( 'selected', 'selected' );
		                            }
		                        } );
		                        putInputValue( _input, detail[key] );
		                    }

		                }
		            }

		        }
		        for ( ; i < _irows; i++ )
		        {
		            _row_add( $( this ) );
		        }
		    }
			
		}
	});
}

function initMainTableDataNDT(table,data,_readonly,_handle)
{
	clearTableData(table);
	var code=table.attr("code");
	var master = data.rs;
	if (master && data.rs.length > 0)
	{
		master = data.rs[0].rows;
		if (master && data.rs[0].rows.length > 0)
		{
			master = data.rs[0].rows[0];
		}
	}
	var mrows = table.find('tr:not([rowid]):not([nrow])');
	for(var key in master)
	{
		//key = key.toLowerCase();

		var _input = mrows.find( '[name="' + key + '"]' );

		if ( $( _input ).parent().find( 'select' ).length == 0 )
		{
		    putInputValue( _input, master[key] );
		}
		else
		{
		    $( _input ).parent().find( 'button span:eq(0)' ).text( $( _input ).next().find( '[value="' + master[key] + '"]' ).text() );
		    putInputValue( _input, master[key] );
        }
	}

	if(_handle)_handle(table);

	return;
}

