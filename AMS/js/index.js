/*拖动效果*/
$('.modal-footer').on('mousedown',function( event ){
    drag(this.parentNode,event);
});
//列表页按回车筛选按钮
document.onkeydown=function(event){
var e = event || window.event || arguments.callee.caller.arguments[0];
    if(e && e.keyCode==13)
    { 
        event.target.value = event.target.value.replace(/(^\s*)|(\s*$)/g, "");
        if ($('body').attr('code') == 'ShutOrders') {
            $('input[data-path="Code"]').val($('input[data-path="Code"]').val().replace(/(^\s*)|(\s*$)/g, "").split('-')[0]);
        }
        $('#demo .text-filter-box button').click();
    }
};
//列表页单击按钮去空格
document.onmousedown = function( event ){
    $(event.target.parentElement.parentElement).find('div.text-filter-box').each( function(){
        $(this).find('input').val(  $(this).find('input').val().replace(/(^\s*)|(\s*$)/g, "") );
        if ($('body').attr('code') == 'ShutOrders') {
            $('input[data-path="Code"]').val($('input[data-path="Code"]').val().replace(/(^\s*)|(\s*$)/g, "").split('-')[0]);
            //$(this).find('input').val(  $(this).find('input').val().replace(/(^\s*)|(\s*$)/g, "").split('-')[0] );
        }
    });
}

function resizeTable() {
    if ($("#demoList").length == 0) {
        return;
    }
    else {
        $("#demoList").colResizable({ liveDrag: true });    //拖动列宽

        resizeCols = clearInterval(resizeCols);
    }
}
function resizeTable_x() {
    if ($(".demoList").length == 0) {
        return;
    }
    else {
        $(".demoList").colResizable({ liveDrag: true });    //拖动列宽
         
        resizeCols = clearInterval(resizeCols);
    }
}

//调整列表宽度
document.onmouseover = function() {
    resizeTable_x();
    resizeTable();    
};
//一般用户注册表单提交
function UserAdd( obj )
{
 
	var _sum = 0;
	$( 'input[name="RoleID_id"]:checked' ).each( function (index)
	{
		_sum |= $( this ).val();
	        
	} );
	
	$( 'input[name="RoleID"]' ).val( _sum );
		
 

	    var table = $(obj).closest('table');
	
	    SaveFormDataNDT(table, $(obj), __saveNdtCfg);  //保存用户信息		
	 
}

//修改密码
function ChangePwd( obj )
{
    var that = this;
    var _execute = $( _btn ).attr( 'ev' );
    _execute = unescape( _execute );

    var Username = $( 'input[name="Username"]' ).val();
    var OldPwd = $( 'input[name="OldPwd"]' ).val();
    var NewPwd = $( "input[name='NewPwd']" ).val();
    var ReOldPwd = $( "input[name='ReOldPwd']" ).val();
    if ( OldPwd == '' )
    {
        alert( "原密码不能为空!" );
    }
    else if ( Username == "" )
    {
        alert( "用户名不能为空！" );
    }
    else if ( NewPwd != ReOldPwd )
    {
        alert( "两次输入的密码不一致，请重新输入!" );
    }
    else
    {
        var ws = makeDefaultEvent( _execute );
        try
        {
            eval( ws );
        }
        catch ( e )
        {
            console.log( e );
        }
    }

}

