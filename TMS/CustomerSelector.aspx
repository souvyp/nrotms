<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>客户选择</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("SelectorCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="client" style="width:800px">
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
					<td style="width:35px;"></td>
					<td class="title">公司编号</td>
					<td class="title">公司全称</td>
					<td class="title">所属行业</td>
					<td class="title">公司网站</td>
					<td class="title">公司简称</td>
					<td class="title">联系人</td>
					<td class="title">联系电话</td>
					<td class="title">传真</td>
                    
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr onDblClick="dblEvents()">
					<td style="width:35px"><input type="radio" name="id" fld="id" value="{{$value.id}}"/><!--{{$index+1}}--></td>
					<td class="title" fld="ClientCode">{{$value.ClientCode}}</td>
					<td class="title" fld="Name">{{$value.Name}}</td>
					<td class="title" fld="Industry">
                        {{if $value.Industry == "1"}}
							互联网/电子商务
						{{else if $value.Industry == "2"}}
							计算机软件
						{{else if $value.Industry == "3"}}
							计算机硬件
                        {{else if $value.Industry == "4"}}
							财务/审计
                        {{else if $value.Industry == "5"}}
							 金融/银行
                        {{else if $value.Industry == "6"}}
							 保险/贸易进出口
                        {{else if $value.Industry == "7"}}
							 建筑/建材
                        {{else if $value.Industry == "8"}}
							 人力资源服务
                        {{else if $value.Industry == "9"}}
							  法律/法务
                        {{else if $value.Industry == "10"}}
							  航空/航天
                        {{else if $value.Industry == "11"}}
							  其它行业
						{{/if}}
                    </td>
					<td class="title" fld="Web">{{$value.Web}}</td>
					<td class="title" fld="ShortName">{{$value.ShortName}}</td>
					<td class="title" fld="Contact">{{$value.Contact}}</td>
					<td class="title" fld="Phone">{{$value.Phone}}</td>
					<td class="title" fld="Fax">{{$value.Fax}}</td>
                    <td style="display:none" class="title" fld="CompanyID">{{$value.CompanyID}}</td>
                    <td style="display:none" class="title" fld="EnName">{{$value.EnName}}</td>
                    <td style="display:none" class="title" fld="hortEnName">{{$value.hortEnName}}</td>
                    <td style="display:none" class="title" fld="Master">{{$value.Master}}</td>
                    <td style="display:none" class="title" fld="License">{{$value.License}}</td>
                    <td style="display:none" class="title" fld="Zip">{{$value.Zip}}</td>
                    <td style="display:none" class="title" fld="Address">{{$value.Address}}</td>
                    <td style="display:none" class="title" fld="Mail">{{$value.Address}}</td>
                    <td style="display:none" class="title" fld="Weixin">{{$value.Weixin}}</td>
                    <td style="display:none" class="title" fld="Bank">{{$value.Bank}}</td>
                    <td style="display:none" class="title" fld="BankAccount">{{$value.BankAccount}}</td>
                    <td style="display:none" class="title" fld="Comments">{{$value.Comments}}</td>
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
						<li><span data-path="Name" data-order="asc" data-type="text">公司全称</span></li>
					</ul>
				</div>
			<div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="opt_status-search-button"></button></div>
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">姓名:</div><![endif]--><input data-path="Name" data-button="#name-search-button" type="text" value="" placeholder="公司全称" data-control-type="textbox" data-control-name="Name" data-control-action="filter"> <button type="button" id="name-search-button"><i class="glyphicon glyphicon-search"></i></button></div>
				
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
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "client", "/Widget.aspx?param=jplist&vid=grid_jplist_0002");

        resizeCols = setInterval('resizeTable()', 200);
    };
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/plugins/jquery/colResizable-1.5.min.js"></script>
<script src="/assets/request_minify.js"></script>
</body>
</html>
