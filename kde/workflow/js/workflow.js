var workAreaTop = 34;
var w=$(window).width();
var h=$(window).height()-workAreaTop;

var property={
	width:w,
	height:h,
	toolBtns:["start","end","task","node","chat","state","plug","join","fork","complex"],
	haveHead:false,
	headBtns:["new","open","save","undo","redo","reload"],//如果haveHead=true，则定义HEAD区的按钮
	haveTool:true,
	haveGroup:true,
	useOperStack:true
};
var remark={
	cursor:"选择指针",
	direct:"转换连线",
	start:"开始结点",
	end:"结束结点",
	task:"任务结点",
	node:"自动结点",
	chat:"决策结点",
	state:"状态结点",
	plug:"附加插件",
	fork:"分支结点",
	"join":"联合结点",
	complex:"复合结点",
	group:"组织划分框编辑开关",
	multi: '多选',
	top: '上对齐',
	left: '左对齐'
};

function Mask(text){
	var body=$('body');
	if(body.children("div.waiting").length==0){	
		if(!text)text='请稍后。。。';
		$('.override').show();
		$('<div class="modal waiting" style="display:block;"><span><img src="images/throbber.gif" /><br/>'+text+'</span></div>').appendTo(body);
	}
}

function unMask(){
	var body=$('body');
	$('.override').hide();
	body.children("div.waiting").remove();
	closeModal();
}

function openModal(m){
	var body=$('body');
	$('.override').show();
	body.children("div."+m).show()
}

function closeModal(m){
	var body=$('body');
	$('.override').hide();
	if(!m){
		body.children("div.SaveModal,div.OpenModal").hide();
	}
	else
		body.children("div."+m).hide()
}

function JsonToStr(data){
	return JSON.stringify(data);
}


function StrToJson(data){
	return eval('('+data+')');
}

var Flow;
var c_node;

var MISC_URL='/code/files/misc.chi';

$(document).ready(function(){
	Flow=$.createGooFlow($("#Flow"),property);
	Flow.setNodeRemarks(remark);
	
	/*window.onresize=function(){
		$('.GooFlow_work').width($(window).width()-150);
	}*/
	
	//$('.ui').height($('#Flow').height()-38);
	Flow.onItemFocus=function(id,type){
		//Current_Item=this;
		//console.log(this.$nodeDom[id]);
		c_node=this.$nodeData[id];
		if(!c_node)c_node=this.$lineData[id];
		//c_node=this;
		//console.log(c_node);
		showProperty(c_node);
		$('#positionList').removeAttr('nodeid');
		$('#nodeText').text('未选中节点');
		if(id){			
			if(this.$nodeData[id]){
				$('#nodeText').text(this.$nodeData[id].name);
				$('#position [name="nodeid"]').val(id);
				$('#positionList').attr('nodeid',id);
			}
		}
		return true;
	};

	/*Flow.onItemDel=function(id,type){
		return confirm("确定要删除该单元吗?");
	}*/

	Flow.onBtnNewClick=function(){
		/*$('.modal h2').text('新建文件');
		$('.modal .btn').unbind('click');
		$('.modal .btn').bind('click',function(){
			Flow.clearData();
		})
		openModal();	*/
		Flow.clearData();
		Flow.setTitle('undefined');
		
	}
	
	reloadData();
	
	/*Flow.$workArea.delegate(".GooFlow_item,g","contextmenu",{inthis:Flow},function(e){
		e.data.inthis.focusItem(this.id,true);
		var p=mousePosition(e);
		//$(this).removeClass("item_mark");
		//var left = $(this).offset().left,
		//top = $(this).offset().top+10;
		$('#mmMenu').css({'left':p.x,'top':p.y});
		$('#mmMenu').show();
		return false;
	});*/
	
	reloadPosition();
	
	reloadOrganization();
	
	$('#position div[tag] input,#position div[tag] textarea').on('change',function(){
		saveDataToItem();
	});
	
	flow.initialize();
	
	$('[name="orgatype"]').click(function(){
		
		FilterPosition();
		
	});
	
});

