/*拖动效果*/
$('.modal-header,.modal-footer').on('mousedown',function( event ){
    drag(this.parentNode,event);
});
$('div#win-Common-Dialog .modal-body').on('mousedown',function( event ){
    drag(this.parentNode,event);
});

//复选框绑定单击事件
$( 'input[type="checkbox"]' ).on( 'click', function ()
{
    if ( $( this ).attr( 'checked' ) )
    {
        $( this ).removeAttr( 'checked' );
    }
    else
    {
        $( this ).attr( 'checked', 'checked' );
    }
} );

function resizeTable() {
    if ($("#demoList").length == 0) {
        return;
    }
    else {
        $("#demoList").colResizable({ liveDrag: true });    //拖动列宽

        resizeCols = clearInterval(resizeCols);
    }
}

//调整列表宽度
document.onmouseover = function() {
    resizeTable();
};



//一般用户注册表单提交
function UserAdd( obj )
{
    var _sum = 0;
    $( 'input[name="RoleID_id"]:checked' ).each( function ()
    {
        _sum |= $( this ).val();
    } );

    $( 'input[name="RoleID"]' ).val( _sum );

    $( obj ).removeAttr( 'btn-clicked' );
    //$( '#GeneralForm' ).find( 'input:eq(0)' ).attr( 'name', 'Acccount' );
    //var jsonData = $( '#GeneralForm' ).serializeJson();

    //var _RoleID = jsonData.Roleid;
    //var _sum = 0;
    //if ( typeof ( _RoleID ) != 'undefined' )
    //{
    //    for ( var i = 0; i < _RoleID.length ; i++ )
    //    {
    //        _sum |= _RoleID[i];
    //    }
    //}

    //jsonData.RoleID = _sum;

    //DoGeneral( jsonData, CompleteGeneral );
}


//一般用户修改表单提交
function UserEdit()
{
    var jsonData = $( '#GeneralForm' ).serializeJson();

    var _RoleID = jsonData.RoleID;
    var _sum = 0;

    if ( _RoleID != '256' )
    {
        $( 'input[type="checkbox"]' ).each( function ()
        {
            if ( $( this ).attr( 'checked' ) )
            {
                for ( var i = 0; i < jsonData.Roleid.length ; i++ )
                {
                    if ( i == 0 )
                    {
                        _sum = jsonData.Roleid[0];
                    }
                    else
                    {
                        _sum |= jsonData.Roleid[i];
                    }
                }
                jsonData.RoleID = _sum;

                return false;
            }
        } );
    }
    DoUpdateGeneral( jsonData );
}

function GetGeneralProtocol( jsonData )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0060';
    pmls[0].paras = [];

    for ( var key in jsonData )
    {
        var _t = {};
        _t.name = key;
        _t.value = jsonData[key];

        pmls[0].paras.push( _t );
    }

    return JsonToStr( pmls );
}
function DoGeneral( jsonData, callback )
{
    NSF.System.Network.Ajax( '/Portal.aspx',
        GetGeneralProtocol( jsonData ),
        'POST',
        false,
        callback );
}


function GetUpdateGeneralProtocol( jsonData )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0049';
    pmls[0].paras = [];

    for ( var key in jsonData )
    {
        var _t = {};
        _t.name = key;
        _t.value = jsonData[key];

        pmls[0].paras.push( _t );
    }

    return JsonToStr( pmls );
}
function DoUpdateGeneral( jsonData )
{
    NSF.System.Network.Ajax( '/Portal.aspx',
        GetUpdateGeneralProtocol( jsonData ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                alert( '编辑成功!' );
                setTimeout( function ()
                {
                    back();
                }, 1000 );
            }
            else
            {
                alert( data[0].msg );
            }
        } );
}
//function CompleteUpGeneral( result, data )
//{
//    if ( data[0].result )
//    {
//        alert( '用户编辑成功！' );
//    }
//    else
//    {
//        alert( data[0].msg );
//    }
//}


function CompleteGeneral( result, data )
{
    if ( data[0].result )
    {
        //if ( data[0].rs[0].rows[0].User_Result == 0 )
        //{
        //    alert( '用户注册成功！' );
        //}
        //else
        //{
        //    alert( '错误代码：' + data[0].rs[0].rows[0].User_Result );
        //}
        Result( data[0] );
    }
    else
    {
        alert( data[0].msg );
    }
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

function ReceiveOrder( Accept, OrderID )
{
    $( '#myModal' ).modal( 'show' );
    $( 'input[name="Accept"]' ).val( Accept );
    $( 'input[name="OrderID"]' ).val( OrderID );

    if ( Accept == '0' )
    {
        $( '#myModalLabel' ).find( 'p' ).text( '拒收订单' );
        $( 'span[name="content"]' ).text( '是否确定拒收订单' );
    }
    else if ( Accept == '1' )
    {
        $( '#myModalLabel' ).find( 'p' ).text( '接收订单' );
        $( 'span[name="content"]' ).text( '是否确定接收订单' );
    }
}

//接受订单
function OrderAccept( )
{
    $( '#myModal' ).modal( 'hide' );
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0066';

    var _paras = [{}, {}]; 
    _paras[0].name = 'OrderID';
    _paras[0].value = $( 'input[name="OrderID"]' ).val(  );
    _paras[1].name = 'Accept';
    _paras[1].value = $( 'input[name="Accept"]' ).val(  );

    pmls[0].paras = _paras ;

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


//签收订单
function OrderSignEdit()
{
    $( '#myModal' ).modal( 'hide' );
    var Desc_YC = $( 'input[name="Desc_YC"]' ).val();
    var GoodsQty = '';
    $( 'tr[nrowid="TMS_OrderGoods"]' ).each( function ( index )
    {
        var OrderID = $( this ).find( 'input[name="ListID"]' ).val();
        var ReceiptQty = $( this ).find( 'input[name="ReceiptQty"]' ).val();
        var ExceptionQty = $( this ).find( 'input[name="ExceptionQty"]' ).val();

        GoodsQty += '' + OrderID + '=' + ReceiptQty + ',' + ExceptionQty + '';

        if ( $( 'tr[nrowid="TMS_OrderGoods"]' ).length - 1 > index )
        {
            GoodsQty += ';';
        }
    } );

    $( 'input[name="GoodsQty"]' ).val( GoodsQty );
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0068';

    var _paras = [{}, {}, {}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $( 'input[name="OrderID"]' ).val();
    _paras[1].name = 'Desc_YC';
    _paras[1].value = Desc_YC;
    _paras[2].name = 'GoodsQty';
    _paras[2].value = GoodsQty;
    _paras[3].name = 'Cost_YC';
    _paras[3].value = $( 'input[name="Cost_YC"]' ).val();

    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        OrderSign );
}
function OrderSign( result, data )
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
function CostDetailAdd( Addition )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0076';

    var _paras = [{}, {}, {}, {}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $( 'input[name="OrderID"]' ).val();
    _paras[1].name = 'Type';
    _paras[1].value = $( 'input[name="Type"]' ).val();
    _paras[2].name = 'Amount';
    _paras[2].value = $( 'input[name="Amount"]' ).val();
    _paras[3].name = 'Description';
    _paras[3].value = $( 'textarea[name="Description"]' ).val();
    _paras[4].name = 'Addition';
    _paras[4].value = Addition;

    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result ) Result( data[0] );
        } );

}
//上传回单为只读
function ReceiptDocPath()
{
    $( 'input[name="ReceiptDocPath"]' ).removeAttr( 'type' );
}


//订单回单
function OrderReceiptEdit()
{
    $( '#myModal' ).modal( 'hide' );
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0069';

    var _paras = [{}, {}, {}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $( 'input[name="OrderID"]' ).val();
    _paras[1].name = 'ReceiptDocPath';
    _paras[1].value = $( $( 'input[name="ReceiptDocPath"]' )[1] ).val();
    _paras[2].name = 'Cost_YC';
    _paras[2].value = $( 'input[name="Cost_YC"]' ).val();
    _paras[3].name = 'Desc_YC';
    _paras[3].value = $( 'input[name="Desc_YC"]' ).val();

    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        OrderReceipt );
}
function OrderReceipt( result, data )
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
//function OrderReceiptAdd( that )
//{
//    var pmls = [{}];
//    pmls[0].namespace = 'protocol';
//    pmls[0].cmd = 'data';
//    pmls[0].version = 1;
//    pmls[0].id = 'tms_0076';

//    var _paras = [{}, {}, {}, {}, {}];
//    _paras[0].name = 'OrderID';
//    _paras[0].value = $( 'input[name="OrderID"]' ).val();
//    _paras[1].name = 'Type';
//    _paras[1].value = that.val();
//    _paras[2].name = 'Amount';
//    _paras[2].value = that.closest( 'tr' ).find( 'input[name="Amount"]' ).val();
//    _paras[3].name = 'Description';
//    _paras[3].value = that.closest( 'tr' ).find( 'input[name="Description"]' ).val();
//    _paras[4].name = 'Addition';
//    _paras[4].value = 1;

