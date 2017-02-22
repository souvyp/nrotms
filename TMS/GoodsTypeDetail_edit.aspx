<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>物品类型信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="GoodsType">

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
    var __saveNdtCfg = '{"main":{"insertVml":"tms_0001","updateVml":"tms_0001","queryVml":"tms_0004"}}';
</script>
 <table class="FormTable Y_alter" style="width:100%;" id="0d609b55-8534-4f17-8b5c-139c14f2328d" path="OTMS/GoodsType" code="GoodsType">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width:120px;">
    <col style="width:120px;" class="">
  </colgroup>
  <tbody>
    <tr>
      <td class="text-left" rowspan="1" colspan="4" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">物品类型信息</p></div></td>
      <td colspan="4" style="border:0; border-bottom:1px solid #e1e6eb;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#0d609b55-8534-4f17-8b5c-139c14f2328d'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
            <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
   <tr>
      <td rowspan="1" colspan="8" style="background-color:white; border:0;height:15px;"></td>
    </tr>
    <tr style="height: 26px;display:none;" >
      <td class="td_name">类别编号</td>
      <td colspan="7">
        <input name="ID" title="类型名称" oc="text" class="edit form-control transparent" f-options="{'code':'ID','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">类型名称</td>
      <td colspan="7">
        <input name="Name" title="类型名称" oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'300'}" verify="{'title':'类型名称','length':'300','required':true}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">备注</td>
      <td rowspan="1" colspan="7" style="height:60px;">
          <textarea name="Description" title="备注" style="border:0;"  class="edit form-control transparent"  f-options="{'code':'description','type':'richtext','etype':'editable','len':''}" verify="{}"></textarea>
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
        setTimeout("initTableForm($('#0d609b55-8534-4f17-8b5c-139c14f2328d'))", 300);

        $('input,textarea').attr('readonly', 'readonly');
    };
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