function back()
{
    location.href = document.referrer;
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
	else if( OldPwd == NewPwd || OldPwd == ReOldPwd )
	{
		alert("原密码与新密码相同，请重新输入！");
	}
    else
    {
        DoUserPwd( Username, OldPwd, NewPwd, _UserUpdatePwd );
    }

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

//用户新增
function userAdd()
{

	var _code = $( 'body' ).attr( 'code' );
	
	if (_code)
	{
		location.href = _code + '_Add.aspx';
	}
	
	return;
}

//显示错误代码
function Result( _ret )
{
    var _recalVal;
    
    var _result = {  
    	"Pwd_Result": "0", 
    	"Company_Result": "0", 
    	"User_Result": "0", 
    	"Refresh_Result":"", 
    	"EOD_Result":"", 
    	"Price_Result":"", 
    	"Group_Result":"",
    	"Back_Result": "0",
    	"API_Result":"",
        "GroupCompanyEOD_Result":'',
        'OuteZone_Result':''
    };
    	
    var _msg = {
        "-510001001": "序列号生成失败", "-510001002": "公司名是否重复", "-510001003": "新增公司失败",
        "-510002000": "只有管理员有权执行该操作", "-510002001": "没有找到对应公司或公司已被审核", "-510002002": "审核公司失败", "-510002003": "管理员账号是否已经存在", "-510002004": "添加管理员账号失败",
        "-510003001": "参数错误", "-510003002": "账号不存在", "-510003003": "账号密码与原始密码不匹配",
        "-510004001": "参数错误", "-510004002": "账号不存在", "-510004003": "只有系统管理员能重置公司管理员的密码", "-510004004": "公司管理员能重置其他用户的密码", "-510004005": "编辑密码失败",
        "-510005001": "不能添加公司管理员",
        "-510005002": "只有公司管理员才能添加用户", 
        "-510005003": "用户是否已经存在", 
        "-510005004": "新增用户失败",
        "-510005005": "请选择角色",
        "-510005006": "当前用户没有添加个体司机的权限",
        "-510006001": "当前用户没有关联公司", 
        "-510006002": "当前用户没有修改公司资料的权限", 
        "-510006003": "修改失败",
        "-510007001": "当前用户没有关联公司", "-510007002": "当前用户没有罗列公司用户的权限",

        "-510024001": "只有管理员有权执行该操作",
        "-510024002": "是否在园区内 ",
        "-510024003": "退出失败",
        "-510024004": "添加退出通知失败",

        "-510038002": "当前用户没有关联公司",   //执行重算操作，[sp_prv_price_CacheOrderPrice]
        "-510038003": "当前用户没有添加客户的权限",
        "-510039004": "获取当前客户以及影响报价的其他因素失败",
        "-10039005": "委托给承运商的订单，应该使用承运商的报价，当前公司不是承运商的客户",
        "-510039006": "承运商没有接收客户订单",

        "-510039001": "当前用户没有关联公司",     //重新计算费用，[sp_pub_order_RefreshPriceCache]
        "-510039002": "当前用户没有添加客户的权限",
        "-510039003":"订单不可以刷新费用",
        "-510041001": "不能设置公司管理员", "-510041002": "只有公司管理员才能修改用户","-510041003":"用户已经存在","-510041004":"编辑失败","-510041005":"角色为必填项",
        "-510051001": "当前用户没有关联公司",
        "-510051002": "当前用户没有修改公司资料的权限",
        "-510051003": "与管理员不属于同一公司",
        "-510051004": "公司管理员无法禁用",
        "-510051005": "编辑失败",
        "-510004001": "参数错误",
        "-510004002": "用户账号不存在！",
        "-510004003": "只有系统管理员能重置公司管理员的密码",
        "-510004004": "公司管理员能重置其他用户的密码",
        "-510004005": "编辑失败",
        "-510052001": "当前用户没有关联公司",
        "-510052002": "当前用户没有添加客户的权限",
        "-510052003": "源报价单是否有效[只有对方已同意的报价单可以强制过期，草稿和未审核报价单走“关闭”流程]",
        "-510052004": "置为过期失败",
        "-510052005": "写报价单流程表失败",
        "-510052006": "添加报价单被动过期的消息通知[15 报价单被强制过期]失败",
        "-510056001": "当前用户没有关联公司",                 //申请加入集团或修改加入集团申请,[sp_pub_user_JoinGroup]
        "-510056002": "只有管理员可以提交或修改加入集团申请",
        "-510056003": "获取集团的公司编号失败",
        "-510056004": "目标公司是否申明为集团本部",
        "-510056005": "是否已经申请过了[一个公司只能属于一个集团]",
        "-510056006": "待编辑内容是否存在",
        "-510056007": "修改申请信息失败",
        "-510056008": "添加申请信息失败",
        "-510058001": "当前用户没有关联公司",                 //发送加入集团申请，sp_pub_user_SendGroupReq
        "-510058002": "只有管理员可以发送加入集团申请",
        "-510058003": "申请登记是否存在并且有效",
        "-510058004": "发送失败",
        "-510057001": "当前用户没有关联公司",                 //审核加入集团申请，[sp_pub_user_ConfirmGroupReq]
        "-510057002": "只有集团权限才能审批集团加入申请[暂未确定集团权限的RoleID]",
        "-510057003": "当前公司是否申明为集团本部",
        "-510057004": "申请登记是否存在并且有效",
        "-510057005": "审核申请失败",
        "-510060001": "当前用户没有关联公司",                 //关闭加入集团申请，[sp_pub_user_CloseGroupReq]
        "-510060002": "只有管理员可以关闭加入集团申请",
        "-510060003": "申请登记是否存在并且可以关闭",
        "-510060004": "关闭申请失败",

        "-610001001": "当前用户没有关联公司",                 //API申请，[sp_pub_api_RegisterLicense]
        "-610001002": "同一公司不能重复注册",
        "-610001003": "申请失败",
        "-610001004": "编辑失败",
        "-510034008": "关闭时必须填写原因"                    //关闭订单
    };
    for ( var key in _result )
    {
        if ( typeof ( _ret.rs[0].rows[0][key] ) != 'undefined' )
        {
            if ( _ret.rs[0].rows[0][key] == 0 )
            {
                alert( '成功！' );
                setTimeout( function ()
                {
                    if ( $( 'body' ).attr( 'code' ) == 'UpdatePwd' )
                    {
//                      Exit();   hzy   16-06-20  1481
					 	javascript:location.reload();
                    }
                    else
                    {
                        location.href = $( 'body' ).attr( 'code' ) + '.aspx'; 
                    }
                }, 2000 );
            }
            else
            {
                if ( typeof _msg[_ret.rs[0].rows[0][key]] == 'undefined' )
                {
                    alert( '错误信息：异常错误' );
                }
                else
                {
                    if( $( 'body' ).attr( 'code' ) == "RePrice"){
                        _recalVal = _msg[_ret.rs[0].rows[0][key]];
                    }else{
                        alert( _msg[_ret.rs[0].rows[0][key]] );
                    }
                }
            }
        }
    }

    if( $( 'body' ).attr( 'code' ) == "RePrice"){
        return _recalVal;
    }
}

//获取货物分类值
function GetCheckboxVal( that )
{
   var _sum = 0;
   $( 'input[name="Goodscategory"]:checked' ).each( function ()
   {
       _sum |= $( this ).val();
   } );

   $( 'input[name="GoodsCategory"]' ).val( _sum );
	
	var table = $(that).closest('table');
	SaveFormDataNDT(table, $(that), __saveNdtCfg);
}

//显示货物分类值
function GoodsCategory()
{
    var _GoodsCategory = $( 'input[name="GoodsCategory"]' ).val();
    var _name = '';
    $( 'input[name="Goodscategory"]' ).each( function ()
    {
        var _val = parseInt( $( this ).val() ) & parseInt( _GoodsCategory );
        if ( _val == parseInt( $( this ).val() ) )
        {
            $( this )[0].checked = true;
            if ( _val == 1 )
            {
                _name += '普通货物' + ',';
            }
            else if ( _val == 2 )
            {
                _name += '危险品' + ',';
            }
            else if ( _val == 4 )
            {
                _name += '温控货物';
            }
        }
    } );
    $( 'input[name="GoodsCategoryName"]' ).val( _name );

    //显示补差
    var _weight = $('.addition').find('input[name="WeightAddition"]').val();
    var _volume = $('.addition').find('input[name="VolumeAddition"]').val();
    if ((parseInt(_weight) != 0 && _weight != '') || (parseInt(_volume) != 0 && _volume != '')) {
        $('.addition').show();
    }
}

//显示角色
function GetRole()
{
    var _roleID = $( 'input[name="RoleID"]' ).val();

    $( 'input[name="RoleID_id"]' ).each( function ()
    {
        var _val = parseInt( $( this ).val() ) & parseInt( _roleID );
        if ( _val == parseInt( $( this ).val() ) )
        {
            $( this )[0].checked = true;
        }
    } );
}

//普通用户重置密码功能（暂时不要）
function GetUsername( id )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0084';

    var _paras = [{}];
    _paras[0].name = 'id';
    _paras[0].value = id;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                location.href = 'UserRePwd.aspx?UserName=' + data[0].rs[0].rows[0].account;
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}
//是否确认
function IsSend()
{
    $( '#myModal' ).modal( 'show' );
    
}
//确认并保存
function SendOrder()
{
    $( '#myModal' ).modal( 'hide' );
    SaveFormDataNDT( $( '#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860' ), $( '#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860' ).find( 'a:first' ), __saveNdtCfg );
}

