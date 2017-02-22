<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>应收对账信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/FMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="Indexed">

<!-- 通用对话框开始-->
<div class="modal fade text-center" id="win-Common-Dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="width: 1270px;">
		<div class="modal-content">
			<div class="modal-body">
				<div class="content">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 通用对话框结尾 -->

<!--通用头部文件开始-->
<!--#include file="/Controls/FMS/header.aspx"-->

<!--通用头部文件结尾-->
<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
            var __saveNdtCfg = '{"main":{"insertVml":"fml_0009","updateVml":"fml_0009","queryVml":"fml_0003"},"Balance_BillDetails":{"queryVml":"fml_0006","deleteVml":"fml_0005"}}';
</script>
 <table class="FormTable Y_alter" style="width:100%;" id="25ccf24c-9c73-44a5-899b-2565511d81d0" path="Price/eyxhzqmm" code="eyxhzqmm">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width:120px;">
  </colgroup>
  <tbody>
    <tr class="td-container tr-fixed">
        <td class="text-left" rowspan="1" colspan="7" style="padding-left:0;width:100% !important;">
            <div style="padding-top:20px;" >
			    <div style="padding-left: 3px; background-color: #f27302;">
				    <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">应收对账信息</p>
			    </div>
             </div>
        </td>
		 <td colspan="8" style="border:0;">
			<div class="toolbar">
			  <div style="text-align:right;" class="button_workflow">
				<input type="hidden" name="id">
				<!--<a class="btn btn-red footKeepBtn" href="javascript:void(0);" onclick="PrintArea()">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>
				<a class="btn btn-red footKeepBtn output" target="_blank">导出&nbsp;<span class="glyphicon glyphicon-new-window"></span></a>-->
				<a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
			  </div>
			  <div class="clear"></div>
			  <div class="content_workflow"></div>
			</div>
		 </td>
    </tr>
     <tr>
        <td rowspan="1" colspan="15" style="background-color: white; border: 0; height: 64px;""></td>
    </tr>
    <tr style="height: 26px;">
		<td class="td_name" style="background-color: rgb(242, 242, 242);">
             制单日期
             <input type="hidden" name="DocID" value="0"/>
             <input type="hidden" name="OrdersLst" value="0"/>
			 <input type="hidden" name="BillType" value="1"/>		<!--1:应收 2:应付-->
      </td>
      <td class="" rowspan="1" colspan="14">
        <input name="inserttime" disabled placeholder="系统自动生成" class="laydate-icon edit form-control" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'inserttime','type':'date','etype':'','len':''}" verify="{}">
      </td>
    </tr>
	 <tr style="height: 26px;">
       <td class="td_name">
           客户
			 <input type="hidden" name="Customerid" value="0"/> 
      </td>
      <td class="" rowspan="1" colspan="5">
         <input name="CustomerName" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'CustomerName','length':'50','required':true}">
      </td>
	  <td class="" style="background-color: rgb(242, 242, 242);">          
             是否开发票
         </a>
      </td>
      <td class="" rowspan="1" colspan="9">
     
        	<span class="gou-btn gouChecked" onclick="ifBoxChecked()"></span>
      </td>
    </tr>
    
	<tr style="height: 26px;" class="show_hu">
       <td class="" style="background-color: rgb(242, 242, 242);">          
             发票代码
         </a>
      </td>
      <td class="" rowspan="1" colspan="4">
        <input name="Code"   class="edit form-control transparent show_hu_1" f-options="{'code':'Code','type':'text','etype':'','len':''}" verify="{'title':'发票代码','length':'50'}">
      </td>
	  <td class="" style="background-color: rgb(242, 242, 242);">          
             发票号码
         </a>
      </td>
      <td class="" rowspan="1" colspan="4">
        	<input name="No"   class="edit form-control transparent show_hu_2" f-options="{'code':'No','type':'text','etype':'','len':''}" verify="{'title':'发票号码','length':'50'}">
      </td>      
	  <td class="td_name" style="background-color: rgb(242, 242, 242);">
             发票金额
      </td>
      <td class="" rowspan="1" colspan="4">
         <input name="Amount"    placeholder=" " class="edit form-control transparent show_hu_3" f-options="{'code':'Amount','type':'text','etype':'editable','len':'50'}" verify="{'title':'发票金额','length':'50'}">
      </td>
    </tr>
	
    <tr style="height: 26px;">
      <td class="" style="background-color: rgb(242, 242, 242);">说明</td>
      <td rowspan="1" colspan="14" style="height:100px;">
        <textarea name="Description" style="height:100px !important;"  class="edit form-control transparent" f-options="{'code':'Description','type':'richtext','etype':'','len':''}" verify="{}"></textarea>
      </td>
    </tr>
	 <tr>
		<td rowspan="1" colspan="15" style="background-color: white; border: 0; height: 15px;"></td>
	</tr>
	<tr style="height: 26px;" class="" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
		<td class="td_name" >订单编号</td>
		<td class="td_name" >合同编号</td>
		<td class="td_name" >发货日期</td>		
		<td class="td_name">发站市</td>
		<td class="td_name">到站市</td>
		<td class="td_name">总体积(立方米)</td>
		<td class="td_name">总重量(公斤)</td>
		<td class="td_name">总数量</td>
		<td class="td_name">实签数量</td>
		<td class="td_name">总金额（RMB）</td>
		<td class="td_name">货到付款</td>
		<td class="td_name">预付款</td>	
		<td class="td_name">应收款</td>				
		<td class="td_name">备注</td>
		
	</tr>
	<tr  nrowkey="DetailID"  style="height: 26px;display:none"  class="" fb-options="{'rowid':'Balance_BillDetails','initialRows':'1','maxrows':'10','content':''}" rowid="Balance_BillDetails">
		<td colspan="">
			<input oc="text"  name="Code" placeholder="点击进行订单选择" onclick="" title="订单编号" oc="dialogue" class="edit shr" f-options="{'code':'Code','type':'dialogue','etype':'editable','len':'50','cls':'frame','url':'IndexOrderSelect.aspx','vals':'pactcode=pactcode,payment=payment,payable=payable,fromtime=fromtime,Code=code,OrderID=id,fromprovincename=fromprovincename,fromcityname=fromcityname,toprovincename=toprovincename,tocityname=tocityname,volume=Volume,weight=Weight,receiptqty=ReceiptQty,total=Total,amount=Amount,PayAmount=PayAmount','modalWindow':'1'}" verify="{'title':'OrderID','length':'50','required':true}">
			<input type="hidden" name="DetailID" value="0" >
			<input type="hidden" name="OrderID" value="0" >
		</td>
		<td>
			<input name="pactcode" title="合同编号" readonly oc="text" class="edit form-control transparent" f-options="{'code':'pactcode','type':'text','etype':'editable','len':'50'}" verify="{'title':'合同编号','length':'50','required':true}">
		</td>		
		<td>
			<input name="fromtime" title="发货日期" readonly oc="text" class="edit form-control transparent" f-options="{'code':'fromtime','type':'text','etype':'editable','len':'50'}" verify="{'title':'发货日期','length':'50','required':true}">
		</td>				
		<td>
			<input name="fromcityname" title="发站市" readonly oc="text" class="edit form-control transparent" f-options="{'code':'fromcityname','type':'text','etype':'editable','len':'50'}" verify="{'title':'发站市','length':'50','required':true}">
		</td>
		<td class="">
			<input name="tocityname" readonly="readonly"   title="到站市" oc="number" class="edit form-control transparent" f-options="{'code':'tocityname','type':'number','etype':'editable','len':''}" verify="{'title':'到站市','length':'50'}">
		</td>
		<td class="">
			<input name="volume" readonly="readonly"   title="总体积" oc="number" class="edit form-control transparent" f-options="{'code':'volume','type':'number','etype':'editable','len':''}" verify="{'title':'总体积','required':true}">
		</td>
		<td class="">
			<input name="weight" readonly="readonly"   title="总重量" oc="number" class="edit form-control transparent" f-options="{'code':'weight','type':'number','etype':'editable','len':''}" verify="{'title':'总重量','required':true}">
		</td>
		<td class="">
			<input name="amount" readonly="readonly"   title="总数量" oc="number" class="edit form-control transparent" f-options="{'code':'amount','type':'number','etype':'editable','len':''}" verify="{'title':'总数量','required':true}">
		</td>
		<td class="">
			<input name="receiptqty" readonly="readonly"   title="实签数量" oc="number" class="edit form-control transparent" f-options="{'code':'receiptqty','type':'number','etype':'editable','len':''}" verify="{'title':'实签数量','required':true}">
		</td>
		<td>
			<input name="total" readonly="readonly"   title="总金额" oc="number" class="edit form-control transparent" f-options="{'code':'total','type':'number','etype':'editable','len':''}" verify="{'title':'total','number':true}">
		</td>
		<td>
			<input name="payable" readonly="readonly"   title="货到付款" oc="number" class="edit form-control transparent" f-options="{'code':'payable','type':'number','etype':'editable','len':''}" verify="{'title':'货到付款','number':true}">
		</td>
		<td>
			<input name="payment" readonly="readonly"   title="预付款" oc="number" class="edit form-control transparent" f-options="{'code':'payment','type':'number','etype':'editable','len':''}" verify="{'title':'预付款','number':true}">
		</td>
		<td>
			<input name="PayAmount" readonly="readonly"   title="应收款" oc="number" class="edit form-control transparent" f-options="{'code':'PayAmount','type':'number','etype':'editable','len':''}" verify="{'title':'应收款','number':true}">
		</td>
		<td class="">
			<input name="description"    title="描述" oc="text" class="edit form-control transparent" f-options="{'code':'description','type':'number','etype':'editable','len':''}" verify="{'title':'description'}">
		</td>
	   
	</tr>
	<tr   style="height: 26px;" class="" >
		<td colspan="5" class="td_name">
			合计
		</td>
		
		 <td>
			<input name="ToVolume" title="总体积" readonly  oc="text" calculation="var%20arr%3D%7B%5BBalance_BillDetails.volume%5D%7D%3Bvar%20sum%3D0%3Bfor%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28arr%5Bi%5D%3D%3D%27%27%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%3B%7D%7Dsum.toFixed%282%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
		</td>
		<td>
			<input name="ToWeight" title="总重量" readonly  oc="text" calculation="var%20arr%3D%7B%5BBalance_BillDetails.weight%5D%7D%3Bvar%20sum%3D0%3Bfor%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28arr%5Bi%5D%3D%3D%27%27%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%3B%7D%7Dsum.toFixed%282%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
		</td>
		<td>
			<input name="TotalQty" title="总数量" readonly oc="text" calculation="var%20arr%3D%7B%5BBalance_BillDetails.amount%5D%7D%3Bvar%20sum%3D0%3Bfor%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28arr%5Bi%5D%3D%3D%27%27%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%3B%7D%7Dsum.toFixed%282%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
		</td>
		<td>
			<input name="TotalReceiptQty" title="实签数量" readonly oc="text" calculation="var%20arr%3D%7B%5BBalance_BillDetails.receiptqty%5D%7D%3Bvar%20sum%3D0%3Bfor%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28arr%5Bi%5D%3D%3D%27%27%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%3B%7D%7Dsum.toFixed%282%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
		</td>
		<td >
			<input name="ToAccount" title="总金额" readonly  oc="text" calculation="var%20arr%3D%7B%5BBalance_BillDetails.total%5D%7D%3Bvar%20sum%3D0%3Bfor%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28arr%5Bi%5D%3D%3D%27%27%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%3B%7D%7Dsum.toFixed%282%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
		</td>
		<td>
			<input name="Totalpayable" readonly="readonly"   title="货到付款" oc="text"  readonly   calculation="var%20arr%3D%7B%5BBalance_BillDetails.payable%5D%7D%3Bvar%20sum%3D0%3Bfor%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28arr%5Bi%5D%3D%3D%27%27%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%3B%7D%7Dsum.toFixed%282%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
		</td>
		<td>
			<input name="Totalpayment" readonly="readonly"   title="预付款" oc="text" readonly   calculation="var%20arr%3D%7B%5BBalance_BillDetails.payment%5D%7D%3Bvar%20sum%3D0%3Bfor%28var%20i%3D0%3Bi%3Carr.length%3Bi++%29%7Bif%28arr%5Bi%5D%3D%3D%27%27%29%7Bsum+%3DparseFloat%28%270%27%29%3B%7Delse%7B%20sum%20+%3D%20parseFloat%28arr%5Bi%5D%29%3B%7D%7Dsum.toFixed%282%29%3B" class="edit form-control transparent" f-options="{'code':'','type':'text','etype':'editable','len':'50'}" verify="">
		</td>				
	   <td >
		</td>
	   <td >
		</td>

	</tr>
  </tbody>
 </table>
