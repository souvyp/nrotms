/***************************************initInputImage*******************************/

function initInputImage(that , _option,_handle){
	var imageInput=$(that);
	imageInput.attr('data-width',$(that).width());
	imageInput.attr('data-height',$(that).height());
	initDroparea(imageInput);
	if(_handle)_handle(true);
}


/*
	function initDroparea(_droparea) 初始化文件对象
*/
function initDroparea(_droparea,dataFile) {
		var w = _droparea.data('width');
		var h = _droparea.data('height');
		var hpx = h + 'px';
	if(!dataFile){
		_droparea.droparea({
			'instructions': '拖动文件到此处<br />或点击此处',
			'over': '将文件放在此处',
			'nosupport': 'No support for the File API in this web browser',
			'noimage': '不支持的文件类型!',
			'uploaded': '上传完成',
			'maxsize': '10', //Mb
			'init': function(result) {
			    //console.log('custom init',result);
			},
			'start': function (area) {
				area.find('.error').remove();
			},
			'error': function(result, input, area) {
				$('<div class="error">').html(result.error).prependTo(area);
				return 0;
				//console.log('custom error',result.error);
			},
			'complete': function ( result, file, input, area )
			{
			   
			    _droparea = input;
				if ((/image/i).test(file.type)) {
					initImages(area,result.path + result.filename);
				}
				else
					alert('不支持的文件类型!');
			    //console.log('custom complete',result);
			}
		});
	}
	var img=_droparea.attr('data-file');
	if(img){
		var area=_droparea.parents('.droparea');
		initImages(area, img);
		area.find('.instructions').css('z-index', '-1');
	}
	else{
	    var area = _droparea.parents('.droparea');
	    area.find('.instructions').css('text-align', 'center');
	    area.find('.instructions').html('<a style="display:block;">点击上传</a>');
	    area.find('.instructions').find('a').css('line-height', hpx);
	    initImages(area, '');
	}
	function initImages(area, img) {
	    area.find('img').remove();
		_DoDropAreaImageDelete( area.find("input:eq(0)").attr("name") );
		
			//area.data('value',result.filename);
			$('<img>', {
				'src': img,
				'name' : _droparea.attr('name') + '_image'
			}).css({
				//"maxWidth": w,
			    //"maxHeight": h
			    "maxHeight": "100%",
			    "maxWidth": "90%"
			}).appendTo(area);
			var attFile=area.find('input[type="hidden"][name="'+_droparea.attr('name')+'"]');
			if(attFile.length==0){	
				attFile=$('<input type="hidden" name="'+_droparea.attr('name')+'" />');
				attFile.appendTo(area);
			}
			attFile.val(img);
			area.css('text-align', 'center');
			
			if (img != '' && img != null)
			{
				var _html = '<button type="button" name="'+_droparea.attr('name')+'_delbtn" onclick="_DoDropAreaImageDelete(\''+_droparea.attr('name')+'\')"><i class="glyphicon glyphicon-trash"></i></button>';
					_html += '<button type="button" name="'+_droparea.attr('name')+'_delbtn" onclick="_DoDropAreaImageZoom( this )"><i class="glyphicon glyphicon-zoom-in"></i></button>';
					
					_html += '<div class="modal fade" id="zoomModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="">';
					_html += '<div class="modal-dialog" style="width: 600px;padding-top:50px">';
					_html += '<div class="modal-content" style="width: 642px;">';
					_html += '<div class="modal-header" style=" padding-bottom:0;padding-top:20px;"><h4 class="modal-title text-left" id="myModalLabel"><div style="padding-left: 3px; background-color: #f27302;"> <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:\'微软雅黑\';">查看大图</p> </div></h4></div>';
					_html += '<div class="modal-body"><img src="'+ img +'" width="600" height="400"></div>';
					_html += '<div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;"><button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left: 2px; color: #888;"></span></button></div>';
					_html += '</div></div></div>';

				var _btn = $(_html);
				area.after(_btn);
			}

			setTimeout(function () {
			    var mt = (area.height() - area.find('img').height()) / 2;
			    area.find('img').css('margin-top', mt + 'px');
			}, 500);	
			
	}
}
function _DoDropAreaImageZoom( button ){
	$(button).next().modal( "show" );
	$("div.modal-backdrop").removeClass('modal-backdrop');
}
function _DoDropAreaImageDelete(name)
{
	var _droparea = $('input.droparea[name="' + name + '"]');
	if (_droparea && 
	_droparea.length > 0)
	{
		_droparea = _droparea.parent();

		if (_droparea.length > 0)
		{
			try
			{
				_droparea.find('input[name="' + name + '"]').val('');
				_droparea.find('img[name="' + name + '_image"]').remove();
				$('button[name="'+ name +'_delbtn"]').remove();
				$('button[name="'+ name +'_searchbtn"]').remove();
				_droparea.find('div.uploaded').remove();
				_droparea.parent().find("div#zoomModal").remove();
			}
			catch (e)
			{
				//
			}
		}
	}

	return;
}