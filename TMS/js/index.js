/*拖动效果*/
$('.modal-header,.modal-footer').on('mousedown',function( event ){
    drag(this.parentNode,event);
});
$('div#win-Common-Dialog .modal-body').on('mousedown',function( event ){
    drag(this.parentNode,event);
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

};
 
document.onmouseover = function() {
    resizeTable_x();
    resizeTable();    
};


//浮点数计算  加减乘除   方法 
function style_add(a, b) { // 加
	var c, d, e;
	try {
		c = a.toString().split(".")[1].length;
	} catch(f) {
		c = 0;
	}
	try {
		d = b.toString().split(".")[1].length;
	} catch(f) {
		d = 0;
	}
	return e = Math.pow(10, Math.max(c, d)), (style_mul(a, e) + style_mul(b, e)) / e;
}

function style_sub(a, b) { //减
	var c, d, e;
	try {
		c = a.toString().split(".")[1].length;
	} catch(f) {
		c = 0;
	}
	try {
		d = b.toString().split(".")[1].length;
	} catch(f) {
		d = 0;
	}
	return e = Math.pow(10, Math.max(c, d)), (style_mul(a, e) - style_mul(b, e)) / e;
}

function style_mul(a, b) { //乘
	var c = 0,
		d = a.toString(),
		e = b.toString();
	try {
		c += d.split(".")[1].length;
	} catch(f) {}
	try {
		c += e.split(".")[1].length;
	} catch(f) {}
	return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
}

function style_div(a, b) { //除
	var c, d, e = 0,
		f = 0;
	try {
		e = a.toString().split(".")[1].length;
	} catch(g) {}
	try {
		f = b.toString().split(".")[1].length;
	} catch(g) {}
	return c = Number(a.toString().replace(".", "")), d = Number(b.toString().replace(".", "")), style_mul(c / d, Math.pow(10, f - e));
}
//浮点数计算  加减乘除   方法 



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

//列表页单击按钮去空格
document.onmousedown = function( event ){
    $(event.target.parentElement.parentElement).find('div.text-filter-box').each( function(){
        $(this).find('input').val(  $(this).find('input').val().replace(/(^\s*)|(\s*$)/g, "") );
    });
}

/*浏览器窗口变化时，固定头部宽度赋值*/
$(window).resize(function () {
    autoHead();
});
function autoHead() {
    var autoW = $('.formcontainer').width()+2;//+2是为了解决兼容边框
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

//是否确定接收订单
function ReceiveOrder(Accept, OrderID) {
    $('#myModal').modal('show');
    $('input[name="Accept"]').val(Accept);
    $('input[name="OrderID"]').val(OrderID);
    $('#myModal').find('button:eq(0)').attr( 'onclick', "OrderAccept()" );
    if (Accept == '0') {
        $('#myModal #myModalLabel p').text('拒收订单');
        $('.tab_jsjj').html('');
        var _html = '<div class="row"><label class="col-md-2 control-Label">拒收原因</label><div class="col-md-10">' +
            '<textarea name="Description" class="form-control" rows="3" cols="70"></textarea></div></div><input type="hidden" name="Accept" value="' + Accept + '"/><input type="hidden" name="OrderID" value="' + OrderID + '" />';
        $('.tab_jsjj').html(_html);
    } else if (Accept == '1') {
        $('#myModal #myModalLabel p').text('接收订单');
        $('.tab_jsjj').html('');
        var _html = '<span name="content">是否确定接收订单</span><input type="hidden" name="Accept" value="' + Accept + '"/><input type="hidden" name="OrderID" value="' + OrderID + '" />';
        $('.tab_jsjj').html(_html);
    }
}

//接受订单
function OrderAccept() {
    var _y = 1;
    if ($('input[name="Accept"]').val() == 0) {
        if ($('textarea[name="Description"]').val() == '') {
            _y = 0;
            alert('拒绝原因不能为空！');
        } else {
            _y = 1;
        }
    }
    if (_y == 1) {
        $('#myModal').modal('hide');
        var pmls = [{}];
        pmls[0].namespace = 'protocol';
        pmls[0].cmd = 'data';
        pmls[0].version = 1;
        pmls[0].id = 'tms_0066';

        var _paras = [{}, {}, {}];
        _paras[0].name = 'OrderID';
        _paras[0].value = $('input[name="OrderID"]').val();
        _paras[1].name = 'Accept';
        _paras[1].value = $('input[name="Accept"]').val();
        _paras[2].name = 'Description';
        _paras[2].value = $('textarea[name="Description"]').val();
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
}

//签收订单
function OrderSignEdit() {
    $('#myModal').modal('hide');
    var stat = 0;
    var Desc_YC = $('input[name="Desc_YC"]').val();
    var GoodsQty = '';
    $('tr[nrowid="TMS_OrderGoods"]').each(function(index) {
        var OrderID = $(this).find('input[name="ListID"]').val();
		//物品数量
        var Qty = $(this).find('input[name="Qty"]').val();         
        //实签数量
        var ReceiptQty = $(this).find('input[name="ReceiptQty"]').val(); 
        //异常数量
        var ExceptionQty = $(this).find('input[name="ExceptionQty"]').val();

        var _pattern = /^[0-9]+$/;
        GoodsQty += '' + OrderID + '=' + ReceiptQty + ',' + ExceptionQty + '';

        if ($('tr[nrowid="TMS_OrderGoods"]').length - 1 > index) {
            GoodsQty += ';';
        }
        if (ReceiptQty == 0 && ExceptionQty == 0 || ReceiptQty == '' && ExceptionQty == '') {
            stat = 1;
            return false;
        }
        if(!_pattern.test( ReceiptQty ) || !_pattern.test( ExceptionQty ) ){
            stat = 2;
            return false;
        }
//      huzy  2016-06-21  添加判断 异常数量  不能大于实签数量
        if (Qty*1 != ReceiptQty*1 + ExceptionQty*1) {
            stat = 3;
            return false;
        }        
    });
    if (stat == 1) {
        alert('请输入签收或异常数量！');
    }else if (stat == 2) {
        alert('实签数量或异常数量格式不正确，请输入整数！');
    }else if (stat == 3) {
        alert('实签数量和异常数量总和要与物品总数一致！');
    }else {
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
}

function OrderSign(result, data) {
    if (data[0].result) {
        Result(data[0]);
    } else {
        alert(data[0].msg);
    }
}

//新增费用明细
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
//打开是否回单对话框
function IsHd(HdID) {
    HdID = HdID ? HdID : getUrlParam('id');
    $('#IsHd').modal('show');
    $('input[name="HdID"]').val(HdID);
	//获取当前单据位置
	var ListTr = $('input[value="'+ HdID +'"]').parent().parent();
	//传值到模态内
	$('#IsHd .modal-body span').remove();
	$('#IsHd .modal-body').append( '<span class="receiptdoc hide">'+ ListTr.find('.receiptdoc').text() +'</span><span class="receiptDoc1 hide">'+ ListTr.find('.receiptDoc1').text() +'</span><span class="receiptDoc2 hide">'+ ListTr.find('.receiptDoc2').text() +'</span>');
}
    //回单上传照片跳转详情页
function loadPoto() {
    var detailId = $('input[name="HdID"]').val();
    location.href = location.href.split('.aspx')[0]+'_edit.aspx?id=' + detailId;
}
//订单回单
function OrderReceiptEdit(that) {
    $('#myModal').modal('hide');
    var dID = $('input[name="HdID"]').val();
    var _id = NSF.UrlVars.Get( 'id', location.href );
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0069';

    var _paras = [{}, {}, {}, {}, {}, {}];
    _paras[0].name = 'OrderID';
    _paras[1].name = 'ReceiptDocPath0';
    _paras[2].name = 'ReceiptDocPath1';
    _paras[3].name = 'ReceiptDocPath2';
    _paras[4].name = 'IsPaperReceived';
    if(that != undefined && that != '1')
    {
    	_paras[0].value = dID;
    	_paras[1].value = $(that).parent().parent().find('.receiptdoc').text();
    	_paras[2].value = $(that).parent().parent().find('.receiptDoc1').text();
    	_paras[3].value = $(that).parent().parent().find('.receiptDoc2').text();
    }
    else
    {
    	_paras[0].value = $('input[name="OrderID"]').val();
    	_paras[1].value = $('input[name="ReceiptDocPath0"]').eq(1).val();
    	_paras[2].value = $('input[name="ReceiptDocPath1"]').eq(1).val();
    	_paras[3].value = $('input[name="ReceiptDocPath2"]').eq(1).val();
    }  
	
	if( _id != ''  && that != '1')
	{
    	_paras[4].value = 0;
    }
	else
	{
		_paras[4].value = 1;
	}
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

//返回上一页
function back() {
    //history.go( -1 );
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
function Result( _ret, msg ) {
    var _result = {
        "Customer_Result": "0",
        "Supplier_Result": "0",
        "Addr_Result": "0",
        "Car_Result": "0",
        "Driver_Result": "0",
        "EndUser_Result": "0",
        "Goods_Result": "0",
        "GoodsType_Result": "0",
        "Order_Result": "0",
        "Pwd_Result": "0",
        "Company_Result": "0",
        "User_Result": "0",
        "Cost_Result": "0",
        "Back_Result": "0",
        "Flow_Result": "0",
        "Schedule_Result": "",
        "Combine_Result":""
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
        "-510008001": "当前用户没有关联公司",
        "-510008002": "当前用户没有添加客户的权限",
        "-510008003": "客户公司编号是否有效",
        "-510008004": "序列号生成失败",
        "-510008005": "客户公司是否存在,添加失败",
        "-510008006": "客户公司是否存在,编辑失败",
        "-510008007": "手动录入的客户公司名称是否重复",
        "-510009001": "当前用户没有关联公司",
        "-510009002": "当前用户没有添加承运方的权限",
        "-510009003": "承运方公司编号是否有效",
        "-510009004": "客户公司是否存在,添加失败",
        "-510009005": "承运方公司不存在(存在编辑, 不存在添加，被拒绝后允许再次添加)",
        "-510009006": "添加事件通知(被邀请成为供应商)失败",
        "-510009007": "序列号生成失败",
        "-510009008": "不能添加自己的公司为承运方",
        "-510009009": "不能重复邀请同一家公司为承运方",
        "-510010001": "当前用户没有关联公司",
        "-510010002": "当前用户没有添加客户的权限",
        "-510010003": "司机不存在,添加失败",
        "-510010004": "司机是否存在，编辑失败",
        "-510010005": "司机不能重名，姓名相同的司机，应该在姓名中添加标识符，例如：李明(湖南)、李明(山东)等",
        "-510011001": "当前用户没有关联公司",
        "-510011002": "当前用户没有添加客户的权限",
        "-510011003": "车辆不存在,添加失败",
        "-510011004": "车辆是否存在，编辑失败",
        "-510012001": "当前用户没有关联公司",
        "-510012002": "当前用户没有添加客户的权限",
        "-510012003": "司机不存在，新增失败",
        "-510012004": "司机是否存在，编辑失败",
        "-510013001": "当前用户没有关联公司",
        "-510013002": "当前用户没有添加客户的权限",
        "-510013003": "收货方不存在",
        "-510013004": "地址是否存在,添加失败",
        "-510013005": "地址是否存在,编辑失败",
        "-510014001": "当前用户没有关联公司",
        "-510014002": "当前用户没有添加客户的权限",
        "-510014003": "收货方不存在",
        "-510014004": "客户是否存在",
        "-510014005": "来源订单是否存在",
        "-510014006": "编辑模式订单是否存在[只能编辑自己公司的订单]",
        "-510014007": "只能编辑状态为新单据的订单",
        "-510014008": "添加主单信息失败",
        "-510014009": "编辑主单信息失败",
        "-510014010": "承运方是否存在",
        "-510014011": "追加物品信息失败",
        "-510014012": "客户没有填",
        "-510014013": "拆单模式按原单据生成编号失败",
        "-510014014": "修改货物总价值失败",
        "-510014015": "需要投保时货物总价值必须填写",
        "-510015001": "当前用户没有关联公司",
        "-510015002": "当前用户没有添加订单物品的权限",
        "-510015003": "订单不存在",
        "-510015004": "物品不存在",
        "-510015005": "物品添加失败",
        "-510015006": "物品编辑失败",
        "-510015007": "物品不能重复添加",
        "-510016001": "当前用户没有关联公司",
        "-510016002": "当前用户没有添加物品的权限",
        "-510016003": "物品类型是否存在",
        "-510016004": "添加物品失败",
        "-510016005": "编辑物品失败",
        "-510017001": "当前用户没有关联公司",
        "-510017002": "当前用户没有接受订单的权限",
        "-510017003": "订单不存在",
        "-510017004": "被拼车订单已经被接受",
        "-510017005": "接受订单[直接变为已调度]",
        "-510017006": "添加订单流程失败",
        "-510017007": "拒绝订单失败",
        "-510017008": "添加订单流程失败",
        "-510017009": "添加事件通知(订单被拒绝)",
        "-510017010": "添加事件通知(10 订单已接收)",
        "-510018001": "当前用户没有关联公司",
        "-510018002": "当前用户没有分配订单的权限",
        "-510018003": "订单是否存在",
        "-510018004": "订单是否已经被分配",
        "-510018005": "车辆是否存在",
        "-510018006": "司机是否存在",
        "-510018007": "分配订单失败",
        "-510018008": "添加订单流程失败",
        "-510019001": "当前用户没有关联公司",
        "-510019002": "当前用户没有签收订单的权限",
        "-510019003": "订单是否存在",
        "-510019004": "订单是否已经被签收",
        "-510019005": "签收订单失败",
        "-510019006": "添加订单流程失败",
        "-510019007": "更新实签数量，异常数量失败",
        "-510020001": "当前用户没有关联公司",
        "-510020002": "当前用户没有提交订单回单的权限",
        "-510020003": "订单是否存在",
        "-510020004": "订单是否已经回单",
        "-510020005": "回单路径不能为空",
        "-510020006": "订单回单编辑失败",
        "-510020007": "添加订单流程失败",
        "-510020008": "添加已回单事件通知失败",
        "-510020009": "添加上传回单照片事件通知失败",
        "-510021001": "当前用户没有关联公司",
        "-510021002": "当前用户没有添加客户的权限",
        "-510021003": "收件人公司编号是否有效",
        "-510021004": "序列号生成失败",
        "-510021005": "收件人添加失败",
        "-510021006": "收件人修改失败",
        "-510021007": "客户是否存在",
        "-510021008": "收件人名称已存在",
        "-510022001": "当前用户没有关联公司",
        "-510022002": "当前用户没有发送订单的权限",
        "-510022003": "订单是否存在",
        "-510022004": "订单是否已经被发送",
        "-510022005": "承运方是否存在",
        "-510022006": "发送订单失败",
        "-510022007": "添加订单流程失败",
        "-510022008": "指定承运方失败",
        "-510023001": "当前用户没有关联公司",
        "-510023002": "当前用户没有操作承运方的权限",
        "-510023003": "承运方公司编号是否有效",
        "-510023004": "接受失败",
        "-510023005": "拒绝失败",
        "-510023006": "",
        "-510024001": "只有管理员有权执行该操作",
        "-510024002": "公司编号是否有效",
        "-510024003": "启用或禁用失败",
        "-510025001": "当前用户没有关联公司",
        "-510025003": "当前用户没有拆单的权限",
        "-510025003": "来源订单不存在",
        "-510025004": "拆单后原始订单保留，原始订单状态修改为待签收失败",
        "-510025005": "复制原单失败",
        "-510025006": "写订单状态变更记录失败",
        "-510025007": "写订单状态变更记录失败",
        "-510025008": "复制原单物品信息失败",
        "-510026001": "当前用户没有关联公司",
        "-510026002": "当前用户没有添加订单费用的权限",
        "-510026003": "订单是否存在",
        "-510026004": "费用类型是否存在",
        "-510026005": "更新或添加失败",
        "-510028001": "当前用户没有关联公司",
        "-510028002": "当前用户没有启用或禁用客户的权限",
        "-510028003": "客户编号是否有效",
        "-510028004": "启用或禁用失败",
        "-510029001": "当前用户没有关联公司",
        "-510029002": "当前用户没有启用或禁用承运方的权限",
        "-510029003": "承运方编号是否有效",
        "-510029004": "启用或禁用失败",
        "-510030001": "当前用户没有关联公司",
        "-510030002": "当前用户没有启用或禁用最终用户的权限",
        "-510030003": "最终用户编号是否有效",
        "-510030004": "启用或禁用失败",
        "-510031001": "订单号是否存在",
        "-510031002": "下单公司是否是承运方的客户",
        "-510031003": "获取承运方的公司管理员",
        "-510031004": "下单失败",
        "-510031005": "订单的附属表(TMS_OrderCost)",
        "-510031006": "物品信息不能为空",
        "-510032001": "当前用户没有关联公司",
        "-510032002": "当前用户没有添加承运方的权限",
        "-510032003": "当前承运方是否存在",
        "-510032004": "线下承运方是否重名",
        "-510032005": "承运方编辑失败",
        "-510032006": "承运方新增失败",
        "-510033001": "当前用户没有关联公司",
        "-510033002": "当前用户没有打回订单的权限",
        "-510033003": "订单不存在",
        "-510033004": "已经委托供应商承运的单子暂时不能打回",
        "-510033005": "已审核(待分配)",
        "-510033006": "已分配(待签收)",
        "-510033007": "已签收(待回单)",
        "-510033008": "打回订单失败",
        "-510033009": "添加流程失败",
        "-510034001": "当前用户没有关联公司",
        "-510034002": "当前用户没有关闭订单的权限",
        "-510034003": "订单不存在",
        "-510034004": "关闭订单失败",
        "-510034005": "添加流程失败",
        "-510034006": "添加客户关闭委托订单事件通知失败",
        "-510034007": "添加承运方关闭订单事件通知失败",
        "-510035001": "当前用户没有关联公司",
        "-510035002": "当前用户没有添加订单备注的权限",
        "-510035003": "源订单不存在",
        "-510035004": "添加备注失败",
        
        "-510036001": "当前用户没有关联公司",
        "-510036002": "当前用户没有发送订单的权限",
        "-510036003": "原始订单是否存在，是否处于待调度状态(只有运输订单允许调度)",
        "-510036004": "自营",
        "-510036005": "自营,车辆不存在",
        "-510036006": "自营,司机不存在",
        "-510036007": "自营,分配订单失败",
        "-510036008": "自营,添加订单流程失败",
        "-510036009": "检查体积补差、重量补差、数量补差值是否正确",
        "-510036010": "承运方,司机不存在",
        "-510036011": "承运方,分配订单失败",
        "-510036012": "承运方,添加订单流程失败",
        
        "-510037001": "当前用户没有关联公司",
        "-510037002": "当前用户没有发送订单的权限",
        "-510037003": "订单不存在[仅运输订单能发送]",
        "-510037004": "订单已经被发送",
        "-510037005": "在线承运方不存在",
        "-510037006": "线上承运方",
        "-510037007": "添加事件通知(有待接收订单)",
        "-510038002": "当前用户没有关联公司",
        "-510038003": "当前用户没有添加客户的权限",
        "-510039004": "获取当前客户以及影响报价的其他因素失败",
        "-510039005": "委托给承运方的订单，应该使用承运方的报价，主客倒置了一下",
        "-510039006": "计算与当前订单编号配对的承运方客户订单失败",
        "-510039007": "被合单的订单不能单独计算价格",
        "-510040001": "当前用户没有关联公司",
        "-510040002": "请选择需要合单的订单",
        "-510040003": "当前用户没有添加客户的权限",
        "-510040004": "客户默认为自己公司",
        "-510040005": "编辑模式订单是否存在[只能编辑自己公司的订单]",
        "-510040006": "只能编辑状态为新单据的订单",
        "-510040007": "承应商不存在",
        "-510040008": "添加主单信息失败",
        "-510040009": "编辑主单信息失败",
        "-510040010": "现有被合单标记",
        "-510040011": "删除现有拼车记录",
        "-510040012": "添加拼车记录",
        "-510040013": "被合单订单做标记",
        "-510043001": "当前用户没有关联公司",
        "-510043002": "当前用户没有接受单据的权限",
        "-510043003": "单据不存在",
        "-510043004": "修改单据状态失败",
        "-510043005": "添加订单流程失败",
        "-510043006": "获取承运方端的操作者[默认为管理员]",
        "-510043007": "单据被拒绝失败",
        "-510043008": "添加订单流程失败",
        "-510043009": "添加事件通知(13 订单被拒绝)",
        "-510043010": "添加事件通知(14 单据已接收)",
        "-510043011": "更新被合单订单列表的总体积、总重量、总数量失败",
        "-510044001": "当前用户没有关联公司",
        "-510044002": "当前用户没有关闭订单的权限",
        "-510044003": "拼车不存在(只有未经审核的拼车单才能关闭)",
        "-510044004": "关闭订单失败",
        "-510044005": "释放被拼车订单失败",
        "-510045001": "当前用户没有关联公司",
        "-510045002": "没有选择拼车单",
        "-510045003": "当前用户没有添加客户的权限",
        "-510045004": "订单不存在",
        "-510045005": "只待发送的单据能追加",
        "-510045006": "添加拼车记录失败",
        "-510045007": "被合单订单做标记",
        "-510046001": "当前用户没有关联公司",
        "-510046002": "没有选择拼车单",
        "-510046003": "当前用户没有添加客户的权限",
        "-510046004": "订单不存在",
        "-510046005": "只待发送的单据能删除",
        "-510046006": "删除拼车记录失败",
        "-510046007": "源被合单订单清除标记",
        "-510047001": "当前用户没有关联公司",
        "-510047002": "当前用户没有关闭订单的权限",
        "-510047003": "拼车不存在(只有新单据的拼车单才能发送)",
        "-510047004": "发送订单失败",
        "-510049001": "当前用户没有关联公司",
        "-510049002": "当前用户没有修改公司资料的权限",
        "-510049003": "序列号生成失败",
        "-510049004": "获取线下承运方编号失败",
        "-510049005": "参数无效",
        "-510049006": "公司名已存在",
        "-510049007": "添加公司失败",
        "-510050001": "当前用户没有关联公司",
        "-510050002": "当前用户没有修改公司资料的权限",
        "-510050003": "当前是否为线下承运方",
        "-510006001": "当前用户没有关联公司",
        "-510006002": "当前用户没有修改公司资料的权限",
        "-510006003": "当前用户没有修改公司资料的权限[非线下承运方公司]",
        "-510006004": "当前用户没有修改线下承运方资料的权限",
        "-510006005": "判断线下承运方公司名是否重复",
        "-510006006": "修改公司信息失败",
        "-510052001": "当前用户没有关联公司",
        "-510052002": "当前用户没有签收订单的权限",
        "-510052003": "订单是否存在",
        "-510052004": "订单是否已经被签收",
        "-510052005": "签收订单失败",
        "-510052006": "添加订单流程失败",
        "-510052007": "更新实签数量、异常数量失败",
        "-510052008": "添加事件通知失败",
        "-510055001": "当前用户没有关联公司",
        "-510055002": "当前用户没有发送订单的权限",
        "-510055003": "当前订单不存在",
        "-510055004": "订单无法被撤回",
        "-510055005": "获取承运方公司的管理员账号失败",
        "-510055006": "修改订单相应字段失败",
        "-510055007": "添加订单流程失败",
        "-510055008": "添加事件通知失败",
        "-510059001": "当前用户没有关联公司",     //个人中心，配置信息(sp_pub_user_EditOrderCfg)
        "-510059002": "当前用户没有修改公司资料的权限",
        "-510059003": "修改配置信息失败",
        "-510059004": "添加配置失败",
        "-510025101": "当前用户没有关联公司",             //待调度拆单，[sp_prv_order_TransportPlan_V2]
        "-510025102": "当前用户没有拆单的权限",
        "-510025103": " 运输订单PrevOrderID是否存在，获取SrcOrderID等订单参数",
        "-510025104": "未拆单不许提交,应直接转入调度",
        "-510025105": "必须拆单，请根据线路或数量拆单",
        "-510025106": "拆单后关闭源订单并置为无效状态失败",
        "-510025107": "写订单状态变更记录失败",
        "-510025108": "线路信息不能为空",
        "-510025109": "物品信息不能为空",
        "-510014900": "来源订单是否存在(只有客户订单允许创建计划)",                       //下单时直接做计划，[sp_prv_order_AutoPlan]
        "-510014901": "复制原单失败",
        "-510014902": "写订单状态变更记录失败",
        "-510014903": "复制原单的物品信息失败",
        "-510014904": "原订单保留，便于和客户结算，原始订单状态修改为待签收失败",
        "-510014905": "写订单状态变更记录失败",

        "-510028005": "客户物品类型无效",        //物品类型启用禁用
        "-510028006": "此类型下还有物品未禁用",
        "-510028007": "物品类型禁用失败",
        "-510028008": "物品无效",
        "-510028009": "物品禁用失败",
        "-510028010": "客户地址无效",
        "-510028011": "禁用地址失败",
        "-510028012": "收货人是否有效",
        "-510028013": "收货人还有地址未禁用",
        "-510028014": "收货人禁用失败",
        "-510028015": "收货人地址无效",
        "-510028016": "收货人地址禁用失败",
        "-510028017": "物品类型被禁用",
        "-510028018": "客户已经被禁用",
    };
    for (var key in _result) {
        if (typeof(_ret.rs[0].rows[0][key]) != 'undefined') {
            if (_ret.rs[0].rows[0][key] == 0) {
                if( location.href.split('.aspx')[0].split('/')[4] == 'SupplierList_edit'){
                    $('#supModal').modal('show');
                }else if( location.href.split('.aspx')[0].split('/')[4] == 'OrderSend_edit' && key == "Order_Result"){
                    //alert( "成功！" );
                }else if( location.href.split('.aspx')[0].split('/')[4] == 'OrderSend_edit' && key == "Schedule_Result"){
                    alert( "调度成功！" );

					//调度完成后执行消息推送任务
					var _tk = $('input[name="NoticeKey"]').val();
					if (_tk != null && _tk != "" && $('input[name="IsSend"]').val() == "1") {
						infoSend( _tk, function()
						{
							setTimeout( function(){
								location.href = $('body').attr('code') + '.aspx';
							}, 300 );
						});
					}
					else
					{
						setTimeout( function(){
							location.href = $('body').attr('code') + '.aspx';
						}, 300 );
					}
                }else if ($('body').attr('code') == 'OrderSendCar') {
                    if (typeof _ret.rs[0].rows[0].Order_ID != 'undefined') {
                        $('input[name="OrderID"]').val(_ret.rs[0].rows[0].Order_ID);
                    }

                    //拼车单发送完成后执行消息推送任务
                    var _tk = $('input[name="NoticeKey"]').val();
                    if (_tk != null && _tk != "" && $('input[name="IsSend"]').val() == "1")
                    {
                        infoCombinSend( _tk, function()
                        {
                            setTimeout( function(){
                                location.href = $('body').attr('code') + '.aspx';
                            }, 300 );
                        } );
                    }
                    else
                    {
                        setTimeout( function(){
                            alert('成功！');
                            location.href = $('body').attr('code') + '.aspx';
                        }, 300 );
                    }
                }
                else{
                    alert('成功！');
                    setTimeout(function() {
                        if ($('body').attr('code') == 'UpdatePwd') {
                            Exit();
                        } else if (location.href.split('.aspx')[0].split('/')[3] == 'splitSingle') {
                            location.href = '/OrderSend.aspx';
                        }else if ( JsonToStr(_ret.rs[0].rows[0]).indexOf("Combine_Result") != -1) {
                            location.reload();
                        }
                        else {
                            location.href = $('body').attr('code') + '.aspx';
                        }
                    }, 2000);
                }
            } else {
                if (typeof _msg[_ret.rs[0].rows[0][key]] == 'undefined') {
                    alert('错误信息：异常错误');
                } else if( location.href.split('.aspx')[0].split('/')[4] == 'OrderSend_edit' && key == "Schedule_Result"){
                    alert('错误信息：' + _msg[_ret.rs[0].rows[0][key]]);
                    $('div#myModal').modal( "hide" );
                }else if( location.href.split('.aspx')[0].split('/')[4] == 'OrderSend_edit' && key == "Order_Result"){
                    alert('错误信息：' + _msg[_ret.rs[0].rows[0][key]]);
                    $('div#splitModal').modal( "hide" );
                }else {
                    if( typeof msg != "undefined" ){
                        msg = _msg[_ret.rs[0].rows[0][key]];
                    }else{
                        alert('错误信息：' + _msg[_ret.rs[0].rows[0][key]]);
                    }
                }
            }
        }/*else{
            alert( "保存成功！");
            location.href = $('body').attr('code') + '.aspx';
        }*/
    }
    //标记管理页面保存跳转
    if ( $( 'body' ).attr( 'code' ) == 'MSymbol' || $( 'body' ).attr( 'code' ) == 'OrderMSymbol')
    {
        if ( _ret.rs[0].rows[0].ID != undefined && _ret.rs[0].rows[0].ID != '' )
        {
            alert( '保存成功' );
            location.href = document.referrer;
        }
    }

    return msg;
}

//拆单
$('.add_place').click(function() {
    var startTime = $('input[name="FromTime"]').val();

    if ($('tr[nrowid="split"]').length == 0) {} else {
        $('tr[nrowid="split"]').each(function() {
            startTime = $(this).find('input[name="WayToTime"]').val();
        });
    }

    var addtr = "<tr nrowid='split'><td style='border-right:1px solid #e1e6eb;'><span style='float:left;color:#666;'>" +
        "<a href=\"javascript:void(0);\" onclick=\"showModalWindow(this,\'收货方\')\" class=\"edit shr\" f-options=\"{'code':'EndUserID','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'PlayEndUserSelector.aspx','vals':'EndUserName=EndUserName,WayTo=FromName,WayToPhone=Phone,InputDedail=Address,FromProvince=ProvinceID,FromCity=CityID,FromDistrict=DistrictID','modalWindow':'1'}\" verify=\"{}\"><input type=\"hidden\" name=\"EndUserID\">收货方：</a></span></td>" +
        "<td><input style='display:inline-block;width:80px !important;' name=\"EndUserName\" placeholder=\"点击“收货方”进行选择或手动书写\" title=\"点击“收货方”进行选择或手动书写\" class=\"edit form-control transparent writeInput\" f-options=\"{'code':'EndUserName','type':'text','etype':'editable','len':'50'}\" verify=\"{}\"></td>" +
        "<td colspan='1' style='border-left:1px solid #e1e6eb;'><span style='float:left;color:#666;'>" +
        "途经地：</span></td><td colspan='4'><input type='text' name='WayTo' placeholder='请输入省市区或点击“途经地”选择' readonly  class='city_input inputFocus proCitySelAll' style='border:0;width:180px;line-height:34px;'/>" +
        "<input name=\"FromProvince\" type=\"hidden\" class=\"edit form-control transparent\" f-options=\"{'code':'FromProvince','type':'text','etype':'','len':''}\" verify=\"\">" +
        "<input name=\"FromCity\" type=\"hidden\" class=\"edit form-control transparent\" f-options=\"{'code':'FromCity','type':'text','etype':'','len':''}\" verify=\"\">" +
        "<input name=\"FromDistrict\" type=\"hidden\" class=\"edit form-control transparent\" f-options=\"{'code':'FromDistrict','type':'text','etype':'','len':''}\" verify=\"\">" +
        "<div class='provinceCityAll'><div class='tabs clearfix'><ul class=''><li><a href='javascript:' class='current' tb='hotCityAll'>热门城市</a></li><li><a href='javascript:' tb='provinceAll'>省份</a></li><li><a href='javascript:' tb='cityAll' class='city'>城市</a></li><li><a href='javascript:' tb='countyAll' class='district'>区县</a></li></ul></div>" +
        "<div class='con'><div class='hotCityAll invis'><div class='pre'><a></a></div><div class='list'><ul></ul></div><div class='next'><a class='can'></a></div></div><div class='provinceAll invis'><div class='pre'><a onclick='provinceAllPre()'></a></div><div class='list'> <ul> </ul></div><div class='next'><a class='can' onclick='provinceAllNext()'></a></div> </div><div class='cityAll invis'><div class='pre'><a onclick='cityAllPre()'></a></div>" +
        "<div class='list'><ul></ul></div><div class='next'><a class='can' onclick='cityAllNext(this)'></a></div></div><div class='countyAll invis'><div class='pre'><a onclick='countyAllPre()'></a></div><div class='list'><ul></ul></div><div class='next'><a class='can' onclick='countyAllNext(this)'></a></div></div></div></div>" +
        "</td><td colspan='3' style='border: 1px solid #e1e6eb;'><input type='text' name='InputDedail' placeholder='请输入详细地址' class='city_input inputFocus' style='border:0;width:140px;line-height:34px;'/></td><td style=' padding-right:0;border-left: 1px solid #e1e6eb;'>联系电话</td><td><input type=\"text\"  name=\"WayToPhone\" placeholder=\"联系电话\" style=\"border: 0; width: 80px; line-height: 34px;\" /></td><td  style=\"border: 1px solid #e1e6eb;\"><span style=\"float: left; color: #666;\">";
    if (navigator.userAgent.indexOf('Firefox') >= 0)
        addtr += "时间：</span></td><td class=\"\" ><input name=\"WayToTime\" readonly oc=\"date\" class=\"laydate-icon edit\" onclick=\"laydate( { format: 'YYYY-MM-DD hh:mm', min: '" + startTime + "' } )\" f-options=\"{'code':'ToTime','type':'date','etype':'editable','len':'50'}\" verify=\"{}\"></td><td  style='border:1px solid #e1e6eb;'><a class='delete_tr pull-right' style=' margin-left:10px;'>删除</a></td></tr>";
    else
        addtr += "时间：</span></td><td class=\"\" ><input name=\"WayToTime\" readonly oc=\"date\" class=\"laydate-icon edit\" onclick=\"TrigerDateEvent( this, { format: 'YYYY-MM-DD hh:mm' ,min:'" + startTime + "'} )\" f-options=\"{'code':'ToTime','type':'date','etype':'editable','len':'50'}\" verify=\"{}\"></td><td  style='border:1px solid #e1e6eb;'><a class='delete_tr pull-right' style=' margin-left:10px;'>删除</a></td></tr>";
    if (startTime == "") {
        alert('请输入时间！');
    } else {
        if( $('tr[nrowid="split"]').length > 3 ){
            alert( "最多只能拆分5条订单！")
        }else{
            $('.last_place').before(addtr);
        }
    }
    $('.delete_tr').click(function() {
        $(this).parent().parent().remove();
    });
});

function AddGoodsbar(obj) {
    $('.delete_goodsbar').click(function() {
        $(this).parent().parent().remove();
    })

    var _trObj = $(obj).closest('tr');
    $('a').attr('onclick', 'DelGoodsbar(this)');
    $('a').text('删除');

    $(obj).closest('tbody').append(_trObj.outerHTML());

    $('a').attr('onclick', 'AddGoodsbar(this)');
    $('a').text('添加');
}

function DelGoodsbar(obj) {
    $(obj).closest('tr').remove();
}

//运输计划拆单
function SplitSingle() {
    var _fp = $('input[name="FromProvince"]').val();
    var _fc = $('input[name="FromCity"]').val();
    var _fd = $('input[name="FromDistrict"]').val();
    var _from = $('input[name="From"]').val();
    var _fcnt = $('input[name="FromContact"]').val();

    var _tp = $('input[name="ToProvince"]').val();
    var _tc = $('input[name="ToCity"]').val();
    var _td = $('input[name="ToDistrict"]').val();
    var _to = $('input[name="To"]').val();
    var _tcnt = $('input[name="ToContact"]').val();

    var _time = '';
    var _eu = '';
    var _euname = '';

    var AddrLst = '';
    var GoodsLst = '';

    if (typeof($('input[name="WayTo"]').val()) != 'undefined') {        //线路拆单
        //fp1,fc1,fd1,from1,tp1,tc1,td1,to1,time1,eu1,fcnt1,tcnt1,euname1|
        $('input[name="WayTo"]').each(function(index) {
            if (index > 0) {
                _from = _to;
                _fp = _tp;
                _fc = _tc;
                _fd = _td;
                _fcnt = _tcnt;
                _to = $(this).closest('tr').find('input[name="InputDedail"]').val();
                _tp = $(this).closest('tr').find('input[name="FromProvince"]').val();
                _tc = $(this).closest('tr').find('input[name="FromCity"]').val();
                _td = $(this).closest('tr').find('input[name="FromDistrict"]').val();
                _tcnt = $(this).closest('tr').find('input[name="WayToPhone"]').val();
            } else{
                _to = $(this).closest('tr').find('input[name="InputDedail"]').val();
                _tp = $(this).closest('tr').find('input[name="FromProvince"]').val();
                _tc = $(this).closest('tr').find('input[name="FromCity"]').val();
                _td = $(this).closest('tr').find('input[name="FromDistrict"]').val();
                _tcnt = $(this).closest('tr').find('input[name="WayToPhone"]').val();
            }

            _time = $(this).closest('tr').find('input[name="WayToTime"]').val();
            _tcnt = $(this).closest('tr').find('input[name="WayToPhone"]').val();

            //GetSplitEndUserID( $(this).closest('tr') );

            _eu = $(this).closest('tr').find('input[name="EndUserID"]').val();
            if (_eu == '') {
              _eu = -1;  
            }
            _euname = $(this).closest('tr').find('input[name="EndUserName"]').val();


            _from = _from.replaceAll( ",|，", "&#44;");
            _to = _to.replaceAll( ",|，", "&#44;");
            AddrLst += '' + _fp + ',' + _fc + ',' + _fd + ',' + _from + ',' + _tp + ',' + _tc + ',' + _td + ',' + _to + ',' + _time + ',' + _eu + ',' + _fcnt + ',' + _tcnt + ',' + _euname;

            if ($('input[name="WayTo"]').length > index) {
                AddrLst += '|';
            }
        });
        _fp = _tp;
        _fc = _tc;
        _fd = _td;
        _from = _to;
        _fcnt = _tcnt;
        _tp = $('input[name="ToProvince"]').val();
        _tc = $('input[name="ToCity"]').val();
        _td = $('input[name="ToDistrict"]').val();
        _to = $('input[name="To"]').val();
        _tcnt = $('input[name="ToContact"]').val();
        _time = '';
        _eu = '';
    }
    _from = _from.replaceAll( ",|，", "&#44;");
    _to = _to.replaceAll( ",|，", "&#44;");
    AddrLst += '' + _fp + ',' + _fc + ',' + _fd + ',' + _from + ',' + _tp + ',' + _tc + ',' + _td + ',' + _to + ',' + _time + ',' + _eu + ',' + _fcnt + ',' + _tcnt + ',' + _euname;
    var _goodsid = '';
    var _goodsqty = '';
    var _goodsarr = [];
    $('.Goods').each(function(index) {      //数量拆单
        var _atrarr = [];
        var _array = [];
        _goodsid = $(this).find($('input[name="ListID"]')).val();
        _atrarr = $(this).find($('input[name="splitQty"]')).val().split("|");    //拆分数量

        for( var i = 0; i < _atrarr.length ; i++ ){
            _array.push(_goodsid + "=" + _atrarr[i]);
        }
        _goodsarr.push( _array);
    });
    

    var iLen = 0;           //数量
    var jLen = _goodsarr.length;        //物品种类
    for (var i = 0; i < _goodsarr.length; i++) {
        if (_goodsarr[i].length > iLen) iLen = _goodsarr[i].length;
    }
        
    for (var i = 0; i < iLen; i++) {
        var lst = "";
        for (var j = 0; j < jLen; j++) {
            lst += _goodsarr[j][i] ;
            if (j < jLen - 1) {
                lst += ',';
            } else {
                lst += ';'
            }
        }
        GoodsLst += lst.replace(/undefined,/g, '').replace(/,undefined/g,'');
    }

    GoodsLst = GoodsLst.replace(/\d+=0,/g, '').replace(/,\d+=0/g, '').replace(/\d+=0;/g, '');
    GoodsLst = GoodsLst.substring( 0, GoodsLst.length - 1 );

    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0227';

    var _paras = [{}, {}, {}, {}];
    _paras[0].name = 'SrcOrderID';
    _paras[0].value = NSF.UrlVars.Get('id', location.href);
    _paras[1].name = 'AddrLst';
    _paras[1].value = AddrLst;
    _paras[2].name = 'GoodsLst';
    _paras[2].value = GoodsLst;
    _paras[3].name = 'TransType';

    var _data;
    $('.data').each(function() {
        _data = {};
        _data.name = $(this).attr('name');
        _data.value = $(this).val();

        _paras.push(_data);
    });

    $('ul.radiodata').each(function() {
        _data = {};
        _data.name = $(this).find('input:checked').attr('name');
        _data.value = $(this).find('input:checked').val();

        _paras.push(_data);
    });
    

    

     
    if (typeof $('input[name="WayToTime"]').val() != 'undefined' ) {

    	//判断电话号码的格式         2016-06-28  huzy 修改了判断
    	var _reg = /^((([0\+][0-9]{2,3}-)?(0[0-9]{2,3})-)?([0-9]{7,8})?(([0-9]{7,8})(-([0-9]{3,}))?))?(([1][3|4|5|7|8][0-9])[0-9]{8})?$/;
    	for(var i=0;i<$('.line_chaidan_2 tr').length-3;i++){
	    	if ($('.line_chaidan_2 input[name="EndUserName"]').eq(i).val() == "") {
	    		 
	    		alert('收货方不能为空！');
	    		return false;
	    	}
	    	if ($('.line_chaidan_2 input[name="EndUserName"]').eq(i).val() == "") {
	    		alert('收货方不能为空！');
	    		return false;
	    	}
	    	if ($('.line_chaidan_2 input[name="WayToPhone"]').eq(i).val() == "") {
	    		alert('联系人电话不能为空！');
	    		return false;
	    	}
	    	if ($('.line_chaidan_2 input[name="WayTo"]').eq(i).val() == "") {
	    		alert('途经地不能为空！');
	    		return false;
	    	}
	    	if ($('.line_chaidan_2 input[name="InputDedail"]').eq(i).val() == "") {
	    		alert('详细地址不能为空！');
	    		return false;
	    	}
	    	if ($('.line_chaidan_2 input[name="WayToTime"]').eq(i).val() == '') {
	    		alert('时间不能为空！');
	    		return false;
	    	}
	    	var _wayphone = $('.line_chaidan_2 input[name="WayToPhone"]').eq(i).val();
	    	if (!_reg.test(_wayphone)) {
	    		alert("联系人电话格式不正确，请重新输入！");
	    		return false;
	    	} 	    	
    	}

        _paras[3].value = 1;    //线路拆单
        pmls[0].paras = _paras;
 
	    NSF.System.Network.Ajax('/Portal.aspx',
    		JsonToStr(pmls),
    		'POST',
    		false,
   			function(result, data) {
    			if (data[0].result) {
    				var _data = data[0].rs;
                    if( _data[0].rows[0]["Order_Result"] == "0" ){
                        var _rows = _data[1].rows;
                        var _p = "<p>原始单据："+ $('table input[name="Code"]').val() +"</p>"
                        for( var i = 0; i < _rows.length; i++ ){
                            if( _rows[i].Order_ShipMode == "1" ){
                                _p += "<p>新单据：<a href='OrderSend_edit.aspx?id="+ _rows[i].Order_ID +"&did=1'>"+ _rows[i].Order_Code +"</a></p>";
                            }else if( _rows[i].Order_ShipMode == "2" ){
                                _p += "<p>新单据：<a href='OrderSend_edit.aspx?id="+ _rows[i].Order_ID +"&did=2'>"+ _rows[i].Order_Code +"</a></p>";
                            }
                        }
                        $('div#splitModal .modal-body').html( _p );
                        $('div#splitModal button:eq(0)').hide();
                        $('div#splitModal button:eq(1)').attr("onclick", "toSendList()");
                        
                    }else{
                        Result( data[0] );
                    }

   				}
   			});
    }else {
        _paras[3].value = 2;    //数量拆单
        pmls[0].paras = _paras;

        NSF.System.Network.Ajax('/Portal.aspx',
                JsonToStr(pmls),
                'POST',
                false,
                function(result, data) {
                   if (data[0].result) {
                    var _data = data[0].rs;
                    if( _data[0].rows[0]["Order_Result"] == "0" ){
                        var _rows = _data[1].rows;
                        var _p = "<p>原始单据："+ $('table input[name="Code"]').val() +"</p>"
                        for( var i = 0; i < _rows.length; i++ ){
                            if( _rows[i].Order_ShipMode == "1" ){
                                _p += "<p>新单据：<a href='OrderSend_edit.aspx?id="+ _rows[i].Order_ID +"&did=1'>"+ _rows[i].Order_Code +"</a></p>";
                            }else if( _rows[i].Order_ShipMode == "2" ){
                                _p += "<p>新单据：<a href='OrderSend_edit.aspx?id="+ _rows[i].Order_ID +"&did=2'>"+ _rows[i].Order_Code +"</a></p>";
                            }
                        }
                        $('div#splitModal .modal-body').html( _p );
                        $('div#splitModal button:eq(0)').hide();
                        $('div#splitModal button:eq(1)').attr("onclick", "toSendList()");
                        
                    }else{
                        Result( data[0] );
                    }

                    }
                });
    }
}
function toSendList(){

    if( getUrlParam("did") == "2" ){
        location.href = "OrderLongSend.aspx" ;
    }else if( getUrlParam("did") == "1" ){
        location.href = "OrderSend.aspx" ;
    }
}
function checkForm() { 
    pass = true; 
    $("td:contains('*')").next().find("input").each(function(){ 
        if(this.value == '') { 
            text = $(this).parent().prev().text(); 
            alert(text+"是必填项"); 
            this.focus(); 
            pass = false; 
            return false;//跳出each 
        } 
    }); 
    return pass; 
}

//运输计划列表提交
function SplitSingleList(id) {
	var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0073';

    var _paras = [{}, {}, {}, {}];
    _paras[0].name = 'SrcOrderID';
    _paras[0].value = id;
    _paras[1].name = 'AddrLst';
    _paras[1].value = '';
    _paras[2].name = 'GoodsLst';
    _paras[2].value = '';
    _paras[3].name = '_Version';
    _paras[3].value = 1;
    pmls[0].paras = _paras;
     NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) 
        {
            if (data[0].result) 
            {
                Result(data[0]);
       		}
    	});
}
//拆单，获取收货方ID
function GetSplitEndUserID( trObj ){

    var _endUserName = trObj.find('input[name="EndUserName"]').val();

    var _flag;

    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0052';
//1980 拆单时，已有收货方信息，填写途径地、电话未保存
    var _paras = [{}, {}, {}, {}];
    _paras[0].name = 'CustomerID';
    _paras[0].value = $('input[name="CustomerID"]').val();
    _paras[1].name = 'Name';
    _paras[1].value = _endUserName
    _paras[2].name = 'AutoAppend';
    _paras[2].value = 1;
    _paras[3].name = 'Phone';
    _paras[3].value = $('input[name="WayToPhone"]').val();     
    pmls[0].paras = _paras;

    if (_endUserName != '') {
        
    }

    if( !_endUserName.match( new RegExp(/^[a-zA-Z|\u4e00-\u9fa5|\-|\()|\（）| ]+$/)) ){
        _flag = false;
    }else{
        NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                trObj.find('input[name="EndUserID"]').val( data[0].rs[0].rows[0].EndUser_ID );
                _flag = true;
            } 
        });
    }

    return _flag;
    
}

$('input[name="split"]').on('click', function() {
    if ($(this).is(':checked') == true) {
        $('tr[name="splittr"]').show();
       
    } else {
        $('tr[name="splittr"]').hide();
        if (typeof $('input[name="WayToTime"]').val() != 'undefined') {
            $('input[name="WayToTime"]').each(function() {
                $(this).closest('tr').remove();
            });
        }
    }
});


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
function GetCheckboxVal( that )
{
    var _FromName = $('input[name="FromName"]').val();
    var _ToName = $('input[name="ToName"]').val();
    if (_FromName.RTrim().split(' ').length < 3) {
        alert('请将发货省市区填写完整！');
        return false;
    }
    if (_ToName.RTrim().split(' ').length < 3) {
        alert('请将收货省市区填写完整！');
        return false;
    }
    var _flag = GetSplitEndUserID( $(that).closest('table') );


    var _sum = 0;
	//判断运输方式
	var formPro = $('input[name="FromProvince"]').val();
	var formcity = $('input[name="FromCity"]').val();
	var toPro = $('input[name="ToProvince"]').val();
	var tocity = $('input[name="ToCity"]').val();
	var ToCity_id = $('input[name="ToCity_id"]').val();
	var FromCity_id = $('input[name="FromCity_id"]').val();
	
	if(formPro == toPro || formcity == tocity)
	{
		$('input[name="ShipMode"][value="1"]').attr('checked','checked');
	}
	else
	{
		$('input[name="ShipMode"][value="2"]').attr('checked','checked');
	}
    $( 'input[name="Goodscategory"]:checked' ).each( function ()
    {
        _sum |= $( this ).val();
    } );

    if (_sum == 0) {
        $('input[name="GoodsCategory"]').val('');
        alert('货物分类不能为空, 请重新选择!');
        return false;
    } else {
        $('input[name="GoodsCategory"]').val(_sum);
    }

	if( !_flag ){
         alert( "收货方名称输入格式不正确，请重新输入！");
    }else if((/[\&\?]/gi).test($('input[name="From"]').val())){
        alert("发货地址不可包含 & 符号");   
    }else if((/[\&\?]/gi).test($('input[name="To"]').val())){
        alert("收货地址不可包含 & 符号");           
    }
            //2016.10.27 2284 拆单，详细地址中有特殊符号，无法拆单（就是因为 & 的存在）
            //  从下单开始限制  &  的存在
	else{
        var fl = 0;
        if ($('tr[nrowid="TMS_OrderGoods"]').length != 0) {
            $('tr[nrowid="TMS_OrderGoods"]').each( function(index) {
                var _GoodsID = $(this).find( 'input[name="GoodsID"]' ).val();
                var _Qty = $(this).find( 'input[name="Qty"]' ).val();

                if( _GoodsID == '' )
                {
                    fl = 1;
                    return false;
                }
                if( _Qty == '' )
                {
                    fl = 2;
                    return false;
                }
            });
        } else {
            alert("请至少选择一件物品！")
            fl = 4;
            return;
        }
         

        var _goodsval = $('input[name="GoodsValue"]').val();
        if( $('input[name="IsInsurance"]:checked').val() == "1" &&  ( _goodsval == "0.00" || _goodsval == "0" || _goodsval == "" ) ){
            fl = 3;
         }



         if( fl == 1 ){
            alert('物品编号不能为空，请选择物品编号！');
         }else if( fl == 2 ){
            alert('物品数量不能为空，请输入物品数量！');
         }else if( fl == 3 ){
            alert('需要投保时货物总价值必须填写!');
         }

         if(ToCity_id == '')
            {
                alert('到货市不能为空！');
            }
            if(FromCity_id == '')
            {
                alert('发货市不能为空！');
            }       
            //2016.06.15  huzy    判断重量和体积 不能超过 车载量
            if($('input[name="TransportMode"]:checked').val()== 2){
                var Car_weight = $('input[name="CarWeight"]').val()*1;
                var Total_Weight = $('input[name="TotalWeight"]').val()/1000;
                var Car_Volume = $('input[name="CarVolume"]').val()*1;
                var Total_Volumn = $('input[name="TotalVolumn"]').val()*1;
                if(Car_weight < Total_Weight && Car_Volume < Total_Volumn){
                    alert("太重了,不能发车");  
                }
            }
 
            //2016.06.15  huzy  判断重量和体积
 
//          
            //&& _Qty != ''
            if( ( fl == 0 ) || ( ToCity_id != '' && ToCity_id != undefined && FromCity_id != '' && FromCity_id != undefined ) )
            {
                var table = $(that).closest('table');
                /*
                    <Lst>
                        <Goods>
                            <ID>88</ID>
                            <Code>2016042200226</Code>
                            <Name>钢筋</Name>
                            <Qty>1</Qty>
                            <Weight>1.2000</Weight>
                            <Volume>2.000000</Volume>
                            <Unit>2</Unit>
                            <BatchNo>w</BatchNo>
                            <Price>14</Price>
                        </Goods>
                    </Lst>
                */
                var _lst = '<Lst>';
                var _goods;
                $('tr[nrowid="TMS_OrderGoods"]').each( function(index) {
                    _goods = '<Goods><ID>'+ $(this).find('input[name="GoodsID"]').val() +'</ID>';
                    _goods += '<Code>'+ $(this).find('input[name="Code"]').val() +'</Code>';
                    _goods += '<Name>'+ $(this).find('input[name="Name"]').val() +'</Name>';
                    _goods += '<Qty>'+ $(this).find('input[name="Qty"]').val() +'</Qty>';
                    _goods += '<Weight>'+ $(this).find('input[name="Weight"]').val() +'</Weight>';
                    _goods += '<Volume>'+ $(this).find('input[name="Volume"]').val() +'</Volume>';
                    _goods += '<Unit>'+ $(this).find('input[name="Unit"]').val() +'</Unit>';
                    _goods += '<BatchNo>'+ $(this).find('input[name="BatchNo"]').val() +'</BatchNo>';
                    _goods += '<Price>'+ $(this).find('input[name="Price"]').val() +'</Price></Goods>';

                    _lst += _goods;
                });

                _lst += '</Lst>';

                $('input[name="GoodsLst"]').val(_lst);

                SaveFormDataNDT(table, $(that), __saveNdtCfg);  //创建订单
            }

    }
   
}


//创建订单，获取收货ID
function GetEndUserID ( that ){
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0052';
//   1001 收货方信息存储错误     Phone
    var _paras = [{}, {}, {}, {}];
    _paras[0].name = 'CustomerID';
    _paras[0].value = $('input[name="CustomerID"]').val();
    _paras[1].name = 'Name';
    _paras[1].value = $('input[name="EndUserName"]').val();
    _paras[2].name = 'AutoAppend';
    _paras[2].value = 1;
    _paras[3].name = 'Phone';
    _paras[3].value = $('input[name="ToContact"]').val(); 
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                $('input[name="EndUserID"]').val( data[0].rs[0].rows[0].EndUser_ID );

                var table = $(that).closest('table');
                SaveFormDataNDT(table, $(that), __saveNdtCfg);
            } 
        });
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