function FilterPosition(){
	var ot=$('input[name="orgatype"]:checked').val();
	
	if(ot==1){
		$('#positionList .easyui-combotree').combotree('enable');
		var t = $('#positionList .easyui-combotree').combotree('tree');	
		var n = t.tree('getSelected');	
		$('#positionList .resList .item').each(function(){
			if(!n){
				$(this).hide();
			}
			else if($(this).attr('code')=='-1'||(n.data&&n.data.indexOf($(this).attr('code'))>=0)){
				$(this).show();
			}
			else	
				$(this).hide();
		})
	}
	else if(ot==2||ot==0||ot==4){
		$('#positionList .easyui-combotree').combotree('disable');
		$('#positionList .resList .item').each(function(){
			if($(this).attr('code')=='-1')
				$(this).hide();
			else
				$(this).show();
		})
	}
	

}

function reloadOrganization(){
	var acode=$('body').attr('acode');
	$('#positionList .easyui-combotree').width($('#position').width()-5);
	$('#positionList .easyui-combotree').combotree({
		url: MISC_URL+'?param=file&path='+acode+'/org.data',
		//required: true,
		loadFilter: function(data,parent){
			return data.root.children;
		},
		panelHeight:$('#position').height()-65,
		onChange:function(newValue, oldValue){
			FilterPosition();
		}
	});
}

function reloadData(){
	var name=$('body').attr('path');
	var wname=name;
	var param={
		type:'post',
		url:MISC_URL,
		data:{param:'file',path:name},
		mask:Mask(),
		dataFilter:function(){
		},
		success:function(data){
			unMask();
			/*if(data.success){
				Flow.setTitle(wname);
			}
			else
				alert('文件加载失败('+wname+')!');*/
			Flow.loadData(data);
			Flow.$max=data.max;
			Flow.setTitle(data.title);
			
		},
		error:function(){
			unMask();
		}
	}
	Flow.loadDataAjax(param);
}


function reloadPosition(){
	var acode=$('body').attr('acode');
	var param={
		type:'get',
		url:MISC_URL,
		data:{param:'file',path:acode+'/dept.data'},
		mask:Mask(),
		success:function(data){
			unMask();
			var li='';
			for(var i=0;i<data.length;i++){
				li+='<div code="'+data[i].code+'" class="item" style="display:none;">'+data[i].name+'['+data[i].code+']'+'</div>';
			}
			li+='<div code="-1" class="item">全部</div>';
			$('#positionList .resList').html(li);
		//	$('#position.ui').show();
			$('#positionList .resList .item').click(function(){
				var nodeid=$('#positionList').attr('nodeid');
				if(nodeid){
					Flow.$nodeData[nodeid].posi=$(this).attr("code");
					var ot=$('input[name="orgatype"]:checked').val();
					if(ot==1)
						Flow.$nodeData[nodeid].orga=$('#positionList .easyui-combotree').combotree('getValue');
					else if(ot==0)
						Flow.$nodeData[nodeid].orga='-9';                          //全部组织
					else if(ot==2)
						Flow.$nodeData[nodeid].orga='-10';                          //发起人的组织
					else if(ot==4)
						Flow.$nodeData[nodeid].orga='-8';                          //组织文字
					Flow.setName(nodeid,$(this).text(),'node');
					Flow.$nodeData[nodeid].orgText=$('#positionList input[name="orgText"]').val();
				}
			})
		},
		error:function(){
			unMask();
		}
	}
	Flow.loadDataAjax(param);
}

function saveData(){
	var name=$('body').attr('path');
	var jsondata =Flow.exportData();
	jsondata.title=name;
	jsondata.max=Flow.$max;
	var wname=name;
	var conts=JsonToStr(jsondata);
	var param={
		type:'post',
		url:MISC_URL,
		data:{param:'save',cont:conts,name:name},
		mask:Mask(),
		dataFilter:function(){
		},
		success:function(data){
			unMask();
			if(data.success){
				Flow.setTitle(wname);
			}
			else
				alert('文件保存失败('+data.code+')!');
			
		},
		error:function(){
			unMask();
		}
	}
	Flow.loadDataAjax(param);
}

