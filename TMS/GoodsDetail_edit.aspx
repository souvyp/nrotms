<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>客户物品信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="goods">
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

    <!--通用头部文件开始-->
    <!--#include file="/Controls/TMS/header.aspx"-->
    <!--通用头部文件结尾-->

    <div class="formcontainer" style="display: none;">
        <!-- 表单开始-->
        <script language="javascript">
            var __saveNdtCfg = '{"main":{"insertVml":"tms_0016","updateVml":"tms_0016","queryVml":"tms_0018"}}';
        </script>
        <table class="FormTable Y_alter FormTable6" style="width: 100%;" id="c331b75f-b1dc-4083-b74a-56eefcab2547" path="OTMS/goods" code="goods">
            <colgroup>
                <col style="width: 120px;">
                <col style="width: 120px;">
                <col style="width: 120px;">
                <col style="width: 120px;">
                <col class="" style="width: 120px;">
                <col style="width: 120px;" class="">
            </colgroup>
            <tbody>
                <tr>
                    <td class="text-left" rowspan="1" colspan="3" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">客户物品信息</p></div></td>
                    <td colspan="3" style="border:0; border-bottom:1px solid #e1e6eb;">
                        <input type="hidden" name="id">
                        <div class="toolbar">
                            <div style="text-align: right;" class="button_workflow">
                                <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#c331b75f-b1dc-4083-b74a-56eefcab2547'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
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
                    <td class="td_name">物品编码</td>
                    <td class="">
                        <input name="Code" title="物品编码" oc="text" readonly class="edit form-control transparent" placeholder="系统自动生成" f-options="{'code':'Code','type':'text','etype':'editable','len':'50'}" verify="{}">
                        <input name="GoodsID" title="物品编号" type="hidden" oc="text" readonly class="edit form-control transparent" f-options="{'code':'GoodsID','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">物品名称<span class="need_write">*</span></td>
                    <td class="">
                        <input name="Name" title="物品名称" oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'50'}" verify="{'title':'物品名称','length':'50','required':true}">
                    </td>
                    <td class="td_name">
                            <input type="hidden" name="TypeID">物品类型<span class="need_write">*</span>
                    </td>
                    <td class="">
                        <input name="TypeName" title="物品类型" placeholder="点击“物品类型”进行选择" readonly type="text" class="edit form-control transparent" f-options="{'code':'TypeName','type':'text','etype':'editable','len':'50'}" verify="{'title':'物品类型','length':'50','required':true}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">物品价值/元<span class="need_write">*</span></td>
                    <td>
                        <input name="Price" title="价格" oc="number" class="edit form-control transparent" placeholder="四舍五入保留两位小数" f-options="{'code':'Price','type':'number','etype':'editable','len':'12'}" verify="{'title':'物品价值','length':'12','number':true,'required':true}">
                    </td>
                    <td class="td_name">规格<span class="need_write">*</span></td>
                    <td class="">
                        <input name="SPC" title="规格" oc="text" class="edit form-control transparent" f-options="{'code':'SPC','type':'text','etype':'editable','len':'50'}" verify="{'title':'规格','required':true}">
                    </td>
                    <td class="td_name">体积/立方米<span class="need_write">*</span></td>
                    <td class="">
                        <input name="Volume" title="体积" oc="number" class="edit form-control transparent" f-options="{'code':'Volume','type':'number','etype':'editable','len':'10'}" verify="{'title':'体积','length':'10','number':true,'required':true}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">长/米</td>
                    <td class="">
                        <input name="Long" title="长" oc="number" class="edit form-control transparent" f-options="{'code':'Long','type':'number','etype':'editable','len':'10'}" verify="{'title':'长','length':'10','number':true}">
                    </td>
                    <td class="td_name">宽/米</td>
                    <td class="">
                        <input name="Width" title="宽" oc="number" class="edit form-control transparent" f-options="{'code':'Width','type':'number','etype':'editable','len':'10'}" verify="{'title':'宽','length':'10','number':true}">
                    </td>
                    <td class="td_name">高/米</td>
                    <td class="">
                        <input name="Height" title="高" oc="number" class="edit form-control transparent" f-options="{'code':'Height','type':'number','etype':'editable','len':'10'}" verify="{'title':'高','length':'10','number':true}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">
                        <input type="hidden" name="CustomerCompanyID">所属客户<span class="need_write">*</span>
                    </td>
                    <td class="" rowspan="" colspan="">
                        <input name="CustomerName" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <!--<td class="td_name">
                        <a href="javascript:void(0);" onclick="showModalWindow(this,'所属客户')" class="edit" f-options="{'code':'CustomerID','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'CustomerSelector.aspx','vals':'CustomerName=Name,CustomerCompanyID=CompanyID','modalWindow':'1'}" verify="{}">
                            <input type="hidden" name="CustomerCompanyID">所属客户
                        </a>
                    </td>
                    <td class="" rowspan="" colspan="">
                        <input name="CustomerName" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'CustomerName','length':'50','required':true}">
                    </td>-->
                    <td class="td_name">重量/公斤<span class="need_write">*</span></td>
                    <td class="">
                        <input name="Weight" title="重量" oc="number" class="edit form-control transparent" f-options="{'code':'Weight','type':'number','etype':'editable','len':'10'}" verify="{'title':'重量','length':'10','number':true,'required':true}">
                    </td>
                    <td class="td_name">毛重/公斤</td>
                    <td class="">
                        <input name="MWeight" title="毛重" oc="number" class="edit form-control transparent" f-options="{'code':'MWeight','type':'number','etype':'editable','len':'10'}" verify="{'title':'毛重','length':'10','number':true}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">
                            <input type="hidden" name="Unit">数量单位<span class="need_write">*</span>
                    </td>
                    <td class="" rowspan="" colspan="5">
                        <input name="UnitName" readonly placeholder="点击“数量单位”进行选择" class="edit form-control transparent" f-options="{'code':'UnitName','type':'text','etype':'editable','len':'50'}" verify="{'title':'数量单位','length':'50','required':true}">
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
        var reqeustDone = function () {		/*所有JS加载完成以后执行*/
            if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
            if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
            setTimeout("initTableForm($('#c331b75f-b1dc-4083-b74a-56eefcab2547'))", 300);

            var pmls = '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0099","paras":[]}]';
            NSF.System.Network.Ajax( '/Portal.aspx',
                pmls,
                'POST',
                false,
                function ( result, data )
                {
                    if( result )
                    {
                        $('input[name="CustomerCompanyID"]').val(data[0].rs[0].rows[0].companyid);
                        $('input[name="CustomerName"]').attr('placeholder',data[0].rs[0].rows[0].name);
                    }
                } );
            $('input').attr('readonly', 'readonly');
        };

        
        var _jsUrl = "<%=MinifyUrl("FormJs")%>";
    </script>
    <script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
    <script src="/assets/request_minify.js"></script>
</body>
</html>
