function SaveFormDataNDT(table, that, config)
{
	if($(that).attr('btn-clicked'))
	{
		return;
	}
	
	var _chk = _VerifyForm(table);
	if (!_chk)
	{
		return;
	}
	
	$(that).attr('btn-clicked','1');
	
	var datas=wrapFormData(table);
	config = StrToJson(config);
	
	//处理添加、修改
	//datas格式:[{name:"表名",data:{表单数据}},{name:"表名",data:{表单数据}}]
	//第一个对象标识主表，其他的有name标识都为从表，主表的主键为id（自增列），从表的外键为did（bigint)
	var _pmls = [];
	var _opp = {};
	var _nP = 0;
	for (var i = 0; i<datas.length; i++)
	{
		var _d = datas[i];
		
		if (_d)
		{
			//主表
			if (0 == i)
			{
				var _c = config.main;
				if (_c && _d.data)
				{
					var _pml = BuildProtocol( _c, _d.data, false );
					
					_pmls.push(_pml);
				}
			}
			else
			{
				//从表
				var _cTbls = config[_d.name];
				if (_cTbls && _d.data)
				{
					for (var n = 0; n < _d.data.length; n++)
					{
						var _pml = BuildProtocol( _cTbls, _d.data[n], true );
					
						_pmls.push(_pml);
					}
				}
			}
		}
	}
	
	//处理删除
	//_deleteRows格式：
	//[{"name":"Operation2","id":"8"}]
	if (_deleteRows)
	{
		for (var j = 0; j < _deleteRows.length; j++)
		{
			var _dIt = _deleteRows[j];
			
			if (_dIt)
			{
				var _cTbls = config[_dIt.name];
				if (_cTbls)
				{
					var _t = {};
					_t.name = "id";
					_t.value = _dIt.id;

					var _pml = {};
					_pml.namespace = 'protocol';
					_pml.cmd = 'data';
					_pml.version = 1;
					_pml.paras = [];
					_pml.id = _cTbls.deleteVml;
					_pml.paras.push(_t);
					
					_pmls.push(_pml);
				}
			}			
		}
	}
	
	
	

	//提交请求
	PostContent( "/Portal.aspx", JsonToStr(_pmls), 'json', false, function(data)
	{
		$(that).removeAttr('btn-clicked');

		//处理添加的key_guid到id的转换
		for (var n = 0; n < data.length; n++)
		{
			var _ret = data[n];
			if (_ret.result && _ret.rs && _ret.rs.length > 0)
			{
				if (_ret.rs[0].rows && _ret.rs[0].rows.length > 0)
				{
					var __row = _ret.rs[0].rows[0];
					for (var jobj in __row)
					{
						if (jobj.toLowerCase() == "id")
						{
							var _idStr = _opp[n];
							if (_idStr)
							{
								$('input[type="hidden"][name="id"][value="'+ _idStr + '"]').val( __row[jobj] );
							}
						}
					}
				}
			}
			
			if (_ret.result)
			{
			    if ( typeof ( _ret.rs[0] ) != 'undefined' )
			    {
			        Result( _ret );
			    }
			    else
			    {
			        alert( "保存成功！" );

			        setInterval(back(),5000);
			    }
			    

			    
			}
		}
	}, function()
	{
		//error
	});
	
	//details，是否是从表
	function BuildProtocol(config, _data, details)
	{
		var _pml = {};
		_pml.namespace = 'protocol';
		_pml.cmd = 'data';
		_pml.version = 1;
		_pml.paras = [];

		for (var jobj in _data)
		{
			var _t = {};
			_t.name = jobj;
			_t.value = _data[jobj];
			
			_pml.paras.push(_t);
		}
		
		var _id = _data.id;
		if (_id.length >= 32)
		{
			//添加
			_opp[_nP] = _id;
			//var _p = {};
			//_p.no = _nP;
			//_p.id = _id;
			//_opp.push(_p);

			_pml.id = config.insertVml;
		}
		else
		{
			//修改

			_pml.id = config.updateVml;
		}
		
		//从表主动添加did到参数列表中，已存在did则修改之
		if (details)
		{
			var _t = $( 'tr:not([nrowid]) input[type="hidden"][name="id"]');
			if (_t && _t.length > 0)
			{
				var _tDid = _t.val();
				
				if (_tDid.length < 32 && _tDid.length > 0)
				{
					var __t = {};
					__t.name = "did";
					__t.value = _tDid;
			
					_pml.paras.push(__t);
				}
			}
		}
		
		//协议条数
		_nP++;
	
		return _pml;
	}


}

