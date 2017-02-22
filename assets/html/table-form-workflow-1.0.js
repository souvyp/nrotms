/*
数据库表_workflow
id 自增列
name 表名
did 表行id 
orga 组织  flag=1标识提交的用户的组织 flag=0标识待处理的组织 
posi 岗位  flag=1标识提交的用户的岗位 flag=0标识待处理的岗位
user 用户  flag=1标识提交的用户的用户 flag=0标识待处理的用户
flag=1 标识提交的内容行
flag=0 标识待处理的节点
content 提交的内容，针对flag=1有效
time 提交的时间

*/

/*
	GetWFDataFromFile(_path,_handle) 获取流程文件
	_path:流程配置文件路径
	_handle(流程配置文件);
*/

function GetWFDataFromFile(_path,_handle){  
	OnlineData({param: 'file',path: _path+'/default.zwfl'}, function(data) {
		_handle(data);
	}, FILE_URL);
}


/*
	CalcStartNodeFromData(_wdata,_rdata) 根据配置对象计算开始节点
	_wdata:流程配置对象
	_rdata{
		node:当前节点
		orga:组织
		dept:岗位
		user:用户
	}
	返回开始节点;
*/

function CalcStartNodeFromData(_wdata,_rdata){  
	var lines=_wdata.lines;
	var nodes=_wdata.nodes;
	var _node=_rdata.node;

	if(!_node){																		//新提交的流程,计算起始节点
		if(_rdata&&((_rdata.orga&&_rdata.posi)||_rdata.user)){
			for(var key in nodes){
				var node=nodes[key];
				if(node.type=="task"&&node._start==1){  							//根据设置_start标记计算第一个节点作为开始节点
					if(node.user==_rdata.user){  									//找到配置的用户
						_node=key;
						break;
					}
					else if((node.orga=='-10'||node._orga==_rdata.orga)&&node.posi==_rdata.posi){ 	//找到配置的组织和岗位orga=-10标识所有组织
						_node=key;
						break;
					}
				}
			}
		}
		if(!_node)								//未找到中间起始节点
			for(var key in nodes){
				if(nodes[key].type=="start"){   //起始节点
					_node=key;
					break;
				}
			}
	}
	return _node;
}

/*
	CalcNextNodeFromData(_wdata,_rdata) 根据配置对象计算下一组可用节点
	_wdata:流程配置对象
	_rdata{
		node:当前节点
		orga:组织
		dept:岗位
		user:用户
	}
	返回下一组节点;
*/

function CalcNextNodeFromData(_wdata,_rdata){  
	var lines=_wdata.lines;
	var nodes=_wdata.nodes;
	var _node=CalcStartNodeFromData(_wdata,_rdata);

	var nextNodes=[]; 							//当前节点的下一组节点
	for(var key in lines){
		if(lines[key].from==_node){  
			nextNodes.push(nodes[lines[key].to]);
		}
	}
	
	nextNodes.sort(function (a, b) {   			//按_order 排序
		return b._order<a._order;
	});            
	
	return {node:_node,nexts:nextNodes};
}


/*
	CalcNodeTaskRes(_name,_nodes,_wdata,_data)					//根据节点_nodes计算对应的任务对象
	_name:表名
	_nodes: 需要计算的节点
	_wdata: 流程数据对象
	_data: table-form 所有对象的数据集合
	返回 下一个任务节点对应的人员或岗位;
*/