//    pmls[0].paras = _paras;

//    NSF.System.Network.Ajax( '/Portal.aspx',
//        JsonToStr( pmls ),
//        'POST',
//        false,
//        function ( result, data )
//        {
//            if ( data[0].result ) Result( data[0] );
//        } );

//}

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


//同意或拒绝成为承运商
function SupplierAccept( Op, SupplierID )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0072';

    var _paras = [{}, {}];
    _paras[0].name = 'Op';
    _paras[0].value = Op;
    _paras[1].name = 'SupplierID';
    _paras[1].value = SupplierID;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        SupplierAcceptResult );
}
function SupplierAcceptResult( result, data )
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

//显示错误代码
function Result( _ret )
{
    var _result = { "Customer_Result": "0", "Supplier_Result": "0", "Addr_Result": "0", "Car_Result": "0", "Driver_Result": "0", "EndUser_Result": "0", "Goods_Result": "0", "GoodsType_Result": "0", "Order_Result": "0", "Pwd_Result": "0", "Company_Result": "0", "User_Result": "0", "Cost_Result": "0", "Back_Result":"0","Flow_Result":"0","Schedule_Result":"" };
    var _msg = {
        "-510001001": "序列号生成失败", "-510001002": "公司名是否重复", "-510001003": "新增公司失败",
        "-510002000": "只有管理员有权执行该操作", "-510002001": "没有找到对应公司或公司已被审核", "-510002002": "审核公司失败", "-510002003": "管理员账号是否已经存在", "-510002004": "添加管理员账号失败",
        "-510003001": "参数错误", "-510003002": "账号不存在", "-510003003": "账号密码与原始密码不匹配",
        "-510004001": "参数错误", "-510004002": "账号不存在", "-510004003": "只有系统管理员能重置公司管理员的密码", "-510004004": "公司管理员能重置其他用户的密码", "-510004005": "编辑密码失败",
        "-510005001": "不能添加公司管理员", "-510005002": "只有公司管理员才能添加用户", "-510005003": "用户是否已经存在", "-510005004": "新增用户失败","-510005005": "请选择角色",
        "-510006001": "当前用户没有关联公司", "-510006002": "当前用户没有修改公司资料的权限", "-510006003": "修改失败",
        "-510007001": "当前用户没有关联公司", "-510007002": "当前用户没有罗列公司用户的权限",
        "-510008001": "当前用户没有关联公司", "-510008002": "当前用户没有添加客户的权限", "-510008003": "客户公司编号是否有效", "-510008004": "序列号生成失败", "-510008005": "客户公司是否存在,添加失败", "-510008006": "客户公司是否存在,编辑失败", "-510008007": "手动录入的客户公司名称是否重复",
        "-510009001": "当前用户没有关联公司", "-510009002": "当前用户没有添加承运商的权限", "-510009003": "承运商公司编号是否有效", "-510009004": "客户公司是否存在,添加失败",
        "-510010001": "当前用户没有关联公司", "-510010002": "当前用户没有添加客户的权限", "-510010003": "司机是否存在,添加失败", "-510010004": "司机是否存在，编辑失败",
        "-510011001": "当前用户没有关联公司", "-510011002": "当前用户没有添加客户的权限", "-510011003": "车辆是否存在,添加失败", "-510011004": "车辆是否存在，编辑失败",
        "-510012001": "当前用户没有关联公司", "-510012002": "当前用户没有添加客户的权限", "-510012003": "司机是否存在，新增失败", "-510012004": "司机是否存在，编辑失败",
        "-510013001": "当前用户没有关联公司", "-510013002": "当前用户没有添加客户的权限", "-510013003": "收货人是否存在", "-510013004": "地址是否存在,添加失败", "-510013005": "地址是否存在,编辑失败",
        "-510014001": "当前用户没有关联公司", "-510014002": "当前用户没有添加客户的权限", "-510014003": "延伸客户是否存在", "-510014004": "客户是否存在", "-510014005": "来源订单是否存在", "-510014006": "编辑模式订单是否存在[只能编辑自己公司的订单]", "-510014007": "只能编辑状态为新单据的订单", "-510014008": "添加主单信息失败", "-510014009": "编辑主单信息失败", "-510014010": "承运商是否存在",
        "-510015001": "当前用户没有关联公司", "-510015002": "当前用户没有添加订单物品的权限", "-510015003": "物品是否存在", "-510015004": "订单是否存在", "-510015005": "物品添加失败", "-510015006": "物品编辑失败",
        "-510016001": "当前用户没有关联公司", "-510016002": "当前用户没有添加物品的权限", "-510016003": "物品类型是否存在", "-510016004": "添加物品失败", "-510016005": "编辑物品失败",
        "-510017001": "当前用户没有关联公司", "-510017002": "当前用户没有接受订单的权限", "-510017003": "订单是否存在", "-510017004": "订单是否已经被接受", "-510017005": "接受订单失败", "-510017006": "添加订单流程失败",
        "-510018001": "当前用户没有关联公司", "-510018002": "当前用户没有分配订单的权限", "-510018003": "订单是否存在", "-510018004": "订单是否已经被分配", "-510018005": "车辆是否存在", "-510018006": "司机是否存在", "-510018007": "分配订单失败", "-510018008": "添加订单流程失败",
        "-510019001": "当前用户没有关联公司", "-510019002": "当前用户没有签收订单的权限", "-510019003": "订单是否存在", "-510019004": "订单是否已经被签收", "-510019005": "签收订单失败", "-510019006": "添加订单流程失败", "-510019007": "更新实签数量，异常数量失败",
        "-510020001": "当前用户没有关联公司", "-510020002": "当前用户没有提交订单回单的权限", "-510020003": "订单是否存在", "-510020004": "订单是否已经回单", "-510020005": "回单路径不能为空", "-510020006": "订单回单编辑失败", "-510020007": "添加订单流程失败",
        "-510021001": "当前用户没有关联公司", "-510021002": "当前用户没有添加客户的权限", "-510021003": "收件人公司编号是否有效", "-510021004": "序列号生成失败", "-510021005": "收件人添加失败", "-510021006": "收件人修改失败", "-510021007": "客户是否存在", "-510021008": "收件人名称已存在",
        "-510022001": "当前用户没有关联公司", "-510022002": "当前用户没有发送订单的权限", "-510022003": "订单是否存在", "-510022004": "订单是否已经被发送", "-510022005": "承运商是否存在", "-510022006": "发送订单失败", "-510022007": "添加订单流程失败", "-510022008": "指定承运商失败",
        "-510023001": "当前用户没有关联公司", "-510023002": "当前用户没有操作承运商的权限", "-510023003": "承运商公司编号是否有效", "-510023004": "接受失败", "-510023005": "拒绝失败", "-510023006": "",
        "-510024001": "只有管理员有权执行该操作", "-510024002": "公司编号是否有效", "-510024003": "启用或禁用失败",
        "-510025001": "当前用户没有关联公司", "-510025003": "当前用户没有拆单的权限", "-510025003": "来源订单不存在", "-510025004": "拆单后原始订单保留，原始订单状态修改为待签收失败", "-510025005": "复制原单失败", "-510025006": "写订单状态变更记录失败", "-510025007": "写订单状态变更记录失败",
        "-510026001": "当前用户没有关联公司", "-510026002": "当前用户没有添加订单费用的权限", "-510026003": "订单是否存在", "-510026004": "费用类型是否存在", "-510026005": "更新或添加失败",
        "-510028001": "当前用户没有关联公司", "-510028002": "当前用户没有启用或禁用客户的权限", "-510028003": "客户编号是否有效", "-510028004": "启用或禁用失败",
        "-510029001": "当前用户没有关联公司", "-510029002": "当前用户没有启用或禁用承运商的权限", "-510029003": "承运商编号是否有效", "-510029004": "启用或禁用失败",
        "-510030001": "当前用户没有关联公司", "-510030002": "当前用户没有启用或禁用最终用户的权限", "-510030003": "最终用户编号是否有效", "-510030004": "启用或禁用失败",
        "-510031001": "订单号是否存在", "-510031002": "下单公司是否是承运商的客户", "-510031003": "获取承运商的公司管理员", "-510031004": "下单失败", "-510031005": "订单的附属表(TMS_OrderCost)", "-510031006": "订单附属表(TMS_OrderGoods)",
        "-510032001": "当前用户没有关联公司", "-510032002": "当前用户没有添加承运商的权限", "-510032003": "当前承运商是否存在", "-510032004": "线下承运商是否重名", "-510032005": "承运商编辑失败", "-510032006": "承运商新增失败",
        "-510033001": "当前用户没有关联公司", "-510033002": "当前用户没有打回订单的权限", "-510033003": "订单不存在", "-510033004": "已经委托供应商承运的单子暂时不能打回", "-510033005": "已审核(待分配)", "-510033006": "已分配(待签收)", "-510033007": "已签收(待回单)", "-510033008": "打回订单失败", "-510033009": "添加流程失败",
        "-510034001": "当前用户没有关联公司", "-510034002": "当前用户没有关闭订单的权限", "-510034003": "订单不存在", "-510034004": "关闭订单失败", "-510034005": "添加流程失败",
        "-510035001": "当前用户没有关联公司", "-510035002": "当前用户没有添加订单备注的权限", "-510035003": "源订单不存在", "-510035004": "添加备注失败",
        "-510036001": "当前用户没有关联公司", "-510036002": "当前用户没有发送订单的权限", "-510036003": "原始订单是否存在，是否处于待调度状态(只有运输订单允许调度)", "-510036004": "自营", "-510036005": "自营,车辆不存在", "-510036006": "自营,司机不存在", "-510036007": "自营,分配订单失败", "-510036008": "自营,添加订单流程失败", "-510036009": "承运方,车辆不存在", "-510036010": "承运方,司机不存在", "-510036011": "承运方,分配订单失败", "-510036012": "承运方,添加订单流程失败",
        "-510036001": "当前用户没有关联公司", "-510036002": "当前用户没有发送订单的权限", "-510036003": "原始订单是否存在，是否处于待调度状态(只有运输订单允许调度)", "-510036004": "自营", "-510036005": "自营,车辆不存在", "-510036006": "自营,司机不存在", "-510036007": "自营,分配订单失败", "-510036008": "自营,添加订单流程失败", "-510036009": "承运方,车辆不存在", "-510036010": "承运方,司机不存在", "-510036011": "承运方,分配订单失败", "-510036012": "承运方,添加订单流程失败",
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
                        Exit();
                    }
                    else if ( location.href.split( '.aspx' )[0].split( '/' )[3] == 'splitSingle' )
                    {
                        location.href = '/OrderSend.aspx';
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
                    alert( '错误信息：' + _msg[_ret.rs[0].rows[0][key]] );
                }
            }
        }
    }
}

