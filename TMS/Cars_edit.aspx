<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>车辆信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="Cars">

<!-- 通用对话框开始-->
<div class="modal fade text-center" id="win-Common-Dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
<!-- 通用对话框开始1-->
    <div class="modal fade text-center" id="CarType_Length" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" style="width:auto;display: inline-block;">
            <div class="modal-content">
                <div class="modal-header" style="padding: 5px 10px;">
				</div>
				<div class="" style="padding:20px;position:relative">
					<div class="content">
					</div>
				</div>
            </div>
        </div>
    </div>
<!-- 通用对话框1结尾 -->
<!--通用头部文件开始-->
<!--#include file="/Controls/TMS/header.aspx"-->
<!--通用头部文件结尾-->

<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
	var __saveNdtCfg = '{"main":{"insertVml":"tms_0036","updateVml":"tms_0037","queryVml":"tms_0038"}}';
</script>
 <table class="FormTable Y_alter FormTable6" style="width:100%;" id="68752aaa-5611-4d16-a7a4-3195afc8dfc7" path="OTMS/anwduhsv" code="anwduhsv">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col class="" style="width: 120px;">
    <col style="width:120px;">
  </colgroup>
  <tbody class="Car">
    <tr>
      <td class="text-left" rowspan="1" colspan="3" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">车辆信息</p></div></td>
      <td colspan="3" style="border:0; border-bottom:1px solid #e1e6eb;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <!--<a class="btn btn-red footKeepBtn" href="javascript:void(0);" ev="%23saveNDT%23">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>-->
            <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#68752aaa-5611-4d16-a7a4-3195afc8dfc7'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
            <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
    <tr>
      <td rowspan="1" colspan="6" style="background-color:white; border:0;height:15px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">车牌号<span class="need_write">*</span></td>
      <td class="">
        <input name="SN" title="车牌号" oc="text" class="edit form-control transparent" f-options="{'code':'SN','type':'text','etype':'editable','len':'50'}" verify="{'title':'车牌号','required':true}">
      </td>
      <td class="td_name"><a style="display:block" href="javascript:showCarType_length(this)">车型(点击选择车型)<span class="need_write">*</span></a></td>
      <td class="" colspan="3">
          <input type="hidden" name="CarType" readonly value="0" class="edit form-control transparent">
          <input type="text"  name="CarTypeName" readonly class="edit form-control transparent" verify="{'title':'车型','required':true}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">规格/车长</td>
      <td class="">
        <input type="text" name="CarLengthName" readonly class="edit form-control transparent">
        <input type="hidden" name="CarLength" readonly class="edit form-control transparent">
      </td>
      <td class="td_name">载重（吨）</td>
      <td class="" colspan="3">
        <input name="Weight" title="载重" readonly oc="number" class="edit form-control transparent" f-options="{'code':'Weight','type':'number','etype':'editable','len':''}" verify="{}">
      </td>
    </tr>
	<tr style="height: 26px;">
      <td class="td_name">容积（立方米）</td>
      <td class="" colspan="5">
        <input type="text" name="Volume" readonly class="edit form-control transparent">
      </td>      
    </tr>
    <tr>
        <td class="td_name">座位数/个</td>
      <td class="">
        <input name="Seats" title="座位数" oc="number" class="edit form-control transparent" f-options="{'code':'Seats','type':'number','etype':'editable','len':''}" verify="{}">
      </td>
      <td class="td_name">购入时间<span class="need_write">*</span></td>
      <td class="" colspan="3">
        <input name="PurchaseTime" title="购入日期" oc="date" class="laydate-icon edit" onclick="TrigerDateEvent(this, { format: 'YYYY-MM-DD' })" f-options="{'code':'PurchaseTime','type':'date','etype':'editable','len':''}" verify="{'title':'购入时间','required':true}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">保险时间<span class="need_write">*</span></td>
      <td class="">
        <input name="Insurance" title="保险日期" oc="date" class="laydate-icon edit" onclick="TrigerDateEvent(this,{format: 'YYYY-MM-DD'})" f-options="{'code':'Insurance','type':'date','etype':'editable','len':''}" verify="{'title':'保险时间','required':true}">
      </td>
      
      <td class="td_name">车辆品牌<span class="need_write">*</span></td>
      <td class="" colspan="3">
        <input name="Brand" title="车辆品牌" oc="text" class="edit form-control transparent" f-options="{'code':'Brand','type':'text','etype':'editable','len':'50'}" verify="{'title':'品牌','required':true}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name" rowspan="14" rowspan="1" >车辆图片</td>
      <td rowspan="14" colspan="5" style="height:338px;">
        <input type="file" title="车辆照片" oc="image" class="edit form-control droparea spot" name="Photo" data-post="/ImageUploader.aspx?filename=Photo&mode=droparea" data-width="50" data-height="50" data-crop="true" f-options="{'code':'Photo','type':'image','etype':'editable','len':'300'}" verify="{}">
    </tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
  </tbody>
 </table>
<!-- 表单结尾 -->
</div>

<!--通用页尾开始-->
<!--#include file="/Controls/TMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        setTimeout( "initTableForm($('#68752aaa-5611-4d16-a7a4-3195afc8dfc7'))", 300 );
        setTimeout( "CarTypes( $( 'input[name=\"CarType\"]' ).val() )", 2000 );
    };
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
