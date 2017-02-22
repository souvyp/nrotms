<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!DOCTYPE html>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<head>
	    <title>通用打印-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
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
			font-size: 8px;
			color: rgb(77,77,77);
			font-family: "宋体";
		}
		td{
			text-align: left;
		}
		ul{
			margin: 0;
			padding: 0;
		}
		.logo{
			width: 190px;
			height: 75px;
		}
		.logo img{
			width: 190px;
			height: 75px;
		}
		.qrcode{
			/*width: 200px;*/
			height: 100px;
			margin-bottom: 10px;
		}
		.qrcode img{
			width: 100px;
			height: 100px;
			float: right;
		}
		.title{
			border-top: 1px solid rgb(179,179,179);
			border-bottom: 0!important;
			background-color: rgb(240,240,240);
			font-weight: bold;
		}
		*{
			margin: 0;
			padding: 0;
		}
		.default{
			width: 22.5cm;
			height: 28.5cm;
			page-break-after: always;
			display: none;
		}
		.page0{
			width: 22.5cm;
			height: 28.5cm;
			position: relative;
		}
		.page0 table thead td{
			border-top: 1px solid black;
			border-bottom: 1px solid black;
			border-collapse: collapse;
			background-color: gainsboro;
		}
		.page0 table tbody td{
			border-bottom: 1px solid black;
			border-collapse: collapse;
		}
		.body table{
			width: 100%;
		}
		.footer{
			width: 100%;
			position: absolute;left: 0;bottom: 0;
		}
		.information{
			width: 100%;
			border-bottom: 1px solid rgb(179,179,179);
			padding-bottom: 10px;
		}
		.information table:nth-child(1) tr td:nth-child(1){
			width: 30%;
		}
		.information table:nth-child(1) tr td:nth-child(2){
			width: 30%;
		}
		.information table:nth-child(1) tr td:nth-child(3){
			width: 40%;
		}
		.information table:nth-child(2) tr td:nth-child(1){
			width: 30%;
		}
		.information table:nth-child(2) tr td:nth-child(2){
			width: 30%;
		}
		.information table:nth-child(2) tr td:nth-child(3){
			width: 20%;
		}
		.information table:nth-child(2) tr td:nth-child(4){
			width: 20%;
			text-align: right;
		}
		.attention{
			width: 100%;
		}
		.attention table tr td:nth-child(2){
			font-size: 5px;
		}
		.signature{
			width: 100%;
		}
		div.companyName{
			font-size: 24px;font-family: "宋体";font-weight: bold;
		}
		.DefalutOrder{
			position:relative;
			display: none;
			width: 22.5cm;
			height: 28.5cm;
		}
		.orders{
			position:relative;
			width: 22.5cm;
			height: 28.5cm;
		}
		.pagecode{
			width: 100%;
			text-align: center;
		}
	</style>
	<body>
		<div class='default'>
			<div class='header'>
				<table>
		 			<tr>
		 				<td colspan="3">打印日期:<span class="date"></span></td>
		 			</tr>
		 			<tr>
		 				<td style="width: 200px;"><div class="logo"><img src="/images/print_logo1.png"></div></td>
		 				<td style="text-align:center;">
		 					<div class="companyName" ></div>
		 					<div class="codeTitle" style="font-size: 16px;">（客户单）</div>
	 					</td>
		 				<td style="width: 200px;"><div class="qrcode"><img src="/images/QRCode.png"></div></td>
		 			</tr>
		 		</table>
		 		<table>
		 			<tr>
		 				<td>合同号:<span class="pactcode"></span></td>
		 				<td></td>
		 				<td style="text-align:right">订单编号：<span class="code"></span></td>
		 			</tr>
		 			<tr>
		 				<td>发货地址:<span class="fromaddress"></span></td>
		 				<td></td>
		 				<td style="text-align:right">收货地址:<span class="toaddress" ></span></td>
		 			</tr>
		 		</table>
			</div>
			
			<div class='body'>
				
			</div>
			
			<div class='footer'>
				<div class="information">
			 		<table>
			 			<tr>
			 				<td></td><td></td><td></td><td></td><td></td>
			 			</tr>
			 		</table>
			 		
			 		<table style="padding: 10px;;border-bottom: 1px solid rgb(179,179,179);">
			 			<tr>
			 				<td style="font-weight: bold;">发货方信息</td>
			 				<td style="font-weight: bold;">收货方信息</td>
			 				<td style="font-weight: bold;">承运方信息</td>
			 			</tr>
			 			<tr>
			 				<td>发货方名称：<span class="fromname"></span></td>
			 				<td>收货方名称：<span class="toname"></span></td>
			 				<td>承运方名称：<span class="suppliername"></span></td>
			 			</tr>
			 			<tr>
			 				<td>发货时间：<span class="fromtime"></span></td>
			 				<td>收货时间：<span class="totime"></span></td>
			 				<td>联系人：<span class="suppliercontactor"></span></td>
			 			</tr>
			 			<tr>
			 				<td>特殊要求：
			 					<span class="pick"></span>
			 					<span class="onload"></span>
			 					<span class="delivery"></span>
			 					<span class="offload"></span>
			 				</td>
			 				<td>联系电话：<span class="tocontact"></span></td>
			 				<td>联系电话：<span class="suppliertel"></span></td>
			 			</tr>
			 			<tr>
			 				<td>联系电话：<span class="fromcontact"></span></td>
			 				<td>下单时间：<span class="creattime"></span></td>
			 				<td></td>
			 			</tr>
			 			<tr>
			 				<td colspan="3">&nbsp;</td>
			 			</tr>
			 		</table>
			 		<table style="margin-top: 10px;">
			 			<tr>
			 				<td>计费模式：<span class="chargemode"></span></td>
			 				<td>计价单位：<span class="unit"></span></td>
			 				<td>运输模式：<span class="transportmode"></span></td>
			 				<td>是否保价：<span class="insurance"></span></td>
			 			</tr>
			 			<tr>
			 				<td>包装方式：<span class="package"></span></td>
			 				<td>运输方式：<span class="shipmethod"></span></td>
			 				<td>货物分类：<span class="category"></span></td>
			 				<td></td>
			 			</tr>
			 			<tr>
			 				<td colspan="4">备注：<span class="description"></span></td>
			 			</tr>
			 		</table>
			 	</div>
			 	
			 	<div class="attention">
			 		<table style="padding: 10px;">
			 			<tr>
			 				<td width="10%">
			 					注意事项：
			 				</td>
			 				<td>
			 					一、发货方托运的货物如实填写，不得隐瞒货物名称、数量及性质，不得在托运货物内夹带危险品、禁运物品。否则承运方在运输途中为此造成损失均由甲方负责。
			 				</td>
			 			</tr>
			 			<tr>
			 				<td width="10%" ></td>
			 				<td>
			 					二、发货方若不跟人押车，卸货地址务必填清，货物包装必须完整无损，承运方按卸货地址给予按期，完整无缺运到和办理交接手续，否则造成损失各负其责。
			 				</td>
			 			</tr>
			 			<tr>
			 				<td width="10%" ></td>
			 				<td>
			 					三、发货方托运货物时、必须参加保险，如不参加保险，出现货损、货差由发货方自负。
			 				</td>
			 			</tr>
			 		</table>
			 	</div>
			 	
			 	<div class="signature">
			 		<table>
			 			<tr>
			 				<td style="">核对人：_____________</td>
			 				<td style="">签收人：_____________</td>
			 				<td style="text-align: right;">______年______月______日</td>
			 			</tr>
			 		</table>
			 	</div>
				<div class='pagecode'></div>
			</div>
		</div>
	</body>
	<script>
		var __config = {
						'page':{
								'height':'25'		//纸张高度(单位：cm)
								},
						//表头设置
						'header':{
								'height':'5',		//高度(单位：cm)
								'showmode':'every'	//显示模式：顶端top/每页every
								},
						//表格设置
						'body'  :{
								'id':'tms_0030',	//存储过程id
								'rowheight':'1.5',	//行高(单位：cm)		
								'pagesum':'true',	//是否显示每页合计
								'item':'[物品编号,物品参数:物品名称、物品规格、物品批次,总重量（公斤）,总体积（立方米）,物品数量]',					//标题		 	(每列用","隔开,每列子行用"、"隔开,母标题与子标题用":"隔开)
								'field':'[GoodsID,parameter:Name、SPC、BatchNo,Weight,Volume,Qty]'	//标题对应字段  	(每列用","隔开,每列子行用"、"隔开,母字段与子字段用":"隔开)
								},
						//表尾设置		
						'footer':{
								'height':'9.5',		//高度(单位：cm)
								'showmode':'every'	//显示模式：底端bottom/每页every
								}
						}
		
		function strToJson(str){ 
			var json = eval('(' + str + ')'); 
			return json; 
		}
				
		function goods(orderid){
			var vml =
		 '[{"namespace":"protocol","cmd":"data","version":1,"id":"'+bodyconfig.id+'","paras":[{"name":"did","value":"' + orderid + '"}]}]';
			
			NSF.System.Network.Ajax('/Portal.aspx',
				vml,
				'POST',
				false,
				function(result, data) {
					if(result) {
						var item = bodyconfig.item.slice(1,-1).split(",");
						var field = bodyconfig.field.slice(1,-1).split(",");
						
						var num = data[0].rs[0].rows.length;			//总数据行
						var pageindex = 1;								//页索引值1
						var pageindex2 = 1;								//页索引值2
						var rowindex = 1;								//行索引
//						var pages;										//总页数1
//						var totlapage;									//总页数2
						var sum = [];									//每页数据合计二维数组
						
					if(__config.header.showmode=="every"&&__config.footer.showmode=="every"){
						if(__config.body.pagesum == "true"){
							pages = Math.ceil(num*__config.body.rowheight/(__config.page.height-__config.header.height-__config.footer.height-__config.body.rowheight));
							var rownum = Math.floor((__config.page.height-__config.header.height-__config.footer.height-__config.body.rowheight)/__config.body.rowheight); 
							totlapage = pages;
						
							//1、增加页数
							while(pages>0){
								var copydefault = $(".default").clone();
								copydefault.removeClass("default");
								copydefault.addClass("page0");
								copydefault.addClass("page"+pageindex);
								$("body").append(copydefault);
									
								//添加页码到.pagecode
								var code = pageindex+"/"+totlapage;
								$(".page"+pageindex+" .pagecode").text(code);
									
								//为每页加入打印分隔符	
								if(pages==1){
								}else{$(".page"+pageindex).css("page-break-after","always");}
									
								sum[pageindex] = [];							//定义元素数组
								
								//添加标题项
								$(".page"+pageindex+" .body").append("<table><thead><tr></tr></thead><tbody></tbody></table>");
								for(var i=0;i<item.length;i++){
									if(item[i].split(":").length==1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i]+"</td>");
									}else if(item[i].split(":").length>1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i].split(":")[0]+"</td>");
									}
									sum[pageindex][i] = 0.0;					//初始化元素数组元素
								}
								pageindex++;
								pages--;
							}
							
							//2、分页添加物品信息
							for(var i=0;i<data[0].rs[0].rows.length;i++){
							
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								//2.1、页尾行的处理
								if(rowindex%rownum==0){		
									for(var j=0;j<field.length;j++){
										var items = item[j];	//标题
										var fields = field[j];  //数据
										var commodityinfo = data[0].rs[0].rows[i];
										
										//有子行的列（不加总）
										if(fields.split(":").length > 1){
											$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
											for(var k=0;k<fields.split(":")[1].split("、").length;k++){
												var fieldS = fields.split(":")[1].split("、")[k];
												var itemS = items.split(":")[1].split("、")[k];
												var info = eval('commodityinfo.'+fieldS);
												$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
											}
											sum[pageindex2][j] = "";
										//没有子行的列（按条件加总）
										}else if(fields.split(":").length == 1){
											var info = eval('commodityinfo.'+fields);
											$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
											//数字会加总，文字不会加总
											if(isNaN(parseFloat(info))){
												sum[pageindex2][j] = "";
											}else{
												sum[pageindex2][j] += parseFloat(info);
											}
										}
									}
									
									//添加每页合计
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									for(var j=0;j<field.length;j++){
										if($.type(sum[pageindex2][j]) === "undefined"){
											$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
										}else{
											$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
										}
									}
									
									rowindex++;
									pageindex2++;
									
								//2.2、一般行的处理	
								}else{									
			 						for(var j=0;j<field.length;j++){
			 							var items = item[j];	//标题
			 							var fields = field[j];  //数据
										var commodityinfo = data[0].rs[0].rows[i];
											
										//有子行的列（不加总）	
										if(fields.split(":").length > 1){
											$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
											for(var k=0;k<fields.split(":")[1].split("、").length;k++){
												var fieldS = fields.split(":")[1].split("、")[k];
												var itemS = items.split(":")[1].split("、")[k];
	
												var info = eval('commodityinfo.'+fieldS);
												$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
											}
											sum[pageindex2][j] = "";
										//没有子行的列（按条件加总）	
										}else if(fields.split(":").length == 1){
											var info = eval('commodityinfo.'+fields);
											$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
											
											//数字会加总，文字不会加总
											if(isNaN(parseFloat(info))){
												sum[pageindex2][j] = "";
											}else{
												sum[pageindex2][j] += parseFloat(info);
											}
										}
									}
									rowindex++;
								}
							}
							
							//3、补充空行
							if(num%rownum==0){
								var rowsextra = 0;
							}else{
								var rowsextra = (rownum - num%rownum);
							}
							
							while(rowsextra>=1){
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								//3.1、页尾行的处理
								if(rowsextra==1){
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
	
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									for(var j=0;j<field.length;j++){
										if($.type(sum[pageindex2][j]) === "undefined"){
											$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
										}else{
											$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
										}
									}
								//3.2、一般行的处理	
								}else{
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
								}
								rowsextra--;
							}
							$('.body table tbody tr').css("height",__config.body.rowheight+"cm");
						}else{
							pages = Math.ceil(num*__config.body.rowheight/(__config.page.height-__config.header.height-__config.footer.height));
							var rownum = Math.floor((__config.page.height-__config.header.height-__config.footer.height)/__config.body.rowheight); 
							totlapage = pages;
						
							//1、增加页数
							while(pages>0){
								var copydefault = $(".default").clone();
								copydefault.removeClass("default");
								copydefault.addClass("page0");
								copydefault.addClass("page"+pageindex);
								$("body").append(copydefault);
									
								//添加页码到.pagecode
								var code = pageindex+"/"+totlapage;
								$(".page"+pageindex+" .pagecode").text(code);
									
								//为每页加入打印分隔符	
								if(pages==1){
								}else{$(".page"+pageindex).css("page-break-after","always");}
									
								sum[pageindex] = [];							//定义元素数组
								
								//添加标题项
								$(".page"+pageindex+" .body").append("<table><thead><tr></tr></thead><tbody></tbody></table>");
								for(var i=0;i<item.length;i++){
									if(item[i].split(":").length==1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i]+"</td>");
									}else if(item[i].split(":").length>1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i].split(":")[0]+"</td>");
									}
									sum[pageindex][i] = 0.0;					//初始化元素数组元素
								}
								pageindex++;
								pages--;
							}
							
							//2、分页添加物品信息
							for(var i=0;i<data[0].rs[0].rows.length;i++){
							
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								//2.1、页尾行的处理
								if(rowindex%rownum==0){		
									for(var j=0;j<field.length;j++){
										var items = item[j];	//标题
										var fields = field[j];  //数据
										var commodityinfo = data[0].rs[0].rows[i];
										
										//有子行的列（不加总）
										if(fields.split(":").length > 1){
											$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
											for(var k=0;k<fields.split(":")[1].split("、").length;k++){
												var fieldS = fields.split(":")[1].split("、")[k];
												var itemS = items.split(":")[1].split("、")[k];
												var info = eval('commodityinfo.'+fieldS);
												$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
											}
											sum[pageindex2][j] = "";
										//没有子行的列（按条件加总）
										}else if(fields.split(":").length == 1){
											var info = eval('commodityinfo.'+fields);
											$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
											//数字会加总，文字不会加总
											if(isNaN(parseFloat(info))){
												sum[pageindex2][j] = "";
											}else{
												sum[pageindex2][j] += parseFloat(info);
											}
										}
									}
									
									rowindex++;
									pageindex2++;
									
								//2.2、一般行的处理	
								}else{									
			 						for(var j=0;j<field.length;j++){
			 							var items = item[j];	//标题
			 							var fields = field[j];  //数据
										var commodityinfo = data[0].rs[0].rows[i];
											
										//有子行的列（不加总）	
										if(fields.split(":").length > 1){
											$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
											for(var k=0;k<fields.split(":")[1].split("、").length;k++){
												var fieldS = fields.split(":")[1].split("、")[k];
												var itemS = items.split(":")[1].split("、")[k];
	
												var info = eval('commodityinfo.'+fieldS);
												$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
											}
											sum[pageindex2][j] = "";
										//没有子行的列（按条件加总）	
										}else if(fields.split(":").length == 1){
											var info = eval('commodityinfo.'+fields);
											$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
											
											//数字会加总，文字不会加总
											if(isNaN(parseFloat(info))){
												sum[pageindex2][j] = "";
											}else{
												sum[pageindex2][j] += parseFloat(info);
											}
										}
									}
									rowindex++;
								}
							}
							
							//3、补充空行
							if(num%rownum==0){
								var rowsextra = 0;
							}else{
								var rowsextra = (rownum - num%rownum);
							}
							
							while(rowsextra>=1){
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								//3.1、页尾行的处理
								if(rowsextra==1){
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
								//3.2、一般行的处理	
								}else{
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
								}
								rowsextra--;
							}
							$('.body table tbody tr').css("height",__config.body.rowheight+"cm");
						}
						
					}else if(__config.header.showmode=="every"&&__config.footer.showmode=="bottom"){
						if(__config.body.pagesum == "true"){
							var lastrows = Math.floor((__config.page.height - __config.header.height - __config.footer.height - __config.body.rowheight)/__config.body.rowheight);
							var rownum = Math.floor((__config.page.height - __config.header.height - __config.body.rowheight)/__config.body.rowheight);
//							var pageextra = Math.ceil(num*__config.body.rowheight/(__config.page.height - __config.header.height - __config.body.rowheight));
							var pageextra = Math.ceil((num - lastrows)*__config.body.rowheight/(__config.page.height - __config.header.height - __config.body.rowheight));
							
							pages = pageextra + 1;
							totlapage = pages;
							
							//1、增加页数
							while(pages>0){
								var copydefault = $(".default").clone();
								copydefault.removeClass("default");
								copydefault.addClass("page0");
								copydefault.addClass("page"+pageindex);
								$("body").append(copydefault);
									
								//添加页码到.pagecode
								var code = pageindex+"/"+totlapage;
								$(".page"+pageindex+" .pagecode").text(code);
									
								//为每页加入打印分隔符	
								if(pages==1){
								}else{$(".page"+pageindex).css("page-break-after","always");}
									
								sum[pageindex] = [];							//定义元素数组
								
								//添加标题项
								$(".page"+pageindex+" .body").append("<table><thead><tr></tr></thead><tbody></tbody></table>");
								for(var i=0;i<item.length;i++){
									if(item[i].split(":").length==1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i]+"</td>");
									}else if(item[i].split(":").length>1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i].split(":")[0]+"</td>");
									}
									sum[pageindex][i] = 0.0;					//初始化元素数组元素
								}
								pageindex++;
								pages--;
							}
							
							//2、分页添加物品信息
							if(pageindex2 == pages){
								for(var i=0;i<data[0].rs[0].rows.length;i++){

									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%lastrows==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										//添加每页合计
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}else{
								for(var i=0;i<data[0].rs[0].rows.length;i++){

									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%rownum==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										//判断添加每页合计
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}

							//3、补充空行
							if((num-rownum*pageextra)%lastrows==0){
								var rowsextra = 0;
							}else{
								var rowsextra = (lastrows - (num-rownum*pageextra)%lastrows);
							}
							
							while(rowsextra>=1){
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								//3.1、页尾行的处理
								if(rowsextra==1){
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
	
									if(bodyconfig.pagesum=="true"){
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
									}
								//3.2、一般行的处理	
								}else{
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
								}
								rowsextra--;
							}
							$('.body table tbody tr').css("height",__config.body.rowheight+"cm");
						
						}else{
							var lastrows = Math.floor((__config.page.height - __config.header.height - __config.footer.height)/__config.body.rowheight);
							var rownum = Math.floor((__config.page.height - __config.header.height)/__config.body.rowheight);
							var pageextra = Math.ceil((num - lastrows)*__config.body.rowheight/(__config.page.height - __config.header.height));
							
							pages = pageextra + 1;
							totlapage = pages;
							
							//1、增加页数
							while(pages>0){
								var copydefault = $(".default").clone();
								copydefault.removeClass("default");
								copydefault.addClass("page0");
								copydefault.addClass("page"+pageindex);
								$("body").append(copydefault);
									
								//添加页码到.pagecode
								var code = pageindex+"/"+totlapage;
								$(".page"+pageindex+" .pagecode").text(code);
									
								//为每页加入打印分隔符	
								if(pages==1){
								}else{$(".page"+pageindex).css("page-break-after","always");}
									
								sum[pageindex] = [];							//定义元素数组
								
								//添加标题项
								$(".page"+pageindex+" .body").append("<table><thead><tr></tr></thead><tbody></tbody></table>");
								for(var i=0;i<item.length;i++){
									if(item[i].split(":").length==1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i]+"</td>");
									}else if(item[i].split(":").length>1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i].split(":")[0]+"</td>");
									}
									sum[pageindex][i] = 0.0;					//初始化元素数组元素
								}
								pageindex++;
								pages--;
							}
							
							//2、分页添加物品信息
							if(pageindex2 == pages){
								for(var i=0;i<data[0].rs[0].rows.length;i++){

									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%lastrows==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}else{
								for(var i=0;i<data[0].rs[0].rows.length;i++){

									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%rownum==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}

							//3、补充空行
							if((num-rownum*pageextra)%lastrows==0){
								var rowsextra = 0;
							}else{
								var rowsextra = (lastrows - (num-rownum*pageextra)%lastrows);
							}
							
							while(rowsextra>=1){
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								//3.1、页尾行的处理
								if(rowsextra==1){
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
	
									if(bodyconfig.pagesum=="true"){
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
									}
								//3.2、一般行的处理	
								}else{
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
								}
								rowsextra--;
							}
							$('.body table tbody tr').css("height",__config.body.rowheight+"cm");
						}
						
						$(".footer").css("display","none");
						$(".page"+pages+" .footer").css("display","block");
					}else if(__config.header.showmode=="top"&&__config.footer.showmode=="every"){
						if(__config.body.pagesum == "true"){
							var firstrows = Math.floor((__config.page.height - __config.header.height - __config.footer.height - __config.body.rowheight)/__config.body.rowheight);
							var rownum = Math.floor((__config.page.height - __config.footer.height - __config.body.rowheight)/__config.body.rowheight);
							var pageextra = Math.ceil((num - firstrows)*__config.body.rowheight/(__config.page.height - __config.footer.height - __config.body.rowheight));
							
							pages = pageextra + 1;
							totlapage = pages;
							
							//1、增加页数
							while(pages>0){
									var copydefault = $(".default").clone();
									copydefault.removeClass("default");
									copydefault.addClass("page0");
									copydefault.addClass("page"+pageindex);
									$("body").append(copydefault);
									
								//添加页码到.pagecode
								var code = pageindex+"/"+totlapage;
								$(".page"+pageindex+" .pagecode").text(code);
									
								//为每页加入打印分隔符	
								if(pages==1){
								}else{$(".page"+pageindex).css("page-break-after","always");}
									
								sum[pageindex] = [];							//定义元素数组
								
								//添加标题项
								$(".page"+pageindex+" .body").append("<table><thead><tr></tr></thead><tbody></tbody></table>");
								for(var i=0;i<item.length;i++){
									if(item[i].split(":").length==1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i]+"</td>");
									}else if(item[i].split(":").length>1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i].split(":")[0]+"</td>");
									}
									sum[pageindex][i] = 0.0;					//初始化元素数组元素
								}
								pageindex++;
								pages--;
								
								$(".page0 .header").css("display","none");
								$(".page1 .header").css("display","block");
							}
							
							//2、分页添加物品信息
							if(pageindex2 == 1){
								for(var i=0;i<data[0].rs[0].rows.length;i++){
								
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%firstrows==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
											
										//添加每页合计
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}else{
								for(var i=0;i<data[0].rs[0].rows.length;i++){
								
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%firstrows==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										//添加每页合计
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}
							
							//3、补充空行
							if((num-firstrows)%rownum==0){
								var rowsextra = 0;
							}else{
								var rowsextra = (rownum - (num-firstrows)%rownum);
							}
							
							while(rowsextra>=1){
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								//3.1、页尾行的处理
								if(rowsextra==1){
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
	
									if(bodyconfig.pagesum=="true"){
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
									}
								//3.2、一般行的处理	
								}else{
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
								}
								rowsextra--;
							}
							$('.body table tbody tr').css("height",__config.body.rowheight+"cm");
						}else{
							var firstrows = Math.floor((__config.page.height - __config.header.height - __config.footer.height)/__config.body.rowheight);
							var rownum = Math.floor((__config.page.height - __config.footer.height - __config.body.rowheight)/__config.body.rowheight);
							var pageextra = Math.ceil((num - firstrows)*__config.body.rowheight/(__config.page.height - __config.footer.height));
							
							pages = pageextra + 1;
							totlapage = pages;
							
							//1、增加页数
							while(pages>0){
								var copydefault = $(".default").clone();
								copydefault.removeClass("default");
								copydefault.addClass("page0");
								copydefault.addClass("page"+pageindex);
								$("body").append(copydefault);
									
								//添加页码到.pagecode
								var code = pageindex+"/"+totlapage;
								$(".page"+pageindex+" .pagecode").text(code);
									
								//为每页加入打印分隔符	
								if(pages==1){
								}else{$(".page"+pageindex).css("page-break-after","always");}
									
								sum[pageindex] = [];							//定义元素数组
								
								//添加标题项
								$(".page"+pageindex+" .body").append("<table><thead><tr></tr></thead><tbody></tbody></table>");
								for(var i=0;i<item.length;i++){
									if(item[i].split(":").length==1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i]+"</td>");
									}else if(item[i].split(":").length>1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i].split(":")[0]+"</td>");
									}
									sum[pageindex][i] = 0.0;					//初始化元素数组元素
								}
								pageindex++;
								pages--;
								
								$(".page0 .header").css("display","none");
								$(".page1 .header").css("display","block");
							}
							
							//2、分页添加物品信息
							if(pageindex2 == 1){
								for(var i=0;i<data[0].rs[0].rows.length;i++){
								
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%firstrows==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}else{
								for(var i=0;i<data[0].rs[0].rows.length;i++){
								
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%firstrows==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										//添加每页合计
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}
							
							//3、补充空行
							if((num-firstrows)%rownum==0){
								var rowsextra = 0;
							}else{
								var rowsextra = (rownum - (num-firstrows)%rownum);
							}
							
							while(rowsextra>=1){
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								//3.1、页尾行的处理
								if(rowsextra==1){
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
	
									if(bodyconfig.pagesum=="true"){
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
									}
								//3.2、一般行的处理	
								}else{
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
								}
								rowsextra--;
							}
							$('.body table tbody tr').css("height",__config.body.rowheight+"cm");
						}
						$(".header").css("display","none");
						$(".page1 .header").css("display","block");
					}else if(__config.header.showmode=="top"&&__config.footer.showmode=="bottom"){
						if(__config.body.pagesum == "true"){
							var firstrows = Math.floor((__config.page.height - __config.header.height - __config.body.rowheight)/__config.body.rowheight);
							var lastrows = Math.floor((__config.page.height - __config.footer.height - __config.body.rowheight)/__config.body.rowheight);
							var rownum = Math.floor((__config.page.height - __config.body.rowheight)/__config.body.rowheight);
							var pageextra = Math.ceil((num - firstrows - lastrows)*__config.body.rowheight/(__config.page.height - __config.body.rowheight));
							
							pages = pageextra + 2;
							totlapage = pages;
							
							//1、增加页数
							while(pages>0){
								var copydefault = $(".default").clone();
								copydefault.removeClass("default");
								copydefault.addClass("page0");
								copydefault.addClass("page"+pageindex);
								$("body").append(copydefault);
									
								//添加页码到.pagecode
								var code = pageindex+"/"+totlapage;
								$(".page"+pageindex+" .pagecode").text(code);
									
								//为每页加入打印分隔符	
								if(pages==1){
								}else{$(".page"+pageindex).css("page-break-after","always");}
									
								sum[pageindex] = [];							//定义元素数组
								
								//添加标题项
								$(".page"+pageindex+" .body").append("<table><thead><tr></tr></thead><tbody></tbody></table>");
								for(var i=0;i<item.length;i++){
									if(item[i].split(":").length==1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i]+"</td>");
									}else if(item[i].split(":").length>1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i].split(":")[0]+"</td>");
									}
									sum[pageindex][i] = 0.0;					//初始化元素数组元素
								}
								pageindex++;
								pages--;
								
								$(".page0 .header").css("display","none");
								$(".page1 .header").css("display","block");
							}
							
							//2、分页添加物品信息
							if(pageindex2 == 1){
								for(var i=0;i<data[0].rs[0].rows.length;i++){
								
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%firstrows==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										//添加每页合计
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}else if(pageindex2 == pages){
								for(var i=0;i<data[0].rs[0].rows.length;i++){
								
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%lastrows==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										//添加每页合计
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}else{
								for(var i=0;i<data[0].rs[0].rows.length;i++){
								
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%rownum==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										//添加每页合计
										$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
										
										for(var j=0;j<field.length;j++){
											if($.type(sum[pageindex2][j]) === "undefined"){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
											}else{
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}
							
							//3、补充空行
							if((num-firstrows-pageextra*rownum)%lastrows==0){
								var rowsextra = 0;
							}else{
								var rowsextra = lastrows-(num-firstrows-pageextra*rownum)%lastrows;
							}
							
							while(rowsextra>=1){
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								//3.1、页尾行的处理
								if(rowsextra==1){
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
	
									//添加每页合计
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									for(var j=0;j<field.length;j++){
										if($.type(sum[pageindex2][j]) === "undefined"){
											$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
										}else{
											$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+sum[pageindex2][j]+"</td>");
										}
									}
									
								//3.2、一般行的处理	
								}else{
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
								}
								rowsextra--;
							}
							$('.body table tbody tr').css("height",__config.body.rowheight+"cm");
						}else{
							var firstrows = Math.floor((__config.page.height - __config.header.height)/__config.body.rowheight);
							var lastrows = Math.floor((__config.page.height - __config.footer.height)/__config.body.rowheight);
							var rownum = Math.floor(__config.page.height/__config.body.rowheight);
							var pageextra = Math.ceil((num - firstrows - lastrows)*__config.body.rowheight/(__config.page.height - __config.body.rowheight));
							
							pages = pageextra + 2;
							totlapage = pages;
							
							//1、增加页数
							while(pages>0){
								var copydefault = $(".default").clone();
								copydefault.removeClass("default");
								copydefault.addClass("page0");
								copydefault.addClass("page"+pageindex);
								$("body").append(copydefault);
									
								//添加页码到.pagecode
								var code = pageindex+"/"+totlapage;
								$(".page"+pageindex+" .pagecode").text(code);
									
								//为每页加入打印分隔符	
								if(pages==1){
								}else{$(".page"+pageindex).css("page-break-after","always");}
									
								sum[pageindex] = [];							//定义元素数组
								
								//添加标题项
								$(".page"+pageindex+" .body").append("<table><thead><tr></tr></thead><tbody></tbody></table>");
								for(var i=0;i<item.length;i++){
									if(item[i].split(":").length==1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i]+"</td>");
									}else if(item[i].split(":").length>1){
										$(".page"+pageindex+" .body table thead tr").append("<td>"+item[i].split(":")[0]+"</td>");
									}
									sum[pageindex][i] = 0.0;					//初始化元素数组元素
								}
								pageindex++;
								pages--;
								
								$(".page0 .header").css("display","none");
								$(".page1 .header").css("display","block");
							}
							
							//2、分页添加物品信息
							if(pageindex2 == 1){
								for(var i=0;i<data[0].rs[0].rows.length;i++){
								
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%firstrows==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}else if(pageindex2 == pages){
								for(var i=0;i<data[0].rs[0].rows.length;i++){
								
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%lastrows==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}else{
								for(var i=0;i<data[0].rs[0].rows.length;i++){
								
									$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
									
									//2.1、页尾行的处理
									if(rowindex%rownum==0){		
										for(var j=0;j<field.length;j++){
											var items = item[j];	//标题
											var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
											
											//有子行的列（不加总）
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										
										rowindex++;
										pageindex2++;
										
									//2.2、一般行的处理	
									}else{									
				 						for(var j=0;j<field.length;j++){
				 							var items = item[j];	//标题
				 							var fields = field[j];  //数据
											var commodityinfo = data[0].rs[0].rows[i];
												
											//有子行的列（不加总）	
											if(fields.split(":").length > 1){
												$(".page"+pageindex2+" .body tbody tr").last().append("<td><ul></ul></td>");
												for(var k=0;k<fields.split(":")[1].split("、").length;k++){
													var fieldS = fields.split(":")[1].split("、")[k];
													var itemS = items.split(":")[1].split("、")[k];
		
													var info = eval('commodityinfo.'+fieldS);
													$(".page"+pageindex2+" .body tbody tr td ul").last().append("<li>"+itemS+":"+info+"</li>");
												}
												sum[pageindex2][j] = "";
											//没有子行的列（按条件加总）	
											}else if(fields.split(":").length == 1){
												var info = eval('commodityinfo.'+fields);
												$(".page"+pageindex2+" .body tbody tr").last().append("<td>"+info+"</td>");
												
												//数字会加总，文字不会加总
												if(isNaN(parseFloat(info))){
													sum[pageindex2][j] = "";
												}else{
													sum[pageindex2][j] += parseFloat(info);
												}
											}
										}
										rowindex++;
									}
								}
							}
							
							//3、补充空行
							if((num-firstrows-pageextra*rownum)%lastrows==0){
								var rowsextra = 0;
							}else{
								var rowsextra = lastrows-(num-firstrows-pageextra*rownum)%lastrows;
							}
							
							while(rowsextra>=1){
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								//3.1、页尾行的处理
								if(rowsextra==1){
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
								//3.2、一般行的处理	
								}else{
									for(var i=0;i<field.length;i++){
										$(".page"+pageindex2+" .body tbody tr").last().append("<td>&nbsp</td>");
									}
								}
								rowsextra--;
							}
							$('.body table tbody tr').css("height",__config.body.rowheight+"cm");
						}
						
						$(".header").css("display","none");
						$(".footer").css("display","none");
						$(".page1 .header").css("display","block");
						$(".page"+pages+" .footer").css("display","block");
					}
				}
			})
		}
		
		//暂时不用
		function orders1(orderid){
			var vml =
		 '[{"namespace":"protocol","cmd":"data","version":1,"id":"'+headerconfig.id+'","paras":[{"name":"id","value":"' + orderid + '"}]}]';
			
			NSF.System.Network.Ajax('/Portal.aspx',
				vml,
				'POST',
				false,
				function(result, data) {
					if(result) {
						$(".header").append("<table><tr></tr></table>");
						var item = headerconfig.item.slice(1,-1).split(",");
						var field = headerconfig.field.slice(1,-1).split(",");
						var orderinfo = data[0].rs[0].rows[0];
						
						for(var i=0;i<item.length;i++){
							$(".header table tr").append("<td></td>");
							var iteM = item[i].split("、");
							var fielD = field[i].split("、");
							
							$(".header table tr td").append("<ul></ul>");
							for(var j=0;j<iteM.length;j++){
								var info = eval('orderinfo.'+fielD[j]);
								$(".header table tr td ul").last().append("<li>"+iteM[j]+":"+info+"</li>");
							}
						}
					}
				})
		}
		//暂时不用
		function orders2(orderid){
			var vml =
		 '[{"namespace":"protocol","cmd":"data","version":1,"id":"'+footerconfig.id+'","paras":[{"name":"id","value":"' + orderid + '"}]}]';
			
			NSF.System.Network.Ajax('/Portal.aspx',
				vml,
				'POST',
				false,
				function(result, data) {
					if(result) {
						$(".footer").append("<table><tr></tr></table>");
						var item = footerconfig.item.slice(1,-1).split(",");
						var field = footerconfig.field.slice(1,-1).split(",");
						var orderinfo = data[0].rs[0].rows[0];
						
						for(var i=0;i<item.length;i++){
							$(".footer table tr").append("<td></td>");
							var iteM = item[i].split("、");
							var fielD = field[i].split("、");
							
							$(".header table tr td").append("<ul></ul>");
							for(var j=0;j<iteM.length;j++){
								var info = eval('orderinfo.'+fielD[j]);
								$(".header table tr td ul").last().append("<li>"+iteM[j]+":"+info+"</li>");
							}
						}
					}
				})
		}
		
		var _orderid = NSF.UrlVars.Get('id', location.href);
		
		var headerconfig = __config.header;
		var bodyconfig = __config.body;
		var footerconfig = __config.footer;
		var pageconfig = __config.page;
		
		$(".default").css("height",pageconfig.page+"cm");
		$(".page0").css("height",pageconfig.page+"cm");
		$(".header").css("height",headerconfig.height+"cm");
		$(".footer").css("height",footerconfig.height+"cm");
		
		goods(_orderid);
	</script>
</html>