//拆单
$( '.add_place' ).click( function ()
{
    var addtr = "<tr><td colspan='1' style='border-right:1px solid #e1e6eb;'><span style='float:left;color:#666;'>途径地：</span></td><td colspan='8'><input type='text' name='WayTo' placeholder='请输入途径地' style='border:0;width:700px;line-height:34px;'/></td><td  style=\"border: 1px solid #e1e6eb;\"><span style=\"float: left; color: #666;\">时间：</span></td><td class=\"\" ><input name=\"ToTime\"   oc=\"date\" class=\"laydate-icon edit\" onclick=\"TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )\" f-options=\"{'code':'ToTime','type':'date','etype':'editable','len':'50'}\" verify=\"{}\"></td><td  style='border:1px solid #e1e6eb;'><a class='delete_tr pull-right' style=' margin-left:10px;'>删除</a></td></tr>";
    $( '.last_place' ).before( addtr );
    $( '.delete_tr' ).click( function ()
    {
        $( this ).parent().parent().remove();
    } )
} )

function AddGoodsbar( obj )
{
    $( '.delete_goodsbar' ).click( function ()
    {
        $( this ).parent().parent().remove();
    } )

    var _trObj = $( obj ).closest( 'tr' );
    _trObj.find( 'a' ).attr( 'onclick', 'DelGoodsbar(this)' );
    _trObj.find( 'a' ).text( '删除' );

    $( obj ).closest( 'tbody' ).append( _trObj.outerHTML() );

    _trObj.find( 'a' ).attr( 'onclick', 'AddGoodsbar(this)' );
    _trObj.find( 'a' ).text( '添加' );
}

function DelGoodsbar( obj )
{
    $( obj ).closest( 'tr' ).remove();
}


function SplitSingle()
{
    var _from = $( 'input[name="InputFrom"]' ).val();
    var _to = $( 'input[name="InputTo"]' ).val();

    if ( _from == '' )
    {
        alert( '起始地不能为空' );
    }
    else if ( _to == '' )
    {
        alert( '目的地不能为空' );
    }
    var AddrLst = '';
    var GoodsLst = '';

    if ( typeof ( $( 'input[name="WayTo"]' ).val() ) != 'undefined' )
    {
        $( 'input[name="WayTo"]' ).each( function ( index )
        {
            if ( index % 2 == 0 )
            {
                if ( index > 0 )
                {
                    _from = _to;
                }
                _to = $( this ).val();
            }
            else
            {
                _from = _to;
                _to = $( this ).val();
            }
            var _time = $( this ).closest( 'tr' ).find( 'input[name="ToTime"]' ).val();
            AddrLst += '' + _from + ',' + _to + ',' + _time +'';

            if ( $( 'input[name="WayTo"]' ).length - 1 > index )
            {
                AddrLst += ';';
            }
        } );
        _from = ';' + _to;
        _to = $( 'input[name="InputTo"]' ).val();
    }

    AddrLst += '' + _from + ',' + _to + '';

    var _goodsid = '';
    var _goodsqty = '';
    $( '.Goods' ).each( function ( index )
    {
        _goodsid = $( this ).find( $( 'input[name="GoodsID"]' ) ).val();
        _goodsqty = $( this ).find( $( 'input[name="Qty"]' ) ).val();

        GoodsLst += '' + _goodsid + '=' + _goodsqty + '';

        if ( index < $( '.Goods' ).length - 1 )
        {
            GoodsLst += ';';
        }
        else
        {
            return false;
        }
    } );

    if ( $( 'input[name="split"]' ).is( ':checked' ) == false )
    {
        AddrLst = '';
        GoodsLst = '';
    }

    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0073';

    var _paras = [{}, {}, {}];
    _paras[0].name = 'SrcOrderID';
    _paras[0].value = NSF.UrlVars.Get( 'id', location.href );
    _paras[1].name = 'AddrLst';
    _paras[1].value = AddrLst;
    _paras[2].name = 'GoodsLst';
    _paras[2].value = GoodsLst;
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
        } );
}

//删除附加费明细
function DelCost( obj )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0079';

    var _paras = [{}, {}];
    _paras[0].name = 'id';
    _paras[0].value = $( obj ).closest( 'tr' ).find( 'input[name="id"]' ).val();
    _paras[1].name = 'orderid';
    _paras[1].value = $( 'input[name="OrderID"]' ).val();
    pmls[0].paras = _paras;

    var _flag = false;

    NSF.System.Network.Ajax( '/Portal.aspx',
        JsonToStr( pmls ),
        'POST',
        false,
        function ( result, data )
        {
            if ( data[0].result )
            {
                _flag = true;
            }
            else
            {
                alert( '删除失败！' );
            }
        } );

    if ( _flag == true )
    {
        $( obj ).closest( 'tr' ).remove();
    }
}

//附加费为其它时，可写
function IsReadonly( obj )
{
    if ( $( obj ).val() == '8' )
    {
        $( 'textarea[name="Description"]' ).removeAttr( 'readonly' );
    }
    else
    {
        $( 'textarea[name="Description"]' ).attr( 'readonly', 'readonly' );
    }
}

//获取货物分类值
function GetCheckboxVal()
{
    var _sum = 0;
    $( 'input[name="Goodscategory"]:checked' ).each( function ()
    {
        _sum |= $( this ).val();
    } );

    $( 'input[name="GoodsCategory"]' ).val( _sum );
}

//常用地址自动填充地址项
function GetAddress( obj )
{
    var _value = $( obj ).find( ':selected' ).text();
    var _address = $( obj ).closest( 'tbody' );

    if ( $( obj ).attr( 'name' ).indexOf( 'Province' ) != -1 )
    {
        _address.find( 'span[name="city"]' ).text( '' );
        _address.find( 'span[name="district"]' ).text( '' );
        _address.find( 'span[name="province"]' ).text( _value );
    }
    else if ( $( obj ).attr( 'name' ).indexOf( 'City' ) != -1 )
    {
        _address.find( 'span[name="city"]' ).text( _value );
    }
    else if ( $( obj ).attr( 'name' ).indexOf( 'District' ) != -1 )
    {
        _address.find( 'span[name="district"]' ).text( _value );
    }
    var _addressVal = _address.find( 'span[name="province"]' ).text() + _address.find( 'span[name="city"]' ).text() + _address.find( 'span[name="district"]' ).text();
    _address.find( 'input[name="Address"]' ).val( _addressVal );
}

