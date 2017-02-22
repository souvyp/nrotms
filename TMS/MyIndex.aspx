<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>个人中心-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<link href="../../css/guideBrows.css" rel="stylesheet" type="text/css"/>
</head>
<body code="Index">
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
<!-- 待接收订单 -->
<script id="jplist-template" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable table">
			<thead>
				<tr class="trtitle">
					<td style="width:35px;"></td>
					<td class="title">单据编号</td>
					<td class="title">合同编号</td>
					<td class="title">客户名称</td>
                    <td class="title">延伸客户</td>
					<td class="title">发货地址</td>
                    <td class="title">收货地址</td>
					<td class="title">数量</td>
					<td class="title">重量</td>
					<td class="title">体积</td>
					<td class="title" style="text-align:left;">操作</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
					<td class="title" fld="Code" title="{{$value.Code}}"><a target="_blank" href="OrderAccept_edit.aspx?id={{$value.id}}" >{{$value.Code}}</a></td>
					<td class="title" title="{{$value.PactCode}}" fld="PactCode">{{$value.PactCode}}</td>
					<td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
					<td class="title" title="{{$value.EndUserName}}" fld="EndUserName">{{$value.EndUserName}}</td>
					<td class="title" title="{{$value.From}}" fld="From">{{$value.From}}</td>
					<td class="title" title="{{$value.To}}" fld="To">{{$value.To}}</td>
                    <td class="title" title="{{$value.Qty}}" fld="">{{$value.Qty}}</td>
                    <td class="title" title="{{$value.Weight}}" fld="">{{$value.Weight}}</td>
                    <td class="title" title="{{$value.Volume}}" fld="">{{$value.Volume}}</td>
					<td class="title" style="text-align:left;">
                        <button type="button"  title="接收订单" onclick = "ReceiveOrder( 1, {{$value.id}})"  style="margin-left:0;">接收</button>
                	    <button type="button"  title="拒绝打单" onclick = "ReceiveOrder( 0, {{$value.id}})" >拒绝</button>
                        <!--button type="button"  title="关闭订单" onclick="Closed({{$value.id}})">关闭</button-->
				</tr>
			{{/each}}
			</tbody>
		</table>
	</div>
</div>
</script>
<!-- 待调度订单 -->
<script id="jplist-template1" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable table">
			<thead>
				<tr class="trtitle">
					<td style="width:40px;"></td>
					<td class="title">单据编号</td>
					<td class="title">合同编号</td>
					<td class="title">承运方名称</td>
					<td class="title">订单数量</td>
					<td class="title">运输模式</td>
					<td class="title" style="text-align:left;">操作</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:40px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
					<td class="title"  fld="Code" title="{{$value.Code}}"><a href="CombinedSend_edit.aspx?id={{$value.id}}" >{{$value.Code}}</a></td>
					<td class="title" title="{{$value.PactCode}}" fld="PactCode">{{$value.PactCode}}</td>
                    <td class="title" title="{{$value.SupplierName}}" fld="SupplierName">{{$value.SupplierName}}</td>
                    <td class="title" title="{{$value.Qty}}" fld="Qty">{{$value.Qty}}</td>
                    <td class="title" title="{{$value.ShipMode}}" fld="ShipMode">
                    	{{if $value.ShipMode == "1" }}
                    		市内
                    	{{else if $value.ShipMode == "2" }}
                    		长途
                    	{{/if}}
                    	</td>
                    <td class="title" style="text-align:left;">
                    	<button class="btn btn-link" title="发送拼车单" onclick="Closed({{$value.id}})" style="margin-left:0;">发送</button>
                    	<button class="btn btn-link" title="编辑拼车单" onclick="javascript:location.href='CombinedSend_edit.aspx?id={{$value.id}}'" style="margin-left:0;">编辑</button>
                        <button class="btn btn-link" title="关闭订单" onclick="Closed({{$value.id}})" style="margin-left:0;">关闭</button>
                    </td>
    			</tr>
			{{/each}}
			</tbody>
		</table>
	</div>
