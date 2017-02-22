<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>司机信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="driver">

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

<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
    var __saveNdtCfg = '{"main":{"insertVml":"tms_0032","updateVml":"tms_0032","queryVml":"tms_0034"}}';
</script>
 <table class="FormTable Y_alter FormTable6" style="width:100%;" id="1b39ced2-fdee-4688-83f7-5e0c3f41e8de" path="OTMS/driver" code="driver">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
  </colgroup>
  <tbody>
    <tr>
      <td class="text-left" rowspan="1" colspan="3" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">司机信息</p></div></td>
      <td colspan="3" style="border:0; border-bottom:1px solid #e1e6eb;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <!--<a class="btn btn-red footKeepBtn" href="javascript:void(0);" ev="%23saveNDT%23">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>-->
            <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#1b39ced2-fdee-4688-83f7-5e0c3f41e8de'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
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
      <td class="td_name" rowspan="1" colspan="6">
        <input name="ID" title="司机编号" oc="text" class="edit form-control transparent" f-options="{'code':'ID','type':'text','etype':'editable','len':'50'}" verify="">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">姓名<span class="need_write">*</span></td>
      <td class="">
        <input name="Name" title="姓名" oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'300'}" verify="{'title':'姓名','length':'300','required':true}">
      </td>
      <td class="td_name">性别</td>
      <td class="">
            <ul class="edit form-control list-inline" name="Gender" type="radio" f-options="{'code':'Gender','type':'radio','etype':'editable','len':'1','cls':'list','url':'','id':'','text':''}" verify="{}">
            <li>
                <input type="radio" name="Gender" class="edit-list transparent" value="0" checked >男
            </li>
            <li>
                <input type="radio" name="Gender" class="edit-list transparent" value="1">女
            </li>
            </ul>
      </td>
      <td rowspan="4" colspan="2">
         <input type="file" title="照片" oc="image" class="edit form-control droparea spot" name="Photo" data-post="/ImageUploader.aspx?filename=Photo&mode=droparea" data-width="50" data-height="50" data-crop="true" f-options="{'code':'Photo','type':'image','etype':'editable','len':'300'}" verify="{}">      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">出生日期</td>
      <td class="">
        <input name="Birthday" title="出生日期" oc="date" class="laydate-icon edit" onclick="TrigerDateEvent(this,{format: 'YYYY-MM-DD'})" f-options="{'code':'Birthday','type':'date','etype':'editable','len':'50'}" verify="{}">
      </td>
      <td class="td_name">联系电话<span class="need_write">*</span></td>
      <td class="">
        <input name="Phone" title="联系电话" oc="text" class="edit form-control transparent" f-options="{'code':'Phone','type':'text','etype':'editable','len':'50'}" verify="{'title':'联系电话','length':'50','required':true,'textarea1':true,'validate':'{\'pattern\': \'^((([0\+][0-9]{2,3}-)?(0[0-9]{2,3})-)?([0-9]{7,8})?(([0-9]{7,8})(-([0-9]{3,}))?))?(([1][3|4|5|7|8][0-9])[0-9]{8})?$\',\'message\': \'格式不正确，请重新输入！\'}'}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">驾照日期<span class="need_write">*</span></td>
      <td class="">
        <input name="LicensedDate" title="驾照日期" oc="date" class="laydate-icon edit" onclick="TrigerDateEvent(this,{format: 'YYYY-MM-DD'})" f-options="{'code':'LicensedDate','type':'date','etype':'editable','len':'50'}" verify="{'title':'驾照日期','required':true}">
      </td>
      <td class="td_name">驾照类型<span class="need_write">*</span></td>
      <td class="">
        <ul class="edit form-control list-inline" name="LicenseType" type="radio" f-options="{'code':'LicenseType','type':'radio','etype':'editable','len':'8','cls':'list','url':'','id':'','text':''}" verify="{}">
            <li>
                <input type="radio" name="LicenseType" class="edit-list transparent" value="1" checked="checked">A照
            </li>
            <li>
                <input type="radio" name="LicenseType" class="edit-list transparent" value="2">B照
            </li>
            <li>
                <input type="radio" name="LicenseType" class="edit-list transparent" value="3">C照
            </li>
        </ul>
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">驾驶证号<span class="need_write">*</span></td>
      <td class="" rowspan="1" colspan="3">
        <input name="SN" title="驾驶证号" oc="text" class="edit form-control transparent" f-options="{'code':'SN','type':'text','etype':'editable','len':'100'}" verify="{'title':'驾驶证号','required':true,'textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'(^[0-9]{15}$)|(^[0-9]{18}$)|(^[0-9]{17}([0-9]|X|x)$)\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
      </td>
      
    </tr>
    <tr style="height: 26px; display:none;">
      <td class="td_name">身份证号<span class="need_write">*</span></td>
      <td class="" rowspan="1" colspan="3">
        <input name="PersonalSN" title="身份证号" oc="text" class="edit form-control transparent" f-options="{'code':'PersonalSN','type':'text','etype':'editable','len':'100'}" verify="{'title':'身份证号'}" maxlength="18">
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
        initTableForm($('#1b39ced2-fdee-4688-83f7-5e0c3f41e8de'), false, function () {
            ifChecked();
            ifBoxChecked();
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