//订单中自动填充地址项
function OrderAddress( obj )
{
    var _value = $( obj ).find( ':selected' ).text();

    if ( $( obj ).find( ':selected' ).val() == '' )
    {
        _value = '';
    }

    var _address = $( obj ).closest( 'tbody' );

    if ( $( obj ).attr( 'name' ) == 'FromProvince_id' )
    {
        _address.find( 'span[name="fromcity"]' ).text( '' );
        _address.find( 'span[name="fromdistrict"]' ).text( '' );
        _address.find( 'span[name="fromprovince"]' ).text( _value );
    }
    else if ( $( obj ).attr( 'name' ) == 'FromCity_id' )
    {
        _address.find( 'span[name="fromcity"]' ).text( _value );
    }
    else if ( $( obj ).attr( 'name' ) == 'FromDistrict_id' )
    {
        _address.find( 'span[name="fromdistrict"]' ).text( _value );
    }
    var _addressValFrom = _address.find( 'span[name="fromprovince"]' ).text() + _address.find( 'span[name="fromcity"]' ).text() + _address.find( 'span[name="fromdistrict"]' ).text();
    _address.find( 'input[name="From"]' ).val( _addressValFrom );

    if ( $( obj ).attr( 'name' ) == 'ToProvince_id' )
    {
        _address.find( 'span[name="tocity"]' ).text( '' );
        _address.find( 'span[name="todistrict"]' ).text( '' );
        _address.find( 'span[name="toprovince"]' ).text( _value );
    }
    else if ( $( obj ).attr( 'name' ) == 'ToCity_id' )
    {
        _address.find( 'span[name="tocity"]' ).text( _value );
    }
    else if ( $( obj ).attr( 'name' ) == 'ToDistrict_id' )
    {
        _address.find( 'span[name="todistrict"]' ).text( _value );
    }
    var _addressValTo = _address.find( 'span[name="toprovince"]' ).text() + _address.find( 'span[name="tocity"]' ).text() + _address.find( 'span[name="todistrict"]' ).text();
    _address.find( 'input[name="To"]' ).val( _addressValTo );
}

/*备注区域*/
$('.remarks_sign').click(function(){
	$('.remarks_area').css('display','table-row');
} )

//承运商列表启用、禁用
function EODSupplier( EOD, SupplierID )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0081';

    var _paras = [{}, {}];
    _paras[0].name = 'EOD';
    _paras[0].value = EOD;
    _paras[1].name = 'SupplierID';
    _paras[1].value = SupplierID;
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

//客户列表启用、禁用
function EODCustomer( EOD, CustomerID )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0082';

    var _paras = [{}, {}];
    _paras[0].name = 'EOD';
    _paras[0].value = EOD;
    _paras[1].name = 'CustomerID';
    _paras[1].value = CustomerID;
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
//最终用户列表启用、禁用
function EODEnduser( EOD, EnduserID )
{
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0083';

    var _paras = [{}, {}];
    _paras[0].name = 'EOD';
    _paras[0].value = EOD;
    _paras[1].name = 'EnduserID';
    _paras[1].value = EnduserID;
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

//显示角色
function GetRole()
{
    var _roleID = $( 'input[name="RoleID"]' ).val();

    $( 'input[name="RoleID_id"]' ).each( function ()
    {
        var _val = parseInt( $( this ).val() ) & parseInt( _roleID );
        if ( _val == parseInt( $( this ).val() ) )
        {
            $( this ).attr( 'checked', true );
        }
    } );
}

function GoodsCategory()
{
    var _GoodsCategory = $( 'input[name="GoodsCategory"]' ).val();

    $( 'input[name="Goodscategory"]' ).each( function ()
    {
        var _val = parseInt( $( this ).val() ) & parseInt( _GoodsCategory );
        if ( _val == parseInt( $( this ).val() ) )
        {
            $( this ).attr( 'checked', true );
        }
    } );


    if ( $( 'input[name="TransportMode"]' ).val() == '2' )
    {
        $( 'tr[name="CarInfo"]' ).show();
    }
    else
    {
        $( 'tr[name="CarInfo"]' ).hide();
    }
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

function IsBackOrder( OrderID )
{
    $( '#myModal' ).modal( 'show' );
    $( 'input[name="OrderID"]' ).val( OrderID );
}
//打回
function SendBackOrder()
{
    $( '#myModal' ).modal( 'hide' );
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0089';

    var _paras = [{}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $( 'input[name="OrderID"]' ).val(  );
    _paras[1].name = 'Description';
    _paras[1].value = $( 'textarea[name="Description"]' ).val();
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
    $( 'textarea[name="Description"]' ).val( '' );
}

function Closed( OrderID )
{
    $( '#ClosedModal' ).modal( 'show' );
    $( 'input[name="COrderID"]' ).val( OrderID );
}

function ClosedOrder()
{
    $( '#ClosedModal' ).modal( 'hide' );
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0090';

    var _paras = [{}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $( 'input[name="COrderID"]' ).val();
    _paras[1].name = 'Description';
    _paras[1].value = $( 'textarea[name="CDescription"]' ).val();
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
    $( 'textarea[name="CDescription"]' ).val( '' );
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

function ScheduleOrder()
{
    $( '#myModal' ).modal( 'hide' );

    var _DriverID = $( 'input[name="DriverID"]' ).val();
    var _CarID = $( 'input[name="CarID"]' ).val();
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0093';

    var _paras = [{}, {}, {}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = NSF.UrlVars.Get( 'id', location.href );
    _paras[1].name = 'SupplierID';
    _paras[1].value = $( 'input[name="SupplierID"]' ).val();
    _paras[2].name = 'DriverID';
    _paras[2].value = _DriverID
    _paras[3].name = 'CarID';
    _paras[3].value = _CarID;
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
var colsPanH = $('textarea').parent().attr('colspan') * 35;
$('textarea').css('height', colsPanH);

//生成日期控件
function GetDateEvent( that, options )
{
    options.choose = function ( dates )
    {
        $( that ).trigger( 'change' );
    };
    laydate( options );
}

//营业额统计
function TurnoverStat()
{
    var start = dataTime_chart()[0];
    var end = dataTime_chart()[1];
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0001","paras":[{"name":"starttime","value":"' + start + ' 00:00:00"},{"name":"endtime","value":"' + end + ' 23:59:59"}]}]';
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                    	var chartsName = [];
                    	var chartsTotal = [[],[],[],[]];
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].CustomerName + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalVolume + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalWeight + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalAmount + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalCost + '</td>';
                            _html += '</tr>';
                            chartsName[i] = data[0].rs[0].rows[i].CustomerName;
                            chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i].TotalVolume));
                            chartsTotal[1].push(parseFloat(data[0].rs[0].rows[i].TotalWeight));
                            chartsTotal[2].push(parseFloat(data[0].rs[0].rows[i].TotalAmount));
                            chartsTotal[3].push(parseFloat(data[0].rs[0].rows[i].TotalCost));
                        }
                        var series = [];
                        series[0] = {name:'总体积(方)',data:chartsTotal[0]};
                        series[1] = {name:'总重量(吨)',data:chartsTotal[1]};
                        series[2] = {name:'订单数量(个)',data:chartsTotal[2]};
                        series[3] = {name:'总运费(元)',data:chartsTotal[3]};
                        
//                      $('.hr_charts').removeClass('hide');
                        ColumnChart('highcharts', start, end, chartsName, series, '营业额');					
                    }
                    else
                    {
                        _html += '<tr><td colspan="5" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                        $('.highcharts').html('');
                        $('.hr_charts').addClass('hide');
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}
//货代统计
function SuppGood()
{
    var start = $( 'input[name="startime"]' ).val() + ' 00:00:00';
    var end = $( 'input[name="endtime"]' ).val() + ' 23:59:59';
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0002","paras":[{"name":"starttime","value":"' + start + '"},{"name":"endtime","value":"' + end + '"}]}]';
        NSF.System.Network.Ajax( '/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.SuppGood' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].SupplierName + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Volume + '</td><td>' + data[0].rs[0].rows[i].Weight + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Amount + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Count + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Total + '</td>';
                            _html += '</tr>';
                        }                       
                    }
                    else
                    {
                        _html += '<tr><td colspan="5" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                    }
                    $( '.SuppGood' ).append( _html );
                }
            }
        )
    }
}
//自营配送报表
function SuppSelf()
{
    var start = $( 'input[name="startime"]' ).val() + ' 00:00:00';
    var end = $( 'input[name="endtime"]' ).val() + ' 23:59:59';
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0003","paras":[{"name":"starttime","value":"' + start + '"},{"name":"endtime","value":"' + end + '"}]}]';
        NSF.System.Network.Ajax( '/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.SelfYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].DriverName + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].CarSN + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Volume + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Weight + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Amount + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Count + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Total + '</td>';
                            _html += '</tr>';
                        }
                    }
                    else
                    {
                        _html += '<tr><td colspan="6" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                    }
                    $( '.SelfYL' ).append( _html );
                }
            }
        )
    }
}
//判断浏览器为火狐
$(function()
{
	if (navigator.userAgent.indexOf('Firefox') >= 0)
	{
		//更改日期控件onclick 调用函数，此方式日期限制无效
		$('input[name="FromTime"],input[name="ToTime"],input[name="StartTime"],input[name="EndTime"],input[name="WayToTime"],input[placeholder="制单时间"],input[placeholder="起始时间"],input[placeholder="结束时间"],input[name="Birthday"]').attr('onclick','laydate( {format: "YYYY/MM/DD"})');
		$('input[name="startime"],input[name="endtime"]').attr('onclick','laydate({format: "YYYY/MM/DD"})');
	} 
});

