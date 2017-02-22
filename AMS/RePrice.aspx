<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>订单价格重算-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/AMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<style>
    /*.jptable tr td:first-child {
        width:60px !important;
    }*/
    .jptable tr td:nth-child(2) {
        /*width:180px !important;*/
    }
    input[type="checkbox"]{display:inline-block !important;}
</style>
<script src="/assets/js/csdu.queue.js"></script>
</head>
<body code="RePrice">

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
<div class="modal fade" id="format-Modal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" style="width:90%;" >
        <div class="modal-content" style="width:100%;padding:20px 20px 50px;" >
            <%--<div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">重新计算任务失败提醒</p>
                        <div style="position:absolute;top:-6px; right:0;">
					        <!--<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="SendBackOrder()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>-->
				<button type="button" class="btn btn-default cancer " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;"></span></button>
                       </div>
                    </div>
                </h4>
            </div>--%>

            <div class="dialogue-header" style="background-color:#f27302;position:relative;margin-left:10px;margin-right:10px;margin-top:20px; margin-bottom:20px;">
                <p style="text-align:left;background-color:white;margin-left:3px;padding-left:10px; color:#666; font-size:14px;">价格重算结果</p>
                <div style="position:absolute;top:-6px; right:0;">
					<!--<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="SendBackOrder()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>-->
				<button type="button" class="btn btn-default cancer " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;"></span></button>
                </div>
			</div>
              
            <div class="modal-body" style="padding:0 25px;">
	            <div class="row" style="border-top:1px solid #e1e6eb;">
	                <div class="list-item box jplist-panel tabbtn" >
						<div class="" style="height:203px;"><!-- block right -->
							<table class="jptable  table FailureTable ">
								<thead>
									<tr class="trtitle">
										<td class="title">单据编号</td>
										<td class="title">合同编号</td>
					                    <td class="title">客户名称</td>
										<td class="title">收货人名称</td>
										<td class="title" colspan="3" style="width:400px">错误代码</td>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
                            <p class="SuccessTips text-center hide" style="font-size:14px;color:#f27302;margin-top:80px;">恭喜您，价格重算全部成功，没有错误数据提醒</p>
                            <div class="text-center">
					            <div class="num" id="num"></div>
					        </div>
						</div>
					</div>
	            </div>
	            
            </div>
            <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;" >
				<!--<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="SendBackOrder()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>-->
				<%--<button type="button" class="btn btn-default cancer " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;"></span></button>--%>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
<!--通用头部文件开始-->
<!--#include file="/Controls/AMS/header.aspx"-->
<!--通用头部文件结尾-->

<!-- 模板开始-->
<script id="jplist-template" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable  table SrcTable" id="demoList">
			<thead>
				<tr class="trtitle">
					<td style="width:60px;"><input type="checkbox" onclick="checkDataAll(this)" class="checkbox-all" style="margin-left:19px;margin-top:0;position:relative;top:2px;"></td>
					<td class="title" style="line-height:23px;">单据编号</td>
					<td class="title" style="line-height:23px;">合同编号</td>
                    <td class="title" style="line-height:23px;">客户名称</td>
					<td class="title" style="line-height:23px;">收货人名称</td>
					<td class="title" style="line-height:23px;">发货地址</td>
					<td class="title" style="line-height:23px;">收货地址</td>
					<td class="title" style="line-height:23px;">订单状态</td>
					<td class="title" style="line-height:23px;">费用合计</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/><span style="position:relative; top:-6px;display:inline-block;width:16px;">{{$index+1}}</span>
					<input type="checkbox" name="content" fld="" value="{{$value.id}}"  /></td>
					<td class="title" title="{{$value.code}}" fld="code"><a target="_blank" href="RePrice_edit.aspx?id={{$value.id}}" >{{$value.code}}</a></td>
					<td class="title" title="{{$value.pactcode}}" fld="pactcode">{{$value.pactcode}}</td>
					<td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
					<td class="title" title="{{$value.endusername}}" fld="endusername">{{$value.endusername}}</td>
					<td class="title" title="{{$value.from}}" fld="from">{{$value.from}}</td>
					<td class="title" title="{{$value.to}}" fld="to">{{$value.to}}</td>
					<td class="title" title="{{$value.StatusName}}" fld="StatusName">{{$value.StatusName}}</td>
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
               <p class="mainHtml_tit">订单价格重算</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
				<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="CreateTime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货人名称</span></li>
					</ul>
				</div>
                <div class="text-filter-box">
                    <input data-path="pactcode" data-button="#opt_status-search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="pactcode" data-control-action="filter" />
				</div>
				<div class="text-filter-box">
                    <input data-path="endusername" data-button="#opt_status-search-button" type="text" value="" placeholder="收货人名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
				</div>
                <div class="text-filter-box">
                    <input data-path="CustomerName" data-button="#opt_status-search-button" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
				</div>
				<div class="text-filter-box">
					
					<!--[if lt IE 10]><div class="jplist-label">制单时间:</div><![endif]-->
					<input readonly data-path="createtime" onclick="GetDateEvent(this, { format: 'YYYY/MM/DD' })"   data-button="#search-button" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter"> 
					<button type="button" id="search-button">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>		
                 <a class="" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" onclick="collapseStat(this)" style="display:inline-block;line-height:30px;margin-top:10px;">
					<span rol="img" class="glyphicon glyphicon-menu-down" style="top:2px;margin-right:2px;color:#f27302;"></span><span rol="text" style="color:#666;font-weight:normal;">更多</span>
				</a>
                <div>
                    <button  title="重新计算" class="edit btn footKeepBtn" style="text-shadow:none;" onclick="ReCal()">重新计算</button>
                </div>
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
<!--#include file="/Controls/AMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">

    var resizeCols = null;
    var reqeustDone = function ()
    {		/*所有JS加载完成以后执行*/
        if ( typeof ( initHeader ) != "undefined" ) initHeader();					/*初始化页面通用头部*/
        if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "RePrice", "/Widget.aspx?param=jplist&vid=grid_jplist_0063");

        resizeCols = setTimeout('resizeTable()', 200);
    }
    var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="js/index.js"></script>
<script src="/assets/plugins/jquery/colResizable-1.5.min.js"></script>
<script src="/assets/request_minify.js"></script>
</html>
