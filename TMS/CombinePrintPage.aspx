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
		.header{
			width: 100%;
			position: absolute;top: 0;	
		}
		.commodity{
			width: 100%;
			position: absolute;top:180px;
		}
		.commodity .title:nth-child(1){
			width: 12%;
		}
		.commodity .title:nth-child(2){
			width: 10%;
		}
		.commodity .title:nth-child(3){
			width: 10%;
		}
		.commodity .title:nth-child(4){
			width: 6%;
		}
		.commodity .title:nth-child(5){
			width: 16%;
		}		
		.commodity .title:nth-child(6){
			width: 11%;
		}
		.commodity .title:nth-child(7){
			width: 9%;
		}
		.commodity .title:nth-child(8){
			width: 16%;
		}
		.commodity .title:nth-child(9){
			width: 10%;
		}
		.commodity .commoditytable tbody tr:nth-child(12) td{
			border-bottom: none;
		}
		.charge{
			width: 100%;
			position: absolute;top:820px;
			padding-bottom: 10px;
		}
		.charge td:nth-child(1){
			width: 12%;
		}
		.charge td:nth-child(2){
			width: 10%;
		}
		.charge td:nth-child(3){
			width: 10%;
		}
		.charge td:nth-child(4){
			width: 6%;
		}
		.charge td:nth-child(5){
			width: 16%;
		}		
		.charge td:nth-child(6){
			width: 11%;
		}
		.charge td:nth-child(7){
			width: 9%;
		}
		.charge td:nth-child(8){
			width: 16%;
		}
		.charge td:nth-child(9){
			width: 10%;
		}				
		.charge table tr td{
			text-align: left;
			border-bottom: 1px solid rgb(179,179,179);
			border-top: 1px solid rgb(179,179,179);
			height: 25px;
			line-height: 25px;
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
		sup{
			font-size: 4px;
		}

	</style>
	<body onload="getdate()">
		<div class="DefalutOrder">
			<div class="header">
		 		<table>
		 			<tr>
		 				<td colspan="3">打印日期:<span class="date"></span></td>
		 			</tr>
		 			<tr>
		 				<td style="width: 200px;"><div class="logo"><img src="/images/print_logo1.png"></div></td>
		 				<td style="text-align:center;">
		 					<div class="companyName" ></div>
		 					<div class="codeTitle" style="font-size: 16px;">（拼车单）</div>
	 					</td>
		 				<td style="width: 200px;"><div class="qrcode"><img src="/images/QRCode.png"></div></td>
		 			</tr>
		 		</table>
		 		<table>
		 			<tr>
		 				<td>合同号:<span class="pactcode"></span></td>
		 				<td style="text-align:right">制单时间：<span class="creattime"></span></td>
		 			</tr>
		 			<tr>
		 				<td>承运方:<span class="supplier"></span></td>
		 				<td></td>
		 			</tr>
		 		</table>
		 	</div>	 
		 	
		 	<div class="charge">
		 		<table>
		 			<tbody>
						<tr>
							<td rowspan="2"><ul><li>本页小计</li><li></li>总计</li></ul></td> 
							<td rowspan="2"><ul><li><span class='WeiSum'></span></li><li><span class='weightsum'></span></li></td> 
							<td rowspan="2"><ul><li><span class='VolSum'></span></li><li><span class='volumesum'></span></li></td> 
							<td rowspan="2"><ul><li><span class='QtySum'></span></li><li><span class='qtysum'></span></li></td> 
							<td rowspan="2"></td> 
							<td rowspan="2"></td> 
							<td rowspan="2"></td> 
							<td rowspan="2"></td> 
							<td rowspan="2"></td> 
						</tr>
		 				<tr></tr>
		 				<tr>
		 					<td colspan="4">
		 						<ul>
		 							<li>总费用:<span class='SumCost'></span></li>
		 							<li>预付款:<span class='Payable'></span></li>
		 						</ul>
		 					</td>  
	 						<td colspan="5">
	 							<ul>
	 								<li>&nbsp;</li>
	 								<li>货到付款:<span class='Payment'></span></li>
	 							</ul>	
	 						</td> 
		 				</tr>
		 			</tbody>
		 		</table>
		 	</div>
		 	
		 	<div class="commodity">
		 		<table class="commoditytable">
		 			<thead>
		 			<tr>
		 				<td class="title">合同编号</td>
		 				<td class="title">重量(kg)</td>
		 				<td class="title">体积(m³)</td>
		 				<td class="title">数量</td>
		 				<td class="title">发货地址</td>
		 				<td class="title">收货方</td>
		 				<td class="title">收货方电话</td>
		 				<td class="title">收货地址</td>
		 				<td class="title">备注</td>
		 			</tr>
		 			</thead>
		 			<tbody>
		 			</tbody>
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
		 '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0233","paras":[{"name":"id","value":"' + _orderid + '"}]}]';
			
			NSF.System.Network.Ajax('/Portal.aspx',
				vml,
				'POST',
				false,
				function(result, data) {
					if(result) {
						//
						$(".company").text(data[0].rs[0].rows[0].CreatorCompanyName);
						//承运商名称
						$(".supplier").text(data[0].rs[0].rows[0].SupplierName);
						
						//总费用
						var totlecost = data[0].rs[0].rows[0].TotalCost;
						var payment = data[0].rs[0].rows[0].Payment;
						var payable = data[0].rs[0].rows[0].Payable;
						
						if(totlecost==0.00){
							$(".SumCost").text("0.00元	 大写:零圆整");
						}else{
							$(".SumCost").text(data[0].rs[0].rows[0].TotalCost+"元     大写:"+convertCurrency(data[0].rs[0].rows[0].TotalCost));
						}
						//预付款
						if(payment==0.00){
							$(".Payment").text("0.00元	大写:零圆整");
						}else{
							$(".Payment").text(data[0].rs[0].rows[0].Payment+"元     大写:"+convertCurrency(payment));
						}
						//货到付款
						if(payable==0.00){
							$(".Payable").text("0.00元	大写:零圆整");
						}else{
							$(".Payable").text(data[0].rs[0].rows[0].Payable+"元     大写:"+convertCurrency(payable));
						}
						
						//合同编号
						$(".pactcode").text(data[0].rs[0].rows[0].PactCode);
	 					//承运方大标题
	 					$('div.companyName').text(data[0].rs[0].rows[0].CreatorCompanyName);

	 					//创建时间
	 					$(".creattime").text(data[0].rs[0].rows[0].CreateTime);

	 					//承运方名称
	 					$(".suppliername").text(data[0].rs[0].rows[0].SupplierName);
	 					//承运方联系人
	 					$(".suppliercontactor").text(data[0].rs[0].rows[0].SupplierContact);
	 					//承运方联系电话
	 					$(".suppliertel").text(data[0].rs[0].rows[0].SupplierPhone);
						
	 					//总重量
	 					$(".weightsum").text(data[0].rs[0].rows[0].TotalWeight);
	 					//总体积
	 					$(".volumesum").text(data[0].rs[0].rows[0].TotalVolume);
	 					//总数量
	 					$(".qtysum").text(parseFloat(data[0].rs[0].rows[0].TotalAmount).toFixed(0));
					}
				})
		}
		
		function goods(_orderid){
			var vml =
		 '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0105","paras":[{"name":"did","value":"' + _orderid + '"}]}]';
			
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
	 					
	 					pages = Math.ceil(style_div(num,12));
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
	 							$(".order"+pageindex+" .charge tr:nth-child(3)").css("display","none");
	 						}
	 						
	 						pageindex++;
	 						pages--;
	 					}
	 					
	 					//添加物品信息
	 					for(var i=0;i<data[0].rs[0].rows.length;i++){
	 						if(rowindex%12==0){
	 							if(getBt(data[0].rs[0].rows[i].description)>40){
	 								var str = cutStr(data[0].rs[0].rows[i].description,40);
 									str+="..";
	 							}else{
	 								var str = cutStr(data[0].rs[0].rows[i].description,40);
	 							}
	 							
	 							if(getBt(data[0].rs[0].rows[i].from)>62){
	 								var from = cutStr(data[0].rs[0].rows[i].from,62);
	 								from+="..";
	 							}else{
	 								var from = cutStr(data[0].rs[0].rows[i].from,62);
	 							}
	 							
	 							if(getBt(data[0].rs[0].rows[i].to)>62){
	 								var to = cutStr(data[0].rs[0].rows[i].to,62);
	 								to+="..";
	 							}else{
	 								var to = cutStr(data[0].rs[0].rows[i].to,62);
	 							}
	 							
	 							if(getBt(data[0].rs[0].rows[i].endusername)>38){
	 								var enduser = cutStr(data[0].rs[0].rows[i].endusername,38);
	 								enduser+="..";
	 							}else{
	 								var enduser = cutStr(data[0].rs[0].rows[i].endusername,38);
	 							}
								
								var amount = parseFloat(data[0].rs[0].rows[i].amount).toFixed(0);
								
								$(".order"+pageindex2+" .commoditytable tbody").eq(0).append("<tr><td>"+data[0].rs[0].rows[i].PactCode+"</td><td>"+data[0].rs[0].rows[i].weight+"</td><td>"+data[0].rs[0].rows[i].volume+"</td><td>"+amount+"</td><td>"+from+"</td><td>"+enduser+"</td><td>"+data[0].rs[0].rows[i].tocontact+"</td><td>"+to+"</td><td>"+str+"</td>");

	 							rowindex++;
 								pageindex2++;

	 						}else{
	 							if(getBt(data[0].rs[0].rows[i].description)>40){
	 								var str = cutStr(data[0].rs[0].rows[i].description,40);
 									str+="..";
	 							}else{
	 								var str = cutStr(data[0].rs[0].rows[i].description,40);
	 							}
	 							
	 							if(getBt(data[0].rs[0].rows[i].from)>62){
	 								var from = cutStr(data[0].rs[0].rows[i].from,62);
	 								from+="..";
	 							}else{
	 								var from = cutStr(data[0].rs[0].rows[i].from,62);
	 							}
	 							
	 							if(getBt(data[0].rs[0].rows[i].to)>62){
	 								var to = cutStr(data[0].rs[0].rows[i].to,62);
	 								to+="..";
	 							}else{
	 								var to = cutStr(data[0].rs[0].rows[i].to,62);
	 							}
	 							
	 							if(getBt(data[0].rs[0].rows[i].endusername)>38){
	 								var enduser = cutStr(data[0].rs[0].rows[i].endusername,38);
	 								enduser+="..";
	 							}else{
	 								var enduser = cutStr(data[0].rs[0].rows[i].endusername,38);
	 							}

 								var amount = parseFloat(data[0].rs[0].rows[i].amount).toFixed(0);

								$(".order"+pageindex2+" .commoditytable tbody").eq(0).append("<tr><td>"+data[0].rs[0].rows[i].PactCode+"</td><td>"+data[0].rs[0].rows[i].weight+"</td><td>"+data[0].rs[0].rows[i].volume+"</td><td>"+amount+"</td><td>"+from+"</td><td>"+enduser+"</td><td>"+data[0].rs[0].rows[i].tocontact+"</td><td>"+to+"</td><td>"+str+"</td>");
	 							rowindex++;
	 						}
						}
	 					
	 					//补充空行
	 					if(num%12==0){
	 						var rowsextra = 0;
	 					}else{
	 						var rowsextra = (12 - num%12);
	 					}
	 					
	 					while(rowsextra>=1){
	 						if(rowsextra==1){
	 							$(".order"+totlapage+" .commoditytable tbody").append("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>");
//	 							$(".order"+totlapage+" .commoditytable tbody").append("<tr> <td>本页小计</td> <td><span class='WeiSum'></span></td> <td><span class='VolSum'></span></td> <td><span class='QtySum'></span></td> <td></td> <td></td> <td></td> <td></td> <td></td>");
// 								$(".order"+totlapage+" .commoditytable tbody").eq(0).append("<tr> <td>总计</td> <td><span class='weightsum'></span></td> <td><span class='volumesum'></span></td> <td><span class='qtysum'></span></td> <td></td> <td></td> <td></td> <td></td> <td></td>");
 								// $(".order"+totlapage+" .commoditytable tbody").eq(0).append("<tr> <td><ul><li>费用信息</li><li>总费用:</li></ul></td> <td colspan='2'><ul><li>单位/元</li><li><span class='SumCost'></span></li></ul></td> <td colspan='2'><ul><li>&nbsp</li><li>货到付款:<span class='Payment'></span></li></td> <td></td> <td colspan='3'><ul><li>&nbsp</li><li>预付款:<span class='Payable'></span></li></td></tr>");-->
	 						}else{
	 							$(".order"+totlapage+" .commoditytable tbody").append("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>");
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
	 						
	 						for(var i=0;i<12;i++){
	 							if($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(2)").eq(i).text()==""){
	 								
	 							}else{
	 								weightsum += parseFloat($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(2)").eq(i).text());
	 							}
	 							
	 							if($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(3)").eq(i).text()==""){
	 								
	 							}else{
	 								volumesum += parseFloat($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(3)").eq(i).text());
	 							}
	 							
	 							if($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(4)").eq(i).text()==""){
	 								
	 							}else{
	 								qtysum += parseFloat($(".order"+pageindex2+" .commoditytable tbody tr td:nth-child(4)").eq(i).text());
	 							}
	 						}
	 						
	 						$(".order"+pageindex2+" .charge tbody .WeiSum").text(weightsum.toFixed(4));
	 						$(".order"+pageindex2+" .charge tbody .VolSum").text(volumesum.toFixed(6));
	 						$(".order"+pageindex2+" .charge tbody .QtySum").text(parseFloat(qtysum).toFixed(0));
	 						
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
			
			goods(_orderid);
			orders(_orderid);
			
			window.print();
			window.history.back(-1); 
		}   
		
		function cutStr(str,L){    
		    var result = '',
		        strlen = str.length, // 字符串长度
		        chrlen = str.replace(/[^\x00-\xff]/g,'**').length; // 字节长度
		
		    if(chrlen<=L){return str;}
		    
		    for(var i=0,j=0;i<strlen;i++){
		        var chr = str.charAt(i);
		        if(/[\x00-\xff]/.test(chr)){
		            j++; // ascii码为0-255，一个字符就是一个字节的长度
		        }else{
		            j+=2; // ascii码为0-255以外，一个字符就是两个字节的长度
		        }
		        if(j<=L){ // 当加上当前字符以后，如果总字节长度小于等于L，则将当前字符真实的+在result后
		            result += chr;
		        }else{ // 反之则说明result已经是不拆分字符的情况下最接近L的值了，直接返回
		            return result;
		        }
		    }
		}
		
		function getBt(str){
		    var char = str.match(/[^\x00-\xff]/ig);
		    return str.length + (char == null ? 0 : char.length);
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
		
		function convertCurrency(money) {
		  //汉字的数字
		  var cnNums = new Array('零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖');
		  //基本单位
		  var cnIntRadice = new Array('', '拾', '佰', '仟');
		  //对应整数部分扩展单位
		  var cnIntUnits = new Array('', '万', '亿', '兆');
		  //对应小数部分单位
		  var cnDecUnits = new Array('角', '分', '毫', '厘');
		  //整数金额时后面跟的字符
		  var cnInteger = '整';
		  //整型完以后的单位
		  var cnIntLast = '圆';
		  //最大处理的数字
		  var maxNum = 999999999999999.9999;
		  //金额整数部分
		  var integerNum;
		  //金额小数部分
		  var decimalNum;
		  //输出的中文金额字符串
		  var chineseStr = '';
		  //分离金额后用的数组，预定义
		  var parts;
		  if (money == '') { return ''; }
		  money = parseFloat(money);
		  if (money >= maxNum) {
		    //超出最大处理数字
		    return '';
		  }
		  if (money == 0) {
		    chineseStr = cnNums[0] + cnIntLast + cnInteger;
		    return chineseStr;
		  }
		  //转换为字符串
		  money = money.toString();
		  if (money.indexOf('.') == -1) {
		    integerNum = money;
		    decimalNum = '';
		  } else {
		    parts = money.split('.');
		    integerNum = parts[0];
		    decimalNum = parts[1].substr(0, 4);
		  }
		  //获取整型部分转换
		  if (parseInt(integerNum, 10) > 0) {
		    var zeroCount = 0;
		    var IntLen = integerNum.length;
		    for (var i = 0; i < IntLen; i++) {
		      var n = integerNum.substr(i, 1);
		      var p = IntLen - i - 1;
		      var q = p / 4;
		      var m = p % 4;
		      if (n == '0') {
		        zeroCount++;
		      } else {
		        if (zeroCount > 0) {
		          chineseStr += cnNums[0];
		        }
		        //归零
		        zeroCount = 0;
		        chineseStr += cnNums[parseInt(n)] + cnIntRadice[m];
		      }
		      if (m == 0 && zeroCount < 4) {
		        chineseStr += cnIntUnits[q];
		      }
		    }
		    chineseStr += cnIntLast;
		  }
		  //小数部分
		  if (decimalNum != '') {
		    var decLen = decimalNum.length;
		    for (var i = 0; i < decLen; i++) {
		      var n = decimalNum.substr(i, 1);
		      if (n != '0') {
		        chineseStr += cnNums[Number(n)] + cnDecUnits[i];
		      }
		    }
		  }
		  if (chineseStr == '') {
		    chineseStr += cnNums[0] + cnIntLast + cnInteger;
		  } else if (decimalNum == '') {
		    chineseStr += cnInteger;
		  }
		  return chineseStr;
		}
	</script>
</html>