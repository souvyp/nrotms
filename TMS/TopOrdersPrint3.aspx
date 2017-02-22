<!DOCTYPE html>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>客户送货单-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
	<script src="/assets/js/jquery-1.11.1.min.js"></script>
	<script src="/assets/NSF/js/NSF.0.0.4.min.js"></script>
	<script src="/assets/NSF/js/NSF.System.Data.js"></script>
	<head>
		<title>客户送货单</title>
		<style>
			body{
				font-size: 10pt;
				font-family: "Arial";
			}
			table{
				width: 22.5cm;
			}
			h1{
				text-align: center;
			}
			.toporder{
				width: 60%;
				padding-top: 10px;
				display: none;
			}
			.pageno{
				font-size: 20px;
				float: right;
				font-family: "Arial";
			}
			.title0{
				font-size: 28px;
				float: left;
				display: inline-block;
				margin-left: 7.8cm;
			}
			.signature0 tr td{
				text-align: center;
				width: 20%;
			}
			.signature0 tr:nth-child(2) td{
				text-align: center;
				width: 20%;
				height: 15px;
			}
			.signature0 tr:nth-child(2) td p{
				height: 15px;
				width: 60%;
				border-bottom: 1px solid black;
				margin-left: 20%;
			}
			.pagefoot{
				width: 22.5cm;
				text-align: center;
				margin-top: 5px;
				page-break-after:right;
			}
			.goodsinfo{
				border-collapse: collapse;
			}
			.goodsinfo thead tr td{
				border-bottom: 1px solid black;
			}
			.goodsinfo tr td{
				text-align: center;
			}
			.goodsinfo tr td:nth-child(2){
				text-align: left;
			}
			.goodsinfo tr td:nth-child(6){
				text-align: left;
			}
			tr{
				height: 20px;
				line-height: 20px;
			}
			td{
				table-layout: fixed;
			}
		</style>
	</head>
	
	<body onload="search()">
		<div class="toporder">
	 		<table>
	 		<thead>
	 			<tr>
	 				<td colspan="2"><span class="title0">TOP脱普企业集团</span><span class="pageno"></span></td>
	 			</tr>
	 		</thead>
	 		
	 		<tbody>
	 			<tr>
	 				<td colspan="2">发货单位：<span class="fromcompany"></span></td>
	 			</tr>
	 			<tr>
	 				<td colspan="2">原因单据：<span class="documentreason"></span></td>
	 			</tr>
	 			<tr>
	 				<td style="width: 60%;">本单编号：<span class="pactcode"></span></td>
	 				<td>单据有效期：<span class="documentsvalidity"></span></td>
	 			</tr>
	 			<tr>
	 				<td style="width:60%;">单据种类：<span class="documentcategory"></span></td>
	 				<td>填单日期：<span class="fillingdates"></span></td>
	 			</tr>
	 		</tbody>	
	 	</table>
	 	
	 		<table style="border-top:1px solid black;">
 			<tr>
 				<td colspan="6" style="width: 43%;">客户代号：<span class="customercode"></span></td>
 				<td colspan="8" style="width: 57%">客户名称：<span class="customername"></span></td>
 			</tr>
 			<tr>
 				<td colspan="8" style="width: 57%;">收货地址：<span class="recipientaddress"></span></td>
 				<td colspan="3" style="width: 21.5%">联系人：<span class="recipientcontactor"></span></td>
 				<td colspan="3" style="width: 21.5%">联系电话：<span class="recipienttel"></span></td>
 			</tr>
	 	</table>
	 	
			<table class="goodsinfo">
 			<thead>
 				<tr>
	 				<td style="width: 43px;">序号</td>
	 				<td style="width: 170px;text-align: left;">简称/中文名称</td>
	 				<td style="width: 47px;">入箱数</td>
	 				<td style="width: 32px;">货号</td>
	 				<td style="width: 42px;">数量</td>
	 				<td style="width: 93px;text-align: left;">单位/条形码</td>
	 				<td style="width: 50px;">收货量</td>
	 				<td style="width: 65px;">未税单价</td>
	 				<td style="width: 65px;">未税金额</td>
	 				<td style="width: 48px;">税额</td>
	 				<td style="width: 65px;">含税金额</td>
	 				<td style="width: 60px;">备注</td>
 				</tr>
 			</thead>
 			
 			<tbody>

 			</tbody>
		</table>
		
			<table class="totalcost">
			<tr>
				<td style="width: 213px;" colspan="2">送货金额（本页小计）</td>
 				<td style="width: 47px;"></td>
 				<td style="width: 32px;"></td>
 				<td style="width: 42px;"><span class="totlamount"></span></td>
 				<td style="width: 93px;text-align: left;">件</td>
 				<td style="width: 50px;"></td>
 				<td style="width: 65px;"></td>
 				<td style="width: 65px;"></td>
 				<td style="width: 48px;"></td>
 				<td style="width: 65px;"></td>
 				<td style="width: 60px;"></td>
			</tr>
			<tr>
				<td colspan="2">送货金额（总计）</td>
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
			<tr>
				<td colspan="2">折扣</td>
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
			<tr>
				<td style="width: 213px;" colspan="2">发票金额</td>
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
			<tr>
				<td colspan="4">送货总件数：<span class="Totlamount"></span>件</td>
 				<td colspan="4">总体积：<span class="Totlavolume"></span>立方米</td>
 				<td colspan="4">总重量：<span class="Totlaweight"></span>公斤</td>
			</tr>
		</table>
		
			<table style="border-top: 1px solid black;border-bottom: 1px solid black;">
			<tr>
				<td colspan="4">备注：（客户签收时，请注意各项收货数量，如不注明，视为默认收货数量等于送货数量。）<span class="ordercomments"></span></td>
			</tr>
			<tr>
				<td colspan="4">&nbsp</td>
			</tr>
			<tr>
				<td style="width: 40%;">运输公司名称：<span class="suppliercompany"></span></td>
				<td style="width: 20%;">运输公司车号：<span class="suppliercarid"></span></td>
				<td style="width: 20%;">车型：<span class="suppliercarcategory"></span><span></span></td>
				<td style="width: 20%;">承运人：<span class="supplier"></span></td>
			</tr>
		</table>
		
			<table class="signature0">
			<tr><td>发货核准</td><td>复核</td><td>发货经办</td><td>制单</td><td>客户签收</td></tr>
			<tr>
				<td><p></p></td>
				<td><p></p></td>
				<td><p></p></td>
				<td><p></p></td>
				<td><p></p></td>
			</tr>
		</table>
		
			<p class="pagefoot">共五联	第一联:签收联(白) 第二联:客户联(红) 第三联:财务联(黄) 第四联:统计联(绿) 第五联:仓库联(蓝)</p>
		</div>
	
	</body>
