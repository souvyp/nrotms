var FILE_URL = '/code/files/misc.chi';
var MISC_ACCOUNT='/code/account/misc.chi';
var ORGMINDMAP = 'org.data';
var TREEMINDMAP = 'mind.zmmp';
var USERDATA = 'user.data';
var DEPARTMENTDATA = 'dept.data';
var _deptData;
var _userData={data:[]};
var _currentOrg;
var _currentContainer=1;
var _currentUser;

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

function OnlineData(param,h,url,err){
	MM.App.setThrobber(true);
	$.ajax( {
        type: "post",
        url: url?url:FILE_URL,
        data: param,
        dataType: 'json',
        success: function ( data, textStatus ){
			if(h) h(data);
			MM.App.setThrobber(false);
        },
        error: function () {
			if(err)err();
			MM.App.setThrobber(false);
        }
    } );
}

function resetMap(){
	var json = {'root':{layout: "map",text: "总公司"}};
	var map=MM.Map.fromJSON(json);
	MM.App.setMap(map);
}

$(function(){	
	$('#BtnLoad').click(function(){
		OnlineData({param:'file',path:appcode+'\\'+ORGMINDMAP},function(data){
			MM.App.setMap(MM.Map.fromJSON(data));
			MM.App.onSelect(MM.App.current);

		});		
	});
	
	$('#BtnSave').click(function(){
		var mw=MM.UI.Backend.WebDAV;
		mw._url.value='/code/files/misc.chi?param=put&name='+appcode+'\\'+ORGMINDMAP+'&center=';
		mw.save();
	})
	
	$('#BtnLoadUser').click(function(){
		var fileName=appcode+'\\'+USERDATA;
		OnlineData({param:'file',path:fileName},function(data){
			if(data&&data.data){				
				_userData=data;					
				LoadUserM(_userData.data,true);
			}
		})
	})
	
	setTimeout(function(){
		$('#BtnLoad').click();
		MakeTree();
		ReloadResM();
		$('#BtnLoadUser').click();
	},100);
	
	
	

	$('#resDelete').click(function(){
		var code=$('#resourceModal [name="code"]').val();
		for(var i=0;i<_deptData.length;i++){
			if(code==_deptData[i].code){
				_deptData.splice(i,1);
				break;
			}
		}
		LoadResM(_deptData,true);
	})
	
	MM.App.onSelect=function(item){
		if(_currentContainer==1){
			var li='<li class="active">'+item.getText()+'</li>';
			p=item;
			while(!p.isRoot()){
				p=p.getParent();
				li='<li><a href="#">'+p.getText()+'</a></li>'+li;
			}			
			$('.floatBtn ol.breadcrumb').html(li);
			_currentOrg={data:item._data,id:item._id};
		}
		
		if(item.isRoot()){
			$('#resourceLay .resList .drag input[type="checkbox"]').removeAttr('checked');
		}
		else{
			var data=item._data;
			$('#resourceLay .resList .drag').each(function(){
				var code=($(this).attr('tag'));
				if(data&&data.indexOf(code)>=0)
					$(this).find('input[type="checkbox"]')[0].checked=true;
				else
					$(this).find('input[type="checkbox"]')[0].checked=false;
			})
		}
	}
	
	$("#userDetail input[type=\"checkbox\"], #userDetail input[type=\"radio\"]").not("[data-switch-no-init]").bootstrapSwitch();
	
	$(window).resize(function() {
		$('#userList').width($(window).width()-200);
		$('#userList').height($(window).height()-100);
	});
	$(window).resize();
})