<!-- 表单结尾 -->
</div>

<!--通用页尾开始-->
<!--#include file="/Controls/FMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
		initTableForm($('#25ccf24c-9c73-44a5-899b-2565511d81d0'),'',function() {
        	autoHead();
        	autoHu();
        	setTimeout( "RemovePointer();showTotal();", 200 );
        },'');
        $('input,textarea').attr('readonly', true);
	}

	function PrintArea()
	{
        var _orderid = NSF.UrlVars.Get('id', location.href);
    	window.location.href="printIndex.aspx?id="+_orderid;
     }

	
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/FMS/JS.aspx"-->
<script type="text/javascript">
    /*浏览器窗口变化时，固定头部宽度赋值*/
    $(window).resize(function () {
        autoHead();

    });
 
    /*固定头部宽度赋值*/
    function autoHead() {
        var autoW = $('.formcontainer').width() + 2;//+2是为了解决兼容边框
        $('.tr-fixed').css('width', autoW + 'px');
    }
    function ifBoxChecked() {
	 	if($('.gou-btn').hasClass('gouChecked')){
	 		$('.gou-btn').removeClass('gouChecked');
	 		$('.show_hu').hide();
	 		$('.show_hu_1').attr('name','');
	 		$('.show_hu_2').attr('name','');
	 		$('.show_hu_3').attr('name','');
	 	}else{
	 		$('.gou-btn').addClass('gouChecked');
	 		$('.show_hu').show();	 	
	 		$('.show_hu_1').attr('name','Code');
	 		$('.show_hu_2').attr('name','No');
	 		$('.show_hu_3').attr('name','Amount');	 		
	 	}
	}    
    function autoHu() {
		if($('.show_hu_1').val() == "" || $('.show_hu_1').val() == undefined){
	 		$('.gou-btn').removeClass('gouChecked');
	 		$('.show_hu').hide();
	 		$('.show_hu_1').attr('name','');
	 		$('.show_hu_2').attr('name','');
	 		$('.show_hu_3').attr('name','');
		}
    }

    
    
</script>
<script src="/assets/request_minify.js"></script>
</body>
</html>