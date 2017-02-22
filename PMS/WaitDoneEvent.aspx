<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>我的待办-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="WaitDoneEvent">

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
<div class="list-item box jplist-panel tabbtn" >
	<div class=""><!-- block right -->
        <div class="maintitle_container">
           <p class="mainHtml_tit">我的待办</p>
        </div>
        <hr style="" >
		<table class="jptable  table">
			<thead>
				<tr class="trtitle">
					<td style="" colspan=""></td>
					<td class="title" style="color:#999;">事件</td>
                    <td class="title" style="color:#999;">发生时间</td>
				</tr>
			</thead>
			<tbody>
				<tr name="WaitDoneEvent" >
                    <td style="width:35px"></td>
					<td style="width:35px" name="WaitEvent" ><a  href="javascript:void(0)"></a></td>
					<td class="title" name="Event_Ext" style="display:none;" view-fld='{fld:"Event_Ext",method:"show"}'></td>
					<td class="title" name="Event_SrcCompanyName" style="display:none;" view-fld='{fld:"Event_SrcCompanyName",method:"show"}'></td>
					<td class="title" name="Event_DstCompanyName" style="display:none;" view-fld='{fld:"Event_DstCompanyName",method:"show"}'></td>
					<td class="title" name="Event_Type" style="display:none;" view-fld='{fld:"Event_Type",method:"show"}'></td> 
                    <td class="title" name="Doc_Type" style="display:none;" view-fld='{fld:"Doc_Type",method:"show"}'></td>
                    <td class="title" name="SupplierSymbolID" style="display:none;" view-fld='{fld:"SupplierSymbolID",method:"show"}'></td>
					<td class="title" view-fld='{fld:"Event_Time",method:"show"}'></td>
				</tr>
			</tbody>
		</table>
	</div>
    <div class="page"></div>
    <div name="first-ds-pag">
        <div style="text-align:center;display:none">
            <ul class="pag pagination">
                <li class="bord_li prev"><a href="#">
                    <img src="/assets/NSF/images/left.png" /></a>
                </li>
                <li class="bord_li next"><a href="#">
                    <img src="/assets/NSF/images/right.png" /></a>
                </li>
                <li class="bord_li border_li_marg showrec">每页<span class="pagesize"></span>条 ， 共<span class="recamount"></span>条</li>
            </ul>
        </div>
    </div>
</div>
<!-- 模板结尾 -->

<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
<%--		<div id="demo" class="box jplist">
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">历史待办</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
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
						<li><span data-path="Event_Time" data-order="desc" data-type="number">排序</span></li>
					</ul>
				</div>
			<div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="opt_status-search-button"></button></div>
				<!-- 分页结果 -->
				<div class="jplist-label" data-type="第 {current} 页，共 {pages} 页" data-control-type="pagination-info" data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging" data-control-action="paging"></div>
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
		</div>--%>
		<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				