//通用取起始时间
function dataTime_chart()
{
	var start = $( 'input[name="startime"]' ).val();
    var end = $( 'input[name="endtime"]' ).val();
    if($( 'input[name="endtime"]' ).val() == '') //判断截止日期是否选填，如未选填则默认为当前日期
    {
    	var mydate = new Date();
	    end = "" + mydate.getFullYear() + "/" + ((mydate.getMonth()+1)<10 ? "0" + (mydate.getMonth()+1) : (mydate.getMonth()+1))+ '/' + (mydate.getDate()<10 ? "0"+ mydate.getDate() : mydate.getDate());
    	$( 'input[name="endtime"]' ).val(end);
    }
    var time = new Array(start, end);
    return time;
}
//柱形图
function ColumnChart(className, ShowStart, ShowEnd, chartsName, series, StatName) //类名，起始时间，名称，数据,统计名称
{
	$('.'+className).highcharts({
	    chart: {
	        type: 'column'
	    },
	    title: {
	        text: '('+ ShowStart +'-'+ ShowEnd +') '+ StatName
	    },
	    xAxis: {
	        categories: chartsName,
	        crosshair: true
	    },
	    yAxis: {
	        min: 0,
	        title: {
	            text: ''
	        }

	    },
	    credits: {
	    	text: '',
	    	href: ''
		},
	    tooltip: {
	        headerFormat: '<span style="font-size:10px">{point.key}</span><table style="width:100px;">',
	        pointFormat: '<tr><td style="color:{series.color};padding:0;text-align:left">{series.name}: </td></tr>'+
							  '<td style="padding:0;text-align:left"><b>{point.y}</b></td></tr>',
	        footerFormat: '</table>',
	        shared: true,
	        useHTML: true
	    },
	    plotOptions: {
	        column: {
	            pointPadding: 0.2,
	            borderWidth: 0
	        }
	    },
	    series
	});	
}
/**************
//条形图调用方式
var chartsName = [];
var chartsTotal = [[],[],[],[]];
for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
{
	_html += '<tr>';
	_html += '<td>' + data[0].rs[0].rows[i].CustomerName + '</td>';
	_html += '<td>' + data[0].rs[0].rows[i].TotalVolume + '</td>';
	_html += '<td>' + data[0].rs[0].rows[i].TotalWeight + '</td>';
	_html += '<td>' + data[0].rs[0].rows[i].TotalAmount + '</td>';
	_html += '<td>' + data[0].rs[0].rows[i].TotalCost + '</td>';
	_html += '</tr>';
	chartsName[i] = data[0].rs[0].rows[i].CustomerName;
	chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i].TotalVolume));
}
var series = [];
series[0] = {name:'各公司所占比',data:chartsTotal[0]};
$('.hr_charts').removeClass('hide');
BarChart('highcharts', start, end, chartsName, series, '应收结账');	

//通用条形图
function BarChart( className, ShowStart, ShowEnd, chartsName, series, StatName, TotalValue ) //类名，起始时间，名称，数据,统计名称,总计数值
{            
	$( '.' + className ).highcharts(
	{                                           
		chart: 
		{                                                           
			type: 'bar'                                                    
		},                                                                 
		title: 
		{                                                           
			text: '('+ ShowStart +'-'+ ShowEnd +') '+ StatName                   
		},                                                                 
		xAxis: 
		{                                                           
			categories: chartsName,
			title:
			{
				align: 'high',
				offset: 0,
				text: '公司名称',
				rotation: 0,
				y:20,
				x:-5
			}                                                     
		},                                                                 
		yAxis: 
		{                                                           
			min: 20,
			title:
			{
				align: 'high',
				text: '单位/万元'
			} 
		},                                                                 
		tooltip: 
		{
			shared: true,
			useHTML: true,
			headerFormat: '<small>{point.key}</small><table>',
			pointFormat: '<tr><td style="color: {series.color}">所占比例: </td>' +
			'<td style="text-align: right"><b>{point.y}</b></td></tr>',
			footerFormat: '</table>',
			valueDecimals: 2
		},                                                            
		plotOptions: 
		{                                                     
			bar: 
			{                                                         
				dataLabels: 
				{                                              
					enabled: true,
					formatter:function()
					{
						return '{y}/' + this.point.y / TotalValue * 100 +"%";	
					}					
				}                                                          
			}                                                              
		},                                                                
		credits: 
		{                                                         
			enabled: false                                                 
		},                                                                 
		series 
	});                                                                                                                                                                                                                				
}
**************/
//客户利润报表
function OCusPro()
{
	var start = dataTime_chart()[0];
    var end = dataTime_chart()[1];
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0009","paras":[{"name":"starttime","value":"' + start + ' 00:00:00"},{"name":"endtime","value":"' + end + ' 23:59:59"}]}]';
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                    	var chartsName = [];
                    	var chartsTotal = [[],[],[],[],[],[]];
                        var _TotalCost = 0, _TotalAmount = 0, _TotalWeight = 0, _TotalVolume = 0, _TotalPrime = 0, _Profit = 0;

                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].CustomerName + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalCost + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalAmount + '</td>';                            
                            _html += '<td>' + data[0].rs[0].rows[i].TotalWeight + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalVolume + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalPrime + '</td>';
                            _html += '<td>' + parseFloat(data[0].rs[0].rows[i].TotalCost - data[0].rs[0].rows[i].TotalPrime).toFixed(2) + '</td>';
                            _html += '</tr>';
                            chartsName[i] = data[0].rs[0].rows[i].CustomerName;
                            chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i].TotalCost));
                            chartsTotal[1].push(parseFloat(data[0].rs[0].rows[i].TotalAmount));
                            chartsTotal[2].push(parseFloat(data[0].rs[0].rows[i].TotalWeight));
                            chartsTotal[3].push(parseFloat(data[0].rs[0].rows[i].TotalVolume));
                            chartsTotal[4].push(parseFloat(data[0].rs[0].rows[i].TotalPrime));
                            chartsTotal[5].push(parseFloat(data[0].rs[0].rows[i].TotalCost - data[0].rs[0].rows[i].TotalPrime));

                            _TotalCost += parseFloat(data[0].rs[0].rows[i].TotalCost);
                            _TotalAmount += parseFloat(data[0].rs[0].rows[i].TotalAmount);
                            _TotalWeight += parseFloat(data[0].rs[0].rows[i].TotalWeight);
                            _TotalVolume += parseFloat(data[0].rs[0].rows[i].TotalVolume);
                            _TotalPrime += parseFloat(data[0].rs[0].rows[i].TotalPrime);
                            _Profit += parseFloat(data[0].rs[0].rows[i].TotalCost - data[0].rs[0].rows[i].TotalPrime);
                        }
                        var series = [];
                        series[0] = {name:'总收入(元)',data:chartsTotal[0]};
                        series[1] = {name:'订单数量(个)',data:chartsTotal[1]};
                        series[2] = {name:'总重量(吨)',data:chartsTotal[2]};
                        series[3] = {name:'总体积(方)',data:chartsTotal[3]};
                        series[4] = {name:'总成本(元)',data:chartsTotal[4]};
                        series[5] = {name:'总利润(元)',data:chartsTotal[5]};

                        _html += '<tr>';
                        _html += '<td>合计</td>';
                        _html += '<td>' + _TotalCost.toFixed(2) + '</td>';
                        _html += '<td>' + _TotalAmount + '</td>';                            
                        _html += '<td>' + _TotalWeight.toFixed(4) + '</td>';
                        _html += '<td>' + _TotalVolume.toFixed(6) + '</td>';
                        _html += '<td>' + _TotalPrime.toFixed(2) + '</td>';
                        _html += '<td>' + _Profit.toFixed(2) + '</td>';
                        _html += '</tr>';
                        
//                      $('.hr_charts').removeClass('hide');
                        ColumnChart('highcharts', start, end, chartsName, series, '客户利润报表');					
                    }
                    else
                    {
                        _html += '<tr><td colspan="7" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                        $('.highcharts').html('');
                        $('.hr_charts').addClass('hide');
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}
//订单利润报表
function OCPro()
{
	var start = dataTime_chart()[0] + ' 00:00:00';
    var end = dataTime_chart()[1] + ' 23:59:59';
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0010","paras":[{"name":"starttime","value":"' + start + '"},{"name":"endtime","value":"' + end + '"}]}]';
    	NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                    	var chartsName = [];
                    	var chartsTotal = [[],[],[],[],[],[]];
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td title="'+data[0].rs[0].rows[i].Code+'">' + data[0].rs[0].rows[i].Code + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].PactCode + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].CreateTime + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].CustomerName + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalCost + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Qty + '</td>';                            
                            _html += '<td>' + data[0].rs[0].rows[i].TotalWeight + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalVolume + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalPrime + '</td>';
                            _html += '<td>' + parseFloat(data[0].rs[0].rows[i].TotalCost - data[0].rs[0].rows[i].TotalPrime).toFixed(2) + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].EndUser + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].From + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].To + '</td>';
                            _html += '</tr>';
                            chartsName[i] = data[0].rs[0].rows[i].EndUser;
                            chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i].TotalCost));
                            chartsTotal[1].push(parseFloat(data[0].rs[0].rows[i].TotalAmount));
                            chartsTotal[2].push(parseFloat(data[0].rs[0].rows[i].TotalWeight));
                            chartsTotal[3].push(parseFloat(data[0].rs[0].rows[i].TotalVolume));
                            chartsTotal[4].push(parseFloat(data[0].rs[0].rows[i].TotalPrime));
                            chartsTotal[5].push(parseFloat(data[0].rs[0].rows[i].TotalCost - data[0].rs[0].rows[i].TotalPrime));
                        }
                        var series = [];
                        series[0] = {name:'收入(元)',data:chartsTotal[0]};
                        series[1] = {name:'订单数量(个)',data:chartsTotal[1]};
                        series[2] = {name:'总重量(吨)',data:chartsTotal[2]};
                        series[3] = {name:'总体积(方)',data:chartsTotal[3]};
                        series[4] = {name:'成本(元)',data:chartsTotal[4]};
                        series[5] = {name:'利润(元)',data:chartsTotal[5]};
                        
