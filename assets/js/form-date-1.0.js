function TrigerDateEvent(that,options){
	options.choose=function(dates){
		$(that).trigger('change');
	};
	laydate(options);
}