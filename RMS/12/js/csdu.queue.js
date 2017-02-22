var Queue = function(){
    this._queue_1 = [];
    this._queue_2 = [];
    this._queue_3 = [];
    this._queue_4 = [];
    this._queue_5 = [];    
	this._eventHandler = {
		"fire" : null,
		"empty" : null,
		"clean" : null
	};
}

/*
1. 如何实现分优先级的队列？
   new多个Queue对象
2. 队列项的名字如何添加？
   放在args里面
*/
Queue.prototype = {
	//ms
    Interval : 20,  //间隔
	Init : function() //初始
	{
		return;
	},
	Destroy : function()  // 结束
	{
		this._queue = [];
		if (this._eventHandler && this._eventHandler.clean)
		{
			setTimeout(this._eventHandler.clean, 10);
		}

		return;
	},
	Bind : function( name, fn )  // 绑定
	{
		if (!name || !fn)
		{
			return;
		}
		if (name == "fire")
		{
			this._eventHandler.fire = fn;
		}
		else if (name == "empty")
		{
			this._eventHandler.empty = fn;
		}
		else if (name == "clean")
		{
			this._eventHandler.clean = fn;
		}
	},
    /**
     * 添加事件到队列中
     * @param {function} fn 函数对象
     * @param {object} context 上下文对象 可为空
     * @param {array} args JSON参数 可为空
     */
    // 
    Push : function(fn, context, args ,priority)
	{
		if(priority == 5){
	        this._queue_5.push(
	            {
	                fn : fn,
	                context : context,
	                param : args
	            }
	        );	
		}else if(priority ==4){
	        this._queue_4.push(
	            {
	                fn : fn,
	                context : context,
	                param : args
	            }
	        );
		}else if(priority == 3){
	        this._queue_3.push(
	            {
	                fn : fn,
	                context : context,
	                param : args
	            }
	        );
		}else if(priority == 2){
	        this._queue_2.push(
	            {
	                fn : fn,
	                context : context,
	                param : args
	            }
	        );
		}else if(priority == 1){
	        this._queue_1.push(
	            {
	                fn : fn,
	                context : context,
	                param : args
	            }
	        );
		}

    },
    Exec : function( step )
	{
        var that = this;
        setTimeout( function()
		{
			that._fire( step );
		}, that.Interval );
    },
	Length : function()
	{
		return this._queue.length;
	},
    _fire : function( step )
	{
		
		var task; 
		if(priority == 5){
	       var task; = this._queue_5.shift();
		}else if(priority ==4){
	       var task; = this._queue_4.shift();
		}else if(priority == 3){
	       var task; = this._queue_3.shift();
		}else if(priority == 2){
	       var task; = this._queue_2.shift();
		}else if(priority == 1){
	       var task; = this._queue_1.shift();
		}		
        //获取首个事件
        
        if( !task )
		{
			if (this._eventHandler && this._eventHandler.empty)
			{
				setTimeout(this._eventHandler.empty, 10);
			}
			return;
		}

        task.fn.call( this, task.context, task.param );
        task = null;

		if (this._eventHandler && this._eventHandler.fire)
		{
			setTimeout(this._eventHandler.fire, 10);
		}
		if (!step)
		{
			this.Exec();
		}
    }
}