<!--通用页尾开始-->
<!--#include file="/Controls/PMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/

        $('tr[name="WaitDoneEvent"]').attr('view-id', '{ id:"tms_0095",cross:"false", rowIdentClass:"WaitDoneEvent", paras:[{"name":"Amount","value":1000}]}');
        var _myEvents = new NSF.System.Data.Grid();
        _myEvents.Pagination("first-ds-pag", $("div[name='first-ds-pag']"));
        _myEvents.Initialize("/", "WaitDoneEvent", $("tr[name='WaitDoneEvent']").attr("view-id"), $("tr[name='WaitDoneEvent']"));

        $('.WaitDoneEvent').each(function () {
            var _WaitEvent;
            var _Event_Ext = $(this).find('td[name="Event_Ext"]').text();
            var _Event_SrcCompanyName = $(this).find('td[name="Event_SrcCompanyName"]').text();
            var _Event_DstCompanyName = $(this).find('td[name="Event_DstCompanyName"]').text();
            var _Event_Type = $(this).find('td[name="Event_Type"]').text();
            var _Doc_Type = $(this).find('td[name="Doc_Type"]').text();
            var _SupplierSymbolID = $(this).find('td[name="SupplierSymbolID"]').text(); //0 客户订单 1 自营订单

            if (_Event_Type == '1') {
                _WaitEvent = _Event_DstCompanyName + '被邀请成为承运方';
                $(this).find('a').attr('href', 'BeInvite.aspx');
            }
            else if (_Event_Type == '2') {
                if (_Event_Result == '0') {
                    _WaitEvent = '邀请' + _Event_SrcCompanyName + '成为承运方被接受';
                    $(this).find('a').attr('href', 'SupplierList.aspx');
                }
                else {
                    _WaitEvent = '邀请' + _Event_SrcCompanyName + '成为承运方被拒绝';
                    $(this).find('a').attr('href', 'Invite.aspx');
                }
            }else if (_Event_Type == '7') {
                if( _SupplierSymbolID == "0" ){
                    if( _Doc_Type == "1" ){
                        _WaitEvent = '【客户】由'+_Event_SrcCompanyName+'创建的按单报价，待审核报价单：' + _Event_Ext;
                        $(this).find('a').attr('href', 'Index_edit.aspx?id='+ _Event_Ext +'&status=1&code=VerifingDoc');
                    }else if( _Doc_Type == "2" ){
                        _WaitEvent = '【客户】由'+_Event_SrcCompanyName+'创建的合约报价，待审核报价单：' + _Event_Ext;
                        $(this).find('a').attr('href', 'DocByCompact_edit.aspx?id='+ _Event_Ext +'&status=1&code=VerifingDoc');
                    }else if( _Doc_Type == "3" ){
                        _WaitEvent = '【客户】由'+_Event_SrcCompanyName+'创建的按单补充报价，待审核报价单：' + _Event_Ext;
                        $(this).find('a').attr('href', 'IndexAddition_edit.aspx?id='+ _Event_Ext +'&status=1&code=VerifingDoc');
                    }else if( _Doc_Type == "4" ){
                        _WaitEvent = '【客户】由'+_Event_SrcCompanyName+'创建的合单报价，待审核报价单：' + _Event_Ext;
                        $(this).find('a').attr('href', 'SendingCombined_edit.aspx?id='+ _Event_Ext +'&status=1&code=VerifingDoc');
                    }else if( _Doc_Type == "5" ){
                        _WaitEvent = '【客户】由'+_Event_SrcCompanyName+'创建的合单补充报价，待审核报价单：' + _Event_Ext;
                        $(this).find('a').attr('href', 'IndexAddCombined_edit.aspx?id='+ _Event_Ext +'&status=1&code=VerifingDoc');
                    }
                }
            } else if (_Event_Type == '25') {
                if( _SupplierSymbolID == "0" ){
                    _WaitEvent = '【客户】基础（零担/整车）价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'AdditionDoc_edit.aspx?id='+ _Event_Ext );
                }else if( _SupplierSymbolID == "1" ){
                    _WaitEvent = '【自营】基础（零担/整车）价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'SelfAddition_edit.aspx?id='+ _Event_Ext );
                }
            } else if (_Event_Type == '26') {
                if( _SupplierSymbolID == "0" ){
                    _WaitEvent = '【客户】提货费价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'AdditionDoc_edit.aspx?id='+ _Event_Ext );
                }else if( _SupplierSymbolID == "1" ){
                    _WaitEvent = '【自营】提货费价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'SelfAddition_edit.aspx?id='+ _Event_Ext );
                }
            } else if (_Event_Type == '27') {
                if( _SupplierSymbolID == "0" ){
                    _WaitEvent = '【客户】送货费价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'AdditionDoc_edit.aspx?id='+ _Event_Ext );
                }else if( _SupplierSymbolID == "1" ){
                    _WaitEvent = '【自营】送货费价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'SelfAddition_edit.aspx?id='+ _Event_Ext );
                }
            }  else if (_Event_Type == '28') {
                if( _SupplierSymbolID == "0" ){
                    _WaitEvent = '【客户】装货费价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'AdditionDoc_edit.aspx?id='+ _Event_Ext );
                }else if( _SupplierSymbolID == "1" ){
                    _WaitEvent = '【自营】装货费价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'SelfAddition_edit.aspx?id='+ _Event_Ext );
                }
            } else if (_Event_Type == '29') {
                if( _SupplierSymbolID == "0" ){
                    _WaitEvent = '【客户】卸货费价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'AdditionDoc_edit.aspx?id='+ _Event_Ext );
                }else if( _SupplierSymbolID == "1" ){
                    _WaitEvent = '【自营】卸货费价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'SelfAddition_edit.aspx?id='+ _Event_Ext );
                }
            } else if (_Event_Type == '30') {
                if( _SupplierSymbolID == "0" ){
                    _WaitEvent = '【客户】保费价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'AdditionDoc_edit.aspx?id='+ _Event_Ext );
                }else if( _SupplierSymbolID == "1" ){
                    _WaitEvent = '【自营】保费价格为0：' + _Event_Ext;
                    $(this).find('a').attr('href', 'SelfAddition_edit.aspx?id='+ _Event_Ext );
                }
            }
            
            $(this).find('td[name="WaitEvent"] a').text(_WaitEvent);

        });

        //提示没有数据

        if ($('.table tbody tr:first').hasClass('WaitDoneEvent') == false) {
            var nodata = $("<p></p>").text('没有数据');
            nodata.css('text-align', 'center');
            $('.table').after(nodata);

        }
        //获取序列号
        for (var i = 0; i < $('.WaitDoneEvent').length; i++) {
            $('.WaitDoneEvent').eq(i).find('td').first().text(i+1);
        }
        
    };
    var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/PMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
