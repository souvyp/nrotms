
function printTable(that,w){
	if(!w) w=794;//设置成a4
	_table_make_width(that,w); 
	that.find(".edit,.edit-list,.editarea").each(function(){
			$(this).removeAttr('readonly').removeAttr('disabled');
			$(this).closest('td').html(getInputText($(this)));
	});
	that.find('tbody').find("a").each(function(){
		if($(this).hasClass('button'))
			$(this).closest('td').html('');
		else{
			$(this).closest('td').html($(this).html());
		}
	});
	
	that.parent().printArea();
}

function printURLTable(table){
	var url='print.chi?id='+table.find('tr:not([rowid]):not([nrowid]) input[name="id"]').val();
	//openBlank(url);
	
	var a = document.createElement('a');
	a.href=url;//'print.chi?id='+table.find('tr:not([rowid]):not([nrowid]) input[name="id"]').val();
	a.target="_blank";
	a.click();
	a.remove();
}