</html>
<script>
	function search(){
		var orderid = NSF.UrlVars.Get('orderid', location.href);
		var vml =
	 '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0223","paras":[{"name":"id","value":"' +orderid+ '"}]}]';
		
		NSF.System.Network.Ajax('/Portal.aspx',
			vml,
			'POST',
			false,
			function(result, data) {
				if(result) {
					var pages = Math.ceil(data[0].rs[1].rows.length/13);
					var tables = Math.ceil(data[0].rs[1].rows.length/13);
					var pagen = 1;
					
					while(tables>0){
						var tablecopy = $(".toporder").clone();
						tablecopy.removeClass("toporder");
						tablecopy.addClass("order"+tables);
						$("body").append(tablecopy);
						$(".order"+tables+" .pageno").text("PAGE:"+pagen+"/"+pages);
						
						if(pagen==pages){
							var amount = 0;
							var num = 1;
							for(var i = (pagen-1)*13;i<data[0].rs[1].rows.length;i++){
								$(".order"+tables+" .goodsinfo tbody").append("<tr><td>"+"</td><td>"
																   +data[0].rs[1].rows[i].Name+"</td><td>"
																   +data[0].rs[1].rows[i].BoxNo+"</td><td>"
															   	   +data[0].rs[1].rows[i].BatchNo+"</td><td>"
													   			   +data[0].rs[1].rows[i].Qty+"</td><td>"
												   				   +data[0].rs[1].rows[i].BarCode+"</td><td>"
															   	   +data[0].rs[1].rows[i].ReceiptQty+"</td><td>"
													   			   +"</td><td>"
													   			   +"</td><td>"
													   			   +"</td><td>"
																   +data[0].rs[1].rows[i].Comments+"</td></tr><tr><td>"
																   +"</td><td>"
																   //换行
																   +"</td><td>"
																   +"</td><td>"
															   	   +"</td><td>"
													   			   +"</td><td>"
													   			   +data[0].rs[1].rows[i].UnitName+"</td><td>"
												   				   +"</td><td>"
															   	   +"</td><td>"
													   			   +"</td><td>"
													   			   +"</td><td>"
													   			   +"</td><td>"
																   +"</td></tr>"
								)
								amount = style_add(amount,data[0].rs[1].rows[i].Qty);
								num++;
							}
							
							while(num<=13){
								$(".order"+tables+" .goodsinfo tbody").append("<tr><td colspan='12'></td></tr><tr><td colspan='12'></td></tr>")
								num++;
							}
							
							$(".order"+tables+" .totalcost .totlamount").text(amount);
							
						}else{
							var amount = 0;
							for(var i=(pagen-1)*13;i<pagen*13;i++){
									$(".order"+tables+" .goodsinfo tbody").append("<tr><td>"+"</td><td>"
																   +data[0].rs[1].rows[i].Name+"</td><td>"
																   +data[0].rs[1].rows[i].BoxNo+"</td><td>"
															   	   +data[0].rs[1].rows[i].BatchNo+"</td><td>"
													   			   +data[0].rs[1].rows[i].Qty+"</td><td>"
												   				   +data[0].rs[1].rows[i].BarCode+"</td><td>"
															   	   +data[0].rs[1].rows[i].ReceiptQty+"</td><td>"
													   			   +"</td><td>"
													   			   +"</td><td>"
													   			   +"</td><td>"
																   +data[0].rs[1].rows[i].Comments+"</td></tr><tr><td>"
																   +"</td><td>"
																   //换行
																   +"</td><td>"
																   +"</td><td>"
															   	   +"</td><td>"
													   			   +"</td><td>"
													   			   +data[0].rs[1].rows[i].UnitName+"</td><td>"
												   				   +"</td><td>"
															   	   +"</td><td>"
													   			   +"</td><td>"
													   			   +"</td><td>"
													   			   +"</td><td>"
																   +"</td></tr>"
									)
									amount = style_add(amount,data[0].rs[1].rows[i].Qty);
								}
							
							$(".order"+tables+" .totalcost .totlamount").text(amount);
						}
						
						pagen++;
						tables--;
					}
					//1
					$(".fromcompany").text();
					$(".documentreason").text();
					$(".pactcode").text(data[0].rs[0].rows[0].PactCode);
					$(".documentsvalidity").text();
					$(".documentcategory").text();
					$(".fillingdates").text(data[0].rs[0].rows[0].StatusTime);
					//2
					$(".customercode").text(data[0].rs[0].rows[0].ClientCode);
					$(".customername").text(data[0].rs[0].rows[0].EndUserName);
					$(".recipientaddress").text(data[0].rs[0].rows[0].To);
					$(".recipientcontactor").text(data[0].rs[0].rows[0].EndContact);
					$(".recipienttel").text(data[0].rs[0].rows[0].ToContact);
					//3
//					var num = 1;
//					for(var i=0;i<data[0].rs[1].rows.length;i++){
//						$(".goodsinfo tbody").append("<tr><td>"+"</td><td>"
//															   +data[0].rs[1].rows[i].Name+"</td><td>"
//															   +data[0].rs[1].rows[i].BoxNo+"</td><td>"
//														   	   +data[0].rs[1].rows[i].BatchNo+"</td><td>"
//												   			   +data[0].rs[1].rows[i].Qty+"</td><td>"
//											   				   +data[0].rs[1].rows[i].BarCode+"</td><td>"
//														   	   +data[0].rs[1].rows[i].ReceiptQty+"</td><td>"
//												   			   +"</td><td>"
//												   			   +"</td><td>"
//												   			   +"</td><td>"
//															   +data[0].rs[1].rows[i].Comments+"</td></tr><tr><td>"
//															   +"</td><td>"
//															   
//															   +data[0].rs[1].rows[i].Name+"</td><td>"
//															   +"</td><td>"
//														   	   +"</td><td>"
//												   			   +"</td><td>"
//												   			   +data[0].rs[1].rows[i].UnitName+"</td><td>"
//											   				   +"</td><td>"
//														   	   +"</td><td>"
//												   			   +"</td><td>"
//												   			   +"</td><td>"
//												   			   +"</td><td>"
//															   +"</td></tr>"
//						)
//						num+=2;
//					}
//					while(num<=26){
//						$(".goodsinfo tbody").append("<tr><td colspan='12'></td></tr>")
//						num++;
//					}
					//4
					$(".Totlamount").text(data[0].rs[0].rows[0].TotalAmount);
					$(".Totlavolume").text(data[0].rs[0].rows[0].TotalVolume);
					$(".Totlaweight").text(data[0].rs[0].rows[0].TotalWeight);
					//5
					$(".suppliercompany").text('ZBWLS（上海中保）');
					//目前车ID是没有的，有的时候再加data[0].rs[0].rows[0].CarID
					$(".suppliercarid").text();
					//目前车型是没有的，有的时候再加data[0].rs[0].rows[0].CarType
					$(".suppliercarcategory").text();
					$(".supplier").text();
				}
			})
			window.print();
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