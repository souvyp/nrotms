//序列化表单
( function ( $ )
{
    $.fn.serializeJson = function ()
    {
        var serializeObj = {};
        var array = this.serializeArray();
        var str = this.serialize();
        $( array ).each( function ()
        {
            if ( serializeObj[this.name] )
            {
                if ( $.isArray( serializeObj[this.name] ) )
                {
                    serializeObj[this.name].push( this.value );
                } else
                {
                    serializeObj[this.name] = [serializeObj[this.name], this.value];
                }
            } else
            {
                serializeObj[this.name] = this.value;
            }
        } );
        return serializeObj;
    };
} )( jQuery );


$( function ()
{
    makeNavs( function ()
    {
		var TooltipController;
		$('.sidebar-title').on('mouseenter', function (e) 
		{
			var offset = $(this).offset();
			//var name = $(e)[0].target.textContent;//获取 nav 名称
			var name = $(this).find('span.sidebar-title-text').text();
			offsetX = offset.left;//获取位置
			offsetY = offset.top;//获取位置
			TooltipController = showTooltip(offsetX, offsetY, name); //显示
		}).on('mouseleave', function () 
		{
			hideTooltip(TooltipController);//关闭
		});	
	
		//获取当前系统时间附加到 input 框 
		var now = new Date();										
		var year = now.getFullYear();       //年
		var month = now.getMonth() + 1;     //月
		var day = now.getDate();     
		$('input[name="date"]').val(year+'-'+month+'-'+day);	
    } );

    $( '.save' ).click( function ()
    {
        var CompanyID = $( 'input[name="CompanyID"]' ).val();
        var Accept = $( 'input[name="Accept"]' ).val();
        var AdminAccount = $( "input[name='AdminAccount']" ).val();
        var AdminPwd = $( "input[name='AdminPwd']" ).val();
        var ReAdminPwd = $( "input[name='ReAdminPwd']" ).val();
        var AdminName = $( "input[name='AdminName']" ).val();
        if ( AdminAccount == "" )
        {
            alert( "用户名不能为空！" );
        }
        else if ( AdminPwd == '' )
        {
            alert( "密码不能为空!" );
        }
        else if ( AdminAccount == "" )
        {
            alert( "用户名不能为空！" );
        }
        else if ( AdminPwd != ReAdminPwd )
        {
            alert( "两次输入的密码不一致，请重新输入" );
            $( "input[name='ReAdminPwd']" ).val( '' );
        }
        else
        {
            DoUserRegister( CompanyID, Accept, AdminAccount, AdminPwd, AdminName, _UserRegisterComplete );
        }
    } );

    $( 'div[class="dropdown topbar-notice topbar-btn topbar-left"]' ).on( 'click', function ()
    {
        if ( $( this ).attr( 'class' ).indexOf( 'open' ) == -1 )
        {
            $( 'ul[name="MyEvents"]' ).attr( 'view-id', '{ id:"tms_0080",cross:"false", rowIdentClass:"MyEvents", paras:[{"name":"Amount","value":4}]}' );
            var _myEvents = new NSF.System.Data.Grid();
            _myEvents.Pagination( "first-ds-pag", $( "div[name='first-ds-pag']" ) );
            _myEvents.Initialize( "/", "MyEvents", $( "ul[name='MyEvents']" ).attr( "view-id" ), $( "ul[name='MyEvents']" ) );

            $( 'ul[class="MyEvents"]' ).each( function ()
            {
                var _Event;
                var _Event_Type = $( this ).find( 'span[name="Event_Type"]' ).text();
                var _Event_SrcCompanyName = $( this ).find( 'span[name="Event_SrcCompanyName"]' ).text();
                var _Event_DstCompanyName = $( this ).find( 'span[name="Event_DstCompanyName"]' ).text();
                var _Event_Ext = $( this ).find( 'span[name="Event_Ext"]' ).text();
                var _Event_Result = $( this ).find( 'span[name="Event_Result"]' ).text();

                if ( _Event_Type == '1' )
                {
                    _Event = _Event_DstCompanyName + '被邀请成为承运商';
                    $( this ).find( 'a' ).attr( 'href', '/BeInvite.aspx' );
                }
                else if ( _Event_Type == '2' )
                {
                    if ( _Event_Result == '0' )
                    {
                        _Event = '邀请' + _Event_SrcCompanyName + '成为承运商被接受';
                        $( this ).find( 'a' ).attr( 'href', '/SupplierList.aspx' );
                    }
                    else
                    {
                        _Event = '邀请' + _Event_SrcCompanyName + '成为承运商被拒绝';
                        $( this ).find( 'a' ).attr( 'href', '/Invite.aspx' );
                    }
                }
                else if ( _Event_Type == '3' )
                {
                    _Event = '待接收订单：' + _Event_Ext;
                    $( this ).find( 'a' ).attr( 'href', '/OrderAccept.aspx' );
                }
                else if ( _Event_Type == '4' )
                {
                    _Event = '被拒绝的订单：' + _Event_Ext;
                    $( this ).find( 'a' ).attr( 'href', '/OrderSend.aspx' );
                }
                else if ( _Event_Type == '5' )
                {
                    _Event = '订单有新的异常费用产生：' + _Event_Ext;
                    $( this ).find( 'a' ).attr( 'href', '/Index_edit.aspx?id=' + _Event_Ext + '.aspx' );
                }
                else if ( _Event_Type == '6' )
                {
                    _Event = '订单有新的附加费用产生：' + _Event_Ext;
                    $( this ).find( 'a' ).attr( 'href', '/Index_edit.aspx?id=' + _Event_Ext + '.aspx' );
                }
                $( this ).find( 'span[name="Event"]' ).text( _Event );
            } );
            GetAmount();
        }

    } );
} );

