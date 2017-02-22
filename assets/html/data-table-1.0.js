function makeDataTableFilter(table,dataFilter)
{
	table.attr("fld",dataFilter);
	table[0].oTable.fnFilter( );
}

function makeDataTableList(table,mselect){
	var _search_string='';
	var _search_flds='';
	var tableID=table.attr('id');
	var columns=[];
	var fields='';
	var i=0;

	makeToolbar(tableID, null, 'grid');
	
	table.find('thead th').each(function()
	{
		var fld=$(this).attr('fld');
		var fldOpt = $(this).attr('fb-options');

		if(fld)
		{
			var _opt = 
			{
				"searchable" : false,
				"sortable" : false
			};
			if (fldOpt)
			{
				fldOpt = unescape(fldOpt);
				_opt = StrToJson(fldOpt);
			}

			if(i==0)
			{
				columns.push(
				{
					mRender: function(data, type, full) 
					{
							if(mselect==1)
								return '<input type="checkbox" value="' + full.id + '" />';
							else if(mselect==3)
								return '<input type="radio" name="radio-'+tableID+'" value="'+full.id+'" />';
							else	//mselect==2 or others
								return '<input type="hidden" value="'+full.id+'" /><div style="white-space:nowrap">'+data+'</div>';
					},
					mData :fld,
					"bSortable": false
				});
			}
			else
			{
				columns.push(
				{
					mData :fld,
					"bSortable" : _opt.sortable
				});
			}

			if(fields!=="")
			{
				fields+=',';
			}
			fields += fld;

			if( i>0 && _opt.searchable)
			{
				if(_search_flds!=="")
				{
					_search_flds+='^^^';
				}
				_search_flds += "cast( isnull("+fld+",'') as varchar)^^^'|' ";
			}
			i++;
		}
	});
	
	if(fields.indexOf('id,')<0)
		fields='id,'+fields;
	var oTable=table.dataTable( {
		language: {
            "url": "/assets/plugins/DataTables-1.10.6/media/js/chinese.json"
        },
		dom: 'C<"clear">lfrtip',
		colVis : {
			buttonText : "显示 / 隐藏列"
		},
		aaSorting: [], 
		bStateSave: false,
		responsive: mselect==0,
		processing: true,
		searching:true,
		
		/*"scrollY": "200px",
        "dom": "frtiS",
        "deferRender": true,*/
		
        bServerSide: true,                   
		sAjaxSource: "/code/data/table.chi",
		//sAjaxSource: "./data.json",
		fnServerData:function(sSource, aoData, fnCallback){
			var params={param:'tabledata',data:table.attr('code'),fields:fields};
			for(var i=0;i<aoData.length;i++){
				if(aoData[i].name=='iDisplayStart')
					params.page=aoData[i].value;
				else if(aoData[i].name=='iDisplayLength')
					params.rows=aoData[i].value;
				else if(aoData[i].name=="iSortingCols"){
					var col=aoData[i].value;
					if (columns[col])
					{
						params.sort=columns[col].mData;
					}
					else
					{
						params.sort = '';
					}
				}
				else if(aoData[i].name=="sSortDir_0"){
					params.order = aoData[i].value;
				}
				else if(aoData[i].name=="sEcho"){
					params.sEcho = aoData[i].value;
				}
			}
			params.page=Math.ceil(params.page / params.rows)+1;
			params.filter="";
			var dFilter = table.attr("fld");
			if(dFilter){
				params.filter+=dFilter;
			}
			if(!_search_string==""){
				_search_flds='_search_all';
				if(params.filter!=="")params.filter+=' and ';
				params.filter+=escape("("+_search_flds + " like '%"+_search_string+"%')");
			}
			 $.ajax( {    
				"type": "get",     
				"contentType": "application/json",    
				"url": sSource,     
				"dataType": "json",    
				"data": params,
				"success": function(resp) {
					fnCallback({sEcho:params.sEcho,aaData:resp.rows,iTotalRecords:resp.total,iTotalDisplayRecords:resp.total});   
					var _searchBox=$('#'+tableID+'_filter input');

					if(_searchBox.length==1){
						_searchBox.unbind();
						_searchBox.bind( 'keypress.DT', function(e) {
							if ( e.keyCode == 13 ) {
								_search_string=$(this).val();
								oTable.fnFilter( );
								return false;
							}
						} )
					}
				}    
			});    
		},
		aoColumns: columns,
		aoColumnDefs: makeInlineToolbar(columns.length, tableID, 'grid')
	} );
	table[0].oTable=oTable;
	
	table.find('tbody').on( 'click', 'tr', function (e) {
		
	   if(e.target.tagName=="TD"){
		   if(mselect==1){
				$(this).removeClass('selected');
			   var checkbox= $(this).find('td:first-child input[type="checkbox"]');
			   if(checkbox.length==1){
				checkbox[0].checked=!checkbox[0].checked;
				if(checkbox[0].checked)
					$(this).addClass('selected');
			   }
		   }
		   else  if(mselect==3){
			  var radio= $(this).find('td:first-child input[type="radio"]');
			   if(radio.length==1){
				radio[0].checked=true;
				 $(this).addClass('selected');
			   }
		   }			
			else if(mselect==0){
				$(this).toggleClass('selected');
			}
			else if(mselect==2){
				$(this).parent().find('.selected').removeClass('selected');
				$(this).addClass('selected');
			}
		
	   }

    } );	
	
}	

function getSelectedRows( tid )
{
	return $('#'+tid).find('.selected');
}

function checkDataAll(obj){
	var table=$(obj).parents('table.dataTable');

	table.find('tbody tr td:first-child input[type="checkbox"]').each(function(){
		this.checked = obj.checked;
	});
}

function UnselectAllRows(table){
	table.find('tbody tr td:first-child input[type="checkbox"]').each(function()
	{
		this.checked = false;
	});
	
	table.find(".selected").removeClass("selected");
}

function editTableRow(tid,keyid)
{
	var _url = './default_edit.html';

	if (keyid)
	{
		//编辑
		_url += '?id=' + keyid;
	}
	
	location.href = _url;
}

function RefreshData(tid){
	setTimeout(function(){
		$('#'+tid)[0].oTable.fnFilter( );
	},300);
}

function DeleteRowTable(tid,keyid){
	OnlineData({param: 'delete',data: $('#'+tid).attr('code'),ids:keyid}, 
		function(data) {
			if(data.success==true){
				RefreshData(tid);
			}
		}
	,TABLE_URL);
}