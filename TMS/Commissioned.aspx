<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>已委托订单-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="Commissioned">

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

<!----关闭订单开始--------->
<div class="modal fade" id="ClosedModal" tabindex="-1" role="dialog"
    aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                <%--<button type="button" class="close"
                    data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>--%>

                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px; margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">关闭订单</p>
                    </div>
                </h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <label class="col-md-2 control-Label" style="color:#333;font-size:12px;">关闭原因</label>
                    <div class="col-md-10">
                        <textarea name="CDescription" class="form-control" rows="3" cols="70"></textarea>
                        <input type="hidden" name="COrderID" />
                    </div>
                </div>
            </div>
            <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
				<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="ClosedOrder()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
<!----关闭订单结尾--------->

<!----撤回委托订单开始--------->
<div class="modal fade" id="UnscheduleModal" tabindex="-1" role="dialog"
    aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                <%--<button type="button" class="close"
                    data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>--%>

                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px; margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">撤回委托订单</p>
                    </div>
                </h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <label class="col-md-2 control-Label" style="color:#333;font-size:12px;">撤回原因</label>
                    <div class="col-md-10">
                        <textarea name="CDescription" class="form-control" rows="3" cols="70"></textarea>
                        <input type="hidden" name="COrderID" />
                    </div>
                </div>
            </div>
            <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
				<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="UnscheduleSupplierOrder( $(this).closest('#UnscheduleModal'))" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
<!--<div class="modal fade" id="UnscheduleModal" tabindex="-1" role="dialog"
    aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                    data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>

                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #0099CC;">
                        <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">撤回委托订单</p>
                    </div>
                </h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <label class="col-md-2 control-Label">撤回原因</label>
                    <div class="col-md-10">
                        <textarea name="CDescription" class="form-control" rows="3" cols="70"></textarea>
                        <input type="hidden" name="COrderID" />
                    </div>
                </div>
            </div>
            <div class="modal-footer">
				<button type="button" class="btn btn-default  okButton" style="margin-right:10px;border-radius:3px" aria-label="OK" title="确定" onclick="UnscheduleSupplierOrder( $(this).closest('#UnscheduleModal'))" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok-sign" style="margin-left:2px;color:#888;"></span></button>
				<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="border-radius:3px;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove-sign" style="margin-left:2px;color:#888;"></span></button>
            </div>
        </div>
    </div>
</div>-->
<!----撤回委托订单结尾--------->

