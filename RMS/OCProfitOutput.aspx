<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!DOCTYPE html>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="/assets/js/jquery-1.11.1.min.js"></script>
	<script src="/assets/NSF/js/NSF.0.0.4.min.js"></script>
	<script src="/assets/NSF/js/NSF.System.Converter.min.js"></script>
	<script src="js/index.js"></script>
	<head>	
		<title>订单利润报表导出-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--#include file="/Controls/Meta.aspx"-->
		<!--#include file="/Controls/RMS/CSS.aspx"-->
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
		<div class="title"><h1>订单利润报表</h1></div>
		<!--<p>报表日期：<span class="date"></span></p>-->
		<table id="demoTable">
			<thead>
				<tr>
					<td class="title">订单编号</td>
					<td class="title">合同编号</td>
                    <td class="title">订单日期</td>
                    <td class="title">客户名称</td>
                    <td class="title">收入(元)</td>
                    <td class="title">总数量</td>
                    <td class="title">总重量(吨)</td>
                    <td class="title">总体积(方)</td>
                    <td class="title">成本(元)</td>
                    <td class="title">利润(元)</td>
                    <td class="title">收货方</td>
                    <td class="title">出发城市</td>
                    <td class="title">到达城市</td>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</body>
		</table>
		<script>
			function printtable(){
				var _startime = NSF.UrlVars.Get('start', location.href);
				var _endtime = NSF.UrlVars.Get('end', location.href);
				
			    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0010","paras":[{"name":"starttime","value":"' + _startime + ' 00:00:00"},{"name":"endtime","value":"' + _endtime + ' 23:59:59"}]}]';
				  NSF.System.Network.Ajax('/Portal.aspx',
				vml,
				'POST',
				false,
				function(result, data) {
					if(result) {
						for(var i=0;i<data[0].rs[0].rows.length;i++){
							$("tbody").append("<tr style='page-break-after:always;'><td>"+data[0].rs[0].rows[i].Code+"</td><td>"
												+data[0].rs[0].rows[i].PactCode+"</td><td>"
												+data[0].rs[0].rows[i].CreateTime+"</td><td>"
												+data[0].rs[0].rows[i].CustomerName+"</td><td>"
												+data[0].rs[0].rows[i].TotalCost+"</td><td>"
												+data[0].rs[0].rows[i].Qty+"</td><td>"
												+data[0].rs[0].rows[i].TotalWeight+"</td><td>"
												+data[0].rs[0].rows[i].TotalVolume+"</td><td>"
												+data[0].rs[0].rows[i].TotalPrime+"</td><td>"
												+parseFloat(data[0].rs[0].rows[i].TotalCost - data[0].rs[0].rows[i].TotalPrime).toFixed(2)+"</td><td>"
												+data[0].rs[0].rows[i].EndUser+"</td><td>"
												+data[0].rs[0].rows[i].From+"</td><td>"
												+data[0].rs[0].rows[i].To+"</td><td></tr>");
						}
					}
				});
				toXls('demoTable');
			}
		</script>
</html>