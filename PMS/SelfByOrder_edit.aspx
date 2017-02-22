<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>按单报价- <%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="SelfByOrder">

<link href="city/css/cityLayout.css" type="text/css" rel="stylesheet"> 
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
<!-- 通用对话框2开始 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    

                    <h4 class="modal-title text-left" id="myModalLabel">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">发送报价单</p>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    是否确定发送报价单
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                    <button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="NoZero(this)"><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left: 2px;"></span></button>
                    <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left: 2px; color: #888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
<!-- 通用对话框2结尾 -->
<!--通用头部文件开始-->
<!--#include file="/Controls/PMS/header.aspx"-->
<!--通用头部文件结尾-->

<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
    var __saveNdtCfg = '{"main":{"insertVml":"tms_0226","updateVml":"tms_0226","queryVml":"pml_0033"}}';
</script>
 <table class="FormTable Y_alter areaTable" style="width:100%;" id="cf7f9153-cb57-415d-8a41-6a4695b6dd1a" path="Price/iqoicoqa" code="iqoicoqa">
  <colgroup>
    <col style="width: 72px;">
    <col style="width: 72px;">
    <col style="width: 72px;">
    <col style="width: 72px;">
    <col class="" style="width: 72px;">
    <col style="width:72px;">
    <col style="width:72px;">
    <col style="width:72px;">
    <col style="width:72px;">
    <col style="width:72px;">
    <col style="width:72px;">
  </colgroup>
  <tbody>
    <tr class="td-container tr-fixed">
      <td class="text-left" rowspan="1" colspan="4" style="font-size: 14px; border: 0; border-bottom: 1px solid #e1e6eb; padding-right: 0; padding-left: 0;width:100% !important">
      <div style="padding-top:20px;" >
              <div style="padding-left: 3px; background-color: #f27302;">
                  <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">按单报价</p>
              </div>
          </div>
      </td>
      
      <td colspan="6" style="border: 0;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <a class="btn btn-red footKeepBtn" href="javascript:void(0);" onclick="NoZero(this)"  >保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>
            <a class="btn btn-red footKeepBtn sendBtn" href="javascript:void(0);" title="发送报价单" onclick="IsSend()">发送&nbsp;<span class="glyphicon glyphicon-send"></span></a>
            <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#cf7f9153-cb57-415d-8a41-6a4695b6dd1a'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
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
      <td class="td_name">单据编号</td>
      <td class="" rowspan="1" colspan="2">
          <input name="Code" title="" oc="text" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Code','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
      <td class="td_name">制单日期</td>
      <td class="" rowspan="1" colspan="2">
          <input name="CreateTime" title="制单日期" style="font-size:12px;" placeholder="系统自动生成" oc="date" disabled class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'CreateTime','type':'date','etype':'editable','len':'50'}" verify="">
          <input type="hidden"  name="DocID" value=0>    <!--报价单ID-->
          <input type="hidden"  name="Issend"  id="Issend"/>     <!--1:发送 0保存-->
          <input type="hidden"  name="Type" value="1">
          <input type="hidden" name="OrderID" value=0 >
          <input type="hidden" name="Name" value=0 >        <!--报价单名称-->
          <input type="hidden" name="CustomerID" value="0"/>
      </td>
      <td class="td_name">制单人</td>
      <td class="" rowspan="1" colspan="3">
          <input name="Creator" title="制单人" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'Creator','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name" style="background-color: rgb(242, 242, 242);">
             合同编号
      </td>
      <td class="" rowspan="1" colspan="9">
         <input name="PactCode" readonly class="edit form-control transparent" f-options="{'code':'PactCode','type':'text','etype':'editable','len':'50'}" >
      </td>
    </tr>
     <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name" style="background-color: rgb(242, 242, 242);">
             发货方
      </td>
      <td class="" rowspan="1" colspan="2">
         <input name="CustomerName" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'CustomerName','length':'50','required':true}">
      </td>
      <td class="td_name" style="background-color: rgb(242, 242, 242);">是否提货</td>
      <td class="yesorno" rowspan="1" colspan="2">
        <input type="hidden"  name="IsPick" >
         <input name="PickName" readonly class="edit form-control transparent" f-options="{'code':'PickName','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
      <td class="td_name">是否装货</td>
      <td class="yesorno" rowspan="1" colspan="3">
          <input type="hidden"  name="IsOnLoad" >
          <input name="OnLoadName" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'OnLoadName','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">收货方</td>
      <td class="" rowspan="1" colspan="2">
          <input name="EndUserName" class="writeInput"  readonly placeholder="" class="edit form-control transparent" f-options="{'code':'EndUserName','type':'text','etype':'editable','len':'50'}" verify="{'title':'收货方','length':'50','required':true}">
      </td>
      <td class="td_name" style="background-color: rgb(242, 242, 242);">是否送货</td>
      <td class="yesorno" rowspan="1" colspan="2">
         <input type="hidden" name="IsDelivery" >
         <input name="DeliveryName" readonly class="edit form-control transparent" f-options="{'code':'DeliveryName','type':'text','etype':'editable','len':'50'}" verify="">
      </td>
      <td class="td_name">是否卸货</td>
      <td class="yesorno" rowspan="1" colspan="3">
          <input type="hidden" name="IsOffLoad" >
          <input name="OffLoadName" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'OffLoadName','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
     <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
     <tr>
        <td class="td_name">发货省</td>
        <td class="" colspan="2">
            <input name="FromProvince" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'FromProvince','type':'text','etype':'editable','len':'100'}" verify="{}">
        </td>
        <td class="td_name">发货市</td>
        <td colspan="2">
          <input name="FromCity" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'FromCity','type':'text','etype':'editable','len':'100'}" verify="{}">
        </td>
        <td class="td_name">发货区</td>
        <td colspan="3">
          <input name="FromDistrict" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'FromDistrict','type':'text','etype':'editable','len':'100'}" verify="{}">
        </td>
    </tr>
    <tr style="height: 26px;">
        <td class="td_name">到货省</td>
        <td class="" colspan="2">
          <input name="ToProvince" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'editable','len':'100'}" verify="{}">
        </td>
        <td class="td_name">到货市</td>
        <td colspan="2">
           <input name="ToCity" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'editable','len':'100'}" verify="{}">
        </td>
        <td class="td_name">到货区</td>
        <td colspan="3">
          <input name="ToDistrict" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'editable','len':'100'}" verify="{}">
        </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name" style="background-color: rgb(242, 242, 242);">发货地址</td>
      <td class="" rowspan="1" colspan="2">
         <input name="IFrom" readonly class="edit form-control transparent" f-options="{'code':'IFrom','type':'text','etype':'editable','len':'50'}" verify="{'title':'','length':'50','required':true}">
      </td>
      <td class="td_name" style="background-color: rgb(242, 242, 242);">运输模式</td>
      <td class="" rowspan="1" colspan="2">
         <input name="TransportMode" type="hidden" readonly class="edit form-control transparent" f-options="{'code':'TransportMode','type':'text','etype':'editable','len':'50'}" verify="{'title':'TransportMode','length':'50','required':true}">
         <input type="text" readonly name="TransportModeName" class="edit form-control transparent"/>
      </td>
      <td class="td_name" style="background-color: rgb(242, 242, 242);">是否保价</td>
      <td class="yesorno" rowspan="1" colspan="3">
          <input type="hidden" name="IsInsurance" >
         <input name="InsuranceName" readonly class="edit form-control transparent" f-options="{'code':'InsuranceName','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
      
    </tr>
    <tr style="height: 26px;">
          <td class="td_name">收货地址</td>
          <td class="" rowspan="1" colspan="2">
              <input name="ITo" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'ITo','type':'text','etype':'editable','len':'100'}" verify="{}">
          </td>
          <td class="td_name">计费模式</td>
          <td class="" colspan="2">
            <input type="hidden" name="ChargeMode" value="0">
            <select name="ChargeMode_id" disabled  class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);Unit(this)" f-options="{'code':'ChargeMode','type':'combobox','etype':'','len':''}" verify="{'title':'计费模式','length':''}">
              <option value="">-------------------------</option>
              <option value="1">重量</option>
              <option value="2">体积</option>
              <option value="3">数量</option>
            </select>
           </td>
          <td class="td_name">价格单位</td>
           <td class="" colspan="3">
            <input type="hidden" name="PriceUnit" value="0">
            <select name="PriceUnit_id" disabled class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);UnitType(this)" f-options="{'code':'PriceUnit','type':'combobox','etype':'','len':''}" verify="{'title':'价格单位','length':''}">
              <option value="">-------------------------</option>
              <!--#include file="/Controls/Unit.aspx"-->
            </select>
          </td>
      </tr>
     <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">总数量</td>
      <td class="" rowspan="1" colspan="2">
          <input name="TotalAmount" class="writeInput"  readonly placeholder="" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="{'title':'收货方','length':'50','required':true}">
      </td>
      <td class="td_name" style="background-color: rgb(242, 242, 242);">总体积</td>
      <td class="" rowspan="1" colspan="2">
         <input name="TotalVolume" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'','length':'50','required':true}">
      </td>
      <td class="td_name">总重量</td>
      <td class="" rowspan="1" colspan="3">
          <input name="TotalWeight" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
     <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    
    <tr style="height: 26px;">
      <td class="" rowspan="1" colspan="10" style="border:0;font-size:13px;"><span class="glyphicon glyphicon-record"></span>价格</td>
    </tr>
    <tr class="key_down_bottom" style="height: 26px;background-color: rgb(242, 242, 242);">
      <td class="backgroundGray">零担(RMB/元)</td>
      <td class="backgroundGray">整车(RMB/元)</td>
      <td class="backgroundGray">提货(RMB/元)</td>
      <td class="backgroundGray">送货(RMB/元)</td>
      <td class="backgroundGray">装货(RMB/元)</td>
      <td class="backgroundGray">卸货(RMB/元)</td>
      <td class="backgroundGray">附加费(RMB/元)</td>
      <td class="backgroundGray">保险费(RMB/元)</td>
      <td class="backgroundGray">税费(RMB/元)</td>
      <td class="backgroundGray">合计(RMB/元)</td>
    </tr>
    <tr class="CombineOrderPrice" style="height: 26px;">
      <td class="nozero">
        <input name="LessLoadPrice" onkeyup="sumTotalPrice(this)"   class="edit form-control transparent price" f-options="{'code':'LessLoadPrice','type':'number','etype':'','len':''}" verify="{'title':'LessLoadPrice','length':'','textarea1':true}">
      </td>
      <td class="nozero">
        <input name="FullLoadPrice"  onkeyup="sumTotalPrice(this)" class="edit form-control transparent price" f-options="{'code':'FullLoadPrice','type':'number','etype':'','len':''}" verify="{'title':'FullLoadPrice','length':'','textarea1':true}">
      </td>
      <td class="nozero">
        <input name="PickPrice" onkeyup="sumTotalPrice(this)"   class="edit form-control transparent price" f-options="{'code':'PickPrice','type':'number','etype':'','len':''}" verify="{'title':'PickPrice','length':'','textarea1':true}">
      </td>
       <td class="nozero">
        <input name="DeliveryPrice" onkeyup="sumTotalPrice(this)"   class="edit form-control transparent price" f-options="{'code':'DeliveryPrice','type':'number','etype':'','len':''}" verify="{'title':'DeliveryPrice','length':'','textarea1':true}">
      </td>
      <td class="nozero">
        <input name="OnLoadPrice" onkeyup="sumTotalPrice(this)"   class="edit form-control transparent price" f-options="{'code':'OnLoadPrice','type':'number','etype':'','len':''}" verify="{'title':'OnLoadPrice','length':'','textarea1':true}">
      </td>
      <td class="nozero">
        <input name="OffLoadPrice" onkeyup="sumTotalPrice(this)"   class="edit form-control transparent price" f-options="{'code':'OffLoadPrice','type':'number','etype':'','len':''}" verify="{'title':'OffLoadPrice','length':'','textarea1':true}">
      </td>
      <td class="nozero">
        <input name="AdditionPrice" onkeyup="sumTotalPrice(this)"   class="edit form-control transparent price" f-options="{'code':'AdditionPrice','type':'number','etype':'','len':''}" verify="{'title':'AdditionPrice','length':'','textarea1':true}">
      </td>
      <td class="nozero">
        <input name="InsuranceCost" onkeyup="sumTotalPrice(this)"   class="edit form-control transparent price" f-options="{'code':'InsuranceCost','type':'number','etype':'','len':''}" verify="{'title':'InsuranceCost','length':'','textarea1':true}">
      </td>
      <td class="nozero" colspan="">
        <input name="TaxPrice" onkeyup="sumTotalPrice(this)"   class="edit form-control transparent price" f-options="{'code':'TaxPrice','type':'number','etype':'','len':''}" verify="{'title':'TaxPrice','length':'','textarea1':true}">
      </td>
      <td class="nozero"  colspan="">
        <input name="TotalAmounts"  readonly class="edit form-control transparent" f-options="{'code':'TotalAmounts','type':'number','etype':'','len':''}" verify="">
      </td>
    </tr>
     <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    <tr>
        <td class="td_name">备注</td>
        <td colspan="9" style="height:100px;">
          <textarea name="Description" style="line-height: 28px;height:100px;"  class="edit form-control transparent" f-options="{'code':'Description','type':'richtext','etype':'','len':''}" verify="{'title':'Description','length':'','textarea1':true}"></textarea>
        </td>
    </tr>
    <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
	 <tr style="height: 26px;">
		<td class="td_name" colspan="10">报价单跟踪信息</td>
	</tr>                
	<tr class="" name="TrackDetail" style="height: 26px;">
		<td  colspan="10">
			<span name="History"></span>
			<div style="display:none">
				<span name="InsertTime" view-fld='{fld:"InsertTime",method:"show"}'></span>
				<span name="CreatorName" view-fld='{fld:"Creator",method:"show"}'></span>
				<span name="SrcStatusName" view-fld='{fld:"SrcStatus",method:"show"}' ></span>
				<span name="DstStatusName" view-fld='{fld:"DstStatus",method:"show"}'></span>
				<span name="Operation" view-fld='{fld:"Operation",method:"show"}'></span>
				<span name="Descriptions" view-fld='{fld:"description",method:"show"}'></span>
        <span name="CompanyName" view-fld='{fld:"CompanyName",method:"show"}'></span>

			</div>
		</td>
	</tr>

     <tr>
           <td colspan="10" style="border: 0;">
            <input type="hidden" name="id">
            <div class="toolbar">
              <div style="text-align:right;" class="button_workflow">
                <!--<a class="btn btn-red footKeepBtn" href="javascript:void(0);" ev="%23saveNDT%23" onclick="GetCheckboxVal()">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>-->
                <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#cf7f9153-cb57-415d-8a41-6a4695b6dd1a'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
                <%--<a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>--%>
              </div>
              <div class="clear"></div>
              <div class="content_workflow"></div>
            </div>
          </td>
     </tr>
  </tbody>
 </table>