//2764 客户资源管理-收货方管理-收货方常用地址：新增启用禁用功能
function EODCustomerAddr(EOD, AddrID) {
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0232';

    var _paras = [{}, {}];
    _paras[0].name = 'EOD';
    _paras[0].value = EOD;
    _paras[1].name = 'AddrID';
    _paras[1].value = AddrID;
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
    if ((parseFloat(_weight) != 0 && _weight != '') || (parseFloat(_volume) != 0 && _volume != '')) {
        $('.addition').show();
    }
    //显示承运方名称
    var _sname = $('input[name="SupplierName"]');
    if( _sname.length > 0 ){
        _sname.val( _sname.val().split('[')[0] );
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

//是否确认   2284 拆单，详细地址中有特殊符号，无法拆单
function IsSend_p( OrderID ) {
    if((/[\&\?]/gi).test($('input[name="From"]').val())){
        alert("发货地址不可包含 & 符号");   
    }else if((/[\&\?]/gi).test($('input[name="To"]').val())){
        alert("收货地址不可包含 & 符号");           
    }else{
	    $('#myModal').modal('show');
	
	    if( $('#myModal').find( 'input[name="OrderID"]' ) != undefined ){
	        $('#myModal').find( 'input[name="OrderID"]' ).val( OrderID );
	    }	
    }

}



//是否确认
function IsSend( OrderID ) {
    $('#myModal').modal('show');

    if( $('#myModal').find( 'input[name="OrderID"]' ) != undefined ){
        $('#myModal').find( 'input[name="OrderID"]' ).val( OrderID );
    }
}

//列表是否关闭
function IsClose(OrderID) {
    $('#myModal-close').modal('show');

    if ($('#myModal-close').find('input[name="OrderID"]') != undefined) {
        $('#myModal-close').find('input[name="OrderID"]').val(OrderID);
    }
}

//是否确认签收
function IsSign( OrderID ) {
    $('#signModal').modal('show');
    $('input[name="OrderID"]').val(OrderID);
}

//确认并保存
function SendOrder() {
    $('#myModal').modal('hide');
    SaveFormDataNDT($('#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860'), $('#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860').find('a:first'), __saveNdtCfg);
}

function IsBackOrder(OrderID) {
    $('#signModal').modal('show');
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
/*关闭订单*/
function Closed(OrderID)
{
	//$('#ClosedModal').modal('show');
    $('input[name="COrderID"]').val(OrderID);
 
    // 2016-10-17 胡zy  关闭订单 后台处理
    var _OrderID = $('input[name="COrderID"]').val();
    alert('请联系贵公司管理员完成关闭订单操作！\r\n订单号：' + _OrderID);    
}

function ClosedOrder()
{
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
              if ($('body').attr('code') == 'Index') {
                  alert('成功！');
                  window.location.reload();
              }
              else {
                  Result(data[0]);
              }
          } else {
              alert(data[0].msg);
          }
      });
  $('textarea[name="CDescription"]').val('');
}

