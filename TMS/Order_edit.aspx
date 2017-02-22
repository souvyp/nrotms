<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>创建订单-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--#include file="/Controls/Meta.aspx"-->
    <!--#include file="/Controls/TMS/CSS.aspx"-->
    <link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="Order_edit">
    <!--额外的css开始-->
    <!--#include file="/Controls/CSS.aspx"-->
    <!--额外的css结尾-->

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

    <div  class="formcontainer" style="display: none;">
        <!-- 表单开始-->
        <script language="javascript">
            var __saveNdtCfg = '{"main":{"insertVml":"tms_0024","updateVml":"tms_0024","queryVml":"tms_0101"}}';
        </script>
        <table  class="FormTable Y_alter" style="width: 100%;" id="ef41d4b8-88a5-4954-9d0d-b1dc6a71f860" path="OTMS/eofxvafl" code="Order_edit">
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
                    <td class="text-left" rowspan="1" colspan="4" style="padding-left:0;width:100%;">
                        <div style="padding-top:20px;" >
                            <div style="padding-left: 3px; background-color: #f27302;">
                                <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">创建订单</p>
                            </div>
                        </div>
                    </td>
                    <td colspan="6" style="border: 0; border-bottom: 1px solid #e1e6eb;">
                        <input type="hidden" name="id">
                        <div class="toolbar">
                            <div style="text-align: right;" class="button_workflow">
                                <a class="btn btn-red footKeepBtn" href="javascript:void(0);"  onclick="GetCheckboxVal(this)">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>
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
                 
                <tr style="height: 26px; display: none">
                    <td class="styleCenter td_name" rowspan="1"  style="font-size: 18px;">
                        <input name="OrderID" title="订单编号" oc="text" class="edit form-control  transparent" value="0" f-options="{'code':'OrderID','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">单据编号</td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="Code" title="单据编号" oc="text" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Code','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">合同编号</td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="PactCode" title="合同编号" oc="text" class="edit form-control data transparent" f-options="{'code':'PactCode','type':'text','etype':'editable','len':'100'}" verify="{'title':'合同编号','length':'100','required':true,'textarea1':true,'validate':'{\'pattern\': \'^[a-zA-Z0-9\-]*$\',\'message\': \'格式不正确，请重新输入！\'}'}">
                    </td>
                </tr>
                <tr>
                     <td class="td_name">制单日期</td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="CreateTime" title="制单日期" style="font-size:12px;" placeholder="系统自动生成" oc="date" disabled class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'CreateTime','type':'date','etype':'editable','len':'50'}" verify="">
                    </td>
                    <td class="td_name">制单人</td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="Creator" title="制单人" oc="text" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Creator','type':'text','etype':'editable','len':'100'}" verify="{}">
                    </td>
                </tr>
                <tr>
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name" >
                        <!--a href="javascript:void(0);" onclick="showModalWindow(this,'客户名称')" class="edit" f-options="{'code':'CustomerID','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'CustomerSelector.aspx','vals':'CustomerName=Name,CustomerID=id,CompanyID=CompanyID','modalWindow':'1'}" verify="{}">
                            
                        </a-->
						<input type="hidden" name="CustomerID" class="data">客户名称
						<input type="hidden" name="CompanyID" />
                    </td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="CustomerName" readonly type="text" class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">是否提货</td>
                    <td class="" colspan="">                       
                        <ul class="list-inline">
                            <li>
                                <label><input type="radio" name="IsPick" value="1">是</label></li>
                            <li>
                                <label><input type="radio" name="IsPick" value="0" checked>否</label></li>
                        </ul>                   
                    </td> 
                    <td class="td_name">是否装货</td>
                    <td class="" colspan="2">                       
                        <ul class="list-inline">
                            <li>
                                <label><input type="radio" name="IsOnLoad" value="1">是</label></li>
                            <li>
                                <label><input type="radio" name="IsOnLoad" value="0" checked>否</label></li>
                        </ul>                   
                    </td> 
                </tr>
                <tr style="height: 26px;">
                  <td class="td_name">发货省/市/区</td>
                  <td class="" colspan="9" >
                      <div class="bs-chinese-region flat dropdown" data-submit-type="id" data-min-level="1" data-max-level="3">
                                <input type="text" class="edit form-control transparent" name="FromName" id="FromName" placeholder="选择你的地区" data-toggle="dropdown" readonly="" verify="{'title':'省/市/区','length':'300','required':true}">
                                <input type="hidden" name="FromProvince" class="data">
                                <input type="hidden" name="FromCity" class="data">
                                <input type="hidden" name="FromDistrict" class="data">
                                <div class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                    <div>
                                        <ul class="nav nav-tabs" role="tablist">
                                            <li role="presentation" class="active"><a href="#fromprovince" data-next="city" role="tab" data-toggle="tab">省份</a></li>
                                            <li role="presentation"><a href="#fromcity" data-next="district" role="tab" data-toggle="tab">城市</a></li>
                                            <li role="presentation"><a href="#fromdistrict" data-next="street" role="tab" data-toggle="tab">县区</a></li>
                                        </ul>
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane active" id="fromprovince">--</div>
                                            <div role="tabpanel" class="tab-pane" id="fromcity">--</div>
                                            <div role="tabpanel" class="tab-pane" id="fromdistrict">--</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                  </td>
                </tr> 
                <tr>
                    <td class="td_name">发货时间</td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="FromTime" title="发货时间" oc="date" class="laydate-icon data edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD hh:mm' } )" f-options="{'code':'FromTime','type':'date','etype':'editable','len':'50'}" verify="{'title':'发货时间','length':'50','required':true}">
                    </td>
                    <td class="td_name">联系电话</td>
                     <td class="">
                        <input name="FromContact" title="发货人联系电话"  oc="text" class="edit form-control data transparent" f-options="{'code':'FromContact','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','required':true,'textarea1':true,'validate':'{\'pattern\': \'^((([0\+][0-9]{2,3}-)?(0[0-9]{2,3})-)?([0-9]{7,8})?(([0-9]{7,8})(-([0-9]{3,}))?))?(([1][3|4|5|7|8][0-9])[0-9]{8})?$\',\'message\': \'格式不正确，请重新输入！\'}'}">
                    </td>
                    <td class="td_name">
                        <a href="javascript:void(0);" onclick="showModalWindow(this,'发货地址',$( 'input[name=CustomerID]' ));" class="edit" f-options="{'code':'id','type':'dialogue','etype':'editable','len':'32','cls':'frame','url':'FromSelector.aspx','vals':'From=Address,FromProvince=ProvinceID,FromCity=CityID,FromDistrict=DistrictID,FromCityName=CityName,FromDistrictName=DistrictName,FromProvinceName=ProvinceName,FromContact=Phone,FromName=FromName','modalWindow':'1'}" verify="{}">发货地址</a>
                    </td>
                    <td class="" rowspan="1" colspan="2">
                        <input name="From" title="发货地址"  class="writeInput" placeholder="点击“发货地址”进行选择或手动书写" oc="text" class="edit form-control data transparent form_add" f-options="{'code':'From','type':'text','etype':'editable','len':'600'}" verify="{'title':'发货地址','length':'600','required':true}">
                    </td>
                </tr>
                <tr>
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;">
                     <td class="td_name">
                        <a href="javascript:void(0);" onclick="showModalWindow(this,'收货方',$( 'input[name=\'CustomerID\']' ))" class="edit" f-options="{'code':'EndUserID','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'EndUserSelector.aspx','vals':'EndUserName=EndUserName,ToName=FromName,ToContact=Phone,To=Address,ToProvince=ProvinceID,ToCity=CityID,ToDistrict=DistrictID','modalWindow':'1'}" verify="{}">
                            <input type="hidden" name="EndUserID" class="data">收货方
                        </a>
                    </td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="EndUserName" class="writeInput"  placeholder="点击“收货方”进行选择或手动书写" class="edit form-control data transparent" f-options="{'code':'EndUserName','type':'text','etype':'editable','len':'50'}" verify="{'title':'收货方','length':'50','required':true}">
                    </td>
                    <td class="td_name">是否送货</td>
                    <td class="" colspan="">
                        <ul class="list-inline">
                            <li>
                                <label><input type="radio" name="IsDelivery" value="1">是</label></li>
                            <li>
                                <label><input type="radio" name="IsDelivery" value="0" checked>否</label></li>
                        </ul>   
                    </td>
                    <td class="td_name">是否卸货</td>
                    <td class="" colspan="2">                       
                        <ul class="list-inline">
                            <li>
                                <label><input type="radio" name="IsOffLoad" value="1">是</label></li>
                            <li>
                                <label><input type="radio" name="IsOffLoad" value="0" checked>否</label></li>
                        </ul>                   
                    </td>                    
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">到货省/市/区</td>
                    <td class="" colspan="9" >
                      <div class="bs-chinese-region flat dropdown" data-submit-type="id" data-min-level="1" data-max-level="3">
                                <input type="text" class="edit form-control transparent" name="ToName" id="ToName" placeholder="选择你的地区" data-toggle="dropdown" readonly="" verify="{'title':'省/市/区','length':'300','required':true}">
                                <input type="hidden" name="ToProvince" class="data">
                                <input type="hidden" name="ToCity" class="data">
                                <input type="hidden" name="ToDistrict" class="data">
                                <div class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                    <div>
                                        <ul class="nav nav-tabs" role="tablist">
                                            <li role="presentation" class="active"><a href="#toprovince" data-next="city" role="tab" data-toggle="tab">省份</a></li>
                                            <li role="presentation"><a href="#tocity" data-next="district" role="tab" data-toggle="tab">城市</a></li>
                                            <li role="presentation"><a href="#todistrict" data-next="street" role="tab" data-toggle="tab">县区</a></li>
                                        </ul>
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane active" id="toprovince">--</div>
                                            <div role="tabpanel" class="tab-pane" id="tocity">--</div>
                                            <div role="tabpanel" class="tab-pane" id="todistrict">--</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                  </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">到货时间</td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="ToTime" title="到货时间" oc="date" class="laydate-icon edit data" onclick="TrigerDateEvent(this, { format: 'YYYY-MM-DD hh:mm',min:$('input[name=\'FromTime\']').val() })" f-options="{'code':'ToTime','type':'date','etype':'editable','len':'50'}" verify="{'title':'到货时间','length':'50','required':true}">
                    </td>
                    <td class="td_name">联系电话</td>
                      <td class="">
                        <input name="ToContact"  title="收货方联系电话"  oc="text" class="edit form-control data transparent" f-options="{'code':'ToContact','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','required':true,'textarea1':true,'validate':'{\'pattern\': \'^((([0\+][0-9]{2,3}-)?(0[0-9]{2,3})-)?([0-9]{7,8})?(([0-9]{7,8})(-([0-9]{3,}))?))?(([1][3|4|5|7|8][0-9])[0-9]{8})?$\',\'message\': \'格式不正确，请重新输入！\'}'}">
                      </td>
                    <td class="td_name">收货地址</td>
                    <td class="" rowspan="1" colspan="2">
                        <input name="To" title="收货地址" class="writeInput" placeholder="点击“收货地址”进行选择或手动书写" oc="text" class="edit form-control data transparent" f-options="{'code':'To','type':'text','etype':'editable','len':'600'}" verify="{'title':'收货地址','length':'600','required':true}">
                    </td>
                </tr>

                <tr>
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;">
					<td class="td_name">计费模式</td>
					<td class="" colspan="4">
						<input type="hidden" name="ChargeMode" value="0" class="data">
						<select name="ChargeMode_id"  class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);Unit(this)" f-options="{'code':'ChargeMode','type':'combobox','etype':'','len':''}" verify="{'title':'计费模式','length':'','textarea1':true,'required':true}">
						  <option value="">-------------------------</option>
						  <option value="1">重量</option>
						  <option value="2">体积</option>
						  <option value="3">数量</option>
						</select>
					 </td>
					<td class="td_name">价格单位</td>
                   <td class="" colspan="4">
					<input type="hidden" name="PriceUnit" value="0" class="data">
					<select name="PriceUnit_id"  class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);UnitType(this)" f-options="{'code':'PriceUnit','type':'combobox','etype':'','len':''}" verify="{'title':'价格单位','length':'','textarea1':true,'required':true}">
					  <option value="">-------------------------</option>
					  <!--#include file="/Controls/Unit.aspx"-->
					</select>
				  </td>
                </tr>
                
                <tr style="height: 26px;">
                    <td class="td_name">运输模式</td>
                    <td class="" colspan="4">
                        <ul class="list-inline">
                            <li>
                                <label><input type="radio" name="TransportMode" value="1" onclick="removeCarType()" checked>零担</label></li>
                            <li>
                                <label><input type="radio" name="TransportMode" onclick="showCarType_length(this)" value="2"  >整车</label></li><!--onclick="ShowCars(this)"-->
                        </ul>
                    </td>
                    <td class="td_name">包装方式</td>
                        <td class="" colspan="9">
                            <ul class="list-inline">
                                <li>
                                    <label><input type="radio"  name="PackageMode" value="1" checked>散箱</label></li>
                                <li>
                                    <label><input type="radio"  name="PackageMode" value="2">托盘或木箱</label></li>
                                <li>
                                    <label><input type="radio"  name="PackageMode" value="3">托盘、木箱或不规则形状</label></li>
                            </ul>
                        </td>
                </tr>
                <tr style="height: 26px; display:none;" name="CarInfo">
                    <td class="td_name">车型</td>
                    <td class="" colspan="4">
                        <input type="hidden" name="CarType" readonly value="0" class="edit form-control data transparent">
                        <input type="text" name="CarTypeName" readonly class="edit form-control transparent">
                    </td>
                    <td class="td_name">规格/车长（米）</td>
                    <td class="" colspan="4">
                        <input type="text" name="CarLengthName" readonly class="edit form-control transparent">
                        <input type="hidden" name="CarLength" readonly class="edit form-control data transparent">
                    </td>
                </tr>
				<tr style="height: 26px; display:none;" name="CarInfo">
                    <td class="td_name">容积（立方米）</td>
                    <td class="" colspan="4">                     
                        <input type="text" name="CarVolume" readonly class="edit form-control data transparent">
                    </td>
                    <td class="td_name">载重（吨）</td>
                    <td class="" colspan="4">
                        <input type="text" name="CarWeight" readonly class="edit form-control data transparent">
                    </td>
                </tr>
                <tr style="height: 26px;">
                  <td class="td_name">货物分类</td>
                  <td class="" rowspan="1" colspan="4">
                  	<input type="hidden"  name="GoodsCategory" class="data" verify="" />
                  	<input type="hidden" name="markSign" style="border:none;width:0;height:0;"  />
                      <ul class="list-inline">
                        <li><input type="checkbox"  class="control-check" name="Goodscategory" value="1"  />普通货物</li>
                        <li><input type="checkbox"  class="control-check" name="Goodscategory" value="2" />危险品</li>
                        <li><input type="checkbox"  class="control-check" name="Goodscategory" value="4" />温控货物</li>
                    </ul>
                  </td>
                  <td class="td_name">是否保价</td>
                  <td class="" colspan="4">
                      <ul class="list-inline">
                          <li>
                              <label><input type="radio"  name="IsInsurance" value="1" checked>是</label></li>
                          <li>
                              <label><input type="radio"  name="IsInsurance" value="0">否</label></li>
                      </ul>
                  </td>
                </tr>
                <tr>
					<td class="td_name">
                        <a href="javascript:void(0);" onclick="showModalWindow(this,'标识',$('input[name=\'CSymbolID\']'))" class="edit" f-options="{'code':'id','type':'dialogue','etype':'editable','len':'32','cls':'frame','url':'MSymbolSelector.aspx','vals':'CustomerSymbolID=id,CustomerSymbolName=name','modalWindow':'1'}" verify="{}">客户标识
                        </a>
                        <input type="hidden" name="CustomerSymbolID" class="data">
                        <input type="hidden" name="CSymbolID" value="1">
                    </td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="CustomerSymbolName" title="客户标识" readonly class="writeInput" placeholder="点击“客户标识”进行选择" oc="text" class="edit form-control transparent" f-options="{'code':'CustomerSymbolName','type':'text','etype':'editable','len':'600'}" verify="{'title':'客户标识','length':'600'}">
                    </td>
                    <td class="td_name" colspan="1">设备编号</td>
                    <td colspan="4">
                    	<input name="DeviceCode" onmouseout="validateDCode(this)"  class="edit form-control transparent data" f-options="{'code':'DeviceCode','type':'richtext','etype':'','len':''}" verify="{'title':'DeviceCode','length':'','textarea1':true}"></input>
                    </td>                    
				</tr>
                <tr>
                    <td class="td_name">
                        预付款
                    </td>
                    <td class="" rowspan="1" colspan="4">
                        <input name="Payment" title="预付款"  class="writeInput" placeholder="" oc="text" class="edit form-control transparent data" f-options="{'code':'Payment','type':'text','etype':'editable','len':'600'}" verify="{'title':'预付款','length':'600'}">
                    </td>
                    <td class="td_name" colspan="1">货到付款</td>
                    <td colspan="4">
                        <input name="Payable"   class="edit form-control transparent data" f-options="{'code':'Payable','type':'richtext','etype':'','len':''}" verify="{'title':'货到付款','length':'','textarea1':true}"></input>
                    </td>                    
                </tr>
                <tr>
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr>
                    <td class="td_name">
                       	 备注
                    </td>
                    <td colspan="9">
                        <input name="Descriptions"  class="edit form-control transparent data" f-options="{'code':'Descriptions','type':'richtext','etype':'','len':''}" verify="{'title':'Descriptions','length':'','textarea1':true}"></input>
                        <input type="hidden" name="GoodsLst" title="物品信息" class="data">
                  </td>
                </tr>
                <tr>
                    <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
                </tr>
                <tr style="height: 26px;" class="" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                    <td class="td_name" colspan="" >物品编号</td>
                    <td class="td_name" colspan="" >物品名称</td>
                    <td class="td_name" colspan="2">规格</td>
                    <td class="td_name">总重量（公斤）</td>
                    <td class="td_name">总体积（立方米）</td>
                    <td class="td_name">物品数量</td>
                    <td class="td_name" >价值（元）</td>
					<td class="td_name">批次</td>
                    <td class="td_name" style="text-align: right;">
                        <a href="javascript:void(0);" tar="TMS_OrderGoods" name="add" class="button edit" executecode="%23add%23" f-options="{'code':'add','type':'_button','etype':'','len':''}" verify="{}">新增</a>
                    </td>
                </tr>
                <tr   style="height: 26px;display:none" class="" fb-options="{'rowid':'TMS_OrderGoods','initialRows':'1','maxrows':'10','content':''}" rowid="TMS_OrderGoods">
                    <td colspan="">
                        <input type="text" placeholder="点击进行物品选择" style="cursor:pointer;" readonly onclick="showWindow( this, '物品编号', $( 'input[name=CompanyID]' ), '', GoodsSelect )" title="物品编号" oc="dialogue" class="edit form-control transparent" name="GoodsID" f-options="{'code':'GoodsID','type':'dialogue','etype':'editable','len':'8','cls':'frame','url':'GoodsSelector.aspx','vals':'GoodsID=id,Name=Name,SPC=SPC,Weight=Weight,Volume=Volume,weight=Weight,volume=Volume,UnitName=UnitName,Price=Price,price=Price,Qty=Qty,Code=Code,Unit=Unit','modalWindow':'1'}" verify="{'title':'物品编号','length':'8','required':true}">
                    </td>
                    <td colspan="">
                        <input name="Name" title="物品名称" readonly oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'50'}" verify="{'title':'物品名称','length':'50','required':true}">
                        <input type="hidden" name="Code" title="物品编号">
                        <input type="hidden" name="Unit" title="计量单位">
                    </td>
                    <td colspan="2">
                        <input name="SPC" title="规格" readonly oc="text" class="edit form-control transparent" f-options="{'code':'SPC','type':'text','etype':'editable','len':'50'}" verify="{'title':'规格','length':'50','required':true}">
                    </td>
                    
                    <td class="">
                        <input name="Weight" readonly="readonly"   title="重量" oc="number" class="edit form-control transparent" f-options="{'code':'Weight','type':'number','etype':'editable','len':''}" verify="{'title':'重量','number':true}">
                        <input name="weight" type="hidden" />
                    </td>
                    <td>
                        <input name="Volume" readonly="readonly"   title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                        <input name="volume" type="hidden" />
                    </td>
                    <td class="">  
                        <input name="Qty"   onfocus="quickQueryCust(event,this)" class="writeInput edit form-control transparent " placeholder="输入数量,最多七位"  title="物品数量" oc="text" class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                    </td>
                    <td class="" >
                        <input name="Price" title="物品价值"  readonly   oc="text" class="edit form-control transparent" f-options="{'code':'Price','type':'text','etype':'editable','len':'50'}" verify="{'title':'Price','length':'50','required':true}">
                        <input name="price" type="hidden" />
                    </td>
					<td class="">
                        <input name="BatchNo"  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'text','etype':'editable','len':''}" verify="{'title':'批次'}">
                    </td>
                   <td name="button" class="" style="text-align: right;">
                    <a href="javascript:void(0);" tar="TMS_OrderGoods" class="button edit" onclick="delect_zero(this)" executecode="%23delete%23" f-options="{'code':'','type':'_button','etype':'','len':''}" verify="{'title':'','length':'','textarea1':true}">删除</a>
                  </td>
                </tr>

                <tr   style="height: 26px;display:none" class="" fb-options="{'rowid':'AutoPlan','initialRows':'1','maxrows':'10','content':''}" nrowid="AutoPlan">
                    <td colspan=""></td>
                </tr>
                <tr style="height: 26px;">
                      <td class="td_name"  colspan="4">补差</td>
                      <td class="" rowspan="1">
                            <input name="WeightAddition"   onkeyup="weightAddtion();getRex(this)" title="重量补差" oc="text" class="edit form-control transparent" f-options="{'code':'WeightAddition','type':'number','etype':'editable','len':''}" verify="">
                      </td>
                      <td class="" colspan="">
                           <input name="VolumeAddition"  onkeyup="volumeAddtion();getRex(this)" title="体积补差" oc="text" class="edit form-control transparent" f-options="{'code':'VolumeAddition','type':'number','etype':'editable','len':''}" verify="">
                      </td>
                      <td colspan="4"></td>
                </tr>
                <tr   style="height: 26px;" class="" >
                    <td colspan="4" class="td_name">合计</td>
                     <td>
                        <input name="TotalWeight" title="总重量"  readonly  oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Weight%5D%7D%3Bvar%20WeightAddition%3D%24%28%27input%5Bname%3D%22WeightAddition%22%5D%27%29.val%28%29%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%20if%28WeightAddition%3D%3D%27%27%29%7B%20sum+%3DparseFloat%28arr%5Bi%5D%29%3B%7Delse%7B%20%20if%28i%3D%3D0%29%20%7B%20sum%20+%3D%20parseFloat%28WeightAddition%29%3B%20%7D%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%284%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'calculation','len':'50'}" verify="">
                    </td>
                    <td>
                        <input name="TotalVolume" title="总体积" readonly  oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Volume%5D%7D%3Bvar%20VolumeAddition%3D%24%28%27input%5Bname%3D%22VolumeAddition%22%5D%27%29.val%28%29%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%20if%28VolumeAddition%3D%3D%27%27%29%7B%20sum+%3DparseFloat%28arr%5Bi%5D%29%3B%7Delse%7B%20%20if%28i%3D%3D0%29%20%7B%20sum%20+%3D%20parseFloat%28VolumeAddition%29%3B%20%7D%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%286%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
                    </td>
                    <td >
                        <input name="TotalQty" title="总数量" readonly oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Qty%5D%7D%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseInt%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseInt%28arr%5Bi%5D%29%20%3B%7D%7D" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
                    </td>
                     <td>
                        <input name="GoodsValue" title="总价值"   oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Price%5D%7D%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%282%29%3B"  class="edit form-control transparent" f-options="{'code':'GoodsValue','type':'number','etype':'editable','len':''}" 
                    </td>
                    <td colspan="2" ></td>
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
                setTimeout(' selectBs();Calculator();GoodsCategory();orderEdit();ifChecked();ifBoxChecked();autoHead();CustomerAddrAdd();', 300);
                //生成新单据时复制物品信息
                $('tr[nrowid="AutoPlan"]')[0].isDirty = true;
                $('tr[nrowid="AutoPlan"] td:eq(0)').append('<input type = "hidden" name="id" value="'+uuid()+'" />');
            }, 'dbo.fn_pub_user_User2CompanyID(@Operator,0)' )
        }
        var reqeustDone = function ()
        {		/*所有JS加载完成以后执行*/
            if ( typeof ( initHeader ) != "undefined" ) initHeader();					/*初始化页面通用头部*/
            if ( typeof ( initFooter ) != "undefined" ) initFooter();                   /*初始化页面通用底部*/
            setTimeout('_DoPageLoad()', 300);

            $( '.shr' ).click( function ()
            {
                if ( $( 'input[name="EndUserName"]' ).val() == "" )
                {
                    alert( '请先选择收货方！' );
                }else{
                    showModalWindow(this,'收货地址',$( 'input[name=EndUserID]' ));
                }
            } );
        }

        function weightAddtion() {
            var WeightAddition=$('input[name="WeightAddition"]').val();
            var sum=0; 

            $('tr[nrowid="TMS_OrderGoods"] input[name="Weight"]').each(function(index) {
                var _val = $(this).val();
                if (_val == '') {
                    sum+=parseFloat('0');
                } else if (WeightAddition == '') { 
                    sum+=parseFloat(_val);
                } else {  
                    if (index==0) { 
                        sum += parseFloat(WeightAddition); 
                    } 
                    sum += parseFloat(_val) ;
                }
            });
            $('input[name="TotalWeight"]').val(sum.toFixed(4));
            
        }

        function volumeAddtion() {
            var VolumeAddition=$('input[name="VolumeAddition"]').val();
            var sum=0; 

            $('tr[nrowid="TMS_OrderGoods"] input[name="Volume"]').each(function(index) {
                var _val = $(this).val();
                if (_val == '') {
                    sum+=parseFloat('0');
                } else if (VolumeAddition == '') { 
                    sum+=parseFloat(_val);
                } else {  
                    if (index==0) { 
                        sum += parseFloat(VolumeAddition); 
                    } 
                    sum += parseFloat(_val) ;
                }
            });
            $('input[name="TotalVolume"]').val(sum.toFixed(6));
        }

        function validateDCode(input) {
            var _value = $(input).val();
            if (_value == '') {
                _value = 0;
            }
            var pmls = '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0220","paras":[{"name" : "DeviceCode", "value" : '+ _value +'}]}]';
            NSF.System.Network.Ajax( '/Portal.aspx',
                pmls,
                'POST',
                false,
                function ( result, data )
                {
                    if (data[0].result) {
                        if (data[0].rs[0].rows[0].Check_Result == '-510062001') {
                            alert('设备不存在!');
                            $(input).val('');
                        } else if (data[0].rs[0].rows[0].Check_Result == '-510062002') {
                            alert('设备正在使用,请使用其他设备!');
                            $(input).val('');
                        }
                    }
                } );
        }
        
        
        var _jsUrl = "<%=MinifyUrl("FormJs")%>";
   
    </script>
    <script src="/assets/js/jquery-1.11.1.min.js"></script>
    <!--#include file="/Controls/TMS/JS.aspx"-->

    <script src="/assets/request_minify.js"></script>
    <style type="text/css">
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
        }

        input[type="number"]{-moz-appearance:textfield;}
        #laydate_hms{display:block !important}
    </style>
</body>
</html>
