

/***************************************initCombobox*******************************/

function initCombobox(that,_option,_handle){

	if(_option.cls=="url" || _option.cls=="tree"){
		var _DataID=_option.id;
		var _DataValue=_option.text;

		GetContent(unescape( _option.url ),{},'json',false,function(data){
			
			var _level = _option.cls=="tree"?2:1;
			var rows=makeRemoteData(data,_level);
			if(rows.length>0){					
				
				if(_level!==2&&!_DataID){
					var n=0;
					for(var key in rows[0]){
						if(n==0) 
							_DataID=key;
						else if(n==1){
							_DataValue=key;
							break;
						}
						n++;
					}							
				}
				if(!_DataValue)_DataValue=_DataID;
				var _arrs=[];
				for(var i=0 ; i<rows.length;i++){
					if(_level==2)
						_arrs.push({id:rows[i]["id"],text:rows[i]["text"],group:rows[i]["group"]});
					else
						_arrs.push({id:rows[i][_DataID],text:rows[i][_DataValue]});
				}
				var _html='';

				//待联动菜单不显示选项
				if (_option.linkfield && _option.linkfield != "" && _option.linkcombo && _option.linkcombo != ""){
					_html=makeComboOptions([]);
				}
				else{
					_html=makeComboOptions(_arrs);
				}
				$(that).html(_html);				
				if(_handle)_handle(data);
				var tr=$(that).closest('tr');
				if(!tr.attr('rowid'))
					initSelectControl(that);
			}
			else if(_handle)_handle(false);
		},function(){if(_handle)_handle(false);});
	}
	else {
		if(_handle)_handle(true);
		var tr=$(that).closest('tr');
		if(!tr.attr('rowid'))
		{
			initSelectControl(that);
		}
	}
}

function initSelectControl(that){
	var _that=$(that);
	if(!_that.hasClass('selectCarr')){
		_that=_that.find( 'select.edit' );
	}	
	if(!_that[0].inited){
		_that[0].inited=true;
		_that.selectpicker( {
			'selectedText': 'cat'
		} );
	}
}

/*2015/05/21 下拉菜单代码整理 郭红亮*/
/*
options, 配置项
urldata, 数据
val, 默认值
flt, 筛选值
*/
function _ShowComboWithUrlData( options, urldata, val, flt )
{
	var selects = '';
	var _DataID=options.optValue;
	var _DataValue=options.optText;
	
	if ( location.href.indexOf( '?' ) != -1 )
	{
	    selects += '<option value="0">-------------------------</option>';
	}
	else
	{
	    selects += '<option value="">-------------------------</option>';
	}

	var rows=makeRemoteData(urldata);
	if(rows.length>0)
	{						
		if(!_DataID)
		{
			var n=0;
			for(var key in rows[0])
			{
			    //if ( options.cls == 'vml' )
			    //{
			        if ( key == 'id' )
			        {
			            _DataID = key;
			        }
			        else if ( key == 'name' )
			        {
			            _DataValue = key;
			            break;
			        }
			    //}
			    //else
			    //{
			    //    if( n == 0 )
			    //    	_DataID=key;
			    //    else if(n==1)
			    //    {
			    //    	_DataValue=key;
			    //    	break;
			    //    }

			    //    n++;
			    //}
			    
				
			}							
		}

		if(!_DataValue)
			_DataValue=_DataID;

		for(var i=0 ; i<rows.length;i++)
		{
			var _show = true;

			//按联动要求过滤选项
			if (options.linkfield)
			{
				var _curVal = rows[i][options.linkfield];
				if (_curVal )
				{
					if (flt == _curVal)
					{
						_show = true;
					}
					else
					{
						_show = false;
					}
				}
			}
			
			if (_show)
			{
				selects += '<option value="' + rows[i][_DataID] + '"';
				if (val == rows[i][_DataID])
					selects += ' selected';
				selects += ' >' + rows[i][_DataValue] + '</option>';
			}
		}
	}

	return selects;
}
/*2015/05/21 下拉菜单代码整理 郭红亮*/

/*2015/05/20 联动菜单 郭红亮*/
function _DoComboLinking( obj )
{
	if (obj)
	{
		var _name = $(obj).attr("name");
		if (_name)
		{
			_name = _name.substr(0, _name.length - 3);

			var _flt = $(obj).val();
			if (!_flt)
			{
				_flt = '';
			}
			
			var _rowObj = $(obj).closest("tr[nrowid]");
			_DoLinkedComboRefresh( _name, _flt, _rowObj )
		}
	}
}