function importData(that ){
	if(!that.input){
		that.input=document.createElement("input");
		that.input.type = "file";

		that.input.onchange = function(e) {
			var file = e.target.files[0];
			if (!file) { return; }

			var reader = new FileReader();
			reader.onload = function() { 
				var data=StrToJson(reader.result);
				Flow.loadData(data);
				Flow.$max=data.max;
			}
			reader.onerror = function() { console.log(reader.error); }
			reader.readAsText(file);
		}.bind(this);
	}
	that.input.click();
}

function exportData(){
	var name=$('body').attr('path');
	var si=name.indexOf('/');
	name=name.substring(si+1,name.length);
	var data =Flow.exportData();
	data.title=name;
	data.max=Flow.$max;
	var cont=JsonToStr(data);
	var link = document.createElement("a");

	link.download = name;
	link.href = "data:text/plain;base64," + btoa(unescape(encodeURIComponent(cont)));
	document.body.appendChild(link);
	link.click();
	link.parentNode.removeChild(link);
}

function showProperty(node){
	if(node){
		var t=node.type;
		if(node.from)t='line';
		var box=$('#position div[tag="'+t+'"]');
		box.find('input[type="text"]').val('');
		box.find('input[type="radio"],input[type="checkbox"]').removeAttr('checked');
		box.find('textarea').val('');
		for(var key in node){
			if(key.substring(0,1)=="_"){
				var input=box.find('[name="'+key+'"]');
				if(input.length>0){
					if(input[0].type=="checkbox"){
						if(node[key])
							input[0].checked='checked';
					}
					else if(input[0].type=="radio"){
						input=box.find('[name="'+key+'"][value="'+node[key]+'"]');
						if(input.length==1){
							input[0].checked='checked';
						}
					}
					else
						input.val(node[key]);
				}
			}
		}
		
		if(node.orga){
			if(node.orga=="-9"){
				$('#positionList [name="orgatype"][value="0"]')[0].checked=true;
			}
			else if(node.orga=="-10"){
				$('#positionList [name="orgatype"][value="2"]')[0].checked=true;
			}
			else if(node.orga=="-8"){
				$('#positionList [name="orgatype"][value="4"]')[0].checked=true;
			}
			else{
				$('#positionList [name="orgatype"][value="1"]')[0].checked=true;
				//$('#positionList .easyui-combotree').combotree('setValue',node.orga);
			}
			FilterPosition();
		}
		
		$('#positionList input[name="orgText"]').val(node.orgText);

					
		$('#position div[tag][tag!="'+t+'"]').hide();
		box.show();
	}
}


$.fn.serializeObject = function ()
{
    var o = {};
    var a = this.serializeArray();
    $.each( a, function ()
    {
        if ( o[this.name] !== undefined )
        {
            if ( !o[this.name].push )
            {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push( this.value || '' );
        }
        else
        {
            o[this.name] = this.value || '';
        }
    } );
    return o;
};

function saveDataToItem(){

	if(c_node){
		var t=c_node.type;
		if(c_node.from)t='line';
		var formItem=$('#position div[tag="'+t+'"]');
		var form=$('<form></form>');
		formItem.wrap(form);
		var data=$('#position form').serializeObject();
		formItem.unwrap();
		for(var key in c_node){
			if(key.substring(0,1)=="_"){
				delete c_node[key];
			}
		}
		for(var key in data){
			c_node[key]=data[key];
		}		
	}
}

function showTab(btn,inx){
	if(inx==0){
		$('#positionList').show();
		$('#nodeProperty').hide();
	}
	else if(inx==1){
		$('#positionList').hide();
		$('#nodeProperty').show();
	}
}

		
function exportToPng(){
	
var canvas = document.createElement('canvas');
	
canvg(canvas,'<svg>'+ $("#Flow")[0].outerHTML+'</svg>');


var img = canvas.toDataURL("image/png");

	console.log(img);
}