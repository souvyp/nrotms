<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>承运方回单统计-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/RMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<style>
	table{
		width:100%;
		font-size: 10px;
		color: rgb(77,77,77);
	}
	td{
		text-align: left;
	}
	ul{
		list-style-type: none;
		margin: 0;
		padding: 0;
	}
	li{
		text-align: left;
	}
	.logo1{
		width: 190px;
		height: 60px;
	}
	.logo1 img{
		width: 190px;
		height: 60px;
	}
	.company{
		width:220px;
		height: 60px;
	}
	.company img{
		width:220px;
		height: 60px;
	}
	.qrcode{
		width: 200px;
		height: 100px;
	}
	.qrcode img{
		width: 100px;
		height: 100px;
		float: right;
	}
	.title1{
		background-color: rgb(240,240,240);
		font-weight: bold;
		width: 20%;
	}
	.commodity{
		width: 100%;
	}
	.commodity table{
		width: 100%;
	}
	.commodity table thead{
		width: 100%;
	}
	.commodity table tbody{
		width: 100%;
	}
	.commodity table thead tr td{
		width: 20%;
		height: 50px;
	}
	.commodity table tbody tr td{
		width: 20%;
		height: 50px;		
	}
	.information{
		margin-top: 20px;
	}
	.attention{
		margin-top: 20px;
	}
	.signature{
		margin-top: 40px;
	}
</style>
</head>
<body code="CarrierReceipt" onload="getdate()">

<!-- 通用对话框开始-->
<div class="modal fade text-center" id="win-Common-Dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm" style="width: 300px !important;height: 230px !important;">
		<div class="modal-content" style="height: 230px;">
			<div class="modal-body">
				<div class="content">
					<div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="win-Common-DialogLabel">是否确认打印？</h4>	
	               </div>        
					<div class="modal-body">
					</div>			
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		                <button type="button" class="btn btn-red footKeepBtn" onclick="print_a()">确认</button>
		            </div>
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
           <p style="float: left;" class="mainHtml_tit">承运方回单统计</p>
           
        </div>
		<!-- 操作面板 -->
		<div class="jplist-panel box panel-top min_height">
			<div class="text-filter-box">
				<input readonly="" name="startime" onclick="GetDateEvent( this, { format: 'YYYY/MM/DD' } )" type="text" value="" placeholder="开始日期" data-control-type="textbox" data-control-action="filter"> 
                <span class="pull-left" style="padding:5px 10px;">-</span>
                <input readonly="" name="endtime" onclick="GetDateEvent( this, { format: 'YYYY/MM/DD', min: $( 'input[name=\'startime\']' ).val() } )" type="text" value="" placeholder="结束日期" data-control-type="textbox"  data-control-action="filter"> 
				<button type="button" id="btn_click" onclick="CarrRec()"><i class="glyphicon glyphicon-search"></i></button>
			</div>
			<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
		</div>
		<div>
			<!-- 异步加载内容 -->
			<div class="list box text-shadow anothertab_martop">
                <div class="list-item box jplist-panel tabbtn">
                    <div class=""><!-- block right -->
	                    <table class="jptable table table-border">
		                    <thead>
			                    <tr class="trtitle">
                                        <td class="title">承运方名称</td>
					                    <td class="title">总回单数</td>
					                    <td class="title">未回单数</td>
					                    <td class="title">已回单数</td>
					                    <td class="title">回单比例</td>
 
			                    </tr>
		                    </thead>			                    
                            <tbody class="jplistYL">
			                    
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
<hr class="col-md-12 hr_charts hide"/>
<div class="highcharts col-md-12" style="min-width: 310px; height: 400px; margin: 0 auto;float: left;"></div>

<!--通用页尾开始-->
<!--#include file="/Controls/RMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/        
    };
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
 
	
	function getdate(){
		var Dates = new Date();
		var year = Dates.getFullYear();
		var mounth = Dates.getMonth()+1;
		var day = Dates.getDate();
		var printdate = year+"/"+mounth+"/"+day;
		$(".date").text(printdate);
	}
 
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/RMS/JS.aspx"-->
<script src="/assets/plugins/highcharts/highcharts.js"></script>
<script src="/assets/request_minify.js"></script>
</body>
</html>
