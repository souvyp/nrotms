<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>订单价格-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--#include file="/Controls/Meta.aspx"-->
	<link href="/pms/city/css/cityLayout.css" type="text/css" rel="stylesheet">
    <!--#include file="/Controls/TMS/CSS.aspx"-->
    <link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="OrderPrice">

    <style type="text/css">
        .jptable tr:hover {
            background-color: transparent !important;
        }

        .add_place {
            margin-left: 10px;
        }

        .jptable tr td {
            width: 8.33%;
            text-align: left;
        }

            .jptable tr td .btn {
                border: 1px solid #ddd;
                height: 32px;
                color: #888;
                background-color: #eee;
                margin: 0;
                padding: 8px 16px;
            }

                .jptable tr td .btn:hover {
                    background-color: white;
                }

        .hoverH4 {
            text-align: center;
        }

            .hoverH4 a:hover {
                color: #008fbf !important;
            }
    </style>

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

    <!--通用头部文件开始-->
    <!--#include file="/Controls/TMS/header.aspx"-->
    <!--通用头部文件结尾-->

    <!-- 模板开始-->
    <%--<script id="jplist-template" type="text/x-template">--%>
    <div class="formcontainer" style="display: none;">
        <!-- 表单开始-->
        <script language="javascript">
            var __saveNdtCfg = '{"main":{"insertVml":"","updateVml":"","queryVml":"tms_0027"},"TMS_OrderGoods":{"insertVml":"tms_0028","updateVml":"tms_0028","queryVml":"tms_0030","deleteVml":"tms_0031"}}';
        </script>
        <table class="FormTable Y_alter FormTable6 readForm" style="width: 100%;" id="ef41d4b8-88a5-4954-9d0d-b1dc6a71f860" path="OTMS/OrderPrice" code="OrderPrice">
            <colgroup>
                <col style="width: 109px;">
                <col style="width: 120px;" class="">
                <col style="width: 120px;">
                <col style="width: 120px;">
                <col class="" style="width: 120px;">
                <col style="width: 111px;" class="">
				<col style="width: 109px;">
            </colgroup>
            <tbody>
                <tr class="td-container tr-fixed">
                    <td class="text-left" rowspan="1" colspan="4" style="font-size: 14px; border: 0; border-bottom: 1px solid #e1e6eb; padding-right: 0; padding-left: 0;width:100% !important">
                    <div style="padding-top:20px;" >
                            <div style="padding-left: 3px; background-color: #f27302;">
                                <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">订单价格</p>
                            </div>
                        </div>
                    </td>
                    
                    <td colspan="5" style="border: 0; border-bottom: 1px solid #e1e6eb;width:100%;">
                        <input type="hidden" name="id">
                        <div class="toolbar">
                            <div style="text-align: right;" class="button_workflow">
                                <%--<a class="btn btn-red" href="javascript:void(0);" ev="%23saveNDT%23" onclick="GetCheckboxVal()">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>--%>
                                <a class="btn btn-default footKeepBtn" href="javascript:void(0);" onclick="skiptoprintcost()">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>
                                <a class="btn btn-red" href="javascript:void(0);" onclick="window.close();" >关闭&nbsp;<span class="glyphicon glyphicon-remove"></span></a>
                            </div>
                            <div class="clear"></div>
                            <div class="content_workflow"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 64px;"></td>
                </tr>
                <tr style="height: 26px; display: none">
                    <td class="styleCenter td_name" rowspan="1" style="font-size: 18px;">
                        <input name="OrderID" title="订单编号" oc="text" class="edit form-control transparent" value="0" f-options="{'code':'OrderID','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">单据编号</td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="Code" title="单据编号" oc="text" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Code','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">合同编号</td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="PactCode" title="合同编号" readonly oc="text" class="edit form-control transparent" f-options="{'code':'PactCode','type':'text','etype':'editable','len':'50'}" verify="{'title':'PactCode','length':'50','required':true}">
                    </td>
                </tr>
                <tr>
                    <td class="td_name">制单日期</td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="CreateTime" title="制单日期" placeholder="系统自动生成" oc="date"  disabled class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'CreateTime','type':'date','etype':'editable','len':'50'}" verify="">
                    </td>
                    <td class="td_name">制单人</td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="Creator" title="制单人" oc="text" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Creator','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                
                <tr>
                    <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">客户名称</a>
                    </td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="Name" readonly class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'50'}" verify="{'title':'Name','length':'50','required':true}">
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

                <tr>
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
                <tr>
                    <td class="td_name">发货时间</td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="FromTime" title="发货时间" disabled oc="date" class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'FromTime','type':'date','etype':'editable','len':'50'}" verify="{'title':'FromTime','length':'50','required':true}">
                    </td>
                    <td class="td_name">联系电话</td>
                    <td class="">
                        <input name="FromContact" title="发货人联系电话" readonly  oc="text" class="edit form-control transparent" f-options="{'code':'FromContact','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^(13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9])[0-9]{8}$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                    </td>
                    <td class="td_name">
						发货地址
                    </td>
                    <td class="" rowspan="1" colspan="">
                        <input name="From" title="发货地址" readonly oc="text" class="edit form-control transparent" f-options="{'code':'From','type':'text','etype':'editable','len':'32'}" verify="{'title':'From','length':'50','required':true}">
                    </td>
                </tr>
                <tr>
                    <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">
						收货方
                    </td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="EndUserName" readonly class="edit form-control transparent" f-options="{'code':'EndUserName','type':'text','etype':'editable','len':'50'}" verify="{'title':'EndUserName','length':'50','required':true}">
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
                        <input name="ToTime" title="到货时间" oc="date" disabled class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'ToTime','type':'date','etype':'editable','len':'50'}" verify="{'title':'ToTime','length':'50','required':true}">
                    </td>
                    <td class="td_name">联系电话</td>
                    <td class="">
                        <input name="ToContact" title="收货方联系电话"  readonly oc="text" class="edit form-control transparent" f-options="{'code':'ToContact','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^(13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9])[0-9]{8}$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                    </td>
                    <td class="td_name">
						收货地址
                    </td>
                    <td class="" rowspan="1" colspan="">
                        <input name="To" title="收货地址" oc="text" readonly class="edit form-control transparent" f-options="{'code':'To','type':'text','etype':'editable','len':'32'}" verify="{'title':'To','length':'50','required':true}">
                    </td>
                </tr>

                <tr>
                    <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
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
                <tr style="height: 26px;display:none" name="CarInfo">
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
                <tr style="height:26px;">
                    <td class="td_name">
                        	设备编号
                    </td>
                    <td colspan="9">
                        <textarea style="line-height:28px;" name="DeviceCode"  readonly class="edit form-control transparent" f-options="{'code':'DeviceCode','type':'richtext','etype':'','len':''}" verify="{'title':'DeviceCode','length':'','textarea1':true}"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="td_name">
                        预付款
                    </td>
                    <td class="" rowspan="1" colspan="3">
                        <input name="Payment" title="预付款" readonly  class="writeInput" placeholder="" oc="text" class="edit form-control transparent data" f-options="{'code':'Payment','type':'text','etype':'editable','len':'600'}" verify="{'title':'预付款','length':'600'}">
                    </td>
                    <td class="td_name" colspan="1">货到付款</td>
                    <td colspan="4">
                        <input name="Payable" readonly  class="edit form-control transparent data" f-options="{'code':'Payable','type':'richtext','etype':'','len':''}" verify="{'title':'货到付款','length':'','textarea1':true}"></input>
                    </td>                    
                </tr>
                <tr>
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
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
                    <td class="td_name" colspan="" >物品编号</td>
                    <td class="td_name" colspan="1" >物品名称</td>
                    <td class="td_name">规格</td>
                    <td class="td_name" >总重量（公斤）</td>
                    <td class="td_name" >总体积（立方米）</td>
                    <td class="td_name">物品数量</td>
					<td class="td_name" colspan="2">批次</td>
					
                </tr>
                <tr   style="height: 26px;display:none" class="" fb-options="{'rowid':'TMS_OrderGoods','initialRows':'1','maxrows':'10','content':''}" rowid="TMS_OrderGoods">
                    <td colspan="">
                        <input type="text"  readonly title="物品编号" oc="dialogue" class="edit form-control transparent" name="GoodsID" f-options="{'code':'GoodsID','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'GoodsSelector.aspx','vals':'GoodsID=id,Name=Name,SPC=SPC,Weight=Weight,Volume=Volume,weight=Weight,volume=Volume','modalWindow':'1'}" verify="{'title':'GoodsID','length':'50','required':true}">
                    </td>
                    <td colspan="">
                        <input name="Name" readonly title="物品名称" oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'50'}" verify="{'title':'Name','length':'50','required':true}">
                    </td>
                    <td>
                        <input name="SPC" readonly title="规格" oc="text" class="edit form-control transparent" f-options="{'code':'SPC','type':'text','etype':'editable','len':'50'}" verify="{'title':'SPC','length':'50','required':true}">
                    </td>
                    <td class="" colspan="">
                        <input name="Weight" readonly="readonly"   title="重量" oc="number" class="edit form-control transparent" f-options="{'code':'Weight','type':'number','etype':'editable','len':''}" verify="{'title':'重量','number':true}">
                        <input name="weight" type="hidden" />
                    </td>
                    <td colspan="">
                        <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                        <input name="volume" type="hidden" />
                    </td>
                    <td class="" colspan="">
                        <input name="Qty" onkeyup="Calculator(this)" readonly  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                    </td>
					<td class="" colspan="2">
						<input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
					</td>
                </tr>
                <tr style="height: 26px;display: none" class="addition">
                      <td class="td_name"  colspan="3">补差</td>
                      <td class="" rowspan="1" colspan="">
                            <input name="WeightAddition" style="cursor:text !important;"   title="重量补差" oc="text" class="edit form-control transparent" f-options="{'code':'WeightAddition','type':'number','etype':'editable','len':''}" verify="{'title':'WeightAddition','number':true,'required':true}">
                      </td>
                      <td class="" colspan="">
                           <input name="VolumeAddition" style="cursor:text !important;"   title="体积补差" oc="text" class="edit form-control transparent" f-options="{'code':'VolumeAddition','type':'number','etype':'editable','len':''}" verify="{'title':'VolumeAddition','number':true,'required':true}">
                      </td>
                      <td ></td>
                      <td colspan="2" ></td>
                </tr>
                <tr   style="height: 26px;" class="" >
                    <td colspan="3" class="">
                      合计
                    </td>
                    
                     <td>
                      <input name="TotalWeight" title="总重量" readonly oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Weight%5D%7D%3Bvar%20WeightAddition%3D%24%28%27input%5Bname%3D%22WeightAddition%22%5D%27%29.val%28%29%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%20if%28WeightAddition%3D%3D%27%27%29%7B%20sum+%3DparseFloat%28arr%5Bi%5D%29%3B%7Delse%7B%20%20if%28i%3D%3D0%29%20%7B%20sum%20+%3D%20parseFloat%28WeightAddition%29%3B%20%7D%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%284%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'calculation','len':'50'}" verify="">
                    </td>
                    <td>
                      <input name="TotalVolume" title="总体积" readonly oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Volume%5D%7D%3Bvar%20VolumeAddition%3D%24%28%27input%5Bname%3D%22VolumeAddition%22%5D%27%29.val%28%29%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%20if%28VolumeAddition%3D%3D%27%27%29%7B%20sum+%3DparseFloat%28arr%5Bi%5D%29%3B%7Delse%7B%20%20if%28i%3D%3D0%29%20%7B%20sum%20+%3D%20parseFloat%28VolumeAddition%29%3B%20%7D%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%284%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
                    </td>
                    <td >
                        <input name="TotalQty" title="总数量" readonly oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Qty%5D%7D%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%284%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
                    </td>
                     <td colspan="2" >
                    </td>
                  </tr>
                <tr>
                    <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
            </tbody>
            <tbody>
                    <tr>
                        <td colspan="10" style="padding:0px">
                            <a data-toggle="collapse" id="accordion" data-parent="#accordion" href="#collapseOne" style="font-family: '微软雅黑'; color: #888; font; font-size: 14px;">
                                <div class="panel panel-default" style="border-radius:0;box-shadow:none;border:none;">
                                    <div class="" style="background-color: transparent; padding: 10px; margin-bottom: -15px; border-bottom: 0px solid #eee;">
                                        <h4 class="panel-title hoverH4" style="font-family:'微软雅黑';color:#0099CC;">查看费用详情<span class="glyphicon glyphicon-menu-down" style="position:relative;top:2px;left:5px;"></span><span class="glyphicon glyphicon-menu-up" style="position:relative;top:2px;left:5px;display:none;"></span>
                                        </h4>
                                    </div>
                                </div>
                            </a>
                        </td>
                    </tr>
                </tbody>
                <tbody class="hide costdetail">
                    <tr>
                        <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                    </tr>
                    <!--零担-->
                    <tr style="height: 26px;" class="PMS_LessLoad hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                        <td class="td_name" colspan="3" >报价单号(零担)</td>
                        <td class="td_name" colspan="3" >报价公司(零担)</td>
                        <td class="td_name" colspan="2">价格(零担)</td>
                    </tr>
                    <tr   style="height: 26px;" class="PMS_LessLoad hide" fb-options="{'rowid':'PMS_LessLoad','initialRows':'1','maxrows':'10','content':''}" nrowid="PMS_LessLoad">
                        <td colspan="3">
                            <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                            <input name="volume" type="hidden" />
                        </td>
                        <td class="" colspan="3">
                            <input name="Qty" onkeyup="Calculator(this)" readonly  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                        </td>
                        <td class="" colspan="2">
                            <input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
                        </td>
                    </tr>
                    <tr class="PMS_FullLoad hide">
                        <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                    </tr>
                    <!--整车-->
                    <tr style="height: 26px;" class="PMS_FullLoad hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                        <td class="td_name" colspan="3" >报价单号(整车)</td>
                        <td class="td_name" colspan="3" >报价公司(整车)</td>
                        <td class="td_name" colspan="2">价格(整车)</td>
                    </tr>
                    <tr   style="height: 26px;" class="PMS_FullLoad hide" fb-options="{'rowid':'PMS_FullLoad','initialRows':'1','maxrows':'10','content':''}" nrowid="PMS_FullLoad">
                        <td colspan="3">
                            <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                            <input name="volume" type="hidden" />
                        </td>
                        <td class="" colspan="3">
                            <input name="Qty" onkeyup="Calculator(this)" readonly  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                        </td>
                        <td class="" colspan="2">
                            <input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
                        </td>
                    </tr>
                    <tr class="CityPickPrice hide">
                        <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                    </tr>
                    <!--提货费-->
                    <tr style="height: 26px;" class="CityPickPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                        <td class="td_name" colspan="3" >报价单号(提货)</td>
                        <td class="td_name" colspan="3" >报价公司(提货)</td>
                        <td class="td_name" colspan="2">价格(提货)</td>
                    </tr>
                    <tr   style="height: 26px;" class="CityPickPrice hide" fb-options="{'rowid':'CityPickPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="CityPickPrice">
                        <td colspan="3">
                            <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                            <input name="volume" type="hidden" />
                        </td>
                        <td class="" colspan="3">
                            <input name="Qty" onkeyup="Calculator(this)" readonly  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                        </td>
                        <td class="" colspan="2">
                            <input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
                        </td>
                    </tr>
                    <tr class="CityDeliveryPrice hide">
                        <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                    </tr>
                    <!--送货费-->
                    <tr style="height: 26px;" class="CityDeliveryPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                        <td class="td_name" colspan="3" >报价单号(送货)</td>
                        <td class="td_name" colspan="3" >报价公司(送货)</td>
                        <td class="td_name" colspan="2">价格(送货)</td>
                    </tr>
                    <tr   style="height: 26px;" class="CityDeliveryPrice hide" fb-options="{'rowid':'CityDeliveryPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="CityDeliveryPrice">
                        <td colspan="3">
                            <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                            <input name="volume" type="hidden" />
                        </td>
                        <td class="" colspan="3">
                            <input name="Qty" onkeyup="Calculator(this)" readonly  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                        </td>
                        <td class="" colspan="2">
                            <input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
                        </td>
                    </tr>
                    <tr class="OnLoadPrice hide">
                        <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                    </tr>
                    <!--装货费-->
                    <tr style="height: 26px;" class="OnLoadPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                        <td class="td_name" colspan="3" >报价单号(装货)</td>
                        <td class="td_name" colspan="3" >报价公司(装货)</td>
                        <td class="td_name" colspan="2">价格(装货)</td>
                    </tr>
                    <tr   style="height: 26px;" class="OnLoadPrice hide" fb-options="{'rowid':'OnLoadPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="OnLoadPrice">
                        <td colspan="3">
                            <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                            <input name="volume" type="hidden" />
                        </td>
                        <td class="" colspan="3">
                            <input name="Qty" onkeyup="Calculator(this)" readonly  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                        </td>
                        <td class="" colspan="2">
                            <input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
                        </td>
                    </tr>
                    <tr class="OffLoadPrice hide">
                        <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                    </tr>
                    <!--卸货费-->
                    <tr style="height: 26px;" class="OffLoadPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                        <td class="td_name" colspan="3" >报价单号(卸货)</td>
                        <td class="td_name" colspan="3" >报价公司(卸货)</td>
                        <td class="td_name" colspan="2">价格(卸货)</td>
                    </tr>
                    <tr   style="height: 26px;" class="OffLoadPrice hide" fb-options="{'rowid':'OffLoadPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="OffLoadPrice">
                        <td colspan="3">
                            <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                            <input name="volume" type="hidden" />
                        </td>
                        <td class="" colspan="3">
                            <input name="Qty" onkeyup="Calculator(this)" readonly  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                        </td>
                        <td class="" colspan="2">
                            <input name="OnLoad"  readonly  title="" oc="text" class="edit form-control transparent" f-options="{'code':'OnLoad','type':'number','etype':'editable','len':''}" verify="">
                        </td>
                    </tr>
                    <tr class="InsurancePrice hide">
                        <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                    </tr>
                    <!--保险费-->
                    <tr style="height: 26px;" class="InsurancePrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                        <td class="td_name" colspan="3" >报价单号(保险)</td>
                        <td class="td_name" colspan="3" >报价公司(保险)</td>
                        <td class="td_name" colspan="2">价格(保险)</td>
                    </tr>
                    <tr   style="height: 26px;" class="InsurancePrice hide" fb-options="{'rowid':'InsurancePrice','initialRows':'1','maxrows':'10','content':''}" nrowid="InsurancePrice">
                        <td colspan="3">
                            <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                            <input name="volume" type="hidden" />
                        </td>
                        <td class="" colspan="3">
                            <input name="Qty" onkeyup="Calculator(this)" readonly  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                        </td>
                        <td class="" colspan="2">
                            <input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
                        </td>
                    </tr>
                    <tr class="TaxPrice hide">
                        <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                    </tr>
                    <!--税费-->
                    <tr style="height: 26px;" class="TaxPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                        <td class="td_name" colspan="3" >报价单号(税费)</td>
                        <td class="td_name" colspan="3" >报价公司(税费)</td>
                        <td class="td_name" colspan="2">价格(税费)</td>
                    </tr>
                    <tr   style="height: 26px;" class="TaxPrice hide" fb-options="{'rowid':'TaxPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="TaxPrice">
                        <td colspan="3">
                            <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                            <input name="volume" type="hidden" />
                        </td>
                        <td class="" colspan="3">
                            <input name="Qty" onkeyup="Calculator(this)" readonly  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                        </td>
                        <td class="" colspan="2">
                            <input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
                        </td>
                    </tr>
                    <tr class="AdditionPrice hide">
                        <td rowspan="1" colspan="8" style="background-color: white; border: 0; height: 15px;"></td>
                    </tr>
                    <!--附加费-->
                    <tr style="height: 26px;" class="AdditionPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                        <td class="td_name" colspan="3" >报价单号(附加费)</td>
                        <td class="td_name" colspan="3" >报价公司(附加费)</td>
                        <td class="td_name" colspan="2">价格(附加费)</td>
                    </tr>
                    <tr   style="height: 26px;" class="AdditionPrice hide" fb-options="{'rowid':'AdditionPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="AdditionPrice">
                        <td colspan="3">
                            <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                            <input name="volume" type="hidden" />
                        </td>
                        <td class="" colspan="3">
                            <input name="Qty" onkeyup="Calculator(this)" readonly  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                        </td>
                        <td class="" colspan="2">
                            <input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
                        </td>
                    </tr>
                </tbody> 
        </table>
        <!-- 表单结尾 -->
    </div>
	<div>
		<table class="FormTable Y_alter FormTable6" >
			<tr  style="height: 26px;" name="OrderPriceTitle">
			</tr>
			<tr  style="height: 26px;" name="OrderPrice">
			</tr>
		</table>
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
    <!--#include file="/Controls/TMS/footer.aspx"-->
    <!--通用页尾结尾-->

    <script type="text/javascript">
        function _DoPageLoad()
        {
            initTableForm( $( '#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860' ), false, function ()
            {
                setTimeout( 'GoodsCategory();CarTypes( $( \'input[name="CarType"]\' ).val() );YesORno();PackageMode();ShipModeName();TransportMode();Sum();', 300 );
                OrderPriceShow( NSF.UrlVars.Get( 'id', location.href ) );                
            } );
        }
        var reqeustDone = function ()
        {		/*所有JS加载完成以后执行*/
            if ( typeof ( initHeader ) != "undefined" ) initHeader();					/*初始化页面通用头部*/
            if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/
            setTimeout("_DoPageLoad()", 300);//初始化固定头部的宽度
            setTimeout("hoverTips(),autoHead()", 1100);  /*input的tips*/

            //点击查看详情
            var coutNum = 0;
            $('#accordion .panel').click(function () {
                coutNum++;
                if (coutNum % 2 == 0) {
                    $('tbody.prompt').show();
                    $('.glyphicon-menu-down').css('display', 'inline');
                    $('.glyphicon-menu-up').css('display', 'none');
                    $('tbody.costdetail').addClass('hide');
                } else {
                    $('tbody.prompt').hide();
                    $('.glyphicon-menu-down').css('display', 'none');
                    $('.glyphicon-menu-up').css('display', 'inline');

                    $('tbody.costdetail').removeClass('hide');
                }
            });
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
            var autoW = $('.formcontainer').width() + 2;//+2是为了解决兼容边框
            $('.tr-fixed').css('width', autoW + 'px');
        }
    </script>
    <script src="/assets/request_minify.js"></script>
</body>
</html>