function ShowCars(obj) {
    if ($(obj).val() == '1') {
        $('tr[name="CarInfo"]').hide();
        $('div[name="CarType"]').find('input[name="CarType"]:checked').attr('checked', false);
        $('input[name="CarLength"]').val(0);
    } else {
        $('tr[name="CarInfo"]').show();
    }
}

//待调度订单保存详情
function ScheduleOrderSave( that )
{
    var fl = 0;
    var _FromName = $('input[name="FromName"]').val();
    var _ToName = $('input[name="ToName"]').val();
    if (_FromName.split(' ').length < 2) {
        alert('请将发货省市区填写完整！');
        fl == 5;
        return false;
    }
    if (_ToName.split(' ').length < 2) {
        alert('请将收货省市区填写完整！');
        fl == 6;
        return false;
    }
    var _flag = GetSplitEndUserID( $(that).closest('table') );
    
    var _sum = 0;
    //判断运输方式
   /* var formPro = $('input[name="FromProvince"]').val();
    var formcity = $('input[name="FromCity"]').val();
    var toPro = $('input[name="ToProvince"]').val();
    var tocity = $('input[name="ToCity"]').val();
    var ToCity_id = $('input[name="ToCity_id"]').val();
    var FromCity_id = $('input[name="FromCity_id"]').val();
    
    if(formPro == toPro || formcity == tocity)
    {
        $('input[name="ShipMode"][value="1"]').attr('checked','checked');
    }
    else
    {
        $('input[name="ShipMode"][value="2"]').attr('checked','checked');
    }*/
    $( 'input[name="Goodscategory"]:checked' ).each( function ()
    {
        _sum |= $( this ).val();
    } );

    if (_sum == 0) {
        $('input[name="GoodsCategory"]').val('');
    } else {
        $('input[name="GoodsCategory"]').val(_sum);
    }
    if( !_flag ){
         alert( "收货方名称输入格式不正确，请重新输入！");
    }else{
        var _goodsval = $('input[name="GoodsValue"]').val();
        if( $('input[name="IsInsurance"]:checked').val() == "1" &&  ( _goodsval == "0.00" || _goodsval == "0" || _goodsval == "" ) ){
            fl = 3;
         }

        if (parseFloat($('#TotalWeight').val()) < 0 || parseFloat($('#TotalVolume').val()) < 0) {
            fl = 4;
        }

        if( fl == 3 ){
            alert('需要投保时货物总价值必须填写!');
         }else if( fl == 4 ){
            alert('补差值必须小于合计值！');
         }

         /*if(ToCity_id == '')
            {
                alert('到货市不能为空！');
            }
            if(FromCity_id == '')
            {
                alert('发货市不能为空！');
            }       
            
            //&& _Qty != ''
            if( ( fl == 0 )  )
            {
                var table = $(that).closest('table');

                //SaveFormDataNDT(table, $(that), __saveNdtCfg);  //创建订单
            }*/
    }

    return fl;
   
}

