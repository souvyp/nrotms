﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>客户信息列表-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="Customer">

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
		<table class="jptable table table-border" id="demoList">
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
					<td class="title">是否失效</td>
                    <td class="title">操作</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
	                <td class="title"　 fld="ClientCode" title="{{$value.ClientCode}}">{{$value.ClientCode}}</td>				
                    <td class="title" fld="Name" style="text-align:left;"  title="{{$value.Name}}"><a href="Customer_edit.aspx?id={{$value.id}}">{{$value.Name}}</a></td>
					<td class="title" fld="Industry">
                        {{if $value.Industry == "0"}}
							互联网/电子商务
						{{else if $value.Industry == "1"}}
							计算机软件
						{{else if $value.Industry == "2"}}
							计算机硬件
                        {{else if $value.Industry == "3"}}
							财务/审计
                        {{else if $value.Industry == "4"}}
							 金融/银行
                        {{else if $value.Industry == "5"}}
							 保险/贸易进出口
                        {{else if $value.Industry == "6"}}
							 建筑/建材
                        {{else if $value.Industry == "7"}}
							 人力资源服务
                        {{else if $value.Industry == "8"}}
							  法律/法务
                        {{else if $value.Industry == "9"}}
							  航空/航天
                        {{else if $value.Industry == "10"}}
							  其它行业
						{{/if}}
                    </td>
					<td  class="title" fld="Web" style="text-align:left;" title="{{$value.Web}}"><a target="_blank" href="http://{{$value.Web}}" <%--onclick="openBlank('{{$value.id}}')"--%>>{{$value.Web}}</a></td>
					<td  class="title" fld="ShortName" style="text-align:left;" title="{{$value.ShortName}}">{{$value.ShortName}}</td>
					<td  class="title" fld="Contact" title="{{$value.Contact}}">{{$value.Contact}}</td>
					<td  class="title" fld="Phone" title="{{$value.Phone}}">{{$value.Phone}}</td>
					<td class="title" fld="Invalid">
                        {{if $value.Invalid == "0"}}
                            有效
                        {{else if $value.Invalid == "1" }}
                            失效
                        {{/if}}
                    </td>
                   <td class="title">
                    {{if $value.Invalid == "0"}}
                    <span readonly style="margin-right:5px;">启用</span>
                    {{else}}
                    <button type="button"  title="启用"   onclick =  EODCustomer('1','{{$value.id}}') style="margin-left:0;">启用</button>
                    {{/if}}
                    {{if $value.Invalid=="1"}}
                    <span readonly style="margin-left:5px;">禁用</span>
                    {{else}}
                    <button type="button"  title="禁用" onclick =  EODCustomer('0','{{$value.id}}') >禁用</button>  
                    {{/if}}                         
                    </td>
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
               <p class="mainHtml_tit">客户信息</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
                <div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">姓名:</div><![endif]-->
                    <input data-path="Name" data-button="#search-button" type="text" value="" placeholder="公司全称" data-control-type="textbox" data-control-name="Name" data-control-action="filter"> 
                    <button type="button" id="search-button"><i class="glyphicon glyphicon-search"></i></button>
                </div>
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
            <div class="jplist-panel box min_height">
				<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="items-per-page-drop-down" data-control-name="paging" data-control-action="paging">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="InsertTime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="Name" data-order="asc" data-type="text">公司全称</span></li>
					</ul>
				</div>
				
                <!-- 分页结果 -->
				<div class="jplist-label" data-type="第 {current} 页，共 {pages} 页" data-control-type="pagination-info" data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging" data-control-action="paging"></div>
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
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "client", "/Widget.aspx?param=jplist&vid=grid_jplist_0003");

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