function ShowCars( obj )
{
    if ( $( obj ).find('option:selected').text() == '整车' )
    {
        $( 'tr[name="CarInfo"]' ).show();
    }
    else
    {
        $( 'tr[name="CarInfo"]' ).hide();
    }
}

$( 'input[name="radio"]' ).click( function ()
{
    if ( $( this ).val() == '1' )
    {
        $( 'tr[name="CarDriver"]' ).show();
        $( 'tr[name="CarDriverSupplier"]' ).hide();
        $( 'tr[name="CarDriverSup"]' ).hide();
    }
    else if ( $( this ).val() == '2' )
    {
        $( 'tr[name="CarDriverSupplier"]' ).show(); 
        $( 'tr[name="CarDriver"]' ).hide(); 
    }
   
    $( 'input[name="DriverID"]' ).val('');
    $( 'input[name="CarID"]' ).val( '' );
    $( 'input[name="SN"]' ).val( '' );
    $( 'input[name="DriverName"]' ).val( '' );
    $( 'input[name="SupplierName"]' ).val( '' );
    $( 'input[name="SupplierID"]' ).val( '' );
} );

//实时计算体积，重量
function Calculator( obj )
{
    var _qty = $( obj ).val();
    var _weight = $( obj ).closest( 'tr' ).find( 'input[name="weight"]' ).val();
    var _volume = $( obj ).closest( 'tr' ).find( 'input[name="volume"]' ).val();

    $( obj ).closest( 'tr' ).find( 'input[name="Weight"]' ).val( _qty * _weight );
    $( obj ).closest( 'tr' ).find( 'input[name="Volume"]' ).val( _qty * _volume );
}

//火狐底下textarea的高度固定
if (!$('textarea').attr('rows')) {
    if ($('textarea').parents('td').css('height')) {
        var rowsPanH = $('textarea').parents('td').height();
        $('textarea').css('height', rowsPanH + 'px');
    } else {
        var rowsPanH = $('textarea').parents('tr').height();
        $('textarea').css('height', rowsPanH + 'px');
    } 
}



//重新计算订单价格
function ReCal()
{
	//2016.06.15 hzy  确定选择了数据
	if($("input[type=checkbox]:checked").size() ==0)
	{
		alert("请在下面的列表中，至少选择其中一行，谢谢~");
	}else{
		$('#format-Modal').modal('show');
	    //$('div.loading').show();
	    $('button.cancer').prop('disabled','disabled');
	
	    setTimeout('ReCalData()',1000);
	}

}

function ReCalData(){
    var OrderID = 0;
    var _trObj = '';
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0001';

    var _paras = [{}];
    _paras[0].name = 'OrderID';

    var _checkbox = $('.SrcTable').find('input[name="content"]:checked');
    var queue = new Queue();
    queue.Interval = 100;

    _checkbox.each( function( index ){
        var that = this;
        OrderID = $(that).val();
        _trObj = $(that).closest('tr');
        _paras[0].value = OrderID;
        pmls[0].paras = _paras;

        var pmlStr = JsonToStr( pmls );
        queue.Push( function (_context, pmls ) {
            var num =  _checkbox.length - _context._queue.length;
            $("#num").html( "<span style=\"color:#f27302\">" + num + "</span>/" + _checkbox.length );
                NSF.System.Network.Ajax( '/Portal.aspx', pmls ,'POST', false, 
                    function ( result, data ) { 
                        if( data[0].rs[0].rows[0].Refresh_Result != '0' ){
                             var _recalVal =   Result(data[0]);
                            $('.FailureTable tbody').append('<tr><td>'+ _trObj.find('td:eq(1)').text() +'</td><td>'+_trObj.find('td:eq(2)').text() +'</td><td>'+
                        _trObj.find('td:eq(3)').text() +'</td><td>'+
                        _trObj.find('td:eq(4)').text() +'</td><td colspan="3" style="width:400px">'+ _recalVal +'</td></tr>');
                       
                         } 
                   } ); 
                if( num == _checkbox.length ){
                    $('button.cancer').removeProp('disabled');
                    if( $('#format-Modal tbody tr').length == 0 ){
                        $('.SuccessTips').removeClass('hide').show();
                    }
                }


        }, queue, pmlStr );
       
    }); 

     queue.Exec();

     
}

$('.cancer').click( function (){
    location.reload();
});

//生成日期控件
function  GetDateEvent( that, options )
{	
	options.choose=function(dates){
		$(that).trigger('change');
	};
	laydate(options);	
}

//根据单位筛选单位类型
function UnitType( obj )
{
	var _unit = $(obj).val();
	
	if( _unit != '' )
	{
		if( _unit == 1 || _unit == 2 )
		{
			$(obj).parent().prev().prev().find('input[name="ChargeMode"]').val(1);
			$(obj).parent().prev().prev().find('span[class="filter-option pull-left"]').text('重量');
		}
		else if( _unit == 3 || _unit == 4 )
		{
			$(obj).parent().prev().prev().find('input[name="ChargeMode"]').val(2);
			$(obj).parent().prev().prev().find('span[class="filter-option pull-left"]').text('体积');
		}
		else
		{
			$(obj).parent().prev().prev().find('input[name="ChargeMode"]').val(3);
			$(obj).parent().prev().prev().find('span[class="filter-option pull-left"]').text('数量');
		}
	}
	
}
//根据单位类型筛选单位
function Unit( obj )
{
	if($(obj).val() != $(obj).prev().val())
	{
		$(obj).prev().val($(obj).val());
	}
	$(obj).parent().next().next().find('input[name="PriceUnit"]').val(0);
	$(obj).parent().next().next().find('span[class="filter-option pull-left"]').text('-----------------------------');
	
	var _type = $(obj).val();
	if( _type == 1 )
	{
		$(obj).parent().next().next().find('li').hide();
		$(obj).parent().next().next().find('li:eq(1)').show();
		$(obj).parent().next().next().find('li:eq(2)').show();
		
	}
	else if( _type == 2 )
	{
		$(obj).parent().next().next().find('li').hide();
		$(obj).parent().next().next().find('li:eq(3)').show();
		$(obj).parent().next().next().find('li:eq(4)').show();
	}
	else if( _type == 3 )
	{
		$(obj).parent().next().next().find('li').hide();
		$(obj).parent().next().next().find('li:gt(4)').show();
	}
}
//判断浏览器为火狐
$(function()
{
	if (navigator.userAgent.indexOf('Firefox') >= 0)
	{
		//更改日期控件onclick 调用函数，此方式日期限制无效
		$('input[name="FromTime"],input[name="ToTime"],input[name="StartTime"],input[name="EndTime"],input[name="WayToTime"],input[placeholder="制单时间"],input[placeholder="起始时间"],input[placeholder="结束时间"],input[name="Birthday"]').attr('onclick','laydate()');
	} 
});

