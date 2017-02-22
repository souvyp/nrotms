<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>客户利润报表-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
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
		width: 14%;
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
		width: 14%;
		height: 50px;
	}
	.commodity table tbody tr td{
		width: 14%;
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
<body code="OCustomerProfit" onload="getdate()">

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

<!-- 模板开始-->
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
		<div id="demo" class="box jplist">
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
    			<p class="mainHtml_tit" style="float: left;">客户利润报表</p>	
    			<div style="float: right;" class="btn btn-red footKeepBtn" onclick="PrintArea()">打印&nbsp;<span class="glyphicon glyphicon-print"></span></div>
	            <a style="float: right;margin:5px;position:relative;bottom:5px" class="btn btn-red footKeepBtn" target="_blank"  onclick="OCustomerProfitOutput(this)" id="printbtn">导出&nbsp;<span class="glyphicon glyphicon-new-window"></span></a>
           </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
				<div class="text-filter-box">
					<input readonly="" name="startime" onclick="GetDateEvent( this, { format: 'YYYY/MM/DD' } )" type="text" value="" placeholder="开始日期" data-control-type="textbox" data-control-action="filter"> 
                    <span class="pull-left" style="padding:5px 10px;">-</span>
                    <input readonly="" name="endtime" onclick="GetDateEvent( this, { format: 'YYYY/MM/DD', min: $( 'input[name=\'startime\']' ).val() } )" type="text" value="" placeholder="结束日期" data-control-type="textbox"  data-control-action="filter"> 
					<button type="button" id="btn_click" onclick="OCusPro()"><i class="glyphicon glyphicon-search"></i></button>
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
                                        <td class="title">客户名称</td>
					                    <td class="title">总收入(元)</td>
					                    <td class="title">订单数量(个)</td>
					                    <td class="title">总重量(吨)</td>
					                    <td class="title">总体积(方)</td>
					                    <td class="title">总成本(元)</td>
					                    <td class="title">总利润(元)</td>
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
					<!--startprint-->
						<div class="page" style="display: none;">
						 	<div class='header'>
						 		<table>
						 			<tr>
						 				<td colspan='3' style="text-align: left;">打印日期:<span class="date"></span></td>
						 			</tr>
						 			<tr>
						 				<td><div class='logo1'><img src='/images/zhongbaowuliu.png'></div></td>
						 				<td><div class='company'><img src='/images/kehudan.png'></div></td>
						 				<td><div class='qrcode'><img src='/images/erweima.png'></div></td>
						 			</tr>
						 			<tr>
						 				<td colspan='3' style="text-align: left;">统计时间:<span class="statictime"></span></td>
						 			</tr>
						 		</table>
						 	</div>	 	
						 	<div class='commodity'>
						 		<table>
							 		<thead>
							 			<tr>
							 				<td class="title1">客户名称</td>
					                    	<td class="title1">总收入(元)</td>
					                    	<td class="title1">订单数量(个)</td>
					                    	<td class="title1">总重量(吨)</td>
					                    	<td class="title1">总体积(方)</td>
					                    	<td class="title1">总成本(元)</td>
					                    	<td class="title1">总利润(元)</td>
							 			</tr>
							 		</thead>
						 		</table>
						 	</div>		
						 	<div class='attention'>
						 		<table style='padding: 10px;'>
						 			<tr>
						 				<td width='10%' style="text-align: left;">
						 					注意事项:
						 				</td>
						 				<td colspan='2'>
						 					<ul>
						 						<li style="text-align: left;">一、发货方托运的货物如实填写，不得隐瞒货物名称、数量及性质，不得在托运货物内夹带危险品、禁运物品。否则承运方在运输途中为此造成损失均由甲方负责。</li>
						 						<li style="text-align: left;">二、发货方若不跟人押车，卸货地址务必填清，货物包装必须完整无损，承运方按卸货地址给予按期，完整无缺运到和办理交接手续，否则造成损失各负其责。</li>
						 						<li style="text-align: left;">三、发货方托运货物时、必须参加保险，如不参加保险，出现货损、货差由发货方自负。</li>
						 					</ul>
						 				</td>
						 			</tr>
						 		</table>
						 	</div>
						 	<div class='signature'>
						 		<table>
						 			<tr>
						 				<td style="width: 70%;"></td>
						 				<td style='align-content: right;'>______年______月______日</td>
						 			</tr>
						 		</table>
						 	</div>
					 	</div>
				 	<!--endprint-->
 
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				
<hr class="col-md-12 hr_charts hide"/>
<div class="highcharts col-md-12" style="min-width: 310px; height: 400px; margin: 0 auto;float: left;"></div>
<!--通用页尾开始-->
<!--#include file="/Controls/RMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/
    };
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
	
	function PrintArea(){
		
		if($(".jplistYL").eq(0).children().length==0){
			alert("请输入时间段进行查询！");
			setTimeout("closealert()",2000);
		}else if($(".jplistYL").eq(0).children().length>0){
			if($(".jplistYL").eq(0).children().eq(0).children().eq(0).text()=="该时间段没有数据！！！"){
				alert("该时间段没有数据，请重新选择时间段进行查询！");
				setTimeout("closealert()",2000);
			}else{
				var start = $("input[name='startime']").val();
				var end = $("input[name='endtime']").val();
		
				var tb = $(".jplistYL").clone();
				tb.removeClass("jplistYL");
				$(".commodity").eq(0).children().eq(0).append(tb);
				$(".statictime").text(start +"——" +end);
				
				print_a()				
			}
		}
	}
	
	function closealert(){
		$("button[class='close']").click();
	}
	
	function getdate(){
		var Dates = new Date();
		var year = Dates.getFullYear();
		var mounth = Dates.getMonth()+1;
		var day = Dates.getDate();
		var printdate = year+"/"+mounth+"/"+day;
		$(".date").text(printdate);
	}
	
	function print_a() {
		$(".page").attr("style","display:block");
        bdhtml = window.document.body.innerHTML;
        sprnstr = "<!--startprint-->";
        eprnstr = "<!--endprint-->";
        prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        window.print();
        window.history.go(0);
        $(".commodity").eq(0).children().eq(0).children().eq(1).remove();
    }
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/RMS/JS.aspx"-->
<script src="/assets/plugins/highcharts/highcharts.js"></script>
<script src="/assets/request_minify.js"></script>
</body>
</html>