function changeContainer(obj){
	var v=$(obj).val();
	if(v!==1){
		if(MM.App.current.isRoot()){			
			alert('根节点不能设置岗位和用户!');
			setTimeout(function(){
				$('#toggleButton .active').removeClass('active');
				$('#toggleButton label:eq(0)').addClass('active');
			},100);
			return false;
		}
	}
	_currentContainer=v;	
	$('[tags]').each(function(){
		var tags=$(this).attr('tags');
		if(tags&&tags.indexOf(v)>=0)
			$(this).show();
		else	
			$(this).hide();
	});
	
	$('#help').hide();
	if(v==1){
		MM.App.onSelect(MM.App.current);
		$('#resourceLay .resList .drag input[type="checkbox"]').show();
		$('#resourceLay .resList .drag input[type="radio"]').hide();
		$('#resourceLay').hide();
	}
	if(v==2){
		$('#resourceLay .resList .drag input[type="checkbox"]').hide();
		$('#resourceLay .resList .drag input[type="radio"]').show();
		$('#resourceLay').show();
		var instance = $('#mindMapTree').jstree(true);
		instance.deselect_all();
	}
	if(v==3){
		$('#resourceLay .resList .drag input[type="checkbox"]').show();
		$('#resourceLay .resList .drag input[type="radio"]').hide();
		$('#resourceLay').show();	
	}
	FilterResM();
	FilterUserM();
	return true;
}
/**************************************************mindMap*************************************************/
function MakeTree(){
	OnlineData({param:'file',path:appcode+'\\'+TREEMINDMAP},function(data){		
		$('#mindMapTree').parent().html('<div id="mindMapTree"></div>');
		
		$('#mindMapTree')
		.on("changed.jstree", function (e, data) {
			e.preventDefault();
			if(_currentContainer==2&&data.selected.length) {
				var radio=$('#resourceLay .resList .drag input[type="radio"]:checked');
				if(radio.length==1){
					var inx=radio.parent().attr('index');
					_deptData[inx][_currentOrg.id]=data.selected;
				}
				else{
					var instance = $('#mindMapTree').jstree(true);
					instance.deselect_all();
					alert('请选择一个岗位');
				}
			}
			
		}).jstree({
			"checkbox" : {
			  "keep_selected_style" : false
			}, 
			'core' : {
				'data' : data.root,
				'force_text' : true,
				'themes' : {
					'responsive' : false,
					//'variant' : 'small',
					//'stripes' : true
				}
			},
			"plugins" : [ "checkbox" ,"wholerow" ]
		  });
	});
}

function setTreeData(obj){
	obj.checked=true;
	var inx=$(obj).parent().attr('index');
	var perm=_deptData[inx][_currentOrg.id];
	if(!perm)perm=[];
	var instance = $('#mindMapTree').jstree(true);
	instance.deselect_all();
	for(var i=0;i<perm.length;i++)
		instance.select_node(perm[i]);
}
/**************************************************resource*************************************************/
function ReloadResM(){
	OnlineData({param:'file',path:appcode+'\\'+DEPARTMENTDATA},function(data){
		_deptData = data;
		LoadResM(_deptData,true);
	})
}

function PostResM(){
	OnlineData({param:'save',path:appcode+'\\'+DEPARTMENTDATA,cont:JSON.stringify(_deptData)})
}

function SaveResM(){
	var isNew=$("#resDelete").is(":visible")==false;

	$('#resourceModal [name="code"]').removeAttr("disabled"); 
	var data=$('#resourceModal form').serializeObject();

	if(isNew){
		if(!_deptData)
			_deptData=[];
		var isExists;
		for(var i=0;i<_deptData.length;i++){
			if(data.code==_deptData[i].code){
				isExists=true;
				alert('岗位编号 :'+data.code+' 已经存在!');
				break;
			}
		}
		if(!isExists){
			_deptData.push(data);
			LoadResM([data],false);
			$('#resourceModal').modal('hide');
		}
	}
	else{
		for(var i=0;i<_deptData.length;i++){
			if(data.code==_deptData[i].code){
				_deptData[i]=data;
				break;
			}
		}
		LoadResM(_deptData,true);
	}
}

function setPositions(obj){
	var code=$(obj).parent().attr("tag");
	if(_currentContainer==3){
		if(_currentUser){
			if(!_currentUser.data.position)_currentUser.data.position=[];
			var i=_currentUser.data.position.indexOf(code);
			if(obj.checked){
				if(i<0)_currentUser.data.position.push(code);
			}
			else if(i>=0){
				_currentUser.data.position.splice(i,1);
			}				
		}else{
			obj.checked=false; 
			alert('请选择一个用户!');
		}
	}
	else{
		if(MM.App.current.isRoot()){
			obj.checked=false; 
			alert('根节点不能设置岗位!');
		}
		else{
			var data=MM.App.current._data;
			if(!data)data=[];
			
			var i=data.indexOf(code);
			if(obj.checked){
				if(i<0)data.push(code);
			}
			else if(i>=0){
				data.splice(i,1);
			}
			MM.App.current._data=data;
		}
	}
}

function FilterResM(){
	if(_currentContainer==1){
		$('#resourceLay .resList .drag').show();
	}
	else{
		$('#resourceLay .resList .drag').hide();
		if(_currentOrg){
			var data=_currentOrg.data;
			if(data)
				for(var i=0;i<data.length;i++){
					var obj=$('#resourceLay .resList .drag[tag="'+data[i]+'"]');
					obj.show();
					obj.find('input').each(function(){
						this.checked=false;
					});
				}
		}
	}
}

