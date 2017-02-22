<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<%
string did = Request.QueryString["did"];
string sTitle = "";

if (did == "1")
{
	sTitle = "市内待调度订单详情";
}
else
{
	sTitle = "长途待调度订单详情";
}
%>
<!doctype html>
<html>
<head>
    <title><%=sTitle%>-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="/assets/js/csdu.queue.js"></script>
    <!--#include file="/Controls/Meta.aspx"-->
</head>
<%
if (did == "1")
{
	%>
	<body onload="autoHead()" code="OrderSend">
	<%
}
else
{
	%>
	<body onload="autoHead()" code="OrderLongSend">
	<%
}
%>
    <!--额外的css开始-->
    <!--#include file="/Controls/CSS.aspx"-->
    <!--#include file="/Controls/TMS/CSS.aspx"-->
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

        .jptable tr td,.line_chaidan tr td{
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
         .panel:hover {
              background:#eee;
            }

            .hoverH4 a:hover {
                color: #008fbf !important;
            }
        label{ color:#888 !important; }
    </style>
    <!--额外的css结尾-->
    <link href="../PMS/city/css/cityLayout.css" type="text/css" rel="stylesheet">
    <!-- 通用对话框开始-->
    <div class="modal fade text-center" id="win-Common-Dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="content" id="fromTo">
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
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    <%--<button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>--%>
                    <input type="hidden" name="IsSend">

                    <h4 class="modal-title text-left" id="myModalLabel">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">发送订单</p>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    是否确定调度
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;"><!--ScheduleOrder(0)-->
                    <button type="button" class="btn btn-default   footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="ScheduleOrder(0)"><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left: 2px;"></span></button>
                    <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left: 2px; color: #888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
    <!--拆单开始-->
    <div class="modal fade" id="splitModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width:70%">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    <h4 class="modal-title text-left" id="myModalLabel">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">拆分订单</p>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    <div>
                        <div>
                            <p>提交订单前，请您先核对订单预览效果。总拆单数：<span class="qtynum qty-total"></span></p>
                        </div>
                        <div class="splitline">
                            <div>
                                <p><img src="/images/splitline.png">&nbsp;线路拆单预览</p>
                            </div>
                            <div class="line-dash"></div>
                            <div>
                                <ul class="ul-line">
                                <li><img src="/images/split1.png"><span>起始地：<p class="fromAddress"></p></span></li>
                                <li class="last"><img src="/images/split2.png"><span>目的地：</span><p class="toAddress"></p></li>
                                </ul>
                            </div>
                        </div>

                        <div class="splitnum">
                            <div>
                            <p><img src="/images/splitline.png">&nbsp;数量拆单预览</p>
                            </div>
                            <div class="line-dash"></div>
                            <div class='splitnumdata'>
                                <ul class="list-inline">
                                    <li style="width:35%">物品名称</li>
                                </ul>
                                <div class="line-dash"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                    <button type="button" class="btn btn-default   footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="ScheduleOrder(1)"><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left: 2px;"></span></button>
                    <button type="button" class="btn btn-default "  data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="" o=>关闭</span><span class="glyphicon glyphicon-remove" style="margin-left: 2px; color: #888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
    <!--拆分数量-->
    <div class="modal fade" id="splitQtyModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="height:235px;">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    <h4 class="modal-title text-left" id="myModalLabel">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">拆分数量</p>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group col-md-12">
                        <div class="col-md-10">
                            <label>物品名称：<span name="GoodsName"></span></label>
                        </div>
                        <div class="col-md-10">
                            <label>总数量：<span name="totalQty"></span><span class="hide" name="ListID"></span></label>
                        </div>
                        <div class="clearfix"></div>
                        <br>
                        <div class="col-md-2 qty">
                            <input type="text"  class="form-control qtyinput" placeholder="">
                        </div>
                        <div class="col-md-2 qty">
                            <input type="text"  class="form-control qtyinput" placeholder="">
                        </div>
                        <div class="col-md-2" >
                            <a href="javascript:void(0)" style="color:#F27302;" onclick="addText(this)">
                              <div class="glyphicon glyphicon-plus" style="vertical-align: -webkit-baseline-middle;" ></div>   
                            </a>
                            &nbsp;&nbsp;
                            <a href="javascript:void(0)" onclick="delText(this)" style="color:#F27302;display:none">
                              <div class="glyphicon glyphicon-minus" style="vertical-align: -webkit-baseline-middle;" ></div>   
                            </a>
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
    
    <!--拆单结束-->

    <!--通用头部文件开始-->
    <!--#include file="/Controls/TMS/header.aspx"-->
    <!--通用头部文件结尾-->

    <!-- 模板开始-->
    <%--<script id="jplist-template" type="text/x-template">--%>
    <div class="list-item box jplist-panel tabbtn">
        <div class="chaidan">
            <!-- block right -->
            <table class="jptable">
                <thead style="position:fixed;z-index:1;padding-right:25px;">
                    <tr class="td-container tr-fixed" style="border-bottom: 1px solid #ddd;">
                        <td colspan="8" style="width:100%;border-bottom:0;">
                            <div style="height:100%;width:100%;background-color:white;border:1px solid white">
                                <div style="background-color: #f27302;">
                                    <div>
                                         <p style="margin-left: 3px; padding-left: 10px; margin-bottom: 25px; margin-top: 25px; background-color: white; color: #888; font-size: 14px;" class="titles"><%=sTitle%></p>
                                    </div>
                                    <div style="position: absolute; right: 0;top: 27px">
                                        <button type="button" class="btn footKeepBtn" onclick="IsSend_p()">调度&nbsp;<span class="glyphicon glyphicon-ok-circle"></span></button>
                                        <button type="button" class="btn footKeepBtn" onclick="IsSplit()" style="display:none">拆单&nbsp;<span class="glyphicon glyphicon-ok-circle"></span></button>
                                        <button type="button" class="btn" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt" style="transform: rotateY(180deg);"></span></button>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <!--<tr>
                        <td rowspan="1" colspan="8" style="background-color: white;border:0;border-left:1px solid white !important; border-right:1px solid white !important;height: 15px;"></td>
                    </tr>-->
                </thead>
                <tbody style="position:absolute;top:76px;left:19px;right:17px">
                    <tr>
                        <td>
                            <div class="panel-group" id="accordion">
                                <div class="panel-body" style="padding:0;">
                                        <div class="formcontainer" style="display: block;">
                                            <!-- 表单开始-->
                                            <script language="javascript">
                                                var __saveNdtCfg = '{"main":{"insertVml":"","updateVml":"tms_0024","queryVml":"tms_0215"},"TMS_OrderGoods":{"insertVml":"","updateVml":"","queryVml":"tms_0030","deleteVml":""}}';
                                            </script>
                                            <table class="FormTable Y_alter" style="width: 100%;" id="ef41d4b8-88a5-4954-9d0d-b1dc6a71f860" path="OTMS/eofxvafl" code="eofxvafl">
                                                <colgroup>
                                                    <col style="width: 109px;">
                                                    <col style="width: 120px;" class="">
                                                    <col style="width: 120px;">
                                                    <col style="width: 120px;">
                                                    <col class="" style="width: 120px;">
                                                    <col style="width: 111px;" class="">
                                                </colgroup>
                                                <tbody>
                                                    <tr>
                                                        <td colspan="10" style="padding:0px">
                                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" style="font-family: '微软雅黑'; color: #888; font; font-size: 14px;">
                                                                <div class="panel panel-default" style="border-radius:0;box-shadow:none;border:none;">
                                                                    <div class="" style="background-color: transparent; padding: 10px; margin-bottom: -1px; border-bottom: 1px solid #eee;">
                                                                        <h4 class="panel-title hoverH4" style="font-family:'微软雅黑';color:#0099CC;">查看详情<span class="glyphicon glyphicon-menu-down" style="position:relative;top:2px;left:5px;"></span><span class="glyphicon glyphicon-menu-up" style="position:relative;top:2px;left:5px;display:none;"></span>
                                                                        </h4>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                  </tbody>
                                                  <tbody class="hideTbody" style="display:none;">
                                                    <tr>
                                                        <td rowspan="1" colspan="10" style="background-color: white;border:0;border-left:1px solid white !important;border-right:1px solid white !important; height: 15px;"></td>
                                                    </tr>
                                                   
                                                    <tr style="height: 26px; display: none">
                                                        <td class="styleCenter td_name" rowspan="1" colspan="6" style="font-size: 18px;">
                                                            <input name="OrderID" title="订单编号" oc="text" readonly  class="edit form-control transparent" value="0" f-options="{'code':'OrderID','type':'text','etype':'editable','len':'50'}" verify="{}">
                                                        </td>
                                                    </tr>
                                                    <tr style="height: 26px;">
                                                        <td class="td_name">单据编号</td>
                                                        <td class="" rowspan="1" colspan="4">
                                                            <input name="Code" title="单据编号" oc="text" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Code','type':'text','etype':'editable','len':'50'}" verify="{}">
                                                            <input type="hidden" name="GoodsLst" title="物品信息">
                                                        </td>
                                                        <td class="td_name">合同编号</td>
                                                        <td class="" rowspan="1" colspan="4">
                                                            <input name="PactCode" title="合同编号" readonly oc="text"   class="edit form-control data transparent" f-options="{'code':'PactCode','type':'text','etype':'editable','len':'50'}" verify="{'title':'合同编号','length':'100','required':true,'textarea1':true,'validate':'{\'pattern\': \'^[a-zA-Z0-9\-]*$\',\'message\': \'格式不正确，请重新输入！\'}'}">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                         <td class="td_name">制单日期</td>
                                                        <td class="" rowspan="1" colspan="4">
                                                            <input name="CreateTime" title="制单日期" placeholder="系统自动生成" oc="date" readonly class="laydate-icon edit" f-options="{'code':'CreateTime','type':'date','etype':'editable','len':'50'}" verify="">
                                                        </td>
                                                        <td class="td_name">制单人</td>
                                                        <td class="" rowspan="1" colspan="4">
                                                            <input name="Creator" title="制单人" oc="text" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Creator','type':'text','etype':'editable','len':'50'}" verify="{}">
                                                        </td>
                                                    </tr>
                                                    
                                                </tbody>
                                                <tbody>
                                                    <tr>
                                                        <td rowspan="1" colspan="10" style="background-color: white;border:0; border-left: 1px solid white !important;border-right: 1px solid white !important;height: 15px;"></td>
                                                    </tr>
                                                    <tr style="height: 26px;">
                                                        <td class="td_name">客户名称</td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="Name" readonly class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'50'}" verify="{'title':'CustomerName','length':'50','required':true}">
                                                            <input type="hidden" name="CustomerID" class="data">
                                                        </td>
                                                        <td class="td_name">是否提货</td>
                                                        <td class="" colspan="2">
                                                            <ul class="list-inline radiodata">
                                                                <li>
                                                                      <label><input type="radio" name="IsPick" value="1" checked>是 </li> </label>
                                                                <li>
                                                                      <label><input type="radio" name="IsPick" value="0">否 </li> </label>
                                                            </ul> 
                                                        </td>
                                                        <td class="td_name">是否装货</td>
                                                        <td class="" colspan="3">                       
                                                            <ul class="list-inline radiodata">
                                                                <li>
                                                                    <label><input type="radio" name="IsOnLoad" value="1"  checked>是</label></li>
                                                                <li>
                                                                    <label><input type="radio" name="IsOnLoad" value="0">否</label></li>
                                                            </ul>                   
                                                        </td> 
                                                    </tr>
                                                    <tr>
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
                                                        <td class="td_name">发货时间
                                                        </td>
                                                        <td class="" rowspan="" colspan="3">
                                                            <input name="FromTime"  onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD hh:mm' } )"   title="发货时间" oc="date" class="edit data"  f-options="{'code':'FromTime','type':'date','etype':'editable','len':'50'}" verify="{'title':'FromTime','length':'50','required':true}">
                                                        </td>
                                                        <td class="td_name">联系电话</td>
                                                        <td class="" colspan="2">
                                                            <input name="FromContact" title="发货人联系电话"  oc="text" class="edit form-control transparent data" f-options="{'code':'FromContact','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','required':true,'textarea1':true,'validate':'{\'pattern\': \'^((([0\+][0-9]{2,3}-)?(0[0-9]{2,3})-)?([0-9]{7,8})?(([0-9]{7,8})(-([0-9]{3,}))?))?(([1][3|4|5|7|8][0-9])[0-9]{8})?$\',\'message\': \'格式不正确，请重新输入！\'}'}">
                                                        </td>
                                                        <td class="td_name">
                                                            <a href="javascript:void(0);" onclick="showModalWindow(this,'发货地址',$( 'input[name=CustomerID]' ));"    class="edit" f-options="{'code':'id','type':'dialogue','etype':'editable','len':'32','cls':'frame','url':'FromSelector.aspx','vals':'From=Address,FromProvince=ProvinceID,FromCity=CityID,FromDistrict=DistrictID,FromCityName=CityName,FromDistrictName=DistrictName,FromProvinceName=ProvinceName,FromContact=Phone','modalWindow':'1'}" verify="{}">发货地址
                                                            </a>
                                                        </td>
                                                        <td class="" rowspan="1" colspan="3">
                                                            <input name="From" title="发货地址"  oc="text" class="edit form-control transparent data" f-options="{'code':'From','type':'text','etype':'editable','len':'32'}" verify="{'title':'From','length':'50','required':true}">
                                                           
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                            <td rowspan="1" colspan="10" style="background-color: white;border:0;border-left:1px solid white !important;border-right:1px solid white !important; height: 15px;"></td>
                                                        </tr>   
                                                        <tr>
                                                            <td class="td_name">
                                                                <a href="javascript:void(0);"  onclick="showModalWindow(this,'收货方',$('input[name=CustomerID]'));"  class="edit" f-options="{'code':'EndUserID','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'EndUserSelector.aspx','vals':'EndUserName=EndUserName,ToName=FromName,ToContact=Phone,To=Address,ToProvince=ProvinceID,ToCity=CityID,ToDistrict=DistrictID','modalWindow':'1'}" verify="{}">
                                                                    <input type="hidden" readonly  name="EndUserID" class="data">收货方
                                                                </a>
                                                            </td>
                                                            <td class="" rowspan="1" colspan="3">
                                                                <input name="EndUserName"  class="edit form-control transparent data" f-options="{'code':'EndUserName','type':'text','etype':'editable','len':'50'}" verify="{'title':'EndUserName','length':'50','required':true}">
                                                            </td>
                                                            <td class="td_name">是否送货</td>
                                                            <td class="" colspan="2">
                                                            	<ul class="list-inline radiodata">
                                                                    <li>
                                                                        <label><input type="radio" name="IsDelivery" value="1" checked>是</label></li>
                                                                    <li>
                                                                        <label><input type="radio" name="IsDelivery" value="0">否</label></li>
                                                                </ul> 
                                                               
                                                            </td>
                                                            <td class="td_name">是否卸货</td>
                                                            <td class="" colspan="3">                       
                                                                <ul class="list-inline radiodata">
                                                                    <li>
                                                                        <label><input type="radio" name="IsOffLoad" value="1" checked >是</label></li>
                                                                    <li>
                                                                        <label><input type="radio" name="IsOffLoad" value="0">否</label></li>
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
                                                            <td class="td_name">到货时间
                                                            </td>
                                                            <td class="" rowspan="" colspan="3">
                                                                <input name="ToTime" title="到货时间" oc="date" class="edit data"  onclick="TrigerDateEvent(this, { format: 'YYYY-MM-DD hh:mm', min: $('input[name=\'FromTime\']').val() })" f-options="{'code':'ToTime','type':'date','etype':'editable','len':'50'}" verify="{'title':'ToTime','length':'50','required':true}">
                                                            </td>
                                                            <td class="td_name">联系电话</td>
                                                              <td class="" colspan="2">
                                                                <input name="ToContact"  title="收货方联系电话"  oc="text" class="edit form-control transparent data" f-options="{'code':'ToContact','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','required':true,'textarea1':true,'validate':'{\'pattern\': \'^((([0\+][0-9]{2,3}-)?(0[0-9]{2,3})-)?([0-9]{7,8})?(([0-9]{7,8})(-([0-9]{3,}))?))?(([1][3|4|5|7|8][0-9])[0-9]{8})?$\',\'message\': \'格式不正确，请重新输入！\'}'}">
                                                              </td>
                                                            <td class="td_name">收货地址<td class="" rowspan="1" colspan="3">
                                                                <input name="To" title="收货地址" oc="text"  class="edit form-control transparent data" f-options="{'code':'To','type':'text','etype':'editable','len':'32'}" verify="{'title':'To','length':'50','required':true}">
                                                            </td>
                                                        </tr>
                                                    </tbody>                                                    
                                                    <tbody class="hideTbody" style="display:none;">
                                                        <tr>
                                                            <td rowspan="1" colspan="10" style="background-color: white;border-left:1px solid white !important;border-right:1px solid white !important; height: 15px;"></td>
                                                        </tr>
                                                        <tr style="height: 26px;">
                                                            <td class="td_name">计费模式</td>
                                                            <td class="" colspan="4">
                                                                <input type="hidden" name="ChargeMode" value="0" class="data">
                                                                <select  name="ChargeMode_id" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);Unit(this)" f-options="{'code':'ChargeMode','type':'combobox','etype':'','len':''}" verify="{'title':'ChargeMode','length':'','textarea1':true}">
                                                                    <option value="">-------------------------</option>
                                                                    <option value="1">重量</option>
                                                                    <option value="2">体积</option>
                                                                    <option value="3">数量</option>
                                                                </select>
                                                             </td>
                                                            <td class="td_name">价格单位</td>
                                                           <td class="" colspan="4">
                                                            <input type="hidden" name="PriceUnit" value="0" class="data">
                                                            <select  name="PriceUnit_id" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);UnitType(this)" f-options="{'code':'PriceUnit','type':'combobox','etype':'','len':''}" verify="{'title':'PriceUnit','length':'','textarea1':true}">
                                                              <option value="">-------------------------</option>
                                                              <!--#include file="/Controls/Unit.aspx"-->
                                                            </select>
                                                          </td>
                                                        </tr>
                                                        <tr style="height: 26px;">
                                                            <td class="td_name">运输模式</td>
                                                            <td class="" colspan="4">
                                                                <ul class="list-inline radiodata">
                                                                    <li>
                                                                        <label><input type="radio" name="TransportMode" value="1" onclick="removeCarType()"  >零担</label></li>
                                                                    <li>
                                                                        <label><input type="radio" name="TransportMode" value="2" onclick="showCarType_length( this )">整车</label>
                                                                    </li>
                                                                </ul>
                                                            </td>
                                                            <td class="td_name">包装方式</td>
                                                            <td class="" colspan="4">
                                                                <ul class="list-inline radiodata">
                                                                    <li>
                                                                        <label><input type="radio"  name="PackageMode" value="1" >散箱</label></li>
                                                                    <li>
                                                                        <label><input type="radio"  name="PackageMode" value="2">托盘或木箱</label></li>
                                                                    <li>
                                                                        <label><input type="radio"  name="PackageMode" value="3">托盘、木箱或不规则形状</label></li>
                                                                </ul>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 26px;" name="CarInfo">
                                                            <td class="td_name">车型</td>
                                                            <td class="" colspan="4">
                                                                <input type="hidden" name="CarType" readonly value="0" class="edit form-control transparent data">
                                                                <input type="text" name="CarTypeName" readonly class="edit form-control transparent">
                                                            </td>
                                                            <td class="td_name">规格/车长（米）</td>
                                                            <td class="" colspan="4">
                                                                <input type="text" readonly class="edit form-control transparent" name="CarLengthName">
                                                                <input type="hidden" name="CarLength" readonly class="edit form-control transparent data">                                                            
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 26px; display:none;" name="CarInfo">
                                                            <td class="td_name">容积（立方米）</td>
                                                            <td class="" colspan="4">                     
                                                                <input type="text" name="CarVolume" readonly class="edit form-control transparent data">
                                                            </td>
                                                            <td class="td_name">载重（吨）</td>
                                                            <td class="" colspan="4">
                                                                <input type="text" name="CarWeight" readonly class="edit form-control transparent data">
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 26px;">
                                                              <td class="td_name">货物分类</td>
                                                              <td class="" rowspan="1" colspan="4">
                                                                  <ul class="list-inline">
                                                                    <li><input type="hidden" class="data"  name="GoodsCategory" f-options="{'code':'GoodsCategory','type':'date','etype':'editable','len':'50'}" verify="{'title':'货物分类','length':'50','required':true}" />
                                                                    <input type="checkbox"  class="control-check" name="Goodscategory" value="1" />普通货物</li>
                                                                    <li><input type="checkbox"  class="control-check" name="Goodscategory" value="2" />危险品</li>
                                                                    <li><input type="checkbox"  class="control-check" name="Goodscategory" value="4" />温控货物</li>
                                                                </ul>
                                                              </td>
                                                              <td class="td_name">是否保价</td>
                                                              <td class="" colspan="4">
                                                                  <ul class="list-inline radiodata">
                                                                      <li>
                                                                          <label><input type="radio"  name="IsInsurance" value="1" checked>是</label></li>
                                                                      <li>
                                                                          <label><input type="radio"  name="IsInsurance" value="0">否</label></li>
                                                                  </ul>
                                                              </td>
                                                        </tr>
                                                       <tr>
                                                            <td class="td_name">
                                                                <a href="javascript:void(0);" onclick="showModalWindow(this,'标记',$('input[name=\'CSymbolID\']'))"  class="edit" f-options="{'code':'id','type':'dialogue','etype':'editable','len':'32','cls':'frame','url':'MSymbolSelector.aspx','vals':'CustomerSymbolID=id,CustomerSymbolName=name','modalWindow':'1'}" verify="{}">客户标记名称
                                                                </a>
                                                                <input type="hidden" name="CustomerSymbolID" class="data">
                                                                <input type="hidden" name="CSymbolID" value="1">
                                                            </td>
                                                            <td class="" rowspan="1" colspan="4">
                                                                <input name="CustomerSymbolName" readonly title="客户标记名称" class="writeInput" placeholder="客户标记名称" oc="text" class="edit form-control transparent" f-options="{'code':'CustomerSymbolName','type':'text','etype':'editable','len':'600'}" verify="{'title':'客户标记名称','length':'600'}">
                                                            </td>
                                                            <td class="td_name">原始单据编号</td>
                                                            <td class="" rowspan="1" colspan="4">
                                                                <input name="SrcCode" title="原始单据编号" oc="text" readonly class="edit form-control transparent data" f-options="{'code':'SrcCode','type':'text','etype':'editable','len':'50'}" verify="{}">
                                                            </td>
                                                        </tr>
                                                        <tr style="height:26px;">
										                    <td class="td_name">
										                        	设备编号
										                    </td>
										                    <td colspan="9">
										                        <textarea style="line-height:28px;" name="DeviceCode"  readonly class="edit form-control transparent data" f-options="{'code':'DeviceCode','type':'richtext','etype':'','len':''}" verify="{'title':'DeviceCode','length':'','textarea1':true}"></textarea>
										                    </td>
										                </tr>
                                                        <tr style="height:26px;">
                                                            <td class="td_name">
                                                                预付款
                                                            </td>
                                                            <td class="" rowspan="1" colspan="4">
                                                                <input name="Payment" title="预付款"   placeholder="" oc="text" class="edit form-control transparent data" f-options="{'code':'Payment','type':'text','etype':'editable','len':'600'}" verify="{'title':'预付款','length':'600'}">
                                                            </td>
                                                            <td class="td_name" colspan="1">货到付款</td>
                                                            <td colspan="4">
                                                                <input name="Payable"   class="edit form-control transparent data" f-options="{'code':'Payable','type':'richtext','etype':'','len':''}" verify="{'title':'货到付款','length':'','textarea1':true}"></input>
                                                            </td>                    
                                                        </tr>
                                                        <tr>
                                                            <td rowspan="1" colspan="10" style="background-color: white; border: 0;border-left:1px solid white; height: 15px;"></td>
                                                        </tr>
                                                        <tr style="height:26px;">
                                                            <td class="td_name">
                                                                	备注
                                                            </td>
                                                            <td colspan="9">
                                                                <textarea style="line-height:28px;" name="Descriptions"   class="edit form-control transparent data" f-options="{'code':'Descriptions','type':'richtext','etype':'','len':''}" verify="{'title':'Descriptions','length':'','textarea1':true}"></textarea>
                                                          </td>
                                                        </tr>
                                                   </tbody>
                                                   <tbody class="showTbody">
                                                        <tr>
                                                            <td rowspan="1" colspan="10" style="background-color: white;border:0;border-left:1px solid white !important;border-right:1px solid white !important; height: 15px;"></td>
                                                        </tr>
                                                        <tr style="height: 26px;" class="" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
                                                            <td class="td_name" >物品编号</td>
                                                            <td class="td_name" colspan="2" >物品名称</td>
                                                            <td class="td_name" colspan="2">规格</td>
                                                            <td class="td_name" colspan="">总重量（公斤）</td>
                                                            <td class="td_name" colspan="">总体积（立方米）</td>
                                                            <td class="td_name">物品数量</td>
                                                            <td class="td_name" >价值（元）</td>
                                                            <td class="td_name">批次</td>
                                                            
                                                        </tr>
                                                        <tr style="height: 26px; display: none;" class="" fb-options="{'rowid':'TMS_OrderGoods','initialRows':'1','maxrows':'10','content':''}" rowid="TMS_OrderGoods">
                                                            <td colspan="">
                                                                <input type="text" readonly title="物品编号" oc="dialogue" class="edit form-control transparent" name="GoodsID" f-options="{'code':'GoodsID','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'GoodsSelector.aspx','vals':'GoodsID=id,Name=Name,SPC=SPC,Weight=Weight,Volume=Volume,weight=Weight,volume=Volume,UnitName=UnitName,Price=Price,price=Price,Qty=Qty','modalWindow':'1'}" verify="{'title':'GoodsID','length':'50','required':true}">
                                                                <input type="hidden" name="ListID" />
                                                            </td>
                                                            <td class="" colspan="2" >
                                                                <input name="Name" title="物品名称" readonly  onclick="showModalWindow( this, '物品编号', $( 'input[name=CustomerCompanyID]' ), '', GoodsSelect )"  oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'50'}" verify="{'title':'Name','length':'50','required':true}">
                                                            </td>
                                                           
                                                            <td colspan="2">
                                                              <input name="SPC" title="规格" readonly oc="text" class="edit form-control transparent" f-options="{'code':'SPC','type':'text','etype':'editable','len':'50'}" verify="{'title':'SPC','length':'50','required':true}">
                                                            </td>
                                                            <td class="" colspan="">
                                                                <input name="Weight" title="重量" readonly oc="number" class="edit form-control transparent" f-options="{'code':'Weight','type':'number','etype':'editable','len':''}" verify="{'title':'重量','number':true}">
                                                                <input name="weight" type="hidden" />
                                                            </td>
                                                            <td colspan="">
                                                                <input name="Volume" title="体积" readonly oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':''}" verify="{'title':'体积','number':true}">
                                                                <input name="volume" type="hidden" />
                                                            </td>
                                                            <td class="">
                                                                <input name="Qty"  onkeyup="Calculator(this)" title="物品数量" oc="number" readonly class="edit form-control transparent" f-options="{'code':'Qty','type':'number','etype':'editable','len':''}" verify="{'title':'物品数量','number':true,'required':true}">
                                                            </td>
                                                             <td class="" >
                                                                <input name="Price" title="物品价值"  readonly   oc="text" class="edit form-control transparent" f-options="{'code':'Price','type':'text','etype':'editable','len':'50'}" verify="{'title':'Price','length':'50','required':true}">
                                                                <input name="price" type="hidden" />
                                                            </td>
                                                            <td class="">
                                                                <input name="BatchNo" readonly  title="批次" oc="text" class="edit form-control transparent" f-options="{'code':'BatchNo','type':'number','etype':'editable','len':''}" verify="{'title':'批次'}">
                                                            </td>
                                                            
                                                        </tr>
                    
                                                        <tr style="height: 26px;" class="addition">
                                                              <td class="" rowspan="2"  colspan="5">补差</td>
                                                              <td class="" rowspan="1" colspan="">
                                                                    <input name="wAddition" readonly    title="重量补差" oc="text" class="edit form-control transparent" f-options="{'code':'WeightAddition','type':'number','etype':'editable','len':''}" verify="{'title':'WeightAddition','number':true}" >
                                                              </td>
                                                              <td class="" colspan="">
                                                                   <input name="vAddition"  readonly  title="体积补差" oc="text" class="edit form-control transparent" f-options="{'code':'VolumeAddition','type':'number','etype':'editable','len':''}" verify="{'title':'VolumeAddition','number':true}" >
                                                              </td>
                                                              <td colspan="3"></td>
                                                        </tr>
                                                        <tr style="height: 26px;" class="addition">
                                                              <td class="" rowspan="1" style="white-space:normal;">
                                                                    <span style="line-height:26px">+</span>
                                                                    <input name="WeightAddition" onkeyup="weightAddtion();getRex(this)"    title="重量补差" oc="text" class="edit form-control data transparent" f-options="{'code':'WeightAddition','type':'number','etype':'editable','len':''}" verify="{'title':'WeightAddition','number':true}" style="width:100px !important;float:right">
                                                              </td>
                                                              <td class="" colspan="" style="white-space:normal;">
                                                                    <span style="line-height:26px">+</span>
                                                                   <input name="VolumeAddition" onkeyup="volumeAddtion();getRex(this)"    title="体积补差" oc="text" class="edit form-control data transparent" f-options="{'code':'VolumeAddition','type':'number','etype':'editable','len':''}" verify="{'title':'VolumeAddition','number':true}" style="width:100px !important;float:right">
                                                              </td>
                                                              <td colspan="3"></td>
                                                        </tr>
                                                        <tr   style="height: 26px;" class="" >
                                                            <td colspan="5" class="">
                                                              合计
                                                            </td>
                                                             <td colspan="">
                                                              <input id="TotalWeight" name="TotalWeight" title="总重量" readonly oc="text"  class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'calculation','len':'50'}" verify="">
                                                            </td>
                                                            <td colspan="">
                                                              <input id="TotalVolume" name="TotalVolume" title="总体积" readonly oc="text"  class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
                                                            </td>
                                                            <td >
                                                                <input name="TotalQty" title="总数量" readonly oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Qty%5D%7D%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%284%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
                                                            </td>
                                                            <td>
                                                                <input name="GoodsValue" title="总价值"    oc="text" calculation="var%20arr%3D%7B%5BTMS_OrderGoods.Price%5D%7D%3Bvar%20sum%3D0%3B%20for%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28%20arr%5Bi%5D%3D%3D%27%27%20%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%20%3B%7D%7Dsum.toFixed%284%29%3B"  class="edit form-control data transparent" f-options="{'code':'GoodsValue','type':'number','etype':'editable','len':''}" 
                                                            </td>
                                                             <td colspan="" >
                                                            </td>
                                                          </tr>
                                                       </tbody>
                                                       <tbody class="" style="display:none;">       <!--hideTbody-->
                                                          <tr>
                                                              <td rowspan="1" colspan="10" style="background-color: white;border:0 !important;border-left:1px solid white !important;border-right:1px solid white !important; height: 15px;"></td>
                                                          </tr>
                                                          <tr>
                                                             <td colspan="10" style="border: 0;border-left:1px solid white !important;">
                                                                <input type="hidden" name="id">
                                                                <div class="toolbar">
                                                                    <div style="text-align: right;" class="button_workflow">
                                                                        <a class="btn btn-red footKeepBtn save-transplan" href="javascript:void(0);" onclick="">保存详情&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>
                                                                    </div>
                                                                    <div class="clear"></div>
                                                                    <div class="content_workflow"></div>
                                                                </div>
                                                            </td>
                                                         </tr>
                                                   </tbody>
                                                   <tbody class="prompt">
                                                        <tr style="height:26px;">
                                                        <td rowspan="1" colspan="10" style="background-color: white;border:1px solid white !important; height: 15px;text-align:center"><span style="color:#F27302;position:relative;top:3px">*</span>&nbsp;&nbsp;更多物品或订单详情需要修改请点击查看详情</td>
                                                        </tr>
                                                   </tbody>
                                            </table>
                                            <!-- 表单结尾 -->
                                        </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="cd_td" colspan="8">
                            <table class="table jptable line_chaidan">
                                <tbody>
                                    <tr style="height:47px" class="schedule-radio">
                                       <td colspan="4" style="border-right: 1px solid #e1e6eb;background-color: #F5F6FA;">
                                         我要拆单
                                        </td> 
                                        <td colspan="4" style="border-right: 1px solid #e1e6eb;background-color: #F5F6FA;">
                                         直接调度
                                        </td>
                                    </tr>
                                    
                                    <tr style="height:47px" class="splitbox">
                                        <td colspan="2" style="">
                                            <input type="radio" name="split" id="lineSplit" value="1"   />线路拆单
                                        </td>
                                        <td colspan="2" style="">
                                            <input type="radio" name="split"  id="qtySplit" value="2" />数量拆单
                                        </td>
                                        <td colspan="2" style="border-left: 1px solid #e1e6eb;">
                                            <input type="radio" name="radio"   value="3" />自营
                                        </td>
                                        <td class="" colspan="2">
                                            <input type="radio" name="radio" value="4"/>承运方
                                        </td>
                                    </tr>
                                    <tr name="CarDriver" class="scheduletr" style="width:26px;display:none;">
                                        <td class="td_name" colspan="2" style="width:6.5%;">
                                            <a href="javascript:void(0);" title="车辆" onclick="car_zy(this)" oc="dialogue" class="edit car_select" f-options="{'code':'CarID','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'CarsSelector.aspx','vals':'SN=SN','modalWindow':'1'}" verify="{}">
                                                <input type="hidden" name="CarID">车辆
                                            </a>
                                        </td>
                                        <td class="" rowspan="1" colspan="">
                                            <input name="SN" placeholder="点击车辆进行选择" readonly class="edit form-control transparent" f-options="{'code':'SN','type':'text','etype':'','len':'50'}" verify="{'title':'SN','length':'50','required':true}">
                                        </td>
                                        <td class="td_name" >
                                            <a href="javascript:void(0);" onclick="showModalWindow(this,'司机')" title="司机" oc="dialogue" class="edit" f-options="{'code':'DriverID','type':'dialogue','etype':'editable','len':'60','cls':'frame','url':'DriverSelector.aspx','vals':'DriverName=Name','modalWindow':'1'}" verify="{}">
                                                <input type="hidden" name="DriverID">司机
                                            </a>
                                        </td>
                                        <td class="" rowspan="1" colspan="">
                                            <input name="DriverName" placeholder="点击司机进行选择" readonly class="edit form-control transparent" f-options="{'code':'DriverName','type':'text','etype':'','len':'50'}" verify="{'title':'DriverName','length':'50','required':true}">
                                        </td>
                                        <td class="td_name" >
                                            <a href="javascript:void(0);" onclick="showModalWindow(this,'标记',$('input[name=\'SSymbolID\']'))" class="edit" f-options="{'code':'id','type':'dialogue','etype':'editable','len':'32','cls':'frame','url':'MSymbolSelector.aspx','vals':'SupplierSymbolID=id,SupplierSymbolName=name','modalWindow':'1'}" verify="{}">承运方标记名称
                                            </a>
                                            <input type="hidden" name="SupplierSymbolID">
                                            <input type="hidden" name="SSymbolID" value="2">
                                        </td>
                                        <td class="" rowspan="1" colspan="">
                                            <input name="SupplierSymbolName" title="标记名称" readonly class="edit form-control transparent" placeholder="点击“承运方标记名称”进行选择" oc="text" readonly class="edit form-control transparent" f-options="{'code':'SupplierSymbolName','type':'text','etype':'editable','len':'600'}" verify="{'title':'承运方标记名称','length':'600','required':true}">
                                        </td>
                                    </tr>
                                    <tr name="CarDriverSupplier" class="scheduletr" style="display: none;width:26px;">
                                        <td class="td_name" colspan="2" style="width:6.5%;">
                                            <a href="javascript:void(0);" name="Supplier" onclick="showModalWindow(this,'承运方');" class="edit" f-options="{'code':'id','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'SupplierSelector.aspx','vals':'SupplierName=CompanyName,SupplierID=id,CompanyID=CompanyID,OpenId=OpenId','modalWindow':'1'}" verify="{}">
                                                <input type="hidden" name="SupplierID">承运方
                                                <input type="hidden" name="CompanyID">
												<input type="hidden" name="OpenId">
                                            </a>
                                            <input type="hidden" name="NoticeKey" value="<%=NDS.Widgets.Weixin.WxNormalHandler.GetTokenTx()%>">
                                        </td>
                                        <td class="" rowspan="1" colspan="5">
                                            <input name="SupplierName" placeholder="点击“承运方”进行选择" title="点击承运方进行选择" class="edit form-control transparent" readonly="readonly" f-options="{'code':'SupplierName','type':'text','etype':'editable','len':'50'}" verify="{}">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    
                    
                    
                    <tr class="lineSplit" style="display:none;">
                        <td class="cd_td" colspan="8">
                            <table class="table jptable line_chaidan line_chaidan_2">
                                <thead>
                                    <tr>
                                        <td colspan="15" style="background-color: #F5F6FA; border-bottom: 1px solid #e1e6eb; color: #999;">线路拆单</td>
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
                    <tr class="qtySplit" style="display:none;" >
                        <td class="cd_td" colspan="8">
                            <table class="table goods_chaidan jptable">
                                <thead>
                                    <tr>
                                        <td colspan="10" style="border: none; background-color: #F5F6FA; border-bottom: 1px solid #e1e6eb; color: #999;">数量拆单</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>物品编号</td>
                                        <td>客户名称</td>
                                        <td>物品名称</td>
                                        <td>总重量（公斤）</td>
                                        <td>总体积（立方米）</td>
                                        <td>总数量</td>
                                        <td>拆分数量</td>
                                    </tr>
                                    <tr name="Goods">
                                        <td view-fld='{ fld:"GoodsID",method:"show"}'></td>
                                        <td view-fld='{ fld:"CustomerName",method:"show"}'></td>
                                        <td name="GoodsName" view-fld='{ fld:"GoodsName",method:"show"}'></td>
                                        <td view-fld='{ fld:"Weight",method:"show"}'></td>
                                        <td view-fld='{ fld:"Volume",method:"show"}'></td>
                                        <td name="Qty" view-fld='{ fld:"Qty",method:"show"}'></td>
                                        <td view-fld='{ fld:"splitQty",method:"template",template:"<input type=\"hidden\"  name=\"ListID\" value=\"@listid@\" /><input type=\"text\" readonly onclick=\"splitQtyClick(this)\"   name=\"splitQty\" value=\"@qty@\" style=\"width: 81px;\" />"}'>
                                            </td>
                                        <!--<td>
                                            <a herf="javascript:void(0)"  title="拆分"    onclick="splitOrderQty(this)" >拆分</a>
                                        </td>-->
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!--通用页尾开始-->
    <!--#include file="/Controls/TMS/footer.aspx"-->
    <!--通用页尾结尾-->

    <script type="text/javascript">

        function _DoPageLoad(){
            initTableForm( $( '#ef41d4b8-88a5-4954-9d0d-b1dc6a71f860' ), false, function ()
            {
                setTimeout( "GoodsCategory();showTotal();ifChecked();ifBoxChecked();splitQtyShow();showInfor();hoverTips();", 300 );
                CarTypes( $( 'input[name="CarType"]' ).val() );
                //Calculator();
                 if (NSF.UrlVars.Get("id")) {
                    var _FromProvince = $('input[name="FromProvince"]').val();
                    var _FromCity = $('input[name="FromCity"]').val();
                    var _FromDistrict = $('input[name="FromDistrict"]').val();
                    var _ToProvince = $('input[name="ToProvince"]').val();
                    var _ToCity = $('input[name="ToCity"]').val();
                    var _ToDistrict = $('input[name="ToDistrict"]').val();

                    if (_FromDistrict == '' || _FromDistrict == '0') {
                        $('input[name="FromName"]').val(_FromCity);
                    } else {
                        $('input[name="FromName"]').val(_FromDistrict);
                    }

                    if (_ToDistrict == '' || _ToDistrict == '0') {
                        $('input[name="ToName"]').val(_ToCity);
                        
                    } else {
                        $('input[name="ToName"]').val(_ToDistrict);
                    }
                    getAreas();
                  } else {
                    getAreas();
                  }		
            } );
        }

        function sumQtySplit() {    //数量拆分总数
            var _totalQty = 0;
            $('input.qtyinput').each(function() {
                if ($(this).val() != '') {
                    _totalQty += parseInt($(this).val());
                }
            });

            return _totalQty;
        }
        
        var reqeustDone = function (){

			/*所有JS加载完成以后执行*/
            if ( typeof ( initHeader ) != "undefined" ) initHeader();					/*初始化页面通用头部*/
            if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/
            setTimeout( "_DoPageLoad();", 300);//初始化固定头部的宽度

            //数量拆分
            $(document).on("focus keyup", 'input.qtyinput', function( e ){
                if( e.type == "focusin" ){
                    $(this).val( "" );
                }if( e.type == "keyup" ){
                    $(this).val( $(this).val().replace(/[^\d.]/g,'') );
                    $(this).parent().next().find('input.qtyinput').val('');

                    var _tatalQty = parseInt($('span[name="totalQty"]').text());
                    var _sumQty = sumQtySplit();
                    var _nextVal = _tatalQty - _sumQty;

                    if (_nextVal < 0) {
                        alert('拆分数据必须小于总数量！');
                        $(this).val('');
                    } else {
                        if (_nextVal > 0) {
                            $(this).parent().next().find('input.qtyinput').val(_nextVal);
                        }
                    }

                    //$(this).parent().next().find('input.qtyinput').val(_tatalQty - parseInt($(this).val()));
                    //$('span[name="totalQty"]').text(_tatalQty - parseInt($(this).val()));
                }
            });
            

            //点击查看详情
            var coutNum = 0;
            $('#accordion .panel').click(function () {
                coutNum++;
                if (coutNum % 2 == 0) {
                    $('tbody.prompt').show();
                    $('.glyphicon-menu-down').css('display', 'inline');
                    $('.glyphicon-menu-up').css('display', 'none');
                    $('.showTbody').css('display', 'table-row-group');
                    $('.hideTbody').css('display', 'none');
                    var inforNum = $('.showTbody tr').length;
                    for (var i = 4; i < $('.showTbody tr').length; i++) {
                        $('.showTbody tr').eq(i).css('display', 'none');
                    }
                } else {
                    $('tbody.prompt').hide();
                    $('.glyphicon-menu-down').css('display', 'none');
                    $('.glyphicon-menu-up').css('display', 'inline');
                    $('.showTboby').css('display', 'none');
                    $('.hideTbody').css('display', 'table-row-group');
                    var inforNum = $('.showTbody tr').length;
                    for (var i = 4; i < $('.showTbody tr').length; i++) {
                        $('.showTbody tr').eq(i).css('display', 'table-row');
                    }
                    /*$('input[name="wAddition"]').val($('input[name="WeightAddition"]').val());
                    $('input[name="vAddition"]').val($('input[name="VolumeAddition"]').val());
                    $('input[name="WeightAddition"]').val('0.0000');
                    $('input[name="VolumeAddition"]').val('0.000000');*/
                }
            });

            //选择运输模式
            $( 'input[name="TransportMode"]' ).click( function (){
                if ( $( this ).val() == 1 )
                    $( 'tr[name="CarInfo"]' ).hide();
                else
                    $('tr[name="CarInfo"]').show();
            });
        }
        //重量补差
        function weightAddtion() {
            var WeightAddition=$('input[name="WeightAddition"]').val();
            var wAddition=parseFloat($('input[name="wAddition"]').val());
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
             sum += wAddition;
            $('input[name="TotalWeight"]').val(sum.toFixed(4));
        }
        //体积补差
        function volumeAddtion() {
            var VolumeAddition=$('input[name="VolumeAddition"]').val();
            var vAddition = parseFloat($('input[name="vAddition"]').val());
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
            sum += vAddition;

            $('input[name="TotalVolume"]').val(sum.toFixed(6));
        }
    
    function addText(divObj) {      //添加输入框
        var _divParent = $(divObj).parent();
        var _div = _divParent.prev().clone();

        _div.find('input').val('');
        if ($('input.qtyinput').length < 4) {
            _divParent.before(_div);
            $(divObj).next().show();
        } else {
            _divParent.before(_div);
            $(divObj).hide();
        }
    }

    function delText(divObj) {      //删除输入框
        var _divParent = $(divObj).parent();
        if ($('input.qtyinput').length > 3) {
            _divParent.prev().remove();
            $(divObj).prev().show();
        } else {
            _divParent.prev().remove();
            
            $(divObj).hide();
        }
    }

    </script>

    <!--其他JS开始-->
    <!--#include file="/Controls/JS.aspx"-->
	<!--#include file="/Controls/TMS/JS.aspx"-->
    <!--其他JS结尾-->
    <style>
		.show{display:block;}
	</style>
	<script src="js/AllAreas.js"></script>
    <script src="/assets/request_form.js"></script>
	</body>
    <style>
        .qtynum{color:#F27302}
        .line-dash{border:1px dashed #E5E5E5;}
        #splitModal ul li{height:35px;line-height:35px}
        .splitnum ul li{width:12%}
        #splitModal img{width:10px}
        .ul-line{padding-top:10px}
        .ul-line li{border-left:1px solid #e5e5e5;position:relative;left:5px;line-height:12px !important;}
        .ul-line li.last{border-left-color: #fff !important;}
        .ul-line li img{position:absolute;left:-6px;}
        .ul-line li span{padding-left:10px;}
        .ul-line p{display:inline-block;}
    </style>
</html>
