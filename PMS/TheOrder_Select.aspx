<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>订单选择</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("SelectorCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="TheOrder_Select" style="width:800px">
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

<!-- 模板开始-->
<script id="jplist-template" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable table" id="demoList">
			<thead>
				<tr class="trtitle">
					<td style="width:2%;"></td>
					<td class="title">订单编号</td>
					<td class="title">客户名称</td>
					<td class="title">发货地址</td>
					<td class="title">收货地址</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="radio" name="id" fld="id" value="{{$value.id}}"/><!--{{$index+1}}--></td>
					<td class="title" fld="Code">{{$value.Code}}</td>
					<td class="title" fld="CustomerName">{{$value.CustomerName}}</td>
					<td class="title" fld="IFrom">{{$value.IFrom}}</td>
					<td class="title" fld="ITo">{{$value.ITo}}</td>
					<td style="display:none;" class="title" fld="CreateTime">{{$value.CreateTime}}</td>
					<td style="display:none;" class="title" fld="Creator">{{$value.Creator}}</td>
					<td style="display:none;" class="title" fld="IsPick">{{$value.IsPick}}</td>
					<td style="display:none;" class="title" fld="IsOnLoad">{{$value.IsOnLoad}}</td>
					<td style="display:none;" class="title" fld="EndUserName">{{$value.EndUserName}}</td>
					<td style="display:none;" class="title" fld="IsOffLoad">{{$value.IsOffLoad}}</td>
					<td style="display:none;" class="title" fld="FromProvince">{{$value.FromProvince}}</td>
					<td style="display:none;" class="title" fld="FromCity">{{$value.FromCity}}</td>
					<td style="display:none;" class="title" fld="FromDistrict">{{$value.FromDistrict}}</td>
					<td style="display:none;" class="title" fld="ToProvince">{{$value.ToProvince}}</td>
					<td style="display:none;" class="title" fld="ToCity">{{$value.ToCity}}</td>
					<td style="display:none;" class="title" fld="ToDistrict">{{$value.ToDistrict}}</td>
					<td style="display:none;" class="title" fld="TransportMode">{{$value.TransportMode}}</td>
					<td style="display:none;" class="title" fld="IsInsurance">{{$value.IsInsurance}}</td>
					<td style="display:none;" class="title" fld="ChargeMode">{{$value.ChargeMode}}</td>
					<td style="display:none;" class="title" fld="PriceUnit">{{$value.PriceUnit}}</td>
					<td style="display:none;" class="title" fld="TotalAmount">{{$value.TotalAmount}}</td>
					<td style="display:none;" class="title" fld="TotalVolume">{{$value.TotalVolume}}</td>
					<td style="display:none;" class="title" fld="TotalWeight">{{$value.TotalWeight}}</td>
					<td style="display:none;" class="title" fld="IsDelivery">{{$value.IsDelivery}}</td>
					<td style="display:none;" class="title" fld="CustomerID">{{$value.CustomerID}}</td>
				</tr>
			{{/each}}
			</tbody>
		</table>
	</div>
</div>
</script>
<!-- 模板结尾 -->

<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
		<div id="demo" class="box jplist">
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
				<div class="jplist-drop-down" data-control-type="items-per-page-drop-down" data-control-name="paging" data-control-action="paging">
					<ul>
						<li><span data-number="3"> 每页 3 个项目 </span></li>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10" data-default="true"> 每页 10 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="statustime" data-order="asc" data-type="date">排序</span></li>
					</ul>
				</div>
			<div class="text-filter-box" style="display:none;">
					<select data-control-type="filter-select" data-control-name="customerid" data-control-action="filter">
						<option data-path="<%=Request.QueryString["value"]%>" selected>客户编号</option>
					</select>
			</div>
            <div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">客户名称:</div><![endif]--><input data-path="CustomerName" data-button="#name-search-button" type="text" value="" placeholder="公司名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter"> <button type="button" id="name-search-button"><i class="glyphicon glyphicon-search"></i></button></div>
			<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">订单编号:</div><![endif]--><input data-path="code" data-button="#code-search-button" type="text" value="" placeholder="订单编号" data-control-type="textbox" data-control-name="code" data-control-action="filter"> <button type="button" id="code-search-button"><i class="glyphicon glyphicon-search"></i></button></div>
            <div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="opt_status-search-button"></button></div>
				<!-- 分页结果 -->
				<div class="jplist-label" data-type="第 {current} 页，共 {pages} 页" data-control-type="pagination-info" data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging" data-control-action="paging"></div>
				<!-- 加载数据时显示 -->
				<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow"></div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>没有数据</p>
				</div>
			</div>
		</div>
		<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				

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
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "client", "/Widget.aspx?param=jplist&vid=grid_jplist_0051");

        resizeCols = setInterval('resizeTable()', 200);
    };
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/PMS/JS.aspx"-->
<script src="/assets/plugins/jquery/colResizable-1.5.min.js"></script>
<script src="/assets/request_minify.js"></script>
</body>
</html>