function LoadResM(data,clear){
	if(data){
		if(clear)
			$('#resourceLay .resList').html('');
		var span='';
		for(var i=0;i<data.length;i++){
			span+='<div class="drag" tag="'+data[i].code+'" index="'+i+'"><input type="radio" name="dragSelect" onclick="setTreeData(this)" style="vertical-align: middle;display:none;width:16px;height:16px;"/> <input type="checkbox" style="vertical-align: middle;width:16px;height:16px;margin-right:6px;" onclick="setPositions(this)"/><span onclick="showResM(this)" style="vertical-align: middle;" code="'+data[i].code+'" note="'+escape(data[i].note)+'">'+data[i].name+'</span></div>';
		}
		var sp=$(span);
		$('#resourceLay .resList').append(sp);
		FilterResM();
	}
}

function NewResM(){
	$('#resourceModal form')[0].reset();
	$('#resDelete').hide();
	$('#resourceModal [name="code"]').removeAttr("disabled"); 
	$('#resourceModal').modal('show');
}

function showResM(obj){
	if(_currentContainer==1){
		$('#resourceModal [name="code"]').val($(obj).attr('code'));
		$('#resourceModal [name="code"]').attr("disabled","disabled"); 
		$('#resourceModal [name="name"]').val($(obj).text());
		$('#resourceModal [name="note"]').val(unescape($(obj).attr('note')));
		$('#resDelete').show();
		$('#resourceModal').modal('show');
	}
	else if(_currentContainer==2){	
		$(obj).prev().prev()[0].checked=!$(obj).prev().prev()[0].checked;
		setTreeData($(obj).prev().prev()[0]);
	}
	else if(_currentContainer==3){
		$(obj).prev()[0].checked=!$(obj).prev()[0].checked;
		setPositions($(obj).prev()[0]);
	}
}


/**************************************************user*************************************************/
function FilterUserM(){
	if(_currentContainer==3){
		_currentUser=null;
		$('#userList .tiles-wrap li.active').removeClass("active");
		$('#userList ul li').each(function(){
			var org=$(this).attr('data-org');
			if(_currentOrg.id!==org)
				$(this).hide();
			else	
				$(this).show();
		});
	}
}

function LoadUserM(data,clear){
	var li='';
	if(clear)
		$('#userList ul').html('');
	if(data){
		for(var i=0;i<data.length;i++){
			var vis="";
			if(data[i].org&&data[i].org!==_currentOrg.id)vis='style="display:none;"';
			li+='<li data-code="'+data[i].code+'" data-name="'+data[i].name+'" data-org="'+data[i].org+'" onclick="activeUser(this)" '+vis+'>';
			var photo=data[i].photo;
			if(!photo)photo='icons/user.png';
			li+='<div><img src="'+photo+'" style="min-width:64px;max-width:150px;min-height:64px;max-height:150px;" /></div>';
			li+='<a href="#userDetail" data-toggle="modal" href="#userDetail" onclick="newUserMM(this);">';
			li+=data[i].name+'['+data[i].code+']'+'</a><br />';
			if(data[i].datasrc){
				if(isArray(data[i].datasrc)){
					for(var j=0;j<data[i].datasrc.length;j++){
						if(data[i].datatarget[j]){
							if(j>0)li+='<br />';
							li+=data[i].datatarget[j]+'['+data[i].datasrc[j]+']';
						}
					}
				}
			}
			if(data[i].datatarget)
				li+=data[i].datatarget+'['+data[i].datasrc+']';
			li+='<span class="closeBtn" onclick="DeleteUser(this)">&nbsp;</span>';
			li+='<span class="imageBtn"><div style="position:relative;height: 24px;"> <input type="file"  class="Fileinput" style="width:24px;" title="" /></span></div></li>';
		}
		$('#userList ul').html(li);
		if(li!==""){
			activeUser($('#userList ul li:eq(0)'));
			$('#resourceLay .resList .drag input[type="checkbox"]').removeAttr('disabled');
		}else	
			$('#resourceLay .resList .drag input[type="checkbox"]').attr('disabled','disabled');
		
		$('#userList .Fileinput').on('change',function(){
			var that=$(this);
			var li=that.parent().parent().parent();
			activeUser(li);
			readImgFile(that[0],function(data){
				li.find('img').attr('src',data);
				ChangeUserProp(li.attr('data-code'),'photo',data);
			});
		})
	}
}



function getUserData(code){
	var data;
	for(var i=0;i<_userData.data.length;i++){
		if(code==_userData.data[i].code){
			data=_userData.data[i];
			break;
		}
	}
	return {data:data,index:i};
}

