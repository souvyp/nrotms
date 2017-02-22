<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>我的待办-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<link href="/assets/NSF/css/pagination.css" rel="stylesheet" type="text/css" />

</head>
<body code="WaitDoneEvent" onload="showWaitDoneEvent()">

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
<style>
    .jptable tr td:first-child{
        width:1% !important;
    }
</style>
<!-- 模板开始-->
<div class="list-item box jplist-panel tabbtn" >
	<div class=""><!-- block right -->
        <div class="maintitle_container">
           <p class="mainHtml_tit">我的待办</p>
        </div>
        <hr style="" >
		<table class="jptable  table">
			<thead>
				<tr class="trtitle">
					<td style="" colspan=""></td>
					<td class="title" style="color:#999;">事件</td>
                    <td class="title" style="color:#999;">发生时间</td>
				</tr>
			</thead>
			<tbody>
				<tr name="WaitDoneEvent" view-id='{ id:"tms_0091",cross:"false", rowIdentClass:"WaitDoneEvent", paras:[{"name":"rows","value":5},{"name":"page","value":1}]}' >
                    <td style="width:35px"></td>
					<td style="width:35px" name="WaitEvent" ><a href="javascript:void(0)"></a></td>
					<td class="title" name="Event_Type" style="display:none;" view-fld='{fld:"Event_Type",method:"show"}'></td>
					<td class="title" name="Event_SrcCompanyName" style="display:none;" view-fld='{fld:"Event_SrcCompanyName",method:"show"}'></td>
					<td class="title" name="Event_DstCompanyName" style="display:none;" view-fld='{fld:"Event_DstCompanyName",method:"show"}'></td>
					<td class="title" name="Event_Ext" style="display:none;" view-fld='{fld:"Event_Ext",method:"show"}'></td>
					<td class="title" view-fld='{fld:"Event_Time",method:"show"}'></td>
					<td class="title" style="display:none;" name="Event_Result" view-fld='{fld:"Event_Result",method:"show"}'></td>
                    <td class="title" style="display:none;" name="IsLongDistance" view-fld='{fld:"IsLongDistance",method:"show"}'></td>
				</tr>
			</tbody>
		</table>
	</div>
    <div class="page"></div>
    <div name="first-ds-pag">
        <ul class="pag pagination">
                <li class="bord_li prev"><a href="javascript:void(0)">&laquo;</a></li>
                <li class="bord_li next"><a href="javascript:void(0)">&raquo;</a></li>
                <li class="bord_li border_li_marg showrec">每页<span class="pagesize"></span>条 ， 共<span class="recamount"></span>条</li>
            </ul>
    </div>
</div>
<!-- 模板结尾 -->
		

<!--通用页尾开始-->
<!--#include file="/Controls/TMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
    };
    var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
