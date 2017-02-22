<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>订单选择</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("SelectorCss")%>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/hu_s.css" />
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
	.modal-backdrop.in {
	    filter: alpha(opacity=00) !important;
	    opacity: .0 !important;
	}
</style>
</head>
<body code="AccountPayOrderSelect" style="width:1200px; overflow-x: hidden;">
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


<!-- 模板开始-->
<script id="jplist-template" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable table" id="demoList">
			<thead>
				<tr class="trtitle">
					<td class="td_name" style="width:35px;">
						<input type="checkbox" id="checkbox-0" style="display:none" onclick="checkboxAll(this)" />
						<label for="checkbox-0"></label>						
					</td>
					<td class="td_name" >订单编号</td>
					<td class="td_name" >合同编号</td>
					<td class="td_name" >发货日期</td>							
					<td class="td_name">发站省</td>
					<td class="td_name">发站市</td>
					<td class="td_name">到站省</td>
					<td class="td_name">到站市</td>
					<td class="td_name">总体积</td>
					<td class="td_name">总重量</td>
					<td class="td_name">总数量</td>
					<td class="td_name">实签数量</td>
					<td class="td_name">总金额</td>
					<td class="td_name">货到付款</td>
					<td class="td_name">预付款</td>							
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr onDblClick="dblEvents()">
					<td style="width:35px">
						<input type="checkbox" id="checkbox-{{$index+1}}" style="display:none"  name="id" fld="id" value="{{$value.id}}"/>
						<label for="checkbox-{{$index+1}}"></label>
						{{$index+1}}
					</td>
					<td class="title" fld="code">{{$value.code}}</td>
					<td class="title" fld="pactcode">{{$value.pactcode}}</td>
					<td class="title" fld="fromtime" title="{{$value.fromtime}}">{{$value.fromtime}}</td>							
					<td class="title" fld="fromprovincename">{{$value.fromprovincename}}</td>
					<td class="title" fld="fromcityname">{{$value.fromcityname}}</td>
					<td class="title" fld="toprovincename">{{$value.toprovincename}}</td>
					<td class="title" fld="tocityname">{{$value.tocityname}}</td>
					<td class="title" fld="Volume">{{$value.Volume}}</td>
					<td class="title" fld="Weight">{{$value.Weight}}</td>
					<td class="title" fld="Amount">{{$value.Amount}}</td>
					<td class="title" fld="ReceiptQty">{{$value.ReceiptQty}}</td>
					<td class="title" fld="Total">{{if $value.Total == '0.00'}}<span style="color:red">0.00</span>{{else}}<span >{{ {m:$value.Min,t:$value.Total} | Total}}</span>{{/if}}
					</td>
					<td class="title" fld="payable">{{$value.payable}}</td>
					<td class="title" fld="payment">{{$value.payment}}</td>					
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
 
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="id" data-order="asc" data-type="number">排序</span></li>
					</ul>
				</div>
			<div class="text-filter-box" style="display:none;">
					<select data-control-type="filter-select" data-control-name="Supplierid" data-control-action="filter">
						<option data-path="<%=Request.QueryString["value"]%>" selected>承运商编号</option>
					</select>
			</div>
				<div class="text-filter-box">
                    <input data-path="rangefilter_fromtime" class="rangeFromModal time" name="FromTime" data-button="#search-button"  type="text" value="" placeholder="发货时段" data-control-type="textbox" data-control-name="rangefilter_fromtime" data-control-action="filter"> 
				</div>		
				<div class="text-filter-box">
					<input data-path="exceptfilter_not_id"  type="hidden" value="<%=Request.QueryString["code_List_val"]%>" data-control-type="textbox" data-control-name="exceptfilter_not_id" data-control-action="filter">
				</div>						
            <div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">合同编号:</div><![endif]--><input data-path="pactcode" data-button="#name-search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="pactcode" data-control-action="filter"> </div>
			<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">订单编号:</div><![endif]--><input data-path="code" data-button="#code-search-button" type="text" value="" placeholder="订单编号" data-control-type="textbox" data-control-name="code" data-control-action="filter"> <button type="button" id="code-search-button"><i class="glyphicon glyphicon-search"></i></button></div>
            <div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="opt_status-search-button"></button></div>
 
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
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
				<div class="jplist-drop-down" data-control-type="items-per-page-drop-down" data-control-name="paging" data-control-action="paging">
					<ul>
						<li><span data-number="3"> 每页 3 个项目 </span></li>
						<li><span data-number="5" data-default="true"> 每页 5 个项目 </span></li>
						<li><span data-number="10" > 每页 10 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>
 
				 	
        		<div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="opt_status-search-button"></button></div>
				<!-- 分页结果 -->
				<div class="jplist-label" data-type="第 {current} 页，共 {pages} 页" data-control-type="pagination-info" data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging" data-control-action="paging"></div>
				
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
		
		template.helper( "Total", function(data){
			try
			{
				if( parseInt(data.t) < parseInt(data.m))
				{
					return data.m;
				}
				else
				{
					return data.t;
				}
			} catch ( e )
			{
				return '0.00';
			}
		} );
        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "AccountPayOrderSelect", "/Widget.aspx?param=jplist&vid=grid_jplist_0118", false, function () {
            var code = [];
            $( 'tr[nrowid="Balance_BillDetails"]', parent.document ).each( function ( index )
            {
                code[index] = $(this).find('input[name="Code"]').val();
            } );
            if ( code.length > 0)
            {
                $( '.list .jptable tbody tr' ).each( function (index)
                {
                    for ( var i = 0; i < code.length; i++ )
                    {
                        if ( $( this ).find( 'td[fld="code"]' ).text() == code[i] ) {
                            $( this ).attr("style", "background:#f5f6fa");
                            $(this).find('input[type="checkbox"]')[0].checked = true;
                            $(this).find(':checkbox')[0].disabled = true;
                            $(this).click(function(e){
							     e.stopPropagation();
							});
                        }
                    }
                });
            }
        });
		
		/*setTimeout( function(){
		
			$('td[fld="Total"]').each(function(){
				
				var _trObj = $(this).closest('tr');
				var _Min = $(this).next().text();
				
				if( parseInt( $(this).text() ) < parseInt( _Min ) )
				{
					$(this).text( _Min );
				}
			});
		},1000 )*/
 
        $('input.rangeFromModal').on( "click", function(){
        	$("div#rangeFromModal").modal( "show" );
           	$('.fahuo').text('发货时段');        	
        } );
		
        resizeCols = setInterval('resizeTable()', 200);
	};
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/FMS/JS.aspx"-->
<script src="/assets/plugins/jquery/colResizable-1.5.min.js"></script>
<script src="/assets/request_minify.js"></script>
</body>
</html>
