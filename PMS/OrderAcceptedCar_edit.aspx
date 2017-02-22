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
        

    </style>
</head>
<body code="DocCombined">

<link href="city/css/cityLayout.css" type="text/css" rel="stylesheet">
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

<!--通用头部文件开始-->
<!--#include file="/Controls/PMS/header.aspx"-->

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
    <tr>
        <td class="text-left" rowspan="1" colspan="3" style="font-size: 14px; border: 0; border-bottom: 1px solid #e1e6eb; padding-right: 0; padding-left: 0;">
        <div style="padding-left: 3px; background-color: #f27302;">
            <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">合单信息</p>
        </div>
        </td>
      <td colspan="4" style="border:0;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
     <tr>
        <td rowspan="1" colspan="7" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="" style="background-color: rgb(242, 242, 242);">合同编号</td>
      <td class="" rowspan="1" colspan="">
         <input name="PactCode" readonly class="edit form-control transparent"  f-options="{'code':'PactCode','type':'text','etype':'editable','len':'100'}" verify="{'title':'合同编号','length':'100','required':true}">
            <input type="hidden" name="OrderID" value="0">
            <input type="hidden" name="OrdersLst" value="0">
            <input type="hidden" name="ShipMode" value="0">
      </td>
       <td class="" style="background-color: rgb(242, 242, 242);">          
                <input type="hidden" name="SupplierID">承运方
            </a>
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="SupplierName" placeholder="点击“承运方”进行选择" title="点击承运方进行选择" class="edit form-control transparent" readonly="readonly" f-options="{'code':'SupplierName','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
      <td class="" style="background-color: rgb(242, 242, 242);">制单时间</td>
      <td rowspan="1" colspan="2">
         <input name="CreateTime" readonly  class="edit form-control transparent" readonly="readonly" f-options="{'code':'CreateTime','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
    </tr>
     <tr>
        <td rowspan="1" colspan="7" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
	
	<tr style="height: 26px;">
      <td class="" rowspan="1" colspan="7" style="border:0;font-size:13px;"><span class="glyphicon glyphicon-record"></span>已选择的合单订单</td>
    </tr>
    <tr style="height: 26px;">
      <td class="backgroundGray" rowspan="1" colspan="">订单编号</td>
      <td class="backgroundGray" rowspan="1" colspan="">收货方</td>
      <td class="backgroundGray" rowspan="1" colspan="">发货地址</td>
      <td class="backgroundGray" rowspan="1" colspan="">收货地址</td>
      <td class="backgroundGray" rowspan="1" colspan="">总数量</td>
      <td class="backgroundGray" rowspan="1" colspan="">总重量（公斤）</td>
      <td class="backgroundGray" rowspan="1" colspan="">总体积（立方米）</td>
    </tr>
    <tr style="height: 26px; display: none;"  class="" fb-options="{'rowid':'MinPrice','initialRows':'','maxrows':'','content':''}" rowid="OrderContains">
      <td class="" rowspan="1" colspan="">
      <input type="text" disabled placeholder="点击进行订单选择" style="cursor:pointer;"  title="订单编号" oc="dialogue" class="edit form-control transparent" name="code" f-options="{'code':'code','type':'dialogue','etype':'editable','len':'8','cls':'frame','url':'LongCitySelector.aspx','vals':'orderid=id,weight=Weight,volume=Volume,code=Code','modalWindow':'1'}" verify="{'title':'订单编号','length':'8','required':true}">
      <input type="hidden" name="orderid" value="0">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="endusername" readonly class="edit form-control transparent" f-options="{'code':'endusername','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="from" readonly class="edit form-control transparent" f-options="{'code':'to','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="to" readonly class="edit form-control transparent" f-options="{'code':'weight','type':'number','etype':'','len':''}" verify="{}">
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
  </tbody>
 </table>
<!-- 表单结尾 -->
</div>

    <!--通用页尾开始-->
<!--#include file="/Controls/PMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        setTimeout("initTableForm($('#25ccf24c-9c73-44a5-899b-2565511d81d0'))", 300);
    };
	
  

	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/PMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>