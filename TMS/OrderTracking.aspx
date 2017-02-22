<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>订单查询-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="OrderTracking">

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

<!--打印选择日期开始-->
<div class="modal fade" id="printTBModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog" style="height:170px">
          <div class="modal-content" style="height:100%;width:64%">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
	                <h4 class="modal-title text-left" id="myModalLabel">
	                    <div style="padding-left: 3px; background-color: #f27302;">
	                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">打印报表</p>
	                    </div>
	                </h4>
                </div>
                <div class="modal-body">
                	<div class="form-group">
                		<div class="col-md-3" style="padding-top:7px">发货日期</div>
                		<div class="col-md-9">
            				<input type="text"  onclick="GetDateEvent(this, { format: 'YYYY-MM-DD'})" class="form-control report-date" placeholder="发货日期">
                		</div>
                	</div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="skiptoprint($(this).closest('#printTBModal'), 1)" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!--打印选择日期结尾-->
			
<!--获取时间段开始-->
<div class="modal fade" id="rangeModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog" style="height:200px">
          <div class="modal-content" style="height:100%">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
	                <h4 class="modal-title text-left" id="myModalLabel">
	                    <div style="padding-left: 3px; background-color: #f27302;">
	                        <p class="time_ment zhidan" style="">时间段</p>
	                    </div>
	                </h4>
                </div>
                <div class="modal-body">
                	<div class="form-group">
                		<div class="col-md-5">
            				<input type="text"  onclick="GetDateEvent(this, { format: 'YYYY-MM-DD'})" class="form-control min" placeholder="起始时间">
                		</div>
                		<div class="col-md-1">-</div>
                		<div class="col-md-5">
            				<input type="text"  onclick="GetDateEvent(this, { format: 'YYYY-MM-DD'})" class="form-control max" placeholder="结束时间">
                		</div>
                	</div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="rangeOk( $(this).closest('div#rangeModal') )" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!--发货时间段开始-->
<div class="modal fade" id="rangeFromModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog" style="height:200px">
          <div class="modal-content" style="height:100%">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
	                <h4 class="modal-title text-left" id="myModalLabel">
	                    <div style="padding-left: 3px; background-color: #f27302;">
	                        <p class="time_ment fahuo" style="">时间段</p>
	                    </div>
	                </h4>
                </div>
                <div class="modal-body">
                	<div class="form-group">
                		<div class="col-md-5">
            				<input type="text"  onclick="GetDateEvent(this, { format: 'YYYY-MM-DD'})" class="form-control min" placeholder="起始时间">
                		</div>
                		<div class="col-md-1">-</div>
                		<div class="col-md-5">
            				<input type="text"  onclick="GetDateEvent(this, { format: 'YYYY-MM-DD'})" class="form-control max" placeholder="结束时间">
                		</div>
                	</div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="rangeOk( $(this).closest('div#rangeFromModal') )" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!--通用头部文件开始-->
<!--#include file="/Controls/TMS/header.aspx"-->
<!--通用头部文件结尾-->

<!-- 模板开始-->
<script id="jplist-template" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable  table" id="demoList">
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
					<td class="title">拼车单编号</td>
					<td class="title">操作</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
					<td class="title" title="{{$value.code}}" fld="code"><a target="_blank" href="OrderTracking_edit.aspx?id={{$value.id}}&code=orderIndex">{{$value.code}}</a></td>
					<td class="title" title="{{$value.pactcode}}" fld="pactcode">{{$value.pactcode}}</td>
					<td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
					<td class="title" title="{{$value.endusername}}" fld="endusername">{{$value.endusername}}</td>
					<td class="title" title="{{$value.from}}" fld="from">{{$value.from}}</td>
					<td class="title" title="{{$value.to}}" fld="to">{{$value.to}}</td>
					<!--<td class="title" title="{{$value.StatusName}}" fld="StatusName">{{$value.StatusName}}</td>-->
					<td class="title" title="{{$value.StatusName}}" fld="StatusName">
						{{if $value.Supplier != "0" && $value.status == "1"}}
							<span style="color:#f03800;">{{$value.StatusName}}</span>
                        {{else if $value.status == "0"}}
                            <span style="color:#ff6100;">{{$value.StatusName}}</span>
                        {{else if $value.status == "1" }}
                            <span style="color:#00a0da;">{{$value.StatusName}}</span>
                        {{else if $value.status == "2" }}
                            <span style="color:#b56ad8;">{{$value.StatusName}}</span>
                        {{else if $value.status == "4" }}
                            <span style="color:#669966;">{{$value.StatusName}}</span
                        {{else if $value.status == "8" }}
                            <span style="color:#51d2b7;">{{$value.StatusName}}</span>
                        {{else if $value.status == "16" }}
                            <span style="color:#666;">{{$value.StatusName}}</span>
                        {{/if}}
                    </td>						
					<td class="title"  fld="ContainsOrderCode" title="{{$value.ContainsOrderCode}}" >
                        <a target="_blank" href="OrderAcceptedCar_edit.aspx?id={{$value.OwnerOrderID}}">{{$value.ContainsOrderCode}}</a>                
                    </td>
					<td class="title" fld="DeviceCode">
						{{if $value.DeviceCode != ''}}
							<a target="_blank" href="http://106.14.17.157/gps/map/marker.action?devCode={{$value.DeviceCode}}" style="margin-right:5px;" title="定位">定位</a>
							<a target="_blank" href="http://106.14.17.157/gps/map/history.action?devCode={{$value.DeviceCode}}&start={{$value.LFromTime}}&end={{$value.ToTime}}" style="margin-right:5px;" title="轨迹">轨迹</a>
						{{else}}
							<a style="margin-right:5px; color:#ccc !important;" title="定位">定位</a>
							<a style="margin-right:5px; color:#ccc !important;" title="轨迹">轨迹</a>				
						{{/if}}
					</td>
				</tr>
			{{/each}}
			</tbody>
		</tabl
	</div>
