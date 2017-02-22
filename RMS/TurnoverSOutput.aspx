<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!DOCTYPE html>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="/assets/js/jquery-1.11.1.min.js"></script>
	<script src="/assets/NSF/js/NSF.0.0.4.min.js"></script>
	<script src="/assets/NSF/js/NSF.System.Converter.min.js"></script>
	<script src="js/index.js"></script>
	<head>	
		<title>营业额月报表导出-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
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
		<div class="title"><h1>营业额月报表</h1></div>
		<!--<p>报表日期：<span class="date"></span></p>-->
		<table id="demoTable">
			<thead>
				<tr>
					<td class="title">年</td>
                    <td class="title">一月(元)</td>
                    <td class="title">二月(元)</td>
                    <td class="title">三月(元)</td>
                    <td class="title">四月(元)</td>
                    <td class="title">五月(元)</td>
                    <td class="title">六月(元)</td>
                    <td class="title">七月(元)</td>
                    <td class="title">八月(元)</td>
                    <td class="title">九月(元)</td>
                    <td class="title">十月(元)</td>
                    <td class="title">十一月(元)</td>
                    <td class="title">十二月(元)</td>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</body>
		</table>
		<script>
			function printtable(){				
			    var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0008","paras":[]}]';
				  NSF.System.Network.Ajax('/Portal.aspx',
				vml,
				'POST',
				false,
				function(result, data) {
					if(result) {
						for(var i=0;i<data[0].rs[0].rows.length;i++){
							$("tbody").append("<tr style='page-break-after:always;'><td>"+data[0].rs[0].rows[i].Year+"</td><td>"
												+data[0].rs[0].rows[i][1]+ '</td><td>'
												+data[0].rs[0].rows[i][2]+ '</td><td>'
												+data[0].rs[0].rows[i][3]+ '</td><td>'
												+data[0].rs[0].rows[i][4]+ '</td><td>'
												+data[0].rs[0].rows[i][5]+ '</td><td>'
												+data[0].rs[0].rows[i][6]+ '</td><td>'
												+data[0].rs[0].rows[i][7]+ '</td><td>'
												+data[0].rs[0].rows[i][8]+ '</td><td>'
												+data[0].rs[0].rows[i][9]+ '</td><td>'
												+data[0].rs[0].rows[i][10]+ '</td><td>'
												+data[0].rs[0].rows[i][11]+ '</td><td>'
												+data[0].rs[0].rows[i][12]+"</td></tr>");
						}
					}
				});
				toXls('demoTable');
			}
		</script>
</html>