function CalcNodeTaskRes(_name,_nodes,_wdata,_data){ 
	var nodes = _wdata.nodes;
	var lines = _wdata.lines;

	var sucNext=[]; 								//根据关系条件计算下一组节点的位置
	for(var i=0;i<_nodes.length;i++){
		var _relation = _nodes[i]._relation;
		if(_relation!==""){							//按关系条件计算
			var w=calcTemplate(_relation,_data,true);
			
			if(w==true){
				sucNext.push(_nodes[i]);                                  
			}
		}
		else{
			sucNext.push(_nodes[i]);   			//没有关系条件默认为下一组节点
		}
	}
		
		
	var nextTaskNodes=[];
	
	for(var i=0;i<sucNext.length;i++){              //计算下一组任务节点的位置
		if(sucNext[i].type=="task"){				//任务节点
			nextTaskNodes(sucNext[i]);
		}
		else if(sucNext[i].type=="fork"){			//分支节点
			for(var key in lines){
				if(nodes[lines[key].from]==sucNext[i]){  
					var tNode=nodes[lines[key].to];
					tNode.__node_id=lines[key].to;
					nextTaskNodes.push(tNode);
				}
			}
		}
		else if(sucNext[i].type=="join"){			//聚合节点  根据多人单审或多人并审判断是否可以进入下一节点 待实现（目前流程暂时没有此节点）
		/*	for(var key in lines){
				if(nodes[lines[key].from]==sucNext[i]){  
					var tNode=nodes[lines[key].to];
					tNode.__node_id=lines[key].to;
					nextTaskNodes.push(tNode);
				}
			}*/
		}
		else {} //其他类型节点 待实现 （目前流程暂时没有使用其他节点）
	}
	
	var nextTaskRes=[];								//格式{name:'主表名',node:'节点ID',orga:'组织',dept:'岗位',user:'用户'};
	
	for(var i=0;i<nextTaskNodes.length;i++){        //计算下一组任务节点对应的节点ID、组织、人员、岗位
		var nNode=nextTaskNodes[i];
		var _config=nNode._config;
		if(_config){
			var w=calcTemplate(_config,_data,true);
			if(w){
				w.node=nNode.__node_id;
				w.name=_name;
				nextTaskRes.push(w);
			}
		}
		else{
			nextTaskRes.push({name:_name,node:nNode.__node_id,orga:nNode.orga,dept:nNode.posi,user:nNode.user});
		}
	}
	
	return nextTaskRes;

}

/*
	postToWF(table)   	//将表单内容提交到流程
	table: 				table-form 对象
	btn:				操作按钮
	_handle(data)  		操作返回结果
*/

function postToWF(table,btn,_handle){  

	var _data=wrapFormData(table,true);
	var _table=table.get(0);
	var _rdata=_table._rdata;
	if(_rdata&&_rdata.user){	//没有用户字段，证明没有保存数据
		var _wdata=_table._wdata;
		postWFToDB(table,_wdata,_rdata,_data,_handle?function(data){_handle(data)}:null);
	}
	else{
		alert('请先保存数据！');
	}
}

/*
	postWFToDB(table,_wdata,_rdata,_data,_handle)  	//将流程提交到_workflow数据库
	table: form-table
	_wdata: 流程数据对象
	_rdata{
		node:当前节点
		orga:组织
		dept:岗位
		user:用户
	}
	_data: table-form 所有对象的数据集合
	_handle(data)  		操作返回结果
*/

function postWFToDB(table,_wdata,_rdata,_data,_handle){
	var _name=table.attr('code');
	var nextNodes=CalcNextNodeFromData(_wdata,_rdata);
	var nextTaskRes=CalcNodeTaskRes(_name,nextNodes.nexts,_wdata,_data);

	if(nextTaskRes.length==0){
		alert('流程配置错误,无法计算下一组节点!');
	}
	else{
		var datas=[{name:_name,data:{id:_data.id}}];
		var contentid='workflow_content_'+table.attr('id');
		datas.push({name:'_workflow',data:{name:_name,node:nextNodes.node,orga:_rdata.orga,dept:_rdata.posi,user:_rdata.user,flag:1,content:$('#'+contentid).val()}});

		for(var i=0;i<nextTaskRes.length;i++){
			var wfData={name:'_workflow',data:nextTaskRes[i]};
			datas.push(wfData);                           //保存到_workflow数据库中
		}
		
		SaveDataToDB(datas,function(data){
			if(_handle)_handle(data);
		})
	}
}

/*
	createWFToolbar(table) 根据当前节点配置文件生成工具栏
*/
function createWFToolbar(table){
	var _table = table.get(0);
	var _wdata=_table._wdata;
	var _rdata=_table._rdata;

	var toolbar='<div class="workflowBar">';
	if(_rdata.node){
		var nodes=_wdata.nodes;
		var currentNode=nodes[_rdata.node];
		var tid=table.attr("id");
		toolbar+='<button onclick="postToWF($(\'#'+tid+'\'),this,function(data){operateResultData(data)})">提交</button>';
		if(!_rdata.isStart)
			toolbar+='<textarea id="workflow_content_'+tid+'"></textarea>';
	}
	else{
		alert('流程起始节点配置错误');
		return;
	}
	toolbar+='</div>';
	table.before($(toolbar));

}

