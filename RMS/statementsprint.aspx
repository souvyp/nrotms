<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
    <title>订单打印-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--#include file="/Controls/Meta.aspx"-->
    <!--#include file="/Controls/TMS/CSS.aspx"-->
    <link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
    <!--<script src="/js/jquery.qrcode.min.js"></script>-->
	<script language="JavaScript" src="/assets/js/jquery-1.11.1.min.js"></script>
	<script language="JavaScript" src="/assets/NSF/js/NSF.0.0.4.min.js"></script>
</head>
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
<body onload="getdate()">
	<div class="page">
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
		 				<td class='title1'>承运方名称</td>
		 				<td class='title1'>总运费(元)</td>
		 				<td class='title1'>订单数量(个)</td>
		 				<td class='title1'>总重量(吨)</td>
		 				<td class='title1'>总体积(方)</td>
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
</body>
<script>		
	function getQueryString(name) {
	    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
	    var r = window.location.search.substr(1).match(reg);
	    if (r != null) {
	        return unescape(r[2]);
	    }
	    return null;
	} 
		
	function PrintArea(){
		var start = $("input[name='startime']").val();
		var end = $("input[name='endtime']").val();
		$(".statictime").text(start +"——" +end);
		var statement = $(".jplistYL").clone();
		$(".commodity").eq(0).children().eq(0).append(statement);
		$(".page").attr("style","display: block;");
		$(".commodity tr td").attr("style","width: 20%;");
		$(".page").printArea();
		$(".page").attr("style","display: none;");
		$(".commodity").eq(0).children().eq(0).children().eq(1).remove();
	}
	
	function getdate(){
		var Dates = new Date();
		var year = Dates.getFullYear();
		var mounth = Dates.getMonth()+1;
		var day = Dates.getDate();
		var printdate = year+"/"+mounth+"/"+day;
		$(".date").text(printdate);
	}
	
	window.onload=function(){
		var rows = parseInt(getQueryString("rows"));
		var start = getQueryString("startti").toString();
	    var end = getQueryString("endti").toString();
	    
	    $(".commodity table").append("<tbody id='detail'></tbody>");
	    $(".statictime").text(start+"——"+end); 
	    
	    for(var i=0;i<rows;i++){
	    	var tr = document.createElement("tr");
	    	
	    	for(var j=0;j<4;j++){
	    		var td = document.createElement("td");
	    		var content = getQueryString("tr"+i+"td"+j);
	    		td.innerText = content;
	    	}
	    	
	    	var tb = document.getElementById("detail");
	    	tb.appendChild(tr);
	    }
	}
</script>
</html>