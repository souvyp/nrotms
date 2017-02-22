<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>历史消息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="EventsHistory">

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

<style>
    .jptable tr td:first-child{
        width:1% !important;
    }
</style>
<!-- 模板开始-->
<script id="jplist-template" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable  table">
			<thead>
				<tr class="trtitle">
					<td style=""></td>
					<td class="title">事件</td>
					<td class="title">发生时间</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="ID" fld="id" value="{{$value.ID}}"/>{{$index+1}}</td>
					<td class="title" fld="Event_Type">
						{{if $value.Event_Type == '1'}}
                            <a target="_blank" href="BeInvite.aspx">
                                {{$value.Event_DstCompanyName}}被邀请成为承运方
                            </a>
                        {{else if $value.Event_Type == '2'}}
                            <a target="_blank" href="Invite.aspx">
                               邀请{{$value.Event_SrcCompanyName}}成为承运方被拒绝
                            </a>
                        {{else if $value.Event_Type == '3'}}
                            <a target="_blank" href="OrderAccept_edit.aspx?id={{$value.Event_Ext}}">
                               待接收订单：{{$value.Event_Ext}}
                            </a>
						{{else if $value.Event_Type == '7'}}
						 	<a target="_blank" href="VerifingDoc.aspx?id={{$value.Event_Ext}}">
                               待审核报价单：{{$value.Event_Ext}}
                            </a>
                        {{else if $value.Event_Type == '8'}}
						 	<a target="_blank" href="MySending.aspx?id={{$value.Event_Ext}}">
                               {{$value.Event_SrcCompanyName}}拒绝了报价单：{{$value.Event_Ext}};
                            </a>
                         {{else if $value.Event_Type == '9'}}
                            <a target="_blank" href="SupplierList.aspx">
                               {{$value.Event_SrcCompanyName}}同意成为承运方
                            </a>
                        {{else if $value.Event_Type == '11'}}
						 	<a target="_blank" href="Index.aspx?id={{$value.Event_Ext}}">
                               {{$value.Event_SrcCompanyName}}接收了报价单：{{$value.Event_Ext}};
                            </a>
                        {{else if $value.Event_Type == '15'}}
						 	<a target="_blank" href="Index.aspx?id={{$value.Event_Ext}}">
                               被强制过期的报价单：{{$value.Event_Ext}};
                            </a>
                        {{/if}}
                    </td>
					<td class="title" fld="Event_Time">{{$value.Event_Time}}</td>
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
               <p class="mainHtml_tit">历史消息</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
				
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
						<li><span data-path="Event_Time" data-order="desc" data-type="number">排序</span></li>
					</ul>
				</div>
			    <div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="Button1"></button></div>
				    <!-- 分页结果 -->
				    <div class="jplist-label" data-type="第 {current} 页，共 {pages} 页" data-control-type="pagination-info" data-control-name="paging" data-control-action="paging"></div>
				    <!-- 分页操作 -->
				    <div class="jplist-pagination" data-control-type="pagination" data-control-name="paging" data-control-action="paging"></div>
				    <!-- 加载数据时显示 -->
				    <div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
			    </div>
			    <!-- 操作面板 -->
		    </div>
		<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				

<!--通用页尾开始-->
<!--#include file="/Controls/PMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "EventsHistory", "/Widget.aspx?param=jplist&vid=grid_jplist_0058");
    };
    var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/PMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
