/*
数据库表_workflow
id 自增列
name 表名
did 表行id 
orga 组织  flag=1标识提交的用户的组织 flag=0标识待处理的组织  
posi 岗位  flag=1标识提交的用户的岗位 flag=0标识待处理的岗位
user 用户  flag=1标识提交的用户的用户 flag=0标识待处理的用户
flag 处理标记
	0 待处理
	1 已处理
	2 被处理(历史)
	3 被忽略(历史)
	4 已关闭
	5 已退回
	6 被退回(历史)
content 提交的内容
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
	CalcStartNodeFromData(_wdata,_rdata,_data) 根据配置对象计算开始节点
	_wdata:流程配置对象
	_rdata{
		node:当前节点
		orga:组织
		posi:岗位
		user:用户
	}
	返回开始节点;
*/

function CalcStartNodeFromData(_wdata,_rdata,_data){  
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
						
					}
					else if((node.orga=='-8'||node.orga=='-9'||node.orga=="-10"||node.orga==_rdata.orga)&&node.posi==_rdata.posi){ 	//找到配置的组织和岗位orga=-9标识所有组织
						_node=key;
					}
					/*if(_node){
						var _relation = node._relation;
						if(_relation&&_relation!==""){							//按配置公式条件计算
							var w=calcTemplate(_relation,_data,true);
							if(w==true){
								break;                                 
							}
							else
								_node=null;
						}
						else{
							break;   
						}
					}*/
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
	CalcNextNodeFromData(_wdata,_rdata,_data) 根据配置对象计算下一组可用节点
	_wdata:流程配置对象
	_rdata{
		node:当前节点
		orga:组织
		posi:岗位
		user:用户
	}
	返回下一组节点;
*/

function CalcNextNodeFromData(_wdata,_rdata,_data){  
	var lines=_wdata.lines;
	var nodes=_wdata.nodes;
	
	var _node=_rdata.node;
	if(!_node)_node = CalcStartNodeFromData(_wdata,_rdata,_data);

	var nextNodes=[]; 							//当前节点的下一组节点
	for(var key in lines){
		if(lines[key].from==_node){  
			var _to = lines[key].to;
			nodes[_to].__node_id=_to;          //记录自己的节点值
			nextNodes.push(nodes[_to]);
		}
	}
	
	nextNodes.sort(function (a, b) {   			//按_order 排序
		return b._order<a._order;
	});            
	
	return {node:_node,nexts:nextNodes};
}

