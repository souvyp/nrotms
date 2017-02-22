//对话框双击列表选中事件
function dblEvents(){
    $(window.parent.document.getElementsByClassName('okButton')).trigger('click');
}
/*拖动效果*/
$('.modal-header,.modal-footer').on('mousedown',function( event ){
    drag(this.parentNode,event);
});
$('div#win-Common-Dialog .modal-body').on('mousedown',function( event ){
    drag(this.parentNode,event);
});
//复选框绑定单击事件
$('input[type="checkbox"]').on('click', function() {
    if ($(this).attr('checked')) {
        $(this).removeAttr('checked');
    } else {
        $(this).attr('checked', 'checked');
    }
});

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
function UserAdd(obj) {
    var _sum = 0;
    $('input[name="RoleID_id"]:checked').each(function() {
        _sum |= $(this).val();
    });

    $('input[name="RoleID"]').val(_sum);

    $(obj).removeAttr('btn-clicked');
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
function UserEdit() {
    var jsonData = $('#GeneralForm').serializeJson();

    var _RoleID = jsonData.RoleID;
    var _sum = 0;

    if (_RoleID != '256') {
        $('input[type="checkbox"]').each(function() {
            if ($(this).attr('checked')) {
                for (var i = 0; i < jsonData.Roleid.length; i++) {
                    if (i == 0) {
                        _sum = jsonData.Roleid[0];
                    } else {
                        _sum |= jsonData.Roleid[i];
                    }
                }
                jsonData.RoleID = _sum;

                return false;
            }
        });
    }
    DoUpdateGeneral(jsonData);
}

function GetGeneralProtocol(jsonData) {
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0060';
    pmls[0].paras = [];

    for (var key in jsonData) {
        var _t = {};
        _t.name = key;
        _t.value = jsonData[key];

        pmls[0].paras.push(_t);
    }

    return JsonToStr(pmls);
}

function DoGeneral(jsonData, callback) {
    NSF.System.Network.Ajax('/Portal.aspx',
        GetGeneralProtocol(jsonData),
        'POST',
        false,
        callback);
}


function GetUpdateGeneralProtocol(jsonData) {
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0049';
    pmls[0].paras = [];

    for (var key in jsonData) {
        var _t = {};
        _t.name = key;
        _t.value = jsonData[key];

        pmls[0].paras.push(_t);
    }

    return JsonToStr(pmls);
}

function DoUpdateGeneral(jsonData) {
    NSF.System.Network.Ajax('/Portal.aspx',
        GetUpdateGeneralProtocol(jsonData),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                alert('编辑成功!');
                setTimeout(function() {
                    back();
                }, 1000);
            } else {
                alert(data[0].msg);
            }
        });
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