<!-- 表单结尾 -->
</div>
<div class="page"></div>
    <div name="first-ds-pag">
        <div style="text-align:center;display:none">
            <ul class="pag pagination">
                <li class="bord_li prev"><a href="#">
                    <img src="/assets/NSF/images/left.png" /></a>
                </li>
                <li class="bord_li next"><a href="#">
                    <img src="/assets/NSF/images/right.png" /></a>
                </li>
                <li class="bord_li border_li_marg showrec">每页<span class="pagesize"></span>条 ， 共<span class="recamount"></span>条</li>
            </ul>
        </div>
    </div>
<!--通用页尾开始-->
<!--#include file="/Controls/PMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        setTimeout("initTableForm($('#cf7f9153-cb57-415d-8a41-6a4695b6dd1a')),autoHead()", 300);//初始化固定头部的宽度
        setTimeout('rowAdd();SetOrderID();hoverTips();', 2000);
        var _docid = getUrlParam('id');
        //$("input[name='Name']").val( '('+ _docid +')按单报价'  ); //报价单名称

        $('tr[name="TrackDetail"]').attr('view-id', '{ id:"pml_0026",cross:"false", rowIdentClass:"TrackDetail", paras:[{"name":"docid","value":' + _docid + '}]}');
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
        EdtCombPrice_Keydown();
    };

    
    var _jsUrl = "<%=MinifyUrl("FormJs")%>";
    
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/PMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