</div>
</script>
<!-- 待签收订单 -->
<script id="jplist-template2" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable  table">
			<thead>
				<tr class="trtitle">
					<td style="width:35px;"></td>
					<td class="title">单据编号</td>
					<td class="title">合同编号</td>
					<td class="title">客户名称</td>
					<td class="title">收货方名称</td>
					<td class="title">发货地址</td>
					<td class="title">收货地址</td>
					<td class="title">订单状态</td>
					<td class="title" style="text-align:left;">操作</td>
			  </tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
					<td class="title" title="{{$value.code}}" fld="code"><a href="OrderSign_edit.aspx?id={{$value.id}}">{{$value.code}}</a></td>
					<td class="title" title="{{$value.pactcode}}" fld="pactcode">{{$value.pactcode}}</td>
					<td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
					<td class="title" title="{{$value.endusername}}" fld="endusername">{{$value.endusername}}</td>
					<td class="title" title="{{$value.from}}" fld="from">{{$value.from}}</td>
					<td class="title" title="{{$value.to}}" fld="to">{{$value.to}}</td>
					<td class="title" title="{{$value.StatusName}}" fld="StatusName">{{$value.StatusName}}</td>
                    <td class="title" style="text-align:left;">
<%--                        <a href="javascript:void(0)" onclick="IsBackOrder({{$value.id}})">打回</a>--%>
                        <a href="Comments.aspx?id={{$value.id}}" style="margin-right:5px;">备注</a>
                        <!--button type="button" title="打回订单" onclick="IsBackOrder({{$value.id}})">打回</button-->
                        <button type="button" title="关闭订单" onclick="Closed({{$value.id}})">关闭</button>
                    </td> 
               </tr>
			{{/each}}
			</tbody>
		</table>
	</div>
</div>
</script>
<!-- 待回单订单 -->
<script id="jplist-template3" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable table">
			<thead>
				<tr class="trtitle">
					<td style="width:35px;"></td>
					<td class="title">单据编号</td>
					<td class="title">合同编号</td>
					<td class="title">客户名称</td>
					<td class="title">收货方名称</td>
					<td class="title">发货地址</td>
					<td class="title">收货地址</td>
					<td class="title">订单状态</td>
					<td class="title" style="text-align:left;">操作</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
					<td class="title" title="{{$value.code}}" fld="code"><a href="OrderReceipt_edit.aspx?id={{$value.id}}">{{$value.code}}</a></td>
					<td class="title" title="{{$value.pactcode}}" fld="pactcode">{{$value.pactcode}}</td>
					<td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
					<td class="title" title="{{$value.endusername}}" fld="endusername">{{$value.endusername}}</td>
					<td class="title" title="{{$value.from}}" fld="from">{{$value.from}}</td>
					<td class="title" title="{{$value.to}}" fld="to">{{$value.to}}</td>
					<td class="title" title="{{$value.StatusName}}" fld="StatusName">{{$value.StatusName}}</td>
                    <td class="title">
<%--                        <a href="javascript:void(0)" onclick="IsBackOrder({{$value.id}})">打回</a>--%>
                        <a href="Comments.aspx?id={{$value.id}}&name=OrderReceipt" style="margin-right:5px;">备注</a>
                        <button class="btn btn-link" title="打回订单" onclick="IsBackOrder({{$value.id}})">打回</button>
                        <button class="btn btn-link" title="关闭订单" onclick="Closed({{$value.id}})">关闭</button>
                    </td> 
    </tr>
			{{/each}}
			</tbody>
		</table>
	</div>
