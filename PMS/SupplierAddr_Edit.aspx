<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>承运方常用地址信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--#include file="/Controls/Meta.aspx"-->
    <!--#include file="/Controls/TMS/CSS.aspx"-->
    <link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="SupplierAddr">

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
        <table class="FormTable Y_alter FormTable6" style="width: 100%;" id="7cff24c8-129a-4746-8c7d-55b22bd37199" path="OTMS/SupplierAddr" code="SupplierAddr">
            <colgroup>
                <col style="width: 120px;">
                <col style="width: 200px;">
                <col style="width: 120px;">
                <col style="width: 207px;">
            </colgroup>
            <tbody>
                <tr>
                   <td class="text-left" rowspan="1" colspan="3" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">承运方常用地址信息</p></div></td>
                    <td colspan="3" style="border:0; border-bottom:1px solid #e1e6eb;">
                        <input type="hidden" name="id">
                        <div class="toolbar">
                            <div style="text-align: right;" class="button_workflow">
                                <a class="btn btn-red" href="javascript:void(0);" ev="%23saveNDT%23">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>
                                <a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#7cff24c8-129a-4746-8c7d-55b22bd37199'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>
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
                        <input name="ID" title="地址编号" oc="text" class="edit form-control transparent" f-options="{'code':'ID','type':'text','etype':'editable','len':'50'}" verify="{}">
                    </td>
                </tr>
                <tr class="" style="height: 26px;">

                    <td class="td_name">
						<a href="javascript:void(0);" onclick="showModalWindow(this,'承运方名称')" class="edit" f-options="{'code':'CustomerID','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'SupplierSelector.aspx','vals':'CustomerName=CompanyName,CustomerID=id','modalWindow':'1'}" verify="{}">
                            <input type="hidden" name="CustomerID">承运方名称
                        </a>
					</td>
                    <td class="">
                        <input name="CustomerName" readonly oc="text" class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'CustomerName','length':'50','required':true}">
                    </td>
                    <td class="td_name">地址类型</td>
                    <td class="" colspan="3">
						<input type="hidden" name="Type" value="3">
						承运方常用地址
                    </td>
                </tr>
                <tr style="height: 26px;">
                  <td class="td_name">省</td>
                  <td class="" >
                    <input type="hidden" name="ProvinceID">
                    <select name="ProvinceID_id" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);" f-options="{'code':'ProvinceID','type':'combobox','etype':'','len':'','cls':'vml','vml':'%7Bid%3A%22order_province%22%2Ccross%3A%22false%22%2Cparas%3A%5B%5D%7D','id':'','text':'','linkfield':'','linkcombo':''}" verify="{'title':'ProvinceID','length':'50','required':true}">
                      <option value="">---------------------------</option>
                      <option value="110000">北京市</option>
                      <option value="120000">天津市</option>
                      <option value="130000">河北省</option>
                      <option value="140000">山西省</option>
                      <option value="150000">内蒙古自治区</option>
                      <option value="210000">辽宁省</option>
                      <option value="220000">吉林省</option>
                      <option value="230000">黑龙江省</option>
                      <option value="310000">上海市</option>
                      <option value="320000">江苏省</option>
                      <option value="330000">浙江省</option>
                      <option value="340000">安徽省</option>
                      <option value="350000">福建省</option>
                      <option value="360000">江西省</option>
                      <option value="370000">山东省</option>
                      <option value="410000">河南省</option>
                      <option value="420000">湖北省</option>
                      <option value="430000">湖南省</option>
                      <option value="440000">广东省</option>
                      <option value="450000">广西壮族自治区</option>
                      <option value="460000">海南省</option>
                      <option value="500000">重庆市</option>
                      <option value="510000">四川省</option>
                      <option value="520000">贵州省</option>
                      <option value="530000">云南省</option>
                      <option value="540000">西藏自治区</option>
                      <option value="610000">陕西省</option>
                      <option value="620000">甘肃省</option>
                      <option value="630000">青海省</option>
                      <option value="640000">宁夏回族自治区</option>
                      <option value="650000">新疆维吾尔自治区</option>
                      <option value="710000">台湾省</option>
                      <option value="810000">香港特别行政区</option>
                      <option value="820000">澳门特别行政区</option>
                    </select>
                  </td>
                  <td class="td_name">市</td>
                  <td>
                    <input type="hidden" name="CityID">
                    <select name="CityID_id" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);" f-options="{'code':'CityID','type':'combobox','etype':'','len':'','cls':'vml','vml':'%7Bid%3A%22order_city%22%2Ccross%3A%22false%22%2Cparas%3A%5B%5D%7D','id':'id','text':'name','linkfield':'parentid','linkcombo':'ProvinceID'}" verify="{'title':'CityID','length':'50','required':true}">
                      <option value="">---------------------------</option>
                    </select>
                  </td>
                  <td class="td_name">区</td>
                  <td>
                    <input type="hidden" name="DistrictID">
                    <select name="DistrictID_id" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);" f-options="{'code':'DistrictID','type':'combobox','etype':'','len':'','cls':'vml','vml':'%7Bid%3A%22order_district%22%2Ccross%3A%22false%22%2Cparas%3A%5B%5D%7D','id':'id','text':'name','linkfield':'parentid','linkcombo':'CityID'}" verify="{'title':'DistrictID','length':'50','required':true}">
                      <option value="">---------------------------</option>
                    </select>
                  </td>
                </tr>
                <tr style="height: 26px;">
                    <td class="td_name">地址</td>
                    <td rowspan="1" colspan="5">
                        <input name="Address" title="地址" oc="text" class="edit form-control transparent" f-options="{'code':'Address','type':'text','etype':'editable','len':'50'}" verify="{}">
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
        var reqeustDone = function () {		/*所有JS加载完成以后执行*/
            if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
            if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
            setTimeout("initTableForm($('#7cff24c8-129a-4746-8c7d-55b22bd37199'))", 300);
        };
        var _jsUrl = "<%=MinifyUrl("FormJs")%>";
    </script>
    <script src="/assets/js/jquery-1.11.1.min.js"></script>
	<!--#include file="/Controls/PMS/JS.aspx"-->
    <script src="/assets/request_minify.js"></script>
</body>
</html>