//select下拉值为0时
function selectBs()
{
	if($('input[name="ChargeMode"]').val() == 0)
	{
		$('select[name="ChargeMode_id"]').next().find('button span').eq(0).text('请选择');
	}
	if($('input[name="PriceUnit"]').val() == 0)
	{
		$('select[name="PriceUnit_id"]').next().find('button span').eq(0).text('请选择');
	}
}

//车型
function CarTypes(that, rel) {
    var TypeName = '';
    if (rel == 0) {
        TypeName = '';
    } else if (rel == 1) {
        TypeName = '半挂车';
    } else if (rel == 2) {
        TypeName = '高栏车';
    } else if (rel == 3) {
        TypeName = '厢式货车';
    } else if (rel == 4) {
        TypeName = '平板车';
    } else if (rel == 5) {
        TypeName = '敞车';
    } else if (rel == 6) {
        TypeName = '冷藏车';
    } else if (rel == 7) {
        TypeName = '面包车';
    } else if (rel == 8) {
        TypeName = '特种车辆';
    } else if (rel == 9) {
        TypeName = '集卡车';
    } else if (rel == 10) {
        TypeName = '其它车型';
    }
    that.find( 'input[name="CarTypeName"]' ).val( TypeName );
    if(that.find( 'input[name="CarLength"]' ).val() != '')
    {
        if ( that.find( 'input[name="CarLength"]' ).val() == 999.00 )
        {
            that.find( 'input[name="CarLengthName"]' ).val( '其他' );
            that.find('input[name="CarDetailShow"]').val('其他/'+that.find( 'input[name="CarVolume"]' ).val()+'/'+that.find( 'input[name="CarWeight"]' ).val());
        }
        else
        {
            that.find( 'input[name="CarLengthName"]' ).val( that.find( 'input[name="CarLength"]' ).val() );
            that.find('input[name="CarDetailShow"]').val(that.find( 'input[name="CarLength"]' ).val()+'/'+that.find( 'input[name="CarVolume"]' ).val()+'/'+that.find( 'input[name="CarWeight"]' ).val());
        }
    };
}
//是否ID转文字
function YesORno() {
 
 //补充报价类别  转换  文字      hzy  2016-06-24
   
        var id = $(this).find('input').val();
        var name = '';
        if (id == 0) {
            name = '无';
        } else if (id == 1) {
            name = '上楼费';
        } else if (id == 2) {
            name = '倒车费';
        } else if (id == 999) {
            name = '其他';
        }
        $('input[name="CarTypeName"]').val(TypeName);

}
//是否ID转文字
function YesORno() {
    $('.yesorno').each(function () {
        var id = $(this).find('input').eq(0).val();
        var name = '';
        if (id == 1) {
            name = '是';
        } else if (id == 0) {
            name = '否';
        }
        $(this).find('input').eq(1).val(name);
    });
}

//包装方式
function PackageMode() {
    var id = $('input[name="PackageMode"]').val();
    var name = '';
    if (id == 1) {
        name = '散箱';
    } else if (id == 2) {
        name = '托盘或木箱';
    } else if (id == 3) {
        name = '托盘、木箱或不规则形状';
    }
    $('input[name="PackageModeName"]').val(name);
}
//运输方式
function ShipModeName() {
    var id = $('input[name="ShipMode"]').val();
    var name = '';
    if (id == 1) {
        name = '市内';
    } else if (id == 2) {
        name = '长途';
    }
    $('input[name="ShipModeName"]').val(name);
}
//运输模式
function TransportMode() {
    var id = $('input[name="TransportMode"]').val();
    var name = '';
    if (id == 1) {
        name = '零担';
    } else if (id == 2) {
        name = '整车';
    }
    $('input[name="TransportModeName"]').val(name);
}
//订单费用显示
function OrderPriceShow(_id) {
    NSF.System.Data.RecordSet("/", { id: "pml_0025", cross: "false", rowIdentClass: "OrderPrice", paras: [{ "name": "OrderID", "value": _id }] }, function (result, config, data) {
        var _tdt = '<td class="td_name">类型</td>';
        var _td = '<td class="td_name">价格</td>';

        if (typeof data[1].rows[0] != 'undefined') {

            if (data[1].rows[0].LessLoad == '' || data[1].rows[0].LessLoad == '0.00') //零担
            { }
            else
            {
                _tdt += '<td >零担（RMB/元）</td>';
                _td += '<td name="LessLoad" >' + data[1].rows[0].LessLoad + '</td>';
            }
            if (data[1].rows[0].FullLoad == '' || data[1].rows[0].FullLoad == '0.00') //整车
            {
            }
            else {
                _tdt += '<td >整车（RMB/元）</td>';
                _td += '<td name="FullLoad" >' + data[1].rows[0].FullLoad + '</td>';
            }
            if (data[1].rows[0].Pick == '' || data[1].rows[0].Pick == '0.00')      //提货费
            {
            }
            else {
                _tdt += '<td >提货费（RMB/元）</td>';
                _td += '<td name="Pick" >' + data[1].rows[0].Pick + '</td>';
            }
            if (data[1].rows[0].Delivery == '' || data[1].rows[0].Delivery == '0.00')      //送货费
            {
            }
            else {
                _tdt += '<td >送货费（RMB/元）</td>';
                _td += '<td name="Delivery" >' + data[1].rows[0].Delivery + '</td>';
            }
            if (data[1].rows[0].OnLoad == '' || data[1].rows[0].OnLoad == '0.00')         //装货费
            {
            }
            else {
                _tdt += '<td >装货费（RMB/元）</td>';
                _td += '<td name="OnLoad" >' + data[1].rows[0].OnLoad + '</td>';
            }
            if (data[1].rows[0].OffLoad == '' || data[1].rows[0].OffLoad == '0.00')      //卸货费
            {
            }
            else {
                _tdt += '<td >卸货费（RMB/元）</td>';
                _td += '<td name="OffLoad" >' + data[1].rows[0].OffLoad + '</td>';
            }

            if (data[1].rows[0].InsuranceCost == '' || data[1].rows[0].InsuranceCost == '0.00')        //保险费
            {
            }
            else {
                _tdt += '<td >保险费（RMB/元）</td>';
                _td += '<td name="InsuranceCost" >' + data[1].rows[0].InsuranceCost + '</td>';
            }
            if (data[1].rows[0].Addition == '' || data[1].rows[0].Addition == '0.00')      //附加费
            {
            }
            else {
                _tdt += '<td >附加费（RMB/元）</td>';
                _td += '<td name="Addition" >' + data[1].rows[0].Addition + '</td>';
            }

            if (data[1].rows[0].Tax == '' || data[1].rows[0].Tax == '0.00')      //附加费
            {
            }
            else {
                _tdt += '<td >税费（RMB/元）</td>';
                _td += '<td name="Tax" >' + data[1].rows[0].Tax + '</td>';
            }

            _tdt += '<td >合计（RMB/元）</td>';
            _td += '<td name="Total" >' + data[1].rows[0].Total + '</td>';
        }
        else {
            _tdt += '<td >合计</td>';
            _td += '<td ></td>';
        }

        $('tr[name="OrderPriceTitle"]').append(_tdt);
        $('tr[name="OrderPrice"]').append(_td);
    });
}

