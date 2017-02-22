$(function() {
    $(document).on('mouseover', 'button#search-button', function(e) {       //列表页单击按钮去空格
        $(e.target.parentElement.parentElement).find('div.text-filter-box').each( function(){
            $(this).find('input').val(  $(this).find('input').val().replace(/(^\s*)|(\s*$)/g, "") );
        });
    });

    $(document).on('keydown', 'div.text-filter-box>input', function(e) {    //列表页按回车筛选按钮
        if (e.keyCode == 13) {
            $(e.target.parentElement.parentElement).find('div.text-filter-box').each( function(){
                $(this).find('input').val(  $(this).find('input').val().replace(/(^\s*)|(\s*$)/g, "") );
            });
            $('#demo .text-filter-box button').click();
        }
    });
});

/*拖动效果*/
$('.modal-header,.modal-footer').on('mousedown',function( event ){
    drag(this.parentNode,event);
});
$('div#win-Common-Dialog .modal-body').on('mousedown',function( event ){
    drag(this.parentNode,event);
});

//时间段
function rangeOk( divModal ) {
    var min = divModal.find(".min").val();
    var max = divModal.find(".max").val();

    if (min == '' || max == '') {
        alert('日期不能有空值！')
    } else {
        $('input.'+ divModal.attr('id') +'').val( min + "|" + max + '|2' );
        divModal.modal( "hide" );
    }

}
$('input.rangeModal').on( "click", function(){
    $("div#rangeModal").modal( "show" );
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

//复选框绑定单击事件
$('input[type="checkbox"]').on('click', function() {
    if ($(this).attr('checked')) {
        $(this).removeAttr('checked');
    } else {
        $(this).attr('checked', 'checked');
    }
});

/*浏览器窗口变化时，固定头部宽度赋值*/
$(window).resize(function () {
    autoHead();
});
/*固定头部宽度赋值*/
function autoHead() {
    var autoW = $('.formcontainer').width() + 2;//+2是为了解决兼容边框
    $('.tr-fixed').css('width', autoW + 'px');
}

//修改密码
function ChangePwd(obj) {
    var that = this;
    var _execute = $(_btn).attr('ev');
    _execute = unescape(_execute);

    var Username = $('input[name="Username"]').val();
    var OldPwd = $('input[name="OldPwd"]').val();
    var NewPwd = $("input[name='NewPwd']").val();
    var ReOldPwd = $("input[name='ReOldPwd']").val();
    if (OldPwd == '') {
        alert("原密码不能为空!");
    } else if (Username == "") {
        alert("用户名不能为空！");
    } else if (NewPwd != ReOldPwd) {
        alert("两次输入的密码不一致，请重新输入!");
    } else {
        var ws = makeDefaultEvent(_execute);
        try {
            eval(ws);
        } catch (e) {
            console.log(e);
        }
    }
}

function ReceiveOrder(Accept, OrderID) {
    $('#myModal').modal('show');
    $('input[name="Accept"]').val(Accept);
    $('input[name="OrderID"]').val(OrderID);

    if (Accept == '0') {
        $('#myModalLabel').find('p').text('拒收订单');
        $('span[name="content"]').text('是否确定拒收订单');
    } else if (Accept == '1') {
        $('#myModalLabel').find('p').text('接收订单');
        $('span[name="content"]').text('是否确定接收订单');
    }
}

//接受订单
function OrderAccept() {
    $('#myModal').modal('hide');
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0066';

    var _paras = [{}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $('input[name="OrderID"]').val();
    _paras[1].name = 'Accept';
    _paras[1].value = $('input[name="Accept"]').val();

    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                Result(data[0]);

            } else {
                alert(data[0].msg);
            }
        });
}


//签收订单
function OrderSignEdit() {
    $('#myModal').modal('hide');
    var Desc_YC = $('input[name="Desc_YC"]').val();
    var GoodsQty = '';
    $('tr[nrowid="TMS_OrderGoods"]').each(function(index) {
        var OrderID = $(this).find('input[name="ListID"]').val();
        var ReceiptQty = $(this).find('input[name="ReceiptQty"]').val();
        var ExceptionQty = $(this).find('input[name="ExceptionQty"]').val();

        GoodsQty += '' + OrderID + '=' + ReceiptQty + ',' + ExceptionQty + '';

        if ($('tr[nrowid="TMS_OrderGoods"]').length - 1 > index) {
            GoodsQty += ';';
        }
    });

    $('input[name="GoodsQty"]').val(GoodsQty);
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0068';

    var _paras = [{}, {}, {}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $('input[name="OrderID"]').val();
    _paras[1].name = 'Desc_YC';
    _paras[1].value = Desc_YC;
    _paras[2].name = 'GoodsQty';
    _paras[2].value = GoodsQty;
    _paras[3].name = 'Cost_YC';
    _paras[3].value = $('input[name="Cost_YC"]').val();

    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        OrderSign);
}

function OrderSign(result, data) {
    if (data[0].result) {
        Result(data[0]);
    } else {
        alert(data[0].msg);
    }
}

function CostDetailAdd(Addition) {
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0076';

    var _paras = [{}, {}, {}, {}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $('input[name="OrderID"]').val();
    _paras[1].name = 'Type';
    _paras[1].value = $('input[name="Type"]').val();
    _paras[2].name = 'Amount';
    _paras[2].value = $('input[name="Amount"]').val();
    _paras[3].name = 'Description';
    _paras[3].value = $('textarea[name="Description"]').val();
    _paras[4].name = 'Addition';
    _paras[4].value = Addition;

    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) Result(data[0]);
        });

}
//上传回单为只读
function ReceiptDocPath() {
    $('input[name="ReceiptDocPath"]').removeAttr('type');
}


//订单回单
function OrderReceiptEdit() {
    $('#myModal').modal('hide');
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0069';

    var _paras = [{}, {}, {}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $('input[name="OrderID"]').val();
    _paras[1].name = 'ReceiptDocPath';
    _paras[1].value = $($('input[name="ReceiptDocPath"]')[1]).val();
    _paras[2].name = 'Cost_YC';
    _paras[2].value = $('input[name="Cost_YC"]').val();
    _paras[3].name = 'Desc_YC';
    _paras[3].value = $('input[name="Desc_YC"]').val();

    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        OrderReceipt);
}

function OrderReceipt(result, data) {
    if (data[0].result) {
        Result(data[0]);
    } else {
        alert(data[0].msg);
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

function back() {
    location.href = document.referrer;
}

//修改用户密码
function UpdatePwdSave() {
    var Username = $('input[name="Username"]').val();
    var OldPwd = $('input[name="OldPwd"]').val();
    var NewPwd = $('input[name="NewPwd"]').val();
    var ReOldPwd = $('input[name="ReOldPwd"]').val();

    if (NewPwd != ReOldPwd) {
        alert("两次输入的密码不一致，请重新输入!");
    } else if (OldPwd == NewPwd || OldPwd == ReOldPwd) {
        alert("原密码与新密码相同，请重新输入！");
    } else {
        DoUserPwd(Username, OldPwd, NewPwd, _UserUpdatePwd);
    }

}

function GetUpdatePwd(Username, OldPwd, NewPwd) {
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

    var Reg_ToString = NSF.System.Json.ToString(params);
    return Reg_ToString;
}

function DoUserPwd(Username, OldPwd, NewPwd, callback) {
    NSF.System.Network.Ajax('/Portal.aspx',
        GetUpdatePwd(Username, OldPwd, NewPwd),
        'POST',
        false,
        callback
    );
}

function _UserUpdatePwd(result, data) {
    if (data[0].result) {
        Result(data[0]);
    } else {
        alert(data[0].msg);
    }
}

//用户新增
function userAdd() {
    location.href = 'GeneralUserAdd.aspx';
}


//同意或拒绝成为承运方
function SupplierAccept(Op, SupplierID) {
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

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        SupplierAcceptResult);
}

function SupplierAcceptResult(result, data) {
    if (data[0].result) {
        Result(data[0]);
    } else {
        alert(data[0].msg);
    }
}

//显示错误代码
function Result(_ret) {
    var _result = {
        "Order_Result": "0",
        "Addr_Result": "0",
        "Pwd_Result": "0",
        "Company_Result": "0",
        "User_Result": "0",
        "Cost_Result": "0",
        "Back_Result": "0",
        "Flow_Result": "0",
        "Schedule_Result": "",
        "Close_Result": "",
        "Verify_Result": "",
        "Combine_Result":"",
        "Customer_Result": "",
        "Combine_Result":"",
		"Supplier_Result":"0",
        "Close_Result":"",
        "Price_Result":"",
        "Supplier_Result":"",

    };
    var _msg = {
        "-510001001": "序列号生成失败",
        "-510001002": "公司名是否重复",
        "-510001003": "新增公司失败",
        "-510002000": "只有管理员有权执行该操作",
        "-510002001": "没有找到对应公司或公司已被审核",
        "-510002002": "审核公司失败",
        "-510002003": "管理员账号是否已经存在",
        "-510002004": "添加管理员账号失败",
        "-510003001": "参数错误",
        "-510003002": "账号不存在",
        "-510003003": "账号密码与原始密码不匹配",
        "-510004001": "参数错误",
        "-510004002": "账号不存在",
        "-510004003": "只有系统管理员能重置公司管理员的密码",
        "-510004004": "公司管理员能重置其他用户的密码",
        "-510004005": "编辑密码失败",
        "-510005001": "不能添加公司管理员",
        "-510005002": "只有公司管理员才能添加用户",
        "-510005003": "用户是否已经存在",
        "-510005004": "新增用户失败",
        "-510006001": "当前用户没有关联公司",
        "-510006002": "当前用户没有修改公司资料的权限",
        "-510006003": "修改失败",
        "-510007001": "当前用户没有关联公司",
        "-510007002": "当前用户没有罗列公司用户的权限",
        "-510009001": "当前用户没有关联公司",
        "-510009002": "当前用户没有添加承运方的权限",
        "-510009003": "承运方公司编号是否有效",
        "-510009004": "客户公司是否存在,添加失败",
        "-510009005": "承运方公司不存在(存在编辑, 不存在添加，被拒绝后允许再次添加)",
        "-510009006": "添加事件通知(被邀请成为供应商)失败",
        "-510009007": "序列号生成失败",
        "-510009008": "不能添加自己的公司为承运方",
        "-510009009": "不能重复邀请同一家公司为承运方",
        "-520001001": "当前用户没有关联公司",
        "-520001002": "当前用户没有添加客户的权限",
        "-520001003": "按单报价",
        "-520001004": "按合约报价(同一合约可以多次报价)",
        "-520001005": "补充报价",
        "-520001006": "客户不存在",
        "-520001007": "原报价单是否存在，仅草稿模式允许编辑",
        "-520001008": "新增报价单失败",
        "-520001009": "编辑报价单失败",

        "-520001011": "零担费用错误",     //合约报价保存
        "-520001012": "整车费用错误",
        "-520001013": "提货费用错误",
        "-520001014": "送货费用错误",
        "-520001015": "装卸费用错误",
        "-520001016": "装卸费用错误",
        "-520001017": "保险费用错误",
        "-520001018": "税费用错误",
        "-520001019": "最低费用错误",
        "-520001020": "没有填写任何费用",

        "-520011001": "当前用户没有关联公司",
        "-520011002": "当前用户没有关闭报价单的权限",
        "-520011003": "报价单是否存在",
        "-520011004": "只有报价单创建者(所在公司)可以关闭",
        "-520011005": "只有草稿、已发布但未审批的报价单可以关闭",
        "-520011006": "关闭报价单失败",
        "-520012001": "当前用户没有关联公司",
        "-520012002": "当前用户没有发布报价单的权限",
        "-520012003": "报价单是否存在",
        "-520012004": "只有报价单创建者(所在公司)可以发送",
        "-520012005": "只有草稿可以发布",
        "-520012006": "发送报价单失败",
        "-520012007": "合约报价已过期",
        "-520012008": "某项价格为0时不允许发送",
        "-520012009": "没有价格时不允许发送，至少输入一项价格",
        "-520013001": "当前用户没有关联公司",
        "-520013002": "当前用户没有发布报价单的权限",
        "-520013003": "报价单是否存在",
        "-520013004": "只有报价单接收者(所在公司)可以审核",
        "-520013005": "只有已发布的报价单可以审核",
        "-520013006": "拒绝时请填写原因",
        "-510029001": "当前用户没有关联公司",
        "-510029002": "当前用户没有启用或禁用承运方的权限",
        "-510029003": "承运方编号是否有效",
        "-510029004": "启用或禁用失败",
        "-5200031001": "整车，当前用户没有关联公司",
        "-520003002": "整车，当前用户没有添加客户的权限",
        "-520003003": "整车，价格类型是否匹配",
        "-520003004": "整车，车型、车长等于0",
        "-520003005": "整车，报价单是否存在[只有草稿才能追加价格]",
        "-520003006": "整车，新增价格失败",
        "-520003007": "整车，修改价格失败",
        "-520003008": "整车，价格必须大于0",
        "-510038002": "当前用户没有关联公司",
        "-510038003": "当前用户没有添加客户的权限",
        "-510039004": "获取当前客户以及影响报价的其他因素失败",
        "-510039005": "委托给承运方的订单，应该使用承运方的报价，主客倒置了一下",
        "-510039006": "计算与当前订单编号配对的承运方客户订单失败",
        "-510039007": "被合单的订单不能单独计算价格",
        "-5200021001": "零担，当前用户没有关联公司",
        "-520002002": "零担，当前用户没有添加客户的权限",
        "-520002003": "零担，价格类型是否匹配",
        "-520002004": "零担，计算方式校验",
        "-520002005": "零担，报价单是否存在[只有草稿才能追加价格]",
        "-520002006": "零担，新增价格失败",
        "-520002007": "零担，修改价格失败",
        "-520002008": "零担，价格必须大于0",
        "-520054001": "当前用户没有关联公司",
        "-520054002": "当前用户没有禁用报价单的权限",
        "-520054003": "报价单不存在",
        "-520054004": "只有报价单创建者(所在公司)可以禁用",
        "-520054006": "执行禁用操作失败",
        "-520054007": "删除原价格失败",
        "5200041001": "（同城）提货费，当前用户没有关联公司",
        "-520004002": "（同城）提货费，当前用户没有添加客户的权限",
        "-520004003": "（同城）提货费，价格类型是否匹配(同城提货)",
        "-520004004": "（同城）提货费，报价单是否存在[只有草稿才能追加价格]",
        "-520004005": "（同城）提货费，新增价格失败",
        "-520004006": "（同城）提货费，修改价格失败",
        "-520004007": "（同城）提货费，价格必须大于0",
        "-5200051001": "（同城）送货费，当前用户没有关联公司",
        "-520005002": "（同城）送货费，当前用户没有添加客户的权限",
        "-520005003": "（同城）送货费，价格类型是否匹配(同城送货)",
        "-520005004": "（同城）送货费，报价单是否存在[只有草稿才能追加价格]",
        "-520005005": "（同城）送货费，新增价格失败",
        "-520005006": "（同城）送货费，修改价格失败",
        "-520005007": "（同城）送货费，价格必须大于0",
        "-5200061001": "装卸费，当前用户没有关联公司",
        "-520006002": "装卸费，当前用户没有添加客户的权限",
        "-520006003": "装卸费，价格类型是否匹配",
        "-520006004": "装卸费，计算方式校验",
        "-520006005": "报价单是否存在[只有草稿才能追加价格]",
        "-520006006": "装卸费，新增价格失败",
        "-520006007": "装卸费，修改价格失败",
        "-520006008": "装卸费，价格必须大于0",
        "-5200081001": "最低收费，当前用户没有关联公司",
        "-520008002": "最低收费，当前用户没有添加客户的权限",
        "-520008003": "最低收费，价格类型是否匹配",
        "-520008004": "最低收费，报价单是否存在[只有草稿才能追加价格]",
        "-520008005": "最低收费，新增价格失败",
        "-520008006": "最低收费，修改价格失败",
        "-520008007": "最低收费，价格必须大于0",
        "-5200071001": "保费，当前用户没有关联公司",
        "-520007002": "保费，当前用户没有添加客户的权限",
        "-520007003": "保费，价格类型是否匹配",
        "-520007004": "保费，报价单是否存在[只有草稿才能追加价格]",
        "-520007005": "保费，新增价格失败",
        "-520007006": "保费，修改价格失败",
        "-520007007": "保费，价格必须大于0",
        "-5200101001": "附加费，当前用户没有关联公司",
        "-520010002": "附加费，当前用户没有添加客户的权限",
        "-520010003": "附加费，价格类型是否匹配",
        "-520010004": "附加费，报价单是否存在[只有草稿才能追加价格]",
        "-520010005": "附加费，新增价格失败",
        "-520010006": "附加费，修改价格失败",
        "-520010007": "附加费，价格必须大于0",
        "-5200151001": "税费，当前用户没有关联公司",
        "-520015002": "税费，当前用户没有添加客户的权限",
        "-520015003": "税费，价格类型是否匹配",
        "-520015004": "税费，报价单是否存在[只有草稿才能追加价格]",
        "-520015005": "税费，新增价格失败",
        "-520015006": "税费，修改价格失败",
        "-520015007": "税费，价格必须大于0",
        "-510039101": "没有价格",
        "-510039102": "复制价格失败",
       
    };
    for (var key in _result) {
        if (typeof(_ret.rs[0].rows[0][key]) != 'undefined') {
            var _code = $('body').attr('code');
            var _isDend = $('#IsSend').val();
            if (_ret.rs[0].rows[0][key] == 0) {
                alert('成功！');
                /*if ( typeof _ret.rs[0].rows[0]["Doc_ID"] != "undefined") {
                    $('input[name="DocID"]').val( _ret.rs[0].rows[0]["Doc_ID"] );
                    if ( _isDend == "1" && _code != "DocByCompact" && $('body').attr('role') != "DocByCompact") {
                        SendDoc( _code );
                    }
                }*/
                
                var _href = location.href.split('.aspx')[0].split('/')[4];
                setTimeout(function() {
                    if( location.href.split('.aspx')[0].split('/')[4] == 'SupplierList_edit'){
                        $('#supModal').modal('show');
                    }else if ($('body').attr('code') == 'UpdatePwd') {
                        Exit();
                    } else if ( _code == 'DocByOrder' || _code == 'AdditionDoc' || _code == 'DocCombined' || _code == 'AddCombined' ) {
                        location.href = _code + '.aspx'; 
                    } else if ( _code == 'SelfByOrder' || _code == 'SelfCombined' || _code == 'SelfAddition' || _code == 'SelfAddCombin' ) {
                        location.href = _code + '.aspx'; 
                    } else if (  _code == 'DocByCompact' || ( _code == 'MySending' && _href == "SendCompact_edit" ) ) {
                        /*if( typeof _ret.rs[0].rows[0].Doc_ID != "undefined" ){
                            $('.savaLoad').removeClass('hide');
                            CompactVal( _ret.rs[0].rows[0].Doc_ID, _code );
                        }else {
                            location.href = _code + '.aspx';
                        }*/
                        location.href = _code + '.aspx';
                    }else if ( ( _href != "SendCompact_edit" && _code == 'MySending' ) || _code == "SelfSending" ) {
                        location.href = _code + '.aspx'; 
                    }else if (_code == 'Index') {
                        location.href = 'Index.aspx';
                    }else if (_code == 'SelfSent') {
                        location.href = 'SelfSent.aspx';
                    }else if ( _code == 'VerifingDoc') {
                        //location.href = 'VerifiedDoc.aspx';
                        location.href = _code + '.aspx'; 
                    }else if ( _code == 'SelfVerifing') {
                        //location.href = 'SelfVerified.aspx';
                        location.href = _code + '.aspx'; 
                    }else if ( _code == 'SelfVerifing') {
                        //location.href = 'SelfVerified.aspx';
                        location.href = _code + '.aspx'; 
                    }else {
                        location.href = _code + '.aspx'; 
                    }
                }, 1000);
            } else {
                if (typeof _msg[_ret.rs[0].rows[0][key]] == 'undefined') {
                    alert('错误信息：异常错误');
                } else {
                    alert('提示：' + _msg[_ret.rs[0].rows[0][key]]);
                }
            }
        } else {
            if ($('body').attr('code') == 'Unit') {
                alert('保存成功！');
                setTimeout( function() {
                   location.href = _code + '.aspx' 
                }, 5000);
            }            
        }
    }
}

//拆单
$('.add_place').click(function() {
    var addtr = "<tr><td colspan='1' style='border-right:1px solid #e1e6eb;'><span style='float:left;color:#666;'>途径地：</span></td><td colspan='8'><input type='text' name='WayTo' placeholder='请输入途径地' style='border:0;width:700px;line-height:34px;'/></td><td  style=\"border: 1px solid #e1e6eb;\"><span style=\"float: left; color: #666;\">时间：</span></td><td class=\"\" ><input name=\"ToTime\"   oc=\"date\" class=\"laydate-icon edit\" onclick=\"TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )\" f-options=\"{'code':'ToTime','type':'date','etype':'editable','len':'50'}\" verify=\"{}\"></td><td  style='border:1px solid #e1e6eb;'><a class='delete_tr pull-right' style=' margin-left:10px;'>删除</a></td></tr>";
    $('.last_place').before(addtr);
    $('.delete_tr').click(function() {
        $(this).parent().parent().remove();
    })
})

function AddGoodsbar(obj) {
    $('.delete_goodsbar').click(function() {
        $(this).parent().parent().remove();
    })

    var _trObj = $(obj).closest('tr');
    _trObj.find('a').attr('onclick', 'DelGoodsbar(this)');
    _trObj.find('a').text('删除');

    $(obj).closest('tbody').append(_trObj.outerHTML());

    _trObj.find('a').attr('onclick', 'AddGoodsbar(this)');
    _trObj.find('a').text('添加');
}

function DelGoodsbar(obj) {
    $(obj).closest('tr').remove();
}


function SplitSingle() {
    var _from = $('input[name="InputFrom"]').val();
    var _to = $('input[name="InputTo"]').val();

    if (_from == '') {
        alert('起始地不能为空');
    } else if (_to == '') {
        alert('目的地不能为空');
    }
    var AddrLst = '';
    var GoodsLst = '';

    if (typeof($('input[name="WayTo"]').val()) != 'undefined') {
        $('input[name="WayTo"]').each(function(index) {
            if (index % 2 == 0) {
                if (index > 0) {
                    _from = _to;
                }
                _to = $(this).val();
            } else {
                _from = _to;
                _to = $(this).val();
            }
            var _time = $(this).closest('tr').find('input[name="ToTime"]').val();
            AddrLst += '' + _from + ',' + _to + ',' + _time + '';

            if ($('input[name="WayTo"]').length - 1 > index) {
                AddrLst += ';';
            }
        });
        _from = ';' + _to;
        _to = $('input[name="InputTo"]').val();
    }

    AddrLst += '' + _from + ',' + _to + '';

    var _goodsid = '';
    var _goodsqty = '';
    $('.Goods').each(function(index) {
        _goodsid = $(this).find($('input[name="GoodsID"]')).val();
        _goodsqty = $(this).find($('input[name="Qty"]')).val();

        GoodsLst += '' + _goodsid + '=' + _goodsqty + '';

        if (index < $('.Goods').length - 1) {
            GoodsLst += ';';
        } else {
            return false;
        }
    });

    if ($('input[name="split"]').is(':checked') == false) {
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
    _paras[0].value = NSF.UrlVars.Get('id', location.href);
    _paras[1].name = 'AddrLst';
    _paras[1].value = AddrLst;
    _paras[2].name = 'GoodsLst';
    _paras[2].value = GoodsLst;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                Result(data[0]);
            }
        });
}

