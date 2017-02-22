<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>已关闭报价单-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="SelfClosed">

<style type="text/css">
#demo .jptable tr td button
{
margin:0px 5px;
padding:0;
}
</style>

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

<!-- 模板开始-->
<script id="jplist-template" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable table" id="demoList">
			<thead>
				<tr class="trtitle">
					<td style="width:35px;"></td>
					<td class="title" style="width:200px;">报价单编码</td>
					<td class="title">单据编号</td>
					<td class="title">合同编号</td>
 					<td class="title">客户名称</td>
                    <td class="title">报价方式</td>
                    <td class="title">报价状态</td>
                    <td class="title">承运方标记名称</td>
    			</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
					<td class="title" title="{{$value.code}}" fld="code">
                        {{if $value.type == 1}}
                            <a target="_blank" href="SelfSent_edit.aspx?id={{$value.id}}&code=SelfClosed">{{$value.code}}
                        {{else if $value.type == 3}}
	                        <a target="_blank" href="SelfSentAddition_edit.aspx?id={{$value.id}}&code=SelfClosed&OrderID={{$value.OrderID}}">{{$value.code}}  
                        {{else if $value.type == 4}}
	                        <a target="_blank" href="SelfSentCombined_edit.aspx?id={{$value.id}}&code=SelfClosed">{{$value.code}}
	                    {{else if $value.type == 5}}
	                        <a target="_blank" href="SelfSentAddCombined_edit.aspx?id={{$value.id}}&code=SelfClosed&OrderID={{$value.OrderID}}">{{$value.code}}
                        {{/if}}
                    </td>
                    <td class="title" title="{{$value.OrderCode}}" fld="OrderCode">{{$value.OrderCode}}</td>
                    <td class="title" title="{{$value.PactCode}}" fld="PactCode">{{$value.PactCode}}</td>
 					<td class="title" title="{{$value.customercompanyname}}" fld="customercompanyname">{{$value.customercompanyname}}</td>                    
                    <td class="title" title="{{$value.type}}" fld="type">
                        {{if $value.type == "1"}}
                            按单报价
                        {{else if $value.type == "3" }}
                            按单补充
                        {{else if $value.type == "4" }}
                            合单报价
                        {{else if $value.type == "5" }}
                            合单补充
                        {{/if}}
                    </td>
                    <td class="title" title="{{$value.StatusName}}" fld="StatusName">{{$value.StatusName}}</td> 
                    <td class="title" title="{{$value.SupplierSymbolName}}" fld="SupplierSymbolName">{{$value.SupplierSymbolName}}</td> 
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
            <div class="maintitle_container">
               <p class="mainHtml_tit">已关闭报价单</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">	
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>			
			    <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-search-button"></button>
				</div>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="id" data-order="asc" data-type="number">排序</span></li>
						<li><span data-path="name" data-order="asc" data-type="text">报价单名称</span></li>
						<li><span data-path="PactCode" data-order="desc" data-type="text">合同编号</span></li>
					</ul>
				</div>

				<div class="text-filter-box"><input data-path="OrderCode" data-button="#opt_status-search-button" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="OrderCode" data-control-action="filter"> </div>
				
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">姓名:</div><![endif]--><input data-path="PactCode" data-button="#sopt_status-search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="PactCode" data-control-action="filter"></div>
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">编码:</div><![endif]--><input data-path="code" data-button="#opt_status-search-button" type="text" value="" placeholder="报价单编码" data-control-type="textbox" data-control-name="code" data-control-action="filter"></div>
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">客户名称:</div><![endif]--><input data-path="customercompanyname" data-button="#opt_status-search-button" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="customercompanyname" data-control-action="filter"></div>
				
				
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">制单时间:</div><![endif]--><input readonly data-path="createtime" onclick="GetDateEvent(this, { format: 'YYYY-MM-DD' })" data-button="#search-button" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter">
					<button type="button" id="search-button">
						<i class="glyphicon glyphicon-search"></i>
					</button>				
				</div>
       
                <div class="clearfix"></div>
                <!-- 加载数据时显示 -->
				<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow anothertab_martop"></div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>没有数据</p>
				</div>
			</div>
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
			<div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
				<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down left" data-control-type="items-per-page-drop-down"	data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
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

<!--通用页尾开始-->
<!--#include file="/Controls/PMS/footer.aspx"-->
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
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "SelfClosed", "/Widget.aspx?param=jplist&vid=grid_jplist_0102");

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