</div>
</script>
<!-- 待审核承运方 -->
<script id="jplist-template4" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable  table">
			<thead>
				<tr class="trtitle">
					<td style=""></td>
					<td class="title">邀请公司名称</td>
					<td class="title">状态</td>
			        <td class="title">操作</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
					<td class="title" title="{{$value.OwnerCompanyName}}" fld="OwnerCompanyName"><a href="BeInvite_edit.aspx?id={{$value.id}}" >{{$value.OwnerCompanyName}}</a></td>
					<td class="title"  fld="Status">
                        {{if $value.Status == "0"}}
                            待处理申请
                        {{else if $value.Status == "1" }}
                            接受申请
                        {{else if$value.Status == "2" }}
                            拒绝
                        {{/if}}
                    </td>
					<td class="title" fld=""><span  title="同意" onclick="SupplierAccept( 1, {{$value.id}})" style="cursor:pointer;color:#06c;">同意</span> &nbsp; <span onclick="SupplierAccept( 2, {{$value.id}})" title="拒绝" style="cursor:pointer; color:#06c;">不同意</span></td>
    				</tr>
			{{/each}}
			</tbody>
		</table>
	</div>
</div>
</script>
<!-- 模板结尾 -->

<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
<div class="mt30" style="padding-left:15px; padding-right:15px;">
    <p class="tips">欢迎您登录物流源平台！</p>
    <div class="navTab clearfix" name="TrackDetail">
        <a href="javascript:void(0)" class="active" role="demo">待接收订单（<span class="orangeO" name="Confirm_Count" view-fld='{fld:"Confirm_Count",method:"show"}'></span>）</a>
        <a href="javascript:void(0)" role="demo1">待调度订单（<span class="orangeO" name="Receipt_Count" view-fld='{fld:"Receipt_Count",method:"show"}'></span>）</a>
        <a href="javascript:void(0)" role="demo2">待签收订单（<span class="orangeO" name="Recv_Count" view-fld='{fld:"Recv_Count",method:"show"}'></span>）</a>
        <a href="javascript:void(0)" role="demo3">待回单订单（<span class="orangeO" name="Schedule_Count" view-fld='{fld:"Schedule_Count",method:"show"}'></span>）</a>
        <a href="javascript:void(0)" role="demo4">待审核承运方（<span class="orangeO" name="Sign_Count" view-fld='{fld:"Sign_Count",method:"show"}'></span>）</a>
    </div>
</div>
<!-- 待接收订单 -->
<div id="demo" class="box jplist demoTab">
		<div class="" style="padding-left:15px; padding-right:15px;">
            <!-- 手机自适应按钮 -->
            <div class="tableDiv clearfix">
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container" style="margin-top:0;">
                <p class="mainHtml_tit">待接收订单</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="StatusTime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
					</ul>
				</div>
			    <div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="opt_status-search-button"></button></div>
				<div class="text-filter-box">
                    <input data-path="endusername" data-button="#name-search-button" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
                    <button type="button" id="name-search-button">
                            <i class="glyphicon glyphicon-search"></i>
                        </button>
				</div>
                <div class="text-filter-box">
                    <input data-path="Code" data-button="#CodeButton" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
                    <button type="button" id="CodeButton">
                            <i class="glyphicon glyphicon-search"></i>
                        </button>
				</div>
				<div class="text-filter-box">
                    <input data-path="CustomerName" data-button="#CustButton" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
                    <button type="button" id="CustButton">
                            <i class="glyphicon glyphicon-search"></i>
                        </button>
				</div>
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">制单时间:</div><![endif]--><input readonly data-path="createtime" onclick="GetDateEvent( this, { format: 'YYYY/MM/DD' } )"   data-button="#name-search-button-starttime" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter"> <button type="button" id="name-search-button-starttime"><i class="glyphicon glyphicon-search"></i></button></div>
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
			<!-- 操作面板 -->
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
        </div>
