<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>客户信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--#include file="/Controls/Meta.aspx"-->
    <!--#include file="/Controls/PMS/CSS.aspx"-->
    <link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="Customer">

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

    <div class="formcontainer" style="display: none;">
        <!-- 表单开始-->
        <script language="javascript">
            var __saveNdtCfg = '{"main":{"insertVml":"tms_0020","updateVml":"tms_0020","queryVml":"tms_0023"}}';
        </script>
        <table class="FormTable Y_alter FormTable6" style="width: 100%;" id="fe39a44c-f33d-47e4-b418-427f0a05e209" path="OTMS/company" code="company">
            <colgroup>
                <col style="width: 120px;">
                <col style="width: 120px;">
                <col style="width: 120px;">
                <col style="width: 120px;">
                <col class="" style="width: 120px;">
                <col style="width: 120px;">
            </colgroup>
            <tbody>
                <tr>
                    <td class="text-left" rowspan="1" colspan="3" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">客户信息</p></div></td>
                    <td colspan="3" style="border:0; border-bottom:1px solid #e1e6eb;">
                        <input readonly type="hidden" name="id">
                        <div class="toolbar">
                            <div style="text-align: right;" class="button_workflow">
                                <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#fe39a44c-f33d-47e4-b418-427f0a05e209'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
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
                <tr style="height: 26px;display:none;">
                    <td class="styleCenter" rowspan="1" colspan="6" style="font-size: 18px; background-color: rgb(242, 242, 242);">
                        <input readonly name="ID" title="客户编号" oc="text" class="edit form-control transparent" f-options="{'code':'ID','type':'text','etype':'editable','len':'50'}" verify="{}">
                        <input readonly name="CustomerCompanyID" title="公司编号" value="0" >
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">公司全称</td>
                    <td class="" rowspan="1" colspan="1" >
                        <input readonly name="Name" title="公司全称"   oc="text" class="edit form-control transparent" f-options="{'code':'name','type':'text','etype':'editable','len':'50'}" verify="{'title':'name','length':'50','required':true}">
                    </td>
                    <td class="td_name">公司网站</td>
                    <td class="">
                        <input readonly name="Web" title="公司网站"  oc="text" placeholder="例如：www.wlyuan.com.cn" class="edit form-control transparent" f-options="{'code':'web','type':'text','etype':'editable','len':'50'}" verify="{'title':'Web','length':'50','url':true}" style="border:0;">
                    </td>
                    <td class="td_name" rowspan="4" style="text-align:center;">公司logo</td>
                    <td colspan="1" rowspan="4">
                        <input type="" readonly oc="image" disabled class="edit form-control droparea spot"  name="Logo" data-post="/ImageUploader.aspx?filename=Logo" data-width="50" data-height="50" data-crop="true" f-options="{'code':'Logo','type':'image','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">公司简称</td>
                    <td class="">
                        <input readonly name="ShortName" title="公司简称" oc="text" class="edit form-control transparent" f-options="{'code':'shortname','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">公司英文名</td>
                    <td class="">
                        <input readonly name="EnName" class="edit form-control transparent"  f-options="{'code':'enname','type':'text','etype':'editable','len':'50'}" verify="{'title':'enname','length':'50','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^[A-Za-z]+$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">英文简称</td>
                    <td class="">
                        <input readonly name="ShortEnName"  class="edit form-control transparent" f-options="{'code':'shortenname','type':'text','etype':'editable','len':'50'}" verify="{'title':'shortenname','length':'50','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^[A-Za-z]+$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                    </td>
                    <td class="td_name">企业法人</td>
                    <td class="">
                        <input readonly name="Master"  class="edit form-control transparent" f-options="{'code':'master','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr style="height:26px;">
                   <td class="td_name">联系人</td>
                    <td class="">
                        <input readonly name="Contact"  title="联系人" oc="text" class="edit form-control transparent" f-options="{'code':'contact','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                   <td class="td_name">联系电话</td>
                    <td class="">
                        <input readonly name="Phone" title="联系电话"  oc="text" class="edit form-control transparent" f-options="{'code':'phone','type':'text','etype':'editable','len':'50'}" verify="{'title':'phone','length':'50','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^([0-9]{3,4}-?[0-9]{7,8})$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">传真</td>
                    <td class="" colspan="1">
                        <input readonly name="Fax" title="传真" oc="text"  class="edit form-control transparent" f-options="{'code':'fax','type':'text','etype':'editable','len':'50'}" verify="{'title':'fax','length':'50','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^[+]{0,1}([0-9]){1,3}[ ]?([-]?(([0-9])|[ ]){1,12})+$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                    </td>
                    <td class="td_name">邮编</td>
                    <td class="">
                        <input readonly name="Zip" placeholder="例如：200000" class="edit form-control transparent"  f-options="{'code':'zip','type':'text','etype':'editable','len':'50'}" verify="{'title':'zip','length':'50','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^[1-9][0-9]{5}(?![0-9])$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
                    </td>
                    <td class="td_name " rowspan="3" style="text-align:center;">营业执照</td>
                    <td class="" rowspan="3">
                        <input  type="" readonly oc="image"  class="edit form-control droparea spot"  name="License" data-post="/ImageUploader.aspx?filename=License" data-width="50" data-height="50" data-crop="true" f-options="{'code':'License','type':'image','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">邮箱</td>
                    <td class="">
                        <input readonly name="Mail" placeholder="如：dd@qq.com" class="edit form-control transparent"  f-options="{'code':'mail','type':'text','etype':'editable','len':'50'}" verify="{'title':'Mail','length':'50','mail':true}">
                    </td>
                    <td class="td_name">微信公众号</td>
                    <td class="" colspan="1">
                        <input readonly name="WeiXin" class="edit form-control transparent"  f-options="{'code':'weixin','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr style="height:26px">
                   <td class="td_name">公司开户行</td>
                    <td class="">
                        <input readonly name="Bank" class="edit form-control transparent"  f-options="{'code':'Bank','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                    <td class="td_name">银行账号</td>
                    <td colspan="1">
                        <input readonly name="BankAccount" class="edit form-control transparent"  f-options="{'code':'bankaccount','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr style="height:26px">
                    <td class="td_name">所属行业</td>
                    <td class="">
                    <input readonly type="hidden" name="Industry">
                    <select name="Industry_id" disabled title="---------------------------" oc="combobox" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);" f-options="{'code':'Industry','type':'combobox','etype':'editable','len':'32'}" verify="{}">
                        <option value="0">---------------------------</option>
                        <option value="1">互联网/电子商务</option>
                        <option value="2">计算机软件</option>
                        <option value="3">计算机硬件</option>
                        <option value="4">财务/审计</option>
                        <option value="5">金融/银行</option>
                        <option value="6">保险/贸易进出口</option>
                        <option value="7">建筑/建材</option>
                        <option value="8">人力资源服务</option>
                        <option value="9">法律/法务</option>
                        <option value="10">航空/航天</option>
                        <option value="11">其它行业</option>
                    </select>
                    </td>
                     <td class="td_name">地址</td>
                    <td class="" colspan="3">
                        <input readonly name="Address" class="edit form-control transparent"  f-options="{'code':'address','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr style="height: 60px;">
                    <td rowspan="1" class="td_name">公司简介</td>
                    <td rowspan="1" colspan="5">
                        <textarea readonly name="Description" style="border:0;"  class="edit form-control transparent"  f-options="{'code':'description','type':'richtext','etype':'editable','len':''}" verify="{}"></textarea>
                    </td>
                </tr>
            </tbody>
        </table>
        <!-- 表单结尾 -->
    </div>

    <!--通用页尾开始-->
    <!--#include file="/Controls/PMS/footer.aspx"-->
    <!--通用页尾结尾-->

    <script type="text/javascript">
        var reqeustDone = function () {		/*所有JS加载完成以后执行*/
            if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
            if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
            setTimeout("initTableForm($('#fe39a44c-f33d-47e4-b418-427f0a05e209'))", 300);
        };
        var _jsUrl = "<%=MinifyUrl("FormJs")%>";
    </script>
    <script src="/assets/js/jquery-1.11.1.min.js"></script>
	<!--#include file="/Controls/PMS/JS.aspx"-->
    <script src="/assets/request_minify.js"></script>
</body>
</html>