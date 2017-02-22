<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>价格类型信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="Category">

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

<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
    var __saveNdtCfg = '{"main":{"insertVml":"pml_0004","updateVml":"pml_0005","queryVml":"pml_0006"}}';
</script>
 <table class="FormTable Y_alter" style="width:100%;" id="3a2e29ba-3cd1-4cbe-953a-56b52094be0b" path="Price/gmpjneiu" code="gmpjneiu">
  <tbody>
    <tr>
        <td class="text-left" rowspan="1" colspan="2" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">价格类型信息</p></div></td>
      <td colspan="2" style="border:0;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <a class="btn btn-red" href="javascript:void(0);" ev="%23saveNDT%23">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>
            <a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#3a2e29ba-3cd1-4cbe-953a-56b52094be0b'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>
            <a class="btn btn-red" href="javascript:void(0);" onclick="closeForm(this)">关闭&nbsp;<span class="glyphicon glyphicon-remove"></span></a>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
      <tr>
      <td rowspan="1" colspan="4" style="background-color:white; border:0;height:15px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="" style="color: rgb(0, 0, 0); background-color: rgb(242, 242, 242);width:1%">价格类型名称</td>
      <td rowspan="1" colspan="3">
        <input name="name" class="edit form-control transparent" f-options="{'code':'name','type':'text','etype':'','len':''}" verify="{'title':'name','length':'','textarea1':true}">
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
        setTimeout("initTableForm($('#3a2e29ba-3cd1-4cbe-953a-56b52094be0b'))", 300);
    };
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/PMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
