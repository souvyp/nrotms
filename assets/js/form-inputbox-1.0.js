/***************************************initInputBox*******************************/

function initInputBox(that,_option,_handle){
	if(_option.cls=="url"){
		var _DataID=_option.id;
		var _DataValue=_option.text;

		GetContent(unescape(_option.url),{},'json',false,function(data){	
			var rows=makeRemoteData(data,1);
			if(rows.length>0){					
				if(!_DataID){
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
					_arrs.push({id:rows[i][_DataID],text:rows[i][_DataValue]});
				}
				makeInputBox(that,_arrs);
				if(_handle) _handle(data);
			}
			else if(_handle) _handle(false);
		},function(){if(_handle) _handle(false);});
	}
	else if(_handle) _handle(true);
}

function makeInputBox(that,_arrs){
	$(that).find('label:not(:hidden)').remove();
	var input=$(that).find('label:hidden input');
	for (var i = 0; i < _arrs.length; i++) {
		var nInput = input.clone();
		nInput.attr('value',$.trim(_arrs[i]["id"]));
		$(that).append($('<label></label>').append(nInput[0]).append($.trim(_arrs[i]["text"])));
	}
}