//删除附加费明细
function DelCost(obj) {
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0079';

    var _paras = [{}, {}];
    _paras[0].name = 'id';
    _paras[0].value = $(obj).closest('tr').find('input[name="id"]').val();
    _paras[1].name = 'orderid';
    _paras[1].value = $('input[name="OrderID"]').val();
    pmls[0].paras = _paras;

    var _flag = false;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                _flag = true;
            } else {
                alert('删除失败！');
            }
        });

    if (_flag == true) {
        $(obj).closest('tr').remove();
    }
}

//附加费为其它时，可写
function IsReadonly(obj) {
    if ($(obj).val() == '8') {
        $('textarea[name="Description"]').removeAttr('readonly');
    } else {
        $('textarea[name="Description"]').attr('readonly', 'readonly');
    }
}

//获取货物分类值
function GetCheckboxVal() {
    var _sum = 0;
    $('input[name="Goodscategory"]:checked').each(function() {
        _sum |= $(this).val();
    });

    $('input[name="GoodsCategory"]').val(_sum);
}

//常用地址自动填充地址项
function GetAddress(obj) {
    var _value = $(obj).find(':selected').text();
    var _address = $(obj).closest('tbody');

    if ($(obj).attr('name').indexOf('Province') != -1) {
        _address.find('span[name="city"]').text('');
        _address.find('span[name="district"]').text('');
        _address.find('span[name="province"]').text(_value);
    } else if ($(obj).attr('name').indexOf('City') != -1) {
        _address.find('span[name="city"]').text(_value);
    } else if ($(obj).attr('name').indexOf('District') != -1) {
        _address.find('span[name="district"]').text(_value);
    }
    var _addressVal = _address.find('span[name="province"]').text() + _address.find('span[name="city"]').text() + _address.find('span[name="district"]').text();
    _address.find('input[name="Address"]').val(_addressVal);
}

//订单中自动填充地址项
function OrderAddress(obj) {
    var _value = $(obj).find(':selected').text();

    if ($(obj).find(':selected').val() == '') {
        _value = '';
    }

    var _address = $(obj).closest('tbody');

    if ($(obj).attr('name') == 'FromProvince_id') {
        _address.find('span[name="fromcity"]').text('');
        _address.find('span[name="fromdistrict"]').text('');
        _address.find('span[name="fromprovince"]').text(_value);
    } else if ($(obj).attr('name') == 'FromCity_id') {
        _address.find('span[name="fromcity"]').text(_value);
    } else if ($(obj).attr('name') == 'FromDistrict_id') {
        _address.find('span[name="fromdistrict"]').text(_value);
    }
    var _addressValFrom = _address.find('span[name="fromprovince"]').text() + _address.find('span[name="fromcity"]').text() + _address.find('span[name="fromdistrict"]').text();
    _address.find('input[name="From"]').val(_addressValFrom);

    if ($(obj).attr('name') == 'ToProvince_id') {
        _address.find('span[name="tocity"]').text('');
        _address.find('span[name="todistrict"]').text('');
        _address.find('span[name="toprovince"]').text(_value);
    } else if ($(obj).attr('name') == 'ToCity_id') {
        _address.find('span[name="tocity"]').text(_value);
    } else if ($(obj).attr('name') == 'ToDistrict_id') {
        _address.find('span[name="todistrict"]').text(_value);
    }
    var _addressValTo = _address.find('span[name="toprovince"]').text() + _address.find('span[name="tocity"]').text() + _address.find('span[name="todistrict"]').text();
    _address.find('input[name="To"]').val(_addressValTo);
}

/*备注区域*/
$('.remarks_sign').click(function() {
    $('.remarks_area').css('display', 'table-row');
})

//承运方列表启用、禁用
function EODSupplier(EOD, SupplierID) {
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

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
}

//客户列表启用、禁用
function EODCustomer(EOD, CustomerID) {
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

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
}
//最终用户列表启用、禁用
function EODEnduser(EOD, EnduserID) {
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

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
}

//显示角色
function GetRole() {
    var _roleID = $('input[name="RoleID"]').val();

    $('input[name="RoleID_id"]').each(function() {
        var _val = parseInt($(this).val()) & parseInt(_roleID);
        if (_val == parseInt($(this).val())) {
            $(this).attr('checked', true);
        }
    });
}

function GoodsCategory() {
    var _GoodsCategory = $('input[name="GoodsCategory"]').val();

    $('input[name="Goodscategory"]').each(function() {
        var _val = parseInt($(this).val()) & parseInt(_GoodsCategory);
        if (_val == parseInt($(this).val())) {
            $(this).attr('checked', true);
        }
    });


    if ($('input[name="TransportMode"]').val() == '2') {
        $('tr[name="CarInfo"]').show();
    } else {
        $('tr[name="CarInfo"]').hide();
    }
}

function GetUsername(id) {
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0084';

    var _paras = [{}];
    _paras[0].name = 'id';
    _paras[0].value = id;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                location.href = 'UserRePwd.aspx?UserName=' + data[0].rs[0].rows[0].account;
            } else {
                alert(data[0].msg);
            }
        });
}
//打开是否确认发送报价单对话框
function IsSend(DocID) {
    //DocID = DocID ? DocID : getUrlParam('id');
    $('#myModal').modal('show');
    //2309 合约报价，发送功能问题
    $('.modal-content').css("top",$(window).height()/3);
 
    
    if (DocID) {
        $('input[name="DocID"]').val(DocID);
    }
    //$('input[name="DocID"]').val(DocID);

}
//确认并保存
function SendOrder() {
    $('#myModal').modal('hide');
    SaveFormDataNDT($('#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860'), $('#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860').find('a:first'), __saveNdtCfg);
}

