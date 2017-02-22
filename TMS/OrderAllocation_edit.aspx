<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>运输计划详情-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
</head>
<body code="OrderAllocation">
    <!--额外的css开始-->
    <!--#include file="/Controls/CSS.aspx"-->
    <style type="text/css">
        .topbar_nav li a {
            font-weight:bold;
         }
        .jptable tbody tr:hover {
            background-color: transparent !important;
        }

        .add_place {
            margin-left: 10px;
        }

        .jptable tr td {

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
            .panel:hover {
              background:#eee;
            }
            .hoverH4 a:hover {
                color: #008fbf !important;
            }
    </style>
    <!--额外的css结尾-->
<link href="../PMS/city/css/cityLayout.css" type="text/css" rel="stylesheet">
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
<!--拆分数量-->
    <div class="modal fade" id="splitQtyModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="height:220px;">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    <%--<button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>--%>

                    <h4 class="modal-title text-left" id="myModalLabel">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">拆分数量</p>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group col-md-10">
                        <div class="col-md-10">
                          <label>总数量：<span name="totalQty"></span><span class="hide" name="ListID"></span></label>
                        </div>
                        <div class="clearfix"></div>
                        <br>
                        <div class="col-md-2">
                            <input type="text" class="form-control qtyinput" placeholder="">
                        </div>
                        <div class="col-md-2">
                            <input type="text" class="form-control qtyinput" placeholder="">
                        </div>
                        <div class="col-md-2">
                            <input type="text" class="form-control qtyinput" placeholder="">
                        </div>
                        <div class="col-md-2">
                            <input type="text" class="form-control qtyinput" placeholder="">
                        </div>
                        <div class="col-md-2">
                            <input type="text" class="form-control qtyinput" placeholder="">
                        </div>
                  </div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                    <button type="button" class="btn btn-default   footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="splitQty( $(this).closest('div#splitQtyModal'))"><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left: 2px;"></span></button>
                    <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left: 2px; color: #888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
    <!--通用头部文件开始-->
    <!--#include file="/Controls/TMS/header.aspx"-->
    <!--通用头部文件结尾-->

    <!-- 模板开始-->
    <%--<script id="jplist-template" type="text/x-template">--%>
    <div class="list-item box jplist-panel tabbtn">
        <div class="chaidan">
            <!-- block right -->
            <table class="jptable" style="width:100%;">
                <thead style="position:fixed;z-index:1;padding-right:25px;" >
                    <tr  class="td-container tr-fixed" style="border-bottom: 1px solid #ddd;">
                        <td colspan="8" style="width:100%;border-bottom:0;">
                            <div  style="height:100%;width:100%;background-color:white;border:1px solid white;">
                                <div style="background-color:#f27302">
                                    <p style="margin-left: 3px; padding-left: 10px; margin-bottom: 25px; margin-top: 25px; background-color: white; color: #888; font-size: 14px;">运输计划详情</p>
                                </div>
                                <div  style="position: absolute; right: 0px; top: 27px">
                                    <button type="button" class="btn footKeepBtn" onclick="SplitSingle()">提交&nbsp;<span class="glyphicon glyphicon-ok-circle"></span></button>
                                    <button type="button" class="btn" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt" style="transform: rotateY(180deg);"></span></button>
                                </div>
                            </div>
                        </td>
                    </tr>

                </thead>
                <tbody style="position:absolute;top:86px;left:15px;right:15px">
                    <tr>
                        <td colspan="8" class="initAloWidth">
                            <div class="panel-group" id="accordion">
                                <a data-toggle="collapse" data-parent="#accordion" href="/demo/bootstrap3-plugin-collapse-accordion.htm#collapseOne" style="font-family: '微软雅黑'; color: #888; font; font-size: 14px;">
                                    <div class="panel panel-default" style="border-radius:0;box-shadow:none;">
                                        <div style="background-color: transparent; padding: 10px; margin-bottom: -1px; border-bottom: 1px solid #eee;">
                                            <h4 class="panel-title hoverH4" style="font-family:'微软雅黑'; color:#0099CC;">查看详情<span class="glyphicon glyphicon-menu-down" style="position:relative;top:2px;left:5px;"></span><span class="glyphicon glyphicon-menu-up" style="position:relative;top:2px;left:5px;display:none;"></span>
                                            </h4>
                                        </div>
                                    </div>
                                </a>
                                <div >
                                    <div class="panel-body" style="padding:0;">
                                        <div class="formcontainer" style="display: block;">
                                            <!-- 表单开始-->
                                            <script language="javascript">
                                                var __saveNdtCfg = '{"main":{"insertVml":"","updateVml":"tms_0024","queryVml":"tms_0027"},"TMS_OrderGoods":{"insertVml":"tms_0028","updateVml":"tms_0028","queryVml":"tms_0030","deleteVml":"tms_0031"}}';
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
                                                <tbody class="hideTbody" style="display:none;">
                                                    <tr style="height: 26px; display: none">
                                                        <td class="styleCenter td_name" rowspan="1" colspan="6" style="font-size: 18px;">
                                                            <input name="OrderID" title="订单编号" oc="text" readonly="readonly" class="edit form-control transparent" value="0" f-options="{'code':'OrderID','type':'text','etype':'editable','len':'50'}" verify="{}">
                                                        </td>
                                                    </tr>

                                                    <tr style="height: 26px;">
                                                        <td class="td_name">单据编号</td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="Code" title="单据编号" oc="text" readonly="readonly" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Code','type':'text','etype':'editable','len':'50'}" verify="{}">
                                                        </td>
                                                        <td class="td_name">合同编号</td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="PactCode" title="合同编号" oc="text" readonly="readonly" class="edit form-control transparent" f-options="{'code':'PactCode','type':'text','etype':'editable','len':'50'}" verify="{'title':'PactCode','length':'50','required':true}">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                         <td class="td_name">制单日期</td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="CreateTime" title="制单日期" placeholder="系统自动生成" oc="date" disabled class="laydate-icon edit" onclick="TrigerDateEvent(this, { format: 'YYYY-MM-DD' })" f-options="{'code':'CreateTime','type':'date','etype':'editable','len':'50'}" verify="">
                                                        </td>
                                                        <td class="td_name">制单人</td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="Creator" title="制单人" oc="text" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Creator','type':'text','etype':'editable','len':'50'}" verify="{}">
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td rowspan="1" colspan="8" style="background-color: white;border:0 !important;border-left:1px solid white !important;border-right:1px solid white !important; height: 15px;"></td>
                                                    </tr>
                                                </tbody>
                                                <tbody>
                                                    <tr style="height: 26px;">
                                                        <td class="td_name">
                                                                客户名称
															<input type="hidden" name="CustomerID">
                                                        </td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="Name" readonly="readonly" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'50'}" verify="{'title':'CustomerName','length':'50','required':true}">
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
                                                        <td class="" colspan="">
                                                           <input type="hidden" class="edit form-control transparent" name="FromProvince_id" readonly f-options="{'code':'FromProvince_id','type':'text','etype':'editable','len':'32'}"/>
                                                           <input type="text" class="edit form-control transparent" name="FromProvince" readonly f-options="{'code':'FromProvince','type':'text','etype':'editable','len':'32'}"/>
                                                        </td>
                                                        <td class="td_name">发货市</td>
                                                        <td colspan="">
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
                                                        <td class="td_name">发货时间
                                                        </td>
                                                        <td class="" rowspan="1" colspan="">
                                                            <input name="FromTime" disabled="disabled" title="发货时间" oc="date" class="laydate-icon edit" onclick="TrigerDateEvent(this, { format: 'YYYY-MM-DD' })" f-options="{'code':'FromTime','type':'date','etype':'editable','len':'50'}" verify="{'title':'FromTime','length':'50','required':true}">
                                                        </td>
                                                        <td class="td_name">联系电话</td>
                                                        <td class="">
                                                            <input name="FromContact" title="收货方联系电话" readonly="readonly"  oc="text" class="edit form-control transparent" f-options="{'code':'FromContact','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^(13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9])[0-9]{8}$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                                                        </td>
                                                        <td class="td_name">
                                                            发货地址
                                                        </td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="From"  disabled="disabled" title="发货地址" oc="text" class="edit form-control transparent" f-options="{'code':'From','type':'text','etype':'editable','len':'32'}" verify="{'title':'From','length':'50','required':true}">
                                                            <div style="display: none">
                                                                <span name="fromprovince"></span>
                                                                <span name="fromcity"></span>
                                                                <span name="fromdistrict"></span>
                                                            </div>
                                                        </td>    
                                                    </tr>
                                                    <tr>
                                                        <td rowspan="1" colspan="8" style="background-color: white;border:0 !important;border-left:1px solid white !important;border-right:1px solid white !important; height: 15px;"></td>
                                                    </tr>
                                                    <tr>
                                                         <td class="td_name">
                                                                收货方
                                                        </td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="EndUserName" readonly="readonly" class="edit form-control transparent" f-options="{'code':'EndUserName','type':'text','etype':'editable','len':'50'}" verify="{'title':'EndUserName','length':'50','required':true}">
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
                                                        
                                                        <td class="td_name">到货时间
                                                        </td>
                                                        <td class="" rowspan="1" colspan="">
                                                            <input name="ToTime" title="发货时间" disabled="disabled" oc="date" class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD', min: $( 'input[name=\'FromTime\']' ).val() } )" f-options="{'code':'ToTime','type':'date','etype':'editable','len':'50'}" verify="{'title':'ToTime','length':'50','required':true}">
                                                        </td>     
                                                        <td class="td_name">联系电话</td>
                                                        <td class="">
                                                            <input name="ToContact" title="收货方联系电话" readonly="readonly"  oc="text" class="edit form-control transparent" f-options="{'code':'ToContact','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^(13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9])[0-9]{8}$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                                                        </td>                                              
                                                        <td class="td_name">
                                                            收货地址
                                                        </td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="To" title="收货地址" readonly="readonly" oc="text" class="edit form-control transparent" f-options="{'code':'To','type':'text','etype':'editable','len':'32'}" verify="{'title':'To','length':'50','required':true}">
                                                            <div style="display: none">
                                                                <span name="toprovince"></span>
                                                                <span name="tocity"></span>
                                                                <span name="todistrict"></span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tbody class="hideTbody" style="display:none;">
                                                    <tr>
                                                        <td rowspan="1" colspan="8" style="background-color: white;border:0 !important;border-left:1px solid white !important;border-right:1px solid white !important; height: 15px;"></td>
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
													   <td class="" colspan="4">
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
                                                            <input type="hidden" readonly class="edit form-control transparent" name="CarLength">
                                                        </td>
                                                    </tr>
													<tr style="height: 26px;" name="CarInfo">
														<td class="td_name">容积（立方米）</td>
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
                                                        <td class="" rowspan="1" colspan="4">
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
                                                        <td class="td_name">
                                                            预付款
                                                        </td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="Payment" title="预付款" readonly class="writeInput" placeholder="" oc="text" class="edit form-control transparent data" f-options="{'code':'Payment','type':'text','etype':'editable','len':'600'}" verify="{'title':'预付款','length':'600'}">
                                                        </td>
                                                        <td class="td_name" colspan="1">货到付款</td>
                                                        <td colspan="4">
                                                            <input name="Payable" readonly  class="edit form-control transparent data" f-options="{'code':'Payable','type':'richtext','etype':'','len':''}" verify="{'title':'货到付款','length':'','textarea1':true}"></input>
                                                        </td>                    
                                                    </tr>
                                                    <tr>
                                                        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;border-left:1px solid white !important;border-right:1px solid white !important;"></td>
                                                    </tr>
                                                    <tr style="height:26px;">
                                                        <td class="td_name">
                                                            备注
                                                        </td>
                                                        <td colspan="9">
                                                            <textarea style="line-height:28px;" name="Descriptions"  readonly class="edit form-control transparent" f-options="{'code':'Descriptions','type':'richtext','etype':'','len':''}" verify="{'title':'Descriptions','length':'','textarea1':true}"></textarea>
                                                      </td>
                                                    </tr>
                                                </tbody>
                                                <tbody class="showTbody">
                                                    <tr>
                                                        <td rowspan="1" colspan="8" style="background-color: white;border:0 !important;border-left:1px solid white !important;border-right:1px solid white !important; height: 15px;"></td>
                                                    </tr>
                                                    <tr style="height: 26px;" class="" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                                                        <td class="td_name" colspan="">物品编号</td>
                                                        <td class="td_name" colspan="2" >物品名称</td>
                                                        <td class="td_name">规格</td>
                                                        <td class="td_name">物品数量</td>
                                                        <td class="td_name">重量</td>
                                                        <td class="td_name">体积</td>
														<td class="td_name">批次</td>
                                                    </tr>
                                                    <tr style="height: 26px; display: none;" class="" fb-options="{'rowid':'TMS_OrderGoods','initialRows':'1','maxrows':'10','content':''}" rowid="TMS_OrderGoods">
                                                        <td colspan="">
                                                            <input type="text" title="物品编号" oc="dialogue" class="edit form-control transparent" disabled name="GoodsID" f-options="{'code':'id','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'../GoodsSelector.aspx','vals':'GoodsID=id','modalWindow':'1'}" verify="{}">

                                                        </td>
                                                        <td class="" colspan="2" >
                                                            <input name="Name" readonly="readonly" title="物品名称" oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'50'}" verify="{'title':'Name','length':'50','required':true}">
                                                        </td>
                                                        <td>
                                                            <input name="SPC" title="规格" readonly oc="text" class="edit form-control transparent" f-options="{'code':'SPC','type':'text','etype':'editable','len':'50'}" verify="{'title':'SPC','length':'50','required':true}">
                                                        </td>
                                                        <td class="">
                                                            <input name="Qty"  readonly="readonly" title="物品数量" oc="number" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                                                        </td>
                                                        <td class="">
                                                            <input name="Weight" readonly="readonly" title="重量" oc="number" class="edit form-control transparent" f-options="{'code':'Weight','type':'number','etype':'editable','len':''}" verify="{'title':'重量','number':true}">
                                                        </td>
                                                        <td>
                                                            <input name="Volume" readonly="readonly" title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                                                        </td>
														<td class="">
															<input name="BatchNo"  readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次','required':true}">
														</td>
                                                    </tr>
                                                    <tr style="height: 26px;display:none" class="addition">
                                                          <td class=""  colspan="4">补差</td>
                                                          <td></td>
                                                          <td class="" rowspan="1" colspan="">
                                                                <input name="WeightAddition"   title="重量补差" readonly oc="text" class="edit form-control transparent" f-options="{'code':'WeightAddition','type':'number','etype':'editable','len':''}" verify="{'title':'WeightAddition','number':true,'required':true}">
                                                          </td>
                                                          <td class="" colspan="">
                                                               <input name="VolumeAddition"   title="体积补差" readonly oc="text" class="edit form-control transparent" f-options="{'code':'VolumeAddition','type':'number','etype':'editable','len':''}" verify="{'title':'VolumeAddition','number':true,'required':true}">
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
                                                </tbody>
                                            </table>
                                            <!-- 表单结尾 -->
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="cd_td" colspan="8">
                            <table class="table jptable line_chaidan">
                                <tbody>
                                    <tr>
                                        <td colspan="13" style="border-right: 1px solid #e1e6eb;padding:0;">
                                         <span style="background-color: #eee;line-height:42px;height:40px;padding-left:20px;padding-right:20px; display:inline-block;margin-right:10px;">是否拆单：</span><input type="checkbox" name="split" style="margin:0;margin-left:15px;position:relative;top:2px;" />
                                        </td>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr name="splittr" style="display:none;">
                        <td class="cd_td" colspan="8">
                            <table class="table jptable line_chaidan line_chaidan_2">
                                <thead>
                                    <tr>
                                        <td colspan="15" style="background-color: #F5F6FA; border-bottom: 1px solid #e1e6eb; color: #999;">路线拆单</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="1" style="border-right: 1px solid #e1e6eb;"><span style="float: left; color: #666;">起始地：</span></td>
                                        <td colspan="11">
                                            <input type="text" readonly name="InputFrom" placeholder="请输入发货地" style="border: 0; width: 100%; line-height: 34px;" /></td>
                                        <td>联系电话</td>
                                        <td>
                                            <input type="text" readonly name="InputFromPhone" placeholder="请输入发货人联系电话" style="border: 0; width: 100%; line-height: 34px;" />
                                        </td>
                                        <td style="border-left: 1px solid #ddd;"><a class="add_place pull-right">添加</a></td>
                                    </tr>
                                    <tr class="last_place">
                                        <td colspan="1" style="border-right: 1px solid #e1e6eb;"><span style="float: left; position: relative; top: 2px;">目的地：</span></td>
                                        <td colspan="11">
                                            <input type="text" readonly name="InputTo" placeholder="请输入收货地" style="border: 0; width: 100%; line-height: 34px;" />
                                        </td>
                                        <td>联系电话
                                        </td>
                                        <td>
                                            <input type="text" readonly name="InputToPhone" placeholder="请输入收货方联系电话" style="border: 0; width: 100%; line-height: 34px;" />
                                        </td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr name="splittr" style="display:none" >
                        <td class="cd_td" colspan="8">
                            <table class="table goods_chaidan jptable">
                                <thead>
                                    <tr>
                                        <td colspan="10" style="border: none; background-color: #F5F6FA; border-bottom: 1px solid #e1e6eb; color: #999;">货物数量拆单</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>客户名称</td>
                                        <td>收货方</td>
                                        <td>发货地址</td>
                                        <td>收货地址</td>
                                        <td>物品名称</td>
                                        <td>总重量（公斤）</td>
                                        <td>总体积（立方米）</td>
                                        <td>总数量</td>
                                        <td>拆分数量</td>
                                    </tr>
                                    <tr name="Goods">
                                        <td view-fld='{ fld:"CustomerName",method:"show"}'></td>
                                        <td view-fld='{ fld:"EndUserName",method:"show"}'></td>
                                        <td view-fld='{ fld:"From",method:"show"}'></td>
                                        <td view-fld='{ fld:"To",method:"show"}'></td>
                                        <td view-fld='{ fld:"GoodsName",method:"show"}'></td>
                                        <td view-fld='{ fld:"Weight",method:"show"}'></td>
                                        <td view-fld='{ fld:"Volume",method:"show"}'></td>
                                        <td name="Qty" view-fld='{ fld:"Qty",method:"show"}'></td>
                                        <td view-fld='{ fld:"splitQty",method:"template",template:"<input type=\"hidden\"  name=\"GoodsID\" value=\"@goodsid@\" /><input type=\"hidden\"  name=\"ListID\" value=\"@listid@\" /><input type=\"text\" readonly onclick=\"splitQtyClick(@qty@, @listid@)\"   name=\"splitQty\" value=\"@qty@\" style=\"width: 81px;\" />"}'>
                                            </td>
                                        
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>


    <script type="text/javascript">
        function _DoPageLoad()
        {
            initTableForm( $( '#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860' ), false, function ()
            {
                GoodsCategory();
                CarTypes( $( 'input[name="CarType"]' ).val() );
                YesORno();
                PackageMode();
                ShipModeName();
                TransportMode();
                hoverTips();
            } );
        }
        function showInfor() {
            var inforNum = $('.showTbody tr').length;
            for (var i = 4; i < $('.showTbody tr').length; i++) {
                $('.showTbody tr').eq(i).css('display', 'none');
            }

        };
        var reqeustDone = function ()
        {		/*所有JS加载完成以后执行*/
            if ( typeof ( initHeader ) != "undefined" ) initHeader();					/*初始化页面通用头部*/
            if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/
            setTimeout("_DoPageLoad(),autoHead()", 300);//初始化固定头部的宽度
            setTimeout("hoverTips();Sum()", 2100);  /*input的tips*/
            setTimeout("showInfor()", 1000);  /*初始物品信息的条数*/

            //数量拆分
            $('input.qtyinput').on( "focus keyup", function( e ){
                if( e.type == "focus" ){
                    $(this).val( "" );
                }if( e.type == "keyup" ){
                    $(this).val( $(this).val().replace(/[^\d.]/g,'') );
                }
                
            });

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

            $('.gou-btn').click(function ()
            {
                if ( $( 'input[name="split"]' ).is( ':checked' ) == true )
                {
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
                }
                autoHead();
            });

            /*var _topscroll;
            var _top;
            $("div.viewFramework-product-body").scroll( function(){
                _topscroll =  $(this).scrollTop();
                if( _topscroll > 0 ){
                    _top = _topscroll ;
                }else{
                    _top = 0;
                }

                $("#floatButton").animate({ top: 0 }, { duration: 500, queue: false }); 
            });*/

           
        }
    </script>
    <!--通用页尾开始-->
    <!--#include file="/Controls/TMS/footer.aspx"-->
    <!--通用页尾结尾-->
    
    <!--其他JS开始-->
    <!--#include file="/Controls/JS.aspx"-->
	<!--#include file="/Controls/TMS/JS.aspx"-->
    <!--其他JS结尾-->
    <script type="text/javascript">
        $(function () {
            var coutNum = 0;
            $('#accordion .panel').click(function () {
                coutNum++;
                if (coutNum % 2 == 0) {
                    $('.glyphicon-menu-down').css('display', 'inline');
                    $('.glyphicon-menu-up').css('display', 'none');
                    $('.showTbody').css('display', 'table-row-group');
                    $('.hideTbody').css('display', 'none');
                    var inforNum = $('.showTbody tr').length;
                    for (var i = 4; i < $('.showTbody tr').length; i++) {
                        $('.showTbody tr').eq(i).css('display', 'none');
                    }
                } else {
                    $('.glyphicon-menu-down').css('display', 'none');
                    $('.glyphicon-menu-up').css('display', 'inline');
                    $('.showTboby').css('display', 'none');
                    $('.hideTbody').css('display', 'table-row-group');
                    for (var i = 4; i < $('.showTbody tr').length; i++) {
                        $('.showTbody tr').eq(i).css('display', 'table-row');
                    }
                }
                autoHead();
            });

        });
        /*浏览器窗口变化时，固定头部宽度赋值*/
        $(window).resize(function () {
            autoHead();
        });
        /*固定头部宽度赋值*/
        function autoHead() {
            var autoW = $('.chaidan').width() + 2;//+2是为了解决兼容边框
            $('.tr-fixed').css('width', autoW + 'px');
            $('.initAloWidth').css('width', autoW + 'px');
        }
    </script>
    <script src="/assets/request_form.js"></script>
</body>
</html>