function GetAmount()
{
    NSF.System.Data.RecordSet( "/", { id: "tms_0086", cross: "false", paras: [] }, function ( result, config, data )
    {
        $( 'span[class="topbar-btn-notice-num"]' ).text( data[0].rows[0].Event_Count );

    } );

}

//管理员注册，公司审核  同意
//function Comfirm( CompanyID )
//{
//    $( '#win-Common-Dialog' ).modal( 'show' );
//    $( 'input[name="CompanyID"]' ).val( CompanyID );
//    $( 'input[name="Accept"]' ).val( 1 );

//}
//不同意
//function ComfirmNo( CompanyID )
//{
//    $( '#win-Common-Dialog' ).modal( 'show' );
//    $( 'input[name="CompanyID"]' ).val( CompanyID );
//    $( 'input[name="Accept"]' ).val( 0 );
//}

//注册
function GetUserRegister( CompanyID, Accept, AdminAccount, AdminPwd, AdminName )
{
    var params = [{}];
    params[0].namespace = 'protocol';
    params[0].cmd = 'data';
    params[0].version = 1;
    params[0].id = 'tms_0070';

    var _Reg = [{}, {}, {}, {}, {}];
    _Reg[0].name = 'CompanyID';
    _Reg[0].value = CompanyID;
    _Reg[1].name = 'Accept';
    _Reg[1].value = Accept;
    _Reg[2].name = 'AdminAccount';
    _Reg[2].value = AdminAccount;
    _Reg[3].name = 'AdminPwd';
    _Reg[3].value = AdminPwd;
    _Reg[4].name = 'AdminName';
    _Reg[4].value = AdminName;
    
    params[0].paras = _Reg;

    var Reg_ToString = NSF.System.Json.ToString( params );
    return Reg_ToString;
}

function DoUserRegister( CompanyID, Accept, AdminAccount, AdminPwd, AdminName, callback )
{
    NSF.System.Network.Ajax( '/Portal.aspx',
        GetUserRegister( CompanyID, Accept, AdminAccount, AdminPwd, AdminName ),
        'POST',
        false,
        callback
        );
}