function saveUserDetail(){
	if(!_userData)_userData={data:[],maxID:0};
	var isExists;

	var data=$('#userDetail form').serializeObject();
	var iData=getUserData(data.code);
	var isNew=$('#userDetail').attr('isNew')!=="1";
	
	if(isNew){
		isExists=iData?true:false;
		if(iData.data)
			alert('用户编号 :'+data.code+' 已经存在!');
		else{
			data.org=_currentOrg.id;
			_userData.maxID = _userData.maxID?_userData.maxID+1:1;
			data.id=_userData.maxID;
			_userData.data.push(data);
			LoadUserM(_userData.data,true);
			$('#userDetail').modal('hide');
		}
	}
	else{
		data.org=_currentOrg.id;
		data.photo=iData.data.photo;
		data.position=iData.data.position;
		_userData.data.splice(iData.index,1,data);
		LoadUserM(_userData.data,true);
		$('#userDetail').modal('hide');
	}	
}
function newUserMM(obj){
	clearDataTemplate('userDetail');
	if(!obj) 
		$('#userDetail').removeAttr('isNew');
	else{
		$('#userDetail').attr('isNew','1');
		var code=$(obj).parent().attr('data-code');
		var data=getUserData(code);
		data=data.data;
		$('#userDetail .modal-header h4 label').text(data.id);
		for(var key in data){
			if(key=="datasrc"){
				var src=data.datasrc;
				var tag=data.datatarget;
				if(!isArray(src)){
					src=[src];
					tag=[tag];
				}
				var row;
				for(var i=0;i<src.length;i++){						
					if(i==0)
						row=$('#userDetail .dataInput');
					else
						row=newDataTemplate(row.find('.col-sm-3'),true);
					row.find('input[name="datasrc"]').val(src[i]);
					row.find('input[name="datatarget"]').val(tag[i]);
				}
			}
			else if(key!=="datatarget")
				$('#userDetail [name="'+key+'"]').val(data[key]);
		}
		if(data.status)
			$('#userDetail input[type="checkbox"]')[0].checked=true;
	}
}

function saveUserData(){
	OnlineData({param:'save',path:appcode+'\\'+USERDATA,cont:JSON.stringify(_userData)})
}

function DeleteUser(obj){
	var code=$(obj).parent().attr('data-code');
	var data=getUserData(code);
	if(data){
		_userData.data.splice(data.index,1);
		$('#userList .tiles-wrap li[data-code="'+code+'"]').remove();
	}	
}

function activeUser(obj){
	$('#userList .tiles-wrap li.active').removeClass("active");
	$(obj).addClass('active');
	var code=$(obj).attr('data-code');
	var inx=$(obj).attr('index');
	_currentUser=getUserData(code);
	if(_currentUser&&_currentUser.data){
		var position=_currentUser.data.position;
		$('#resourceLay .resList .drag input[type="checkbox"]').removeAttr('checked');
		if(position){
			
			$('#resourceLay .resList .drag').each(function(){
				var code=($(this).attr('tag'));
				if(position.indexOf(code)>=0)
					$(this).find('input[type="checkbox"]')[0].checked=true;
				else
					$(this).find('input[type="checkbox"]')[0].checked=false;
			})
		}
	}
}

function isArray(v){
	return toString.apply(v) === '[object Array]';
}  

function ChangeUserProp(code,prop,val){
	var iData=getUserData(code);
	if(iData.data)
		iData.data[prop]=val;
}


function applyUserData(){
	OnlineData({param:'save',path:appcode+'\\'+USERDATA,cont:JSON.stringify(_userData)})
}

/**************************************************template*************************************************/


function newDataTemplate(obj,aft){
	var row=$(obj).parents(".dataInput");
	var nrow=row.clone();
	if(aft)
		row.after(nrow);
	else
		row.before(nrow);
	return nrow;
}

function delDataTemplate(obj){
	var row=$(obj).parents(".dataInput");
	if(row.parent().children(".dataInput").length>1){		
		row.remove();
	}
}

function clearDataTemplate(iid){
	var box=$('#'+iid);
	$('#'+iid+' form')[0].reset();
	box.find('input[name="dataBtn"]').button('reset');
	box.find('input[name="editBtn"]').button('reset');
	var rows=$('#'+iid+' .dataInput');
	for(var i=0;i<rows.length;i++){
		if(i==0)
			rows.find('input[name="target"]').val('');
		else 
			rows.eq(i).remove();
	}
	
}

function clearPermision(){
	alert('清除所有权限');
}