function ScheduleOrder(tip) {
    var queue = new Queue();
    queue.Interval = 100;
    queue.Exec();

    var _array = [];
    _array[0] = '_VerifyForm( $( \"#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860\" ) )';
    _array[1] = 'ScheduleOrderSave( $("a.save-transplan")[0] )';

    if (tip == '0') {       //调度
        _array[2] = 'Schedule()';
        $('input[name="IsSend"]').val(1);
    } else if (tip == '1') {    //拆单
        _array[2] = 'SplitSingle()';
    }
    
    for( var i = 0; i < _array.length; i++ ){
        queue.Push( function ( _context, request ) {
            var _chk = true;
            var _fl = 0;
            if( request == '_VerifyForm( $( \"#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860\" ) )' ){
                _chk = eval( request );
                if (!_chk)
                {
                    if (request == 'Schedule') {
                        $("div#myModal").modal( "hide" );
                    } else if (request == 'SplitSingle') {
                        $("div#splitModal").modal( "hide" );
                    }
                    
                    queue.Destroy();
                }
            }else if( request == 'ScheduleOrderSave( $("a.save-transplan")[0] )' ){
                _fl = eval( request );

                if (typeof _fl == 'boolean') {
                    queue.Destroy();
                    $("div#myModal").modal( "hide" );
                    $("div#splitModal").modal( "hide" );
                }

                if( _fl != "0" ){
                    if (request == 'Schedule') {
                        $("div#myModal").modal( "hide" );
                    } else if (request == 'SplitSingle') {
                        $("div#splitModal").modal( "hide" );
                    }
                    queue.Destroy();
                }
            }else{
                eval( request );
            }
            
           
        }, queue, _array[i] );
    }

    
}