/*用户启用、禁用*/
function EODUser( EOD, UserID )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0004';

    var _paras = [{}, {}];
    _paras[0].name = 'EOD';
    _paras[0].value = EOD;
    _paras[1].name = 'UserID';
    _paras[1].value = UserID;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}

/*用户重置密码*/
function GetAccount( adminaccount ){
    if ( adminaccount != '' )
    {
        location.href = 'UserRePwd.aspx?account=' + adminaccount ;
    }
    else
    {
        alert( '用户账号不存在！' );
    } 
}

/*用户重置密码保存*/
function ReUserPwd( Username, Pwd )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0005';

    var _paras = [{}, {}];
    _paras[0].name = 'Username';
    _paras[0].value = Username;
    _paras[1].name = 'Pwd';
    _paras[1].value = Pwd;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}


//合约报价强制过期
function DocExpiredNow( button ) {
    var divModal = $(button).closest("#combinedModal");
    divModal.modal('hide');
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0210';

    var _paras = [{}, {}];
    _paras[0].name = 'DocID';
    _paras[0].value = divModal.find('input[name="DocID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = divModal.find('textarea[name="Description"]').val();
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}

//弹出是否确认强制过期框
function docCombined( DocID ) {
    $('#combinedModal').modal( 'show' );
    $('#combinedModal input').val( DocID );
}



//单选按钮、多选按钮的样式改变
function ifChecked() {
    $('input[type="radio"]:checked').each( function(){
        $(this).prev('span').css({ "background": "url(../images/dian.png)", "background-size": "10px 10px" });
    });
}
function ifBoxChecked() {
    $('input[type="checkbox"]:checked').each(function(){
        $(this).prev('span').addClass('gouChecked');
    })
}
//单选按钮的样式改变
$('input[type="radio"]').before('<span class="circle-btn"></span>');
$('.circle-btn').parent().click(function () {
    $(this).parents('.list-inline').find('span').css('background', 'none');
    $(this).find('.circle-btn').css({ "background": "url(../images/dian.png)", "background-size": "10px 10px" });
    $(this).find('input')[0].checked = true;

})

//多选按钮的样式改变
$('input[type="checkbox"]').before('<span class="gou-btn"></span>');
$('.gou-btn').click(function () {
    if ($(this).hasClass('gouChecked')) {
        $(this).removeClass('gouChecked');
        $(this).next()[0].checked = false;
    } else {
        $(this).addClass('gouChecked');
        $(this).next()[0].checked = true;
    }

})

//合约报价零担部分显示
function LtlDisplay( id )
{
    $( '#KG, #Ton, #CMetre , #Square, #num' ).find('tr.hide').next().remove();
    var params = '[{"namespace":"protocol","cmd":"data","version":1,"id":"pml_0020","paras":[{"name":"did","value":"' + id + '"}]}]';
    var cross = false;
    $.ajax(
    {
        async: false,
        url: '/Portal.aspx',
        dataType: ( cross ? "jsonp" : "json" ),
        jsonp: ( cross ? 'callback' : '' ),
        type: 'POST',
        data: params,
        success: function ( data )
        {
            var datas = data[0].rs;
            if ( data[0].result )
            {
                if ( datas != '' )
                {
                    $( '.ld input[name="From"]' ).val( datas[0].rows[0].FromName );
                    $( '.ld input[name="FromProvince"]' ).val( datas[0].rows[0].FromProvince );
                    $( '.ld input[name="FromCity"]' ).val( datas[0].rows[0].FromCity );
                    $( '.ld input[name="FromDistrict"]' ).val( datas[0].rows[0].FromDistrict );
                    var KG = 0, Ton = 0, CMetre = 0, Square = 0, num = 0;
                    var KGData = [], TonData = [], CMetreData = [], SquareData = [], numData = [];
                    for ( var i = 0; i < datas[0].rows.length; i++ )
                    {
                        if ( datas[0].rows[i].Unit == 1 )
                        {
                            KG++;
                            KGData[KG-1] = datas[0].rows[i];
                        }
                        else if ( datas[0].rows[i].Unit == 2 )
                        {
                            Ton++;
                            TonData[Ton - 1] = datas[0].rows[i];
                        }
                        else if ( datas[0].rows[i].Unit == 3 )
                        {
                            CMetre++;
                            CMetreData[CMetre - 1] = datas[0].rows[i];
                        }
                        else if ( datas[0].rows[i].Unit == 4 )
                        {
                            Square++;
                            SquareData[Square - 1] = datas[0].rows[i];
                        }
                        else
                        {
                            num++;
                            numData[num - 1] = datas[0].rows[i];
                        }
                    }
                    ShowLtl( KG, 'KG', KGData );
                    ShowLtl( Ton, 'Ton', TonData );
                    ShowLtl( CMetre, 'CMetre', CMetreData );
                    ShowLtl( Square, 'Square', SquareData );
                    ShowLtl( num, 'num', numData );
                }
            }

        }
    } );
}
function ShowLtl( total, name, data )
{
    //数值排版
    var max = [];
    //根据目的城市分级
    var endCity = [];
    for ( var sum = 0; sum < data.length; sum++ )
    {
        max[sum] = data[sum].Max;
        //endCity[sum] = data[sum].ToCity;
        var oNpcd =
            {
                'ToProvince': data[sum].ToProvince,
                'ToCity': data[sum].ToCity,
                'ToDistrict': data[sum].ToDistrict
            };              
        endCity.push( oNpcd );
    };
    //去重
    var endCitys = [];//去除重复后的目的地
    var len = endCity.length;
    var arr = [];
    for(var ecl = 0; ecl < len; ecl++)
    {       
        var t = endCity[ecl];
        if(t['ToDistrict'] != 0)
        {
            if(ecl == 0)
            {
                if(arr.indexOf(t['ToProvince']) ==-1 && arr.indexOf(t['ToCity']) ==-1 && arr.indexOf(t['ToDistrict']) ==-1)
                {
                    arr.push(t['ToProvince'],t['ToCity'],t['ToDistrict']);
                    endCitys.push(t);
                }
            }
            else if(arr.indexOf(t['ToProvince']) !=-1 )
            {
                if(arr.indexOf(t['ToCity']) !=-1)
                {
                    if(arr.indexOf(t['ToDistrict']) ==-1)
                    {
                        arr.push(t['ToProvince'],t['ToCity'],t['ToDistrict']);
                        endCitys.push(t);
                    }
                }               
            }
            else
            {
                arr.push(t['ToProvince'],t['ToCity'],t['ToDistrict']);
                endCitys.push(t);
            }
        }
        else
        {
            /* if(arr.indexOf(t['ToDistrict']) ==-1)
            {
                arr.push(t['ToProvince'],t['ToCity'],t['ToDistrict']);
                endCitys.push(t);
            }        */ 
            if(arr.indexOf(t['ToDistrict']) ==-1 || arr.indexOf(t['ToProvince']) ==-1 || arr.indexOf(t['ToCity']) ==-1)
            {
                arr.push(t['ToProvince'],t['ToCity'],t['ToDistrict']);
                endCitys.push(t);
            }
        }           
    }
    var MaxS = []; //接收去除重复后的最大区间值
    for ( var i = 0; i < max.length; i++ ) //遍历当前数组
    {
        //如果当前数组的第i已经保存进了临时数组，那么跳过，
        //否则把当前项push到临时数组里面
        if ( MaxS.indexOf( max[i] ) == -1 ) MaxS.push( max[i] );
    };
    //数字数组排序
    MaxS = MaxS.sort(function(a,b){
        return a-b;
    });
    //生成行数
    for ( var j = 0; j < endCitys.length; j++ )
    {
        $( '#' + name ).append( '<tr>' + $( '#' + name ).find( '.hide' ).html() + '</tr>' );
    }
    //区间值赋值
    $( '#' + name ).find( 'tr' ).eq( 0 ).find( 'td' ).each( function ( index )
    {
        $( '#' + name ).find( 'tr' ).eq( 0 ).find( 'td' ).eq( index + 1 ).find( 'input' ).val( MaxS[index] );
    } );
    //遍历数据 赋入价格
    for( var p = 0; p < data.length; p++ )
    {
        //根据目的城市进行定位
        for(var c = 0; c < endCitys.length; c++)
        {
            if(data[p].ToProvince == endCitys[c].ToProvince && data[p].ToCity == endCitys[c].ToCity && data[p].ToDistrict == endCitys[c].ToDistrict)
            {
                var DetailID = data[p].DetailID;
                var ToName = data[p].ToName;
                var ToProvince = data[p].ToProvince;
                var ToCity = data[p].ToCity;
                var ToDistrict = data[p].ToDistrict;
                var Price = data[p].Price;
                //数据类容是数量的时候
                if(name == 'num')
                {
                    var Unit = data[p].Unit;
                    var UnitName;
                    $('.num select[name="Unit_id"] option').each(function(index)
                    {
                        if($('.num select[name="Unit_id"] option').eq(index).val() == Unit)
                        {
                            UnitName = $('.num select[name="Unit_id"] option').eq(index).text();
                        }
                    });
                    $('.num button.selectpicker').attr('title',UnitName);
                    $('.num button.selectpicker span.filter-option').text(UnitName);
                    $('.num input[name="Unit"]').val(Unit);
                    $( '.ld' ).find( 'select[name="Unit_id"] option[value='+ Unit +']' ).attr('selected','selected')
                };
                //
                $( '#' + name ).find( 'tr' ).eq( c+2 ).find('td').eq(0).find('input[name="ToName"]').val(ToName);
                $( '#' + name ).find( 'tr' ).eq( c+2 ).find('td').eq(0).find('input[name="ToProvince"]').val(ToProvince);
                $( '#' + name ).find( 'tr' ).eq( c+2 ).find('td').eq(0).find('input[name="ToCity"]').val(ToCity);
                $( '#' + name ).find( 'tr' ).eq( c+2 ).find('td').eq(0).find('input[name="ToDistrict"]').val(ToDistrict);
                //$( '#' + name ).find( 'tr' ).eq( c+2 ).find('td').eq(0).find('input[name="DetailID"]').val(DetailID);
                //获取对应区间位置
                for(var maxqj = 0; maxqj < MaxS.length; maxqj++)
                {
                    if(data[p].Max == MaxS[maxqj])
                    {
                        $( '#' + name ).find( 'tr' ).eq( c+2 ).find('td').eq(maxqj+1).find('input[name="Price"]').val(Price);
                        $( '#' + name ).find( 'tr' ).eq( c+2 ).find('td').eq(maxqj+1).find('input[name="DetailID"]').val(DetailID);
                    }
                }
            }
        }
    }
}

//新增明细行
function rowAdd()
{
  var _rowid;
  var _nrowid;

  $('tr').each( function(){
    _rowid = $(this).attr('rowid');
    _nrowid = $(this).next().attr('nrowid');


    if( _nrowid == undefined ){
        switch( _rowid ){
            case 'PMS_LessLoad' :
                 _row_add( $(this), undefined, undefined );
                break;
            case 'PMS_FullLoad' :
                 _row_add( $(this), undefined, undefined );
                break;
            case 'CityPickPrice' :
                 _row_add( $(this), undefined, undefined );
                break;
            case 'CityDeliveryPrice' :
                 _row_add( $(this), undefined, undefined );
                break;
            case 'LoadPrice2' :
                  _row_add( $(this), undefined, undefined );
                break;
            case 'MinPrice' :
                 _row_add( $(this), undefined, undefined );
                break;
            case 'InsurancePrice' :
                 _row_add( $(this), undefined, undefined );
                break;
            case 'TaxPrice' :
                 _row_add( $(this), undefined, undefined );
                break;
            case 'CombineOrderPrice' :
                _row_add( $(this), undefined, undefined );
                break;   
        }
    }


    this.isDirty = true;
    

    if( $('input[name="IsPick"]').val() === '0' ){
        $(this).find('input[name="PickPrice"]').val( 0 );
        $(this).find('input[name="PickPrice"]').prop( 'readonly', true );
    }
    if( $('input[name="IsDelivery"]').val() === '0' ){
        $(this).find('input[name="DeliveryPrice"]').val( 0 );
        $(this).find('input[name="DeliveryPrice"]').prop( 'readonly', true );
    }
    if( $('input[name="IsOnLoad"]').val() === '0' ){
        $(this).find('input[name="OnLoadPrice"]').val( 0 );
        $(this).find('input[name="OnLoadPrice"]').prop( 'readonly', true );
    }
    if( $('input[name="IsOffLoad"]').val() === '0' ){
        $(this).find('input[name="OffLoadPrice"]').val( 0 );
        $(this).find('input[name="OffLoadPrice"]').prop( 'readonly', true );
    }
    if( $('input[name="IsInsurance"]').val() === '0' ){
        $(this).find('input[name="InsuranceCost"]').val( 0 );
        $(this).find('input[name="InsuranceCost"]').prop( 'readonly', true );
    }
    if( $('input[name="TransportMode"]').val() === '1' ){
        $(this).find('input[name="FullLoadPrice"]').val( 0 );
        $(this).find('input[name="FullLoadPrice"]').prop( 'readonly', true );
    }else if( $('input[name="TransportMode"]').val() === '2' ){
        $(this).find('input[name="LessLoadPrice"]').val( 0 );
        $(this).find('input[name="LessLoadPrice"]').prop( 'readonly', true );
    }
  });

}

/*为table里面的input添加title*/
function hoverTips() {
    $(".FormTable td input").each(function () {
        var thisVal = $(this).val();
        $(this).attr("title", thisVal);
    });
    $('input').on('focus', function(){
    if( $(this).attr('readonly') != undefined || $(this).attr('disabled') != undefined){
    }else{
        //$(this).val('');
    }
});
}
//显示合约报价 整车的起点省市
function ShowVehicle()
{
    var FromName = $( 'tr[nrowid="PMS_FullLoad"]' ).find( 'input[name="FromName"]' ).val();
    var FromProvince = $( 'tr[nrowid="PMS_FullLoad"]' ).find( 'input[name="FromProvince"]' ).val();
    var FromCity = $( 'tr[nrowid="PMS_FullLoad"]' ).find( 'input[name="FromCity"]' ).val();
    $( '.setOff input[name="FromName"]' ).val( FromName );
    $( '.setOff input[name="FromProvince"]' ).val( FromProvince );
    $( '.setOff input[name="FromCity"]' ).val( FromCity );
}

//合约报价新增报价复制
function CopyDoc(that)
{
    var copyCont = $(that).parent().parent().html();//存当前复制的html
    var inputVal = $(that).parent().parent().find('input');//当前复制的input 
    $(that).parent().parent().parent().append('<tr>'+ copyCont +'</tr>');
    var tabTRnow = $(that).parent().parent().parent().find('tr').length;//生成后tr个数
    var parTbody = $(that).parent().parent().parent();//父级tbody
    for(var i = 0; i < inputVal.length; i++)
    {
        if(inputVal.eq(i).attr('name') != 'DetailID')
        {
            parTbody.find('tr').eq(tabTRnow-1).find('input').eq(i).val(inputVal.eq(i).val());
        }
        else
        {
            parTbody.find('tr').eq(tabTRnow-1).find('input').eq(i).val(0);
        }
    }
}
/*显示车型名称*/
function CarName() {
    var _trObj = "";
    var _carType = "";

    $('input[name="CarType"]').each(function() {
        _trObj = $(this).closest("tr");
        _carType = _trObj.find('input[name="CarType"]').val();
        CarTypes(_trObj, _carType);
    } );
    $( 'input[name="FromName"],input[name="ToName"],input[name="From"]' ).each( function ( index )
    {
        var val = $( this ).val();
        var value = val.charAt( val.length - 1 );
        if ( value == '-' )
        {
            val = val.substring( 0, val.length - 1 );
            if ( val.charAt( val.length - 1 ) == '-' )
            {
                val = val.substring( 0, val.length - 1 );
                $( this ).val( val );
            }
            else
            {
                $( this ).val( val );
            }
        }
    } );
    $( 'table' ).find( 'tr' ).each( function ( index )
    {
        $( 'tr' )[index].isDirty = true;
    } );  

    //下拉菜单错误代码
    $('span[class="filter-option pull-left"]').each( function(){
        if( $(this).text() == 'Nothing selected' ){
            $(this).text( '---------------------------' );
        }
    });
}

//改变搜索条框的状态
function collapseStat(that) {
    if ($('#collapseExample').hasClass('in')) {
        $(that).find('span[rol="text"]').text('更多');
        $(that).find('span[rol="img"]').removeClass('glyphicon glyphicon-menu-up');
        $(that).find('span[rol="img"]').addClass('glyphicon glyphicon-menu-down');
    }
    else {
        $(that).find('span[rol="text"]').text('收起');
        $(that).find('span[rol="img"]').removeClass('glyphicon glyphicon-menu-down');
        $(that).find('span[rol="img"]').addClass('glyphicon glyphicon-menu-up');
    }
}

//申请加入集团或修改加入集团申请
function SendDirectlySave( SendDirectly, obj ){

    $('input[name="SendDirectly"]').val( SendDirectly );

    var table = $(obj).closest('table');
    SaveFormDataNDT(table, $(obj), __saveNdtCfg);  //保存用户信息
}

//列表，发送加入集团申请
function SendGroupReq( BranchID ){
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0008';

    var _paras = [{}];
    _paras[0].name = 'BranchID';
    _paras[0].value = BranchID;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}

//列表，发送加入集团申请
function SendParkReq( ZoneID ){
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0014';

    var _paras = [{}];
    _paras[0].name = 'BranchID';
    _paras[0].value = ZoneID;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
               
                alert('成功' );
                setInterval('window.location.reload()',2000);  
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}

//列表，审核加入集团申请
function ConfirmGroup( BranchID ){
    $("div#ConfirmModal").modal( "show" );
    $("div#ConfirmModal").find('input[name="BranchID"]').val( BranchID );
}

//列表，审核加入集团申请
function ConfirmGroupReq( AOR, divObj ){
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0009';

    var _paras = [{}, {}, {}];
    _paras[0].name = 'BranchID';
    _paras[0].value = divObj.find('input[name="BranchID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = divObj.find('textarea[name="Description"]').val();
    _paras[2].name = 'AOR';
    _paras[2].value = AOR;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}

//列表，关闭集团申请
function CloseGroup( BranchID ){
    $("div#closeModal").modal( "show" );
    $("div#closeModal").find('input[name="BranchID"]').val( BranchID );
}
function CloseGroupReq( divObj ){
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0010';

    var _paras = [{}, {}];
    _paras[0].name = 'BranchID';
    _paras[0].value = divObj.find('input[name="BranchID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = divObj.find('textarea[name="Description"]').val();
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}

function paginations()
{
	$('.pagination li').remove();
	$('.pagination').html('<li class="bord_li prev"><a href="javascript:void(0)">上一页</a></li><li class="bord_li next"><a href="javascript:void(0)">下一页</a></li>');
}



//列表，审核加入集团申请
function ConfirmPark( AOR, divObj ){
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0015';

    var _paras = [{}, {}, {}];
    _paras[0].name = 'ZoneID';
    _paras[0].value = divObj.find('input[name="BranchID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = divObj.find('textarea[name="Description"]').val();
    _paras[2].name = 'AOR';
    _paras[2].value = AOR;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}

function ClosePark( divObj ){
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0016';

    var _paras = [{}, {}];
    _paras[0].name = 'ZoneID';
    _paras[0].value = divObj.find('input[name="BranchID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = divObj.find('textarea[name="Description"]').val();
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}

//API申请
function RegisterLicense(){
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'API_001';
    pmls[0].paras = [];

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}

//API接入
function IntoLicense(){
    $('.into').removeClass('hide');
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'API_003';
    pmls[0].paras = [];

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                if (data[0].rs.length != 0) {
                    $('#AppID').text(data[0].rs[0].rows[0].appid);
                    $('#HelloToken').text(data[0].rs[0].rows[0].hellotoken);
                    $('#AesKey').text(data[0].rs[0].rows[0].aeskey);
                    $('#ClientUrl').text(data[0].rs[0].rows[0].clienturl);
                    $('#LicenseID').val(data[0].rs[0].rows[0].id);
                }
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}
//API检测
function checkLicense() {
    var pmls = {};
    pmls.namespace = 'signature';
    pmls.cmd = 'verify';
    pmls.version = 1;

    var _paras;
    _paras = [{}, {}, {}];
    _paras[0].name = 'appid';
    _paras[0].value = $('label#AppID').text()
    _paras[1].name = 'licenseid';
    _paras[1].value = $('input#LicenseID').val();
    _paras[2].name = 'clienturl';
    _paras[2].value = $('textarea#ClientUrl').val();
    
    pmls.paras = _paras;
    var _url = $('textarea#ClientUrl').val();
    NSF.System.Network.Ajax(_url ,
        NSF.System.Json.ToString(pmls),
        'POST',
        false,
        function(result, data) {
            if (data.result) {
                alert("接入成功！");
            } else {
                alert('接入失败，原因：有可能是参数不匹配或此网站已被接入！');
            }
        });
}
//关闭订单
function shut(){
    $('#ClosedModal').modal('hide');
	var _DocID = $('input[name="DocID"]').val();
	var _description = $('textarea[name="CDescription"]').val();

	var vml =
	'[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0090","paras":[{"name":"OrderID","value":"' +_DocID+ '"},{"name":"Description","value":"'+_description+'"}]}]';

	NSF.System.Network.Ajax('/Portal.aspx',
		vml,
		'POST',
		false,
		function(result, data) {
	        if (data[0].result) {
	            Result(data[0]);
	        } else {
	            alert(data[0].msg);
	        }
		});
		reqeustDone();
}

function ShutOrder(DocID){
	if (DocID) {
        DocID = DocID;
    } else {
        DocID = getUrlParam("id");
    }
    
    $('#ClosedModal').modal('show');
    $('input[name="DocID"]').val(DocID);
}

//审核申请列表启用、禁用
function GroupCompanyEOD( EOD, BranchID )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0017';

    var _paras = [{}, {}];
    _paras[0].name = 'EOD';
    _paras[0].value = EOD;
    _paras[1].name = 'BranchID';
    _paras[1].value = BranchID;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}

//申请列表退出
function ZoneCompanyEOD( BranchID )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'aml_0018';

    var _paras = [{}];
    _paras[0].name = 'BranchID';
    _paras[0].value = BranchID;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                Result( data[0] );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}