//判断当前对象是否是某表联动菜单的父对像
function _DoLinkedComboRefresh( name, flt, rowObj )
{
    var _targets = null;
    var _optionsObj = '';

    $( 'select' ).each( function ()
    {
        var _options = $( this ).attr( 'f-options' );
        _optionsObj = StrToJson( _options );

        if ( _optionsObj )
        {
            if ( rowObj && rowObj.length > 0 )
            {
                _targets = rowObj.find( 'select[linkcombo="' + name + '"]' );
            }
            else
            {
                if ( _optionsObj.linkcombo == name )
                {
                    _targets = $( this );
                }
            }
        }
    } );

    if ( _targets != null )
    {
        _targets.each( function ( index )
        {
            //重新生成下拉菜单项
            var _obj = $( this );

            var _options = _obj.attr( 'f-options' );
            _optionsObj = StrToJson( _options );

            var _url = unescape( _optionsObj.url );
            var _vml = unescape( _optionsObj.vml );

            if ( _url  != 'undefined' )
            {
                var that = this;
                OnlineData( {}, function ( data )
                {
                    _obj.children().remove();

                    var selects = _ShowComboWithUrlData( _optionsObj, data, '', flt );

                    $( selects ).appendTo( _obj );

                    var _li = '';
                    for ( var i = 0; i < $( selects ).length; i++ )
                    {
                        _li += '<li rel="' + i + '" class>';
                        _li += '<a tabindex="-1" class style href="#">';
                        _li += '<span class="text">' + $( $( selects )[i] ).text() + '</span>';
                        _li += '<i class="glyphicon glyphicon-ok icon-ok check-mark"></i>';
                        _li += '</a></li>';
                    }

                    $( _obj ).next().find( 'ul' ).html( _li );

                    $( _obj ).find( 'option' ).each( function ()
                    {
                        if ( $( _obj ).prev().val() == $( this ).text() )
                        {
                            $( this ).attr( 'selected', 'selected' );

                            _obj.trigger( 'change' );

                            return false;
                        }
                        else
                        {
                            $( _obj ).next().find( 'span:eq(0)' ).text( '---------------------------' );
                        }
                    } );
                }, _url );
            }
            else if (  _vml  != 'undefined' )
            {
                var that = this;
                var _jsonPara = NSF.System.Json.ToJson( _vml );
                NSF.System.Data.RecordSet( "/", _jsonPara, function ( result, config, data )
                {
                    if ( result )
                    {
                        //_obj.children().each( function ( index )
                        //{
                        //    if ( index > 0 )
                        //    {
                        //        $( this ).remove();
                        //    }
                        //} );
                        _obj.children().remove();

                        var selects = _ShowComboWithUrlData( _optionsObj, data[0], '', flt );

                        $( selects ).appendTo( _obj );

                        var _li = '';
                        for ( var i = 0; i < $( selects ).length; i++ )
                        {
                            _li += '<li rel="' + i + '" class>';
                            _li += '<a tabindex="-1" class style href="#">';
                            _li += '<span class="text">' + $( $( selects )[i] ).text() + '</span>';
                            _li += '<i class="glyphicon glyphicon-ok icon-ok check-mark"></i>';
                            _li += '</a></li>';
                        }

                        $( _obj ).next().find( 'ul' ).html( _li );

                        $( _obj ).find( 'option' ).each( function ()
                        {
                            if ( $( _obj ).prev().val() == $( this ).text() )
                            {
                                $( this ).attr( 'selected', 'selected' );

                                _obj.trigger( 'change' );

                                return false;
                            }
                            else
                            {
                                $( _obj ).prev().val( 0 );
                                $( _obj ).next().find( 'span:eq(0)' ).text( '---------------------------' );
                            }
                        } );
                    }
                } );
            }
        } );
    }

}

/*2015/05/20 联动菜单 郭红亮*/



function makeComboOptions(_arrs){
	var _eHtml = '<option value="">---------------------------</option>';
	if(_arrs.length>0){
		var _group = _arrs[0]["group"];
		var _group_old='';
		for (var i = 0; i < _arrs.length; i++) {
			if(_group){
				if(_group_old!==$.trim(_arrs[i]["group"])){
					if(_group_old!=="")
						_eHtml +='</optgroup>';
					_group_old=$.trim(_arrs[i]["group"]);
					_eHtml +='<optgroup label="'+_group_old+'">';
				}
			}
			_eHtml += '<option value="' + $.trim(_arrs[i]["id"]) + '">';
			_eHtml += $.trim(_arrs[i]["text"]) + '</option>';
		}
		if(_group)
			_eHtml +='</optgroup>';
	}
	return _eHtml;
}



/*********************************************combo action******************************************/
function pushDisplayValue(select){
	var opt = $(select).find("option:selected");
    
	if ( opt.parent()[0].tagName == 'OPTGROUP' )
	{
	    $( select ).prev().val( opt.parent().attr( 'label' ) + '/' + opt.text() );
	}
	else
	{
	    var v = opt.val();
	    if ( v == "---------------------------" ) v = "";
	    $( select ).prev().val( v );
	}
}