function Schedule(){
     var statTF = false;

    var _readioval = $('input[name="radio"]:checked').val();

    var _SupplierID;
    var _SupplierSymbolID;

    if( _readioval != undefined )
    {
        if( _readioval == "3" )
        {
            if( $('input[name="SupplierSymbolName"]').val() == '' || $('input[name="SupplierSymbolName"]').val() == undefined)
            {
                alert('请选择承运方标记');
                $('div#myModal').modal( "hide" );            	
                
            }
            else if($('input[name="SN"]').val() == '' || $('input[name="SN"]').val() == undefined)
            {
                alert('请选择车辆');
                $('div#myModal').modal( "hide" );	
            }
            else if($('input[name="DriverName"]').val() == '' || $('input[name="DriverName"]').val() == undefined)
            {
                alert('请选择司机');
                $('div#myModal').modal( "hide" );	
            }
            else
            {
            	
				statTF = true;
				$('input[name="SupplierID"]').val(0);
				_SupplierSymbolID = $('input[name="SupplierSymbolID"]').val();
            }
        }
        else if( _readioval == "4")
        {
            if($('input[name="SupplierName"]').val() == '')
            {
                alert('请选择承运方');
                $('div#myModal').modal( "hide" );
            }
            else
            {
                statTF = true;
				_SupplierID =  $('input[name="SupplierID"]').val();
				$('input[name="SupplierSymbolID"]').val(0);                
            }
        }
        if(statTF)
        {
            var _DriverID = $('input[name="DriverID"]').val();
            var _CarID = $('input[name="CarID"]').val();
            var pmls = [{}];
            pmls[0].namespace = 'protocol';
            pmls[0].cmd = 'data';
            pmls[0].version = 1;
            pmls[0].id = 'tms_0093';

            var _paras = [{}, {}, {}, {}, {}];
            _paras[0].name = 'OrderID';
            _paras[0].value = NSF.UrlVars.Get('id', location.href);
            _paras[1].name = 'SupplierID';
            _paras[1].value = _SupplierID;
            _paras[2].name = 'DriverID';
            _paras[2].value = _DriverID
            _paras[3].name = 'CarID';
            _paras[3].value = _CarID;
            _paras[4].name = 'SupplierSymbolID';
            _paras[4].value = _SupplierSymbolID;

            var _data;
            $('.data').each(function() {
                _data = {};
                _data.name = $(this).attr('name');
                _data.value = $(this).val();

                _paras.push(_data);
            });

            $('ul.radiodata').each(function() {
                _data = {};
                _data.name = $(this).find('input:checked').attr('name');
                _data.value = $(this).find('input:checked').val();

                _paras.push(_data);
            });

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
    }
    else
    {
        alert('请选择自营或是承运方');
        $('div#myModal').modal( "hide" );
        /*setTimeout( function(){
            location.reload()
        }, 2000 );*/
    }
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

/*$('input[name="split"]').click(function() {     //我要拆单
    if ($(this).val() == '1') {
        $('tr.lineSplit').show();
        $('tr.qtySplit').hide();
    } else if ($(this).val() == '2') {
        $('tr.lineSplit').hide();
        $('tr.qtySplit').show();
    }

    $('input[name="DriverID"]').val('');
    $('input[name="CarID"]').val('');
    $('input[name="SN"]').val('');
    $('input[name="DriverName"]').val('');
    $('input[name="SupplierName"]').val('');
    $('input[name="SupplierID"]').val('');
});*/

//实时计算体积，重量
function Calculator(obj) {
    if( typeof obj != "undefined" ){
        $(obj).val( $(obj).val().replace( /[^\d]|[\d]{8,}/g,"") );
    }
    var _qty = $(obj).val();
    var _weight = $(obj).closest('tr').find('input[name="weight"]').val();
    var _volume = $(obj).closest('tr').find('input[name="volume"]').val();
     var _price = $(obj).closest('tr').find('input[name="price"]').val();
	if($(obj).attr('name') == 'Qty')
	{
		if(_qty > 0){
			//转换为浮点型
			$(obj).closest('tr').find('input[name="Weight"]').val((parseInt(_qty) * parseFloat(_weight)).toFixed(4));
			$(obj).closest('tr').find('input[name="Volume"]').val((parseInt(_qty) * parseFloat(_volume)).toFixed(6));
	        $(obj).closest('tr').find('input[name="Price"]').val((parseInt(_qty) * parseFloat(_price)).toFixed(2));	
		}else if(_qty == 0){
			//转换为浮点型
			$(obj).closest('tr').find('input[name="Weight"]').val((parseInt(1) * parseFloat(_weight)).toFixed(4));
			$(obj).closest('tr').find('input[name="Volume"]').val((parseInt(1) * parseFloat(_volume)).toFixed(6));
	        $(obj).closest('tr').find('input[name="Price"]').val((parseInt(1) * parseFloat(_price)).toFixed(2));		
		}

	}
	// huzy  2016-06-22 添加不能 有 - 号   和修改了  显示效果
	/*if( ( isNaN(_qty) || _qty.length > 7 || _qty =='-' || _qty =='.' ) && typeof _qty != 'undefined' )
	{ 
		$(obj).val( _qty.substring(0,0));
		$('input[name="TotalQty"]').val("");
		$('input[name="TotalWeight"]').val("");
		$('input[name="TotalVolumn"]').val("");
        $('input[name="TotalPrice"]').val("");
		alert("请输入不多于七位数的正整数！");
	}*/
	Sum( obj );
	
}
function quickQueryCust(evt,obj)
{
    if ($(obj).closest('tr').find('input:first').val() == '') {
        alert('请先点击物品编号选择物品！');
        return;
    }
    $(obj).attr('onkeyup', 'Calculator(this)');
    evt = (evt) ? evt : ((window.event) ? window.event : "") //兼容IE和Firefox获得keyBoardEvent对象  
	var key = evt.keyCode?evt.keyCode:evt.which; //兼容IE和Firefox获得keyBoardEvent对象的键值  
	if(key == 13)
	{ 
		$(obj).closest('tr').next().find('input[name="'+ $(obj).attr('name') +'"]').focus();
    }  
}  
//订单状态列表
function status_list() {

    var _OrderID = getUrlParam('id');

    if( !isNaN( _OrderID ) ){
        $('tr[name="TrackDetail"]').attr('view-id', '{ id:"tms_0092",cross:"false", rowIdentClass:"TrackDetail", paras:[{"name":"orderid","value":"' + _OrderID + '"}]}');
    }else{
        $('tr[name="TrackDetail"]').attr('view-id', '{ id:"tms_0213",cross:"false", rowIdentClass:"TrackDetail", paras:[{"name":"orderid","value":"' + _OrderID + '"}]}');

    }


    var _myEvents = new NSF.System.Data.Grid();
    _myEvents.Pagination("first-ds-pag", $("div[name='first-ds-pag']"));
    _myEvents.Initialize("/", "TrackDetail", $("tr[name='TrackDetail']").attr("view-id"), $("tr[name='TrackDetail']"));
    $('.TrackDetail').each(function(index) {
        var _History;
        var _InsertTime = $(this).find('span[name="InsertTime"]').text();
        var _CreatorName = $(this).find('span[name="CreatorName"]').text();
        var _SrcStatusName = $(this).find('span[name="SrcStatusName"]').text();
        var _DstStatusName = $(this).find('span[name="DstStatusName"]').text();
        var _Operation = $(this).find('span[name="Operation"]').text();
        var _Description = $(this).find('span[name="Description"]').text();

        if (_Operation == '0') {
            if (_DstStatusName == '已关闭') {
                _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CreatorName + '接收了订单，并将订单状态从' + _SrcStatusName + '变成' + _DstStatusName + ',关闭原因是："' + _Description + '"';
            } else {
                _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CreatorName + '接收了订单，并将订单状态从' + _SrcStatusName + '变成' + _DstStatusName;
            }
        } else if (_Operation == '1') {
            _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CreatorName + '拒绝接收订单，将订单打回到待发送列表，拒收原因为: "' + _Description + '",订单状态变成' + _DstStatusName;
        } else if (_Operation == '2') {
            _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CreatorName + '打回订单，订单状态由' + _SrcStatusName + '变成' + _DstStatusName;;
        } else if (_Operation == '3') {
            _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CreatorName + '追加备注，备注为' + _Description;
        }
        $(this).find('span[name="History"]').text(_History);

    });
}



/*function GetUnitData( rows )
{
    var _option = '';
    for( var i = 0; i< rows.length; i++ )
    {
        _option += '<option  value="'+ rows[i].id +'">'+ rows[i].name +'</option>';
    }
    $('select[name="PriceUnit_id"]').append( _option );
}
*/

//根据单位类型筛选单位
function Unit(obj) {
    $(obj).parent().next().next().find('input[name="PriceUnit"]').val(0);
    $(obj).parent().next().next().find('span[class="filter-option pull-left"]').text('-----------------------------');
    $(obj).closest('tr').find('select:eq(1)').find('option:selected').removeAttr('selected');
    var _type = $(obj).val();
    if( _type != "" ){
         if (_type == 1) {
            $(obj).parent().next().next().find('li').hide();
            $(obj).parent().next().next().find('li:eq(1)').show();
            $(obj).parent().next().next().find('li:eq(2)').show();

        } else if (_type == 2) {
            $(obj).parent().next().next().find('li').hide();
            $(obj).parent().next().next().find('li:eq(3)').show();
            $(obj).parent().next().next().find('li:eq(4)').show();
        } else if (_type == 3) {
            $(obj).parent().next().next().find('li').hide();
            $(obj).parent().next().next().find('li:gt(4)').show();
        }
    }

    $(obj).parent().next().find('option:selected').removeAttr('selected');
   
}
//根据单位筛选单位类型
function UnitType(obj) {
    var _unit = $(obj).val();

    if (_unit != '') {
        if (_unit == 1 || _unit == 2) {
            $(obj).parent().prev().prev().find('input[name="ChargeMode"]').val(1);
            $(obj).parent().prev().prev().find('span[class="filter-option pull-left"]').text('重量');
            $(obj).parent().prev().find("option[value='1']").attr("selected", "selected");
        } else if (_unit == 3 || _unit == 4) {
            $(obj).parent().prev().prev().find('input[name="ChargeMode"]').val(2);
            $(obj).parent().prev().prev().find('span[class="filter-option pull-left"]').text('体积');
            $(obj).parent().prev().find("option[value='2']").attr("selected", "selected")
        } else {
            $(obj).parent().prev().prev().find('input[name="ChargeMode"]').val(3);
            $(obj).parent().prev().prev().find('span[class="filter-option pull-left"]').text('数量');
            $(obj).parent().prev().find("option[value='3']").attr("selected", "selected");
        }
    }

}

function skiptoprint(divObj, number){   
    var _date = divObj.find('input.report-date').val();
    var _min = divObj.find('input.min').val();
    var _max = divObj.find('input.max').val();

    if (_date == '' || _min == '' || _max == '') {
        alert('请选择日期!');
    } else {
        if(number==1){      //客户订单 打印
            var vml ='[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0222","paras":[{"name":"createtime","value":"'+ _date +'"}]}]';
                  NSF.System.Network.Ajax('/Portal.aspx',
                vml,
                'POST',
                false,
                function(result, data) {
                    if (data[0].rs.length == 0) {
                        alert('无数据打印！');
                    } else {
                        window.open("OrderTrackingPrint.aspx?date="+_date, '_blank');
                    }
                });
                

        }else if(number==3){    //客户订单 导出
            var vml ='[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0224","paras":[{"name":"min","value":"'+ _min+'"}, {"name":"max", "value":"'+ _max +'"}]}]';
                  NSF.System.Network.Ajax('/Portal.aspx',
                vml,
                'POST',
                false,
                function(result, data) {
                    if (data[0].rs.length == 0) {
                        alert('无数据导出！');
                    } else {
                        window.open("OrderTrackingOutput.aspx?min="+ _min + "&max=" + _max, '_blank');
                    }
                });
        }else if(number==2){    //运输订单 打印
            var vml ='[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0221","paras":[{"name":"createtime","value":"'+ _date +'"}]}]';
                  NSF.System.Network.Ajax('/Portal.aspx',
                vml,
                'POST',
                false,
                function(result, data) {
                    if (data[0].rs.length == 0) {
                        alert('无数据打印！');
                    } else {
                        window.open("TrackingManagePrint.aspx?date="+_date, '_blank');
                    }
                });
        }else if(number==4){    //运输订单导出
            var vml ='[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0225","paras":[{"name":"min","value":"'+ _min+'"}, {"name":"max", "value":"'+ _max +'"}]}]';
                  NSF.System.Network.Ajax('/Portal.aspx',
                vml,
                'POST',
                false,
                function(result, data) {
                    if (data[0].rs.length == 0) {
                        alert('无数据显示导出！');
                    } else {
                        window.open("TrackingManageOutput.aspx?min="+_min + "&max=" + _max, '_blank');
                    }
                });
        }else if(number==5){
        	 var vml ='[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0222","paras":[{"name":"createtime","value":"'+ _date +'"}]}]';
                  NSF.System.Network.Ajax('/Portal.aspx',
                vml,
                'POST',
                false,
                function(result, data) {
                    if (data[0].rs.length == 0) {
                        alert('无数据打印！');
                    } else {
                        window.open("OrderTrackingPrint1.aspx?date="+_date, '_blank');
                    }
                });
        }else if(number==6){
        	var vml ='[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0221","paras":[{"name":"createtime","value":"'+ _date +'"}]}]';
                  NSF.System.Network.Ajax('/Portal.aspx',
                vml,
                'POST',
                false,
                function(result, data) {
                    if (data[0].rs.length == 0) {
                        alert('无数据打印！');
                    } else {
                        window.open("TrackingManagePrint1.aspx?date="+_date, '_blank');
                    }
                });
        }

        //divObj.modal('hide');
    }
    
}

/*
    订单导出
    num 1:客户订单查询
        2：客户订单费用
        3：运输订单查询
        4：运输订单费用
*/
function  OrderTrackingToXml(num) {
    var _paras = [];
    var _para;
    var _flag = false;
    $('input.data').each(function() {             //按输入值查询
        _para = {};
        _para.name = $(this).attr('name');
        _para.value = $(this).val();

        if (_para.value != '') {
            _flag = true;
        }

        _paras.push(_para);
    });

    $('ul.listsearch').each(function() {              //按下拉查询
        _para = {};
        _para.name = $(this).attr('name');
        _para.value = $(this).find('li.active span').attr('data-path');

        if (_para.value != '') {
            _flag = true;
        }

        _paras.push(_para);
    });

    $('input.time').each(function() {           //按时间段查询
        var _values = $(this).val().split('|');
        if (_values != '') {
            for (var i = 0; i < _values.length; i++) {
                if (i == 0) {
                    _para = {};
                    _para.name = 'min' + $(this).attr('name');
                    _para.value = _values[i];

                    _paras.push(_para);
                } else {
                    _para = {};
                    _para.name = 'max' + $(this).attr('name');
                    _para.value = _values[i];

                    _paras.push(_para);
                }
                
            }

             _flag = true;
        } 
        
    });

    var _id;
    if (num == '1') {     //客户订单查询
        _id = 'tms_0228';
    } else if (num == '2') {  //客户订单费用
        _id = 'tms_0230';
    } else if (num == '3') {  //运输订单查询
        _id = 'tms_0229';
    } else if (num == '4') {  //运输订单费用
        _id = 'tms_0231';
    }

    var vml ='[{"namespace":"protocol","cmd":"data","version":1,"id":"'+ _id +'","paras":'+ NSF.System.Json.ToString(_paras)  +'}]';

    if (!_flag) {
        alert('请输入查询项！');
    } else {
        NSF.System.Network.Ajax('/Portal.aspx',
                vml,
                'POST',
                false,
                function(result, data) {
                    if (data[0].rs.length == 0) {
                        alert('无数据导出！');
                    } else {
                        if (num == "1") {
                            window.open("OrderTrackingOutput.aspx?data="+ escape(NSF.System.Json.ToString(_paras)), '_blank');
                        } else if (num == "2") {
                            window.open("OrderPriceOutput.aspx?data="+ escape(NSF.System.Json.ToString(_paras)), '_blank');
                        } else if (num == "3") {
                            window.open("TrackingManageOutput.aspx?data="+ escape(NSF.System.Json.ToString(_paras)), '_blank');
                        } else if (num == "4") {
                            window.open("PriceManageOutput.aspx?data="+ escape(NSF.System.Json.ToString(_paras)), '_blank');
                        }
                    }
                });
    }
                  
}

//生成日期控件
function GetDateEvent(that, options) {
    options.choose = function(dates) {
        $(that).trigger('change');
    };
    laydate(options);
	$('#laydate_hms').show();	    
}

//物品选择
function GoodsSelect(value) {
    var flag = true;
    var sum = 0;
    $('tr[nrowid="TMS_OrderGoods"]').each(function() {
        if ($(this).find('input[name="GoodsID"]').val() != "") {
            sum++;
        }
    });

    if ( sum > 100 ) {
        flag = false;
    }
    return flag;
}
 


$('#myTab a').mouseover(function(e) {
    e.preventDefault();
    $(this).tab('show');
});

//选取车型车长
function showCarType_length(that) {
	$('#CarType_Length .modal-header').html('');
	$('#CarType_Length .content').html('');
    $('#CarType_Length').modal('show');
    $('tr[name="CarInfo"]').show();
    $('#CarType_Length .content').attr('style', 'width:820px;height:200px');
    if ($('#CarType_Length .content').find('div').hasClass('dialogue-header')) {} else {
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
                    _html += '<li><a href="javascript:" onclick="car_type(this)" rel=' + data[i].id + '><i></i>' + data[i].name + '</a></li>';
                    for (var j = 0; j < data[i].length.length; j++) {
                        _carLength += '<li row="' + data[i].id + '" class="hidden"><a href="javascript:" onclick="car_type(this)" rel=' + data[i].length[j].id + ' carVolume='+ data[i].length[j].carVolume +' carWeight='+ data[i].length[j].carWeight +'><i></i>' + data[i].length[j].name + '</a></li>'
                    }
                }
                _html += '</ul></div><div class="seach_list carLengths hidden"><ul class="list-inline text-left"><li class="td_name">规格/车长：</li>' + _carLength + '</ul></div>';
				_html += '<div class="seach_list carVolume hidden"><ul class="list-inline text-left"><li class="td_name">容积：</li><li style="height: 21px;width:80%;padding-left:0;"><input name="carVolume" disabled placeholder="容积" oc="text" style="width:90% !important;border:0px;background-color: transparent; box-shadow:none;" class="pull-left edit form-control transparent"/><sapn class="pull-right">立方米</span></li></ul></div>';
				_html += '<div class="seach_list carWeight hidden"><ul class="list-inline text-left"><li class="td_name">载重：</li><li style="height: 21px;width:80%;padding-left:0;"><input name="carWeight" disabled placeholder="载重" oc="text" style="width:90% !important;border:0px;background-color: transparent;box-shadow:none;" class="pull-left edit form-control transparent"/><sapn class="pull-right">吨</span></li></ul></div>';
				
                $('#CarType_Length .modal-header').append(_header);
                $('#CarType_Length .content').append(_html);
            }
        });
    }
    $('#CarType_Length .okButton').click(function() {
        var CarType = $('.carLengths .selected').attr('row');
        var CarLength = $('.carLengths .selected').find('a').attr('rel');
        var CarVolume = $('.carLengths .selected').find('a').attr('carVolume');
        var CarWeight = $('.carLengths .selected').find('a').attr('carWeight');		
        if (CarType != undefined && CarLength != undefined) {
            CarTypes(CarType);
			$('input[name="CarType"]').val(CarType);
			$('input[name="CarLength"]').val(CarLength);
			if(CarLength == 999.00)
			{
				if($('tbody').hasClass('Car'))
				{
					$('.Car input[name="Volume"]').val($('.carVolume input[name="carVolume"]').val());
					$('.Car input[name="Weight"]').val($('.carWeight input[name="carWeight"]').val());
				}
				if($('.carVolume input[name="carVolume"]').val() != '' && $('.carWeight input[name="carWeight"]').val() != '')
				{
					$( 'input[name="CarVolume"]' ).val( $( '.carVolume input[name="carVolume"]' ).val() );
					$( 'input[name="CarWeight"]' ).val( $( '.carWeight input[name="carWeight"]' ).val() );
					$( 'input[name="CarLengthName"]' ).val( '其他' );
					$('#CarType_Length').modal('hide');	
				}
				else
				{
					alert('容积/载重都不能为空！');
				}				
			}
			else
			{			
				if($('tbody').hasClass('Car'))
				{
					$('.Car input[name="Volume"]').val(CarVolume);
					$('.Car input[name="Weight"]').val(CarWeight);
				}				
				$('input[name="CarVolume"]').val(CarVolume);
				$( 'input[name="CarWeight"]' ).val( CarWeight );
				$( 'input[name="CarLengthName"]' ).val( CarLength );
				$('#CarType_Length').modal('hide');	
			}							
        } else {
            alert('请选择车型，规格/车长');
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
    if ($(obj).parent().hasClass('selected')) 
	{
        //$( obj ).parent().removeClass( 'selected' );
    } 
	else 
	{
        $(obj).parent().addClass('selected');
        if (name == '规格/车长：') 
		{
            //$('.carLengths li a[rel="0.00"]').next().remove();
			$('.carVolume,.carWeight').removeClass('hidden');
            if ($(obj).attr('rel') == 999.00) 
			{
				$('input[name="carVolume"],input[name="carWeight"]').val('');
				$('input[name="carVolume"],input[name="carWeight"]').attr('disabled',false);
				
                //$(obj).parent().append('<div class="length_input" style="width:110px;"><input name="Length" placeholder="规格" oc="text" style="width:85% !important;" class="pull-left edit form-control transparent"/><sapn class="pull-right">米</span></div>');
            }
			else
			{
				$('input[name="carVolume"],input[name="carWeight"]').attr('disabled',true);
				$('input[name="carVolume"]').val($(obj).attr('carVolume'));
				$('input[name="carWeight"]').val($(obj).attr('carWeight'));
			}
        }		
		else 
		{
            $('.carLengths li').addClass('hidden');
            $('.carLengths').removeClass('hidden');
            $('.carLengths li').eq(0).removeClass('hidden');
            $('.carLengths li[row=' + id + ']').removeClass('hidden');
			$('.length_input').remove();
        }
    }
}

function removeCarType() {
    $('tr[name="CarInfo"]').hide();
    $('.seach_list li').removeClass('selected');
    $('input[name="CarType"]').val('0');
    $('input[name="CarLength"]').val('');
}
//车型
function CarTypes(rel) {
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
    }else if (rel == 7) {
        TypeName = '面包车';
    }else if (rel == 8) {
        TypeName = '特种车辆';
    }else if (rel == 9) {
        TypeName = '集卡车';
    }else if (rel == 10) {
        TypeName = '其它车型';
    }
    $( 'input[name="CarTypeName"]' ).val( TypeName );
    if ( $( 'input[name="CarLength"]' ).val() == '999.00' )
    {
        $( 'input[name="CarLengthName"]' ).val( '其他' );
    }
    else
    {
        $( 'input[name="CarLengthName"]' ).val( $( 'input[name="CarLength"]' ).val() );
    }
}
//是否ID转文字
function YesORno() {
    $('.yesorno').each(function() {
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

//判断浏览器为火狐     更改日期控件
$(function() {
    if (navigator.userAgent.indexOf('Firefox') >= 0) {
        //更改日期控件onclick 调用函数，此方式日期限制无效
        $('input[name="PurchaseTime"], input.report-date, input[name="Insurance"],input[name="StartTime"],input[name="EndTime"],input[placeholder="制单时间"],input[placeholder="起始时间"],input[placeholder="发货时间"],input[placeholder="结束时间"],input[name="Birthday"],input[name="LicensedDate"]').attr('onclick', 'laydate({ format: "YYYY-MM-DD" })');
        $('#laydate_hms').show();	
        //$('input[name="ToTime"]').attr( 'onclick', "laydate( { format:'YYYY-MM-DD', min:'"+ $('input[name="FromTime"]').val()+"' } )");
        $('input[name="FromTime"]').on('click', function () {
            laydate({ format: 'YYYY-MM-DD hh:mm'});
        	$('#laydate_hms').show();		
        });
        $('input[name="ToTime"]').on('click', function () {
            laydate({ format: 'YYYY-MM-DD hh:mm', min: $('input[name="FromTime"]').val() });
        	$('#laydate_hms').show();		
        });
        //火狐底下textarea的高度固定
        var rowsPanH = $('textarea').parents('tr').height();
        $('textarea').css('height', rowsPanH + 'px');
    };
});

//物品删除后 合计值改变
function delect_zero(obj) {
    var that = $(obj).parent().parent();
    var _tms_ind = $(that).parent().find('tr').length;
    
   	if(_tms_ind == 29 ){ 
	    $('input[name="TotalWeight"]').val("0");
	    $('input[name="TotalVolume"]').val("0");
		$('input[name="TotalQty"]').val("0");
        $('input[name="GoodsValue"]').val('0');
   	}else{
	    //删完后合计值为空
	    if (that.next().attr('nrowid') == undefined && that.prev().attr('rowid') != undefined) {
	        $('input[name="TotalWeight"],input[name="TotalVolume"]').val('0');
	        $('input[name="TotalQty"]').val('0');
	        $('input[name="GoodsValue"]').val('0');
	    }
	    //删除单个项的合计值计算
	    else {
	    	//2287    物品总 量
	        var TotalWeight = $('input[name="TotalWeight"]').val();
	        var TotalVolumn = $('input[name="TotalVolume"]').val();
	        var GoodsValue = $('input[name="GoodsValue"]').val();
	       	var TotalQty = $('input[name="TotalQty"]').val();
	       	// 个数
			var _Qty = $(that).find('input[name="Qty"]').val();
			if(_Qty == "" || _Qty == 0 ){
		        $('input[name="TotalWeight"]').val(TotalWeight);
		        $('input[name="TotalVolume"]').val(TotalVolumn);
				$('input[name="TotalQty"]').val(TotalQty);
				$('input[name="GoodsValue"]').val(GoodsValue);				
			}else{

		        $('input[name="TotalWeight"]').val(style_sub(TotalWeight , $(that).find('input[name="Weight"]').val() ));
		        $('input[name="TotalVolume"]').val(style_sub(TotalVolumn , $(that).find('input[name="Volume"]').val()));
				$('input[name="TotalQty"]').val(style_sub(TotalQty ,  _Qty));
				$('input[name="GoodsValue"]').val(style_sub(GoodsValue , $(that).find('input[name="Price"]').val()));
	    	}	
	    }
 	}

}

//合计
function Sum( obj ) {
    var _weight = parseFloat($('input[name="WeightAddition"]').val());
    var _volume = parseFloat($('input[name="VolumeAddition"]').val());
    var _qty = 0;
    var _price = 0;

    if ($('input[name="WeightAddition"]').val() == '') {
        _weight = 0;
    }

    if ($('input[name="VolumeAddition"]').val() == '') {
        _volume = 0;
    }

    $('tr[nrowid="TMS_OrderGoods"]').each(function( index ) 
	{
		//Three Knives 判断是否为空 为空则为0 避免出现NAN
		if( $(this).find('input[name="Weight"]').val() == '' )
			_weight += 0;
		else 
			_weight += parseFloat($(this).find('input[name="Weight"]').val());
		if( $(this).find('input[name="Volume"]').val() == '' )
			_volume += 0;
		else
			_volume += parseFloat($(this).find('input[name="Volume"]').val());
		if( $(this).find('input[name="Qty"]').val() == '' )
			_qty += 0;
		else
			_qty += parseInt($(this).find('input[name="Qty"]').val());
        if( $(this).find('input[name="Price"]').val() == '' )
            _price += 0;
        else
            _price += parseFloat($(this).find('input[name="Price"]').val());
    });

    $('input[name="TotalWeight"]').val(_weight.toFixed(4));
    $('input[name="TotalVolume"]').val(_volume.toFixed(6));
    $('input[name="TotalQty"]').val(_qty);

    if( typeof obj != "undefined" ){
        $('input[name="GoodsValue"]').val(_price.toFixed(2));
    }
}

//订单费用显示
function OrderPriceShow ( _id ){
    NSF.System.Data.RecordSet( "/", { id:"pml_0041",cross:"false", rowIdentClass:"OrderPrice", paras:[{"name":"OrderID","value": _id }] }, function ( result, config, data )
            {
                var _tdt = '<td class="td_name">类型</td>';
                var _td = '<td class="td_name">价格</td>';

                if( typeof data[1].rows[0] != 'undefined' ){

                    if( data[1].rows[0].LessLoad == '' || data[1].rows[0].LessLoad == '0.00' ) //零担
                    {}
                    else
                    {
                        _tdt += '<td >零担（RMB/元）</td>';
                        _td += '<td name="LessLoad" >'+ data[1].rows[0].LessLoad +'</td>';

                        $('tr[nrowid="PMS_LessLoad"] td:eq(0)').text(data[1].rows[0].LessLoadDocCode);
                        $('tr[nrowid="PMS_LessLoad"] td:eq(1)').text(data[1].rows[0].LessLoadDocIDName);
                        $('tr[nrowid="PMS_LessLoad"] td:eq(2)').text(data[1].rows[0].LessLoad);

                        $('tr.PMS_LessLoad').removeClass('hide');
                    }
                    if( data[1].rows[0].FullLoad == '' || data[1].rows[0].FullLoad == '0.00' ) //整车
                    {
                    }
                    else
                    {
                        _tdt += '<td >整车（RMB/元）</td>';
                        _td += '<td name="FullLoad" >'+ data[1].rows[0].FullLoad +'</td>';

                        $('tr[nrowid="PMS_FullLoad"] td:eq(0)').text(data[1].rows[0].FullLoadDocCode);
                        $('tr[nrowid="PMS_FullLoad"] td:eq(1)').text(data[1].rows[0].FullLoadDocIDName);
                        $('tr[nrowid="PMS_FullLoad"] td:eq(2)').text(data[1].rows[0].FullLoad);

                        $('tr.PMS_FullLoad').removeClass('hide');
                    }
                    if( data[1].rows[0].Pick == '' || data[1].rows[0].Pick == '0.00' )      //提货费
                    {
                    }
                    else
                    {
                        _tdt += '<td >提货费（RMB/元）</td>';
                        _td += '<td name="Pick" >'+ data[1].rows[0].Pick +'</td>';

                        $('tr[nrowid="CityPickPrice"] td:eq(0)').text(data[1].rows[0].PickDocCode);
                        $('tr[nrowid="CityPickPrice"] td:eq(1)').text(data[1].rows[0].PickDocIDName);
                        $('tr[nrowid="CityPickPrice"] td:eq(2)').text(data[1].rows[0].Pick);

                        $('tr.CityPickPrice').removeClass('hide');
                    }
                    if( data[1].rows[0].Delivery == '' || data[1].rows[0].Delivery == '0.00' )      //送货费
                    {
                    }
                    else
                    {
                        _tdt += '<td >送货费（RMB/元）</td>';
                        _td += '<td name="Delivery" >'+ data[1].rows[0].Delivery +'</td>';

                        $('tr[nrowid="CityDeliveryPrice"] td:eq(0)').text(data[1].rows[0].DeliveryDocCode);
                        $('tr[nrowid="CityDeliveryPrice"] td:eq(1)').text(data[1].rows[0].DeliveryDocIDName);
                        $('tr[nrowid="CityDeliveryPrice"] td:eq(2)').text(data[1].rows[0].Delivery);

                        $('tr.CityDeliveryPrice').removeClass('hide');
                    }
                    if( data[1].rows[0].OnLoad == '' || data[1].rows[0].OnLoad == '0.00' )         //装货费
                    {
                    }
                    else
                    {
                        _tdt += '<td >装货费（RMB/元）</td>';
                        _td += '<td name="OnLoad" >'+ data[1].rows[0].OnLoad +'</td>';

                        $('tr[nrowid="OnLoadPrice"] td:eq(0)').text(data[1].rows[0].OnLoadDocCode);
                        $('tr[nrowid="OnLoadPrice"] td:eq(1)').text(data[1].rows[0].OnLoadDocIDName);
                        $('tr[nrowid="OnLoadPrice"] td:eq(2)').text(data[1].rows[0].OnLoad);

                        $('tr.OnLoadPrice').removeClass('hide');
                    }
                    if( data[1].rows[0].OffLoad == '' || data[1].rows[0].OffLoad == '0.00' )      //卸货费
                    {
                    }
                    else
                    {
                        _tdt += '<td >卸货费（RMB/元）</td>';
                        _td += '<td name="OffLoad" >'+ data[1].rows[0].OffLoad +'</td>';

                        $('tr[nrowid="OffLoadPrice"] td:eq(0)').text(data[1].rows[0].OffLoadDocCode);
                        $('tr[nrowid="OffLoadPrice"] td:eq(1)').text(data[1].rows[0].OffLoadDocIDName);
                        $('tr[nrowid="OffLoadPrice"] td:eq(2)').text(data[1].rows[0].OffLoad);

                        $('tr.OffLoadPrice').removeClass('hide');
                    }
                    
                    if( data[1].rows[0].InsuranceCost == '' || data[1].rows[0].InsuranceCost == '0.00' )        //保险费
                    {
                    }
                    else
                    {
                        _tdt += '<td >保险费（RMB/元）</td>';
                        _td += '<td name="InsuranceCost" >'+ data[1].rows[0].InsuranceCost +'</td>';

                        $('tr[nrowid="InsurancePrice"] td:eq(0)').text(data[1].rows[0].InsuranceCostDocCode);
                        $('tr[nrowid="InsurancePrice"] td:eq(1)').text(data[1].rows[0].InsuranceCostDocIDName);
                        $('tr[nrowid="InsurancePrice"] td:eq(2)').text(data[1].rows[0].InsuranceCost);

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
                                if (i == 0) {
                                    $('tr[nrowid="AdditionPrice"] td:eq(0)').text(data[2].rows[0].AdditionDocCode);
                                    $('tr[nrowid="AdditionPrice"] td:eq(1)').text(data[2].rows[0].AdditionDocIDName);
                                    $('tr[nrowid="AdditionPrice"] td:eq(2)').text(data[2].rows[0].AdditionDetail);
                                } else {
                                    $('tr[nrowid="AdditionPrice"]:eq('+ (i-1) +')').after( $('tr[nrowid="AdditionPrice"]:eq(0)').clone());
                                    $('tr[nrowid="AdditionPrice"]:eq('+ i +') td:eq(0)').text(data[2].rows[i].AdditionDocCode);
                                    $('tr[nrowid="AdditionPrice"]:eq('+ i +') td:eq(1)').text(data[2].rows[i].AdditionDocIDName);
                                    $('tr[nrowid="AdditionPrice"]:eq('+ i +') td:eq(2)').text(data[2].rows[i].AdditionDetail);
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

                        $('tr[nrowid="TaxPrice"] td:eq(0)').text(data[1].rows[0].TaxDocCode);
                        $('tr[nrowid="TaxPrice"] td:eq(1)').text(data[1].rows[0].TaxDocIDName);
                        $('tr[nrowid="TaxPrice"] td:eq(2)').text(data[1].rows[0].Tax);

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


/*为table里面的input添加title*/
function hoverTips() {
    $(".FormTable td input").each(function () {
        var thisVal = $(this).val();
        $(this).attr("title", thisVal);
    });
}

/*运输订单，客户订单回单图片外链大图*/
function images()
{
    for (var i = 0; i < $('.instructions').length; i++) {
        if ($('.instructions').eq(i).next().next().next().attr('src') != '') {
            var src = $('.instructions').eq(i).next().next().next().attr('src');
            var style = $('.instructions').eq(i).next().next().next().attr('style');
            $('.instructions').eq(i).next().next().next().remove();
            $('.instructions').eq(i).next().hide();
            $('.instructions').eq(i).next().next().hide();
            $('.instructions').eq(i).parent().append('<a target="_blank" href="' + src + '"><img title="单击查看原图" src="' + src + '" style="' + style + '"/></a>');
             $('.instructions').eq(i).parent().parent().find("button").remove();
        } else {
            $('.instructions').eq(i).next().parent().append('<div style="width:100%;height:100%;position:absolute;left:0;top:0;background-color:white;"></div>');
        }
    }
}

//计费模式select下拉值为0时
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

/*拼单*/
function ToOrderCombbined ( ShipMode ){
    var _OrdersLst = '';
    var _check = $('input[name="CombineBox"]:checked');
    if( _check.length < 2 ){
        alert('请选择至少两笔需要合计的订单！');
    }else if( _check.length > 12 ){
        alert('最多选择12条订单！');
    }else{
        _check.each( function( index ){
            _OrdersLst += $(this).val();

            if( _check.length-1 != index ){
                _OrdersLst += ',';
            }
        });

       if( ShipMode == 1){
            location.href = "OrderCombined_edit.aspx?id=" + _OrdersLst;
        }else if( ShipMode == 2){
            location.href = "OrderLongCombined_edit.aspx?id=" + _OrdersLst;
        }
    }
    
}

/*接收或拒绝拼车单*/
function ReceiveCombineOrders () {
    var _y = 1;
    if ($('input[name="Accept"]').val() == 0) {
        if ($('textarea[name="Description"]').val() == '') {
            _y = 0;
            alert('拒绝原因不能为空！');
        } else {
            _y = 1;
        }
    }
    if (_y == 1) {
        $('#myModal').modal('hide');
        var pmls = [{}];
        pmls[0].namespace = 'protocol';
        pmls[0].cmd = 'data';
        pmls[0].version = 1;
        pmls[0].id = 'tms_0106';

        var _paras = [{}, {}, {}];
        _paras[0].name = 'OrderID';
        _paras[0].value = $('input[name="OrderID"]').val();
        _paras[1].name = 'Accept';
        _paras[1].value = $('input[name="Accept"]').val();
        _paras[2].name = 'Description';
        _paras[2].value = $('textarea[name="Description"]').val();
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
}

/*关闭拼车单*/
function CloseCombineOrder( divModal ) {
    divModal.modal('hide');
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0107';

    var _paras = [{}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = divModal.find('input[name="COrderID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = divModal.find('textarea[name="CDescription"]').val();
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
    divModal.find('textarea[name="CDescription"]').val('');
}

/*保存拼车单*/
function CombineOrders( SendDirectly, ShipMode ){
    var OrdersLst = "";
    var _trObj =  $('tr[nrowid="OrderContains"]');

    if (SendDirectly == "1") {
        $('input[name="IsSend"]').val(1);
    }

    _trObj.each(function( index ){
        OrdersLst += $(this).find('input[name="orderid"]').val();
        if( _trObj.length-1 > index ){
            OrdersLst += ",";
        }
    });

    if( typeof ShipMode == 'undefined' ){
        ShipMode = $('input[name="ShipMode"]').val();
    }
    var savaTF = true;
	if($('input[name="PactCode"]').val() == '')
    {
        alert('合同编号不能为空');
        savaTF = false;
    }

    var _radio = $('input[type="radio"]:checked');

    if( _radio.length != 0 ){
        if( _radio.val() == "4" &&  $('input[name="SupplierName"]').val() == "" ){
            alert("请选择承运方！");
            savaTF = false;
        }else if( _radio.val() == "3" && $('input[name="SupplierSymbolName"]').val() == "" ){
            alert("请选择承运方标记名称！");
            savaTF = false;
        }

    }else{
        alert("请选择自营或是承运方！");
        savaTF = false;
    }
	if(savaTF)
	{
	    var pmls = [{}];
	    pmls[0].namespace = 'protocol';
	    pmls[0].cmd = 'data';
	    pmls[0].version = 1;
	    pmls[0].id = 'tms_0103';
	
	    var _paras = [{}, {}, {}, {}, {}, {}, {}, {}];
	    _paras[0].name = 'OrderID';
	    _paras[0].value = $('input[name="OrderID"]').val();
	    _paras[1].name = 'PactCode';
	    _paras[1].value = $('input[name="PactCode"]').val();
	    _paras[2].name = 'SupplierID';
	    _paras[2].value = $('input[name="SupplierID"]').val();
	    _paras[3].name = 'OrdersLst';
	    _paras[3].value = OrdersLst;
	    _paras[4].name = 'Descriptions';
	    _paras[4].value = $('textarea[name="Descriptions"]').val();
	    _paras[5].name = 'SendDirectly';
	    _paras[5].value = SendDirectly;
	    _paras[6].name = 'ShipMode';
	    _paras[6].value = ShipMode;
        _paras[7].name = 'SupplierSymbolID';
        _paras[7].value = $('input[name="SupplierSymbolID"]').val();
	    pmls[0].paras = _paras;
	
	    if( _trObj.length < 2 ){
	        alert( "合单订单不能少于两条，请重新选择！" );
	    }else{
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
	}
    
}

/*追加被合并的订单*/
function AppendCombineItem( value ){
  var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0108';

    var _paras = [{}, {}, {}];
    _paras[0].name = 'CombineOrderID';
    _paras[0].value = location.href.GetValue( "id" );
    _paras[1].name = 'OrdersLst';
    _paras[1].value = value;
    _paras[2].name = 'Description';
    _paras[2].value = $('textarea[name="Descriptions"]').val();
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
function DeleteCombineItem( obj, vmlid , Dele_n )
{
	
	if( Dele_n == 2){//2016-10-20  只删除 
		$(obj).parent().parent().remove();
	}else{
	    var prow = $(obj).closest('tr');
	    var OrdersLst = prow.find('input[name="orderid"]').val();
	
	    var pmls = [{}];
	    pmls[0].namespace = 'protocol';
	    pmls[0].cmd = 'data';
	    pmls[0].version = 1;
	    pmls[0].id = 'tms_0109';
	
	    var _paras = [{}, {}, {}];
	    _paras[0].name = 'CombineOrderID';
	    _paras[0].value = location.href.GetValue( "id" );
	    _paras[1].name = 'OrdersLst';
	    _paras[1].value = OrdersLst;
	    _paras[2].name = 'Description';
	    _paras[2].value = $('textarea[name="Descriptions"]').val();
	    pmls[0].paras = _paras;
	
	    if( OrdersLst == "0" ){
	        prow.remove();
	    }else{
	        NSF.System.Network.Ajax( '/Portal.aspx',
	        JsonToStr( pmls ),
	        'POST',
	        false,
	        function ( result, data )
	        {
	            if ( data[0].result )
	            {
	                Result( data[0] );
	                
	                prow.remove();
	            }
	            else
	            {
	                alert( data[0].msg );
	            }
	        } );
	    }
			
	}

}

//是否确定接收拼车单
function IsReceiveCombineOrders(Accept, OrderID) {
    $('#myModal').modal('show');
    $('input[name="Accept"]').val(Accept);
    $('input[name="OrderID"]').val(OrderID);

    if (Accept == '0') {
        $('#myModal #myModalLabel p').text('拒收拼车单');
        $('.tab_jsjj').html('');
        var _html = '<div class="row"><label class="col-md-2 control-Label">拒收原因</label><div class="col-md-10">' +
            '<textarea name="Description" class="form-control" rows="3" cols="70"></textarea></div></div><input type="hidden" name="Accept" value="' + Accept + '"/><input type="hidden" name="OrderID" value="' + OrderID + '" />';
        $('.tab_jsjj').html(_html);
    } else if (Accept == '1') {
        $('#myModal #myModalLabel p').text('接收拼车单');
        $('.tab_jsjj').html('');
        var _html = '<span name="content">是否确定接收拼车单</span><input type="hidden" name="Accept" value="' + Accept + '"/><input type="hidden" name="OrderID" value="' + OrderID + '" />';
        $('.tab_jsjj').html(_html);
    }
}

/*列表中发送拼车单*/
function SendCombineOrder( divModal ) {
    divModal.modal('hide');
    $('input[name="IsSend"]').val(1);
    var SupplierID = divModal.find('input[name="SupplierName"]').val();
    if( SupplierID != '' )
    {
	    var pmls = [{}];
	    pmls[0].namespace = 'protocol';
	    pmls[0].cmd = 'data';
	    pmls[0].version = 1;
	    pmls[0].id = 'tms_0202';
	
	    var _paras = [{}, {}];
	    _paras[0].name = 'OrderID';
	    _paras[0].value = divModal.find('input[name="COrderID"]').val();
	    _paras[1].name = 'Description';
	    _paras[1].value = divModal.find('textarea[name="CDescription"]').val();
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
	    divModal.find('textarea[name="CDescription"]').val('');
    }
    else
    {
    	alert('此单据还未选择承运方，不能发送，请选择承运方');
    }
}

/*实签异常数字的输入*/
function realSign(tag) {
    var goodNum = parseInt($(tag).parents('tr').find("input[name='Qty']").val());
    var thisVal = parseInt($(tag).val());
    if (isNaN(thisVal)) {
        //if (thisVal > goodNum) {
            $(tag).val('');
			//$(tag).parent().next().find('input').val('');
        //}
		//else
		//{
			//$(tag).parent().next().find('input').val(thisVal - goodNum);
		//}
    } /* else {
        $(tag).val('');
		$(tag).parent().next().find('input').val('');
    } */
	
}

/*通过收货方ID筛选出收货方地址*/
function FilterAddress( aObj, name, inputObj ){
    GetSplitEndUserID( $(aObj).closest('table') );
    showModalWindow( aObj, name, inputObj );
}

/*标记信息启用、禁用*/
function EODMSymbol( invalid, id ) {
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0206';

    var _paras = [{}, {}];
    _paras[0].name = 'id';
    _paras[0].value = id;
    _paras[1].name = 'invalid';
    _paras[1].value = invalid;
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                alert( "成功！" );
            } else {
                alert( "失败！" );
            }
        });
    setTimeout(location.reload(),500);
}


/*2870 运输系统：资源管理菜单下的列表页需加启用、禁用操作，页面详情保存按钮去掉，信息不可修改*/
function DCMOSymbol( invalid, id ,Type) {
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0237';

    var _paras = [{}, {}, {}];
    _paras[0].name = 'InfoID';
    _paras[0].value = id;
    _paras[1].name = 'EOD';
    _paras[1].value = invalid;
    _paras[2].name = 'Type';
    _paras[2].value = Type;    
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                alert( "成功！" );
            } else {
                alert( "失败！" );
            }
        });
    setTimeout(location.reload(),500);
}
//列表页重置按钮 清空省市区
$('.box button[data-control-type="reset"]').click(function()
{
	$('.current2,input[name="ToProvince"],input[name="ToCity"],input[name="ToDistrict"],input.min,input.max').val('');
	$('#ToButton').click();
});

//签收页面 实签自动赋值
function SignVal()
{
	$( 'tr[nrowid="TMS_OrderGoods"]' ).each( function ( index )
	{
		var qty = $( 'tr[nrowid="TMS_OrderGoods"]' ).eq( index ).find( 'input[name="Qty"]' ).val();
		$( 'tr[nrowid="TMS_OrderGoods"]' ).eq( index ).find( 'input[name="ReceiptQty"]' ).val( qty );
		$( 'tr[nrowid="TMS_OrderGoods"]' ).eq( index ).find( 'input[name="ExceptionQty"]' ).val( 0 );
	} );
}

//订单列表签收
function SignOrderAuto( OrderID ){
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0209';

    var _paras = [{}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = OrderID;
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

//列表页省市迷糊查询
$( 'input[name="cityName"]' ).bind( 'input propertychange', function ()
{
	var val = $( this ).val();
	var top = $(this).position().top + 30;
	var left = $(this).position().left;
	var width = $(this).parent().width();      
	var timeID = setTimeout(function()
	{
		clearTimeout(timeID);
		if(val != undefined)
		{
			if ( /^[a-zA-Z]*$/.test( val ) )
			{
				//如果是字母
				var params = '[{"namespace":"protocol","cmd":"data","version":1,"id":"dml_otms_0002","paras":[{"name":"code","value":"'+ val +'"},{"name":"name","value":""}]}]';  
			}
			else if ( /^[\u4e00-\u9fa5]*$/.test( val ) )
			{
				//如果是汉字
				var params = '[{"namespace":"protocol","cmd":"data","version":1,"id":"dml_otms_0002","paras":[{"name":"code","value":""},{"name":"name","value":"'+ val +'"}]}]';
			}
			/*else
			{
				//非全部字母或汉字
				$('#citySeach').attr('style','top:'+top+'px;left:'+left+'px;width:'+width+'px;');
				$('#citySeach').addClass('show');
				$('#citySeach').html('<li>搜索的数据不存在</li>');
			}*/
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
					if(data[0].rs != '')
					{
						var dataes = data[0].rs[0].rows;
						$('#citySeach').attr('style','top:'+top+'px;left:'+left+'px;width:'+width+'px;');
						$('#citySeach').addClass('show');
						var _html = '';
						for(var i=0;i<dataes.length;i++)
						{
							_html += '<li onclick="citySeachLi(this)" NodeType="'+dataes[i].NodeType+'" ParentID="'+dataes[i].ParentID+'" id="'+dataes[i].ID+'">'+ dataes[i].Name +'</li>';
						}
						$('#citySeach').html(_html);
					}
				}
			} );
		}
	},1000);            
} );
$( '.viewFramework-product-body' ).bind( 'click', function ()
{
	$('#citySeach').removeClass('show');
});
//点击搜索列表赋值
function citySeachLi(that)
{
	$('input[name="ToProvince"],input[name="ToCity"],input[name="ToDistrict"]').val('');
	var nodetype = $(that).attr('nodetype');
	var ParentID = $(that).attr('ParentID');
	var id = $(that).attr('id');
	if(nodetype == 1)
	{
		//类型为1 代表是省级
		$('input[name="ToProvince"]').val(id);
	}
	else if(nodetype == 2)
	{
		//类型为2 代表是市级		
		$('input[name="ToProvince"]').val(ParentID);
		$('input[name="ToCity"]').val(id);		
	}
	else if(nodetype == 3)
	{
		//类型为3 代表是县级区
		$('input[name="ToCity"]').val(ParentID);
		$('input[name="ToDistrict"]').val(id);
	}
	$('input[name="cityName"]').val($(that).text());
	$('#citySeach').removeClass('show');
}

//单选按钮、多选按钮的初始化样式改变
function ifChecked() {
    $('input[type="radio"]:checked').each(function () {
        $(this).prev('span').css({ "background": "url(../images/dian.png)", "background-size": "10px 10px" });
    })
}
function ifBoxChecked() {
    $('input[type="checkbox"]:checked').each(function () {
        $(this).prev('span').addClass('gouChecked');
    })
}
//单选按钮的样式改变
$('input[type="radio"]').before('<span class="circle-btn"></span>');
$('.circle-btn').parent().click(function () {
    $(this).parents('.list-inline').find('.circle-btn').css('background', 'none');
	//
	var radio_name = $(this).find('input[type="radio"]').attr('name');
	$(this).find('input')[0].checked = true;

    $(this).find('.circle-btn').css({ "background": "url(../images/dian.png)", "background-size": "10px 10px" });
    if ($(this).closest('table').hasClass('line_chaidan')) {
        $('.jptable button.footKeepBtn:eq(0)').show();
        $('.jptable button.footKeepBtn:eq(1)').hide();
        $('tr[name="splittr"]').hide();
        $('tr.splitbox span').removeClass( "gouChecked" );
        $(this).closest('tbody').find('.circle-btn').css('background', 'none');
        $(this).find('.circle-btn').css({ "background": "url(../images/dian.png)", "background-size": "10px 10px" });
        if ($(this).find('.circle-btn').next('input').val() == '1') {
            $('tr[name="CarDriver"]').hide();
            $('tr[name="CarDriverSupplier"]').hide();
            $('tr[name="CarDriverSup"]').hide();
            $('.jptable button.footKeepBtn:eq(1)').show();
            $('.jptable button.footKeepBtn:eq(0)').hide();

            $('tr.lineSplit').show();
            $('tr.qtySplit').hide();

            var formP = $( 'input[name="FromProvince"]' ).val();
            var formC = $( 'input[name="FromCity"]' ).val();
            var formD = $( 'input[name="FromDistrict"]' ).val();
            var formadd = $( 'input[name="From"]' ).val();
            var fromPhone = $( 'input[name="FromContact"]' ).val();
            var toP = $( 'input[name="ToProvince"]' ).val();
            var toC = $( 'input[name="ToCity"]' ).val();
            var toD = $( 'input[name="ToDistrict"]' ).val();
            var to = $( 'input[name="To"]' ).val();
            var ToPhone = $( 'input[name="ToContact"]' ).val();
            $( 'input[name="InputFrom"]' ).val( formadd );
            $( 'input[name="InputTo"]' ).val( to);
            $( 'input[name="InputFromPhone"]' ).val( fromPhone );
            $( 'input[name="InputToPhone"]' ).val( ToPhone );

            $('tr.Goods').each(function() {
                $(this).find('input[name="splitQty"]').val($(this).find('td[name="Qty"]').text());
            });


        } else if ($(this).find('.circle-btn').next('input').val() == '2') {
            $('tr[name="CarDriverSupplier"]').hide();
            $('tr[name="CarDriver"]').hide();
            $('.jptable button.footKeepBtn:eq(1)').show();
            $('.jptable button.footKeepBtn:eq(0)').hide();

            $('tr.lineSplit').hide();
            $('tr.qtySplit').show();

            var formP = $( 'input[name="FromProvince"]' ).val();
            var formC = $( 'input[name="FromCity"]' ).val();
            var formD = $( 'input[name="FromDistrict"]' ).val();
            var formadd = $( 'input[name="From"]' ).val();
            var fromPhone = $( 'input[name="FromContact"]' ).val();
            var toP = $( 'input[name="ToProvince"]' ).val();
            var toC = $( 'input[name="ToCity"]' ).val();
            var toD = $( 'input[name="ToDistrict"]' ).val();
            var to = $( 'input[name="To"]' ).val();
            var ToPhone = $( 'input[name="ToContact"]' ).val();
            $( 'input[name="InputFrom"]' ).val( formadd );
            $( 'input[name="InputTo"]' ).val( to);
            $( 'input[name="InputFromPhone"]' ).val( fromPhone );
            $( 'input[name="InputToPhone"]' ).val( ToPhone );


            if ($('tr[nrowid="split"]').length > 0 ) {
                $('tr[nrowid="split"]').remove();
            }
            

        } else if ($(this).find('.circle-btn').next('input').val() == '3') {
            $('tr[name="CarDriver"]').show();
            $('tr[name="CarDriverSupplier"]').hide();
            $('tr[name="CarDriverSup"]').hide();
            $('.button_workflow .footKeepBtn:eq(1)').hide();

            $('tr.lineSplit').hide();
            $('tr.qtySplit').hide();
        } else if ($(this).find('.circle-btn').next('input').val() == '4') {
            $('tr[name="CarDriverSupplier"]').show();
            $('tr[name="CarDriver"]').hide();
            $('input[name="_WeightAddition"]').val( $('input[name=\'WeightAddition\']').val() );
            $('input[name="_VolumeAddition"]').val( $('input[name=\'VolumeAddition\']').val() );
            $('.button_workflow .footKeepBtn:eq(1)').show();

            $('tr.lineSplit').hide();
            $('tr.qtySplit').hide();
        }
//2294 待调度页面：拆单、承运方、自营，三者勾选其一时，无需清除操作
//      $('input[name="DriverID"]').val('');
//      $('input[name="CarID"]').val('');
//      $('input[name="SN"]').val('');
//      $('input[name="DriverName"]').val('');
//      $('input[name="SupplierName"]').val('');
//      $('input[name="SupplierID"]').val('');
    } 
})

//多选按钮的样式改变
$('input[type="checkbox"]').before('<span class="gou-btn"></span>');
$('.gou-btn').click(function () {
    var thisInput = $(this).next('input');
    if( $(this).hasClass('gouChecked')) {
        $(this).removeClass('gouChecked');
        $(this).next()[0].checked = false;
        if (thisInput.attr('name') == "split") {
            $('tr[name="splittr"]').hide();
            if (typeof $('input[name="WayToTime"]').val() != 'undefined') {
                $('input[name="WayToTime"]').each(function () {
                    $(this).closest('tr').remove();
                });
            }
        }
    } else {
        $(this).addClass('gouChecked');  
        $(this).next('input').prop("checked");
         $(this).next()[0].checked = true;
        if (thisInput.attr('name') == "split") {
            $('tr[name="splittr"]').show();
        }
    }
})

$('span.goods').on('click', function() { //多选按钮单击字体时样式改变
    $(this).prev().prev().click();
});

//编码转换列表
function QueryOrdersByCode( Code, Type ){    //Type 1 自己的订单  2 客户提供(发货方/运输)订单强烈
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0211';
    pmls[0].cross = 'false';
    pmls[0].rowIdentClass = 'orderList';

    var _paras = [{}, {}];
    _paras[0].name = 'Code';
    _paras[0].value = Code;
    _paras[1].name = 'Type';
    _paras[1].value = Type;
    pmls[0].paras = _paras;

    /*NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                console.log(data[0]);
            } else {
                alert(data[0].msg);
            }
        });*/

    $('tr[name="orderList"]').attr('view-id',  JsonToStr(pmls[0]) );
    var _orderList = new NSF.System.Data.Grid();
    _orderList.Pagination("first-ds-pag", $("div[name='first-ds-pag']"));
    _orderList.Initialize("/", "orderList", $("tr[name='orderList']").attr("view-id"), $("tr[name='orderList']"));

    var thisVal = '';
     $('.orderList td').each(function () {
        thisVal = $(this).text();
        $(this).attr("title", thisVal);
    });
}

//客户订单首页订单查询
function queryRes( a ) {
    var _code = $(a).closest('div').find('input').val();
	if( _code == '' )
		location.href = "OrderTracking.aspx";
	else
    location.href = "OrderTracking_edit.aspx?id=" + _code;
}

//运输订单首页订单查询
function queryDelivery( a ) {
    var _code = $(a).closest('div').find('input').val();
	if( _code == '' )
		location.href = "TrackingManage.aspx";
	else
		location.href = "TrackingManage_edit.aspx?id=" + _code;
}

//我的待办列表
function showWaitDoneEvent() {
        var _myEvents = new NSF.System.Data.Grid();
        _myEvents.Pagination("first-ds-pag", $('div.list-item').find('div[name="first-ds-pag"]'));
        _myEvents.Initialize("/", "WaitDoneEvent", $("tr[name='WaitDoneEvent']").attr("view-id"), $("tr[name='WaitDoneEvent']"));

        $('.WaitDoneEvent').each(function () {
            var _WaitEvent;
            var _Event_Type = $(this).find('td[name="Event_Type"]').text();
            var _Event_SrcCompanyName = $(this).find('td[name="Event_SrcCompanyName"]').text();
            var _Event_DstCompanyName = $(this).find('td[name="Event_DstCompanyName"]').text();
            var _Event_Ext = $(this).find('td[name="Event_Ext"]').text();
            var _Event_Result = $(this).find('span[name="Event_Result"]').text();
            var _IsLongDistance = $(this).find('span[name="IsLongDistance"]').text();

            if (_Event_Type == '1') {
                _WaitEvent = _Event_DstCompanyName + '被邀请成为承运方';
                $(this).find('a').attr('href', 'BeInvite.aspx');
            }
            else if (_Event_Type == '2') {
                if (_Event_Result == '0') {
                    _WaitEvent = '邀请' + _Event_SrcCompanyName + '成为承运方被接受';
                    $(this).find('a').attr('href', 'SupplierList.aspx');
                }
                else {
                    _WaitEvent = '邀请' + _Event_SrcCompanyName + '成为承运方被拒绝';
                    $(this).find('a').attr('href', 'Invite.aspx');
                }

            }
            else if (_Event_Type == '3') {
                _WaitEvent = '待接收订单：' + _Event_Ext;
                $(this).find('a').attr('href', 'OrderAccept_edit.aspx?id=' + _Event_Ext );
            }
            else if (_Event_Type == '4') {
                _WaitEvent = '被拒绝的订单：' + _Event_Ext;
                if ( _IsLongDistance == '0' ){
                    $(this).find('a').attr('href', 'OrderSend.aspx');
                }else if ( _IsLongDistance == '1' ){
                    $(this).find('a').attr('href', 'OrderLongSend.aspx');
                }
            }
            else if (_Event_Type == '5') {
                _WaitEvent = '订单有新的异常费用产生：' + _Event_Ext;
                $(this).find('a').attr('href', 'Index_edit.aspx?id=' + _Event_Ext );
            }
            else if (_Event_Type == '6') {
                _WaitEvent = '订单有新的附加费用产生：' + _Event_Ext;
                $(this).find('a').attr('href', 'Index_edit.aspx?id=' + _Event_Ext );
            }else if (_Event_Type == '12') {
                _WaitEvent = '待审核拼车单：' + _Event_Ext;
                $(this).find('a').attr('href', 'OrderAcceptCar_edit.aspx?id=' + _Event_Ext );
            }else if (_Event_Type == '13') {
                _WaitEvent = '被拒绝的拼车单：' + _Event_Ext;
                $(this).find('a').attr('href', 'OrderSendCar.aspx?id=' + _Event_Ext );
            }else if (_Event_Type == '14') {
                _WaitEvent = '已接收的拼车单：' + _Event_Ext;
                $(this).find('a').attr('href', 'OrderAcceptedCar.aspx?id=' + _Event_Ext );
            }else if (_Event_Type == '25') {
                _WaitEvent = '基础（零担/整车）价格为0：' + _Event_Ext;
            } else if (_Event_Type == '26') {
                _WaitEvent = '提货费价格为0：' + _Event_Ext;
            } else if (_Event_Type == '27') {
                _WaitEvent = '送货费价格为0：' + _Event_Ext;
            }  else if (_Event_Type == '28') {
                _WaitEvent = '装货费价格为0：' + _Event_Ext;
            } else if (_Event_Type == '29') {
                _WaitEvent = '卸货费价格为0：' + _Event_Ext;
            } else if (_Event_Type == '30') {
                _WaitEvent = '保费价格为0：' + _Event_Ext;
            }
            $(this).find('td[name="WaitEvent"] a').text(_WaitEvent);
        });

        //提示没有数据
        if ($('.table tbody tr:first').hasClass('WaitDoneEvent') == false) {
            var nodata = $("<p></p>").text('没有数据');
            nodata.css('text-align', 'center');
            $('.table').after(nodata);
            $('div.list-item').find('div[name="first-ds-pag"]').hide();
        }

        //获取序列号
        for (var i = 0; i < $('.WaitDoneEvent').length; i++) {
            $('.WaitDoneEvent').eq(i).find('td').first().text(i+1);
        }

        if( $('.WaitDoneEvent').length < 5 ){
            $('div.list-item').find('div[name="first-ds-pag"]').hide();
        }
    }

//我的待办分页
function page(page) {
         $('tr[name="WaitDoneEvent"]').attr('view-id', '{ id:"tms_0091",cross:"false", rowIdentClass:"WaitDoneEvent", paras:[{"name":"rows","value":5},{"name":"page","value":"'+ page +'"}]}');
         showWaitDoneEvent();
  }

//对话框双击列表选中事件
function dblEvents(){
        $(window.parent.document.getElementsByClassName('okButton')).trigger('click');
    }

//批量接收订单
function lotsReceive(){
    if($("tbody input[type=checkbox]:checked").size() ==0)
    {
        alert("请在下面的列表中，至少选择其中一行！");
    }else{
        $('#receive-Modal').modal( "show" );
        $('div.loading').show();
        $('button.cancer').prop('disabled','disabled');
    
        setTimeout('lotsReceiveData()',1000);
    }
}

function lotsReceiveData(){
        var _srcClass = '';
    var _orderid = '';
    var _code = "";
    var _pactcode = "";
    var _customername = "";
    var pmls = [{}];
    var _that;

    var queue = new Queue();
    queue.Interval = 100;
    queue.Exec();
    
    $('.receive-checkbox:checked').each( function( index ){
        _srcClass = $(this).attr("srcClass");
        _orderid = $(this).val();
        _that = $(this);

        pmls[0].namespace = "protocol";
        pmls[0].cmd = "data";
        pmls[0].version = 1;

        if( _srcClass == "3" ){
            pmls[0].id = 'tms_0106';
        }else{
            pmls[0].id = 'tms_0066';
        }

        var _paras = [{}, {}];
        _paras[0].name = 'OrderID';
        _paras[0].value = _orderid;
        _paras[1].name = 'Accept';
        _paras[1].value = 1;
        pmls[0].paras = _paras;

        var pmlStr = JsonToStr( pmls );

        //队列
        queue.Push( function (_context, pmls ) {
            var num =  $('.receive-checkbox:checked').length - _context._queue.length;
            $("#num").html( "<span style=\"color:#f27302\">" + num + "</span>/" + $('.receive-checkbox:checked').length );
                NSF.System.Network.Ajax('/Portal.aspx',
                    pmls,
                    'POST',
                    false,
                    function(result, data) {
                        if (data[0].result) {
                            if( data[0].rs[0].rows[0].Order_Result != "0" ){
                                var _value = Result( data[0], 'msg' );      //返回中文错误信息
                                _code = _that.closest("tr").find("td:eq(1)").text();
                                _pactcode = _that.closest("tr").find("td:eq(2)").text();
                                _customername = _that.closest("tr").find("td:eq(3)").text();

                                var _tr = "<tr><td>" + _code + "</td><td>"+ _pactcode +"</td><td>" + _customername + "</td><td>" + _value + "</td></tr>"
                                $('#receive-Modal tbody').append( _tr );
                            }

                        } else {
                            alert(data[0].msg);
                        }
                    });
                if( num == $('.receive-checkbox:checked').length ){
                    $('button.cancer').removeProp('disabled');
                    if( $('#receive-Modal tbody>tr').length == 0 ){
                        $('#receive-Modal tbody').append( '<tr><td style="text-align: center;" colspan="4">全部接收成功!</td></tr>' );
                    }
                }


        }, queue, pmlStr );
    });
}


//撤回委托订单
function Unschedule( OrderID ){
    $( "#UnscheduleModal" ).modal( "show" );
    $( "#UnscheduleModal" ).find( "input[name='COrderID']").val( OrderID );
}

function UnscheduleSupplierOrder( divModal) {
    divModal.modal('hide');
    var pmls = [{}];
    pmls[0].namespace = 'protocol';
    pmls[0].cmd = 'data';
    pmls[0].version = 1;
    pmls[0].id = 'tms_0214';

    var _paras = [{}, {}];
    _paras[0].name = 'OrderID';
    _paras[0].value = divModal.find('input[name="COrderID"]').val();
    _paras[1].name = 'Description';
    _paras[1].value = divModal.find('textarea[name="CDescription"]').val();
    pmls[0].paras = _paras;

    NSF.System.Network.Ajax('/Portal.aspx',
        JsonToStr(pmls),
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                if ($('body').attr('code') == 'Index') {
                    alert('成功！');
                    window.location.reload();
                }
                else {
                    Result(data[0]);
                }
            } else {
                alert(data[0].msg);
            }
        });
    divModal.find('textarea[name="CDescription"]').val('');
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

//发送拼车单
function CombinedModal( OrderID, SupplierName, OpenId, Qty, PactCode ){
    $("div#CombinedModal").modal( "show" );
    $("div#CombinedModal").find('input[name="COrderID"]').val(OrderID);
    $("div#CombinedModal").find('input[name="OrderID"]').val(OrderID);
    $("div#CombinedModal").find('input[name="PactCode"]').val(PactCode);
    if( SupplierName == "自营" ){
        $("div#CombinedModal").find('input[name="SupplierName"]').val("");
    }else{
        $("div#CombinedModal").find('input[name="SupplierName"]').val(SupplierName);
    }

    $("div#CombinedModal").find('input[name="OpenId"]').val(OpenId);
	$("div#CombinedModal").find('input[name="CombinedQty"]').val(Qty);
}


//确认拆单
//是否确认
function IsSplit() {
    $('ul.qtynum').each(function() {
        $(this).next().remove();
        $(this).remove();
    });
    var _fromAddress = $('.lineSplit input[name="InputFrom"]').val();
    var _toAddress = $('.lineSplit input[name="InputTo"]').val();
    var _li = '';
    var _ul = '';
    var _qtydatalen = 0;

    var _radioval = $('input[name="split"]:checked').val();
    if (_radioval == '1') {     //线路
        $('div.splitnum').hide();
        $('div.splitline').show();

        $('.linedata').each(function() {
            $(this).remove();
        });
        var _linelength = $('tr[nrowid="split"]').length;

        if (_linelength > 0) {
            $('span.qty-total').text(_linelength+1);

            $('tr[nrowid="split"]').each(function() {
                var _wayAddress = $(this).find('input[name="WayTo"]').val() + ' ' + $(this).find('input[name="InputDedail"]').val();
                _li += '<li class="linedata"><img src="/images/split1.png"><span class="wayAddress">途经地：'+ _wayAddress +'</span></li>';
            });

            $('#splitModal li.last').before(_li);
            $('#splitModal .fromAddress').text(_fromAddress);
            $('#splitModal .toAddress').text(_toAddress);

            $('#splitModal').modal('show');
        } else {
            alert('必须进行线路拆单！');
        }
        

    } else if (_radioval == '2') {  //数量
        $('div.splitnum').show();
        $('div.splitline').hide();
        $('.splitnumdata ul li').each(function(index) {
            if (index > 0) {
                $(this).remove();
            }
        });
        var _qtydata;
        $('tr.Goods').each(function() {
            _qtydata = $(this).find('input[name="splitQty"]').val().split('|');
            if (_qtydata.length > _qtydatalen) {
                _qtydatalen = _qtydata.length;
            }
        });
        var _width = 62/_qtydatalen;
        for(var i = 0; i < _qtydatalen; i++) {
            $('.splitnumdata ul:first').append('<li class="text-center" style="width:'+ _width +'%">第'+ (i+1) +'单</li>');
        }

        if (_qtydatalen > 1)  {
            $('span.qty-total').text(_qtydatalen);

            $('tr.Goods').each(function() {
                var _goodsname = $(this).find('td[name="GoodsName"]').text();
                _qtydata = $(this).find('input[name="splitQty"]').val().split('|');
                _ul = '<ul class="qtynum list-inline">';
                _li = '<li style="width:35%">'+ _goodsname +'</li>';
                for(var i = 0; i < _qtydatalen; i++) {
                    if (typeof _qtydata[i] == 'undefined') {
                        _qtydata[i] = 0;
                    }
                    _li += '<li class="text-center" style="width:'+ _width +'%">'+ _qtydata[i] +'</li>';

                }

                _ul += _li +'</ul><div class="line-dash"></div>';

                $('#splitModal .splitnumdata').append(_ul);

                $('#splitModal').modal('show');
            });
        } else {
            alert('必须进行数量拆单！');
        }

        
    }   
}

//添加物品
function saveGoods( a ){
    var volume = $('input[name="Volume"]').val();
    var weight = $('input[name="Weight"]').val();

    if( volume == "0.000000" && weight == "0.0000" ){
        alert( "物品重量、体积不能同时为0，请重新输入！");
    }else{
         var table = $(a).closest('table');
        SaveFormDataNDT(table, $(a), __saveNdtCfg);  
    }
}

//多选按钮的样式改变,jplist列表
function checkboxList() {
    $('input[type="checkbox"]').before('<span class="gou-btn"></span>');
    $('table tr').on( "click", function ( e ) {
        var thisInput = $(this).find('.gou-btn').next('input');

        if( $(this).parent()[0].tagName=="THEAD" ){
            if ($(this).find('.gou-btn').hasClass('gouChecked')) {
            	$(this).parent().next().children().removeAttr("bgcolor");
                $(this).find('.gou-btn').removeClass('gouChecked');
                $(this).find('.gou-btn').next('input')[0].checked = false;
                $(this).closest("table").find("input[type='checkbox']").each( function( index ){
                    $(this).prev().removeClass('gouChecked');
                    $(this)[0].checked = false;
                });
            } else {
                $(this).find('.gou-btn').addClass('gouChecked');
                $(this).parent().next().children().attr("bgcolor","#f4f4f4");
                $(this).find('.gou-btn').next('input').attr("checked", true);
                $(this).closest("table").find("input[type='checkbox']").each( function( index ){
                    $(this).prev().addClass('gouChecked');
                    $(this)[0].checked = true;
                });
            }
        }else{
            if ($(this).find('.gou-btn').hasClass('gouChecked')) {
            	$(this).parent().next().children().removeAttr("bgcolor");
                $(this).find('.gou-btn').removeClass('gouChecked');
                if( e.target.tagName=="SPAN" ){
                    $(this).find('input[type="checkbox"]')[0].checked = false;
                }
            } else {
                $(this).find('.gou-btn').addClass('gouChecked');
                $(this).parent().next().children().attr("bgcolor","#f4f4f4");
                if( e.target.tagName=="SPAN" ){
                    $(this).find('input[type="checkbox"]')[0].checked = true;
                }
            }
        }
        
    });
}

//个人中心，初始化列表数据
function loadList( urlBj )
{
    if( typeof urlBj == "undefined" ){

        if( location.href.indexOf("#") != -1 ){
            urlBj = location.href.split("aspx")[1];
        }else{
            urlBj = $("div.mt30>div:eq(0)").find("a:eq(0)").attr("href");
        }

    }
    if(urlBj == '')
    {
        document.location.href= window.location.href + '#0';
        var urlBj = window.location.hash;
    }
    $('.navTab a').removeClass('active');
    
    if (urlBj) {
        $('.navTab a[href="' + urlBj + '"]').addClass('active');
        $('.jplist').addClass('hide');
        if (urlBj.substr(1) == 0) {
            $('#demo').removeClass('hide');
        } else {
            $('#demo' + urlBj.substr(1)).removeClass('hide');
        }
    } else {
        $('.navTab a[href="#0"]').addClass('active');
    }
    
    
    //待接收
    if (urlBj == '#0')
    {
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "OrderAccept", "/Widget.aspx?param=jplist&vid=grid_jplist_0078", false, checkboxList);
    }
        //市内待调度
    else if (urlBj == '#1') {
        InitList($("#demo1"), $("#demo1 .list"), $("#jplist-template1").html(), "demo1", "/Widget.aspx?param=jplist&vid=grid_jplist_0006", false, checkboxList);
    }
    //待签收
    else if (urlBj == '#2') {
        InitList($("#demo2"), $("#demo2 .list"), $("#jplist-template2").html(), "demo2", "/Widget.aspx?param=jplist&vid=grid_jplist_0080", false, "");
    }
        //待回单
    else if (urlBj == '#3') {
        InitList($("#demo3"), $("#demo3 .list"), $("#jplist-template3").html(), "demo3", "/Widget.aspx?param=jplist&vid=grid_jplist_0081", false, "");
    }
        //待审核承运方
    else if (urlBj == '#4') {
        InitList($("#demo4"), $("#demo4 .list"), $("#jplist-template4").html(), "demo4", "/Widget.aspx?param=jplist&vid=grid_jplist_0027", false, "");
    }
        //长途待调度
    else if (urlBj == '#5')
    {
        InitList($("#demo5"), $("#demo5 .list"), $("#jplist-template5").html(), "demo5", "/Widget.aspx?param=jplist&vid=grid_jplist_0059", false, checkboxList);
    }
        //拼车待调度
    else if (urlBj == '#6')
    {
        InitList($("#demo6"), $("#demo6 .list"), $("#jplist-template6").html(), "demo6", "/Widget.aspx?param=jplist&vid=grid_jplist_0069", false, checkboxList);
    }

}

//个人中心，调度
function ScheduleOrderList(sendId) {
        $('#myModal').modal('hide');

        var _DriverID = $('input[name="DriverID"]').val();
        var _CarID = $('input[name="CarID"]').val();
        var pmls = [{}];
        pmls[0].namespace = 'protocol';
        pmls[0].cmd = 'data';
        pmls[0].version = 1;
        pmls[0].id = 'tms_0093';

        var _paras = [{}, {}, {}, {}, {}, {}, {}];
        _paras[0].name = 'OrderID';
        _paras[0].value = $('#Div1 input[name="id"]').val();
        _paras[1].name = 'SupplierID';
        _paras[1].value = $('input[name="SupplierID"]').val();
        _paras[2].name = 'DriverID';
        _paras[2].value = _DriverID
        _paras[3].name = 'CarID';
        _paras[3].value = _CarID;
        _paras[4].name = '_VolumeAddition';
        _paras[4].value = $('input[name="_VolumeAddition"]').val();
        _paras[5].name = '_WeightAddition';
        _paras[5].value = $('input[name="_WeightAddition"]').val();
        _paras[6].name = 'SupplierSymbolID';
        _paras[6].value = $('input[name="SupplierSymbolID"]').val();
        pmls[0].paras = _paras;

        NSF.System.Network.Ajax('/Portal.aspx',
            JsonToStr(pmls),
            'POST',
            false,
            function (result, data) {
                if (data[0].result) {                    
                    if (data[0].rs[0].rows[0].Schedule_Result == 0)
                    {
                        alert('成功！');
                        window.location.reload();
                    }                      
                    else
                    {
                        Result(data[0]);
                    }
                } else {
                    alert(data[0].msg);
                }
            });
    }

//个人中心
function IndexIsSend(id) {
    $('#Div1').modal('show');
    $('#Div1 input[name="id"]').val(id);

}

//个人中心-配置信息
//获取货物分类值
function orderCfg( that )
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

//拆分物品,显示模态框
function splitQtyClick( inputObj ){
    var _trObj = $(inputObj).closest('tr');
    $('div#splitQtyModal').modal( {backdrop: 'static', keyboard: false} );
    $('div#splitQtyModal span[name="totalQty"]').text( _trObj.find('td[name="Qty"]').text() );
    $('div#splitQtyModal span[name="ListID"]').text( _trObj.find('input[name="ListID"]').val() );
    $('div#splitQtyModal span[name="GoodsName"]').text( _trObj.find('td[name="GoodsName"]').text() );
    $('input.qtyinput').val("");
    $('input.qtyinput').each(function(index) {
        if (index > 1) {
            $(this).parent().remove();
            $('div#splitQtyModal a:eq(1)').hide();
            $('div#splitQtyModal a:eq(0)').show()
        }
    });

    if ($(inputObj).val().indexOf('|') != -1) {
        var _goods = $(inputObj).val().split('|');

        if (_goods.length > 2) {
            var _divClone = $('input.qtyinput:eq(0)').parent();
            _divClone.find('input.qtyinput').val('');
            for (i = 2; i < _goods.length; i++) {
                $('div#splitQtyModal a:eq(0)').click();
            }
        }

        for (var i = 0; i < _goods.length; i++) {
             $('input.qtyinput:eq('+ i +')').val(_goods[i]);
        }
        
    } else {
        $('input.qtyinput:eq(0)').val('');
    }
}
//拆分物品,模态框确认
function splitQty( modalObj ){
    var _totalqty = parseInt( modalObj.find('span[name="totalQty"]').text() );
    var _splitqty = 0;
    var _qtystr = '';
     $('input.qtyinput').each(function( index ){
        if( $(this).val() != "" ){
            _splitqty += parseInt( $(this).val() );
            _qtystr += $(this).val() + "|";
        }else{
            _splitqty += 0;
        }
       
     });

     _qtystr = _qtystr.substring( 0, _qtystr.length-1 );

     if( _splitqty > _totalqty ){
        alert("拆分数量不能超过总数量，请重新拆分！");
        $('input.qtyinput').val("");
     }else if( _splitqty < _totalqty ){
        alert("总数量没被拆分完，请重新拆分！");
        $('input.qtyinput').val("");
     }else if( _splitqty == _totalqty ){
        modalObj.modal( "hide" );
        $(".Goods").find('input[value="'+ modalObj.find('span[name="ListID"]').text() +'"]').next().val( _qtystr );
     }
}

//创建订单
function orderEdit()
{

    var rowTr = $('a[name="add"]').parent().parent().next();
    _row_add(rowTr,undefined, undefined);


    //默认显示客户名称
    var pmls = '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0099","paras":[]}]';
    NSF.System.Network.Ajax( '/Portal.aspx',
        pmls,
        'POST',
        false,
        function ( result, data )
        {
            if( result )
            {
                $('input[name="CustomerName"]').attr('placeholder',data[0].rs[0].rows[0].name);
                $('input[name="CustomerName"]').val(data[0].rs[0].rows[0].name);
                $('input[name="CustomerID"]').val(data[0].rs[0].rows[0].id);
                $('input[name="CompanyID"]').val(data[0].rs[0].rows[0].companyid);
            }
        } );

    //最后一条物品不能删除
    //$( 'tr[nrowid="TMS_OrderGoods"]' ).eq( 0 ).find( 'td a' ).attr( 'executecode', ' ' );
    //$( 'tr[nrowid="TMS_OrderGoods"]' ).eq( 0 ).find( 'td' ).attr( 'disabled', 'disabled' );
}

//待调度订单，显示数量拆单
function splitQtyShow(){
    var _id = NSF.UrlVars.Get( 'id', location.href );
    if ( _id )
    {
        $( 'tr[name="Goods"]' ).attr( 'view-id', '{ id:"tms_0074",cross:"false", rowIdentClass:"Goods", paras:[{"name" : "id", "value" : ' + _id + '}]}' );
    }
    else
    {
        $( 'tr[name="Goods"]' ).attr( 'view-id', '{ id:"tms_0074",cross:"false", rowIdentClass:"Goods", paras:[{"name" : "id", "value" : ""}]}' );
    }
    var _goods = new NSF.System.Data.Grid();
    _goods.Initialize( "/", "Goods", $( "tr[name='Goods']" ).attr( "view-id" ), $( "tr[name='Goods']" ) );

}



//待调度订单，显示合计数据
function showTotal(num)
{
    $( 'div[name="CarType"]' ).find( 'input[name="CarType"]:checked' ).attr( 'checked', false );

    var _weight = parseFloat( $('input[name="WeightAddition"]').val() );
    var _volume = parseFloat( $('input[name="VolumeAddition"]').val() );

    
    var _qty = 0;

    $('tr[nrowid="TMS_OrderGoods"]').each( function(){

        _weight += parseFloat( $(this).find('input[name="Weight"]').val() );
        _volume += parseFloat( $(this).find('input[name="Volume"]').val() );
        _qty += parseFloat( $(this).find('input[name="Qty"]').val() );
    });

    $('input[name="TotalWeight"]').val( _weight.toFixed(4) );
    $('input[name="TotalVolume"]').val( _volume.toFixed(6) );
    $('input[name="TotalQty"]').val( _qty );

    //再次输入补差
    $('input[name="wAddition"]').val($('input[name="WeightAddition"]').val());
    $('input[name="vAddition"]').val($('input[name="VolumeAddition"]').val());
    $('input[name="WeightAddition"]').val('0.0000');
    $('input[name="VolumeAddition"]').val('0.000000');
}

//待调度，运输模式
function car_zy(obj)
{
    
    if ( $( 'input[name="TransportMode"]:checked' ).val() == 1 )
    {
        showModalWindow( obj, '车辆', '', 'CarType=' + '&CarLength=' );
    }
    else if ( $( 'input[name="TransportMode"]:checked' ).val() == 2 )
    {
        showModalWindow( obj, '车辆', '', 'CarType=' + $( 'input[name=CarType]' ).val() + '&CarLength=' + $( 'input[name=CarLength]' ).val() )
    }
    else{
        alert( "请选择运输模式" );
    }
}
//待调度，隐藏部分数据
function showInfor() {
    var inforNum = $('.showTbody tr').length;
    for (var i = 4; i < $('.showTbody tr').length; i++) {
        $('.showTbody tr').eq(i).css('display', 'none');
    }
}


//拼车单显示详情，自营、承运方
function showCombined(){
  var _SupplierID = getUrlParam("SupplierID");
  if( _SupplierID == "0" ){
    $('tr[name="CarDriver"]').show();
    $('tr[name="CarDriverSupplier"]').hide();
    $('input[value="3"]')[0].checked = true;
    $('input[value="3"]').prev('span').css({ "background": "url(../images/dian.png)", "background-size": "10px 10px" });
    
  }else{
    $('tr[name="CarDriverSupplier"]').show();
    $('tr[name="CarDriver"]').hide();
    $('input[value="4"]')[0].checked = true;
    $('input[value="4"]').prev('span').css({ "background": "url(../images/dian.png)", "background-size": "10px 10px" });
  }

  if(  _SupplierID == "0" ){
      $('input[name="SupplierName"]').val("");
  }
}

//导出列表数据
function toXls( tableid ) {
    new NSF.System.Converter.ToXls().method1(tableid);
    //$('div#excel').modal( "hide" );
}

//省市区
function getAreas() {
    store.clear();
    var areas = store.get('sql_areas');
    var params = '[{"namespace":"protocol","cmd":"rfile","version":1,"id":"rLst_file","paras":[{"name":"filename","value":"sql_areas"}]}]';
    
    if (areas) {    //判断数据是否已存在浏览器中
      for (var i = 0; i < areas.length; i++) {
        var area = {id:areas[i].id,name:areas[i].name,level:areas[i].level,parentId:areas[i].parentId};
        areas[i] = area;
      }

      for(var i = 0; i < $('.bs-chinese-region').length; i++){
        $('.bs-chinese-region').eq(i).chineseRegion('source',areas);
      }
    }else {
      $.ajax( {
            async: false,
            url: '/Portal.aspx',
            dataType: "json" ,
            jsonp:  '',
            type: 'POST',
            data: params,
            success: function ( data ) {
                data = NSF.System.Json.ToJson( data[0].file.content )[0].rs[0].rows;
                for (var i = 0; i < data.length; i++) {
                    var area = {id:data[i].id,name:data[i].name,level:data[i].nodetype,parentId:data[i].parentid};
                    data[i] = area;
                }

                for(var i = 0; i < $('.bs-chinese-region').length; i++) {
                  $('.bs-chinese-region').eq(i).chineseRegion('source',data);
                }

                store.set('sql_areas', data);
            }
        }); 
    }
}

//客户常用地址信息页面处理
function CustomerAddrAdd() {
  var pmls = '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0099","paras":[]}]';
  NSF.System.Network.Ajax( '/Portal.aspx', pmls, 'POST', false, function ( result, data ) {     //默认显示客户信息
      if( result ) {
        $('input[name="CustomerName"]').attr('placeholder',data[0].rs[0].rows[0].name);
        $('input[name="CustomerName"]').val(data[0].rs[0].rows[0].name);
        $('input[name="CustomerID"]').val(data[0].rs[0].rows[0].id);
        $('input[name="CompanyID"]').val(data[0].rs[0].rows[0].companyid);
      }
    });

  if (NSF.UrlVars.Get("id")) {
    for(var i = $('.bs-chinese-region').find('input').length - 1; i > 0; i--) {     //默认显示省市区
      if( $('.bs-chinese-region').find('input').eq(i).val() != "" ) {
        $('.bs-chinese-region').find('input:eq(0)').val( $('.bs-chinese-region').find('input').eq(i).val() );
        getAreas();

        return;
      } 
    }
  } else {
    getAreas();
  }
}

//创建订单，获取常用地址信息
function getAddress(value) {
    getAreas();
}

//普通订单调度成功，发送消息给微信
function infoSend(token, callback) {
	var _openId = $('input[name="OpenId"]').val();
	
	if (_openId != null && _openId != "")
	{
		var _params = {};
		_params.touser = _openId;
		//_params.template_id = '5b9KYNT7-ecwYvFkxjyNuAFUFyN7R6Wh3P-saKHEJGI';
        _params.template_id = '3hOtngiEc60Qv_Mz-DjYcJNeB4CRihgUPQL-GhJgUS0';
		_params.url = 'http://driver.wlyuan.com.cn/Index.aspx?openid='+ _params.touser +'&id='+ $('input[name="OrderID"]').val() +'&conbined=0';

		var _data = {};
		//_data.first = {"value": $('span.zld_username').text() + "，您好！您有新订单：" , "color":"#7eb30"};
        _data.first = {"value": $('input[name="SupplierName"]').val() + "，您好！您有新订单：" , "color":"#7eb30"};
        _data.keyword1 = {"value": $('input[name="Code"]').val() , "color":"#7eb30" };
        //_data.keyword2 = {"value": $('input[name="EndUserName"]').val() , "color":"#7eb30" };
        _data.keyword2 = {"value": $('input[name="Name"]').val() , "color":"#7eb30" };
        //_data.keyword3 = {"value": $('input[name="To"]').val() , "color":"#7eb30" };
        _data.keyword3 = {"value": $('input[name="From"]').val() , "color":"#7eb30" };
        //_data.keyword4 = {"value": $('input[name="ToTime"]').val() , "color":"#7eb30" };
        _data.keyword4 = {"value": $('input[name="FromTime"]').val() , "color":"#7eb30" };
        //_data.keyword5 = {"value": $('input[name="ToContact"]').val() , "color":"#7eb30" };
        _data.keyword5 = {"value": $('input[name="FromContact"]').val() , "color":"#7eb30" };

		_params.data = _data;

		var _url = 'http://api.weixin.qq.com/cgi-bin/message/template/send?access_token='+ token +'';
		var cross = false;

		try
		{
			$.ajax({
				async: false,
				url: _url,
				dataType: ( cross ? "jsonp" : "json" ),
				jsonp: ( cross ? 'callback' : '' ),
				type: 'POST',
				data: NSF.System.Json.ToString(_params),
				error: function ( reqObj, status, err )
				{
					console.log( '{ "status" : "' + status + '", "err" : "' + err + '" } ' );
				},
				success: function ( result, data )
				{
					console.log(NSF.System.Json.ToString(data) );
				}
			});
		}
		catch(e)
		{
			//
		}
		finally
		{
			callback();
		}
	}
	else
	{
		callback();
	}
}

//拼车订单发送成功，发送消息给微信
function infoCombinSend(token, callback) {
	var _openId = $('input[name="OpenId"]').val();
	
	if (_openId != null && _openId != "")
	{
		var _params = {};
		_params.touser = _openId;
		_params.template_id = 'CGtmThPkEO7LPDQFULlnA6oLI8I0evrbRAejRarNiUI';
		_params.url = 'http://driver.wlyuan.com.cn/Index.aspx?openid='+ _params.touser +'&id='+ $('input[name="OrderID"]').val() +'&conbined=1';

		var _data = {};
		_data.first = {"value": $('span.zld_username').text() + "，您好！您有新订单：" , "color":"#7eb30"};
		_data.keyword1 = {"value": $('input[name="PactCode"]').val() , "color":"#7eb30" };
        _data.keyword2 = {"value": "拼车订单" , "color":"#7eb30" };

        var _keyword3;
		//_data.keyword2 = '拼车订单';
		if ($('[nrowid="OrderContains"]').length > 0)
		{
			_keyword3 = $('[rowid="OrderContains"]').length;
		}
		else
		{
			_keyword3 = $('input[name="CombinedQty"]').val();
		}
        _data.keyword3 = {"value": _keyword3 , "color":"#7eb30" };

		_params.data = _data;

		var _url = 'http://api.weixin.qq.com/cgi-bin/message/template/send?access_token='+ token +'';
		var cross = false;

		try
		{
			$.ajax({
				async: false,
				url: _url,
				dataType: ( cross ? "jsonp" : "json" ),
				jsonp: ( cross ? 'callback' : '' ),
				type: 'POST',
				data: NSF.System.Json.ToString(_params),
				error: function ( reqObj, status, err )
				{
					console.log( '{ "status" : "' + status + '", "err" : "' + err + '" } ' );
				},
				success: function ( result, data )
				{
					console.log(NSF.System.Json.ToString(data) );
				}
			});
		}
		catch(e)
		{
			//
		}
		finally
		{
			callback();
		}
	}
	else
	{
		callback();
	}
}

//  合计   2016-10-25 Huzy
function Statistics() {
	var TWeight = 0,
		TVolume = 0,
		GoodsValue = 0,
		_qty = 0,
	    _price = 0;		
	    //循环 列表 数据
	$('tr[nrowid="TMS_OrderGoods"]').each(function(index) {
		_qty = parseInt(_qty) + parseInt($(this).find('input[name="Qty"]').val());
		TWeight = style_add(parseFloat(TWeight) , style_mul($(this).find('input[name="Weight"]').val(), $(this).find('input[name="Qty"]').val()));
		TVolume = style_add(parseFloat(TVolume) , style_mul($(this).find('input[name="Volume"]').val(), $(this).find('input[name="Qty"]').val()));		
	});
	//加上补差
 	TWeight = style_add(TWeight , $('input[name="WeightAddition"]').val());
 	TVolume = style_add(TVolume , $('input[name="VolumeAddition"]').val());

    $('input[name="TotalWeight"]').val(TWeight.toFixed(4));
    $('input[name="TotalVolume"]').val(TVolume.toFixed(6));
    $('input[name="TotalQty"]').val(_qty);	
 
}

//  2118     2016-10-25 Huzy
//$(document).on('focus', 'input', function() {
//	
//	if($(this).attr("readonly") == undefined){
//		$(this).parent().css('border','solid 2px #f27302');	
//	}
//});
//
//$(document).on('blur', 'input', function() {
//	
//	if($(this).attr("readonly") == undefined){
//		$(this).parent().css('border','solid 1px #e1e6eb');	
//	}
//});


//订单查询打印
function skipto(){
    var _orderid = NSF.UrlVars.Get('id', location.href);
    window.location.href="PrintPage.aspx?id="+_orderid + '&code=' + NSF.UrlVars.Get('code', location.href); 
}

//订单费用打印
function skiptoprintcost(){
    var _orderid = NSF.UrlVars.Get('id', location.href);
    window.location.href="PrintPageCost.aspx?id="+_orderid + '&code=' + NSF.UrlVars.Get('code', location.href);
}

//拼车单打印
function skiptocomb(){
	var _orderid =	NSF.UrlVars.Get('id', location.href);
	window.location.href="CombinePrintPage.aspx?id=" +_orderid;
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

$('.cancer').click( function (){
    location.reload();
});

function AppendComments(modalObj) {     //客户订单签收管理追加备注信息
    var _OrderID = $(modalObj).find('input[name="OrderID"]').val();
    var _desc = $(modalObj).find('textarea[name="Description"]').val();
    var _pml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"Comments_0001","paras":[{"name":"OrderID","value":"'+ _OrderID +'"},{"name":"Description","value":"'+ _desc +'"}]}]';

    NSF.System.Network.Ajax('/Portal.aspx',
        _pml,
        'POST',
        false,
        function (result, data) {
            if (data[0].result) {                    
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
}

function addComment(OrderID) {  //弹出追加备注信息框
    $('div#AppendComModal').modal({backdrop:"static", keyboard:false});
    $('div#AppendComModal').find('input[name="OrderID"]').val(OrderID);
}

function getRex(inputObj) {     //补差必须为数字
    var _inputVal = parseInt($(inputObj).val());
    $(inputObj).val(_inputVal.replace(/^\d/, ''));
}

function calTotalSign(name) {       //实签数量总计
    var _qty = 0;
    var _qtyTotal = 0;

    $('tr[nrowid="TMS_OrderGoods"]').each(function() {
        _qty = $(this).find('input[name="'+ name +'"]').val();
        if (_qty == '') _qty = 0;
        _qtyTotal += parseInt(_qty);
    });

    $('input[name="Total'+ name +'"]').val(_qtyTotal);
}

function sumTotalSign() {       //实签数量总计
    var _ReceiptQty = 0;
    var _ExceptionQty = 0;
    var _ReceiptQtyTotal = 0;
    var _ExceptionTotal = 0;

    $('tr[nrowid="TMS_OrderGoods"]').each(function() {
        _ReceiptQty = $(this).find('input[name="ReceiptQty"]').val();
        _ExceptionQty = $(this).find('input[name="ExceptionQty"]').val();
        if (_ReceiptQty == '') _ReceiptQty = 0;
        if (_ExceptionQty == '') _ExceptionQty = 0;
        _ReceiptQtyTotal += parseInt(_ReceiptQty);
        _ExceptionTotal += parseInt(_ExceptionQty);
    });

    $('input[name="TotalReceiptQty"]').val(_ReceiptQtyTotal);
    $('input[name="TotalExceptionQty"]').val(_ExceptionTotal);
}

function EODCustomerInfo(Type, EOD, InfoID) {    //1,物品类型 2 ,客户物品 3,常用地址 4,收货方信息 5,收货方常用地址
    var _pml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0234","paras":[{"name":"Type","value":"'+ Type +'"},{"name":"EOD","value":"'+ EOD +'"},{"name":"InfoID","value":"'+ InfoID +'"}]}]';

    NSF.System.Network.Ajax('/Portal.aspx',
        _pml,
        'POST',
        false,
        function (result, data) {
            if (data[0].result) {                    
                Result(data[0]);
            } else {
                alert(data[0].msg);
            }
        });
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
    _html += "&" +  addiParams;
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

        /*$('tr[nrowid="'+ _nrowid +'"]').each(function() {
              $(this).remove();
          });*/

        for (var i = 0; i < tr.length; i++) {
            if (i > 0) {
                $('a[name="add"]').click();
                
                Assignment($('tr[nrowid="'+ _nrowid +'"]:last').find('td:eq(0) input')[0],thatOption, tr[i]);
            } else {
                Assignment(thatBtn,thatOption, tr[i]);
            }

            //$('a[name="add"]').click();
            //Assignment($('tr[nrowid="'+ _nrowid +'"]:last').find('td:eq(0) input')[0],thatOption, tr[i]);

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

function LongCitySelector(value) {      //拼车单订单选择去重复, 计算合计值
    var flag = true;
    var _volume = 0, _weight = 0, _amount = 0, sum = 0;

    $('tr[nrowid="OrderContains"]').each(function() {
        if ($(this).find('input[name="orderid"]').val() == value) {
            sum++;
        }

        if (sum > 1) {
            $(this).remove();
        } else {
            _volume += parseFloat($(this).find('input[name="volume"]').val());
            _weight += parseFloat($(this).find('input[name="weight"]').val());
            _amount += parseFloat($(this).find('input[name="amount"]').val());
        }
    });
    $('input[name="TotalWeight"]').val(_weight.toFixed(4));
    $('input[name="TotalVolume"]').val(_volume.toFixed(6));
    $('input[name="TotalAmount"]').val(_amount.toFixed(2));

    
    return flag;
}

function totalOrderData() {       //拼单详情显示合计
    var _TotalAmount = 0, _TotalWeight = 0, _TotalVolume = 0;
    $('tr[nrowid="OrderContains"]').each(function() {
        _TotalAmount += parseFloat($(this).find('[name="amount"]').val());
        _TotalWeight += parseFloat($(this).find('[name="weight"]').val());
        _TotalVolume += parseFloat($(this).find('[name="volume"]').val());
    });

    $('[name="TotalAmount"]').val(_TotalAmount.toFixed(2));
    $('[name="TotalWeight"]').val(_TotalWeight.toFixed(4));
    $('[name="TotalVolume"]').val(_TotalVolume.toFixed(6));
}

//删除订单明细
function deleteOrder(td) {
    var _volume =$('input[name="TotalVolume"]').val();
    var _weight = $('input[name="TotalWeight"]').val();
    var _amount = $('input[name="TotalAmount"]').val();
    var _trobj = $(td).closest('tr');

    if ($('tr[nrowid="OrderContains"]').length == 1) {
      
        _volume = 0;
        _weight = 0;
        _amount = 0;
    } else {
        _volume -= parseFloat(_trobj.find('input[name="volume"]').val());
        _weight -= parseFloat(_trobj.find('input[name="weight"]').val());
        _amount -= parseFloat(_trobj.find('input[name="amount"]').val());
        _action_delete(_trobj, $(td));
    }
    $('input[name="TotalWeight"]').val(_weight.toFixed(4));
    $('input[name="TotalVolume"]').val(_volume.toFixed(6));
    $('input[name="TotalAmount"]').val(_amount);
}

// 拼车  订单物品多选赋值
function showWindow_before(btn, titleStr, valueObj, addiParams, evSubmit){
	var code_len_hu = $('tr[nrowid="OrderContains"]').find('input[name="orderid"]').length;
	var code_id_hu = "";	
	for(var i = 0;code_len_hu > i;i++){
 		if($('tr[nrowid="OrderContains"]').find('input[name="orderid"]').eq(i).val() != ""){
			code_id_hu +=  $('tr[nrowid="OrderContains"]').find('input[name="orderid"]').eq(i).val() + ",";
 		}
	}
    if (code_id_hu.length > 0) {
        code_id_hu = code_id_hu.substr(0,code_id_hu.length - 1);
    }	
    code_hu = "code_List_val=" + code_id_hu;
//	console.log(goods_id_hu);
	showWindow( btn, titleStr,valueObj, code_hu , evSubmit );
}