function _UserRegisterComplete( result, data )
{
    if ( data[0].result )
    {
        Result( data[0] );
    }
    else
    {
        alert( data[0].msg );
    }
}




function hideTooltip(item) //关闭 nav 文字提示
{
	if (item != false) 
	{
	  item.remove();
	}
}
function showTooltip(X,Y,name) //打开 nav 文字提示
{
	var TooltipHtml = '<div class="aliyun-console-sidebar-tooltip right fade in animateTooltip" style="left:' + (parseInt(X) + 50) + 'px;top: ' + (parseInt(Y)+10) + 'px; z-index:100001;display: block">' +
	'<div class="tooltip-arrow"></div>' +
	'<div class="tooltip-inner">' + name + '</div>' +
	'</div>';
	var TooltipNode = $(TooltipHtml);
	$('body').append(TooltipNode);
	return TooltipNode;
}
//二级nav收缩
function collapseNavbar()
{
	var clickStyle = $('div[click-class]').attr('click-class');
	var style = $('div[click-class]').hasClass(clickStyle);
	if(style)
	{
		$('div[click-class="viewFramework-product-col-1"]').removeClass(clickStyle);
	}
	else
	{
		$('div[click-class="viewFramework-product-col-1"]').addClass(clickStyle);
	}
}

function toggleFoldStatus(e)
{
	var style = $(e).hasClass('sidebar-nav-fold');
	if(style)
	{
		$(e).removeClass('sidebar-nav-fold');
	}
	else
	{		
		$(e).addClass('sidebar-nav-fold');
	}
}

//伪树形收缩
function treeMous(e)
{
	var style = 'ng-hide';
	var YN = $(e).parent().next().hasClass(style);
	$(e).find('span').attr('class','');
	if(YN)
	{
		$(e).parent().next().removeClass(style);
		$(e).find('span').addClass('icon-up');
	}
	else
	{
		$(e).parent().next().addClass(style);
		$(e).find('span').addClass('icon-down');
	}
}


function makeNavs(_handle){
   /* GetContent('/users/licifeng/sysman/mind.zmmp',{},'json',false,function(data){
        var data=data.root;
        var center;
        for(var i=0;i<data.children.length;i++){
        	if(data.children[i].id=="usercenter"){
        		center=data.children[i];
        		break;
        	}
        }
        if(center){
			var _sys;
			for(var i=0;i<center.children.length;i++){
				if(center.children[i].id=="system"){
					_sys=center.children[i];
					break;
				}
			}
			if(_sys)
				makeLeftNav(_sys);
		}
        if(_handle)_handle();
    })*/
    //动态生成左侧菜单
    $.get( MENU_DEF_ZMMP, function ( root )
    {
        var data = root.root.children[0].children;
        if ( data )
        {
            if ( $( 'div[class="sidebar-nav main-nav"]' ).find( 'div' ).length == 0 )
            {
                makeLeftNav( data );
            }

        }
        if ( _handle ) _handle();
    } );
	/*var data  = store.get('_data');
	if(data)
		makeLeftNav(data);
	if(_handle)_handle();*/
}


