<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!DOCTYPE html>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="/assets/js/jquery-1.11.1.min.js"></script>
	<script src="/assets/NSF/js/NSF.0.0.4.min.js"></script>
	<script src="/assets/NSF/js/NSF.System.Converter.min.js"></script>
	<script src="js/index.js"></script>

	<head>	
		<title>客户订单导出-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
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
		</style>
	</head>
	<body onload="printtable()">
		<div class="title"><h1>客户订单日报表</h1></div>
		<!--<p>报表日期：<span class="date"></span></p>-->
		<table id="demoTable">
			<thead>
				<tr>
					<td>订单号</td>
					<td>合同编号 </td>
					<td>客户名称</td>
					<td>发货市</td>
					<td style="width:15%">发货地址</td>
					<td>发货时间</td>
					<td>到货市</td>
					<td style="width:15%">到货地址</td>
					<td>到货时间</td>
					<td>物品明细</td>
					<td>总体积</td>
					<td>总重量</td>
					<td>总数量</td>
					<td>订单状态</td>
					<td>备注</td>
					<td>总金额</td>
					<td>合单编号</td>
					<td>零担</td>
				    <td>整车</td>
				    <td>提货费</td>
				    <td>送货费</td>
				    <td>装货费</td>
				    <td>卸货费</td>
				    <td>保险费</td>
				    <td>税费</td>
				    <td>附加费</td>
					<td>制单时间</td>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</body>
		</table>
		<script>
			function printtable(){
				var _data = NSF.UrlVars.Get('data', location.href);
								
				var vml ='[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0230","paras":'+ unescape(_data) +'}]';
				  NSF.System.Network.Ajax('/Portal.aspx',
				vml,
				'POST',
				false,
				function(result, data) {
					if(result) {
						for(var i=0;i<data[0].rs[0].rows.length;i++){
							var j = i+1;

							var _goodslst = data[0].rs[0].rows[i].GoodsLst.split(';');
							var _goods = '';
							for (var k = 0; k < _goodslst.length; k++) {
								_goods += _goodslst[k];
							}

							if(j==14||(j-14)%16==0){
									$("tbody").append("<tr style='page-break-after:always;'><td>"+data[0].rs[0].rows[i].code+"</td><td>"
												+data[0].rs[0].rows[i].pactcode+"</td><td>"
												+data[0].rs[0].rows[i].CustomerName+"</td><td>"
												+data[0].rs[0].rows[i].FromCity+"</td><td>"
												+data[0].rs[0].rows[i].FromAddress+"</td><td>"
												+data[0].rs[0].rows[i].FromTime+"</td><td>"
												+data[0].rs[0].rows[i].ToCity+"</td><td>"
												+data[0].rs[0].rows[i].ToAddress+"</td><td>"
												+data[0].rs[0].rows[i].ToTime+"</td><td>"
												+_goods+"</td><td>"
												+data[0].rs[0].rows[i].TotalVolume+"</td><td>"
												+data[0].rs[0].rows[i].TotalWeight+"</td><td>"
												+data[0].rs[0].rows[i].TotalAmount+"</td><td>"
												+data[0].rs[0].rows[i].StatusName+"</td><td>"
												+data[0].rs[0].rows[i].Description+"</td><td>"
												+data[0].rs[0].rows[i].TotalCost+"</td><td>"
												+data[0].rs[0].rows[i].ContainsOrderCode+"</td><td>"
												+data[0].rs[0].rows[i].LessLoad+"</td><td>"
												+data[0].rs[0].rows[i].FullLoad+"</td><td>"
												+data[0].rs[0].rows[i].Pick+"</td><td>"
												+data[0].rs[0].rows[i].Delivery+"</td><td>"
												+data[0].rs[0].rows[i].OnLoad+"</td><td>"
												+data[0].rs[0].rows[i].OffLoad+"</td><td>"
												+data[0].rs[0].rows[i].InsuranceCost+"</td><td>"
												+data[0].rs[0].rows[i].Tax+"</td><td>"
												+data[0].rs[0].rows[i].Addition+"</td><td>"
												+data[0].rs[0].rows[i].CreateTime+"</td></tr>");
							}else{
								$("tbody").append("<tr><td>"+data[0].rs[0].rows[i].code+"</td><td>"
											+data[0].rs[0].rows[i].pactcode+"</td><td>"
											+data[0].rs[0].rows[i].CustomerName+"</td><td>"
											+data[0].rs[0].rows[i].FromCity+"</td><td>"
											+data[0].rs[0].rows[i].FromAddress+"</td><td>"
											+data[0].rs[0].rows[i].FromTime+"</td><td>"
											+data[0].rs[0].rows[i].ToCity+"</td><td>"
											+data[0].rs[0].rows[i].ToAddress+"</td><td>"
											+data[0].rs[0].rows[i].ToTime+"</td><td>"
											+_goods+"</td><td>"
											+data[0].rs[0].rows[i].TotalVolume+"</td><td>"
											+data[0].rs[0].rows[i].TotalWeight+"</td><td>"
											+data[0].rs[0].rows[i].TotalAmount+"</td><td>"
											+data[0].rs[0].rows[i].StatusName+"</td><td>"
											+data[0].rs[0].rows[i].Description+"</td><td>"
											+data[0].rs[0].rows[i].TotalCost+"</td><td>"
											+data[0].rs[0].rows[i].ContainsOrderCode+"</td><td>"
											+data[0].rs[0].rows[i].LessLoad+"</td><td>"
											+data[0].rs[0].rows[i].FullLoad+"</td><td>"
											+data[0].rs[0].rows[i].Pick+"</td><td>"
											+data[0].rs[0].rows[i].Delivery+"</td><td>"
											+data[0].rs[0].rows[i].OnLoad+"</td><td>"
											+data[0].rs[0].rows[i].OffLoad+"</td><td>"
											+data[0].rs[0].rows[i].InsuranceCost+"</td><td>"
											+data[0].rs[0].rows[i].Tax+"</td><td>"
											+data[0].rs[0].rows[i].Addition+"</td><td>"
											+data[0].rs[0].rows[i].CreateTime+"</td></tr>");
							}
						}
					}
				})
				toXls('demoTable');
			}
		</script>
</html>