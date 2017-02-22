<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>物品选择</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("SelectorCss")%>" rel="stylesheet" type="text/css" />
<style type="text/css">
	[id^="checkbox-"] + label {
		border: 1px solid #DDDDDD;
	    width: 13px;
	    height: 12px;
	}
	 
	[id^="checkbox-"]:checked + label:after {
		content: '\2713';
		color: #F27302;
		position:relative;
		bottom:10px;
		right:5px;
	}  

</style>
</head>
<body code="goods" style="width:800px">
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
					<td style="width:35px;">
						<input type="checkbox" id="checkbox-0" style="display:none" onclick="checkboxAll(this)" />
						<label for="checkbox-0"></label>
					</td>
					<td class="title">物品名称</td>
					<td class="title">单价(元)</td>
					<td class="title">规格</td>
					<td class="title">体积(立方米)</td>
					<td class="title">重量(公斤)</td>
					<td class="title">毛重(公斤)</td>
					<td class="title">数量单位</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr onDblClick="dblEvents()">
					<td style="width:35px">
						<input type="checkbox" id="checkbox-{{$index+1}}" style="display:none"  name="id" fld="id" value="{{$value.id}}"/>
						<label for="checkbox-{{$index+1}}"></label>
					</td>
                    <td class="title" fld="Name" title="{{$value.Name}}">{{$value.Name}}</td>
					<td class="title" fld="Price">{{$value.Price}}</td>
					<td class="title" fld="SPC">{{$value.SPC}}</td>
					<td class="title" fld="Volume">{{$value.Volume}}</td>
					<td class="title" fld="Weight">{{$value.Weight}}</td>
					<td class="title" fld="MWeight">{{$value.MWeight}}</td>
					<td class="title" fld="UnitName">{{$value.UnitName}}</td>
					<td class="title" style="display:none" fld="Qty"></td>
					<td class="title" style="display:none" fld="Unit">{{$value.Unit}}</td>
					<td class="title" style="display:none" fld="Code">{{$value.Code}}</td>
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
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="id" data-order="desc" data-type="number">排序</span></li>
					</ul>
				</div>
                <div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">姓名:</div><![endif]--><input data-path="Name" data-button="#name-search-button" type="text" value="" placeholder="物品名称" data-control-type="textbox" data-control-name="Name" data-control-action="filter"> <button type="button" id="name-search-button"><i class="glyphicon glyphicon-search"></i></button></div>
			    <div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="opt_status-search-button"></button></div>
				<div class="text-filter-box hidden">
					<select data-control-type="filter-select" data-control-name="CustomerCompanyID" data-control-action="filter">
						<option data-path="<%=Request.QueryString["value"]%>" selected>编号</option>
					</select>
				</div>
                
				<!-- 加载数据时显示 -->
				<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow"></div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>您还没有物品信息，请前往“客户资源管理”创建您的“客户物品”</p>
				</div>
			</div>
            <!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
				<div class="jplist-drop-down" data-control-type="items-per-page-drop-down" data-control-name="paging" data-control-action="paging">
					<ul>
						<li><span data-number="3"> 每页 3 个项目 </span></li>
						<li><span data-number="5" data-default="true"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>
				<!-- 分页结果 -->
				<div class="jplist-label"	data-type="{start} - {end} / {all}" data-control-type="pagination-info"	data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true"></div>
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
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "client", "/Widget.aspx?param=jplist&vid=grid_jplist_0090");

        resizeCols = setInterval('resizeTable()', 200);
    };
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/plugins/jquery/colResizable-1.5.min.js"></script>
<script src="/assets/request_minify.js"></script>
</body>
</html>