function makeLeftNav( data )
{
    var _code = $( 'body' ).attr( 'code' );
    //生成一级菜单

    for ( var i = 0; i < data.length; i++ )
    {
        var _div;
        var _li;
        if ( JsonToStr( data[i] ).indexOf( _code ) != -1 )
        {
            _div = '<div class="sidebar-title" style="background-color:#f27302;height:60px;">';
            //增加头部的菜单---三刀
            _li = '<li class="actives">';
        }
        else
        {
            _div = '<div class="sidebar-title" style="height:60px;">';
            _li = '<li class="">';
        }

        if ( typeof ( data[i].others[1] ) != 'undefined' )
        {
            
            _div += '<a href="' + data[i].others[1] + '.aspx">';
            _li += '<a href="' + data[i].others[1] + '.aspx"><hr class="menu-class" style="display:none;" />';
        }
        else
        {
            _div += '<a>';
            
        }
        _div += '<div class="sidebar-title-inner ng-scope left-menu">';

        if ( typeof ( data[i].others[0] ) != 'undefined' )
        {
            _div += '<p style="margin-bottom:0; text-align:center;"><span style="margin-left:0;" class="center glyphicon ' + data[i].others[0] + ' icon"></span></p><p style="color:white; font-size:12px;margin-top:5px;text-align:center">' + data[i].thumbText + '</p>';
        }
        else
        {
            _div += '<span class="center glyphicon  icon"></span>';
        }
           
        _div += '<span class="sidebar-title-text ng-binding">' + data[i].text + '</span>';
        _div += '</div></a></div>';
        _li += data[i].text +'</a>';

        $( 'div[class="sidebar-nav main-nav"]' ).append( _div );
        $( '.topbar_nav' ).append( _li );
    }

    for ( var i = 0; i < data.length; i++ )
    {
        var _secondMenu = data[i].children;
        if ( typeof ( _secondMenu ) != 'undefined' )
        {
            if ( JsonToStr( data[i] ).indexOf( _code ) != -1 )
            {
                //生成二级菜单
                SecondNode( _secondMenu, _code, data[i].text );
            }
        }
    }

    var TooltipController;
    $( '.sidebar-title' ).on( 'mouseenter', function ( e )
    {
        var offset = $( this ).offset();
        //var name = $( e )[0].target.textContent;//获取 nav 名称
        var name = $(this).find('span.sidebar-title-text').text();
        offsetX = offset.left;//获取位置
        offsetY = offset.top;//获取位置
        TooltipController = showTooltip( offsetX, offsetY, name ); //显示
    } ).on( 'mouseleave', function ()
    {
        hideTooltip( TooltipController );//关闭
    } );
       
}
function SecondNode( _secondMenu, _code, title )
{
    for ( var j = 0; j < _secondMenu.length; j++ )
    {
        if ( j == 0 )
        {
            _div = '<div class="panel-heading product-nav-title ng-binding"><h4 style="font-family:inhreit;font-weight:bold; font-size:16px;color:#666;padding-left:12px; line-height:35px;">' + title + '</h4></div><div class="panel-body nav-title ng-binding menuThird" ><h4 class="panel-title"><a data-toggle="collapse" class="thirdNode" style="font-weight:bold;color:#555;"';
        }
        else
        {
            _div = '<div class="panel-body nav-title ng-binding menuThird" ><h4 class="panel-title"><a data-toggle="collapse" class="thirdNode" style="font-weight:bold; color:#555;"';
        }

        var _thirdMenu = _secondMenu[j].children;

        if ( typeof ( _thirdMenu ) != 'undefined' )
        {
            _div += 'href="#' + _secondMenu[j].id + '">' + _secondMenu[j].text + '<span class="icon-arrow-down"></span>' + '</a></h4></div>';

            for ( var k = 0; k < _thirdMenu.length; k++ )
            {
                if ( typeof ( _thirdMenu[k].others ) != 'undefined' )
                {
                    _div += ' <div id="' + _thirdMenu[k].others[0] + '" class="panel-collapse collapse in  nav-title ng-binding" style="background-color:#f1f1f1;">';
                    if ( typeof ( _thirdMenu[k].others[1] ) != 'undefined' )
                    {
                        _div += '<div class="panel-body nav-title ng-binding menuThird"><a class="thirdNode" href="' + _thirdMenu[k].others[1] + '">'+'&nbsp;&nbsp;&nbsp;'+ _thirdMenu[k].text + '</a></div>';
                    }
                    else
                    {
                        _div += '<div class="panel-body menuThird"><a class="thirdNode" href="javascript:void(0)">' + '&nbsp;&nbsp;&nbsp;'+_thirdMenu[k].text + '</a></div>';
                    }
                }
            }

            _div += '</div>';
        }
        else
        {
            _div += 'href="#' + _secondMenu[j].id + '">' + _secondMenu[j].text + '' + '</a></h4></div>';
        }

        $( 'div[class="product-nav-scene product-nav-main-scene"]' ).append( _div );

        if ( typeof ( _thirdMenu ) == 'undefined' )
        {
            if ( typeof ( _secondMenu[j].others ) != 'undefined' )
            {
                $( 'a[href="#' + _secondMenu[j].id + '"]' ).attr( 'href', '' + _secondMenu[j].others[0] + '' );


                $( 'div[class="panel-body nav-title ng-binding menuThird"]' ).each( function ()
                {
                    if ( $( this ).find( 'a' ).attr( 'href' ) == location.href.split( '/' )[3] )
                    {
                        $( this ).attr( 'style', "background-color:white" );
                    }
                    if ( $( this ).find( 'a' ).attr( 'href' ).indexOf( '.aspx' ) != -1 )
                    {
                        $( this ).find( 'a' ).removeAttr( 'data-toggle' );
                    }

                } );
            }
        }
    }


    $( 'a[class="thirdNode"]' ).each( function ()
    {
        if ( $( 'body' ).attr( 'code' ) == $( this ).attr( 'href' ).split( '.' )[0] )
        {
            $( this ).closest( '.menuThird' ).addClass( 'active' );
        }
        if ( $( 'li[class="actives"]' ).find( 'a' ).attr( 'href' ).split( '.' )[0] == $( this ).attr( 'href' ).split( '.' )[0]
            || '#' + $( 'li[class="actives"]' ).find( 'a' ).attr( 'href' ).split( '.' )[0] == $( this ).attr( 'href' ).split( '.' )[0] )
        {
            $( 'li[class="actives"]' ).find( '.menu-class' ).show();
        }
    } );

}

