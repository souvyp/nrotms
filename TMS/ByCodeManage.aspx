<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>编码转换-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="ByCodeManage">

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

<!-- 模板开始-->
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<div class="maintitle_container">
               <p class="mainHtml_tit">订单查询</p>
        </div>
        <hr style="menu-class" >
        <div class="jplist-panel box panel-top min_height">
            <%--<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>--%>
            <div class="text-filter-box">
                    <input data-path="Code" data-button="#CodeButton" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
                    <button type="button" id="CodeButton" onclick="QueryOrdersByCode( $(this).prev().val(), 1 )">
                         <i class="glyphicon glyphicon-search"></i>
                     </button>
			</div>
		</div>
		<div class="jplist-panel box panel-top min_height" style="margin-top:10px !important;">
			<table class="jptable  table" id="demoList" style="margin-top:0;">
				<thead>
					<tr class="trtitle">
						<td class="title">单据编号</td>
						<td class="title">合同编号</td>
	                    <td class="title">客户名称</td>
						<td class="title">收货方名称</td>
						<td class="title">发货地址</td>
						<td class="title">收货地址</td>
						<td class="title">订单状态</td>
						<td class="title">重量(公斤)</td>
						<td class="title">体积(立方米)</td>
						<td class="title">数量</td>
					</tr>
				</thead>
				<tbody>
					<tr style="display:none" name="orderList" >
						<td class="title" view-fld='{fld:"Code", method:"template",template:"<a target=\"_blank\" href=\"TrackingManage_edit.aspx?id=@id@\">@code@</a>"}'></td>
						<td class="title" view-fld='{fld:"PactCode", method:"show"}'></td>
						<td class="title" view-fld='{fld:"CustomerName", method:"show"}'></td>
						<td class="title" view-fld='{fld:"EndUserName", method:"show"}'></td>
						<td class="title" view-fld='{fld:"From", method:"show"}'></td>
						<td class="title" view-fld='{fld:"TO", method:"show"}'></td>
						<td class="title" view-fld='{fld:"StatusName", method:"show"}'></td>
						<td class="title" view-fld='{fld:"Weight", method:"show"}'></td>
						<td class="title" view-fld='{fld:"Volume", method:"show"}'></td>
						<td class="title" view-fld='{fld:"Amount", method:"show"}'></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
    <div class="page"></div>
    <div name="first-ds-pag">
        <div style="text-align:center;display:none">
            <ul class="pag pagination">
                <li class="bord_li prev"><a href="#">
                    <img src="/assets/NSF/images/left.png" /></a>
                </li>
                <li class="bord_li next"><a href="#">
                    <img src="/assets/NSF/images/right.png" /></a>
                </li>
                <li class="bord_li border_li_marg showrec">每页<span class="pagesize"></span>条 ， 共<span class="recamount"></span>条</li>
            </ul>
        </div>
    </div>
</div>


<!--通用页尾开始-->
<!--#include file="/Controls/TMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    function resizeTable() {
        if ($("#demoList").length == 0) {
            return;
        }
        else {
            $("#demoList").colResizable({ liveDrag: true });

            resizeCols = clearInterval(resizeCols);
        }
    }
    var resizeCols = null;
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        //InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "OrderTracking", "/Widget.aspx?param=jplist&vid=grid_jplist_0013");

        resizeCols = setInterval('resizeTable()', 200);
    };
    var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/plugins/jquery/colResizable-1.5.min.js"></script>
<script src="/assets/request_minify.js"></script>
<style>
.jptable tr td:nth-child(2),.jptable tr td:nth-child(3) {
    /*width: 20%;
    text-align: left;
    padding: 12px 5px !important;
    word-break: break-all;
	white-space: inherit !important;*/
}
</style>
</body>
</html>
