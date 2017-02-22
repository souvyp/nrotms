<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>订单接收详情-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--#include file="/Controls/Meta.aspx"-->
    <!--#include file="/Controls/TMS/CSS.aspx"-->
    <link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="OrderAccept">

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
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">接收订单</p>
                    </div>
                </h4>
                </div>
                <div class="modal-body tab_jsjj">
                    <span name="content">是否确定接收订单</span>
                    <input type="hidden" name="Accept" />
                    <input type="hidden" name="OrderID" />
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="OrderAccept()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
    </div>
    <!--通用头部文件开始-->
    <!--#include file="/Controls/TMS/header.aspx"-->
    <!--通用头部文件结尾-->

    <div class="formcontainer" style="display: none;">
        <!-- 表单开始-->
        <script language="javascript">
            var __saveNdtCfg = '{"main":{"insertVml":"tms_0024","updateVml":"tms_0024","queryVml":"tms_0219"},"TMS_OrderGoods":{"insertVml":"tms_0028","updateVml":"tms_0028","queryVml":"tms_0030","deleteVml":"tms_0031"},"TMS_OrderCost":{"insertVml":"","updateVml":"","queryVml":"tms_0077","deleteVml":""}}';
        </script>
        <table class="FormTable Y_alter readForm" style="width: 100%;" id="ef41d4b8-88a5-4954-9d0d-b1dc6a71f860" path="OTMS/eofxvafl" code="eofxvafl">
            <colgroup>
                <col style="width: 109px;">
                <col style="width: 120px;" class="">
                <col style="width: 120px;">
                <col style="width: 120px;">
                <col class="" style="width: 120px;">
                <col style="width: 111px;" class="">
            </colgroup>
            <tbody>
                <tr class="td-container tr-fixed">
                    <td class="text-left" rowspan="1" colspan="4" style="padding-left:0;width:100%;border: 0; border-bottom: 1px solid #e1e6eb;">
                    <div style="padding-top:20px;" >
                            <div style="padding-left: 3px; background-color: #f27302;">
                                <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">订单接收信息</p>
                            </div>
                        </div>
                    </td>
                    
                    <td colspan="4" style="border: 0; border-bottom: 1px solid #e1e6eb;">
                        <input type="hidden" name="id">
                        <div class="toolbar">
                            <div style="text-align: right;" class="button_workflow">
                                <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
                                <a class="btn btn-red footKeepBtn" href="javascript:void(0);" onclick="ReceiveOrder(1, $('input[name=\'id\']').val())">接收&nbsp;<span class="glyphicon glyphicon-ok-circle"></span></a>
								<a class="btn btn-red noBtn" href="javascript:void(0);" onclick="ReceiveOrder(0, $('input[name=\'id\']').val())">拒绝&nbsp;<span class="glyphicon glyphicon-thumbs-down"></span></a>
								<a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
                            </div>
                            <div class="clear"></div>
                            <div class="content_workflow"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 64px;"></td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">单据编号</td>
                    <td class="" colspan="3">
                        <input name="OrderID" type="hidden"/>
                        <input name="Accept" type="hidden" value="1"/>
                        <input name="Code" title="单据编号" oc="text" readonly class="edit form-control transparent" f-options="{'code':'Code','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">合同编号</td>
                    <td class="" colspan="3">
                        <input name="PactCode" title="合同编号" oc="text" readonly class="edit form-control transparent" f-options="{'code':'PactCode','type':'text','etype':'editable','len':'100'}" verify="{}">
                    </td>
                </tr>
                <tr>
                     <td class="td_name">制单日期</td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="CreateTime" title="制单日期" placeholder="系统自动生成" oc="date" disabled class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'CreateTime','type':'date','etype':'editable','len':'50'}" verify="">
                    </td>
                    <td class="td_name">制单人</td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="Creator" title="制单人" oc="text" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Creator','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                
                <tr>
                    <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">客户名称
                    </td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="Name" title="客户名称" readonly oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'32'}" verify="{}">
                    </td>
                    <td class="td_name">是否提货</td>
                    <td class="yesorno" colspan=""> 
                        <input name="IsPick" type="hidden"/>
                        <input type="text" readonly name="IsPickName" class="edit form-control transparent"/>           
                    </td> 
                    <td class="td_name">是否装货</td>
                    <td class="yesorno" colspan="">
                        <input name="IsOnLoad" type="hidden"/>
                        <input type="text" readonly name="IsOnLoadName" class="edit form-control transparent"/>           
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">发货省</td>
                    <td class="" colspan="1">
                        <input type="hidden" class="edit form-control transparent" name="FromProvince_id" readonly f-options="{'code':'FromProvince_id','type':'text','etype':'editable','len':'32'}"/>
                        <input type="text" class="edit form-control transparent" name="FromProvince" readonly f-options="{'code':'FromProvince','type':'text','etype':'editable','len':'32'}"/>
                    </td>
                    <td class="td_name">发货市</td>
                    <td colspan="1">
                        <input type="hidden" class="edit form-control transparent" name="FromCity_id" readonly f-options="{'code':'FromCity_id','type':'text','etype':'editable','len':'32'}">
                        <input type="text" class="edit form-control transparent" name="FromCity" readonly f-options="{'code':'FromCity','type':'text','etype':'editable','len':'32'}">
                    </td>
                    <td class="td_name">发货区</td>
                    <td colspan="3">
                        <input type="hidden" class="edit form-control transparent" name="FromDistrict_id" readonly f-options="{'code':'FromDistrict_id','type':'text','etype':'editable','len':'32'}">
                        <input type="text" class="edit form-control transparent" name="FromDistrict" readonly f-options="{'code':'FromDistrict','type':'text','etype':'editable','len':'32'}">
                    </td>
                </tr>
                 <tr style="height: 26px;">
                    <td class="td_name">发货时间</td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="FromTime" disabled title="发货时间" oc="date" class="laydate-icon edit" onclick="TrigerDateEvent(this, { format: 'YYYY-MM-DD' })" f-options="{'code':'FromTime','type':'date','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">联系电话</td>
                    <td class="">
                        <input name="FromContact" title="发货人联系电话" readonly  oc="text" class="edit form-control transparent" f-options="{'code':'FromContact','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^(13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9])[0-9]{8}$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                    </td>
                    <td class="td_name">发货地址</td>
                    <td class="" rowspan="1" colspan="">
                        <input name="From" title="发货地址" oc="text" readonly="readonly" class="edit form-control transparent" f-options="{'code':'From','type':'text','etype':'editable','len':'600'}" verify="{}">
                    </td>
                </tr>
                 <tr>
                    <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr>
                    <td class="td_name">收货方
                    </td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="EndUserName" class="edit form-control transparent" readonly="readonly" f-options="{'code':'EndUserName','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">是否送货</td>
                    <td class="yesorno" colspan="">   
                        <input name="IsDelivery" type="hidden"/>
                        <input type="text" readonly name="IsDeliveryName" class="edit form-control transparent"/>                        
                    </td>
                    <td class="td_name">是否卸货</td>
                    <td class="yesorno" colspan="">
                        <input name="IsOffLoad" type="hidden"/>
                        <input type="text" readonly name="IsOffLoadName" class="edit form-control transparent"/>                      
                     
                    </td> 
                    
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">到货省</td>
                    <td class="" colspan="1">
                        <input type="hidden" class="edit form-control transparent" name="ToProvince_id" readonly f-options="{'code':'ToProvince_id','type':'text','etype':'editable','len':'32'}">
                        <input type="text" class="edit form-control transparent" name="ToProvince" readonly f-options="{'code':'ToProvince','type':'text','etype':'editable','len':'32'}">
                    </td>
                    <td class="td_name">到货市</td>
                    <td colspan="1">
                        <input type="hidden" class="edit form-control transparent" name="ToCity_id" readonly f-options="{'code':'ToCity_id','type':'text','etype':'editable','len':'32'}">
                        <input type="text" class="edit form-control transparent" name="ToCity" readonly f-options="{'code':'ToCity','type':'text','etype':'editable','len':'32'}">
                    </td>
                    <td class="td_name">到货区</td>
                    <td colspan="3">
                        <input type="hidden" class="edit form-control transparent" name="ToDistrict_id" readonly f-options="{'code':'ToDistrict_id','type':'text','etype':'editable','len':'32'}">
                        <input type="text" class="edit form-control transparent" name="ToDistrict" readonly f-options="{'code':'ToDistrict','type':'text','etype':'editable','len':'32'}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">到货时间</td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="ToTime" disabled title="到货时间" oc="date" class="laydate-icon edit" onclick="TrigerDateEvent(this, { format: 'YYYY-MM-DD' })" f-options="{'code':'ToTime','type':'date','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">联系电话</td>
                    <td class="">
                        <input name="ToContact" title="收货方联系电话"  readonly oc="text" class="edit form-control transparent" f-options="{'code':'ToContact','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^(13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9])[0-9]{8}$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                    </td>
                    <td class="td_name">收货地址</td>
                    <td class="" rowspan="1" colspan="2">
                        <input name="To" title="收货地址" oc="text" readonly="readonly" class="edit form-control transparent" f-options="{'code':'To','type':'text','etype':'editable','len':'600'}" verify="{}">
                    </td>
                </tr>
                <tr>
                    <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">承运方
                    </td>
                    <td class="" rowspan="1" colspan="8">
                        <input name="SupplierName" readonly class="edit form-control transparent" f-options="{'code':'SupplierName','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">计费模式</td>
						<td class="" colspan="3">
							<input type="hidden" name="ChargeMode" value="0">
							<select name="ChargeMode_id" disabled class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);Unit(this)" f-options="{'code':'ChargeMode','type':'combobox','etype':'','len':''}" verify="{'title':'ChargeMode','length':'','textarea1':true}">
								<option value="">-------------------------</option>
								<option value="1">重量</option>
								<option value="2">体积</option>
								<option value="3">数量</option>
							</select>
							</td>
						<td class="td_name">价格单位</td>
						<td class="" colspan="3">
						<input type="hidden" name="PriceUnit" value="0">
						<select name="PriceUnit_id" disabled class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);UnitType(this)" f-options="{'code':'PriceUnit','type':'combobox','etype':'','len':''}" verify="{'title':'PriceUnit','length':'','textarea1':true}">
							<option value="">-------------------------</option>
							<!--#include file="/Controls/Unit.aspx"-->
						</select>
						</td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">运输模式</td>
                    <td class="" colspan="3">
                        <input name="TransportMode" type="hidden"/>
                        <input type="text" readonly name="TransportModeName" class="edit form-control transparent"/>
                    </td>
                    <td class="td_name">货物分类</td>
                    <td class="" rowspan="1" colspan="3">
                        <input type="hidden" name="GoodsCategory" />
                        <input type="text" name="GoodsCategoryName" readonly class="edit form-control transparent">
                        <ul class="list-inline hidden">
                            <li>                                
                                <input disabled type="checkbox" class="control-check" name="Goodscategory" value="1" />普通货物</li>
                            <li>
                                <input type="checkbox" disabled class="control-check" name="Goodscategory" value="2" />危险品</li>
                            <li>
                                <input type="checkbox" disabled class="control-check" name="Goodscategory" value="4" />温控货物</li>
                        </ul>
                    </td>
                </tr>
                 <tr style="height: 26px;" name="CarInfo">
                    <td class="td_name">车型</td>
                    <td class="" colspan="3">
                        <input type="hidden" name="CarType" readonly value="0" class="edit form-control transparent">
                        <input type="text" name="CarTypeName" readonly class="edit form-control transparent">
                    </td>
                    <td class="td_name">规格/车长（米）</td>
                    <td class="" colspan="3">
                        <input type="text" readonly class="edit form-control transparent" name="CarLengthName">
                        <input type="hidden" name="CarLength" readonly class="edit form-control transparent">
                    </td>
                </tr>
				<tr style="height: 26px;" name="CarInfo">
					<td class="td_name">容积（方）</td>
					<td class="" colspan="3">                     
						<input type="text" name="CarVolume" readonly class="edit form-control transparent">
					</td>
					<td class="td_name">载重（吨）</td>
					<td class="" colspan="3">
						<input type="text" name="CarWeight" readonly class="edit form-control transparent">
					</td>
				</tr>
                <tr style="height: 26px;">
                    <td class="td_name">包装方式</td>
                    <td class="" colspan="3">
                        <input name="PackageMode" type="hidden"/>
                        <input type="text" readonly name="PackageModeName" class="edit form-control transparent"/>
                    </td>
                    <td class="td_name">运输方式</td>
                    <td class="" colspan="3">
                        <input name="ShipMode" type="hidden"/>
                        <input type="text" readonly name="ShipModeName" class="edit form-control transparent"/>
                    </td>
                </tr>
                <tr style="height: 26px;">
                      <td class="td_name">是否保价</td>
                      <td class="yesorno" colspan="3">
                        <input name="IsInsurance" type="hidden"/>
                        <input type="text" readonly name="IsInsuranceName" class="edit form-control transparent"/>
                      </td>
                      <td class="td_name">
                           	 客户标记名称
                            <input type="hidden" name="CustomerSymbolID">
                            <input type="hidden" name="CSymbolID" value="1">
                        </td>
                        <td class="" rowspan="1" colspan="3">
                            <input name="CustomerSymbolName" title="客户标记名称" readonly class="writeInput" placeholder="客户标记名称" oc="text" class="edit form-control transparent" f-options="{'code':'CustomerSymbolName','type':'text','etype':'editable','len':'600'}" verify="{'title':'客户标记名称','length':'600','required':true}">
                        </td>   
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">原始单据编号</td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="SrcCode" title="原始单据编号" oc="text" readonly class="edit form-control transparent" f-options="{'code':'SrcCode','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">物品总价值（元）</td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="GoodsValue" title="物品总价值" oc="text" readonly class="edit form-control transparent" f-options="{'code':'GoodsValue','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr>
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr>
                	<td class="td_name">设备编号</td>
                	<td class="" colspan="8">
                		<input name="DeviceCode" title="设备编号" oc="text" readonly class="edit form-control transparent" f-options="{'code':'DeviceCode','type':'text','etype':'editable','len':'50'}" verify="{}">
                	</td>
                </tr>
                <tr>
                    <td class="td_name">
                        预付款
                    </td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="Payment" title="预付款"  class="writeInput" readonly placeholder="" oc="text" class="edit form-control transparent data" f-options="{'code':'Payment','type':'text','etype':'editable','len':'600'}" verify="{'title':'预付款','length':'600'}">
                    </td>
                    <td class="td_name" colspan="1">货到付款</td>
                    <td colspan="4">
                        <input name="Payable" readonly   class="edit form-control transparent data" f-options="{'code':'Payable','type':'richtext','etype':'','len':''}" verify="{'title':'货到付款','length':'','textarea1':true}"></input>
                    </td>                    
                </tr>
                <tr style="height:26px;">
                    <td class="td_name">
                       	 备注
                    </td>
                    <td colspan="9">
                        <textarea style="line-height:28px;" name="Descriptions"  readonly class="edit form-control transparent" f-options="{'code':'Descriptions','type':'richtext','etype':'','len':''}" verify="{'title':'Descriptions','length':'','textarea1':true}"></textarea>
                  </td>
                </tr>
                
                <tr>
                    <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;" class="" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="">物品编号</td>
                    <td class="td_name" colspan="2">物品名称</td>
                    <td class="td_name">规格</td>
                    <td class="td_name" colspan="">物品数量</td>
                    <td class="td_name">总重量（公斤）</td>
                    <td class="td_name">总体积（立方米）</td>
					<td class="td_name">批次</td>
                </tr>
                <tr style="height: 26px; display: none;" class="" fb-options="{'rowid':'TMS_OrderGoods','initialRows':'1','maxrows':'10','content':''}" rowid="TMS_OrderGoods">
                    <td colspan="">
                        <input type="text" title="物品编号" oc="dialogue" class="edit form-control transparent" name="GoodsID" f-options="{'code':'id','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'../GoodsSelector.aspx','vals':'GoodsID=id','modalWindow':'1'}" verify="{}">
                    </td>
                    <td class="" colspan="2">
                        <input name="Name" title="物品名称" readonly oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td>
                        <input name="SPC" title="规格" readonly oc="text" class="edit form-control transparent" f-options="{'code':'SPC','type':'text','etype':'editable','len':'50'}" verify="{'title':'SPC','length':'50','required':true}">
                    </td>
                    <td class="" colspan="">
                        <input name="Qty" title="物品数量" readonly oc="number" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{}">
                    </td>
                    <td class="">
                        <input name="Weight" title="重量" readonly oc="number" class="edit form-control transparent" f-options="{'code':'Weight','type':'number','etype':'editable','len':''}" verify="{}">
                    </td>
                    <td>
                        <input name="Volume" title="体积" readonly oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{}">
                    </td>
					<td class="">
						<input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
					</td>
                </tr>
                <tr style="height: 26px;display: none" class="addition">
                      <td class=""  colspan="5">补差</td>
                      <td class="" rowspan="1" colspan="">
                            <input name="WeightAddition"   title="重量补差" oc="text" class="edit form-control transparent" f-options="{'code':'WeightAddition','type':'number','etype':'editable','len':''}" verify="{'title':'WeightAddition','number':true,'required':true}">
                      </td>
                      <td class="" colspan="">
                           <input name="VolumeAddition"   title="体积补差" oc="text" class="edit form-control transparent" f-options="{'code':'VolumeAddition','type':'number','etype':'editable','len':''}" verify="{'title':'VolumeAddition','number':true,'required':true}">
                      </td>
					  <td></td>
                </tr>
                <tr   style="height: 26px;" class="" >
                    <td colspan="4" class="">
                      合计
                    </td>
                    <td >
                        <input name="TotalQty" title="总数量" readonly oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Qty%5D%7D%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%284%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
                    </td>
                     <td>
                      <input name="TotalWeight" title="总重量" readonly oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Weight%5D%7D%3Bvar%20WeightAddition%3D%24%28%27input%5Bname%3D%22WeightAddition%22%5D%27%29.val%28%29%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%20if%28WeightAddition%3D%3D%27%27%29%7B%20sum+%3DparseFloat%28arr%5Bi%5D%29%3B%7Delse%7B%20%20if%28i%3D%3D0%29%20%7B%20sum%20+%3D%20parseFloat%28WeightAddition%29%3B%20%7D%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%284%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'calculation','len':'50'}" verify="">
                    </td>
                    <td>
                      <input name="TotalVolume" title="总体积" readonly oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Volume%5D%7D%3Bvar%20VolumeAddition%3D%24%28%27input%5Bname%3D%22VolumeAddition%22%5D%27%29.val%28%29%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%20if%28VolumeAddition%3D%3D%27%27%29%7B%20sum+%3DparseFloat%28arr%5Bi%5D%29%3B%7Delse%7B%20%20if%28i%3D%3D0%29%20%7B%20sum%20+%3D%20parseFloat%28VolumeAddition%29%3B%20%7D%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%284%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
                    </td>
                    
                     <td >
                    </td>
                  </tr>
                <tr>
                    <td rowspan="1" colspan="9" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name" colspan="9">订单跟踪信息</td>
                </tr>                
                <tr class="" name="TrackDetail" style="height: 26px;">
                    <td  colspan="9">
                        <span name="History"></span>
                        <div style="display:none">
                            <span name="InsertTime" view-fld='{fld:"InsertTime",method:"show"}'></span>
                            <span name="CreatorName" view-fld='{fld:"CreatorName",method:"show"}'></span>
                            <span name="SrcStatusName" view-fld='{fld:"SrcStatusName",method:"show"}' ></span>
                            <span name="DstStatusName" view-fld='{fld:"DstStatusName",method:"show"}'></span>
                            <span name="Operation" view-fld='{fld:"Operation",method:"show"}'></span>
                            <span name="Description" view-fld='{fld:"Description",method:"show"}'></span>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <!-- 表单结尾 -->
    </div>

    <!--通用页尾开始-->
    <!--#include file="/Controls/TMS/footer.aspx"-->
    <!--通用页尾结尾-->

    <script type="text/javascript">
        function _DoPageLoad()
        {
            initTableForm( $( '#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860' ), false, function ()
            {
                setTimeout( 'GoodsCategory();status_list();CarTypes( $( \'input[name="CarType"]\' ).val() );YesORno();PackageMode();ShipModeName();TransportMode();Sum();', 300 );
                ifChecked();
                ifBoxChecked();
                //console.log( $( 'input[name="Description"]' ).val() ); 
            } );
        }
        var reqeustDone = function ()
        {		/*所有JS加载完成以后执行*/
            if ( typeof ( initHeader ) != "undefined" ) initHeader();					/*初始化页面通用头部*/
            if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/
            setTimeout('_DoPageLoad(),autoHead()', 300);//初始化固定头部的宽度
            setTimeout("hoverTips();", 1800);  /*input的tips*/
        }
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
            var autoW = $('.formcontainer').width() +2;//+2是为了解决兼容边框
            $('.tr-fixed').css('width', autoW + 'px');
        }
    </script>
    <script src="/assets/request_minify.js"></script>
</body>
</html>
