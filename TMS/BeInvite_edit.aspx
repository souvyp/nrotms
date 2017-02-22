<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>客户信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="BeInvite">

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
    var __saveNdtCfg = '{"main":{"insertVml":"tms_0062","updateVml":"","queryVml":"tms_0085"}}';
</script>
 <table class="FormTable Y_alter" style="width:100%;" id="60eeb3b4-c3e1-4225-943d-2b83f7377390" path="OTMS_TEST/eonrfvtq" code="eonrfvtq">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
  </colgroup>
  <tbody>
    <tr>
      <td class="text-left" colspan="4"  style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">客户信息</p></div></td>
      <td colspan="4" style="border:0; border-bottom:1px solid #e1e6eb;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <a class="btn btn-red footKeepBtn" href="javascript:void(0);" onclick="SupplierAccept( 1,  $('input[name=\'id\']').val())">同意&nbsp;<span class="glyphicon glyphicon-ok-circle"></span></a>
           <a class="btn btn-red noBtn" href="javascript:void(0);" onclick = "SupplierAccept( 2,  $('input[name=\'id\']').val())">拒绝&nbsp;<span class="glyphicon glyphicon-thumbs-down"></span></a>
            <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
    <tr>
       <td rowspan="1" colspan="8" style="height:15px; border:0; background-color:white;"></td>
    </tr>
    <tr style="height: 26px;">
        <td class="td_name"  > 
                客户公司编号
        </td>
        
        <td class=""  colspan="7">
            <input name="CompanyCode" class="edit form-control transparent"  f-options="{'code':'CompanyCode','type':'text','etype':'editable','len':'50'}" verify="{}">
        </td>    

    </tr>
    <tr style="height: 26px;">
        <td class="td_name"> 
                客户公司名称
        </td>
        <td class="" colspan="7">
            <input name="CompanyName" class="edit form-control transparent"  f-options="{'code':'CompanyName','type':'text','etype':'editable','len':'50'}" verify="{}">
        </td>    

    </tr>
    <tr style="height: 26px;">
      <td class="td_name" rowspan="8" colspan="1">邀请信</td>
      <td rowspan="8" colspan="7">
        <textarea name="InviteDesc" class="edit form-control transparent" f-options="{'code':'InviteDesc','type':'richtext','etype':'editable','len':'500'}" verify="{'title':'InviteDesc','length':'500','required':true}"></textarea>
      </td>
    </tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
    <tr style="height: 26px;"></tr>
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
        setTimeout("initTableForm($('#60eeb3b4-c3e1-4225-943d-2b83f7377390'))", 300);
    };
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>