/*
	operateResultData(data) 操作ajax返回结果
*/

function operateResultData(data){
	
	if(data.success==true){
		alert('提交成功!');
		setTimeout('history.go(-1);',2000);
	}
	else{
		alert(unescape(data.errors));
	}
}


/*
	makeWorkFlowTimeline(table,rdata,_handle) 生成表单的流程时间轴
*/

function makeWorkFlowTimeline(table,rdata,_handle){
}


/*
	initWorkFlow(table,_rdata,_handle)  初始化工作流,将_wdata（工作流配置文件）和_rdata（表单绑定的资源对象）绑定到table对应的dom上
	table ： table-form 对象
	_rdata{
		node:当前节点
		orga:组织
		dept:岗位
		user:用户
	}
	_handle(table);
*/

function initWorkFlow(table,_rdata,_handle){
	var _path = table.attr("path");
	var _code = table.attr("code");
	var _table = table.get(0);
	
	GetWFDataFromFile(_path,function(_wdata){
		_table._wdata=_wdata;
		if(!_rdata.node){
			_rdata.node=CalcStartNodeFromData(_wdata,_rdata);  //计算开始节点	
			_rdata.isStart=true;
		}
		_table._rdata=_rdata;
		createWFToolbar(table);
		if(_handle)_handle(table);
	});
}

/*
	wrapWorkFlowData(table) 根据workflowFlag标记从页面更换rdata的内容
	返回结果
	{
		orga:组织
		dept:岗位
		user:用户
	}
*/
function wrapWorkFlowData(table){
	var data=_user_status;//{orga:getCookie('orga'),dept:getCookie('dept'),user:getCookie('user')};
	table.find('[workflowFlag]').each(function() {

		var flag=$(this).attr("workflowFlag");
		if(flag==1){
			data.orga=$(this).val();
		}
		else if(flag==2){
			data.posi=$(this).val();
		}
		else if(flag==3){
			data.user=$(this).val();
		}
	});
	return data;
}

/*
	wrapWorkFlowDataFromData(table,data) 根据workflowFlag标记从数据更换rdata的内容，作用同上
	返回结果
	{
		orga:组织
		dept:岗位
		user:用户
	}
*/
function wrapWorkFlowDataFromData(table,data){
	var rdata=_user_status;//{orga:getCookie('orga'),dept:getCookie('dept'),user:getCookie('user')};
	table.find('tr:not([rowid]) td[fb-options]').each(function() {	
		var ostr = $(this).attr("fb-options");
		options = eval('(' + unescape(ostr) + ')');
		var flag=options.workflowFlag;
		if(flag==1){
			rdata.orga=data[options.codename];
		}
		else if(flag==2){
			rdata.posi=data[options.codename];
		}
		else if(flag==3){
			rdata.user=data[options.codename];
		}
	});
	return rdata;
}

/*
	initWorkFlowFromData(table,nodedata,_sucHandle,_errHandle) //初始化workflow,获得当前数据的工作流内容
	nodedata:当前流程数据
*/

function initWorkFlowFromData(table,nodedata,_sucHandle,_errHandle){ 
	getNextNodesFromDB(table,nodedata,function(_rdata){
		if(_rdata.node){
			if(_errHandle)_errHandle();
		}
		else{
			initWorkFlow(table,_rdata,function(data){
				if(_sucHandle)_sucHandle(data);
			});
		}
	})
}

/*
	getNextNodesFromDB(table,nodedata,_handle) //从数据库获取下一节点的rdata
	nodedata:当前流程数据,如果为空，表示初始化新增流程
	返回_handle（rdata数据流程对象）
*/

function getNextNodesFromDB(table,nodedata,_handle){
	var rdata=wrapWorkFlowData(table);
	if(!nodedata)
		_handle(rdata);
	else{
		var _rdata=rdata;
		OnlineData({param:'workflow',maxid:nodedata.id,did:nodedata.did},function(data){
			for(var i=0;i<data.length;i++){
				if((_rdata.user==data[i].user)||((data[i].orga=="-10"||_rdata.orga==data[i].orga)&&_rdata.posi==data[i].posi)){ //orga=-10标识所有组织
					_rdata.node=data[i].node;
					break;
				}
			}
			_handle(_rdata);
		},TABLE_URL);
	}	
}