</div> 
<!-- 待调度订单 -->
<div id="demo1" class="box jplist demoTab hide">
     <div class="" style="padding-left:15px; padding-right:15px;">
			<!-- 手机自适应按钮 -->
            <div class="tableDiv clearfix">
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">待调度订单</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="CreateTime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
					</ul>
				</div>
			<div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="Button6"></button></div>
				<div class="text-filter-box">
                    <input data-path="endusername" data-button="#DdNameButton" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
                    <button type="button" id="DdNameButton">
                         <i class="glyphicon glyphicon-search"></i>
                     </button>
				</div>
                <div class="text-filter-box">
                    <input data-path="Code" data-button="#DdCodeButton" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
                    <button type="button" id="DdCodeButton">
                         <i class="glyphicon glyphicon-search"></i>
                     </button>
				</div>
                <div class="text-filter-box">
                    <input data-path="CustomerName" data-button="#DdCustButton" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
                    <button type="button" id="DdCustButton">
                         <i class="glyphicon glyphicon-search"></i>
                     </button>
				</div>
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">制单时间:</div><![endif]-->
                    <input readonly data-path="createtime" onclick="GetDateEvent(this, { format: 'YYYY/MM/DD' })"   data-button="#DdTimeButton" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter">
                     <button type="button" id="DdTimeButton"><i class="glyphicon glyphicon-search"></i></button>
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
			<!-- 操作面板 -->
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
    </div>
</div>
<!-- 待签收订单 -->
<div id="demo2" class="box jplist hide demoTab">
    <div class="" style="padding-left:15px; padding-right:15px;">
    <!-- 手机自适应按钮 -->
        <div class="tableDiv clearfix" style="padding-left:15px; padding-right:15px;">
        <div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
        <div class="maintitle_container" style="margin-top:0;">
            <p class="mainHtml_tit">待签收订单</p>
        </div>
        <!-- 操作面板 -->
        <div class="jplist-panel box panel-top min_height">
            <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
	        <div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
		        <ul>
			        <li><span data-path="CreateTime" data-order="desc" data-type="date">排序</span></li>
			        <li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
		        </ul>
	        </div>
            <div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="Button1"></button></div>
	        <div class="text-filter-box">
                <input data-path="endusername" data-button="#QsNameButton" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
                <button type="button" id="QsNameButton">
                        <i class="glyphicon glyphicon-search"></i>
                    </button>
	        </div>
            <div class="text-filter-box">
                <input data-path="Code" data-button="#QsCodeButton" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
                <button type="button" id="QsCodeButton">
                        <i class="glyphicon glyphicon-search"></i>
                    </button>
	        </div>
            <div class="text-filter-box">
                <input data-path="CustomerName" data-button="#QsCustButton" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
                <button type="button" id="QsCustButton">
                        <i class="glyphicon glyphicon-search"></i>
                    </button>
	        </div>
	        <div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">制单时间:</div><![endif]-->
                <input readonly data-path="createtime" onclick="GetDateEvent( this, { format: 'YYYY/MM/DD' } )"   data-button="#QsTimeButton" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter"> 
                <button type="button" id="QsTimeButton"><i class="glyphicon glyphicon-search"></i></button>
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
        <!-- 操作面板 -->
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
   </div>
</div>
<!-- 待回单订单 -->
<div id="demo3" class="box jplist demoTab hide">
    <div class="" style="padding-left:15px; padding-right:15px;">
			<!-- 手机自适应按钮 -->
            <div class="tableDiv clearfix">
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">待回单订单</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="CreateTime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
					</ul>
				</div>
			<div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="Button11"></button></div>
				<div class="text-filter-box">
                    <input data-path="endusername" data-button="#HdNameButton" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
                    <button type="button" id="HdNameButton">
                         <i class="glyphicon glyphicon-search"></i>
                     </button>
				</div>
                <div class="text-filter-box">
                    <input data-path="Code" data-button="#HdCodeButton" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
                    <button type="button" id="HdCodeButton">
                         <i class="glyphicon glyphicon-search"></i>
                     </button>
				</div>
                <div class="text-filter-box">
                    <input data-path="CustomerName" data-button="#HdCustButton" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
                    <button type="button" id="HdCustButton">
                         <i class="glyphicon glyphicon-search"></i>
                     </button>
				</div>
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">制单时间:</div><![endif]-->
                    <input readonly data-path="createtime" onclick="GetDateEvent(this, { format: 'YYYY/MM/DD' })"   data-button="#HdTimeButton" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter"> 
                    <button type="button" id="HdTimeButton"><i class="glyphicon glyphicon-search"></i></button>
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
			<!-- 操作面板 -->
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
    </div>