//                      $('.hr_charts').removeClass('hide');
                        ColumnChart('highcharts', start, end, chartsName, series, '订单利润报表');					
                    }
                    else
                    {
                        _html += '<tr><td colspan="13" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                        $('.highcharts').html('');
                        $('.hr_charts').addClass('hide');
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}
//承运商成本报表
function CarCostReport()
{
	var start = dataTime_chart()[0];
    var end = dataTime_chart()[1];
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0005","paras":[{"name":"starttime","value":"' + start + ' 00:00:00"},{"name":"endtime","value":"' + end + ' 23:59:59"}]}]';
    	NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                    	var chartsName = [];
                    	var chartsTotal = [[],[],[],[]];
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].SupplierName + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalCost + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalAmount + '</td>';                            
                            _html += '<td>' + data[0].rs[0].rows[i].TotalWeight + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalVolume + '</td>';                            
                            _html += '</tr>';
                            chartsName[i] = data[0].rs[0].rows[i].SupplierName;
                            chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i].TotalCost));
                            chartsTotal[1].push(parseFloat(data[0].rs[0].rows[i].TotalAmount));
                            chartsTotal[2].push(parseFloat(data[0].rs[0].rows[i].TotalWeight));
                            chartsTotal[3].push(parseFloat(data[0].rs[0].rows[i].TotalVolume));                            
                        }
                        var series = [];
                        series[0] = {name:'总运费(元)',data:chartsTotal[0]};
                        series[1] = {name:'订单数量(个)',data:chartsTotal[1]};
                        series[2] = {name:'总重量(吨)',data:chartsTotal[2]};
                        series[3] = {name:'总体积(方)',data:chartsTotal[3]};
                        
//                      $('.hr_charts').removeClass('hide');
                        ColumnChart('highcharts', start, end, chartsName, series, '承运商成本报表');					
                    }
                    else
                    {
                        _html += '<tr><td colspan="5" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                        $('.highcharts').html('');
                        $('.hr_charts').addClass('hide');
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}
//运输方式成本报表
function TranCostReport()
{
	var start = dataTime_chart()[0];
    var end = dataTime_chart()[1];
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0002","paras":[{"name":"starttime","value":"' + start + ' 00:00:00"},{"name":"endtime","value":"' + end + ' 23:59:59"}]}]';
    	NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].ShipModeName + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalCost + '</td>';                            
                            _html += '</tr>';                              
                        }
                    }
                    else
                    {
                        _html += '<tr><td colspan="2" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}
//运输类型成本报表
function TranTypeCReport()
{
	var start = dataTime_chart()[0];
    var end = dataTime_chart()[1];
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0003","paras":[{"name":"starttime","value":"' + start + ' 00:00:00"},{"name":"endtime","value":"' + end + ' 23:59:59"}]}]';
    	NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].TransportModeName + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalCost + '</td>';                            
                            _html += '</tr>';                              
                        }
                    }
                    else
                    {
                        _html += '<tr><td colspan="2" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}
//自营成本报表
function SelfCReport()
{
	var start = dataTime_chart()[0];
    var end = dataTime_chart()[1];
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0006","paras":[{"name":"starttime","value":"' + start + ' 00:00:00"},{"name":"endtime","value":"' + end + ' 23:59:59"}]}]';
    	NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                    	var chartsName = [];
                    	var chartsTotal = [[],[],[],[]];
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].SymbolName + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalCost + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalAmount + '</td>';                            
                            _html += '<td>' + data[0].rs[0].rows[i].TotalWeight + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalVolume + '</td>';                            
                            _html += '</tr>';
                            chartsName[i] = data[0].rs[0].rows[i].SymbolName;
                            chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i].TotalCost));
                            chartsTotal[1].push(parseFloat(data[0].rs[0].rows[i].TotalAmount));
                            chartsTotal[2].push(parseFloat(data[0].rs[0].rows[i].TotalWeight));
                            chartsTotal[3].push(parseFloat(data[0].rs[0].rows[i].TotalVolume));                            
                        }
                        var series = [];
                        series[0] = {name:'总运费(元)',data:chartsTotal[0]};
                        series[1] = {name:'订单数量(个)',data:chartsTotal[1]};
                        series[2] = {name:'总重量(吨)',data:chartsTotal[2]};
                        series[3] = {name:'总体积(方)',data:chartsTotal[3]};
                        
//                      $('.hr_charts').removeClass('hide');
                        ColumnChart('highcharts', start, end, chartsName, series, '自营成本报表');					
                    }
                    else
                    {
                        _html += '<tr><td colspan="5" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                        $('.highcharts').html('');
                        $('.hr_charts').addClass('hide');
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}
//费用类型成本
function CTCReport()
{
	var start = dataTime_chart()[0];
    var end = dataTime_chart()[1];
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0004","paras":[{"name":"starttime","value":"' + start + ' 00:00:00"},{"name":"endtime","value":"' + end + ' 23:59:59"}]}]';
    	NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                    	var chartsName = [];
                    	var chartsTotal = [[]];
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].Type + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].Amount + '</td>';                        
                            _html += '</tr>';
                            chartsName[i] = data[0].rs[0].rows[i].Type;
                            chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i].Amount));                       
                        }
                        var series = [];
                        series[0] = {name:'总运费(元)',data:chartsTotal[0]};
                        