function CalcNextNode(_node,_wdata){  //计算_node的下一个节点
	var nodes = _wdata.nodes;
	var lines = _wdata.lines;
	for(var key in lines){
		if(nodes[lines[key].from]==_node){  
			var _to = lines[key].to;
			
			return {__node_id:_to,node:nodes[_to]};
		}
	}
	return null;
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

	var sucNext=[]; 								//根据关系条件计算节点是否可用，返回true标识节点可以
	for(var i=0;i<_nodes.length;i++){
		var _relation = _nodes[i]._relation;
		if(_relation&&_relation!==""){							//按关系条件计算
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
			nextTaskNodes.push(sucNext[i]);
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
		else if(sucNext[i].type=="end"){
			nextTaskNodes.push(sucNext[i]);
		}
		else {} //其他类型节点 待实现 （目前流程暂时没有使用其他节点）
	}
	

	var taskOrgTexts=[];
	var nextTaskRes=[];								//格式{name:'主表名',node:'节点ID',orga:'组织',posi:'岗位',user:'用户'};

	for(var i=0;i<nextTaskNodes.length;i++){        //计算下一组任务节点对应的节点ID、组织、人员、岗位
		var nNode=nextTaskNodes[i];

		if(nNode.type=="end"){					//下一个节点为结束节点
			nextTaskRes.push({name:_name,node:nNode.__node_id,flag:16});
			break;
		}
		
		//var _config=nNode._start?'':nNode._config;					//阶段起始阶段节点是否计算？待确定 
		var _config=nNode._config;
		if(_config&&_config!==""){									//配置了计算公式，按公式计算出下一节点处理的组织岗位或用户
			var w=calcTemplate(_config,_data,true);  
			if(w){
				
				w.node=nNode.__node_id;
				w.name=_name;
				nextTaskRes.push(w);		
			}
		}
		else{
			nextTaskRes.push({name:_name,node:nNode.__node_id,orga:nNode.orga,orgText:nNode.orgText,posi:nNode.posi,user:nNode.user});
		}
		
		if(nNode.orgText) 
			taskOrgTexts.push(nNode);
		
		var nNext = CalcNextNode(nNode,_wdata);

		if(nNext&&nNext.node.type=="task"){						//下一个节点为任务节点，直接进入，忽略其他分支
			break;
		}
	}
	
	return {taskOrgTexts:taskOrgTexts,nexts:nextTaskRes};

}

function GetOrgDataFromOnline(table,_handle){
	var _path = table.attr("path");
	var i=_path.indexOf('/');
	_path=_path.substring(0,i);
	OnlineData({param: 'file',path: _path+'/org.data'}, function(data) {
		_handle(data);
	}, FILE_URL);
}

/*
	postToWF(table)   	//将表单内容提交到流程
	table: 				table-form 对象
	btn:				操作按钮
	_handle(data)  		操作返回结果
*/

function postToWF(table,btn,_handle){  

	var _table=table.get(0);
	var _data=_table._data;
	if(!_data)
		_data=wrapFormData(table,true);

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
		posi:岗位
		user:用户
	}
	_data: table-form 所有对象的数据集合
	_handle(data)  		操作返回结果
*/

function postWFToDB(table,_wdata,_rdata,_data,_handle){
	var _name=table.attr('code');
	var nextNodes=CalcNextNodeFromData(_wdata,_rdata,_data);
	var nextTasks=CalcNodeTaskRes(_name,nextNodes.nexts,_wdata,_data);

	var prs;
	
	var nextTaskRes = nextTasks.nexts;
	if(nextTaskRes.length==0){
		alert('流程配置错误,无法计算下一组节点!');
	}
	else{

		if(nextTasks.taskOrgTexts.length>0){
			var orgID = _rdata.orga;
			if(orgID=="-8"){
				var orgaControl = table.find('[workflowFlag="1"]');
				var orgID = '';
				if(orgaControl.length==1)
					orgID=orgaControl.val();
			}
			
			GetOrgDataFromOnline(table,function(_odata){
				
				findOrgParent(_odata.root,orgID);
				if(prs){
					for(var i=0;i<nextTaskRes.length;i++){
						for(var j=0;j<prs.children.length;j++){
							var _otext = ','+nextTaskRes[i].orgText+',';
							if(_otext.indexOf(','+prs.children[j].text+',')>=0){  //组织文字包含的文字
								nextTaskRes[i].orga=prs.children[j].id;
							}						
						}
					}
				}
				pushDataToDB();
			});
		}
		else
			pushDataToDB();
		
		/*var datas=[{name:_name,data:{id:_data.id}}];
		var contentid='workflow_content_'+table.attr('id');
		datas.push({name:'_workflow',data:{name:_name,node:nextNodes.node,orga:_rdata.orga,posi:_rdata.posi,user:_rdata.user,flag:1,content:$('#'+contentid).val()}});

		for(var i=0;i<nextTaskRes.length;i++){
			var ndata=nextTaskRes[i];
			if(ndata.orga=="-9")
				ndata.orga="";
			else if(ndata.orga=="-10"||ndata.orga=="-8"){
				var orgaControl = table.find('[workflowFlag="1"]');
				if(orgaControl.length==1)
					ndata.orga=orgaControl.val();
				else
					ndata.orga="0";
			}
			var wfData={name:'_workflow',data:ndata};
			datas.push(wfData);                           //保存到_workflow数据库中
		}
		
		SaveDataToDB(datas,function(data){
			if(_handle)_handle(data);
		})*/
	}
	
	
	
	function findOrgParent(org,nid){

		if(org.children){
			for(var i=0;i<org.children.length;i++){
				if(org.children[i].id==nid){
					prs=org;
					break ;
				}
				else
					findOrgParent(org.children[i],nid);
			}
		}
	}
	
	function pushDataToDB(){
		//var datas=[{name:_name,data:{id:_data.id}}];
		//var contentid='workflow_content_'+table.attr('id');
		//datas.push({name:'_workflow',data:{name:_name,historyid:_rdata.id,calcType:1,node:nextNodes.node,orga:_rdata.orga,posi:_rdata.posi,user:_rdata.user,flag:1,content:$('#'+contentid).val()}});

		var datas=[];
		

		var content=table.closest('.formcontainer').find('.content_workflow textarea[name="content"]').val();
		var agree=table.closest('.formcontainer').find('.content_workflow input[name="agree"]:checked').val();

		if(_rdata.isStart){
			content='提交['+document.title+']编号['+table.find('tr:not([rowid]):not([nrowid]) input[name="code"]').val()+']';
			agree=2;
		}		
		datas.push({name:_name,historyid:_rdata.id,did:_data.id,calcType:1,node:nextNodes.node,orga:_user_status.orga,posi:_user_status.posi,user:_user_status.user,username:_user_status.username, flag:1,content:content,agree:agree});
		
		for(var i=0;i<nextTaskRes.length;i++){
			var ndata=nextTaskRes[i];
			if(ndata.orga=="-9")
				ndata.orga="";
			else if(ndata.orga=="-10"||ndata.orga=="-8"){
				var orgaControl = table.find('[workflowFlag="1"]');
				if(orgaControl.length==1)
					ndata.orga=orgaControl.val();
				else
					ndata.orga="0";
			}
			ndata.calcType=1;
			ndata.historyid=_rdata.id;
			ndata.did=_data.id;
			ndata.content=content;
			ndata.agree=agree;
			datas.push(ndata);                           //保存到_workflow数据库中
		}
		table[0]._postData=datas;
		SaveWFDataToDB(datas,function(data){
			if(_handle)_handle(data);
		})
	}
}


/*


*/
function backWFToStart(table,btn,_handle){  
	var _name=table.attr('code');
	var _table=table.get(0);
	var _data=_table._data;
	if(!_data)
		_data=wrapFormData(table,true);

	var _details = FindTableDetailNames(table);
	var _rdata=_table._rdata;
	if(_rdata&&_rdata.user){	//没有用户字段，证明没有保存数据
		
		var datas=[];
		
		var content=table.closest('.formcontainer').find('.content_workflow textarea[name="content"]').val();
		var agree=table.closest('.formcontainer').find('.content_workflow input[name="agree"]:checked').val();


		datas.push({name:_name,details:_details,did:_data.id,historyid:_rdata.id, calcType:1,node:"-1",orga:_user_status.orga,posi:_user_status.posi,user:_user_status.user,username:_user_status.username,flag:5,content:content,agree:agree});
	
		SaveWFDataToDB(datas,function(data){
			if(_handle)_handle(data);
		})
	}
	else{
		alert('请先保存数据！');
	}

}


function SaveWFDataToDB(datas,_handle){    

	OnlineData({param: 'saveWF',data: JSON.stringify(datas)}, function(data) {
		if(_handle)_handle(data);
	}, TABLE_URL);
}

/*
	createWFToolbar(table) 根据当前节点配置文件生成工具栏
*/
function createWFToolbar(table){
	var _table = table.get(0);
	var _wdata=_table._wdata;
	var _rdata=_table._rdata;

	var toolbar=$('.button_workflow');

	if(_rdata.node){
		if(toolbar.find('.added').length==0){
			var nodes=_wdata.nodes;
			var currentNode=nodes[_rdata.node];
			var tid=table.attr("id");
			toolbar.append('<a class="btn btn-red added" href="javascript:void(0);" onclick="postToWF($(\'#'+tid+'\'),this,function(data){operateResultData($(\'#'+tid+'\'),data)})">提交</a>');
			if(!_rdata.isStart){
				$('.content_workflow').show();
				//$('.content_workflow').append('<textarea id="workflow_content_'+tid+'"></textarea>').show();
				toolbar.append('<a class="btn btn-red added" href="javascript:void(0);" onclick="backWFToStart($(\'#'+tid+'\'),this,function(data){operateResultData($(\'#'+tid+'\'),data)})">退回</a>');
			}
		}
	}
	else{
		alert('流程起始节点配置错误');
		return;
	}
}

/*
	operateResultData(table,data) 操作ajax返回结果
*/



function operateResultData(table,data){
	if(data.success==true){
		//alert('提交成功!');
		var ret='';
		

		var _table=table[0];
		var datas=_table._postData;
		if(datas){
			/*var _wdata=_table._wdata;
			var nodes=_wdata.nodes;
			for(var i=0;i<datas.length;i++){
				var wd=datas[i];
				if(!wd.flag){
					//console.log(nodes);
					//console.log(wd.node);
					var node=nodes[wd.node];
					//console.log(node);
					//ret+=wd.user+','+wd.orga+','+wd.posi+','+node.name;
					if(ret!=="")ret+=",";
					ret+=node.name;
				}
			}*/
					
			var data  = data.datas;

			for(var i=0;i<data.length;i++){
				var d = data[i].data[0];
				if(d.flag==0)
					ret += d.username;
			}
			if(ret!==""){
				ret='您的单据已经提交到:['+ret+']';
			}
			else
				ret='提交成功!';
			alert(ret);
			setTimeout(function(){
				closeForm();
			},3000);
		}
		else{
			alert('单据已经退回!');
			setTimeout(function(){
				closeForm();
				//window.location.href="./?opt=1"
			},3000);
		}
	}
	else{
		alert(unescape(data.errors));
	}
}




/*
	initWorkFlow(table,_rdata,_data,_handle)  初始化工作流,将_wdata（工作流配置文件）和_rdata（表单绑定的资源对象）绑定到table对应的dom上
	table ： table-form 对象
	_rdata{
		node:当前节点
		orga:组织
		posi:岗位
		user:用户
	}
	_handle(table);
*/

function initWorkFlow(table,_rdata,_data,_handle){
	var _path = table.attr("path");
	var _code = table.attr("code");
	var _table = table.get(0);
	
	GetWFDataFromFile(_path,function(_wdata){
		if(!_rdata){
			_rdata=wrapWorkFlowData(table);
		}
		_table._wdata=_wdata;
		if(!_rdata.node){
			_rdata.node=CalcStartNodeFromData(_wdata,_rdata,_data);  //计算开始节点	
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
		posi:岗位
		user:用户
	}
*/
function wrapWorkFlowData(table){
	var data=_user_status;//{orga:getCookie('orga'),posi:getCookie('posi'),user:getCookie('user')};
	table.find('[workflowFlag!="0"]').each(function() {
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
		posi:岗位
		user:用户
	}
*/
function wrapWorkFlowDataFromData(table,data){
	var rdata=_user_status;//{orga:getCookie('orga'),posi:getCookie('posi'),user:getCookie('user')};
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

function initWorkFlowFromData(table,_data,nodedata,_sucHandle,_errHandle){ 
	getNextNodesFromDB(table,nodedata,function(_rdata){
		if(!_rdata.node){
			if(_errHandle)_errHandle();
		}
		else{
			if(_data)table[0]._data=_data;
			initWorkFlow(table,_rdata,_data,function(data){
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
			//console.log(data);
			/*for(var i=0;i<data.length;i++){
				if((_rdata.user==data[i].user)||((data[i].orga=="-9"||_rdata.orga==data[i].orga)&&_rdata.posi==data[i].posi)){ //orga=-9标识所有组织
					_rdata.node=data[i].node;
					break;
				}
			}*/

			if(data.length==1){
				_rdata=data[0];
				_rdata.user = _user_status.user;
			}
			_handle(_rdata);
			
		},TABLE_URL);
	}	
}

/*
	makeWorkFlowTimeline(table,_wpanel,_data) 生成表单的流程时间轴
	_wpanel:时间轴面板
	_data:工作流内容
	
*/


function makeWorkFlowTimeLine(table,_wpanel,_data){
	$('#_WorkFlowTimeLine').show();
	var source = _wpanel.html();
	var render = template.compile(source);
	var html = render({rows:_data});
	var whtml=$(html);
	
	_wpanel.html(html);
	_wpanel.find('.WorkFlowPhoto').html('<iframe src="/kde/workflow/show.chi?code='+table.attr('path')+'" ></iframe>');
}

/*
	改变显示面板
*/

function changeDisplayPanel(panels){
	for(var i=0;i<panels.length;i++){
		if($(panels[i]).is(':hidden')){
			$(panels[i]).show();
		}
		else{
			$(panels[i]).hide();
			$('#_WorkFlowTimeLine').text($(panels[i]).attr('title'));
		}
	}
}