<!--获取时间段开始-->
<div class="modal fade" id="rangeModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog">
          <div class="modal-content" style="height:170px">
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
<!--获取时间段结束-->

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
		<table class="jptable table" id="demoList">
			<thead>
				<tr class="trtitle">
					<td style="width:35px;"></td>
					<td class="title">单据编号</td>
					<td class="title">合同编号</td>
					<td class="title">客户名称</td>
                    <td class="title">收货方名称</td>
					<td class="title">发货地址</td>
                    <td class="title">收货地址</td>
					<td class="title">数量</td>
					<td class="title">承运方</td>
					<td class="title">重量(公斤)</td>
					<td class="title">体积(立方米)</td>
					<td class="title">状态</td>
					<td class="title">操作</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
					<td class="title"  fld="Code" title="{{$value.Code}}">
                        {{if $value.Status > '2'}}
                             <a target="_blank" href="Commissioned_edit.aspx?id={{$value.id}}&SupplierSymbolID={{$value.SupplierSymbolID}}" >{{$value.Code}}</a>
                        {{else}}
                            <a target="_blank" href="Indextrans_edit.aspx?id={{$value.id}}&code=Commissioned">{{$value.Code}}</a>
                        {{/if}}
                    </td>
					<td class="title" title="{{$value.PactCode}}" fld="PactCode">{{$value.PactCode}}</td>
                    <td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
					<td class="title" title="{{$value.EndUserName}}" fld="EndUserName">{{$value.EndUserName}}</td>
					<td class="title" title="{{$value.From}}" fld="From">{{$value.From}}</td>
					<td class="title" title="{{$value.To}}" fld="To">{{$value.To}}</td>
                    <td class="title" title="{{$value.Qty}}" fld="Qty">{{$value.Qty}}</td>
                    <td class="title" title="{{$value.SupplierCompanyName}}" fld="Weight">{{$value.SupplierCompanyName}}</td>
                    <td class="title" title="{{$value.Weight}}" fld="Weight">{{$value.Weight}}</td>
                    <td class="title" title="{{$value.Volume}}" fld="Volume">{{$value.Volume}}</td>
                    <td class="title" title="{{$value.StatusName}}" fld="StatusName">{{$value.StatusName}}</td>
                    <td class="title">
                    	{{ if $value.Status != "32" }}
                        	<button class="btn btn-link" title="关闭订单" onclick="Closed({{$value.id}})" style="margin-left:0;">关闭</button>
                        {{/if}}
                        {{ if $value.Status == "1" }}
                        	<button class="btn btn-link" title="撤回委托订单" onclick="Unschedule({{$value.id}})" style="margin-left:0;">撤回</button>
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
               <p class="mainHtml_tit">已委托订单</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="statustime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
						<li><span data-path="PactCode" data-order="desc" data-type="text">合同编号</span></li>
					</ul>
				</div>
			    <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-search-button"></button>
				</div>
				<div class="text-filter-box">
                        <input data-path="endusername" data-button="#opt_status-search-button" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
				    </div>
				<div class="text-filter-box">
                    <input data-path="CustomerName" data-button="#opt_status-search-button" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
                     
				</div>
				<div class="text-filter-box">
                    <input data-path="rangefilter_fromtime" class="rangeFromModal time" name="FromTime" data-button="#search-button"  type="text" value="" placeholder="发货时段" data-control-type="textbox" data-control-name="rangefilter_fromtime" data-control-action="filter">
				</div>	
				<div class="text-filter-box">
					
					<!--[if lt IE 10]><div class="jplist-label">制单时间:</div><![endif]-->
					<!--<input readonly data-path="createtime" onclick="GetDateEvent(this, { format: 'YYYY-MM-DD' })"   data-button="#search-button" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter">--> 
					<input data-path="rangefilter_createtime" class="rangeModal time" name="CreateTime" data-button="#search-button"  type="text" value="" placeholder="制单时段" data-control-type="textbox" data-control-name="rangefilter_createtime" data-control-action="filter">
					<button type="button" id="search-button">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>

                <div class="jplist-drop-down" data-control-type="filter-drop-down" data-control-name="ShipMode" data-control-action="filter"><div class="jplist-dd-panel">订单类型</div>
                    <ul>
                        <li class=""><span data-path="">订单类型</span></li>
                        <li><span data-path="1">市内</span></li>
                        <li><span data-path="2">长途</span></li>
                    </ul>
                </div>

                 <a class="" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" onclick="collapseStat(this)" style="display:inline-block;line-height:30px;margin-top:10px;">
					<span rol="img" class="glyphicon glyphicon-menu-down" style="top:2px;margin-right:2px;color:#f27302;"></span><span rol="text" style="color:#666;font-weight:normal;">更多</span>
				</a>
				<div class="collapse clearfix" id="collapseExample" style="margin-left:238px;">
                    <div class="text-filter-box">
                        <input data-path="Code" data-button="#opt_status-search-button" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
				    </div>
                    <div class="text-filter-box">
                        <input data-path="PactCode" data-button="#opt_status-search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="PactCode" data-control-action="filter" />
				    </div>
                    <div class="text-filter-box">
                        <input data-path="SupplierCompanyName" data-button="#opt_status-search-button" type="text" value="" placeholder="承运方" data-control-type="textbox" data-control-name="SupplierCompanyName" data-control-action="filter" />
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
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "Commissioned", "/Widget.aspx?param=jplist&vid=grid_jplist_0037");

        resizeCols = setInterval('resizeTable()', 200);
        
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
<script src="/assets/plugins/jquery/colResizable-1.5.min.js"></script>
<!--#include file="/Controls/TMS/JS.aspx"-->
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
