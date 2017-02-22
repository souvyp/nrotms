﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>收货方常用地址信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--#include file="/Controls/Meta.aspx"-->
    <!--#include file="/Controls/TMS/CSS.aspx"-->
    <link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="EnduserAddr">

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

    <div class="formcontainer" style="display: none;">
        <!-- 表单开始-->
        <script language="javascript">
            var __saveNdtCfg = '{"main":{"insertVml":"tms_0040","updateVml":"tms_0040","queryVml":"tms_0042"}}';
        </script>
        <table class="FormTable Y_alter FormTable6" style="width: 100%;" id="7cff24c8-129a-4746-8c7d-55b22bd37199" path="OTMS/EnduserAddr" code="EnduserAddr">
            <colgroup>
                <col style="width: 120px;">
                <col style="width: 200px;">
                <col style="width: 120px;">
                <col style="width: 207px;">
            </colgroup>
            <tbody>
                <tr>
                    <td class="text-left" rowspan="1" colspan="3" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">收货方常用地址信息</p></div></td>
                    <td colspan="3" style="border:0; border-bottom:1px solid #e1e6eb;">
                        <input type="hidden" name="id">
                        <input type="hidden" name="Type" value="1">
                        <div class="toolbar">
                            <div style="text-align: right;" class="button_workflow">
                                <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#7cff24c8-129a-4746-8c7d-55b22bd37199'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
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
                <tr style="display: none;">
                    <td class="td_name">地址编号</td>
                    <td class="">
                        <input name="ID" title="地址编号" oc="text" readonly class="edit form-control transparent" f-options="{'code':'ID','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr class="" style="height: 26px;">
                    <td class="td_name">
                        收货方
                    </td>
                    <td class="" >
                        <input name="CustomerName" placeholder="点击“收货方”进行选择" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'收货方','length':'50','required':true}">
                    </td>
                    <td class="td_name">联系电话</td>
                    <td class="" colspan="3">
            						<input name="Phone" title="联系电话" oc="text" readonly class="edit form-control transparent" f-options="{'code':'Phone','type':'text','etype':'editable','len':'50'}" verify="{'title':'联系电话','length':'100','textarea1':true,'validate':'{\'pattern\': \'^((([0\+][0-9]{2,3}-)?(0[0-9]{2,3})-)?([0-9]{7,8})?(([0-9]{7,8})(-([0-9]{3,}))?))?(([1][3|4|5|7|8][0-9])[0-9]{8})?$\',\'message\': \'格式不正确，请重新输入！\'}'}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                  <td class="td_name">省/市/区</td>
                  <td class="" colspan="3" >
                      <div class="bs-chinese-region flat dropdown" data-submit-type="id" data-min-level="1" data-max-level="3">
                                <input type="text" class="edit form-control transparent" name="address" id="address" placeholder="选择你的地区" data-toggle="" readonly="" verify="{'title':'省/市/区','length':'300','required':true}">
                                <input type="hidden" name="ProvinceID">
                                <input type="hidden" name="CityID">
                                <input type="hidden" name="DistrictID">
                                <div class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                    <div>
                                        <ul class="nav nav-tabs" role="tablist">
                                            <li role="presentation" class="active"><a href="#province" data-next="city" role="tab" data-toggle="tab">省份</a></li>
                                            <li role="presentation"><a href="#city" data-next="district" role="tab" data-toggle="tab">城市</a></li>
                                            <li role="presentation"><a href="#district" data-next="street" role="tab" data-toggle="tab">县区</a></li>
                                        </ul>
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane active" id="province">--</div>
                                            <div role="tabpanel" class="tab-pane" id="city">--</div>
                                            <div role="tabpanel" class="tab-pane" id="district">--</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                  </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">地址</td>
                    <td rowspan="1" colspan="3">
                        <input name="Address" readonly onkeyup='this.value=this.value.replace(/[\&\?]/gi,"")' title="地址" oc="text" class="edit form-control transparent" f-options="{'code':'Address','type':'text','etype':'editable','len':'300'}" verify="{'title':'地址','length':'300','required':true}">
                        <div style="display:none">
                            <span name="province"></span>
                            <span name="city"></span>
                            <span name="district"></span>
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
        function _DoPageLoad() {
            initTableForm( $( '#7cff24c8-129a-4746-8c7d-55b22bd37199' ), false, function () {
                if (NSF.UrlVars.Get("id")) {
                    for(var i = $('.bs-chinese-region').find('input').length - 1; i > 0; i--) {     //默认显示省市区
                      if( $('.bs-chinese-region').find('input').eq(i).val() != "" ) {
                        $('.bs-chinese-region').find('input:eq(0)').val( $('.bs-chinese-region').find('input').eq(i).val() );
                        getAreas();

                        return;
                      } 
                    }
                  } else {
                    getAreas();
                  }
            }, '' );

            if (NSF.UrlVars.Get('id', location.href)) {
              $('a.save').hide();
            }
        }

        var reqeustDone = function () {   /*所有JS加载完成以后执行*/
            if (typeof (initHeader) != "undefined") initHeader();         /*初始化页面通用头部*/
            if (typeof (initFooter) != "undefined") initFooter();         /*初始化页面通用底部*/
            setTimeout("_DoPageLoad()", 300);
        };

        

        var _jsUrl = "<%=MinifyUrl("FormJs")%>";
    </script>
    <script src="/assets/js/jquery-1.11.1.min.js"></script>
    <!--#include file="/Controls/TMS/JS.aspx"-->
    <script src="/assets/request_minify.js"></script>
</body>
</html>