function Exit()
{
    DoLoginOut( _LogoutComplete );

    return false;
}



//function makeLeftNav(data){
//    var li='';
//	var levelTwoNode;
//	var code=$('body').attr('code');
//	for(var i=0;i<data.children.length;i++){
//		var child=data.children[i];
//	 	li+='<div class="sidebar-nav main-nav" onclick="toggleFoldStatus(this)">'+
//	                    '<div class="sidebar-title sidebarone">'+
//	                        '<div class="sidebar-title-inner ng-scope">'+
//	                            '<span class="sidebar-title-icon icon-arrow-down"></span>'+
//								'<span class="sidebar-title-text ng-binding">'+child.text+'</span>'+                                							
//	                        '</div>'+
//	                    '</div><ul>';
//	    if(child.children){
//		    for(var j=0;j<child.children.length;j++){	
//				var fnode=child.children[j];
//		    	var icon=fnode.others;
//		    	if(icon)icon=icon["0"];
//				if(fnode.id==code)levelTwoNode = child.children[j];
//		    	icon=icon?icon:'glyphicon-file';
//				li+='<li class="sidebar-title"><a href="../'+fnode.id+'/"><div class="sidebar-title-inner ng-scope">'+									
//					    '<span class="glyphicon '+icon+' icon"></span><span class="sidebar-title-text ng-binding">'+
//					    fnode.text+'</span></div></a></li>';			
//		    }
//		    }
	    
//		li+='</ul></div>';
//    }
//    $('.sidebar-content').html(li);
//	if(levelTwoNode&&levelTwoNode.children){
//		var two='';
//		for(var i=0;i<levelTwoNode.children.length;i++){
//			var othersNode=levelTwoNode.children[i].others;
//			var others='';
//			if(othersNode){
//				others=othersNode['12'];
//				if(!others){
//					others=othersNode['0'];
//					if(others){
//						others='RefreshData('+others+')';
//					}
//				}
//			}
			
