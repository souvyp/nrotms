<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>订单费用信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--#include file="/Controls/Meta.aspx"-->
	<link href="/pms/city/css/cityLayout.css" type="text/css" rel="stylesheet">
    <!--#include file="/Controls/PMS/CSS.aspx"-->
    <link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="FTransSearch">
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
    <!--#include file="/Controls/PMS/header.aspx"-->
    <!--通用头部文件结尾-->

    <!-- 模板开始-->
    <%--<script id="jplist-template" type="text/x-template">--%>
    <div class="formcontainer" style="display: none;">
        <!-- 表单开始-->
        <script language="javascript">
            var __saveNdtCfg = '{"main":{"insertVml":"","updateVml":"","queryVml":"pml_0033"}}';
        </script>
        <table class="FormTable Y_alter FormTable6 readForm" style="width: 100%;" id="ef41d4b8-88a5-4954-9d0d-b1dc6a71f860" path="OPMS/OrderPrice" code="OrderPrice">
            <colgroup>
                <col style="width: 12.5%;">
                <col style="width: 12.5%;">
                <col style="width: 12.5%;">
                <col style="width: 12.5%;">
                <col style="width: 12.5%;">
                <col style="width: 12.5%;"">
				<col style="width: 12.5%;"">
                <col style="width: 12.5%;"">
            </colgroup>
            <tbody>
                <tr class="td-container tr-fixed">
                    <td class="text-left" rowspan="1" colspan="4" style="font-size: 14px; border: 0; border-bottom: 1px solid #e1e6eb; padding-right: 0; padding-left: 0;width:100% !important">
                    <div style="padding-top:20px;" >
                            <div style="padding-left: 3px; background-color: #f27302;">
                                <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">订单费用信息</p>
                            </div>
                        </div>
                    </td>
                    <td colspan="4" style="border: 0; border-bottom: 1px solid #e1e6eb;">
                        <input type="hidden" name="id">
                        <div class="toolbar">
                            <div style="text-align: right;" class="button_workflow">
                                <%--<a class="btn btn-red" href="javascript:void(0);" ev="%23saveNDT%23" onclick="GetCheckboxVal()">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>--%>
                                <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
                                <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt" style="transform: rotateY(180deg);"></span></a>
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
                      <input type="hidden" name="OrderID" value=0 >
                      <input type="hidden" name="Name" value=0 >
                      <input type="hidden" name="Self">   <!--1:自营报价  0:客户报价-->
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
                        <input type="hidden" name="CustomerID" value="0"/>
                  </td>
                  <td class="" rowspan="1" colspan="2">
                     <input name="CustomerName" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'CustomerName','length':'50'}">
                  </td>
                  <td class="td_name" style="background-color: rgb(242, 242, 242);">是否提货</td>
                  <td class="yesorno" rowspan="1" colspan="2">
                    <input type="hidden" name="IsPick" value="0"/>
                     <input name="PickName" readonly class="edit form-control transparent" f-options="{'code':'PickName','type':'text','etype':'editable','len':'50'}" verify="{'title':'PickName','length':'50'}">
                  </td>
                  <td class="td_name">是否装货</td>
                  <td class="yesorno" rowspan="1" colspan="3">
                    <input type="hidden" name="IsOnLoad" value="0"/>
                      <input name="OnLoadName" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'OnLoadName','type':'text','etype':'editable','len':'100'}" verify="{}">
                  </td>
                </tr>
                <tr style="height: 26px;">
                  <td class="td_name">收货方</td>
                  <td class="" rowspan="1" colspan="2">
                      <input name="EndUserName" class="writeInput"  readonly placeholder="" class="edit form-control transparent" f-options="{'code':'EndUserName','type':'text','etype':'editable','len':'50'}" verify="{'title':'收货方','length':'50'}">
                  </td>
                  <td class="td_name" style="background-color: rgb(242, 242, 242);">是否送货</td>
                  <td class="yesorno" rowspan="1" colspan="2">
                    <input type="hidden" name="IsDelivery" value="0"/>
                     <input name="DeliveryName" readonly class="edit form-control transparent" f-options="{'code':'DeliveryNmae','type':'text','etype':'editable','len':'50'}" verify="{'title':'DeliveryName','length':'50'}">
                  </td>
                  <td class="td_name">是否卸货</td>
                  <td class="yesorno" rowspan="1" colspan="3">
                    <input type="hidden" name="IsOffLoad" value="0"/>
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
                     <input name="IFrom" readonly class="edit form-control transparent" f-options="{'code':'IFrom','type':'text','etype':'editable','len':'50'}" verify="{'title':'','length':'50'}">
                  </td>
                  <td class="td_name" style="background-color: rgb(242, 242, 242);">运输模式</td>
                  <td class="" rowspan="1" colspan="2">
                    <input type="hidden" name="TransportMode" >
                     <input name="TransportModeName" type="text" readonly class="edit form-control transparent" f-options="{'code':'TransportModeName','type':'text','etype':'editable','len':'50'}" verify="{'title':'TransportModeName','length':'50'}">
                  </td>
                  <td class="td_name" style="background-color: rgb(242, 242, 242);">是否保价</td>
                  <td class="yesorno" rowspan="1" colspan="3">
                    <input type="hidden" name="IsInsurance" value="0"/>
                     <input name="InsuranceName" readonly class="edit form-control transparent" f-options="{'code':'InsuranceName','type':'text','etype':'editable','len':'50'}" verify="{'title':'InsuranceName','length':'50'}">
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
                          <option value="1">公斤</option>
            <option value="2">吨</option>
            <option value="3">立方米</option>
            <option value="4">升</option>
            <option value="5">个</option>
            <option value="6">托</option>
            <option value="7">台</option>
            <option value="8">箱</option>
            <option value="9">包</option>
            <option value="10">捆</option>
            <option value="11">辆</option>
            <option value="12">件</option>
            <option value="13">袋</option>
            <option value="14">架</option>
            <option value="15">盒</option>
            <option value="16">桶</option>
            <option value="17">其它</option>
                        </select>
                      </td>
                  </tr>
                 <tr>
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;">
                  <td class="td_name">总数量</td>
                  <td class="" rowspan="1" colspan="2">
                      <input name="TotalAmount" class="writeInput"  readonly placeholder="" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="{'title':'收货方','length':'50'}">
                  </td>
                  <td class="td_name" style="background-color: rgb(242, 242, 242);">总体积</td>
                  <td class="" rowspan="1" colspan="2">
                     <input name="TotalVolume" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'','length':'50'}">
                  </td>
                  <td class="td_name">总重量</td>
                  <td class="" rowspan="1" colspan="3">
                      <input name="TotalWeight" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'100'}" verify="{}">
                  </td>
                </tr>
                 <tr>
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr>
                    <td class="td_name">备注</td>
                    <td colspan="9" style="height:100px;">
                      <textarea name="Descriptions" style="line-height: 28px;height:100px;" readonly  class="edit form-control transparent" f-options="{'code':'Descriptions','type':'richtext','etype':'','len':''}" verify="{'title':'Descriptions','length':'','textarea1':true}"></textarea>
                    </td>
                </tr>
                <tr>
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
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
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <!--零担-->
                <tr style="height: 26px;" class="PMS_LessLoad hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="2">报价方式</td>
                    <td class="td_name" colspan="3" >报价单号(零担)</td>
                    <td class="td_name" colspan="3" >报价公司(零担)</td>
                    <td class="td_name" colspan="2">价格(零担)</td>
                </tr>
                <tr   style="height: 26px;" class="PMS_LessLoad hide" fb-options="{'rowid':'PMS_LessLoad','initialRows':'1','maxrows':'10','content':''}" nrowid="PMS_LessLoad">
                    <td class="" colspan="2">
                        <input name="Type"  readonly  title="报价方式" oc="text" class="edit form-control transparent" f-options="{'code':'Type','type':'number','etype':'editable','len':''}" verify="{'title':'报价方式','number':true,'required':true}">
                    </td>
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
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <!--整车-->
                <tr style="height: 26px;" class="PMS_FullLoad hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="2">报价方式</td>
                    <td class="td_name" colspan="3" >报价单号(整车)</td>
                    <td class="td_name" colspan="3" >报价公司(整车)</td>
                    <td class="td_name" colspan="2">价格(整车)</td>
                </tr>
                <tr   style="height: 26px;" class="PMS_FullLoad hide" fb-options="{'rowid':'PMS_FullLoad','initialRows':'1','maxrows':'10','content':''}" nrowid="PMS_FullLoad">
                    <td class="" colspan="2">
                        <input name="Type"  readonly  title="报价方式" oc="text" class="edit form-control transparent" f-options="{'code':'Type','type':'number','etype':'editable','len':''}" verify="{'title':'报价方式','number':true,'required':true}">
                    </td>
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
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <!--提货费-->
                <tr style="height: 26px;" class="CityPickPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="2">报价方式</td>
                    <td class="td_name" colspan="3" >报价单号(提货)</td>
                    <td class="td_name" colspan="3" >报价公司(提货)</td>
                    <td class="td_name" colspan="2">价格(提货)</td>
                </tr>
                <tr   style="height: 26px;" class="CityPickPrice hide" fb-options="{'rowid':'CityPickPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="CityPickPrice">
                    <td class="" colspan="2">
                        <input name="Type"  readonly  title="报价方式" oc="text" class="edit form-control transparent" f-options="{'code':'Type','type':'number','etype':'editable','len':''}" verify="{'title':'报价方式','number':true,'required':true}">
                    </td>
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
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <!--送货费-->
                <tr style="height: 26px;" class="CityDeliveryPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="2">报价方式</td>
                    <td class="td_name" colspan="3" >报价单号(送货)</td>
                    <td class="td_name" colspan="3" >报价公司(送货)</td>
                    <td class="td_name" colspan="2">价格(送货)</td>
                </tr>
                <tr   style="height: 26px;" class="CityDeliveryPrice hide" fb-options="{'rowid':'CityDeliveryPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="CityDeliveryPrice">
                    <td class="" colspan="2">
                        <input name="Type"  readonly  title="报价方式" oc="text" class="edit form-control transparent" f-options="{'code':'Type','type':'number','etype':'editable','len':''}" verify="{'title':'报价方式','number':true,'required':true}">
                    </td>
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
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <!--装货费-->
                <tr style="height: 26px;" class="OnLoadPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="2">报价方式</td>
                    <td class="td_name" colspan="3" >报价单号(装货)</td>
                    <td class="td_name" colspan="3" >报价公司(装货)</td>
                    <td class="td_name" colspan="2">价格(装货)</td>
                </tr>
                <tr   style="height: 26px;" class="OnLoadPrice hide" fb-options="{'rowid':'OnLoadPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="OnLoadPrice">
                    <td class="" colspan="2">
                        <input name="Type"  readonly  title="报价方式" oc="text" class="edit form-control transparent" f-options="{'code':'Type','type':'number','etype':'editable','len':''}" verify="{'title':'报价方式','number':true,'required':true}">
                    </td>
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
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <!--卸货费-->
                <tr style="height: 26px;" class="OffLoadPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="2">报价方式</td>
                    <td class="td_name" colspan="3" >报价单号(卸货)</td>
                    <td class="td_name" colspan="3" >报价公司(卸货)</td>
                    <td class="td_name" colspan="2">价格(卸货)</td>
                </tr>
                <tr   style="height: 26px;" class="OffLoadPrice hide" fb-options="{'rowid':'OffLoadPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="OffLoadPrice">
                    <td class="" colspan="2">
                        <input name="Type"  readonly  title="报价方式" oc="text" class="edit form-control transparent" f-options="{'code':'Type','type':'number','etype':'editable','len':''}" verify="{'title':'报价方式','number':true,'required':true}">
                    </td>
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
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <!--保险费-->
                <tr style="height: 26px;" class="InsurancePrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="2">报价方式</td>
                    <td class="td_name" colspan="3" >报价单号(保险)</td>
                    <td class="td_name" colspan="3" >报价公司(保险)</td>
                    <td class="td_name" colspan="2">价格(保险)</td>
                </tr>
                <tr   style="height: 26px;" class="InsurancePrice hide" fb-options="{'rowid':'InsurancePrice','initialRows':'1','maxrows':'10','content':''}" nrowid="InsurancePrice">
                    <td class="" colspan="2">
                        <input name="Type"  readonly  title="报价方式" oc="text" class="edit form-control transparent" f-options="{'code':'Type','type':'number','etype':'editable','len':''}" verify="{'title':'报价方式','number':true,'required':true}">
                    </td>
                    <td colspan="3">
                        <a><input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
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
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <!--税费-->
                <tr style="height: 26px;" class="TaxPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="2">报价方式</td>
                    <td class="td_name" colspan="3" >报价单号(税费)</td>
                    <td class="td_name" colspan="3" >报价公司(税费)</td>
                    <td class="td_name" colspan="4">价格(税费)</td>
                </tr>
                <tr   style="height: 26px;" class="TaxPrice hide" fb-options="{'rowid':'TaxPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="TaxPrice">
                    <td class="" colspan="2">
                        <input name="Type"  readonly  title="报价方式" oc="text" class="edit form-control transparent" f-options="{'code':'Type','type':'number','etype':'editable','len':''}" verify="{'title':'报价方式','number':true,'required':true}">
                    </td>
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
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <!--附加费-->
                <tr style="height: 26px;" class="AdditionPrice hide" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="2">报价方式</td>
                    <td class="td_name" colspan="3" >报价单号(附加费)</td>
                    <td class="td_name" colspan="3" >报价公司(附加费)</td>
                    <td class="td_name" colspan="2">价格(附加费)</td>
                </tr>
                <tr   style="height: 26px;" class="AdditionPrice hide" fb-options="{'rowid':'AdditionPrice','initialRows':'1','maxrows':'10','content':''}" nrowid="AdditionPrice">
                    <td class="" colspan="2">
                        <input name="Type"  readonly  title="报价方式" oc="text" class="edit form-control transparent" f-options="{'code':'Type','type':'number','etype':'editable','len':''}" verify="{'title':'报价方式','number':true,'required':true}">
                    </td>
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
		<table class="FormTable Y_alter FormTable6"  >
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
    <!--#include file="/Controls/PMS/footer.aspx"-->
    <!--通用页尾结尾-->

    <script type="text/javascript">
        function _DoPageLoad()
        {
            initTableForm( $( '#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860' ), false, function ()
            {
                FOrderPriceShow( NSF.UrlVars.Get( 'id', location.href ) );
            } );
        }
        var reqeustDone = function () {		/*所有JS加载完成以后执行*/
            if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
            if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
            setTimeout("_DoPageLoad(),autoHead()", 300);//初始化固定头部的宽度
            setTimeout("hoverTips();", 3000);  /*input的tips*/

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
        };
        var _jsUrl = "<%=MinifyUrl("FormJs")%>";
    </script>
    <script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/PMS/JS.aspx"-->
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