function CompleteGeneral(result, data) {
    if (data[0].result) {
        //if ( data[0].rs[0].rows[0].User_Result == 0 )
        //{
        //    alert( '用户注册成功！' );
        //}
        //else
        //{
        //    alert( '错误代码：' + data[0].rs[0].rows[0].User_Result );
        //}
        Result(data[0]);
    } else {
        alert(data[0].msg);
    }
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


//显示错误代码
function Result(_ret) {
    var _result = {
        "Order_Result": "0",
        "Pwd_Result": "0",
        "Company_Result": "0",
        "User_Result": "0",
        "Detail_Result": "",
        "Bill_Result":""
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
        "-510005005": "请选择角色",
        "-510006001": "当前用户没有关联公司",
        "-510006002": "当前用户没有修改公司资料的权限",
        "-510006003": "修改失败",
        "-510007001": "当前用户没有关联公司",
        "-510007002": "当前用户没有罗列公司用户的权限",
        "-510024001": "只有管理员有权执行该操作",
        "-510024002": "公司编号是否有效",
        "-510024003": "启用或禁用失败",
        "-530001001": "当前用户没有关联公司",
        "-530001002": "当前用户没有添加订单的权限",
        "-530001003": "订单不存在[已回单的订单]",
        "-530001004": "明细不存在",
        "-530001005": "计算总重量总体积",
        "-530001006": "读取价格信息",
        "-530001007": "添加失败",
        "-530001008": "编辑失败",

        "-530002001": "当前用户没有关联公司",     //应收，应付对账单保存编辑
        "-530002002": "修改对账单失败",
        "-530002003": "新增对账单失败",
        "-530002004": "编辑对账单详情失败",
        "-530002005": "对账单无效",
        "-530002006": "用户无权限",
        "-530002007": "结账失败",
    };
    for (var key in _result) {
        if (typeof(_ret.rs[0].rows[0][key]) != 'undefined') {
            if (_ret.rs[0].rows[0][key] == 0) {
                alert('成功！');
                setTimeout(function() {
                    if ($('body').attr('code') == 'UpdatePwd') {
                        Exit();
                    } else if (location.href.split('.aspx')[0].split('/')[3] == 'splitSingle') {
                        location.href = '/OrderSend.aspx';
                    } else {
                        location.href = $('body').attr('code') + '.aspx';
                    }
                }, 2000);
            } else {
                if (typeof _msg[_ret.rs[0].rows[0][key]] == 'undefined') {
                    alert('错误信息：异常错误');
                } else {
                    alert('错误信息：' + _msg[_ret.rs[0].rows[0][key]]);
                }
            }
        }
    }
}


/*备注区域*/
$('.remarks_sign').click(function() {
    $('.remarks_area').css('display', 'table-row');
})

//普通用户重置密码功能（暂时不要）
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



//火狐底下textarea的高度固定
var rowsPanH = $('textarea').parents('tr').height();
$('textarea').css('height', rowsPanH + 'px');


//订单选择
function Balance_BillDetails(value) {
    var flag = true;
    var sum = 0;
    var _volume = 0;
    var _weight = 0;
    var _total = 0;
    var _amount = 0;
    var _receiptqty = 0;
    $('tr[nrowid="Balance_BillDetails"]').each(function() {
        if ($(this).find('input[name="OrderID"]').val() == value) {
            sum++;
        }

        if (sum > 2 || sum == 2) {
            flag = false;
        } else {
            var _volval = $(this).find('input[name="volume"]').val();
            var _weival = $(this).find('input[name="weight"]').val();
            var _totval = $(this).find('input[name="total"]').val();
            var _amoval = $(this).find('input[name="amount"]').val();
            var _recval = $(this).find('input[name="receiptqty"]').val();

            if (_totval.indexOf('span') != -1) {
                _totval = $(_totval).text().replace(/\s/g,'');
                $(this).find('input[name="total"]').val(_totval);
            } else {
                _totval = _totval.replace(/\s/g,'');
                $(this).find('input[name="total"]').val(_totval);
            }

            _volval = (_volval == '') ? '0.000000' : _volval;
            _weival = (_weival == '') ? '0.0000' : _weival;
            _totval = (_totval == '') ? '0.00' : _totval;
            _amoval = (_amoval == '') ? '0.00' : _amoval;
            _recval = (_recval == '') ? '0.00' : _recval;

            _volume += parseFloat(_volval);
            _weight += parseFloat(_weival);
            _total += parseFloat(_totval);
            _amount += parseFloat(_amoval);
            _receiptqty += parseFloat(_recval);
        }

        this.isDirty = true;
    });
    $('input[name="ToWeight"]').val(_weight.toFixed(4));
    $('input[name="ToVolume"]').val(_volume.toFixed(6));
    $('input[name="TotalQty"]').val(_amount.toFixed(2));
    $('input[name="TotalReceiptQty"]').val(_receiptqty.toFixed(2));
    $('input[name="ToAccount"]').val(_total.toFixed(2));

    //订单选择去重复
    var _cout = 0;
    $('tr[nrowid="Balance_BillDetails"]').each(function() {
        if ($(this).find('input[name="OrderID"]').val() == value) {
            _cout += 1;
        }

        if (_cout > 1) {
            $(this).remove();
        }
    });

    $('a.customer').attr('onclick', 'indexOrder(this)');

    return flag;
}

//选择订单
function SelectOrder(that) {
    var _OrdersLst = '';

    $('tr[nrowid="Balance_BillDetails"]').each(function(index) {
        _OrdersLst += $(this).find('input[name="OrderID"]').val();

        if (index < $('tr[nrowid="Balance_BillDetails"]').length - 1) {
            _OrdersLst += ',';
        }
    });

    $('input[name="OrdersLst"]').val(_OrdersLst);
    if (_OrdersLst == '') {
        alert('订单编号不能为空，请选择订单编号！');
    }else{
        var table = $(that).closest('table');
        SaveFormDataNDT(table, $(that), __saveNdtCfg);
    }
}

//生成日期控件
function GetDateEvent(that, options) {
    options.choose = function(dates) {
        $(that).trigger('change');
    };
    laydate(options);
}


/*去掉手型*/
function RemovePointer(){
    $('.form-control').each( function(){
        if( $(this).attr('readonly') || $(this).attr('disabled') ){
            $(this).css('cursor','default');
        }
    } );
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

/*显示合计*/
function showTotal() {
    var _weight = 0;
    var _volume = 0;
    var _qty = 0;
    var _total = 0;
    var _receiptqty = 0;
    var _payable = 0;
    var _payment = 0;
    
    
    $('tr[nrowid="Balance_BillDetails"]').each(function() {

        if ($(this).find('input[name="weight"]').val() != '') {
            _weight += parseFloat($(this).find('input[name="weight"]').val());
        }

        if ($(this).find('input[name="volume"]').val() != '') {
            _volume += parseFloat($(this).find('input[name="volume"]').val());
        }

        if ($(this).find('input[name="amount"]').val() != '') {
            _qty += parseFloat($(this).find('input[name="amount"]').val());
        }

        if ($(this).find('input[name="receiptqty"]').val() != '') {
            _receiptqty += parseFloat($(this).find('input[name="receiptqty"]').val());
        }

        if ($(this).find('input[name="total"]').val() != '') {
            _total += parseFloat($(this).find('input[name="total"]').val());
        }

        if ($(this).find('input[name="payable"]').val() != '') {
            _payable += parseFloat($(this).find('input[name="payable"]').val());
        }

        if ($(this).find('input[name="payment"]').val() != '') {
            _payment += parseFloat($(this).find('input[name="payment"]').val());
        }        
    });

    $('input[name="ToWeight"]').val(_weight.toFixed(4));
    $('input[name="ToVolume"]').val(_volume.toFixed(6));
    $('input[name="TotalQty"]').val(_qty.toFixed(2));
    $('input[name="TotalReceiptQty"]').val(_receiptqty.toFixed(2));
    $('input[name="ToAccount"]').val(_total.toFixed(2));
    $('input[name="Totalpayable"]').val(_payable.toFixed(2));
    $('input[name="Totalpayment"]').val(_payment.toFixed(2));
}

//删除订单明细
function deleteOrder(td) {
    var _volume =$('input[name="ToVolume"]').val();
    var _weight = $('input[name="ToWeight"]').val();
    var _total = $('input[name="ToAccount"]').val();
    var _amount = $('input[name="TotalQty"]').val();
    var _receiptqty = $('input[name="TotalReceiptQty"]').val();
    var _payable = $('input[name="Totalpayable"]').val();
    var _payment = $('input[name="Totalpayment"]').val();    
    var _trobj = $(td).closest('tr');

    var _volval = _trobj.find('input[name="volume"]').val();
    var _weival = _trobj.find('input[name="weight"]').val();
    var _totval = _trobj.find('input[name="total"]').val();
    var _amoval = _trobj.find('input[name="amount"]').val();
    var _recval = _trobj.find('input[name="receiptqty"]').val();
    var _payab = _trobj.find('input[name="payable"]').val();
    var _payme = _trobj.find('input[name="payment"]').val();    
    
    
    _volval = (_volval == '') ? '0.000000' : _volval;
    _weival = (_weival == '') ? '0.0000' : _weival;
    _totval = (_totval == '') ? '0.00' : _totval;
    _amoval = (_amoval == '') ? '0.00' : _amoval;
    _recval = (_recval == '') ? '0.00' : _recval;
    _payab = (_payab == '') ? '0.00' : _payab;
    _payme = (_payme == '') ? '0.00' : _payme;
    
//  最后一个行  判断 不删除
//  if ($('tr[nrowid="Balance_BillDetails"]').length < 2) {
//      _trobj.find('a').attr('executecode', '');
//      _volume = parseFloat(_volval);
//      _weight = parseFloat(_weival);
//      _total = parseFloat(_totval);
//      _amount = parseFloat(_amoval);
//      _receiptqty = parseFloat(_recval);
//  } else {
//      _volume -= parseFloat(_volval);
//      _weight -= parseFloat(_weival);
//      _total -= parseFloat(_totval);
//      _amount -= parseFloat(_amoval);
//      _receiptqty -= parseFloat(_recval);
//
//      _action_delete(_trobj, $(td));
//
//  }
 
    if ($('tr[nrowid="Balance_BillDetails"]').length == 1) {
      
        _volume = 0;
        _weight = 0;
        _total = 0;
        _amount = 0;
        _receiptqty = 0;
    	_payable = 0;
   		_payment = 0 ;
    
    } else {
        _volume -= parseFloat(_volval);
        _weight -= parseFloat(_weival);
        _total -= parseFloat(_totval);
        _amount -= parseFloat(_amoval);
        _receiptqty -= parseFloat(_recval);
    	_payable = _payab;
   		_payment = _payme ;
        _action_delete(_trobj, $(td));

    }
    $('input[name="ToWeight"]').val(_weight.toFixed(4));
    $('input[name="ToVolume"]').val(_volume.toFixed(6));
    $('input[name="TotalQty"]').val(_amount.toFixed(2));
    $('input[name="TotalReceiptQty"]').val(_receiptqty.toFixed(2));
    $('input[name="ToAccount"]').val(_total.toFixed(2));
    $('input[name="TotalReceiptQty"]').val(_receiptqty.toFixed(2));
    $('input[name="ToAccount"]').val(_total.toFixed(2));
    $('input[name="Totalpayable"]').val(_payable.toFixed(2));
    $('input[name="Totalpayment"]').val(_payment.toFixed(2));
}

//打印日期
function getdate() {
    var Dates = new Date();
    var year = Dates.getFullYear();
    var mounth = Dates.getMonth()+1;
    var day = Dates.getDate();
    var printdate = year+"/"+mounth+"/"+day;
    $(".date").text(printdate);
}


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

function showWindow(btn, titleStr, valueObj, addiParams, evSubmit){     //弹出框列表中选择订单时多选
    var _option=$(btn).attr('f-options');
    _option=eval('('+_option+')');
    var _value;
    var _sup = '';
    if (valueObj)
    {
    _sup = valueObj.val();
    if (typeof(_sup) == 'undefined')
    {
    _sup = '';
    }
    }
    if(_option.cls=="frame"){
    var table = $(btn).closest("table");
    var data=wrapFormData(table,true,true);
    var _url = calcTemplate( unescape( _option.url ), data );
    var _html = "               <div class=\"dialogue-header\" style=\"background-color:#f27302;position:relative;margin-left:10px;margin-right:10px;margin-top:20px; margin-bottom:20px;\">\n" +
    "                   <p style=\"text-align:left;background-color:white;margin-left:3px;padding-left:10px; color:#666; font-size:14px;\">" + titleStr + "</p>\n" +
    "                   <div style=\"position:absolute;top:-6px; right:0;\">\n" +
    "                       <button type=\"button\" class=\"btn btn-default pull-right\" data-dismiss=\"modal\" aria-label=\"Close\" title=\"关闭\" style=\"box-shadow:none;text-shadow:none;\"><span aria-hidden=\"true\" class=\"\">关闭</span><span class=\"glyphicon glyphicon-remove\" style=\"margin-left:2px;color:#888;\"></span></button>\n" +
    "                       <button type=\"button\" class=\"btn btn-default okCheckboxButton pull-right  footKeepBtn\" style=\"margin-right:10px;box-shadow:none;text-shadow:none;\" aria-label=\"OK\" title=\"确定\" ><span aria-hidden=\"true\" class=\"\">确定</span><span class=\"glyphicon glyphicon-ok\" style=\"margin-left:2px;\"></span></button>\n" +
    "                   </div>\n" +
    "               </div>\n" +
    "<iframe src='" + _url + "?value=" + _sup;
    if (addiParams && addiParams != "")
    {
    _html += "&" + addiParams;
    }
    _html += "' />";
    $( '#win-Common-Dialog .content' ).html( _html );
    $('#win-Common-Dialog .okCheckboxButton').unbind('click');
    $('#win-Common-Dialog .okCheckboxButton')[0]._btn=btn;
    $('#win-Common-Dialog .okCheckboxButton')[0]._option=_option;
    $('#win-Common-Dialog .okCheckboxButton').bind('click',function()
    {
        var thatBtn=this._btn;
        var thatOption=this._option;

        var frame=$('#win-Common-Dialog .content iframe');
        var tr = frame[0].contentWindow.selectTrData();
        var trObj = $(thatBtn).closest('tr');
        var _nrowid = trObj.attr('nrowid');

        for (var i = 0; i < tr.length; i++) {
            if (i > 0) {
                $('a[name="add"]').click();
                
                Assignment($('tr[nrowid="'+ _nrowid +'"]:last').find('td:eq(0) input')[0],thatOption, tr[i]);
            } else {
                Assignment(thatBtn,thatOption, tr[i]);
            }

        }

        
    });
    $('#win-Common-Dialog').modal('show');
    function Assignment(thatBtn,thatOption, tr){
        if (!tr)
        {
            return;
        }

        function GetTrVals(fld)
        {
            var _v = '';

            if(fld=="id") {
                _v+=tr.find('[name="'+fld+'"]').val();
            } else {
                _v+=tr.find('[fld="'+fld+'"]').html();
            }
            
            return _v;
        };

        $(thatBtn).find('input[type="hidden"]').val(GetTrVals('id'));
        var btnTr=$(thatBtn).closest('tr');
        if(!btnTr.attr("nrowid"))
        {
            btnTr=table.find("tr:not([nrowid]):not(rowid)");
        }
        var pushValus=thatOption.vals;
        if(pushValus)
        {
            var arrs = pushValus.split(',');
        for(var i=0;i<arrs.length;i++)
        {
        var arr=arrs[i].split('=');
        var _v = GetTrVals(arr[1]);
        if( arr[1] == 'id' )
        {
        _value = _v;
        }
        if(_v)
        {
        btnTr.find( '[name="' + arr[0] + '"]' ).val( _v );
        var _select;
        _select = btnTr.find( '[name="' + arr[0] + '"]' ).next();
        _select.find('option').each( function ()
        {
        if ( _select.attr( 'name' ).split( '_' )[0] == arr[0] )
        {
        if ( $( this ).val() == _v )
        {
        $( this ).attr( 'selected', 'selected' );
        $( this ).parent().next().find( 'button' ).attr( 'title', $( this ).text() );
        $( this ).parent().next().find( '.filter-option' ).text( $( this ).text() );
        pushDisplayValue( $( this ).parent() );
        _DoComboLinking( $( this ).parent() );
        }
        }
        } );
        }
        else
        btnTr.find('[name="'+arr[0]+'"]').val('');
        }
        }
        if (evSubmit)
        {
        if (evSubmit(_value))
        {
        $('#win-Common-Dialog').modal('hide');
        }
        else
        {
        $('#win-Common-Dialog').modal('hide');
        $(btn).closest('tr').remove();
        }
        }
        else
        {
        $('#win-Common-Dialog').modal('hide');
        }
        }
        }
}

function checkboxAll(input) {      //多选框，全选
    if ($(input)[0].checked) {
        $('input[type="checkbox"]').each( function() {
            $(this)[0].checked = true;
        });
    } else {
        $('input[type="checkbox"]').each( function() {
            $(this)[0].checked = false;
        });
    }
}

//导出列表数据
function toXls( tableid ) {
    new NSF.System.Converter.ToXls().method1(tableid);
    //$('div#excel').modal( "hide" );
}

$('input.rangeModal').on( "click", function(){  //时间段选择
    $("div#rangeModal").modal( "show" );
    $("div#rangeModal").find('input').val('');
} );

//列表页按回车筛选按钮
document.onkeydown=function(event){
    var e = event || window.event || arguments.callee.caller.arguments[0];
    if(e && e.keyCode==13)
    { 
//      event.target.value = event.target.value.replace(/(^\s*)|(\s*$)/g, "");
        if($('.navTab a').eq(0).hasClass('active')){
            $('#search-button').click();    
        }else if($('.navTab a').eq(1).hasClass('active')){
            $('#city_search-button').click();   
        }else if($('.navTab a').eq(2).hasClass('active')){
            $('#name-search-button').click();   
        }else if($('.navTab a').eq(3).hasClass('active')){
            $('#long_search-button').click();   
        }else if($('.navTab a').eq(4).hasClass('active')){
            $('#pin_search-button').click();    
        }else if($('.navTab a').eq(5).hasClass('active')){
            $('#Qs_search-button').click(); 
        }else if($('.navTab a').eq(6).hasClass('active')){
            $('#Hd_search-button').click(); 
        }else{
            $('#name-search-button').click();   
            $('#search-button').click();    
            $('#desc-search-button').click();
        }
 
        
        resizeTable();
       
    }
}


// 拼车  订单物品多选赋值
function showWindow_before(btn, titleStr, valueObj, addiParams, evSubmit){
	var code_len_hu = $('tr[nrowid="Balance_BillDetails"]').find('input[name="OrderID"]').length;
	var code_id_hu = "";	
	for(var i = 0;code_len_hu > i;i++){
 		if($('tr[nrowid="Balance_BillDetails"]').find('input[name="OrderID"]').eq(i).val() != ""){
			code_id_hu +=  $('tr[nrowid="Balance_BillDetails"]').find('input[name="OrderID"]').eq(i).val() + ",";
 		}
	}
    if (code_id_hu.length > 0) {
        code_id_hu = code_id_hu.substr(0,code_id_hu.length - 1);
    }	
    code_hu = "code_List_val=" + code_id_hu;
//	console.log(goods_id_hu);
	showWindow( btn, titleStr,valueObj, code_hu , evSubmit );
}


function payFinished(DocID) {        //对账单完结
    var _pmls = '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0236","paras":[{"name":"DocID","value":"'+ DocID +'"}]}]';
    NSF.System.Network.Ajax('/Portal.aspx',
        _pmls,
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