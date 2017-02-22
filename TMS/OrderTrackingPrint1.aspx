<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!DOCTYPE html>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="/assets/js/jquery-1.11.1.min.js"></script>
	<script src="/assets/NSF/js/NSF.0.0.4.min.js"></script>
	<script src="js/index.js"></script>
	<head>	
		<title>客户订单打印-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--#include file="/Controls/Meta.aspx"-->
		<!--#include file="/Controls/TMS/CSS.aspx"-->
		<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
		<style>
			h1{
				text-align: center;
				margin: 0 auto;
			}
			table{
				width: 100%;
			}
			td{
				border: 1px solid black;
				height: 35px;
			}
			table tr td:nth-child(1){
				width: 8%;
			}
			table tr td:nth-child(2){
				width: 8%;
			}
			table tr td:nth-child(3){
				width: 10%;
			}
			table tr td:nth-child(4){
				width: 5%;
			}
			table tr td:nth-child(5){
				width: 5%;
			}
			table tr td:nth-child(6){
				width: 5%;
			}
			table tr td:nth-child(7){
				width: 5%;
			}
			table tr td:nth-child(8){
				width: 5%;
			}
			table tr td:nth-child(9){
				width: 5%;
			}
		</style>
	</head>
	<body onload="printtable()">
		<div class="title"><h1>客户订单日报表</h1></div>
		<p>报表日期：<span class="date"></span></p>
		<table id="demoTable">
			<thead>
				<tr>
					<td>订单号</td>
					<td>合同编号 </td>
					<td>客户名称</td>
					<td>发货市</td>
					<td>到货市</td>
					<td>总体积</td>
					<td>总重量</td>
					<td>总数量</td>
					<td>总金额</td>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</body>
		</table>
		<script>
			function printtable(){
				var dates = NSF.UrlVars.Get('date', location.href);
				var _mode = NSF.UrlVars.Get('mode', location.href);
				
				$(".date").text(dates);
				
				var vml ='[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0222","paras":[{"name":"createtime","value":"'+dates+'"}]}]';
				  NSF.System.Network.Ajax('/Portal.aspx',
				vml,
				'POST',
				false,
				function(result, data) {
					if(result) {
						for(var i=0;i<data[0].rs[0].rows.length;i++){
							var j = i+1;
							if(j==14||(j-14)%16==0){
									$("tbody").append("<tr style='page-break-after:always;'><td>"+data[0].rs[0].rows[i].code+"</td><td>"
												+data[0].rs[0].rows[i].pactcode+"</td><td>"
												+data[0].rs[0].rows[i].CustomerName+"</td><td>"
												+data[0].rs[0].rows[i].FromCity+"</td><td>"
												+data[0].rs[0].rows[i].ToCity+"</td><td>"
												+data[0].rs[0].rows[i].TotalVolume+"</td><td>"
												+data[0].rs[0].rows[i].TotalWeight+"</td><td>"
												+data[0].rs[0].rows[i].TotalAmount+"</td><td>"
												+data[0].rs[0].rows[i].TotalCost+"</td></tr>");
								
							}else{
									$("tbody").append("<tr><td>"+data[0].rs[0].rows[i].code+"</td><td>"
												+data[0].rs[0].rows[i].pactcode+"</td><td>"
												+data[0].rs[0].rows[i].CustomerName+"</td><td>"
												+data[0].rs[0].rows[i].FromCity+"</td><td>"
												+data[0].rs[0].rows[i].ToCity+"</td><td>"
												+data[0].rs[0].rows[i].TotalVolume+"</td><td>"
												+data[0].rs[0].rows[i].TotalWeight+"</td><td>"
												+data[0].rs[0].rows[i].TotalAmount+"</td><td>"
												+data[0].rs[0].rows[i].TotalCost+"</td></tr>");
							}
						}
					}
				})

				window.print();
//				window.history.go(-1);
			}
		</script>
</html>