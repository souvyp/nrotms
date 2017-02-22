<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>应付对账信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/FMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
<style type="text/css">
	.nav li{width:33%}
	.container{margin-top:10px;}
	.FormTable>tbody>tr>td{width:13.5% !important;}
	</style>
</head>
<body onload="getdate()" code="Index">
	<div class="">
		<div style="height:30px;">
			打印日期:<span class="date"></span>
		</div>
		<ul class="nav nav-pills" role="tablist">
		  	<li>
				<img src="/images/print_logo1.png" />
			</li>
			<li style="text-align:center">
			<h4><span></span> - 应付对账单</h4>
			</li>
			<li style="text-align:right">
				<img src="/images/QRCode.png" style="width:50px;height:50px" />
			</li>
		</ul>

		<div class="formcontainer" style="display:none;">
			<!-- 表单开始-->
			<script language="javascript">
			            var __saveNdtCfg = '{"main":{"insertVml":"fml_0001","updateVml":"fml_0002","queryVml":"fml_0003"},"Balance_BillDetails":{"insertVml":"fml_0004","updateVml":"fml_0004","queryVml":"fml_0006","deleteVml":""}}';
			</script>
			<div id="area" style="display:none" >
				<img src="/images/print_logo1.png"/>
			</div>
			 <table class="FormTable Y_alter" style="width:100%;" id="25ccf24c-9c73-44a5-899b-2565511d81d0" path="Price/eyxhzqmm" code="eyxhzqmm">
			  <tbody >
			    <tr>
			        <td class="text-left" rowspan="1" colspan="8" style="font-size: 14px; border: 0; border-bottom: 1px solid #e1e6eb; padding-right: 0; padding-left: 0;">
			        	<input type="hidden" name="SupplierName" >
			        </td>
			    </tr>
			    
			    <tbody id="FormTable">
					<tr style="height: 26px;" class="" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
						<td class="td_name" >订单编号</td>
						<td class="td_name" >合同号</td>
						<td class="td_name">发站市</td>
						<td class="td_name">到站市</td>
						<td class="td_name">体积(立方米)</td>
						<td class="td_name">重量(公斤)</td>	
						<td class="td_name">总金额</td>
				        <td class="td_name">总数量</td>
					</tr>
					<tr   style="height: 26px;display:none" IsDirty="true" class="" fb-options="{'rowid':'Balance_BillDetails','initialRows':'1','maxrows':'10','content':''}" rowid="Balance_BillDetails">
						<td colspan="">
							<textarea oc="text"  name="Code" disabled title="订单编号" oc="dialogue" class="edit shr" f-options="{'code':'Code','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'IndexOrderSelect.aspx','vals':'pactcode=pactcode,Code=code,OrderID=id,fromprovincename=fromprovincename,fromcityname=fromcityname,toprovincename=toprovincename,tocityname=tocityname,volume=Volume,weight=Weight,total=Total','modalWindow':'1'}" verify="{'title':'OrderID','length':'50','required':true}"></textarea>
							<textarea class="hidden" name="DetailID" value="0" ></textarea>
							
						</td>
						<td >
							<textarea name="pactcode" title="合同号" disabled oc="text" class="edit form-control transparent" f-options="{'code':'pactcode','type':'text','etype':'editable','len':'50'}" verify="{'title':'合同号','length':'50','required':true}"></textarea>
						</td>
						
						<td>
							<textarea name="fromcityname" title="发站市" disabled oc="text" class="edit form-control transparent" f-options="{'code':'fromcityname','type':'text','etype':'editable','len':'50'}" verify="{'title':'发站市','length':'50','required':true}"></textarea>
						</td>
						
						<td class="">
							<textarea name="tocityname" disabled="disabled"   title="到站市" oc="number" class="edit form-control transparent" f-options="{'code':'tocityname','type':'number','etype':'editable','len':''}" verify="{'title':'到站市','length':'50','required':true}"></textarea>
						</td>
						<td class="">
							<textarea name="volume" disabled="disabled"   title="总体积" oc="number" class="edit form-control transparent" f-options="{'code':'volume','type':'number','etype':'editable','len':''}" verify="{'title':'总体积','required':true}"></textarea>
						</td>
						<td class="">
							<textarea name="weight" disabled="disabled"   title="总重量" oc="number" class="edit form-control transparent" f-options="{'code':'weight','type':'number','etype':'editable','len':''}" verify="{'title':'总重量','required':true}"></textarea>
						</td>
						
						<td>
							<textarea name="total" disabled="disabled"   title="总金额" oc="number" class="edit form-control transparent" f-options="{'code':'total','type':'number','etype':'editable','len':''}" verify="{'title':'total','number':true}"></textarea>
						</td>
				        <td class="">
							<textarea name="amount" readonly="readonly" title="总数量" oc="number" class="edit form-control transparent" f-options="{'code':'amount','type':'number','etype':'editable','len':''}" verify="{'title':'总数量','required':true}"></textarea>
						</td>
					</tr>
					<tr   style="height: 26px;" IsDirty="true" class=""  >
						<td colspan="4">
							合计
						</td>
						 <td>
							<textarea name="TotalVolume" title="总体积" disabled  oc="edit"  class="edit form-control transparent"  verify=""></textarea>
						</td>
						<td>
							<textarea name="TotalWeight" title="总重量" disabled  oc="edit"  class="edit form-control transparent"  verify=""></textarea>
						</td>
						<td >
							<textarea name="TotalCost" title="总金额" disabled  oc="edit"  class="edit form-control transparent"  verify=""></textarea>
						</td>
					   <td >
					   		<textarea name="TotalAmount"  title="总数量" disabled  oc="edit"  class="edit form-control transparent"  verify=""></textarea>
						</td>
					</tr>
				  </tbody>
				 </table>
			<!-- 表单结尾 -->
		</div>
	</div>
	
	




<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
		initTableForm($('#25ccf24c-9c73-44a5-899b-2565511d81d0'),'',function() {
        	setTimeout( "sumPrint()", 200 );


        },'');
	}
	function sumPrint()
    {
        var _weight = 0;
    	var _volume = 0;
    	var _total = 0;
    	var _amount = 0;

        $('tr[nrowid="Balance_BillDetails"]').each( function(){

        	_weight += parseFloat( $(this).find('textarea[name="weight"]').val() );
        	_volume += parseFloat( $(this).find('textarea[name="volume"]').val() );
        	_total += parseFloat( $(this).find('textarea[name="total"]').val() );
        	_amount += parseFloat( $(this).find('textarea[name="amount"]').val() );
        });

        $('textarea[name="TotalWeight"]').text( _weight.toFixed(4) );
        $('textarea[name="TotalVolume"]').text( _volume.toFixed(6) );
        $('textarea[name="TotalCost"]').text( _total.toFixed(2) );
        $('textarea[name="TotalAmount"]').text( _amount );
        $('h4>span').text($('input[name="SupplierName"]').val());
        window.print();
        window.history.back(-1);
	}
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/FMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
<script src="js/jquery.PrintArea.js"></script>
<style>
    textarea
    {
        height:auto !important;
        background-color: #fff !important;
        line-height: 10px !important;
        padding-top: 10px !important;
    }
    .FormTable>tbody>tr>td:nth-child(2) textarea
    {
        height:35px !important;
    }
    
</style>
</body>
</html>