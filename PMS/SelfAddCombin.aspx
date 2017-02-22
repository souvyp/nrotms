<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>合单补充报价-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="SelfAddCombin">
<style type="text/css">
#demo .jptable tr td button
{
margin:0px 2px;
padding:0;
}
    .jptable tr td:first-child {
        width:3%;
    }
#demoList tr td:nth-child(2){width: 150px;}
#demoList tr td:nth-child(3){width: 130px;}
#demoList tr td:nth-child(4){width: 150px;}    
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

<!--获取时间段开始-->
<div class="modal fade" id="rangeModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog" style="height:200px">
          <div class="modal-content" style="height:100%">
                <div class="modal-header" style=" padding-bottom:0;padding-top:30px;">
	                <h4 class="modal-title text-left" id="myModalLabel">
	                    <div style="padding-left: 3px; background-color: #f27302;">
	                        <p class="time_ment zhidan" style="background-color: #fff;padding-left: 5px;">时间段</p>
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
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
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
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">接收订单</p>
                    </div>
                </h4>
                </div>
                <div class="modal-body tab_jsjj">
                    <span name="content">是否确定接收订单</span>
                    <input type="hidden" name="Accept" />
                    <input type="hidden" name="OrderID" />
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="OrderAccept()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
    </div>
    <div class="modal fade" id="ClosedModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    <%--<button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>--%>

                    <h4 class="modal-title text-left" id="H1">
                        <div style="padding-left: 3px; background-color: #f27302;">
                           <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">关闭订单</p>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <label class="col-md-2 control-Label">关闭原因</label>
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
<!--通用头部文件开始-->
<!--#include file="/Controls/PMS/header.aspx"-->
<!--通用头部文件结尾-->

<!-- 模板开始-->
<script id="jplist-template" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable table">
			<thead>
				<tr class="trtitle">
					<td style=""></td>
					<td class="title">单据编号</td>
			        <td class="title">合同编号</td>
			        <td class="title">客户名称</td>
			        <td class="title">订单数量</td>
			        <td class="title">金额(元)</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style=""><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
					<td class="title" fld="Code" title="{{$value.Code}}"><a href="SelfAddCombin_edit.aspx?id={{$value.id}}" >{{$value.Code}}</a></td>
			        <td class="title" title="{{$value.PactCode}}" fld="PactCode">{{$value.PactCode}}</td>
			        <td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
			        <td class="title" title="{{$value.Qty}}" fld="Qty">{{$value.Qty}}</td>
			        <td class="title" title="{{$value.TotalCost}}" fld="TotalCost">{{$value.TotalCost}}</td>
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
               <p class="mainHtml_tit">合单补充报价</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="StatusTime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="CustomerName" data-order="asc" data-type="text">客户名称</span></li>
						<li><span data-path="PactCode" data-order="asc" data-type="text">合同编号</span></li>
						<li><span data-path="Code" data-order="asc" data-type="text">单据编号</span></li>
					</ul>
				</div>
			    <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-search-button"></button>
				</div>
				<div class="text-filter-box">
                    <input data-path="CustomerName" data-button="#opt_status-search-button" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
				</div>

				<div class="text-filter-box">
                    <input data-path="PactCode" data-button="#opt_status-search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="PactCode" data-control-action="filter">
				</div>

				

				<div class="text-filter-box">
                    <input data-path="rangefilter_createtime" class="rangeModal time" name="CreateTime" data-button="#search-button"  type="text" value="" placeholder="制单时段" data-control-type="textbox" data-control-name="rangefilter_createtime" data-control-action="filter">
                    <button type="button" id="search-button">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>	
                 <a class="" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" onclick="collapseStat(this)" style="display:inline-block;line-height:30px;margin-top:10px;">
					<span rol="img" class="glyphicon glyphicon-menu-down" style="top:2px;margin-right:2px;color:#f27302;"></span><span rol="text" style="color:#666;font-weight:normal;">更多</span>
				</a>
				<div class="collapse clearfix" id="collapseExample" style="margin-left:238px;">
				     <div class="text-filter-box">
                        <input data-path="Code" data-button="#opt_status-search-button" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
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
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "SelfAddCombin", "/Widget.aspx?param=jplist&vid=grid_jplist_0112");
    };
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
