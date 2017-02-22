
function SaveMsg(){
	var enc = new mxCodec(mxUtils.createXmlDocument());
	var node = enc.encode(editor.graph.getModel());
	var content = mxUtils.getPrettyXml(node);
	
	onlineContent(MISC_FILE,{param:'save',path:$('body').attr("code")+'/data.zman',cont:content},'html',function(data){
		alert('保存成功!');
	})
	/*onlineContent(MISC_URL,{param:'saveMsg',id:'data',path:userpath+'/'+base,val:content},'json',function(data){
		alert('保存成功!');
	})*/
}


function LoadMsg()
{
	clearGraph();
	onlineContent(MISC_FILE,{param:'file',path:$('body').attr("code")+'/data.zman'},'html',function(data){
		LoadXml(data);
	})
	/*onlineContent(MISC_URL,{param:'loadMsg',path:userpath+'/'+base},'html',function(data){
		LoadXml(data)
	})*/
};

function clearGraph(){
	LoadXml(' ')
}

function LoadXml(data)
{
	var xml=data;
	if(xml.length<10)
		xml='<mxGraphModel><root><mxCell id="0"/><mxCell id="1" parent="0"/></root></mxGraphModel>';
	var xmlDocument = mxUtils.parseXml(xml);
	if(xmlDocument.documentElement != null && xmlDocument.documentElement.nodeName == 'mxGraphModel'){
		/*for(var i=0;i<operationImg.length;i++)
		{
			operationImg[i].destroy();
		}*/
		operationImg=[];
		
		var decoder = new mxCodec(xmlDocument);
		var node = xmlDocument.documentElement;	
		var graph = editor.graph;
		var model=graph.getModel();
		decoder.decode(node, model);	
		var parent = graph.getDefaultParent();	
		var childCount = model.getChildCount(parent);
		for (var i=0; i < childCount; i++)
		{
			var child = model.getChildAt(parent, i);
			if (mxUtils.isNode(child.value)){
				if(child.value.nodeName.toLowerCase()=='opimg'){
					var img=new mxImage(child.value.getAttribute('img'), 16, 16);					
					img.title=child.value.getAttribute('name');
					img.opimg=child.value;
					img.code=child.value.getAttribute('parentcode');
					img.v=child;
					operationImg.push(img);	
				}
			}
		}
		graph.refresh();
	}
};


$(function(){
	newGraph(document.getElementById('graphContainer'),
		document.getElementById('sidebarContainer'),
		document.getElementById('outlineContainer'),
		document.getElementById('toolbarContainer'));	
		
	get(MISC_URL,{param:'tlbs'},'html',function(data){
		if(data){
			var lst=data.split('\n');
			for(var i=0;i<lst.length;i++){
				$('#tableList').append('<li ord="'+(i+1)+'">'+lst[i]+'</li>');
			}
			
			$('#tableList li').each(function(){
				makeDrag(this);
			})
			
			//$('#tableList').datalist({lines:true,title:'数据列表'})
		}
	});
	
	LoadMsg();
	
});	

function makeDrag(item){
	var graph=editor.graph;
	var dragItem=item.cloneNode(true);
	
	function findCell(nCell,name){
		if(nCell.children)
			for(var j=0;j<nCell.children.length;j++){
				if(nCell.children[j].value.name==name)
					return true;
			}
		return false;
	}
	
	function initField(nGraph,nModel,nCell,name){
		onlineContent(MISC_URL,{param:'sql',sql:"select * from "+name},"json",function(datas){
			nModel.beginUpdate();
			try{
				var data=datas.data;
				for(var i=0;i<data.length;i++){
					if(!findCell(data[i].fieldname)){
						var columnObject = new Column('COLUMNNAME');
						var nn = new mxCell(columnObject, new mxGeometry(0, 0, 0, 26));						
						nn.setVertex(true);
						nn.setConnectable(false);
						if(i==0)
							nn.value.primaryKey=true;
						nn.value.parentcode=nCell.value.code;
						nn.value.orderno = i+1;
						nn.value.name = data[i].fieldname;
						nn.value.fieldname = nn.value.name;
						nn.value.displayname = nn.value.name;
						nn.value.type =data[i].datatype;
						nn.value.fieldtype = data[i].fieldtype;
						nn.value.displaywidth=data[i].displaywidth;
						nn.value.fieldsize=data[i].fieldsize;
						nn.value.editsize=data[i].fieldsize;
						nGraph.addCell(nn, nCell);	
					}
				}							
			}
			finally
			{
				nModel.endUpdate();
			}
		});
	}
	
	var funct = function(graph, evt, cell)
	{
		graph.stopEditing(false);
		
		var pt = graph.getPointForEvent(evt);
		
		var parent = graph.getDefaultParent();
		var name=item.innerText;
		if(findCell(parent,name)){
			alert('数据表['+name+']已经存在视图中!');
			return;
		}
		var model = graph.getModel();
		
		var model = graph.getModel();
		model.beginUpdate();
		try
		{	
			var tableObject = new Table(name);
			var table = new mxCell(tableObject, new mxGeometry(0, 0, 200, 28), 'table');
			
			table.setVertex(true);
			
			table.geometry.x = pt.x;
			table.geometry.y = pt.y;
			table.value.name = name;
			table.value.orderno = item.getAttribute("ord");
			graph.addCell(table, parent);	
			table.geometry.alternateBounds = new mxRectangle(0, 0, table.geometry.width, table.geometry.height);
			initField(graph,model,table,name);
		}
		finally
		{
			model.endUpdate();
		}
		
		graph.setSelectionCell(table);
		
	}
	
	var ds = mxUtils.makeDraggable(item, graph, funct, dragItem);

	// Adds highlight of target tables for columns
	ds.highlightDropTargets = true;
	ds.getDropTarget = function(graph, x, y)
	{
		
	};
}

function alert(text){
	$.messager.alert('提示',text);
}

