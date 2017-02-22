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
			font-size: 8px;
			color: rgb(77,77,77);
			font-family: "宋体";
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
		.logo{
			width: 190px;
			height: 75px;
		}
		.logo img{
			width: 190px;
			height: 75px;
		}
		/*.company{
			width:220px;
			height: 60px;
		}
		.company img{
			width:220px;
			height: 60px;
		}*/
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
		.commodity table tbody tr td{
			border-bottom: 1px solid rgb(179,179,179);
			height: 52px;
		}
		.top{
			width: 100%;
			position: absolute;top: 0;	
		}
		.commodity{
			width: 100%;
			position: absolute;top:180px;
		}
		.information{
			width: 100%;
			position: absolute;top: 730px;left: 0;
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
			position: absolute;bottom: 50px;left: 0;
		}
		.attention table tr td:nth-child(2){
			font-size: 5px;
		}
		.signature{
			width: 100%;
			position: absolute;bottom: 20px;left: 0;
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
			position:absolute;bottom: 0;left: 0;
			text-align: center;
		}

	</style>
	<body onload="getdate()">
		<div class="DefalutOrder">
			
			<div class="top">
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
		 	
		 	<div class="commodity">
		 		<table class="commoditytable">
		 			<thead>
		 			<tr>
		 				<td class="title">物品编号</td>
		 				<td class="title" colspan="2">物品参数</td>
		 				<td class="title">总重量（公斤）</td>
		 				<td class="title">总体积（立方米）</td>
		 				<td class="title">物品数量</td>
		 			</tr>
		 			</thead>
		 			<tbody>
		 			</tbody>
		 		</table>
		 	</div>		
		 	
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
		 				<td width="10%" >
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
		 	
			<div class="pagecode"></div>
		</div>
	</body>
	<script>
		function orders(_orderid){
			var vml =
		 '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0027","paras":[{"name":"id","value":"' + _orderid + '"}]}]';
			
			NSF.System.Network.Ajax('/Portal.aspx',
				vml,
				'POST',
				false,
				function(result, data) {
					if(result) {
						$(".company").text(data[0].rs[0].rows[0].CreatorCompanyName);
						//发货方 收货方
						$(".fromname").text(data[0].rs[0].rows[0].Name);
						$(".toname").text(data[0].rs[0].rows[0].EndUserName);
						
						//合同编号
						$(".pactcode").text(data[0].rs[0].rows[0].PactCode);
						//发货地址
	 					$(".fromaddress").text(data[0].rs[0].rows[0].FromProvince+data[0].rs[0].rows[0].FromCity+data[0].rs[0].rows[0].FromDistrict+data[0].rs[0].rows[0].From);
	 					//到货地址
	 					$(".toaddress").text(data[0].rs[0].rows[0].ToProvince+data[0].rs[0].rows[0].ToCity+data[0].rs[0].rows[0].ToDistrict+data[0].rs[0].rows[0].To);
	 					//重量补差
	 					$(".weightaddition").text(data[0].rs[0].rows[0].WeightAddition);
	 					//体积补差
	 					$(".volumeaddition").text(data[0].rs[0].rows[0].VolumeAddition);
	 					//承运方大标题
	 					$('div.companyName').text(data[0].rs[0].rows[0].CreatorCompanyName);
	 					//发货方姓名
	 					$(".fromname").text(data[0].rs[0].rows[0].Name);
	 					//到货方姓名
	 					$(".toname").text(data[0].rs[0].rows[0].EndUserName);
	 					//计费模式
	 					if(data[0].rs[0].rows[0].ChargeMode==1){
	 						$(".chargemode").text("重量");
	 					}else if(data[0].rs[0].rows[0].ChargeMode==2){
	 						$(".chargemode").text("体积");
						}else if(data[0].rs[0].rows[0].ChargeMode==3){
	 						$(".chargemode").text("数量");
						}
						//发货时间
						$(".fromtime").text(data[0].rs[0].rows[0].FromTime);
						//到货时间
						$(".totime").text(data[0].rs[0].rows[0].ToTime);
						//价格单位
						if(data[0].rs[0].rows[0].PriceUnit==1){
							$(".unit").text("公斤");
						}else if(data[0].rs[0].rows[0].PriceUnit==2){
							$(".unit").text("吨");
						}else if(data[0].rs[0].rows[0].PriceUnit==3){
							$(".unit").text("立方米");
						}else if(data[0].rs[0].rows[0].PriceUnit==4){
							$(".unit").text("升");
						}else if(data[0].rs[0].rows[0].PriceUnit==5){
							$(".unit").text("个");
						}else if(data[0].rs[0].rows[0].PriceUnit==6){
							$(".unit").text("托");
						}else if(data[0].rs[0].rows[0].PriceUnit==7){
							$(".unit").text("台");
						}else if(data[0].rs[0].rows[0].PriceUnit==8){
							$(".unit").text("箱");
						}else if(data[0].rs[0].rows[0].PriceUnit==9){
							$(".unit").text("包");
						}else if(data[0].rs[0].rows[0].PriceUnit==10){
							$(".unit").text("捆");
						}else if(data[0].rs[0].rows[0].PriceUnit==11){
							$(".unit").text("辆");
						}else if(data[0].rs[0].rows[0].PriceUnit==12){
							$(".unit").text("件");
						}else if(data[0].rs[0].rows[0].PriceUnit==13){
							$(".unit").text("袋");
						}else if(data[0].rs[0].rows[0].PriceUnit==14){
							$(".unit").text("架");
						}else if(data[0].rs[0].rows[0].PriceUnit==15){
							$(".unit").text("盒");
						}else if(data[0].rs[0].rows[0].PriceUnit==16){
							$(".unit").text("桶");
						}else if(data[0].rs[0].rows[0].PriceUnit==17){
							$(".unit").text("其他");
						}
						//是否取货
						if(data[0].rs[0].rows[0].IsPick==0){
							$(".pick").text("");
						}else if(data[0].rs[0].rows[0].IsPick==1){
							$(".pick").text("取货 ");
						}
						//是否送货
						if(data[0].rs[0].rows[0].IsDelivery==0){
							$(".delivery").text("");
						}else if(data[0].rs[0].rows[0].IsDelivery==1){
							$(".delivery").text("送货 ");
						}
						//是否装货
						if(data[0].rs[0].rows[0].IsOnLoad==0){
							$(".onload").text("");
						}else if(data[0].rs[0].rows[0].IsOnLoad==1){
							$(".onload").text("装货 ");
						}
						//是否卸货
						if(data[0].rs[0].rows[0].IsOffLoad==0){
							$(".offload").text("");
						}else if(data[0].rs[0].rows[0].IsOffLoad==1){
							$(".offload").text("卸货");
						}						
						//运输模式
						if(data[0].rs[0].rows[0].TransportMode==1){
							$(".transportmode").text("零担");
						}else if(data[0].rs[0].rows[0].TransportMode==2){
							$(".transportmode").text("整车");
						}else if(data[0].rs[0].rows[0].TransportMode==3){
							$(".transportmode").text("空运");
						}else if(data[0].rs[0].rows[0].TransportMode==4){
							$(".transportmode").text("快递");
						}else if(data[0].rs[0].rows[0].TransportMode==5){
							$(".transportmode").text("铁路");
						}else if(data[0].rs[0].rows[0].TransportMode==6){
							$(".transportmode").text("海运");
						}
						//货物分类
						if(data[0].rs[0].rows[0].GoodsCategory==1){
							$(".category").text("普通货物");
						}else if(data[0].rs[0].rows[0].GoodsCategory==2){
							$(".category").text("危险品");
						}else if(data[0].rs[0].rows[0].GoodsCategory==3){
							$(".category").text("普通货物&危险品");
						}else if(data[0].rs[0].rows[0].GoodsCategory==4){
							$(".category").text("温控货物");
						}else if(data[0].rs[0].rows[0].GoodsCategory==5){
							$(".category").text("");
						}else if(data[0].rs[0].rows[0].GoodsCategory==6){
							$(".category").text("危险品&温控货物");
						}else if(data[0].rs[0].rows[0].GoodsCategory==7){
							$(".category").text("普通货物&危险品&温控货物");
						}
						//发货方联系电话
						$(".fromcontact").text(data[0].rs[0].rows[0].FromContact);
						//到货方联系电话
						$(".tocontact").text(data[0].rs[0].rows[0].ToContact);
						//包装方式
						if(data[0].rs[0].rows[0].PackageMode){
							$(".package").text("散箱");
						}else if(data[0].rs[0].rows[0].PackageMode){
							$(".package").text("托盘或木箱");
						}else if(data[0].rs[0].rows[0].PackageMode){
							$(".package").text("托盘、木箱或不规则形状");
						}
	 					//订单编号
	 					$(".code").text(data[0].rs[0].rows[0].Code);
	 					//创建时间
	 					$(".creattime").text(data[0].rs[0].rows[0].CreateTime);
	 					//运输方式
	 					if(data[0].rs[0].rows[0].ShipMode==1){
	 						$(".shipmethod").text("市内");
	 					}else if(data[0].rs[0].rows[0].ShipMode==2){
	 						$(".shipmethod").text("长途");
	 					}
	 					//是否保价
	 					if(data[0].rs[0].rows[0].IsInsurance==0){
	 						$(".insurance").text("否");
	 					}else if(data[0].rs[0].rows[0].IsInsurance==1){
	 						$(".insurance").text("是");
	 					}
	 					//重量补差
	 					$(".WeiAdd").text(data[0].rs[0].rows.WeightAddition);
	 					//体积补差
						$(".VolAdd").text(data[0].rs[0].rows.VolumeAddition);
	 					//客户标记
	 					$(".symbol").text(data[0].rs[0].rows[0].CustomerSymbolName);
	 					//承运方名称
	 					$(".suppliername").text(data[0].rs[0].rows[0].SupplierName);
	 					//承运方联系人
	 					$(".suppliercontactor").text(data[0].rs[0].rows[0].SupplierContact);
	 					//承运方联系电话
	 					$(".suppliertel").text(data[0].rs[0].rows[0].SupplierPhone);
	 					//重量补差值
	 					$(".WeiAdd").text(data[0].rs[0].rows[0].WeightAddition);
	 					//体积补差值
	 					$(".VolAdd").text(data[0].rs[0].rows[0].VolumeAddition);
	 					//总重量
	 					$(".weightsum").text( style_add(parseFloat($(".weightsum").text()),parseFloat($(".weightaddition").text())).toFixed(4));
	 					//总体积
	 					$(".volumesum").text( style_add(parseFloat($(".volumesum").text()),parseFloat($(".volumeaddition").text())).toFixed(6));
						//备注
						$(".description").text(data[0].rs[0].rows[0].Descriptions);
						
	 					//总重量
	 					$(".weightsum").text(data[0].rs[0].rows[0].TotalWeight);
	 					//总体积
	 					$(".volumesum").text(data[0].rs[0].rows[0].TotalVolume);
	 					//总数量
	 					$(".qtysum").text(data[0].rs[0].rows[0].TotalAmount);
					}
				})
		}
		
		function goods(_orderid){
			var vml =
		 '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0030","paras":[{"name":"did","value":"' + _orderid + '"}]}]';
			
			NSF.System.Network.Ajax('/Portal.aspx',
				vml,
				'POST',
				false,
				function(result, data) {
					if(result) {
						
						var weight=0;
						var volume=0;
						var qty=0;
						var num = data[0].rs[0].rows.length;
						var pages = 0;
						var pageindex = 1;
						var pageindex2 = 1;
						var rowindex = 1;
	 					
	 					pages = Math.ceil(num/8);
	 					var totlapage = pages;
	 					
	 					while(pages>0){
	 						var copyorder = $(".DefalutOrder").clone();
	 						copyorder.removeClass("DefalutOrder");
	 						copyorder.addClass("orders");
	 						copyorder.addClass("order"+pageindex);
	 						$("body").append(copyorder);
	 						$(".order"+pageindex+" .pagecode").text(pageindex+"/"+totlapage);
	 						
	 						if(pages==1){
	 							
	 						}else{
	 							$(".order"+pageindex).css("page-break-after","always");
	 						}
	 						
	 						pageindex++;
	 						pages--;
	 					}
	 					
	 					//添加物品信息
	 					for(var i=0;i<data[0].rs[0].rows.length;i++){
	 						if(rowindex%8==0){
	 							$(".order"+pageindex2+" .commoditytable tbody").eq(0).append("<tr><td>"+data[0].rs[0].rows[i].GoodsID+"</td><td colspan='2'><ul><li>物品名称:"+data[0].rs[0].rows[i].Name+"</li><li>物品规格:"+data[0].rs[0].rows[i].SPC+"</li><li>物品批次:"+data[0].rs[0].rows[i].BatchNo+"</li></ul></td><td>"+data[0].rs[0].rows[i].Weight+"</td><td>"+data[0].rs[0].rows[i].volume+"</td><td>"+data[0].rs[0].rows[i].Qty+"</td>");
	 							$(".order"+pageindex2+" .commoditytable tbody").eq(0).append("<tr><td>本页小计</td><td></td><td></td><td><span class='WeiSum'></span></td><td><span class='VolSum'></span></td><td><span class='QtySum'></span></td>");
 								$(".order"+pageindex2+" .commoditytable tbody").eq(0).append("<tr> <td><ul><li>补差</li><li>总计</li></ul></td> <td></td><td></td> <td><ul><li><span class='WeiAdd'></span><li><li><span class='weightsum'></span></li></ul></td> <td><ul><li><span class='VolAdd'></span></li><li><span class='volumesum'></span></li></ul></td> <td><ul><li>&nbsp</li><li><span class='qtysum'></span></li></ul></td>");
	 							rowindex++;
	 							pageindex2++;
	 						}else{
	 							$(".order"+pageindex2+" .commoditytable tbody").eq(0).append("<tr><td>"+data[0].rs[0].rows[i].GoodsID+"</td><td colspan='2'><ul><li>物品名称:"+data[0].rs[0].rows[i].Name+"</li><li>物品规格:"+data[0].rs[0].rows[i].SPC+"</li><li>物品批次:"+data[0].rs[0].rows[i].BatchNo+"</li></ul></td><td>"+data[0].rs[0].rows[i].Weight+"</td><td>"+data[0].rs[0].rows[i].volume+"</td><td>"+data[0].rs[0].rows[i].Qty+"</td>");
	 							rowindex++;
	 						}
						}
	 					
	 					//补充空行
	 					if(num%8==0){
	 						var rowsextra = 0;
	 					}else{
	 						var rowsextra = (8 - num%8);
	 					}
	 					
	 					while(rowsextra>=1){
	 						if(rowsextra==1){
	 							$(".order"+totlapage+" .commoditytable tbody").append("<tr><td></td><td colspan='2'><ul><li></li><li></li><li></li></ul></td><td></td><td></td><td></td>");
	 							$(".order"+totlapage+" .commoditytable tbody").append("<tr><td>本页小计</td><td></td><td></td><td><span class='WeiSum'></span></td><td><span class='VolSum'></span></td><td><span class='QtySum'></span></td>");
 								$(".order"+totlapage+" .commoditytable tbody").eq(0).append("<tr> <td><ul><li>补差</li><li>总计</li></ul></td> <td></td><td></td> <td><ul><li><span class='WeiAdd'></span><li><li><span class='weightsum'></span></li></ul></td> <td><ul><li><span class='VolAdd'></span></li><li><span class='volumesum'></span></li></ul></td> <td><ul><li>&nbsp</li><li><span class='qtysum'></span></li></ul></td>");
	 						}else{
	 							$(".order"+totlapage+" .commoditytable tbody").append("<tr><td></td><td colspan='2'><ul><li></li><li></li><li></li></ul></td><td></td><td></td><td></td>");
	 						}
	 						rowsextra--;
	 					}
	 					
 						//重量数量的分页总计
	 					while(pageindex2 >= 1){
	 						var weightsum = 0;
	 						var volumesum = 0;
	 						var qtysum = 0;
	 						var ArrWei = [];
	 						var ArrVol = [];
	 						var ArrQty = [];
	 						
	 						for(var i=0;i<8;i++){
	 							if($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(3)").eq(i).text()==""){
	 								
	 							}else{
	 								weightsum += parseFloat($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(3)").eq(i).text());
	 							}
	 							
	 							if($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(4)").eq(i).text()==""){
	 								
	 							}else{
	 								volumesum += parseFloat($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(4)").eq(i).text());
	 							}
	 							
	 							if($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(5)").eq(i).text()==""){
	 								
	 							}else{
	 								qtysum += parseFloat($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(5)").eq(i).text());
	 							}
	 						}
	 						
	 						$(".order"+pageindex2+" .commodity .commoditytable tbody .WeiSum").text(weightsum.toFixed(4));
	 						$(".order"+pageindex2+" .commodity .commoditytable tbody .VolSum").text(volumesum.toFixed(6));
	 						$(".order"+pageindex2+" .commodity .commoditytable tbody .QtySum").text(qtysum);
	 						
	 						pageindex2--;
	 						
	 					}
					}
				})
		}
		
		function getdate(){
			var Dates = new Date();
			var year = Dates.getFullYear();
			var mounth = Dates.getMonth()+1;
			var day = Dates.getDate();
			var printdate = year+"/"+mounth+"/"+day;
			$(".date").text(printdate);
			
			var _orderid = NSF.UrlVars.Get('id', location.href);
			var _code = NSF.UrlVars.Get('code', location.href);

			if (_code == 'TransOrder') {
				$('div.codeTitle').text('（运输单）');
			}
			
			goods(_orderid);
			orders(_orderid);
			
			window.print();
			window.history.back(-1); 
		}   
		//浮点数计算  加减乘除   方法 
		function style_add(a, b) { // 加
			var c, d, e;
			try {
				c = a.toString().split(".")[1].length;
			} catch(f) {
				c = 0;
			}
			try {
				d = b.toString().split(".")[1].length;
			} catch(f) {
				d = 0;
			}
			return e = Math.pow(10, Math.max(c, d)), (style_mul(a, e) + style_mul(b, e)) / e;
		}
		
		function style_sub(a, b) { //减
			var c, d, e;
			try {
				c = a.toString().split(".")[1].length;
			} catch(f) {
				c = 0;
			}
			try {
				d = b.toString().split(".")[1].length;
			} catch(f) {
				d = 0;
			}
			return e = Math.pow(10, Math.max(c, d)), (style_mul(a, e) - style_mul(b, e)) / e;
		}
		
		function style_mul(a, b) { //乘
			var c = 0,
				d = a.toString(),
				e = b.toString();
			try {
				c += d.split(".")[1].length;
			} catch(f) {}
			try {
				c += e.split(".")[1].length;
			} catch(f) {}
			return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
		}
		
		function style_div(a, b) { //除
			var c, d, e = 0,
				f = 0;
			try {
				e = a.toString().split(".")[1].length;
			} catch(g) {}
			try {
				f = b.toString().split(".")[1].length;
			} catch(g) {}
			return c = Number(a.toString().replace(".", "")), d = Number(b.toString().replace(".", "")), style_mul(c / d, Math.pow(10, f - e));
		}
	</script>
</html>