/***************************************initTextarea*******************************/

function initTextarea(that,_option,_handle){
	/*$(that).autoTextarea({
	   maxHeight:400,
	   minHeight:30
	});*/
	if(_handle)_handle(true);
}

(function($){
    $.fn.autoTextarea = function(options) {
        var defaults={
            maxHeight:null,
            minHeight:$(this).height()
        };
        var opts = $.extend({},defaults,options);
        return $(this).each(function() {
            $(this).bind("paste cut keydown keyup focus blur",function(){
				var that=this;
				if(!that.calced){
					that.calced = true;
					setTimeout(function(){						
						var height,style=that.style;						
						that.style.height =  opts.minHeight + 'px';
						if (that.scrollHeight > opts.minHeight) {
							if (opts.maxHeight && that.scrollHeight > opts.maxHeight) {
								height = opts.maxHeight;
								style.overflowY = 'scroll';
							} else {
								height = that.scrollHeight;
								style.overflowY = 'hidden';
							}
							style.height = height  + 'px';
						}
						that.calced = false;
					},1000);
				}
            });
        });
    };
})(jQuery);