</div>
</script>
<!-- 模板结尾 -->

<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
		<div id="demo" class="box jplist">
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">订单查询</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="ContainsOrderCode" data-order="desc" data-type="text">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
						<li><span data-path="PactCode" data-order="desc" data-type="text">合同编号</span></li>
						<li><span data-path="FromTime" data-order="desc" data-type="date">发货时间</span></li>
					</ul>
				</div>
                <div class="jplist-drop-down"  data-control-type="filter-drop-down" data-control-name="status" data-control-action="filter">
					<ul class="listsearch" name="Status">
						<li><span data-path="">订单状态</span></li>
						<li><span data-path="1">待调度</span></li>
						<li><span data-path="2">待签收</span></li>
						<li><span data-path="4">待回单</span></li>
						<li><span data-path="8">已回单</span></li>
					</ul>
				</div>
				<div class="jplist-drop-down" data-control-type="filter-drop-down" data-control-name="ShipMode" data-control-action="filter"><div class="jplist-dd-panel">订单类型</div>
                    <ul class="listsearch" name="Shipmode">
                        <li class=""><span data-path="">订单类型</span></li>
                        <li><span data-path="1">市内</span></li>
                        <li><span data-path="2">长途</span></li>
                    </ul>
                </div>
                <div class="jplist-drop-down" data-control-type="filter-drop-down" data-control-name="Combined" data-control-action="filter"><div class="jplist-dd-panel">拼车状态</div>
                    <ul class="listsearch" name="Combined">
                        <li class=""><span data-path="">拼车状态</span></li>
                        <li><span data-path="1">拼车单</span></li>
                        <li><span data-path="0">非拼车单</span></li>
                    </ul>
               </div>
			    <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-search-button"></button>
				</div>
                <div class="text-filter-box">
                    <input data-path="CustomerName" class="data" name="CustomerName" data-button="#opt_status-search-button" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
			    </div>
				
				<div class="text-filter-box">
                    <input data-path="rangefilter_fromtime" class="rangeFromModal time" name="FromTime"  data-button="#search-button"  type="text" value="" placeholder="发货时段" data-control-type="textbox" data-control-name="rangefilter_fromtime" data-control-action="filter">
                    <button type="button" id="search-button">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>

				
                 <a class="" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" onclick="collapseStat(this)" style="display:inline-block;line-height:30px;margin-top:10px;">
					<span rol="img" class="glyphicon glyphicon-menu-down" style="top:2px;margin-right:2px;color:#f27302;"></span><span rol="text" style="color:#666;font-weight:normal;">更多</span>
				</a>
					
					<button class="btn btn-default navbar-left footKeepBtn" data-toggle="modal" onclick="OrderTrackingToXml(1)" title="导出">导出</button>
					
					<button class="btn btn-default navbar-left footKeepBtn" data-toggle="modal" data-target="#printTBModal" title="打印">打印</button>
					
				<div class="collapse clearfix" id="collapseExample" style="margin-left:238px;">
                    <div class="text-filter-box">
                        <input data-path="endusername" class="data" name="EndUserName" data-button="#opt_status-search-button" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
				    </div>
                    <div class="text-filter-box">
                        <input data-path="Code" class="data" name="Code" data-button="#opt_status-search-button" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
				    </div>
                    <div class="text-filter-box">
                        <input data-path="PactCode" name="Pactcode" class="data" data-button="#opt_status-search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="PactCode" data-control-action="filter" />
				    </div>
				    <div class="text-filter-box">
                        <input data-path="ContainsOrderCode" name="ContainsCode" class="data" data-button="#opt_status-search-button" type="text" value="" placeholder="拼车单编号" data-control-type="textbox" data-control-name="ContainsOrderCode" data-control-action="filter" />
				    </div>
				    <div class="text-filter-box">
	                    <input data-path="rangefilter_createtime" class="rangeModal time" name="CreateTime" data-button="#search-button"  type="text" value="" placeholder="制单时段" data-control-type="textbox" data-control-name="rangefilter_createtime" data-control-action="filter">
					</div>
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
				<!--<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>-->
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
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "OrderTracking", "/Widget.aspx?param=jplist&vid=grid_jplist_0013");

        resizeCols = setInterval('resizeTable()', 200);
        $('input.rangeModal').on( "click", function(){
        	$("div#rangeModal").modal( "show" );
           	$('.zhidan').text('制单时段');               	
        } );

        $('input.rangeFromModal').on( "click", function(){
        	$("div#rangeFromModal").modal( "show" );
           	$('.fahuo').text('发货时段');             	
        } );
    };
    var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/plugins/jquery/colResizable-1.5.min.js"></script>
<script src="/assets/request_minify.js"></script>
<style>
.jptable tr td:nth-child(2),.jptable tr td:nth-child(3) {
    width: 20%;
    text-align: left;
    padding: 12px 5px !important;
    /*word-break: break-all;
	white-space: inherit !important;*/
}
</style>
</body>
</html>
