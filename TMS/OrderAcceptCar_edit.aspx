<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>拼车单信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
    <style>
        .FormTable > tbody > tr > td {
      
        }

    </style>
</head>
<body code="OrderAcceptCar">

<!-- 通用对话框开始-->
<div class="modal fade text-center"   id="win-Common-Dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-body">
				<div class="content">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 通用对话框结尾 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog">
          <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                <%--<button type="button" class="close" 
                    data-dismiss="modal" aria-hidden="true">
                        &times;
                </button>--%>
                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">接收拼车单</p>
                    </div>
                </h4>
                </div>
                <div class="modal-body tab_jsjj">
                    <span name="content">是否确定接收拼车单</span>
                    <input type="hidden" name="Accept" />
                    <input type="hidden" name="OrderID" />
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
          <button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="ReceiveCombineOrders()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
          <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
    </div>
<!--通用头部文件开始-->
<!--#include file="/Controls/TMS/header.aspx"-->

<!--通用头部文件结尾-->
<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
    var __saveNdtCfg = '{"main":{"insertVml":"","updateVml":"","queryVml":"tms_0027"},"OrderContains":{"insertVml":"","updateVml":"","queryVml":"tms_0105","deleteVml":""}}';
</script>
 <table class="FormTable Y_alter" style="width:100%;" id="25ccf24c-9c73-44a5-899b-2565511d81d0" path="Price/eyxhzqmm" code="eyxhzqmm">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
  </colgroup>
  <tbody>
    <tr class="td-container tr-fixed">
      <td class="text-left" rowspan="1" colspan="5" style="font-size: 14px; border: 0; border-bottom: 1px solid #e1e6eb; padding-right: 0; padding-left: 0;width:100% !important">
      <div style="padding-top:20px;" >
              <div style="padding-left: 3px; background-color: #f27302;">
                  <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">合单信息</p>
              </div>
          </div>
      </td>
        
      <td colspan="6" style="border:0;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <a class="btn btn-red footKeepBtn" href="javascript:void(0);" onclick="IsReceiveCombineOrders( 1,  $('input[name=\'id\']').val())">接收&nbsp;<span class="glyphicon glyphicon-ok-circle"></span></a>
           <a class="btn btn-red noBtn" href="javascript:void(0);" onclick = "IsReceiveCombineOrders( 0,  $('input[name=\'id\']').val())">拒绝&nbsp;<span class="glyphicon glyphicon-thumbs-down"></span></a>
           <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
            
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
     <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 64px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="" style="background-color: rgb(242, 242, 242);">合同编号</td>
      <td class="" rowspan="1" colspan="3">
         <input name="PactCode" readonly class="edit form-control transparent"  f-options="{'code':'PactCode','type':'text','etype':'editable','len':'100'}" verify="{'title':'合同编号','length':'100','required':true}">
            <input type="hidden" name="OrderID" value="0">
            <input type="hidden" name="OrdersLst" value="0">
            <input type="hidden" name="ShipMode" value="0">
            <input name="Accept" type="hidden" value="1"/>
      </td>
       <td class="" style="background-color: rgb(242, 242, 242);">          
                <input type="hidden" name="SupplierID">承运方
            </a>
      </td>
      <td class="" rowspan="1" colspan="2">
        <input name="SupplierName" placeholder="点击“承运方”进行选择" title="点击承运方进行选择" class="edit form-control transparent" readonly="readonly" f-options="{'code':'SupplierName','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
      <td class="" style="background-color: rgb(242, 242, 242);">制单时间</td>
      <td rowspan="1" colspan="2">
         <input name="CreateTime" readonly  class="edit form-control transparent" readonly="readonly" f-options="{'code':'CreateTime','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 100px;">
      <td class="" style="background-color: rgb(242, 242, 242);">备注</td>
      <td rowspan="1" colspan="9">
       <textarea name="Descriptions" readonly class="edit form-control transparent" f-options="{'code':'Descriptions','type':'richtext','etype':'editable','len':'600'}" verify="{'title':'备注','length':'600','required':true}"></textarea>
      </td>
    </tr>
     <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
	
	<tr style="height: 26px;">
      <td class="" rowspan="1" colspan="10" style="border:0;font-size:13px;"><span class="glyphicon glyphicon-record"></span>已选择的合单订单</td>
    </tr>
    <tr style="height: 26px;">
      <td class="backgroundGray" rowspan="1" colspan="">订单编号</td>
      <td class="backgroundGray" rowspan="1" colspan="">合同编号</td>
      <td class="backgroundGray" rowspan="1" colspan="">收货方</td>
      <td class="backgroundGray" rowspan="1" colspan="">发货地址</td>
      <td class="backgroundGray" rowspan="1" colspan="">发货时间</td>
      <td class="backgroundGray" rowspan="1" colspan="">收货地址</td>
      <td class="backgroundGray" rowspan="1" colspan="">收货时间</td>
      <td class="backgroundGray" rowspan="1" colspan="">总数量</td>
      <td class="backgroundGray" rowspan="1" colspan="">总重量（公斤）</td>
      <td class="backgroundGray" rowspan="1" colspan="">总体积（立方米）</td>
    </tr>
    <tr style="height: 26px; display: none;"  class="" fb-options="{'rowid':'MinPrice','initialRows':'','maxrows':'','content':''}" rowid="OrderContains">
      <td class="" rowspan="1" colspan="">
      <input type="text" disabled placeholder="点击进行订单选择" style="cursor:pointer;" title="订单编号" oc="dialogue" class="edit form-control transparent" name="code" f-options="{'code':'code','type':'dialogue','etype':'editable','len':'8','cls':'frame','url':'LongCitySelector.aspx','vals':'orderid=id,weight=Weight,volume=Volume,code=Code','modalWindow':'1'}" verify="{'title':'订单编号','length':'8','required':true}">
      <input type="hidden" name="orderid" value="0">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="PactCode" class="edit form-control transparent" readonly f-options="{'code':'PactCode','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="endusername" readonly class="edit form-control transparent" f-options="{'code':'endusername','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="from" readonly class="edit form-control transparent" f-options="{'code':'to','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="Fromtime" readonly class="edit form-control transparent" f-options="{'code':'Fromtime','type':'date','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="to" readonly class="edit form-control transparent" f-options="{'code':'weight','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="Totime" readonly class="edit form-control transparent" f-options="{'code':'Totime','type':'date','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="amount" readonly class="edit form-control transparent" f-options="{'code':'amount','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="weight" readonly class="edit form-control transparent" f-options="{'code':'weight','type':'number','etype':'','len':''}" verify="{'title':'weight','length':'','textarea1':true}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="volume" readonly class="edit form-control transparent" f-options="{'code':'volume','type':'number','etype':'','len':''}" verify="{'title':'volume','length':'','textarea1':true}">
      </td>
    </tr>
    <tr style="height: 26px;"  class="" >
      <td class="" rowspan="1" colspan="7">合计</td>
      <td class="" rowspan="1" colspan="">
        <input name="TotalAmount" readonly class="edit form-control transparent" >
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="TotalWeight" readonly class="edit form-control transparent" >
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="TotalVolume" readonly class="edit form-control transparent" >
      </td>
    </tr>
  </tbody>
 </table>
<!-- 表单结尾 -->
</div>

    <!--通用页尾开始-->
<!--#include file="/Controls/PMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    function _DoPageLoad() {
        initTableForm($('#25ccf24c-9c73-44a5-899b-2565511d81d0'), false, function () {            
          setTimeout( "ifChecked();ifBoxChecked();hoverTips();autoHead();totalOrderData();", 500 );

        });
    }
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        setTimeout('_DoPageLoad()', 300);//初始化固定头部的宽度
    };
	
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script type="text/javascript">
    /*浏览器窗口变化时，固定头部宽度赋值*/
    $(window).resize(function () {
        autoHead();
    });
    /*固定头部宽度赋值*/
    function autoHead() {
        var autoW = $('.formcontainer').width() + 2;//+2是为了解决兼容边框
        $('.tr-fixed').css('width', autoW + 'px');
    }
    </script>
<script src="/assets/request_minify.js"></script>
</body>
</html>