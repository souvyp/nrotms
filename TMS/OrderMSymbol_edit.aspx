<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>客户标识-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--#include file="/Controls/Meta.aspx"-->
    <!--#include file="/Controls/TMS/CSS.aspx"-->
    <link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="OrderMSymbol">

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
            var __saveNdtCfg = '{"main":{"insertVml":"tms_0203","updateVml":"tms_0204","queryVml":"tms_0205"}}';
        </script>
        <table class="FormTable Y_alter FormTable6" style="width: 100%;" id="7cff24c8-129a-4746-8c7d-55b22bd37199" path="OTMS/rjwqhugn" code="rjwqhugn">
            <colgroup>
                <col style="width: 120px;">
                <col style="width: 200px;">
                <col style="width: 120px;">
                <col style="width: 207px;">
            </colgroup>
            <tbody>
                <tr>
                    <td class="text-left" rowspan="1" colspan="3" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">标识信息</p></div></td>
                    <td colspan="" style="border:0; border-bottom:1px solid #e1e6eb;">
                        <input type="hidden" name="id">
                        <div class="toolbar">
                            <div style="text-align: right;" class="button_workflow">
<!--                                <a class="btn btn-red footKeepBtn" href="javascript:void(0);" ev="%23saveNDT%23">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>-->
                                <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#7cff24c8-129a-4746-8c7d-55b22bd37199'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
                                <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
                            </div>
                            <div class="clear"></div>
                            <div class="content_workflow"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                  <td rowspan="1" colspan="4" style="background-color:white; border:0;height:15px;"></td>
                </tr>
                <tr class="" style="height: 26px;">
                    <td class="td_name">标识类型</td>
                    <td class="" colspan="3" >
  						        <ul class="edit form-control list-inline" name="type" type="radio" f-options="{'code':'type','type':'radio','etype':'editable','len':'1','cls':'list','url':'客户\r\n承运方','id':'','text':''}" verify="{}">
                        <li>
                          <input type="radio" name="type" value="1" class="edit-list transparent" checked>客户
                        </li>
                      </ul>
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">标识代码</td>
                    <td rowspan="1" colspan="">
                        <input name="code" oc="text" class="edit form-control transparent" f-options="{'code':'code','type':'text','etype':'editable','len':'300'}" verify="{'title':'标识代码','length':'300','required':true}">
                    </td>
                    <td class="td_name">标识名称</td>
                    <td rowspan="1" colspan="">
                        <input name="name" oc="text" class="edit form-control transparent" f-options="{'code':'name','type':'text','etype':'editable','len':'300'}" verify="{'title':'标识名称','length':'300','required':true}">
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
            initTableForm($('#7cff24c8-129a-4746-8c7d-55b22bd37199'), false, function () {
                ifChecked();
                ifBoxChecked();
                $('.circle-btn').css({ "background": "url(../images/dian.png)", "background-size": "10px 10px" });
    			$('.circle-btn').next('input').attr("checked", true);
            });
        }
        var reqeustDone = function () {		/*所有JS加载完成以后执行*/
            if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
            if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
            setTimeout("_DoPageLoad()", 300);
        };
        var _jsUrl = "<%=MinifyUrl("FormJs")%>";
    </script>
    <script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
    <script src="/assets/request_minify.js"></script>
</body>
</html>