//                      $('.hr_charts').removeClass('hide');
                        ColumnChart('highcharts', start, end, chartsName, series, '费用类型成本报表');					
                    }
                    else
                    {
                        _html += '<tr><td colspan="2" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                        $('.highcharts').html('');
                        $('.hr_charts').addClass('hide');
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}
//收入支出报表
function IAEReport()
{
	var start = dataTime_chart()[0];
    var end = dataTime_chart()[1];
    if ( start != '' && end != '' )
    {
        var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0011","paras":[{"name":"starttime","value":"' + start + ' 00:00:00"},{"name":"endtime","value":"' + end + ' 23:59:59"}]}]';
    	NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalPrime + '</td>';
                            _html += '<td>' + data[0].rs[0].rows[i].TotalCost + '</td>';                        
                            _html += '</tr>';                                      
                        }                       		
                    }
                    else
                    {
                        _html += '<tr><td colspan="2" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}
//营业额月报表
function TurnoverSelect()
{
	var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0008","paras":[]}]';
	NSF.System.Network.Ajax('/Portal.aspx',
        vml,
        'POST',
        false,
        function ( result, data )
        {
            if ( result )
            {
                var _html = '';
                $( '.jplistYL' ).html( '' );
                $( '.text-pos' ).addClass( 'jplist-hidden' );
                var length = data[0].rs.length;
                if ( length != 0 )
                {
                	var chartsName = ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'];
                	var chartsTotal = [[]];
                	var year = '';
                    for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                    {
                        _html += '<tr>';
                        _html += '<td>' + data[0].rs[0].rows[i].Year + '</td>';
                        _html += '<td>' + data[0].rs[0].rows[i][1] + '</td>';
                        _html += '<td>' + data[0].rs[0].rows[i][2]+ '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][3] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][4] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][5] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][6] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][7] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][8] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][9] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][10] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][11] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][12] + '</td>'; 
                        _html += '</tr>';
                        chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i][1]),parseFloat(data[0].rs[0].rows[i][2]),parseFloat(data[0].rs[0].rows[i][3]),parseFloat(data[0].rs[0].rows[i][4]),parseFloat(data[0].rs[0].rows[i][5]),parseFloat(data[0].rs[0].rows[i][6]),parseFloat(data[0].rs[0].rows[i][7]),parseFloat(data[0].rs[0].rows[i][8]),parseFloat(data[0].rs[0].rows[i][9]),parseFloat(data[0].rs[0].rows[i][10]),parseFloat(data[0].rs[0].rows[i][11]),parseFloat(data[0].rs[0].rows[i][12]));
                        year = data[0].rs[0].rows[i].Year;
                    }
                    var series = [];
                    series[0] = {name:'金额(元)',data:chartsTotal[0]};
                    
//                  $('.hr_charts').removeClass('hide');
                    ColumnChart('highcharts', year, '', chartsName, series, '营业额月报表');					
                }
                else
                {
                    _html += '<tr><td colspan="13" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                    $('.highcharts').html('');
                    $('.hr_charts').addClass('hide');
                }
                $( '.jplistYL' ).append( _html );
            }
        })
}
//成本月报表
function CostMontR()
{
	var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0007","paras":[]}]';
	NSF.System.Network.Ajax('/Portal.aspx',
        vml,
        'POST',
        false,
        function ( result, data )
        {
            if ( result )
            {
                var _html = '';
                $( '.jplistYL' ).html( '' );
                $( '.text-pos' ).addClass( 'jplist-hidden' );
                var length = data[0].rs.length;
                if ( length != 0 )
                {
                	var chartsName = ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'];
                	var chartsTotal = [[]];
                	var year = '';
                    for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                    {
                        _html += '<tr>';
                        _html += '<td>' + data[0].rs[0].rows[i].Year + '</td>';
                        _html += '<td>' + data[0].rs[0].rows[i][1] + '</td>';
                        _html += '<td>' + data[0].rs[0].rows[i][2]+ '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][3] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][4] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][5] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][6] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][7] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][8] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][9] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][10] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][11] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][12] + '</td>'; 
                        _html += '</tr>';
                        chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i][1]),parseFloat(data[0].rs[0].rows[i][2]),parseFloat(data[0].rs[0].rows[i][3]),parseFloat(data[0].rs[0].rows[i][4]),parseFloat(data[0].rs[0].rows[i][5]),parseFloat(data[0].rs[0].rows[i][6]),parseFloat(data[0].rs[0].rows[i][7]),parseFloat(data[0].rs[0].rows[i][8]),parseFloat(data[0].rs[0].rows[i][9]),parseFloat(data[0].rs[0].rows[i][10]),parseFloat(data[0].rs[0].rows[i][11]),parseFloat(data[0].rs[0].rows[i][12]));
                        year = data[0].rs[0].rows[i].Year;
                    }
                    var series = [];
                    series[0] = {name:'金额(元)',data:chartsTotal[0]};
                    
//                  $('.hr_charts').removeClass('hide');
                    ColumnChart('highcharts', year, '', chartsName, series, '成本月报表');					
                }
                else
                {
                    _html += '<tr><td colspan="13" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                    $('.highcharts').html('');
                    $('.hr_charts').addClass('hide');
                }
                $( '.jplistYL' ).append( _html );
            }
        })
}
//实际利润月报表
function ActualPMR()
{
	var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0012","paras":[]}]';
	NSF.System.Network.Ajax('/Portal.aspx',
        vml,
        'POST',
        false,
        function ( result, data )
        {
            if ( result )
            {
                var _html = '';
                $( '.jplistYL' ).html( '' );
                $( '.text-pos' ).addClass( 'jplist-hidden' );
                var length = data[0].rs.length;
                if ( length != 0 )
                {
                	var chartsName = ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'];
                	var chartsTotal = [[]];
                	var year = '';
                    for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                    {
                        _html += '<tr>';
                        _html += '<td>' + data[0].rs[0].rows[i].Year + '</td>';
                        _html += '<td>' + data[0].rs[0].rows[i][1] + '</td>';
                        _html += '<td>' + data[0].rs[0].rows[i][2]+ '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][3] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][4] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][5] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][6] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][7] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][8] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][9] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][10] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][11] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][12] + '</td>'; 
                        _html += '</tr>';
                        chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i][1]),parseFloat(data[0].rs[0].rows[i][2]),parseFloat(data[0].rs[0].rows[i][3]),parseFloat(data[0].rs[0].rows[i][4]),parseFloat(data[0].rs[0].rows[i][5]),parseFloat(data[0].rs[0].rows[i][6]),parseFloat(data[0].rs[0].rows[i][7]),parseFloat(data[0].rs[0].rows[i][8]),parseFloat(data[0].rs[0].rows[i][9]),parseFloat(data[0].rs[0].rows[i][10]),parseFloat(data[0].rs[0].rows[i][11]),parseFloat(data[0].rs[0].rows[i][12]));
                        year = data[0].rs[0].rows[i].Year;
                    }
                    var series = [];
                    series[0] = {name:'金额(元)',data:chartsTotal[0]};
                    
//                  $('.hr_charts').removeClass('hide');
                    ColumnChart('highcharts', year, '', chartsName, series, '实际利润月报表');					
                }
                else
                {
                    _html += '<tr><td colspan="13" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                    $('.highcharts').html('');
                    $('.hr_charts').addClass('hide');
                }
                $( '.jplistYL' ).append( _html );
            }
        })
}
//业务利润月报表
function BusinessPMR()
{
	var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0013","paras":[]}]';
	NSF.System.Network.Ajax('/Portal.aspx',
        vml,
        'POST',
        false,
        function ( result, data )
        {
            if ( result )
            {
                var _html = '';
                $( '.jplistYL' ).html( '' );
                $( '.text-pos' ).addClass( 'jplist-hidden' );
                var length = data[0].rs.length;
                if ( length != 0 )
                {
                	var chartsName = ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'];
                	var chartsTotal = [[]];
                	var year = '';
                    for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                    {
                        _html += '<tr>';
                        _html += '<td>' + data[0].rs[0].rows[i].Year + '</td>';
                        _html += '<td>' + data[0].rs[0].rows[i][1] + '</td>';
                        _html += '<td>' + data[0].rs[0].rows[i][2]+ '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][3] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][4] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][5] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][6] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][7] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][8] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][9] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][10] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][11] + '</td>'; 
                        _html += '<td>' + data[0].rs[0].rows[i][12] + '</td>'; 
                        _html += '</tr>';
                        chartsTotal[0].push(parseFloat(data[0].rs[0].rows[i][1]),parseFloat(data[0].rs[0].rows[i][2]),parseFloat(data[0].rs[0].rows[i][3]),parseFloat(data[0].rs[0].rows[i][4]),parseFloat(data[0].rs[0].rows[i][5]),parseFloat(data[0].rs[0].rows[i][6]),parseFloat(data[0].rs[0].rows[i][7]),parseFloat(data[0].rs[0].rows[i][8]),parseFloat(data[0].rs[0].rows[i][9]),parseFloat(data[0].rs[0].rows[i][10]),parseFloat(data[0].rs[0].rows[i][11]),parseFloat(data[0].rs[0].rows[i][12]));
                        year = data[0].rs[0].rows[i].Year;
                    }
                    var series = [];
                    series[0] = {name:'金额(元)',data:chartsTotal[0]};
                    
//                  $('.hr_charts').removeClass('hide');
                    ColumnChart('highcharts', year, '', chartsName, series, '业务利润月报表');					
                }
                else
                {
                    _html += '<tr><td colspan="13" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                    $('.highcharts').html('');
                    $('.hr_charts').addClass('hide');
                }
                $( '.jplistYL' ).append( _html );
            }
        })
}

//客户回单统计
function CusRec()
{
	var start = dataTime_chart()[0] + ' 00:00:00';
    var end = dataTime_chart()[1] + ' 23:59:59';
    
    if ( start != '' && end != '' )
    {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0086';

		var _paras = [{},{},{}];
		_paras[0].name = 'Operator';
		_paras[0].value = $('#Span2').text();
		_paras[1].name = 'MinFromTime';
		_paras[1].value = start;
		_paras[2].name = 'MaxFromTime';
		_paras[2].value = end;		
 
		pmls[0].paras = _paras;
 
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
 						var all_r ;
 						var y_r;
 						var n_r;
 						var bfb_r;
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                        	all_r = data[0].rs[0].rows[i].OrderCount;
                        	y_r = data[0].rs[0].rows[i].OrderReceipt;
                        	n_r = all_r - y_r;
                        	bfb_r = y_r/all_r;
                        	bfb_r = bfb_r.toFixed(2);
                        	bfb_r = bfb_r *100;
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].CustomerCompany + '</td>';
                            _html += '<td>' + all_r + '</td>';
                            _html += '<td>' + n_r+ '</td>';                            
                            _html += '<td>' + y_r + '</td>';
                            _html += '<td>' + bfb_r + '%</td>';
 
                            _html += '</tr>';
 
                        }
 	
                    }
                    else
                    {
                        _html += '<tr><td colspan="5" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                        $('.highcharts').html('');
                        $('.hr_charts').addClass('hide');
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}