//			two+='<li><a href="javascript:void(0);" ev="'+escape(others)+'"';
//			if(i==0)two+=' class="active"';
//			two+=' onclick="FilterList(this,\''+levelTwoNode.children[i].id+'\');">';
//			two+='<div class="nav-icon"></div>';
//			two+='<div class="nav-title">'+levelTwoNode.children[i].text+'</div>';
//			two+='</a></li>';     
//		}
//		$('#nav-two-level').html(two);
//	}
//	else
//		$('#nav-two-level li:eq(0) a .nav-title').text(document.title);
//}

function FilterList(obj,iid){
	$(obj).closest('ul').find('a.active').removeClass('active');
	$(obj).addClass('active');
	var execScript=$(obj).attr('ev');
	if(execScript){
		execScript= unescape(execScript);		
		try{
			eval(execScript);
			$('#demo').show();
			$('.formcontainer').hide();
		}
		catch(e){
			console.log(e);
		}
	}
}

//修改用户密码
function UpdatePwdSave()
{
    var Username = $( 'input[name="Username"]' ).val();
    var OldPwd = $( 'input[name="OldPwd"]' ).val();
    var NewPwd = $( 'input[name="NewPwd"]' ).val();
    var ReOldPwd = $( 'input[name="ReOldPwd"]' ).val();

    if ( NewPwd != ReOldPwd )
    {
        alert( "两次输入的密码不一致，请重新输入!" );
    }
    else if ( Username == "" )
    {
        alert( "用户名不能为空！" );
    }
    else
    {
        DoUserPwd( Username, OldPwd, NewPwd, _UserUpdatePwd );
    };
    
}
function GetUpdatePwd( Username, OldPwd, NewPwd )
{
    var params = [{}];
    params[0].namespace = 'protocol';
    params[0].cmd = 'data';
    params[0].version = 1;
    params[0].id = 'tms_0058';

    var _Reg = [{}, {}, {}];
    _Reg[0].name = 'Username';
    _Reg[0].value = Username;
    _Reg[1].name = 'OldPwd';
    _Reg[1].value = OldPwd;
    _Reg[2].name = 'NewPwd';
    _Reg[2].value = NewPwd;

    params[0].paras = _Reg;

    var Reg_ToString = NSF.System.Json.ToString( params );
    return Reg_ToString;
}

function DoUserPwd( Username, OldPwd, NewPwd, callback )
{
    NSF.System.Network.Ajax( '/Portal.aspx',
        GetUpdatePwd( Username, OldPwd, NewPwd ),
        'POST',
        false,
        callback
        );
}

function _UserUpdatePwd( result, data )
{
    if ( data[0].result )
    {
        Result( data[0] );
    }
    else
    {
        alert( data[0].msg );
    }
}

//重置用户名，管理员密码
function ReUserPwd()
{
    var Username = $( 'input[name="Username"]' ).val();
    var Pwd = $( 'input[name="Pwd"]' ).val();

    DoRePwd( Username, Pwd, _UserUpdatePwd )
}

function GetRePwd( Username, Pwd )
{
    var params = [{}];
    params[0].namespace = 'protocol';
    params[0].cmd = 'data';
    params[0].version = 1;
    params[0].id = 'tms_0059';

    var _Reg = [{}, {}];
    _Reg[0].name = 'Username';
    _Reg[0].value = Username;
    _Reg[1].name = 'Pwd';
    _Reg[1].value = Pwd;

    params[0].paras = _Reg;

    var Reg_ToString = NSF.System.Json.ToString( params );
    return Reg_ToString;
}

function DoRePwd( Username, Pwd, callback )
{
    NSF.System.Network.Ajax( '/Portal.aspx',
        GetRePwd( Username, Pwd ),
        'POST',
        false,
        callback
        );
}