function IsBackOrder(OrderID) {
    $('#myModal').modal('show');
    $('input[name="OrderID"]').val(OrderID);
}
//打回
function SendBackOrder() {
    $('#myModal').modal('hide');
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0089';

    var _paras = [{}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $('input[name="OrderID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = $('textarea[name="Description"]').val();
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
    $('textarea[name="Description"]').val('');
}

function Closed(DocID) {
    $('#ClosedModal').modal('show');
    $('input[name="DocID"]').val(DocID);
}

function ClosedOrder() {
    $('#ClosedModal').modal('hide');
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0090';

    var _paras = [{}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = $('input[name="COrderID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = $('textarea[name="CDescription"]').val();
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
    $('textarea[name="CDescription"]').val('');
    
}

function ShowCars(obj) {
    if ($(obj).find('option:selected').text() == '整车') {
        $('tr[name="CarInfo"]').show();
    } else {
        $('tr[name="CarInfo"]').hide();
    }
}

function ScheduleOrder() {
    $('#myModal').modal('hide');

    var _DriverID = $('input[name="DriverID"]').val();
    var _CarID = $('input[name="CarID"]').val();
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0093';

    var _paras = [{}, {}, {}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = NSF.UrlVars.Get('id', location.href);
    _paras[1].name = 'SupplierID';
    _paras[1].value = $('input[name="SupplierID"]').val();
    _paras[2].name = 'DriverID';
    _paras[2].value = _DriverID
    _paras[3].name = 'CarID';
    _paras[3].value = _CarID;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
}

$('input[name="radio"]').click(function() {
    if ($(this).val() == '1') {
        $('tr[name="CarDriver"]').show();
        $('tr[name="CarDriverSupplier"]').hide();
        $('tr[name="CarDriverSup"]').hide();
    } else if ($(this).val() == '2') {
        $('tr[name="CarDriverSupplier"]').show();
        $('tr[name="CarDriver"]').hide();
    }

    $('input[name="DriverID"]').val('');
    $('input[name="CarID"]').val('');
    $('input[name="SN"]').val('');
    $('input[name="DriverName"]').val('');
    $('input[name="SupplierName"]').val('');
    $('input[name="SupplierID"]').val('');
});

//实时计算体积，重量
function Calculator(obj) {
    var _qty = $(obj).val();
    var _weight = $(obj).closest('tr').find('input[name="weight"]').val();
    var _volume = $(obj).closest('tr').find('input[name="volume"]').val();

    $(obj).closest('tr').find('input[name="Weight"]').val(_qty * _weight);
    $(obj).closest('tr').find('input[name="Volume"]').val(_qty * _volume);
}


//发送报价单
function SendDoc( code ) {
    $('#myModal').modal('hide');

    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'pml_0022';

    var _paras = [{}];
    _paras[0].name = 'DocID';
    _paras[0].value = $('input[name="DocID"]').val();
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                if( typeof code != "undefined" ){
                    $('body').attr('code', code );
                }else{
                    $('body').attr('code', 'MySending');
                }
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
}
//确定关闭报价单
function CloseDoc( code ) {
    $('#ClosedModal').modal('hide');

    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'pml_0023';

    var _paras = [{}, {}];
    _paras[0].name = 'DocID';
    _paras[0].value = $('input[name="DocID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = $('textarea[name="Description"]').val();
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
    if( typeof code != "undefined" ){
        location.href= code + ".aspx";
    }else{
        location.href="MySending.aspx";
    }
}

//报价单审核，同意
function VerifyDocOk(DocID) {
    if (DocID) {
        DocID = DocID;
    } else {
        DocID = getUrlParam("id");
    }
    $('#ClosedModal').modal('show');
    $('input[name="DocID"]').val(DocID);
    $('input[name="Op"]').val(0);
}
//报价单审核，拒绝
function VerifyDocNo(DocID) {
    if (DocID) {
        DocID = DocID;
    } else {
        DocID = getUrlParam("id");
    }
    $('#ClosedModal').modal('show');
    $('input[name="DocID"]').val(DocID);
    $('input[name="Op"]').val(1);
}

function VerifyDoc() {
    $('#ClosedModal').modal('hide');
    var _Op = $('input[name="Op"]').val();
    var _description = $('textarea[name="CDescription"]').val();

    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'pml_0024';

    var _paras = [{}, {}, {}];
    _paras[0].name = 'DocID';
    _paras[0].value = $('input[name="DocID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = _description;
    _paras[2].name = 'Op';
    _paras[2].value = _Op;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
}



//报价费用明细删除
function DelPrice(obj, vmlid) {
	// 2016-10-22 1681 补充报价，删除键功能错误
	// 获取当前行
    var prow = $(obj).closest('tr');
	if( vmlid == 1){ // 2016-10-22 添加
		prow.remove();	
	}else{
	    var idbtn = prow.find('input[type="hidden"][name="DetailID"]');
		var statYN = false;
	    var pmls = [{}];
	    pmls[0].namespace = 'protocol';
	    pmls[0].cmd = 'data';
	    pmls[0].version = 1;
	    pmls[0].id = vmlid;
		//合约报价零担部分子表整行删除
		if($(obj).parent().parent().parent().attr('id') == 'KG' || $(obj).parent().parent().parent().attr('id') == 'Ton' || $(obj).parent().parent().parent().attr('id') == 'CMetre' || $(obj).parent().parent().parent().attr('id') == 'Square' || $(obj).parent().parent().parent().attr('id') == 'num' )
		{	
			if(idbtn.eq(0).val() != 0)
			{
				//还没有DetailID的时候 删除行
				statYN = true;
			}
			if(statYN)
			{
				var pmlsjson = '';
				for(var i=0;i<idbtn.length;i++)
				{	if(idbtn.eq(i).prev().val() != '')
					{
						pmlsjson += '{"namespace":"protocol","cmd":"data","version":1,"id":"pml_0018","paras":[{"name":"id","value":"'+ idbtn.eq(i).val() +'"}]},';
					}			
				}
				pmlsjson = pmlsjson.substring(0,pmlsjson.length-1);
				var pmls = '';
				pmls = '['+ pmlsjson +']';
				NSF.System.Network.Ajax('/Portal.aspx',
					pmls,
					'POST',
					false,
					function(result, data) {
						if (data[0].result) {
							//Result(data[0]);
							if(prow.parent().find('tr').length == 3)
							{
								prow.parent().find('tr').eq(0).find('input').val('');
							}
							prow.remove();
							
						} else {
							alert(data[0].msg);
						}
				});	
			}
			else
			{
				prow.remove();
			}
		}
		else
		{
		var _paras = [{}, {}];
		_paras[0].name = 'DocID';
		_paras[0].value = $('input[name="DocID"]').val();
		_paras[1].name = 'DetailID';
		_paras[1].value = idbtn.val();
		pmls[0].paras = _paras;
		
		NSF.System.Network.Ajax('/Portal.aspx',
		JsonToStr(pmls),
		'POST',
		false,
		function(result, data) {
			if (data[0].result) {
				Result(data[0]);

				prow.remove();
			} else {
				alert(data[0].msg);
			}
		});	
	}	
	}
}
/*
var _pmls = '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0100","paras":[]}]';
    NSF.System.Network.Ajax( '/Portal.aspx',
        _pmls,
        'POST',
        false,
        function ( result, data )
        {
            if( result )
            {
                GetUnitData(data[0].rs[0].rows);
            }
        } );

function GetUnitData( rows )
{
    var _option = '';
    for( var i = 0; i< rows.length; i++ )
    {
        _option += '<option  value="'+ rows[i].id +'">'+ rows[i].name +'</option>';
    }
    $('select[name="Unit_id"]').append( _option );
}
*/
//根据单位类型筛选单位
function Unit(obj) {
    $(obj).parent().next().find('input[name="Unit"]').val(0);
    $(obj).parent().next().find('span[class="filter-option pull-left"]').text('-----------------------------');

    var _type = $(obj).val();
    if (_type == 1) {
        $(obj).parent().next().find('li').hide();
        $(obj).parent().next().find('li:eq(1)').show();
        $(obj).parent().next().find('li:eq(2)').show();

    } else if (_type == 2) {
        $(obj).parent().next().find('li').hide();
        $(obj).parent().next().find('li:eq(3)').show();
        $(obj).parent().next().find('li:eq(4)').show();
    } else if (_type == 3) {
        $(obj).parent().next().find('li').hide();
        $(obj).parent().next().find('li:gt(4)').show();
    }

    $(obj).parent().next().find('option:selected').removeAttr('selected');
}
//根据单位筛选单位类型
function UnitType(obj) {
    var _unit = $(obj).val();

    if (_unit != '') {
        if (_unit == 1 || _unit == 2) {
            $(obj).parent().prev().find('input[name="UnitType"]').val(1);
            $(obj).parent().prev().find('span[class="filter-option pull-left"]').text('重量');
            $(obj).parent().prev().find("option[value='1']").attr("selected", "selected")
        } else if (_unit == 3 || _unit == 4) {
            $(obj).parent().prev().find('input[name="UnitType"]').val(2);
            $(obj).parent().prev().find('span[class="filter-option pull-left"]').text('体积');
            $(obj).parent().prev().find("option[value='2']").attr("selected", "selected")
        } else {
            $(obj).parent().prev().find('input[name="UnitType"]').val(3);
            $(obj).parent().prev().find('span[class="filter-option pull-left"]').text('数量');
            $(obj).parent().prev().find("option[value='3']").attr("selected", "selected")
        }
    }

}

//生成日期控件
function GetDateEvent(that, options) {
    options.choose = function(dates) {
        $(that).trigger('change');
    };
    laydate(options);
}

//火狐底下textarea的高度固定
var rowsPanH = $('textarea').parent().attr('rowspan') * 24;
$('textarea').css('height', rowsPanH);

$('#myTab a').mouseover(function(e) {
    e.preventDefault();
    $(this).tab('show');
});

//选取车型车长
function showCarType_length(that) {
    $('#CarType_Length .modal-header').html('');
    $('#CarType_Length .content').html('');
    $('#CarType_Length').modal('show');
    //$('tr[name="CarInfo"]').show();
    var index = $(that).parent().parent().index();
    $('#CarType_Length .content').attr('style', 'width:820px;height:200px');
    var cross = false;
    $.ajax({
        async: false,
        url: '/Resources/UI/carcfg.json',
        dataType: (cross ? "jsonp" : "json"),
        jsonp: (cross ? 'callback' : ''),
        type: 'GET',
        success: function(data) {
            var _html = '';
            var _header = '';
            var _carLength = '';
            _header += '<div class="dialogue-header" style="background-color:#f27302;position:relative;margin-left:10px;margin-right:10px;margin-top:20px; margin-bottom:20px;"><p style="text-align:left;background-color:white;margin-left:3px;padding-left:10px; color:#666; font-size:14px;">整车</p>';
            _header += '<div style="position:absolute;top:-6px; right:0;"><button type="button" class="btn btn-default pull-right" data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>';
            _header += '<button type="button" class="btn btn-default pull-right okButton footKeepBtn" style="margin-right:10px;box-shadow:none;text-shadow:none;" aria-label="OK" title="确定"><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button></div></div>';
            _html += '<div class="seach_list" style="border-top:1px solid #ddd;"><ul class="list-inline text-left"><li class="td_name">车型：</li>';
            for (var i = 0; i < data.length; i++) {
                //_html += '<li><input type="radio" name="CarType" value="'+ data[i].id +'"/>'+ data[i].name +'</li>';
                _html += '<li style="margin-right:5px;"><a href="javascript:" onclick="car_type(this)" rel=' + data[i].id + '><i></i>' + data[i].name + '</a></li>';
                for (var j = 0; j < data[i].length.length; j++) {
                    _carLength += '<li row="' + data[i].id + '" class="hidden"><a href="javascript:" onclick="car_type(this)" rel=' + data[i].length[j].id + ' carVolume=' + data[i].length[j].carVolume + ' carWeight=' + data[i].length[j].carWeight + '><i></i>' + data[i].length[j].name + '</a></li>'
                }
            }
            _html += '</ul></div><div class="seach_list carLengths hidden"><ul class="list-inline text-left"><li class="td_name">规格/车长：</li>' + _carLength + '</ul></div>';
            _html += '<div class="seach_list carVolume hidden"><ul class="list-inline text-left"><li class="td_name">容积：</li><li style="height: 21px;width:80%;padding-left:0;"><input name="carVolume" disabled placeholder="容积" oc="text" style="width:90% !important;border:0px;background-color: transparent; box-shadow:none;" class="pull-left edit form-control transparent"/><sapn class="pull-right">立方米</span></li></ul></div>';
            _html += '<div class="seach_list carWeight hidden"><ul class="list-inline text-left"><li class="td_name">载重：</li><li style="height: 21px;width:80%;padding-left:0;"><input name="carWeight" disabled placeholder="载重" oc="text" style="width:90% !important;border:0px;background-color: transparent;box-shadow:none;" class="pull-left edit form-control transparent"/><sapn class="pull-right">吨</span></li></ul></div>';

            $('#CarType_Length .modal-header').append(_header);
            $('#CarType_Length .content').append(_html);
        }
    });

    $('#CarType_Length .okButton').click(function() {
        var CarType = $('.carLengths .selected').attr('row');
        var CarLength = $('.carLengths .selected').find('a').attr('rel');
        var CarVolume = $('.carLengths .selected').find('a').attr('carVolume');
        var CarWeight = $('.carLengths .selected').find('a').attr('carWeight');
        if (CarType != undefined || CarLength != undefined) {
            if (CarLength == 999.00) {
                // if($('input[name="Length"]').val() == '')
                // alert('请输入改装车长');
                // else
                // CarLength = $('input[name="Length"]').val();
                if ($('tbody').hasClass('Car')) 
				{
                    $('.Car input[name="Volume"]').val($('.carVolume input[name="carVolume"]').val());
                    $('.Car input[name="Weight"]').val($('.carWeight input[name="carWeight"]').val());
                }
				if($('.carVolume input[name="carVolume"]').val() != '' && $('.carWeight input[name="carWeight"]').val() != '')
				{
					$( that ).parent().parent().find( 'input[name="CarVolume"]' ).val( $( '.carVolume input[name="carVolume"]' ).val() );
					$( that ).parent().parent().find( 'input[name="CarWeight"]' ).val( $( '.carWeight input[name="carWeight"]' ).val() );
					$( that ).parent().parent().find( 'input[name="CarLengthName"]' ).val( '其他' );
				}
				else
				{
					alert('容积/载重都不能为空！');
				}
            }
            if (CarVolume != 0.000000 && CarWeight != 0.0000) {
                $( that ).parent().parent().find( 'input[name="CarVolume"]' ).val( CarVolume );
                $( that ).parent().parent().find( 'input[name="CarWeight"]' ).val( CarWeight );
            }
            if (CarType != '' && CarLength != '' && $( '.carVolume input[name="carVolume"]' ).val() != '' && $( '.carWeight input[name="carWeight"]' ).val() != '') 
			{
                //CarTypes(CarType,index);
                $( that ).parent().parent().find( 'input[name="CarType"]' ).val( CarType );
                $( that ).parent().parent().find( 'input[name="CarLength"]' ).val( CarLength );
                CarTypes( $( that ).parent(), CarType );
                if ( CarLength != 999.00 )
                {
                    $( that ).parent().parent().find( 'input[name="CarLengthName"]' ).val( CarLength );
                }
				if($('body').attr('role') == 'DocByCompact')
				{
					if($(that).parent().parent().attr('nrowid') == 'CityDeliveryPrice' || $(that).parent().parent().attr('nrowid') == 'CityPickPrice')
					{
						if ( CarLength != 999.00 )
						{
							$( that ).parent().parent().find( 'input[name="CarDetailShow"]' ).val(CarLength+'/'+CarVolume+'/'+CarWeight);
						}
						else
						{
							$( that ).parent().parent().find( 'input[name="CarDetailShow"]' ).val('其他/'+$( '.carVolume input[name="carVolume"]' ).val()+'/'+$( '.carWeight input[name="carWeight"]' ).val());
						}
					}
				}
                $('#CarType_Length').modal('hide');
            }
        } else {
            alert('请选择车型，车长');
        }
    });
}

function car_type(obj) {
    var name = $(obj).parent().parent().find('li').eq(0).text();
    var type_qt = $(obj).text();
    var id = $(obj).attr('rel');
    $('input[name="carVolume"],input[name="carWeight"]').val('');
    $('.carVolume,.carWeight').addClass('hidden');
    $(obj).parent().parent().find('li').removeClass('selected');
    $('.carLengths li').removeClass('selected');
    $('.carLengths li a[rel="0.00"]').next().remove();
    if ($(obj).parent().hasClass('selected')) {
        //$( obj ).parent().removeClass( 'selected' );
    } else {
        $(obj).parent().addClass('selected');
        if (name == '规格/车长：') {
            $('.carLengths li a[rel="0.00"]').next().remove();
            $('.carVolume,.carWeight').removeClass('hidden');
            if ($(obj).attr('rel') == 999.00) {
                $('input[name="carVolume"],input[name="carWeight"]').val('');
                $('input[name="carVolume"],input[name="carWeight"]').attr('disabled', false);

                //$(obj).parent().append('<div class="length_input" style="width:110px;"><input name="Length" placeholder="规格" oc="text" style="width:85% !important;" class="pull-left edit form-control transparent"/><sapn class="pull-right">米</span></div>');
            } else {
                $('input[name="carVolume"],input[name="carWeight"]').attr('disabled', true);
                $('input[name="carVolume"]').val($(obj).attr('carVolume'));
                $('input[name="carWeight"]').val($(obj).attr('carWeight'));
            }
        } else {
            $('.carLengths li').addClass('hidden');
            $('.carLengths').removeClass('hidden');
            $('.carLengths li').eq(0).removeClass('hidden');
            $('.carLengths li[row=' + id + ']').removeClass('hidden');
            $('.length_input').remove();
        }
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

//判断浏览器为火狐
$(function() {
    if (navigator.userAgent.indexOf('Firefox') >= 0) {
        //更改日期控件onclick 调用函数，此方式日期限制无效
        $('input[name="FromTime"],input[name="ToTime"],input[name="StartTime"],input[name="EndTime"],input[name="WayToTime"],input[placeholder="制单时间"],input[placeholder="起始时间"],input[placeholder="结束时间"],input[name="Birthday"]').attr('onclick', 'laydate({format: "YYYY-MM-DD"})');
    }
});

/*去掉手型*/
function RemovePointer() {
    $('.form-control').each(function() {
        if ($(this).attr('readonly') || $(this).attr('disabled')) {
            $(this).css('cursor', 'default');
        }
    });
}

//合计
function Sum() {
    var _weight = parseFloat($('input[name="WeightAddition"]').val());
    var _volume = parseFloat($('input[name="VolumeAddition"]').val());
    var _qty = 0;

    if ($('input[name="WeightAddition"]').val() == '') {
        _weight = 0;
    }

    if ($('input[name="VolumeAddition"]').val() == '') {
        _volume = 0;
    }

    $('tr[nrowid="TMS_OrderGoods"]').each(function() {

        _weight += parseFloat($(this).find('input[name="Weight"]').val());
        _volume += parseFloat($(this).find('input[name="Volume"]').val());
        _qty += parseFloat($(this).find('input[name="Qty"]').val());
    });
    $('input[name="TotalWeight"]').val(_weight.toFixed(4));
    $('input[name="TotalVolume"]').val(_volume.toFixed(6));
    $('input[name="TotalQty"]').val(_qty);
}



//是否ID转文字
function YesORno() {
    $('.yesorno').each(function() {
        var id = $(this).find('input').val();
        var name = '';
        if (id == 1) {
            name = '是';
        } else if (id == 0) {
            name = '否';
        }
        $(this).find('input').val(name);
    });
 //补充报价类别  转换  文字      huzy  2016-06-24
    $('.yesorno_1').each(function() {
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
        $(this).find('input').val(name);
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

//读取货物类型
function GoodsCategory() {
    var _GoodsCategory = $('input[name="GoodsCategory"]').val();
    var _name = '';
    $('input[name="Goodscategory"]').each(function() {
        var _val = parseInt($(this).val()) & parseInt(_GoodsCategory);
        if (_val == parseInt($(this).val())) {
            $(this).attr('checked', true);
            if (_val == 1) {
                _name += '普通货物' + ',';
            } else if (_val == 2) {
                _name += '危险品' + ',';
            } else if (_val == 4) {
                _name += '温控货物';
            }
        }
    });
    $('input[name="GoodsCategoryName"]').val(_name);

    if ($('input[name="TransportMode"]').val() == '2' || $('input[name="TransportMode"]:checked').val() == '2') {
        $('tr[name="CarInfo"]').show();
    } else {
        $('tr[name="CarInfo"]').hide();
    }

    $('tr[nrowid="TMS_OrderGoods"]').each(function() {
        $(this).find('input[name="weight"]').val($(this).find('input[name="Weight"]').val());
        $(this).find('input[name="volume"]').val($(this).find('input[name="Volume"]').val());
    });
    var _weight = $('.addition').find('input[name="WeightAddition"]').val();
    var _volume = $('.addition').find('input[name="VolumeAddition"]').val();
    if ((parseInt(_weight) != 0 && _weight != '') || (parseInt(_volume) != 0 && _volume != '')) {
        $('.addition').show();
    }
}


//订单费用显示
function OrderPriceShow(_id) {
    NSF.System.Data.RecordSet("/", {
        id: "pml_0025",
        cross: "false",
        rowIdentClass: "OrderPrice",
        paras: [{
            "name": "OrderID",
            "value": _id
        }]
    }, function(result, config, data) {
        if( result && typeof data[0].rows[0] != 'undefined' ){
            $('input[name="LessLoad"]').val( data[0].rows[0].LessLoad );
            $('input[name="FullLoad"]').val( data[0].rows[0].FullLoad );
            $('input[name="Pick"]').val( data[0].rows[0].Pick );
            $('input[name="Delivery"]').val( data[0].rows[0].Delivery );
            $('input[name="OnLoad"]').val( data[0].rows[0].OnLoad );
            $('input[name="OffLoad"]').val( data[0].rows[0].OffLoad );
            $('input[name="InsuranceCost"]').val( data[0].rows[0].InsuranceCost );
            $('input[name="Tax"]').val( data[0].rows[0].Tax );
            $('input[name="Addition"]').val( data[0].rows[0].Addition );
            $('input[name="Total"]').val( data[0].rows[0].TotalAmounts );
        }
        
    });
}


/*查看详情时设置订单号*/
function SetOrderID() {
    var code = $('body').attr('code');
    if (code == 'DocByOrder' || code == 'SelfByOrder' ) {
        var no = 1;
        $('input[name="Name"]').val( $('input[name="Code"]').val() + '('+ $('input[name="OrderID"]').val() +')' + "按单报价" );
    } else if (code == 'AdditionDoc') {
        var no = 2;
        $('input[name="Name"]').val( $('input[name="Code"]').val() + '('+ $('input[name="OrderID"]').val() +')' + "补充报价" );
    } else if (code == 'DocCombined' || code == 'SelfCombined' ) {
        var no = 3;
        $('input[name="Name"]').val( $('input[name="Code"]').val() + '('+ $('input[name="OrderID"]').val() +')' + "合单报价" );
    }
    var _orderid = $('input[name="OrderID"]').val();
    if (_orderid != '') {
        if( no == 3 ){
            $('input[name="OrderCode"]').attr('onclick', 'window.open(\'OrderAcceptedCar_edit.aspx?id=' + _orderid + '\&no=' + no + '\')');
        }else{
            $('input[name="OrderCode"]').attr('onclick', 'window.open(\'OrderPrice_edit.aspx?id=' + _orderid + '\&no=' + no + '\')');
        }
    }

    
}


/*选择订单时设置订单号*/
function GetOrderID(val) {
    var code = $('body').attr('code');
    if (code == 'DocByOrder') {
        var no = 1;
    } else if (code == 'AdditionDoc') {
        var no = 2;
        $('input[name="Name"]').val( $('input[name="Code"]').val() + '('+ $('input[name="OrderID"]').val() +')' + "补充报价" );
    } else if (code == 'DocCombined') {
        var no = 3;
    }
    if( no == 3 ){
        $('input[name="OrderCode"]').attr('onclick', 'window.open(\'OrderAcceptedCar_edit.aspx?id=' + val + '\&no=' + no + '\')');
    }else{
        $('input[name="OrderCode"]').attr('onclick', 'window.open(\'OrderPrice_edit.aspx?id=' + val + '\&no=' + no + '\')');
    }
    if (no == 1) {		
        //如果是按单报价则赋值
        var cross = false;
        var params = '[{"namespace":"protocol","cmd":"data","version":1,"id":"pml_0037","paras":[{"name":"id","value":"' + val + '"}]}]';
        $.ajax({
            async: false,
            url: '/Portal.aspx',
            dataType: (cross ? "jsonp" : "json"),
            jsonp: (cross ? 'callback' : ''),
            type: 'POST',
            data: params,
            success: function(data) {
                if (data[0].result) {
                    var dataes = data[0].rs[0].rows[0];					
                    $( 'tr[nrowid="PMS_LessLoad"] td,tr[nrowid="PMS_FullLoad"] td,tr[nrowid="CityPickPrice"] td,tr[nrowid="LoadPrice2"] td,tr[nrowid="CityDeliveryPrice"] td' ).find( 'input' ).val( '' );
                    $( 'tr[nrowid="PMS_LessLoad"],tr[nrowid="CityPickPrice"],tr[nrowid="LoadPrice2"],tr[nrowid="CityDeliveryPrice"]' ).find( '.filter-option' ).text( $( 'tr[nrowid="PMS_LessLoad"],tr[nrowid="CityPickPrice"],tr[nrowid="LoadPrice2"],tr[nrowid="CityDeliveryPrice"]' ).find( '.selectpicker ' ).attr( 'title' ) );
                    //判断是零担还是整车
					var MaxType = 0;
					var Max = [dataes.TotalWeight,dataes.TotalVolume,dataes.TotalAmount];
					if(dataes.ChargeMode == 1)
					{
						MaxType = 1;
					}
					else if(dataes.ChargeMode == 2)
					{
						MaxType = 2;
					}
					else if(dataes.ChargeMode == 3)
					{
						MaxType = 3;
					}
                    if ( dataes.TransportMode == 1 )
                    {                        
                        $( 'tr[nrowid="PMS_FullLoad"]' ).find( 'input[name="FromName"],input[name="ToName"]' ).val( '请选择城市名称' );
                        //零担
                        $('tr[nrowid="PMS_LessLoad"] input[name="Max"]').val(parseFloat(Max[MaxType-1])+1);
                        $('tr[nrowid="PMS_LessLoad"] input[name="UnitType"]').val(dataes.ChargeMode);
                        $('tr[nrowid="PMS_LessLoad"] select[name="UnitType_id"]').val(dataes.ChargeMode);
                        $('tr[nrowid="PMS_LessLoad"] input[name="Unit"]').val(dataes.PriceUnit);
                        $('tr[nrowid="PMS_LessLoad"] select[name="Unit_id"]').val(dataes.PriceUnit);
                        $('tr[nrowid="PMS_LessLoad"] input[name="FromProvince"]').val(dataes.FromProvice);
                        $('tr[nrowid="PMS_LessLoad"] input[name="FromCity"]').val(dataes.FromCity);
                        $('tr[nrowid="PMS_LessLoad"] input[name="FromDistrict"]').val(dataes.FromDistrict);
                        $('tr[nrowid="PMS_LessLoad"] input[name="FromName"]').val(dataes.CFromProvince + '-' + dataes.CFromCity + '-' + dataes.CFromDistrict);
                        $('tr[nrowid="PMS_LessLoad"] input[name="ToProvince"]').val(dataes.ToProvince);
                        $('tr[nrowid="PMS_LessLoad"] input[name="ToCity"]').val(dataes.ToCity);
                        $('tr[nrowid="PMS_LessLoad"] input[name="ToDistrict"]').val(dataes.ToDistrict);
                        $('tr[nrowid="PMS_LessLoad"] input[name="Min"]').val('0');
                        $('tr[nrowid="PMS_LessLoad"] input[name="ToName"]').val(dataes.CToProvince + '-' + dataes.CToCity + '-' + dataes.CToDistrict);
                        UnitType($('tr[nrowid="PMS_LessLoad"] select[name="Unit_id"]'));
                        Unit($('tr[nrowid="PMS_LessLoad"] select[name="UnitType_id"]'));
                        $('tr[nrowid="PMS_LessLoad"] input[name="Unit"]').val(dataes.PriceUnit);
                        var unitText = $('tr[nrowid="PMS_LessLoad"] select[name="Unit_id"] option[value="' + dataes.PriceUnit + '"]').text();
                        $('tr[nrowid="PMS_LessLoad"] select[name="Unit_id"]').next().find('button').attr('title', unitText);
                        $('tr[nrowid="PMS_LessLoad"] select[name="Unit_id"]').next().find('button .filter-option').text(unitText);
                    } 
					else if ( dataes.TransportMode == 2 )
                    {
                        $( 'tr[nrowid="PMS_LessLoad"]' ).find( 'input[name="FromName"],input[name="ToName"]' ).val( '请选择城市名称' );
                        //整车                        
                        $('tr[nrowid="PMS_FullLoad"] input[name="CarType"]').val(dataes.CarType);
                        $('tr[nrowid="PMS_FullLoad"] input[name="CarLength"]').val(dataes.CarLength);
                        $('tr[nrowid="PMS_FullLoad"] input[name="CarVolume"]').val(dataes.CarVolume);
                        $('tr[nrowid="PMS_FullLoad"] input[name="CarWeight"]').val(dataes.CarWeight);
                        $('tr[nrowid="PMS_FullLoad"] input[name="FromProvince"]').val(dataes.FromProvice);
                        $('tr[nrowid="PMS_FullLoad"] input[name="FromCity"]').val(dataes.FromCity);
                        $('tr[nrowid="PMS_FullLoad"] input[name="FromDistrict"]').val(dataes.FromDistrict);
                        $('tr[nrowid="PMS_FullLoad"] input[name="FromName"]').val(dataes.CFromProvince + '-' + dataes.CFromCity + '-' + dataes.CFromDistrict);
                        $('tr[nrowid="PMS_FullLoad"] input[name="ToProvince"]').val(dataes.ToProvince);
                        $('tr[nrowid="PMS_FullLoad"] input[name="ToCity"]').val(dataes.ToCity);
                        $('tr[nrowid="PMS_FullLoad"] input[name="ToDistrict"]').val(dataes.ToDistrict);
                        $('tr[nrowid="PMS_FullLoad"] input[name="ToName"]').val(dataes.CToProvince + '-' + dataes.CToCity + '-' + dataes.CToDistrict);
                        CarName();
                    }
					//提货则赋值
					if(dataes.Pick == 1)
					{
						$('tr[nrowid="CityPickPrice"] input[name="Max"]').val(parseFloat(Max[MaxType-1])+1);
						$('tr[nrowid="CityPickPrice"] input[name="FromProvince"]').val(dataes.FromProvice);
                        $('tr[nrowid="CityPickPrice"] input[name="FromCity"]').val(dataes.FromCity);
                        $('tr[nrowid="CityPickPrice"] input[name="FromDistrict"]').val(dataes.FromDistrict);
                        $('tr[nrowid="CityPickPrice"] input[name="FromName"]').val(dataes.CFromProvince + '-' + dataes.CFromCity + '-' + dataes.CFromDistrict);
                        $('tr[nrowid="CityPickPrice"] input[name="UnitType"]').val(dataes.ChargeMode);
                        $('tr[nrowid="CityPickPrice"] select[name="UnitType_id"]').val(dataes.ChargeMode);
                        $('tr[nrowid="CityPickPrice"] input[name="Unit"]').val(dataes.PriceUnit);
                        $('tr[nrowid="CityPickPrice"] select[name="Unit_id"]').val(dataes.PriceUnit);
						UnitType($('tr[nrowid="CityPickPrice"] select[name="Unit_id"]'));
                        Unit($('tr[nrowid="CityPickPrice"] select[name="UnitType_id"]'));
						$('tr[nrowid="CityPickPrice"] input[name="Unit"]').val(dataes.PriceUnit);
                        var unitText = $('tr[nrowid="CityPickPrice"] select[name="Unit_id"] option[value="' + dataes.PriceUnit + '"]').text();
                        $('tr[nrowid="CityPickPrice"] select[name="Unit_id"]').next().find('button').attr('title', unitText);
                        $('tr[nrowid="CityPickPrice"] select[name="Unit_id"]').next().find('button .filter-option').text(unitText);
						$('tr[nrowid="CityPickPrice"] input[name="Min"]').val('0');
					};
					//装货/卸货则赋值
					if($('tr[nrowid="LoadPrice2"]').length < 2)
					{
						_row_add($('tr[rowid="LoadPrice2"]'));
					}
					//装货
					$('tr[nrowid="LoadPrice2"]').eq(0).find('input[name="Max"]').val(parseFloat(Max[MaxType-1])+1);
					$('tr[nrowid="LoadPrice2"]').eq(0).find('input[name="DocType"]').val('5');
					$('tr[nrowid="LoadPrice2"]').eq(0).find('input[name="DocType_id"]').val('5');
					$('tr[nrowid="LoadPrice2"]').eq(0).find('input[name="DocType"]').attr('title','5');
					var DocText = $('tr[nrowid="LoadPrice2"]').eq(0).find('select[name="DocType_id"] option[value="5"]').text();
					$('tr[nrowid="LoadPrice2"]').eq(0).find('select[name="DocType_id"]').next().find('button').attr('title', DocText);
					$('tr[nrowid="LoadPrice2"]').eq(0).find('select[name="DocType_id"]').next().find('button .filter-option').text(DocText);
					$('tr[nrowid="LoadPrice2"]').eq(0).find('input[name="UnitType"]').val(dataes.ChargeMode);
					$('tr[nrowid="LoadPrice2"]').eq(0).find('select[name="UnitType_id"]').val(dataes.ChargeMode);
					$('tr[nrowid="LoadPrice2"]').eq(0).find('input[name="Unit"]').val(dataes.PriceUnit);
					$('tr[nrowid="LoadPrice2"]').eq(0).find('select[name="Unit_id"]').val(dataes.PriceUnit);
					$('tr[nrowid="LoadPrice2"]').eq(0).find('input[name="Min"]').val('0');
					UnitType($('tr[nrowid="LoadPrice2"]').eq(0).find('select[name="Unit_id"]'));
					Unit($('tr[nrowid="LoadPrice2"]').eq(0).find('select[name="UnitType_id"]'));
					$('tr[nrowid="LoadPrice2"]').eq(0).find('input[name="Unit"]').val(dataes.PriceUnit);
					var unitText = $('tr[nrowid="LoadPrice2"]').eq(0).find('select[name="Unit_id"] option[value="' + dataes.PriceUnit + '"]').text();
					$('tr[nrowid="LoadPrice2"]').eq(0).find('select[name="Unit_id"]').next().find('button').attr('title', unitText);
					$('tr[nrowid="LoadPrice2"]').eq(0).find('select[name="Unit_id"]').next().find('button .filter-option').text(unitText);
					//卸货
					$('tr[nrowid="LoadPrice2"]').eq(1).find('input[name="Max"]').val(parseFloat(Max[MaxType-1])+1);
					$('tr[nrowid="LoadPrice2"]').eq(1).find('input[name="DocType"]').val('6');
					$('tr[nrowid="LoadPrice2"]').eq(1).find('input[name="DocType_id"]').val('6');
					$('tr[nrowid="LoadPrice2"]').eq(1).find('input[name="DocType"]').attr('title','6');
					var DocText = $('tr[nrowid="LoadPrice2"]').eq(1).find('select[name="DocType_id"] option[value="6"]').text();
					$('tr[nrowid="LoadPrice2"]').eq(1).find('select[name="DocType_id"]').next().find('button').attr('title', DocText);
					$('tr[nrowid="LoadPrice2"]').eq(1).find('select[name="DocType_id"]').next().find('button .filter-option').text(DocText);

					$('tr[nrowid="LoadPrice2"]').eq(1).find('input[name="UnitType"]').val(dataes.ChargeMode);
					$('tr[nrowid="LoadPrice2"]').eq(1).find('select[name="UnitType_id"]').val(dataes.ChargeMode);
					$('tr[nrowid="LoadPrice2"]').eq(1).find('input[name="Unit"]').val(dataes.PriceUnit);
					$('tr[nrowid="LoadPrice2"]').eq(1).find('select[name="Unit_id"]').val(dataes.PriceUnit);
					$('tr[nrowid="LoadPrice2"]').eq(1).find('input[name="Min"]').val('0');
					UnitType($('tr[nrowid="LoadPrice2"]').eq(1).find('select[name="Unit_id"]'));
					Unit($('tr[nrowid="LoadPrice2"]').eq(1).find('select[name="UnitType_id"]'));
					$('tr[nrowid="LoadPrice2"]').eq(1).find('input[name="Unit"]').val(dataes.PriceUnit);
					var unitText = $('tr[nrowid="LoadPrice2"]').eq(1).find('select[name="Unit_id"] option[value="' + dataes.PriceUnit + '"]').text();
					$('tr[nrowid="LoadPrice2"]').eq(1).find('select[name="Unit_id"]').next().find('button').attr('title', unitText);
					$('tr[nrowid="LoadPrice2"]').eq(1).find('select[name="Unit_id"]').next().find('button .filter-option').text(unitText);

					//送货则赋值
					if(dataes.Delivery == 1)
					{
						$('tr[nrowid="CityDeliveryPrice"] input[name="Max"]').val(parseFloat(Max[MaxType-1])+1);
						$('tr[nrowid="CityDeliveryPrice"] input[name="ToProvince"]').val(dataes.ToProvince);
                        $('tr[nrowid="CityDeliveryPrice"] input[name="ToCity"]').val(dataes.ToCity);
                        $('tr[nrowid="CityDeliveryPrice"] input[name="ToDistrict"]').val(dataes.ToDistrict);
                        $('tr[nrowid="CityDeliveryPrice"] input[name="ToName"]').val(dataes.CToProvince + '-' + dataes.CToCity + '-' + dataes.CToDistrict);
                        $('tr[nrowid="CityDeliveryPrice"] input[name="UnitType"]').val(dataes.ChargeMode);
                        $('tr[nrowid="CityDeliveryPrice"] select[name="UnitType_id"]').val(dataes.ChargeMode);
                        $('tr[nrowid="CityDeliveryPrice"] input[name="Unit"]').val(dataes.PriceUnit);
                        $('tr[nrowid="CityDeliveryPrice"] input[name="Min"]').val('0');
                        $('tr[nrowid="CityDeliveryPrice"] select[name="Unit_id"]').val(dataes.PriceUnit);
						UnitType($('tr[nrowid="CityDeliveryPrice"] select[name="Unit_id"]'));
                        Unit($('tr[nrowid="CityDeliveryPrice"] select[name="UnitType_id"]'));
						$('tr[nrowid="CityDeliveryPrice"] input[name="Unit"]').val(dataes.PriceUnit);
                        var unitText = $('tr[nrowid="CityDeliveryPrice"] select[name="Unit_id"] option[value="' + dataes.PriceUnit + '"]').text();
                        $('tr[nrowid="CityDeliveryPrice"] select[name="Unit_id"]').next().find('button').attr('title', unitText);
                        $('tr[nrowid="CityDeliveryPrice"] select[name="Unit_id"]').next().find('button .filter-option').text(unitText);
					};
					//$('tr input,.bootstrap-select button').attr('disabled',true);
					//$('tr input[name="Price"],tr input[name="CarTypeName"],input[name="Name"]').attr('disabled',false);
					$( 'table' ).find( 'tr' ).each( function ( index )
					{
						//$( 'tr' )[index].isDirty = true;
					} );
				}

            }
        });
    }
    return true;
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
    /*$( 'table' ).find( 'tr' ).each( function ( index )
    {
        $( 'tr' )[index].isDirty = true;
    } );  */

    //下拉菜单错误代码
    $('span[class="filter-option pull-left"]').each( function(){
        if( $(this).text() == 'Nothing selected' ){
            $(this).text( '---------------------------' );
        }
    });
}
//手动添加tr
function add( that )
{
    var _html = '<tr>' + $( that ).parent().parent().next().html() + '</tr>';
    $( that ).parent().parent().parent().append( _html );
}

////点击保存后的loading图标
//$('.footKeepBtn').click(function()
//{
//	if($(this).text() == '保存 ')
//	{
//		if($('#msg').find('div').text() == '')
//		{
//			$('.savaLoad').removeClass('hide');
//		}
//	}
//});
//合约报价保存
function CompactSave(that, code ){ 
    if (NSF.UrlVars.Get('copy', location.href)) {   //是否为复制报价单
        $('input[name="DetailID"]').val(0);
        $( 'table tr[nrowid]' ).each( function(){
            if ($(this).attr('nrowid') != 'MinPrice' && $(this).attr('nrowid') != 'InsurancePrice' && $(this).attr('nrowid') != 'TaxPrice') {
                $(this)[0].isDirty = true;
            }
        });
      }

    if ($('body').attr('code') == 'MySending') {   //是否为待发送报价单
        $( 'table tr[nrowid]' ).each( function(){
            if ($(this).attr('nrowid') != 'MinPrice' && $(this).attr('nrowid') != 'InsurancePrice' && $(this).attr('nrowid') != 'TaxPrice') {
                $(this)[0].isDirty = true;
            }
        });
      }

    
    $("body").attr( "code", code );

    $( 'tr[nrowid="PMS_FullLoad"]' ).each( function ( index )
    {
        $( 'tr[nrowid="PMS_FullLoad"]' ).eq( index ).find( 'input[name="FromName"]' ).val( $( '.setOff input[name="FromName"]' ).val() );
        $( 'tr[nrowid="PMS_FullLoad"]' ).eq( index ).find( 'input[name="FromProvince"]' ).val( $( '.setOff input[name="FromProvince"]' ).val() );
        $( 'tr[nrowid="PMS_FullLoad"]' ).eq( index ).find( 'input[name="FromCity"]' ).val( $( '.setOff input[name="FromCity"]' ).val() );
        $( 'tr[nrowid="PMS_FullLoad"]' ).eq( index ).find( 'input[name="FromDistrict"]' ).val( $( '.setOff input[name="FromDistrict"]' ).val() );
    } );
	var pricQj = true;
	//如果填了零担 零担五大类 区间值判断 项目中 每项不能有相同的目的城市
    //重量/公斤
    
	if($('#KG tr').eq(0).find('td').eq(1).find('input').val() != '' && $('#KG tr').eq(0).find('td').eq(1).find('input').val() != undefined){
		$('#KG tr').eq(0).find('td').each(function(index)
		{
			if( index > 0 )
			{
				if( parseInt($('#KG tr').eq(0).find('td').eq(index+1).find('input').val()) < parseInt($('#KG tr').eq(0).find('td').eq(index).find('input').val()))
				{
					alert('重量/公斤项的区间值：后一位区间值必须大于前一位区间');
					pricQj = false;
				}
			};
		});
		$('#KG tr').each(function(index)
		{
			if( index > 1 )
			{
				if( $('#KG tr').eq(index).find('td').eq(0).find('input[name="ToName"]').val() == $('#KG tr').eq(index+1).find('td').eq(0).find('input[name="ToName"]').val() )
				{
					alert('重量/公斤 目的城市重复');
					pricQj = false;
				};
			};
		});
	}
    //重量/吨
	if($('#Ton tr').eq(0).find('td').eq(1).find('input').val() != '' && $('#Ton tr').eq(0).find('td').eq(1).find('input').val() != undefined){
		$('#Ton tr').eq(0).find('td').each(function(index)
		{
			if( index > 0 )
			{
				if( parseInt($('#Ton tr').eq(0).find('td').eq(index+1).find('input').val()) < parseInt($('#Ton tr').eq(0).find('td').eq(index).find('input').val()))
				{
					alert('重量/吨项的区间值：后一位区间值必须大于前一位区间');
					pricQj = false;
				};
			};
		});
		$('#Ton tr').each(function(index)
		{
			if( index > 1 )
			{
				if( $('#Ton tr').eq(index).find('td').eq(0).find('input[name="ToName"]').val() == $('#Ton tr').eq(index+1).find('td').eq(0).find('input[name="ToName"]').val() )
				{
					alert('重量/吨 目的城市重复');
					pricQj = false;
				};
			};
		});
	};
    //体积/立方米
	if($('#CMetre tr').eq(0).find('td').eq(1).find('input').val() != '' && $('#CMetre tr').eq(0).find('td').eq(1).find('input').val() != undefined){
		$('#CMetre tr').eq(0).find('td').each(function(index)
		{
			if( index > 0 )
			{
				if( parseInt($('#CMetre tr').eq(0).find('td').eq(index+1).find('input').val()) < parseInt($('#CMetre tr').eq(0).find('td').eq(index).find('input').val()))
				{
					alert('体积/立方米项的区间值：后一位区间值必须大于前一位区间');
					pricQj = false;
				};
			};
		});
		$('#CMetre tr').each(function(index)
		{
			if( index > 1 )
			{
				if( $('#CMetre tr').eq(index).find('td').eq(0).find('input[name="ToName"]').val() == $('#CMetre tr').eq(index+1).find('td').eq(0).find('input[name="ToName"]').val() )
				{
					alert('体积/立方米 目的城市重复');
					pricQj = false;
				};
			};
		});
	};
    //体积/升
    if($('#Square tr').eq(0).find('td').eq(1).find('input').val() != '' && $('#Square tr').eq(0).find('td').eq(1).find('input').val() != undefined){
		$('#Square tr').eq(0).find('td').each(function(index)
		{
			if( index > 0 )
			{
				if( parseInt($('#Square tr').eq(0).find('td').eq(index+1).find('input').val()) < parseInt($('#Square tr').eq(0).find('td').eq(index).find('input').val()))
				{
					alert('体积/升项的区间值：后一位区间值必须大于前一位区间');
					pricQj = false;
				};
			};
		});
		$('#Square tr').each(function(index)
		{
			if( index > 1 )
			{
				if( $('#Square tr').eq(index).find('td').eq(0).find('input[name="ToName"]').val() == $('#Square tr').eq(index+1).find('td').eq(0).find('input[name="ToName"]').val() )
				{
					alert('体积/升 目的城市重复');
					pricQj = false;
				};
			};
		});
	};
    //数量
	if($('#num tr').eq(0).find('td').eq(1).find('input').val() != '' && $('#num tr').eq(0).find('td').eq(1).find('input').val() != undefined){
		$('#num tr').eq(0).find('td').each(function(index)
		{
			if( index > 0 )
			{
				if( parseInt($('#num tr').eq(0).find('td').eq(index+1).find('input').val()) < parseInt($('#num tr').eq(0).find('td').eq(index).find('input').val()))
				{
					alert('数量项的区间值：后一位区间值必须大于前一位区间');
					pricQj = false;
				};
			};
		});
		$('#num tr').each(function(index)
		{
			if( index > 1 )
			{
				if( $('#num tr').eq(index).find('td').eq(0).find('input[name="ToName"]').val() == $('#num tr').eq(index+1).find('td').eq(0).find('input[name="ToName"]').val() )
				{
					alert('数量 目的城市重复');
					pricQj = false;
				};
			};
		});
	};

	if(pricQj){
		$( 'table tr[nrowid]' ).each( function(){
            //$(this)[0].isDirty = true;
        });
        var flag = 0;
        var _LessLoadPrice = CompactVal();       //零担
        var _FullLoadPrice = FullLoadPrice($('tr[nrowid="PMS_FullLoad"]'));          //整车
        var _PickPrice  = FullLoadPrice($('tr[nrowid="CityPickPrice"]'));          //提货
        var _DeliveryPrice  = FullLoadPrice($('tr[nrowid="CityDeliveryPrice"]'));          //送货
        var _OnLoadPrice  = FullLoadPrice($('tr[nrowid="LoadPrice2"]'));          //装卸
        var _MinPay = FullLoadPrice($('tr[nrowid="MinPrice"]'));          //最低
        var _InsuranceCost  = FullLoadPrice($('tr[nrowid="InsurancePrice"]'));          //保费
        var _TaxPrice = FullLoadPrice($('tr[nrowid="TaxPrice"]'));          //税费

        $('input[name="LessLoadPrice"]').val(_LessLoadPrice);
        $('input[name="FullLoadPrice"]').val(_FullLoadPrice);
        $('input[name="PickPrice"]').val(_PickPrice);
        $('input[name="DeliveryPrice"]').val(_DeliveryPrice);
        $('input[name="OnLoadPrice"]').val(_OnLoadPrice);
        $('input[name="MinPay"]').val(_MinPay);
        $('input[name="InsuranceCost"]').val(_InsuranceCost);
        $('input[name="TaxPrice"]').val(_TaxPrice);


        if( flag == 0 ){
            var table = $( that ).closest( 'table' );
            if (table.length != 0) {
                 SaveFormDataNDT( table, $( that ), __saveNdtCfg );
            } else {
                table = $( 'table' );
                $('#Issend').val(1);
                SaveFormDataNDT( table, $('a.send'), __saveNdtCfg );
            }
        }

	}
}
function CompactVal(){        //零担保存
    var Total = [];
    var json = '';
    var isReady;
    var flag = 0;
    var _add = '';

    var isReady = tdVal( '#KG tr:not(.hide)', Total, 1, 1 );
    if( !isReady ){
        flag = 1;
    }
    isReady = tdVal( '#Ton tr:not(.hide)', Total, 1, 2 );
    if( !isReady ){
        flag = 2;
    }
    isReady = tdVal( '#CMetre tr:not(.hide)', Total, 2, 3 );
    if( !isReady ){
        flag = 3;
    }
    isReady = tdVal( '#Square tr:not(.hide)', Total, 2, 4 );
    if( !isReady ){
        flag = 4;
    }
    isReady = tdVal( '#num tr:not(.hide)', Total, 3, $( '.ld' ).find( 'select[name="Unit_id"]' ).val() );
    if( !isReady ){
        flag = 5;
    }

    if( flag == 0 ){   //判断数据是否填满
        /*
            <Add> 
                <Pr>  
                    <DetailID>111393</DetailID>  <DType>1</DType>  <FrProvince>130000</FrProvince>  
                    <FrCity>130100</FrCity>  <FrDistrict>130103</FrDistrict>  <ToProvince>130000</ToProvince>  
                    <ToCity>130100</ToCity>  <ToDistrict>130124</ToDistrict>  <UnitType>1</UnitType>  
                    <Unit>1</Unit>  <UMin>0</UMin>  <UMax>12</UMax>  
                    <Amount>12.00</Amount>  <MinPay>0</MinPay>  <CarType>0</CarType>  
                    <CarLength>0</CarLength>  <CarVolume>1</CarVolume>  <CarWeight>0</CarWeight>  
                    <Comments>0</Comments>
                </Pr>
            </Add>
        */
        if (Total.length > 0) {
            _add = '<Add>';
            var _pr = '';
            for ( var i = 0; i < Total.length; i++ ){
                _pr = '<Pr>';
                for ( var j = 0; j < Total[i].length; j++ )
                {
                    json += '<'+ Total[i][j].name+'>'+ Total[i][j].value +'</'+ Total[i][j].name +'>';
                }
                _pr += json + '</Pr>';
               json = '';
               _add += _pr;
            }
            _add += '</Add>' ;
        }
        
        
    }else{
        $('div.savaLoad').hide();
    }
    
    return _add;
}

function FullLoadPrice(_FullLoadObj) {      //除零担外，其它费用保存
    var _datalist = [];
    if (_FullLoadObj.length > 0) {
        for (i = 0; i < _FullLoadObj.length; i++) {
            if (_FullLoadObj.eq(i).find('input[name="Price"]').val() != '') {
                _datalist.push(_FullLoadObj.eq(i));
            }
        }

    }
    var _add = '';
    var _pr = '';
    if (_datalist.length > 0) {
        _add = '<Add>';
        for (i = 0; i < _datalist.length; i++) {
            _pr = '<Pr>';
            _datalist[i].find('.data').each(function() {
                if ($(this).attr('name') == 'Description') {
                    _pr += '<Comments>' + $(this).val() + '</Comments>';
                } else if ($(this).attr('name') == 'Min') {
                    _pr += '<UMin>' + $(this).val() + '</UMin>';
                } else if ($(this).attr('name') == 'Max') {
                    _pr += '<UMax>' + $(this).val() + '</UMax>';
                } else {
                    _pr += '<'+ $(this).attr('name') +'>' + $(this).val() + '</'+ $(this).attr('name') +'>';
                }
            });

            _add += _pr + '</Pr>';
        }

        _add += '</Add>';
    }

    return _add;
}

function tdVal( mark, Total, type, unit ){
    //先获取零担重量/公斤内容
    var Max = new Array();//区间值
    var KG = {};//
    var Prices = new Array();//价格数组
    var price, city, Min, Max, Unit_id;//价格,省编号,市编号,区编号,中文地址
    var isReady = true;
    $( mark ).each( function ( index ) {	
		Prices = [];
        var title_tdL = $( mark ).eq( index ).find( 'td' ).length;
        //获取Title 区间值
        if ( index == 0 ) {

            for ( var i = 0; i < title_tdL - 2; i++ )
            {
				if($( mark ).eq( index ).find( 'td' ).eq( i + 1 ).find( 'input' ).val() != '' && $( mark ).eq( index ).find( 'td' ).eq( i + 1 ).find( 'input' ).val() != "0")
				{
					Max[i] = $( mark ).eq( index ).find( 'td' ).eq( i + 1 ).find( 'input' ).val();
				}else{
                    Max[i] = "";
                }
            }
        }
        var _priceTr = $( mark ).eq( index );
        if(  _priceTr.find('input[name="ToName"]').length > 0 ){
            $( mark ).eq( index ).find('td:not(".slashTd")').each( function( i ){
                if( i < $( mark ).eq( index ).find('td:not(".slashTd")').length - 1 ){
                    if( $(this).find('input').val() != "" ){
                        Prices[i] = $(this).find('input').val();
                    }else{
                        Prices[i] = "";
                    }
                }
            });
            
			if( Prices.length == 0 ){
				//如果价格一个都未录入，则根据区间值的长度来进行赋值为0
				for( var M = 0; M < Max.length; M++ )
				{
					Prices[M] = '0';
				}
			}
            for ( var j = 0; j < Max.length; j++ ){
				//根据区间值的长度来赋值，如对应价格未填写，则自动附加当前价格为0
				if( Prices[j] == '' )
				{
					Prices[j] = '0';
				}else{
                    if( j == 0 ){
                        if( $( mark ).eq( index ).find( 'td' ).eq( 0 ).find( 'input[name="ToName"]' ).val() == "" || Max[j] == "" ){
                            alert("缺失目的省市、区间信息或者区间值为0，请将数据填写正确！");
                            isReady = false;
                            return;
                        }
                    }else{
                        if( $( mark ).eq( index ).find( 'td' ).eq( 0 ).find( 'input[name="ToName"]' ).val() == "" || Max[j - 1] == "" ){
                            alert("缺失目的省市、区间信息或者区间值为0，请将数据填写正确！");
                            isReady = false;
                            return;
                        }
                    }
                }
                if( Max[j] != "" && Prices[j+1] == "" ){
                    Prices[j+1] = "0";
                }
                if ( Prices[j+1] != '' && Max[j] != "" ){
                    if ( j == 0 ){
                        city =
                        [
                            { "name": "DetailID", "value": "" + $( mark ).eq( index ).find( 'td' ).eq( j+1 ).find( 'input[name="DetailID"]' ).val() + "" },
                            { "name": "DocType", "value": "1" },
                            { "name": "FromProvince", "value": "" + $( '.ld .province' ).find( 'input[name="FromProvince"]' ).val() + "" },
                            { "name": "FromCity", "value": "" + $( '.ld .province' ).find( 'input[name="FromCity"]' ).val() + "" },
                            { "name": "FromDistrict", "value": "" + $( '.ld .province' ).find( 'input[name="FromDistrict"]' ).val() + "" },
                            { "name": "ToProvince", "value": "" + $( mark ).eq( index ).find( 'td' ).eq( 0 ).find( 'input[name="ToProvince"]' ).val() + "" },
                            { "name": "ToCity", "value": "" + $( mark ).eq( index ).find( 'td' ).eq( 0 ).find( 'input[name="ToCity"]' ).val() + "" },
                            { "name": "ToDistrict", "value": "" + $( mark ).eq( index ).find( 'td' ).eq( 0 ).find( 'input[name="ToDistrict"]' ).val() + "" },
                            { "name": "UnitType", "value": "" + type + "" },
                            { "name": "Unit", "value": "" + unit + "" },
                            { "name": "UMin", "value": "0" },
                            { "name": "UMax", "value": "" + Max[j] + "" },
                            { "name": "Price", "value": "" + Prices[j+1] + "" },
                            { "name": "CarLength", "value": "0" }
                        ];
                    }
                    else{
                        city =
                        [
                            { "name": "DetailID", "value": "" + $( mark ).eq( index ).find( 'td' ).eq( j+1 ).find( 'input[name="DetailID"]' ).val() + "" },
                            { "name": "DocType", "value": "1" },
                            { "name": "FromProvince", "value": "" + $( '.ld .province' ).find( 'input[name="FromProvince"]' ).val() + "" },
                            { "name": "FromCity", "value": "" + $( '.ld .province' ).find( 'input[name="FromCity"]' ).val() + "" },
                            { "name": "FromDistrict", "value": "" + $( '.ld .province' ).find( 'input[name="FromDistrict"]' ).val() + "" },
                            { "name": "ToProvince", "value": "" + $( mark ).eq( index ).find( 'td' ).eq( 0 ).find( 'input[name="ToProvince"]' ).val() + "" },
                            { "name": "ToCity", "value": "" + $( mark ).eq( index ).find( 'td' ).eq( 0 ).find( 'input[name="ToCity"]' ).val() + "" },
                            { "name": "ToDistrict", "value": "" + $( mark ).eq( index ).find( 'td' ).eq( 0 ).find( 'input[name="ToDistrict"]' ).val() + "" },
                            { "name": "UnitType", "value": "" + type + "" },
                            { "name": "Unit", "value": "" + unit + "" },
                            { "name": "UMin", "value":"" + Max[j - 1] + "" },
                            { "name": "UMax", "value": "" + Max[j] + "" },
                            { "name": "Price", "value": "" + Prices[j+1] + "" },
                            { "name": "CarLength", "value": "0" }
                        ];
                    }

                    Total.push( city );
                }                    
            }
        }
    } );
    
    return isReady;
}
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
	var hash = {};
	for(var ecl = 0; ecl < len; ecl++)
	{       
		//去除json数组里面重复情况
		(hash[endCity[ecl]] == undefined) && (hash[endCity[ecl]["ToProvince"]+","+endCity[ecl]["ToCity"]+","+endCity[ecl]["ToDistrict"]]=endCity[ecl]["ToProvince"]+","+endCity[ecl]["ToCity"]+","+endCity[ecl]["ToDistrict"]);
	}
	for(var o in hash)
	{
		var hashCity =
            {
                'ToProvince': o.split(',')[0],
                'ToCity': o.split(',')[1],
                'ToDistrict': o.split(',')[2]
            };		
		endCitys.push(hashCity);
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
					$('.num button.selectpicker span.filter-option').attr('style','color: #DF771E;');
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
            case 'AdditionPrice' :
                _row_add( $(this), undefined, undefined );
                $(this).next()[0].isDirty = true;
                $( 'tr[nrowid="AdditionPrice"]' ).find( 'td a' ).attr( 'onclick', ' ' );
                break;   
        }
    }

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
    $('input').hover(function(){
    //if( $(this).attr('readonly') != undefined || $(this).attr('disabled') != undefined){
    //}else{
    //    //$(this).val('');
        //}
        var thisVal = $(this).val();
        $(this).attr("title", thisVal);
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
	//获取TR fb-options 和 nrowid值
	var fb = $(that).parent().parent().attr('fb-options');
	var nrowid = $(that).parent().parent().attr('nrowid');
	if(fb == undefined)
		$(that).parent().parent().parent().append('<tr>'+ copyCont +'</tr>');
	else
		$(that).parent().parent().parent().append('<tr fb-options="'+ fb +'" nrowid="'+ nrowid +'">'+ copyCont +'</tr>');
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
	$(that).parent().parent().parent().find('tr:last')[0].isDirty = true;
}

//重新报价
function reDocPrice( DocID ) {
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'pml_0037';

    var _paras = [{}, {}];
    _paras[0].name = "DocID";
    _paras[0].value = DocID;

    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
               Result( data[0] );

            } else {
                alert(data[0].msg);
            }
        });
}

//对话框双击列表选中事件
function dblEvents(){
        $(window.parent.document.getElementsByClassName('okButton')).trigger('click');
    }

//<!--合单报价  键盘控制光标移动-->
function EdtCombPrice_Keydown()
{
	$('body').on('keydown',function(e)
	{
		var event=e||window.event;
		var keyVal=event.keyCode;

		if( $('table td input:focus').size() != 0 )
		{
			var baseTr=parseInt($('table td input:focus').parent().parent()[0].rowIndex);
			var baseTd=parseInt($('table td input:focus').parent()[0].cellIndex);
			switch (keyVal)
			{
				//
				case 37://左
					if(baseTd>0)
					{
						$('table tbody tr:nth-child('+(baseTr+1)+')  td:nth-child('+(baseTd)+') input')[0].focus();
					}
					break;
				case 39://右
					if(baseTd<$('.key_down_bottom td').size()-1)
                    {
						$('table tbody tr:nth-child('+(baseTr+1)+')  td:nth-child('+(baseTd+2)+') input')[0].focus();
					}
					break;
			}
		}
	});
}

//huzy 2016-06  合约报价    复制目的地
/*function Copy_destination(index)
{
	//Author : Three Knives
	//当前选中单位
	var actName = $('.ld li.active a').attr('aria-controls');
	// index值有效 并且 index 不等于 actName
	if( index != '' && index != actName )
	{
		//当前选中复制列表有效TR个数
		var trLength = $('#' + index + ' tr').length - 2;
		//声明一个数组 用于装入 省市区
		var DocByCity = [];
		//遍历tr 取出 省市区
		for( var i = 0; i < trLength; i++)
		{
			var DocPcd =
            {
				'ToName' : $('#' + index + ' tr').eq(i+2).find('input[name="ToName"]').val(),
                'ToProvince': $('#' + index + ' tr').eq(i+2).find('input[name="ToProvince"]').val(),
                'ToCity': $('#' + index + ' tr').eq(i+2).find('input[name="ToCity"]').val(),
                'ToDistrict': $('#' + index + ' tr').eq(i+2).find('input[name="ToDistrict"]').val()
            };				
			DocByCity.push( DocPcd );
		}
		//获取当前单位项，TR内已选城市
		var actCity = [];
		$('#' + actName + ' tr').each(function(i)
		{
			if( i > 1 )
			{
				var actPcd =
				{
					'ToName' : $('#' + actName + ' tr').eq( i ).find('input[name="ToName"]').val()
				};				
				actCity.push( actPcd );
			}			
		});
		//去重
		for( var act = 0; act < actCity.length; act++ )
		{
			for( var doc = 0; doc < DocByCity.length; doc++ )
			{
				if( actCity[act].ToName == DocByCity[doc].ToName )
				{					
					DocByCity.splice( doc, 1 );		
				}
			}
		}		
		//判断当前选择的是否有数据
		if( DocByCity != '' && DocByCity[0].ToName != '' )
		{
			//判断当前是否填过数据
			if( $('#' + actName + ' tr').length > 2 )
			{
				//记录TR为空的有几个
				var nullTr = 0;
		
				for( var tr = 0; tr < $('#' + actName + ' tr').length; tr++)
				{
					if( $('#' + actName + ' tr').eq( tr + 2 ).find('input[name="ToName"]').val() == '' )
					{
						nullTr++;
					}					
				}
				if( $('#' + actName + ' tr').eq(2).find('input[name="ToName"]').val() == '' )
				{
					//生成TR,因为未填写状态本身有一个空的TR 所以长度 -1 ,
					for( var j = 0; j < DocByCity.length - nullTr; j++)
					{
						$('#' + actName).find('a[name="add"]').click();
					}
				}
				else
				{
					//生成TR,已填写
					for( var j = 0; j < DocByCity.length; j++)
					{
						$('#' + actName).find('a[name="add"]').click();
					}
				}
			}
			else
			{
				//如果连初始填写行数也没有
				for( var j = 0; j < DocByCity.length; j++)
				{
					$('#' + actName).find('a[name="add"]').click();
				}
			}
			for( var d = 0; d < DocByCity.length; d++ )
			{
				//赋值
				var DocByCityLength = DocByCity.length;
				//记录TR行数
				var rows = $('#' + actName + ' tr').length - DocByCityLength;
				$('#' + actName + ' tr').eq( d + rows ).find('input[name="ToName"]').val(DocByCity[d].ToName);
				$('#' + actName + ' tr').eq( d + rows ).find('input[name="ToProvince"]').val(DocByCity[d].ToProvince);
				$('#' + actName + ' tr').eq( d + rows ).find('input[name="ToCity"]').val(DocByCity[d].ToCity);
				$('#' + actName + ' tr').eq( d + rows ).find('input[name="ToDistrict"]').val(DocByCity[d].ToDistrict);
			}		
		}	
	}
}
*/
function Copy_destination(select) {     //合约报价复制城市
    var _optionVal = $(select).val();
    var _liVal = $('ul[role="tablist"]>.active a').attr('aria-controls');
    var _ToName;
    var _ToProvince;
    var _ToCity;
    var _ToDistrict;
    var _lessli;
    var _row = 1;

    _lessli = $('tbody#'+ _liVal +' li.active a').attr('aria-controls');

    if (typeof _lessli == 'undefined') {
        _lessli = _liVal;
        if ( _optionVal == 'PMS_FullLoad') {
            _row = 3;
        }

        if (_lessli == 'PMS_FullLoad' && $('tbody#PMS_FullLoad').find('input[name="FromName"]').val() == '') {
            alert('请选择起点城市区！');
            return;
        }
    }
    $('tbody#'+ _optionVal +' tr:gt('+ _row +')').each(function() {
        _ToName = $(this).find('input[name="ToName"]').val();
        _ToProvince = $(this).find('input[name="ToProvince"]').val();
        _ToCity = $(this).find('input[name="ToCity"]').val();
        _ToDistrict = $(this).find('input[name="ToDistrict"]').val();

        if (_ToName != '') {
            if ($('tbody#'+ _lessli +' tr:last').find('input[name="ToName"]').val() != '') {
                $('tbody#'+ _lessli +' a[name="add"]').click();
            }
            $('tbody#'+ _lessli +' tr:last').find('input[name="ToName"]').val(_ToName);
            $('tbody#'+ _lessli +' tr:last').find('input[name="ToProvince"]').val(_ToProvince);
            $('tbody#'+ _lessli +' tr:last').find('input[name="ToCity"]').val(_ToCity);
            $('tbody#'+ _lessli +' tr:last').find('input[name="ToDistrict"]').val(_ToDistrict);
        }

        
    });
}

//huzy    2016-06-24   按单报价，不填写任何价格，保存时，建议弹出提示
function NoZero( a ) {
    var flag = false;
    $('tr.CombineOrderPrice').find("input.price").each(function(){
    	var num = $(this).val();
       	if(num*1 != 0 && num != undefined && num != ""){
            flag = true;
      	}
    });

    if( flag ){
        var table = $(a).closest( 'table' );

        if (table.length != 0) {    //保存
            $('#Issend').val(0);
            SaveFormDataNDT( table, $(a), __saveNdtCfg );
        } else {        //发送
            table = $( 'table' );
            $('#Issend').val(1);
            SaveFormDataNDT( table, $(a), __saveNdtCfg );
        }
    }else{
        alert("价格至少填写一项！");
        if ( $('#myModal').length != 0 ) {
            $('#myModal').modal("hide");
        }
    }
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

 //按单报价合计
function sumTotalPrice( input ) {
      $(input).val( $(input).val().replace(/[^\d.]/g,'') );
      var inputs = $('tr.CombineOrderPrice').find("input.price");
      var value = 0;
      var totalPrice = 0;
      inputs.each( function(){
          value = parseFloat( $(this).val() );
          if( isNaN( value ) ){
              value = 0;
          }
          totalPrice += value;
      });
      $('input[name="TotalAmounts"]').val( totalPrice.toFixed(2) );
    }

function promptFromAddr( id ){
    var _from ;
    if( id == "PMS_LessLoad" ){
        _from = $('#'+ id).find("input[name='From']").val();

        if ($('#'+ id).find('li.active').attr('aria-controls') == 'num') {
            if ($('#'+ id).find('input[name="Unit"]').val() == '') {
                alert('请选择数量单位！');
            }
        }
    }else if( id == "PMS_FullLoad" ){
        _from = $('#'+ id).find("input[name='FromName']").val();
    }
    if( _from == '' ){
      alert( "请选择起点城市！" );
    }
}

//跟踪报价单详情
function TrackDetail( id  ){
     $('tr[name="TrackDetail"]').attr('view-id', '{ id:"pml_0026",cross:"false", rowIdentClass:"TrackDetail", paras:[{"name":"docid","value":' + id + '}]}');
        var _myEvents = new NSF.System.Data.Grid();
        _myEvents.Pagination("first-ds-pag", $("div[name='first-ds-pag']"));
        _myEvents.Initialize("/", "TrackDetail", $("tr[name='TrackDetail']").attr("view-id"), $("tr[name='TrackDetail']"));
        $('.TrackDetail').each(function (index) {
            var _History;
            var _InsertTime = $(this).find('span[name="InsertTime"]').text();
            var _CreatorName = $(this).find('span[name="CreatorName"]').text();
            var _SrcStatusName = $(this).find('span[name="SrcStatusName"]').text();
            var _DstStatusName = $(this).find('span[name="DstStatusName"]').text();
            var _Operation = $(this).find('span[name="Operation"]').text();
            var _Description = $(this).find('span[name="Descriptions"]').text();
            var _CompanyName = $( this ).find( 'span[name="CompanyName"]' ).text();


            if (_Operation == '0') {
                _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CompanyName  + '发送了报价单，并将报价单状态从' + _SrcStatusName + '变成' + _DstStatusName;
            }
            else if (_Operation == '1') {
                _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CompanyName  + '拒绝了报价单，将报价单打回到待发送列表，订单状态变成' + _DstStatusName + '，拒绝原因：' + _Description;
            }

            $(this).find('span[name="History"]').text(_History);

        });
}

//复制提货送货费
function costCopy( a ){
    var _tr = $(a).closest("tr");
    var _nid = _tr.attr("nrowid");
    var _nrow = _tr.clone();

    _nrow.find('input[type="hidden"][name="id"]').val( uuid() );

    var rows=_tr.parent().find('[nrowid="'+ _nid+'"]');
    if(rows.length>0){
        _nrow.insertAfter(rows.eq(rows.length-1));
    }
    else{
        _nrow.insertAfter(row);
    }
    _nrow.find("select").each(function( index ){
        $(this).next("div").remove();
    });
    initNrowList( _nrow );

    var _inputVal1 = _tr.find('select:eq(0)').prev().val(), //单位类型
        _inputVal2 = _tr.find('select:eq(1)').prev().val(); //单位

    _nrow.find('select:eq(0)').prev().val( _inputVal1 );
    _nrow.find('select:eq(1)').prev().val( _inputVal2 );

    var _divbtn1 = _tr.find('select:eq(0)').next().find('li[rel="'+ _inputVal1 +'"]').text(),
        _divbtn2 = _tr.find('select:eq(1)').next().find('li[rel="'+ _inputVal2 +'"]').text();

    _nrow.find('select:eq(0)').next().find("button span:eq(0)").text( _divbtn1 );
    _nrow.find('select:eq(1)').next().find("button span:eq(0)").text( _divbtn2 );

    _nrow[0].isDirty = true;
    _nrow.find( 'input[name="DetailID"]' ).val("0");
}

 //补充报价保存发送
function AdditionSend(num) {    //num 1:发送 0:保存
    var table = $( 'table' );
    $('#Issend').val(num);
    var _AddpriceLst = '<Add>';
    $('tr.AdditionPrice:gt(0)').each(function() {
        var _detailid = $(this).find('input[name="DetailID"]').val();
        var _addType = $(this).find('input[name="AdditionType"]').val();
        var _price = $(this).find('input[name="Price"]').val();
        var _descript = $(this).find('textarea[name="Description"]').val();
        _AddpriceLst += '<Pr><DetailID>'+ _detailid +'</DetailID><AdditionType>'+ _addType +'</AdditionType><Amount>'+ _price +'</Amount><Description>'+ _descript +'</Description></Pr>';    
    });
    _AddpriceLst += '</Add>';

    $('input[name="AddpriceLst"]').val(_AddpriceLst);
    SaveFormDataNDT( table, $('a.save'), __saveNdtCfg );
    
}

//反查订单费用显示
function FOrderPriceShow ( _id ){
    var _Self = $('input[name="Self"]').val();
    var _tOne, _tTwo, _tThree, _tFour, _tFive;
    var _code = $('body').attr('code');

    if (_Self == '1') {     //0:客户报价 1:自营
        if (_code == 'FDocSearch') {    //客户订单
             _tOne = 'Index_edit.aspx?code=Index';    //按单报价
             _tTwo = 'DocByCompact_edit.aspx?code=Index';    //合约报价
             _tThree = 'IndexAddition_edit.aspx?code=Index';   //按单补充
             _tFour = 'IndexCombined_edit.aspx?code=Index';   //合单报价
             _tFive = 'IndexAddCombined_edit.aspx?code=Index';   //合单补充
        } else {    //运输订单
             _tOne = 'SelfSent_edit.aspx?code=SelfSent';    //按单报价
             _tThree = 'SelfSentAddition_edit.aspx?code=SelfSent';   //合单补充
             _tFour = 'SelfSentCombined_edit.aspx?code=SelfSent';   //合单报价
             _tFive = 'SelfSentAddCombined_edit.aspx?code=SelfSent';   //合单补充
        }
    } else if (_Self == '0') {
         _tOne = 'Index_edit.aspx?read=0&code=VerifiedDoc';    //按单报价
         _tTwo = 'DocByCompact_edit.aspx?read=0&code=VerifiedDoc';    //合约报价
         _tThree = 'IndexAddition_edit.aspx?read=0&code=VerifiedDoc';   //按单补充
         _tFour = 'IndexCombined_edit.aspx?read=0&code=VerifiedDoc';   //合单报价
         _tFive = 'IndexAddCombined_edit.aspx?read=0&code=VerifiedDoc';   //合单补充
    }
    
    NSF.System.Data.RecordSet( "/", { id:"pml_0041",cross:"false", rowIdentClass:"OrderPrice", paras:[{"name":"OrderID","value": _id }] }, function ( result, config, data )
            {
                var _tdt = '<td class="td_name">类型</td>';
                var _td = '<td class="td_name">价格</td>';
                var _value;
                var _typeName;

                if( typeof data[1].rows[0] != 'undefined' ){

                    if( data[1].rows[0].LessLoad == '' || data[1].rows[0].LessLoad == '0.00' ) //零担
                    {}
                    else
                    {
                        _tdt += '<td >零担（RMB/元）</td>';
                        _td += '<td name="LessLoad" >'+ data[1].rows[0].LessLoad +'</td>';

                        _value = '';
                        _typeName = '';
                        if (data[1].rows[0].LessLoadDocType == '1') {
                            _value = '<a target="_blank" href="'+ _tOne +'&id='+ data[1].rows[0].LessLoadDocID +'">'+ data[1].rows[0].LessLoadDocCode +'</a>';
                            _typeName = '按单报价';
                        } else if (data[1].rows[0].LessLoadDocType == '2') {
                            _value = '<a target="_blank" href="'+ _tTwo +'&id='+ data[1].rows[0].LessLoadDocID +'">'+ data[1].rows[0].LessLoadDocCode +'</a>';
                            _typeName = '合约报价';
                        } else if (data[1].rows[0].LessLoadDocType == '4') {
                            _value = '<a target="_blank" href="'+ _tFour +'&id='+ data[1].rows[0].LessLoadDocID +'">'+ data[1].rows[0].LessLoadDocCode +'</a>';
                            _typeName = '合单报价';
                        }
                        $('tr[nrowid="PMS_LessLoad"] td:eq(0)').text(_typeName);
                        $('tr[nrowid="PMS_LessLoad"] td:eq(1)').html(_value);
                        $('tr[nrowid="PMS_LessLoad"] td:eq(2)').text(data[1].rows[0].LessLoadDocIDName);
                        $('tr[nrowid="PMS_LessLoad"] td:eq(3)').text(data[1].rows[0].LessLoad);

                        $('tr.PMS_LessLoad').removeClass('hide');
                    }
                    if( data[1].rows[0].FullLoad == '' || data[1].rows[0].FullLoad == '0.00' ) //整车
                    {
                    }
                    else
                    {
                        _tdt += '<td >整车（RMB/元）</td>';
                        _td += '<td name="FullLoad" >'+ data[1].rows[0].FullLoad +'</td>';
                        _value = '';
                        _typeName = '';
                        if (data[1].rows[0].FullLoadDocType == '1') {
                            _value = '<a target="_blank" href="'+ _tOne +'&id='+ data[1].rows[0].FullLoadDocID +'">'+ data[1].rows[0].FullLoadDocCode +'</a>';
                            _typeName = '按单报价';
                        } else if (data[1].rows[0].FullLoadDocType == '2') {
                            _value = '<a target="_blank" href="'+ _tTwo +'&id='+ data[1].rows[0].FullLoadDocID +'">'+ data[1].rows[0].FullLoadDocCode +'</a>';
                            _typeName = '合约报价';
                        } else if (data[1].rows[0].FullLoadDocType == '4') {
                            _value = '<a target="_blank" href="'+ _tFour +'&id='+ data[1].rows[0].FullLoadDocID +'">'+ data[1].rows[0].FullLoadDocCode +'</a>';
                            _typeName = '合单报价';
                        }
                        $('tr[nrowid="PMS_FullLoad"] td:eq(0)').text(_typeName);
                        $('tr[nrowid="PMS_FullLoad"] td:eq(1)').html(_value);
                        $('tr[nrowid="PMS_FullLoad"] td:eq(2)').text(data[1].rows[0].FullLoadDocIDName);
                        $('tr[nrowid="PMS_FullLoad"] td:eq(3)').text(data[1].rows[0].FullLoad);

                        $('tr.PMS_FullLoad').removeClass('hide');
                    }
                    if( data[1].rows[0].Pick == '' || data[1].rows[0].Pick == '0.00' )      //提货费
                    {
                    }
                    else
                    {
                        _tdt += '<td >提货费（RMB/元）</td>';
                        _td += '<td name="Pick" >'+ data[1].rows[0].Pick +'</td>';
                        _value = '';
                        _typeName = '';
                        if (data[1].rows[0].PickDocIDType == '1') {
                            _value = '<a target="_blank" href="'+ _tOne +'&id='+ data[1].rows[0].PickDocID +'">'+ data[1].rows[0].PickDocCode +'</a>';
                            _typeName = '按单报价';
                        } else if (data[1].rows[0].PickDocIDType == '2') {
                            _value = '<a target="_blank" href="'+ _tTwo +'&id='+ data[1].rows[0].PickDocID +'">'+ data[1].rows[0].PickDocCode +'</a>';
                            _typeName = '合约报价';
                        } else if (data[1].rows[0].PickDocIDType == '4') {
                            _value = '<a target="_blank" href="'+ _tFour +'&id='+ data[1].rows[0].PickDocID +'">'+ data[1].rows[0].PickDocCode +'</a>';
                            _typeName = '合单报价';
                        }
                        $('tr[nrowid="CityPickPrice"] td:eq(0)').text(_typeName);
                        $('tr[nrowid="CityPickPrice"] td:eq(1)').html(_value);
                        $('tr[nrowid="CityPickPrice"] td:eq(2)').text(data[1].rows[0].PickDocIDName);
                        $('tr[nrowid="CityPickPrice"] td:eq(3)').text(data[1].rows[0].Pick);

                        $('tr.CityPickPrice').removeClass('hide');
                    }
                    if( data[1].rows[0].Delivery == '' || data[1].rows[0].Delivery == '0.00' )      //送货费
                    {
                    }
                    else
                    {
                        _tdt += '<td >送货费（RMB/元）</td>';
                        _td += '<td name="Delivery" >'+ data[1].rows[0].Delivery +'</td>';
                        _value = '';
                        _typeName = '';
                        if (data[1].rows[0].DeliveryDocType == '1') {
                            _value = '<a target="_blank" href="'+ _tOne +'&id='+ data[1].rows[0].DeliveryDocID +'">'+ data[1].rows[0].DeliveryDocCode +'</a>';
                            _typeName = '按单报价';
                        } else if (data[1].rows[0].DeliveryDocType == '2') {
                            _value = '<a target="_blank" href="'+ _tTwo +'&id='+ data[1].rows[0].DeliveryDocID +'">'+ data[1].rows[0].DeliveryDocCode +'</a>';
                            _typeName = '合约报价';
                        } else if (data[1].rows[0].DeliveryDocType == '4') {
                            _value = '<a target="_blank" href="'+ _tFour +'&id='+ data[1].rows[0].DeliveryDocID +'">'+ data[1].rows[0].DeliveryDocCode +'</a>';
                            _typeName = '合单报价';
                        }
                        $('tr[nrowid="CityDeliveryPrice"] td:eq(0)').text(_typeName);
                        $('tr[nrowid="CityDeliveryPrice"] td:eq(1)').html(_value);
                        $('tr[nrowid="CityDeliveryPrice"] td:eq(2)').text(data[1].rows[0].DeliveryDocIDName);
                        $('tr[nrowid="CityDeliveryPrice"] td:eq(3)').text(data[1].rows[0].Delivery);

                        $('tr.CityDeliveryPrice').removeClass('hide');
                    }
                    if( data[1].rows[0].OnLoad == '' || data[1].rows[0].OnLoad == '0.00' )         //装货费
                    {
                    }
                    else
                    {
                        _tdt += '<td >装货费（RMB/元）</td>';
                        _td += '<td name="OnLoad" >'+ data[1].rows[0].OnLoad +'</td>';
                        _value = '';
                        _typeName = '';
                        if (data[1].rows[0].DeliveryDocType == '1') {
                            _value = '<a target="_blank" href="'+ _tOne +'&id='+ data[1].rows[0].OnLoadDocID +'">'+ data[1].rows[0].OnLoadDocCode +'</a>';
                            _typeName = '按单报价';
                        } else if (data[1].rows[0].DeliveryDocType == '2') {
                            _value = '<a target="_blank" href="'+ _tTwo +'&id='+ data[1].rows[0].OnLoadDocID +'">'+ data[1].rows[0].OnLoadDocCode +'</a>';
                            _typeName = '合约报价';
                        } else if (data[1].rows[0].DeliveryDocType == '4') {
                            _value = '<a target="_blank" href="'+ _tFour +'&id='+ data[1].rows[0].OnLoadDocID +'">'+ data[1].rows[0].OnLoadDocCode +'</a>';
                            _typeName = '合单报价';
                        }
                        $('tr[nrowid="OnLoadPrice"] td:eq(0)').text(_typeName);
                        $('tr[nrowid="OnLoadPrice"] td:eq(1)').html(_value);
                        $('tr[nrowid="OnLoadPrice"] td:eq(2)').text(data[1].rows[0].OnLoadDocIDName);
                        $('tr[nrowid="OnLoadPrice"] td:eq(3)').text(data[1].rows[0].OnLoad);

                        $('tr.OnLoadPrice').removeClass('hide');
                    }
                    if( data[1].rows[0].OffLoad == '' || data[1].rows[0].OffLoad == '0.00' )      //卸货费
                    {
                    }
                    else
                    {
                        _tdt += '<td >卸货费（RMB/元）</td>';
                        _td += '<td name="OffLoad" >'+ data[1].rows[0].OffLoad +'</td>';
                        _value = '';
                        _typeName = '';
                        if (data[1].rows[0].OffLoadDocType == '1') {
                            _value = '<a target="_blank" href="'+ _tOne +'&id='+ data[1].rows[0].OffLoadDocID +'">'+ data[1].rows[0].OffLoadDocCode +'</a>';
                            _typeName = '按单报价';
                        } else if (data[1].rows[0].OffLoadDocType == '2') {
                            _value = '<a target="_blank" href="'+ _tTwo +'&id='+ data[1].rows[0].OffLoadDocID +'">'+ data[1].rows[0].OffLoadDocCode +'</a>';
                            _typeName = '合约报价';
                        } else if (data[1].rows[0].OffLoadDocType == '4') {
                            _value = '<a target="_blank" href="'+ _tFour +'&id='+ data[1].rows[0].OffLoadDocID +'">'+ data[1].rows[0].OffLoadDocCode +'</a>';
                            _typeName = '合单报价';
                        }
                        $('tr[nrowid="OffLoadPrice"] td:eq(0)').text(_typeName);
                        $('tr[nrowid="OffLoadPrice"] td:eq(1)').html(_value);
                        $('tr[nrowid="OffLoadPrice"] td:eq(2)').text(data[1].rows[0].OffLoadDocIDName);
                        $('tr[nrowid="OffLoadPrice"] td:eq(3)').text(data[1].rows[0].OffLoad);

                        $('tr.OffLoadPrice').removeClass('hide');
                    }
                    
                    if( data[1].rows[0].InsuranceCost == '' || data[1].rows[0].InsuranceCost == '0.00' )        //保险费
                    {
                    }
                    else
                    {
                        _tdt += '<td >保险费（RMB/元）</td>';
                        _td += '<td name="InsuranceCost" >'+ data[1].rows[0].InsuranceCost +'</td>';
                        _value = '';
                        _typeName = '';
                        if (data[1].rows[0].InsuranceCostDocType == '1') {
                            _value = '<a target="_blank" href="'+ _tOne +'&id='+ data[1].rows[0].InsuranceCostDocID +'">'+ data[1].rows[0].InsuranceCostDocCode +'</a>';
                            _typeName = '按单报价';
                        } else if (data[1].rows[0].InsuranceCostDocType == '2') {
                            _value = '<a target="_blank" href="'+ _tTwo +'&id='+ data[1].rows[0].InsuranceCostDocID +'">'+ data[1].rows[0].InsuranceCostDocCode +'</a>';
                            _typeName = '合约报价';
                        } else if (data[1].rows[0].InsuranceCostDocType == '4') {
                            _value = '<a target="_blank" href="'+ _tFour +'&id='+ data[1].rows[0].InsuranceCostDocID +'">'+ data[1].rows[0].InsuranceCostDocCode +'</a>';
                            _typeName = '合单报价';
                        }
                        $('tr[nrowid="InsurancePrice"] td:eq(0)').text(_typeName);
                        $('tr[nrowid="InsurancePrice"] td:eq(1)').html(_value);
                        $('tr[nrowid="InsurancePrice"] td:eq(2)').text(data[1].rows[0].InsuranceCostDocIDName);
                        $('tr[nrowid="InsurancePrice"] td:eq(3)').text(data[1].rows[0].InsuranceCost);

                        $('tr.InsurancePrice').removeClass('hide');
                    }
                    if( data[1].rows[0].Addition == '' || data[1].rows[0].Addition == '0.00' )      //附加费
                    {
                    }
                    else
                    {
                        _tdt += '<td >附加费（RMB/元）</td>';
                        _td += '<td name="Addition" >'+ data[1].rows[0].Addition +'</td>';

                        if (data[2].rows.length > 0) {
                            for (var i = 0; i < data[2].rows.length; i++) {
                                _value = '';
                                _typeName = '';
                                if (data[2].rows[i].AdditionType == '1') {
                                    _value = '<a target="_blank" href="'+ _tOne +'&id='+ data[2].rows[i].AdditionDocID +'">'+ data[2].rows[i].AdditionDocCode +'</a>';
                                    _typeName = '按单报价';
                                } else if (data[2].rows[i].AdditionType == '2') {
                                    _value = '<a target="_blank" href="'+ _tTwo +'">'+ data[2].rows[i].AdditionDocCode +'</a>';
                                    _typeName = '合约报价';
                                } else if (data[2].rows[i].AdditionType == '3') {
                                    _value = '<a target="_blank" href="'+ _tThree +'&id='+ data[2].rows[i].AdditionDocID +'&OrderID='+ data[2].rows[i].OrderID +'">'+ data[2].rows[i].AdditionDocCode +'</a>';
                                    _typeName = '按单补充';
                                } else if (data[2].rows[i].AdditionType == '4') {
                                    _value = '<a target="_blank" href="'+ _tFour +'&id='+ data[2].rows[i].AdditionDocID +'">'+ data[2].rows[i].AdditionDocCode +'</a>';
                                    _typeName = '合单报价';
                                }else if (data[2].rows[i].AdditionType == '5') {
                                    _value = '<a target="_blank" href="'+ _tFive +'&id='+ data[2].rows[i].AdditionDocID +'&OrderID='+ data[2].rows[i].OrderID +'">'+ data[2].rows[i].AdditionDocCode +'</a>';
                                    _typeName = '合单补充';
                                }
                                if (i == 0) {
                                    $('tr[nrowid="AdditionPrice"] td:eq(0)').text(_typeName);
                                    $('tr[nrowid="AdditionPrice"] td:eq(1)').html(_value);
                                    $('tr[nrowid="AdditionPrice"] td:eq(2)').text(data[2].rows[0].AdditionDocIDName);
                                    $('tr[nrowid="AdditionPrice"] td:eq(3)').text(data[2].rows[0].AdditionDetail);
                                } else {
                                    $('tr[nrowid="AdditionPrice"]:eq('+ (i-1) +')').after( $('tr[nrowid="AdditionPrice"]:eq(0)').clone());
                                    $('tr[nrowid="AdditionPrice"]:eq('+ i +') td:eq(0)').text(_typeName);
                                    $('tr[nrowid="AdditionPrice"]:eq('+ i +') td:eq(1)').html(_value);
                                    $('tr[nrowid="AdditionPrice"]:eq('+ i +') td:eq(2)').text(data[2].rows[i].AdditionDocIDName);
                                    $('tr[nrowid="AdditionPrice"]:eq('+ i +') td:eq(3)').text(data[2].rows[i].AdditionDetail);
                                }
                            }
                        }

                        $('tr.AdditionPrice').removeClass('hide');
                    }
                    if( data[1].rows[0].Tax == '' || data[1].rows[0].Tax == '0.00' )      //附加费
                    {
                    }
                    else
                    {
                        _tdt += '<td >税费（RMB/元）</td>';
                        _td += '<td name="Tax" >'+ data[1].rows[0].Tax +'</td>';
                        _value = '';
                        _typeName = '';
                        if (data[1].rows[0].TaxDocType == '1') {
                            _value = '<a target="_blank" href="'+ _tOne +'&id='+ data[1].rows[0].TaxDocID +'">'+ data[1].rows[0].TaxDocCode +'</a>';
                            _typeName = '按单报价';
                        } else if (data[1].rows[0].TaxDocType == '2') {
                            _value = '<a target="_blank" href="'+ _tTwo +'&id='+ data[1].rows[0].TaxDocID +'">'+ data[1].rows[0].TaxDocCode +'</a>';
                            _typeName = '合约报价';
                        } else if (data[1].rows[0].TaxDocType == '4') {
                            _value = '<a target="_blank" href="'+ _tFour +'&id='+ data[1].rows[0].TaxDocID +'">'+ data[1].rows[0].TaxDocCode +'</a>';
                            _typeName = '合单报价';
                        }
                        $('tr[nrowid="TaxPrice"] td:eq(0)').text(_typeName);
                        $('tr[nrowid="TaxPrice"] td:eq(1)').html(_value);
                        $('tr[nrowid="TaxPrice"] td:eq(2)').text(data[1].rows[0].TaxDocIDName);
                        $('tr[nrowid="TaxPrice"] td:eq(3)').text(data[1].rows[0].Tax);

                        $('tr.TaxPrice').removeClass('hide');
                    }

                    _tdt += '<td >合计（RMB/元）</td>';
                    _td += '<td name="Total" >'+ data[1].rows[0].Total +'</td>';
                }
                else{
                    _tdt += '<td >合计</td>';
                    _td += '<td ></td>';
                }
                
                $( 'tr[name="OrderPriceTitle"]' ).append( _tdt );
                $( 'tr[name="OrderPrice"]' ).append( _td );
            } );    
}

//上下左右键
$( document ).on( 'keydown', 'input', function ( e )
{
    var index = $( this ).parent().index();
    //上
    if ( e.which == 38 )
    {
        if ( $( this ).parent().parent().prev().attr( 'class' ) == 'hide' )
        {
            $( this ).parent().parent().prev().prev().find( 'td' ).eq( index ).find( 'input' ).focus();
        }
        else
        {
            $( this ).parent().parent().prev().find( 'td' ).eq( index ).find( 'input' ).focus();
        }
    }
        //下
    else if ( e.which == 40 )
    {
        if ( $( this ).parent().parent().next().attr( 'class' ) == 'hide' )
        {
            $( this ).parent().parent().next().next().find( 'td' ).eq( index ).find( 'input' ).focus();
        }
        else
        {
            $( this ).parent().parent().next().find( 'td' ).eq( index ).find( 'input' ).focus();
        }
    }
        //左
    else if ( e.which == 37 )
    {
        $( this ).parent().prev().find( 'input' ).focus();
    }
        //右
    else if ( e.which == 39 )
    {
        $( this ).parent().next().find( 'input' ).focus();
    }
} );

//列表页重置按钮 清空省市区
$('.box button[data-control-type="reset"]').click(function()
{
    $('.current2,input[name="FromProvince"],input[name="FromCity"],input[name="FromDistrict"]').val('');
    $('#ToButton').click();
});