//承运方回单统计
function CarrRec()
{
	var start = dataTime_chart()[0] + ' 00:00:00';
    var end = dataTime_chart()[1] + ' 23:59:59';
    
    if ( start != '' && end != '' )
    {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0087';

		var _paras = [{},{},{}];
		_paras[0].name = 'Operator';
		_paras[0].value = $('#Span2').text();
		_paras[1].name = 'MinFromTime';
		_paras[1].value = start;
		_paras[2].name = 'MaxFromTime';
		_paras[2].value = end;		
 
		pmls[0].paras = _paras;
 
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.jplistYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
 						var all_r ;
 						var y_r;
 						var n_r;
 						var bfb_r;
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                        	all_r = data[0].rs[0].rows[i].OrderCount;
                        	y_r = data[0].rs[0].rows[i].OrderReceipt;
                        	n_r = all_r - y_r;
 
                        	bfb_r = y_r/all_r;
                        	bfb_r = bfb_r.toFixed(2);
                        	bfb_r = bfb_r *100;                        	
                            _html += '<tr>';
                            _html += '<td>' + data[0].rs[0].rows[i].SupplierCompanyName + '</td>';
                            _html += '<td>' + all_r + '</td>';
                            _html += '<td>' + n_r+ '</td>';                            
                            _html += '<td>' + y_r + '</td>';
                            _html += '<td>' + bfb_r + '%</td>';
 
                            _html += '</tr>';
 
                        }
 	
                    }
                    else
                    {
                        _html += '<tr><td colspan="5" style="text-align:center !important">该时间段没有数据！！！</td></tr>';
                        $('.highcharts').html('');
                        $('.hr_charts').addClass('hide');
                    }
                    $( '.jplistYL' ).append( _html );
                }
            }
        )
    }
}

function OCProfitOutput(aObj) {     //订单利润导出
    var _startime = $('input[name="startime"]').val();
    var _endtime = $('input[name="endtime"]').val();
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0010","paras":[{"name":"starttime","value":"' + _startime + ' 00:00:00"},{"name":"endtime","value":"' + _endtime + ' 23:59:59"}]}]';

    if (_startime == '' || _endtime == '') {
        alert('开始日期或结束日期不能为空，请重新选择！');
    } else {
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'OCProfitOutput.aspx?start=' + _startime + '&end=' + _endtime);
                    } else {
                        alert('无数据！');
                    }
               }
            });
    }    
}

function CTCostReportOutput(aObj) {     //费用类型成本报表导出
    var _startime = $('input[name="startime"]').val();
    var _endtime = $('input[name="endtime"]').val();
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0004","paras":[{"name":"starttime","value":"' + _startime + ' 00:00:00"},{"name":"endtime","value":"' + _endtime + ' 23:59:59"}]}]';

    if (_startime == '' || _endtime == '') {
        alert('开始日期或结束日期不能为空，请重新选择！');
    } else {
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'CTCostReportOutput.aspx?start=' + _startime + '&end=' + _endtime);
                    } else {
                        alert('无数据！');
                    }
               }
            });
    }  
}

function IAEReportOutput(aObj) {            //收入支出报表
    var _startime = $('input[name="startime"]').val();
    var _endtime = $('input[name="endtime"]').val();
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0011","paras":[{"name":"starttime","value":"' + _startime + ' 00:00:00"},{"name":"endtime","value":"' + _endtime + ' 23:59:59"}]}]';

    if (_startime == '' || _endtime == '') {
        alert('开始日期或结束日期不能为空，请重新选择！');
    } else {
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'IAEReportOutput.aspx?start=' + _startime + '&end=' + _endtime);
                    } else {
                        alert('无数据！');
                    }
               }
            });
    } 
}

function TurnoverSOutput(aObj) {            //营业额月报表
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0008","paras":[]}]';

    NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'TurnoverSOutput.aspx');
                    } else {
                        alert('无数据！');
                    }
               }
            });
}

function CostMonthlyROutput(aObj) {            //成本月报表
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0007","paras":[]}]';

    NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'CostMonthlyROutput.aspx');
                    } else {
                        alert('无数据！');
                    }
               }
            });
}

function ActualPMROutput(aObj) {            //实际利润月报表
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0012","paras":[]}]';

    NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'ActualPMROutput.aspx');
                    } else {
                        alert('无数据！');
                    }
               }
            });
}

function BusinessPMROutput(aObj) {            //实际利润月报表
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0013","paras":[]}]';

    NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'BusinessPMROutput.aspx');
                    } else {
                        alert('无数据！');
                    }
               }
            });
}

function IndexOutput(aObj) {            //营业额报表
    var _startime = $('input[name="startime"]').val();
    var _endtime = $('input[name="endtime"]').val();
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0011","paras":[{"name":"starttime","value":"' + _startime + ' 00:00:00"},{"name":"endtime","value":"' + _endtime + ' 23:59:59"}]}]';

    if (_startime == '' || _endtime == '') {
        alert('开始日期或结束日期不能为空，请重新选择！');
    } else {
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'IndexOutput.aspx?start=' + _startime + '&end=' + _endtime);
                    } else {
                        alert('无数据！');
                    }
               }
            });
    } 
}

function OCustomerProfitOutput(aObj) {            //客户利润报表
    var _startime = $('input[name="startime"]').val();
    var _endtime = $('input[name="endtime"]').val();
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0009","paras":[{"name":"starttime","value":"' + _startime + ' 00:00:00"},{"name":"endtime","value":"' + _endtime + ' 23:59:59"}]}]';

    if (_startime == '' || _endtime == '') {
        alert('开始日期或结束日期不能为空，请重新选择！');
    } else {
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'OCustomerProfitOutput.aspx?start=' + _startime + '&end=' + _endtime);
                    } else {
                        alert('无数据！');
                    }
               }
            });
    } 
}

function AccountsReportOutput(aObj) {            //应收结账报表
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0014","paras":[{"name":"Year","value":"'+ new Date().getFullYear() +'"}]}]';

    NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'AccountsReportOutput.aspx');
                    } else {
                        alert('无数据！');
                    }
               }
            });
}

function CopeReportOutput(aObj) {            //应付结账报表
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0015","paras":[{"name":"Year","value":"'+ new Date().getFullYear() +'"}]}]';

    NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'CopeReportOutput.aspx');
                    } else {
                        alert('无数据！');
                    }
               }
            });
}

function CarrierCostReportOutput(aObj) {            //客户利润报表
    var _startime = $('input[name="startime"]').val();
    var _endtime = $('input[name="endtime"]').val();
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0005","paras":[{"name":"starttime","value":"' + _startime + ' 00:00:00"},{"name":"endtime","value":"' + _endtime + ' 23:59:59"}]}]';

    if (_startime == '' || _endtime == '') {
        alert('开始日期或结束日期不能为空，请重新选择！');
    } else {
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'CarrierCostReportOutput.aspx?start=' + _startime + '&end=' + _endtime);
                    } else {
                        alert('无数据！');
                    }
               }
            });
    } 
}

function SelfCostReportOutput(aObj) {            //自营成本报表
    var _startime = $('input[name="startime"]').val();
    var _endtime = $('input[name="endtime"]').val();
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0006","paras":[{"name":"starttime","value":"' + _startime + ' 00:00:00"},{"name":"endtime","value":"' + _endtime + ' 23:59:59"}]}]';

    if (_startime == '' || _endtime == '') {
        alert('开始日期或结束日期不能为空，请重新选择！');
    } else {
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'SelfCostReportOutput.aspx?start=' + _startime + '&end=' + _endtime);
                    } else {
                        alert('无数据！');
                    }
               }
            });
    } 
}

function TransportCostReportOutput(aObj) {            //运输方式成本报表
    var _startime = $('input[name="startime"]').val();
    var _endtime = $('input[name="endtime"]').val();
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0002","paras":[{"name":"starttime","value":"' + _startime + ' 00:00:00"},{"name":"endtime","value":"' + _endtime + ' 23:59:59"}]}]';

    if (_startime == '' || _endtime == '') {
        alert('开始日期或结束日期不能为空，请重新选择！');
    } else {
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'TransportCostReportOutput.aspx?start=' + _startime + '&end=' + _endtime);
                    } else {
                        alert('无数据！');
                    }
               }
            });
    } 
}

function TranTypeCostReportOutput(aObj) {            //运输类型成本报表
    var _startime = $('input[name="startime"]').val();
    var _endtime = $('input[name="endtime"]').val();
    var _that = aObj;
    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0003","paras":[{"name":"starttime","value":"' + _startime + ' 00:00:00"},{"name":"endtime","value":"' + _endtime + ' 23:59:59"}]}]';

    if (_startime == '' || _endtime == '') {
        alert('开始日期或结束日期不能为空，请重新选择！');
    } else {
        NSF.System.Network.Ajax('/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
               if (result) {
                    var length = data[0].rs.length;
                    if (length > 0) {
                        $(_that).attr('href', 'TranTypeCostReportOutput.aspx?start=' + _startime + '&end=' + _endtime);
                    } else {
                        alert('无数据！');
                    }
               }
            });
    } 
}

//导出列表数据
function toXls( tableid ) {
    new NSF.System.Converter.ToXls().method1(tableid);
    //$('div#excel').modal( "hide" );
}