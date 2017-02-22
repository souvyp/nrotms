<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>货代报表-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/RMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="SupplierGood">

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
<!--#include file="/Controls/RMS/header.aspx"-->
<!--通用头部文件结尾-->

<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
		<div id="demo" class="box jplist">
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">货代报表</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <div class="text-filter-box">
                    <input readonly="" name="startime" onclick="GetDateEvent( this, { format: 'YYYY/MM/DD' } )" type="text" value="" placeholder="开始日期" data-control-type="textbox" data-control-action="filter"> 
                    <span class="pull-left" style="padding:5px 10px;">-</span>
                    <input readonly="" name="endtime" onclick="GetDateEvent( this, { format: 'YYYY/MM/DD', min: $( 'input[name=\'startime\']' ).val() } )" type="text" value="" placeholder="结束日期" data-control-type="textbox"  data-control-action="filter"> 
                    <button type="button" id="btn_click" onclick="SuppGood()"><i class="glyphicon glyphicon-search"></i></button>
                </div>
			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow anothertab_martop">
                    <div class="list-item box jplist-panel tabbtn">
	                    <div class=""><!-- block right -->
		                    <table class="jptable table table-border">
			                    <thead>
				                    <tr class="trtitle">
                                        <td class="title">承运商名称</td>
					                    <td class="title">总体积</td>
					                    <td class="title">总重量</td>
					                    <td class="title">总数量</td>
					                    <td class="title">运输单数量</td>
					                    <td class="title">总运费</td>
				                    </tr>
			                    </thead>			                    
                                <tbody class="SuppGood">
				                    
			                    </tbody>
		                    </table>
	                    </div>
                    </div>
				</div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center">
					<p>没有数据,请选择开始以及结束日期</p>
				</div>
			</div>
		</div>
		<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				

<!--通用页尾开始-->
<!--#include file="/Controls/RMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        
    };
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/RMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
