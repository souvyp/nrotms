﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>车辆选择</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("SelectorCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="CarsSelector" style="width:800px">
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
		<table class="jptable table">
			<thead>
				<tr class="trtitle">
					<td style="width:35px;"></td>
					<td class="title">车牌号</td>
					<td class="title">车型</td>
					<td class="title">车长</td>
					<td class="title">载重</td>
					<td class="title">座位数</td>
					<td class="title">购入日期</td>
					<td class="title">保险日期</td>
					<td class="title">车辆品牌</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr onDblClick="dblEvents()">
					<td style="width:35px"><input type="radio" name="id" fld="id" value="{{$value.id}}"/><!--{{$index+1}}--></td>
					<td class="title" title="{{$value.SN}}" fld="SN">{{$value.SN}}</td>
					<td class="title" fld="Type">
						{{if $value.Type == '1'}}
                        半挂车
                        {{else if $value.Type == '2'}}
                        高栏车
                        {{else if $value.Type == '3'}}
                        厢式货车
                        {{else if $value.Type == '4'}}
                        平板车
                        {{/if}}
					</td>
					<td class="title"  fld="Length">
                        {{if $value.Length == '999.00'}}
                        其他
                        {{else}}
                        {{$value.Length}}
                        {{/if}}                        
                    </td>
					<td class="title"  title="{{$value.Weight}}" fld="Weight">{{$value.Weight}}</td>
					<td class="title"  title="{{$value.Seats}}" fld="Seats">{{$value.Seats}}</td>
					<td class="title"  title="{{$value.PurchaseTime}}" fld="PurchaseTime">{{$value.PurchaseTime}}</td>
					<td class="title"  title="{{$value.Insurance}}" fld="Insurance">{{$value.Insurance}}</td>
					<td class="title"  title="{{$value.Brand}}" fld="Brand">{{$value.Brand}}</td>
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
				<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
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
						<li><span data-path="id" data-order="desc" data-type="number">排序</span></li>
						<li><span data-path="SN" data-order="asc" data-type="text">车牌号</span></li>
					</ul>
				</div>
			    <div class="text-filter-box" style="display:none;">
                    <input class="SupName" data-path="SupplierID" type="text" value='<%=Request.QueryString["value"]%>' data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="SupplierID" data-control-action="filter"/>
                    <button type="button" id="opt_status-search-button"></button>
			    </div>
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">姓名:</div><![endif]--><input data-path="SN" data-button="#name-search-button" type="text" value="" placeholder="车牌号" data-control-type="textbox" data-control-name="SN" data-control-action="filter"> <button type="button" id="name-search-button"><i class="glyphicon glyphicon-search"></i></button></div>
                <div class="text-filter-box hidden">
					<%if (Request.QueryString["cartype"] != null && Request.QueryString["cartype"] != "") {%>
					<select data-control-type="filter-select" data-control-name="Type" data-control-action="filter">
						<option data-path="<%=Request.QueryString["cartype"]%>" selected>车型</option>
					</select>
					<%}%>
					<%if (Request.QueryString["carlength"] != null && Request.QueryString["carlength"] != "") {%>
					<select data-control-type="filter-select" data-control-name="Length" data-control-action="filter">
						<option data-path="<%=Request.QueryString["carlength"]%>" selected>车长</option>
					</select>
					<%}%>
				</div>
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
            <!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
				<!-- 分页结果 -->
				<div class="jplist-label"	data-type="{start} - {end} / {all}" data-control-type="pagination-info"	data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true"></div>
			</div> 
		</div>
		<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				

<script type="text/javascript">
	var reqeustDone = function(){		/*所有JS加载完成以后执行*/
		if ( typeof(initHeader) != "undefined" ) initHeader();					/*初始化页面通用头部*/
		if ( typeof ( initFooter ) != "undefined" ) initFooter();               /*初始化页面通用底部*/
		InitList( $( "#demo" ), $( "#demo .list" ), $( "#jplist-template" ).html(), "CarsSelector", "/Widget.aspx?param=jplist&vid=grid_jplist_0019" );
	}
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
