<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!DOCTYPE html>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="/assets/js/jquery-1.11.1.min.js"></script>
	<script src="/assets/NSF/js/NSF.0.0.4.min.js"></script>
	<script src="/TMS/js/OrderPrint.js"></script>
	<head>	
		<title>运输订单打印-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--#include file="/Controls/Meta.aspx"-->
		<!--#include file="/Controls/TMS/CSS.aspx"-->
		<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
		<style>
			.datatable{
				display: none;
			}
			.default{
				display: none;
			}
			.page0 table{
				margin: 0;
				padding: 0;
				width: 100%;
			}
			.page0 thead td{
				border-top: 1px solid black;
			}
			.page0 td{
				margin: 0;
				padding: 0;
				border: 1px solid black;
				border-collapse: collapse;
			}
			.page0 ul{
				padding: 0;
				margin: 0;
			}
			h3{
				margin: 0;
				width: 100%;
				text-align: center;
			}
			h4{
				margin: 0;
			}
			.pagecode{
				margin: 0;
				width: 100%;
				text-align: center;
			}
		</style>
	</head>
	<body>
	<div class="default">
		 	<div class='header'>
		 		<h3>客户订单日报表</h3>
		 		<h4>报表日期：<span></span></h4>
		 	</div>
		 	<div class='body'>
		 	</div>
		 	<div class='footer'>
		 		<h4 class="pagecode"></h4>
		 	</div>
		</div>
		
		<table class="datatable">
 			<thead>
 				<tr>
 					<td>订单号</td>
 					<td>合同编号</td>
 					<td>客户名称</td>
 					<td>承运商名称</td>
 					<td>发货市</td>
 					<td>到货市</td>
 					<td>总体积</td>
 					<td>总重量</td>
 					<td>总数量</td>
 					<td>合单编号</td>
 				</tr>
 			</thead>
 			<tbody>
 				<!--添加字段，有子行的可添加ul-->
 				<tr>
	 				<td>code</td>
	 				<td>pactcode</td>
	 				<td>CustomerName</td>
	 				<td>SupplierName</td>
	 				<td>FromCity</td>
	 				<td>ToCity</td>
	 				<td>TotalVolume</td>
	 				<td>TotalWeight</td>
	 				<td>TotalAmount</td>
	 				<td>ContainsOwnerOrderCode</td>
	 			</tr>
	 			<!--需要每页合计的在对应列中添加pagesum格式与字段列格式相同-->
	 			<tr>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 			</tr>
	 			<!--总计，尚未实现功能-->
	 			<tr>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 			</tr>
 			</tbody>
 		</table>
	<script>
		var __config =  {
						"page":{							//1、纸张设置
								"height":"25.5"				//	  纸张高度
								},
						"header":{							//2、页头设置
								"height":"2",				//	 页头高度
								"showmode":"once"			//	 显示模式：once/every
								},
						"body"  :{							//3、表格设置
								"id":"tms_0222",			//	 存储过程ID
								"rowheight":"1.5",			//	 行高		
								"titleheight":"1",			//	 标题高度
								"titleshowmode":"every"		//	 标题显示模式：once/every
								},
						"footer":{							//4、页尾设置
								"height":"1",				//	 页尾高度
								"showmode":"every"			//	 显示模式：once/every
								},
						"pagecode":{						//5、页码设置
								"height":"1",				//	 页码高度		
								"fontsize":"10"				//	 字体大小	pt
								}
						}
		Print_Goods(NSF.UrlVars.Get('date', location.href));
		$(".header span").text(NSF.UrlVars.Get('date', location.href));
		window.print();
		window.history.go(-1);
	</script>
	</body>
</html>