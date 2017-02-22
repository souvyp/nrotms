<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>追加备注</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="OrderSign">

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
<script language="javascript">
    var __saveNdtCfg = '{"main":{"insertVml":"Comments_0001","updateVml":"Comments_0001","queryVml":"Comments_0002"}}';
</script>
<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
 <table class="FormTable Y_alter" id="0f517882-d512-44f3-b9aa-0ce06f3777db" path="OTMS/OrderSign" code="OrderSign">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
  </colgroup>
  <tbody>
    <tr>
      <td class="text-left" rowspan="1" colspan="1" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">追加备注</p></div></td>
      <td colspan="1" style="border:0;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
<%--            <a class="btn btn-red" href="javascript:void(0);" onclick="Comments()">提交</a>--%>
            <a class="btn btn-red footKeepBtn" href="javascript:void(0);" ev="%23saveNDT%23">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>
            <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#0f517882-d512-44f3-b9aa-0ce06f3777db'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
            <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
    <tr>
      <td rowspan="1" colspan="2" style="background-color:white; border:0;height:15px;"></td>
    </tr>
    <tr style="height: 66px;">
      <td class="td_name">追加备注</td>
      <td style="width:100%">
        <input type="hidden" name="OrderID" />
        <textarea name="Description" class="edit form-control transparent" f-options="{'code':'Description','type':'richtext','etype':'','len':''}" verify="{'title':'Description','length':'','textarea1':true}"></textarea>
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
		setTimeout("initTableForm($('#0f517882-d512-44f3-b9aa-0ce06f3777db'))", 300);
		var name = getUrlParam('name');
		$('body').attr('code', name);
    };
    var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