</div>
<!-- 待审核承运方 -->
<div id="demo4" class="box jplist demoTab hide">
    <div class="" style="padding-left:15px; padding-right:15px;">
			<!-- 手机自适应按钮 -->
            <div class="tableDiv clearfix">
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">待审核承运方</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<%--<div class="jplist-drop-down" data-control-type="items-per-page-drop-down" data-control-name="paging" data-control-action="paging">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>--%>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="id" data-order="asc" data-type="number">排序</span></li>
						<li><span data-path="OwnerCompanyName" data-order="asc" data-type="text">邀请公司名称</span></li>
					</ul>
				</div>
			<div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#Sh-opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="Sh-opt_status-search-button"></button></div>
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">姓名:</div><![endif]--><input data-path="OwnerCompanyName" data-button="#name-search-button" type="text" value="" placeholder="邀请公司名称" data-control-type="textbox" data-control-name="OwnerCompanyName" data-control-action="filter"> <button type="button" id="Button17"><i class="glyphicon glyphicon-search"></i></button></div>
				<%--<!-- 分页结果 -->
				<div class="jplist-label" data-type="第 {current} 页，共 {pages} 页" data-control-type="pagination-info" data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging" data-control-action="paging"></div>
				<!-- 加载数据时显示 -->--%>
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
            <!-- 操作面板 -->
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
    </div>
</div>
<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				
<!--通用页尾开始-->
<!--#include file="/Controls/TMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/
        InitList( $( "#demo" ), $( "#demo .list" ), $( "#jplist-template" ).html(), "OrderAccept", "/Widget.aspx?param=jplist&vid=grid_jplist_0078" );
        $( 'div[name="TrackDetail"]' ).attr( 'view-id', '{ id:"stat_0001",cross:"false", paras:[]}' );
        var _myEvents = new NSF.System.Data.Grid();        
        _myEvents.Initialize( "/", "TrackDetail", $( "div[name='TrackDetail']" ).attr( "view-id" ), $( "div[name='TrackDetail']" ) );
        $( '.navTab a' ).click( function ()
        {
            var role = $( this ).attr( 'role' );
            $( '.navTab a' ).removeClass( 'active' );
            $( this ).addClass( 'active' );
            $( '.jplist' ).addClass( 'hide' );
            $( '#' + role ).removeClass( 'hide' );
            //待接收
            if ( role == 'demo' )
            {
                InitList( $( "#demo" ), $( "#demo .list" ), $( "#jplist-template" ).html(), "OrderAccept", "/Widget.aspx?param=jplist&vid=grid_jplist_0078" );
            }
            //待调度
            else if ( role == 'demo1' )
            {
                InitList( $( "#demo1" ), $( "#demo1 .list" ), $( "#jplist-template1" ).html(), "demo1", "/Widget.aspx?param=jplist&vid=grid_jplist_0079" );
            }
            //待签收
            else if ( role == 'demo2' )
            {
                InitList( $( "#demo2" ), $( "#demo2 .list" ), $( "#jplist-template2" ).html(), "demo2", "/Widget.aspx?param=jplist&vid=grid_jplist_0080" );
            }
            //待回单
            else if ( role == 'demo3' )
            {
                InitList( $( "#demo3" ), $( "#demo3 .list" ), $( "#jplist-template3" ).html(), "demo3", "/Widget.aspx?param=jplist&vid=grid_jplist_0081" );
            }
            //待审核承运方
            else if ( role == 'demo4' )
            {
                InitList( $( "#demo4" ), $( "#demo4 .list" ), $( "#jplist-template4" ).html(), "demo4", "/Widget.aspx?param=jplist&vid=grid_jplist_0027" );
            }
        } );
    };
    var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
<style type="text/css">
    .active .orangeO{color:white}
    .navTab a{width:auto;}
    .tableDiv p{border-left:0px;}
    .demoTab .jptable tr td button {margin:-3px 5px 0; padding:0;}
    .demoTab .panel-top {border-top:1px solid #ddd; padding-top:15px; padding-bottom:0;}
    .demoTab .maintitle_container {margin-top:0;}
</style>
</body>
</html>
