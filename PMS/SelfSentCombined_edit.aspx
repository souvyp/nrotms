<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>合单报价详情- <%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="SelfSent">

<link href="city/css/cityLayout.css" type="text/css" rel="stylesheet">
<!-- 通用对话框开始-->
<div class="modal fade text-center" id="win-Common-Dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-body">
				<div class="content">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 通用对话框结尾 -->
<div class="modal" id="ClosedModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    
                    <h4 class="modal-title text-left" id="H1">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">待审核报价单</p>
                        </div>
                    </h4>
                </div>
                <div style="position:relative;padding:20px;">
                    <div class="row">
                        <label class="col-md-2 control-Label" style="color:#666;">说明</label>
                        <div class="col-md-10">
                            <textarea name="CDescription" class="form-control" rows="3" cols="70"></textarea>
                            <input type="hidden" name="Op" value="0">
                            <input type="hidden" name="DocID" value="951">
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
          <button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="VerifyDoc()"><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
          <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
<!--通用头部文件开始-->
<!--#include file="/Controls/PMS/header.aspx"-->
<!--通用头部文件结尾-->

<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
    var __saveNdtCfg = '{"main":{"insertVml":"pml_0029","updateVml":"pml_0029","queryVml":"pml_0035"},"CombineOrderPrice":{"insertVml":"pml_0031","updateVml":"pml_0031","queryVml":"pml_0032","deleteVml":""},"OrderContains":{"insertVml":"","updateVml":"","queryVml":"pml_0036","deleteVml":""}}';
</script>
 <table class="FormTable Y_alter" style="width:100%;" id="cf7f9153-cb57-415d-8a41-6a4695b6dd1a" path="Price/iqoicoqa" code="iqoicoqa">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col class="" style="width: 120px;">
    <col style="width:120px;">
  </colgroup>
  <tbody>
    <tr class="td-container tr-fixed">
      <td class="text-left" rowspan="1" colspan="4" style="font-size: 14px; border: 0; border-bottom: 1px solid #e1e6eb; padding-right: 0; padding-left: 0;width:100% !important">
      <div style="padding-top:20px;" >
              <div style="padding-left: 3px; background-color: #f27302;">
                  <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">合单报价</p>
              </div>
          </div>
      </td> 
      
      <td colspan="5" style="border: 0;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <!--<a class="btn btn-red footKeepBtn agreenBtn" href="javascript:void(0);" onclick="VerifyDocOk()" style="display:none;">同意&nbsp;<span class="glyphicon glyphicon-ok-sign"></span></a>
              <a class="btn btn-red noBtn" href="javascript:void(0);" onclick="VerifyDocNo()" style="display:none;">拒绝&nbsp;<span class="glyphicon glyphicon-thumbs-down"></span></a>-->
            <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
     <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 64px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">单据编号</td>
      <td class="" rowspan="1" colspan="2">
          <input name="Code" title="单据编号" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'Code','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
      <td class="td_name">制单日期</td>
      <td class="" rowspan="1" colspan="2">
          <input name="CreateTime" title="制单日期" style="font-size:12px;" placeholder="系统自动生成" oc="date" disabled class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'CreateTime','type':'date','etype':'editable','len':'50'}" verify="">
          <input type="hidden" name="DocID" value=0 >
          <input type="hidden" name="Name" value="" >
      </td>
      <td class="td_name">制单人</td>
      <td class="" rowspan="1" colspan="3">
          <input name="Creator" title="制单人" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'Creator','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name" style="background-color: rgb(242, 242, 242);">合同编号 </td>
      <td class="" rowspan="1" colspan="2">
         <input name="PactCode" readonly class="edit form-control transparent" f-options="{'code':'PactCode','type':'text','etype':'editable','len':'50'}" verify="{'title':'PactCode','length':'50','required':true}">
      </td>
      <td class="td_name" style="background-color: rgb(242, 242, 242);">
             发货方
            <input type="hidden" name="CustomerID" value="0">
            <input type="hidden" name="OrderID" >
      </td>
      <td class="" rowspan="1" colspan="2">
         <input name="CustomerName" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'CustomerName','length':'50','required':true}">
      </td>
      <td class="td_name">承运方标记名称</td>
      <td class="" rowspan="1" colspan="3">
          <input name="SupplierSymbolName" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'SupplierSymbolName','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>   
    <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="" rowspan="1" colspan="10" style="border:0;font-size:13px;"><span class="glyphicon glyphicon-record"></span>已选择的合单订单</td>
    </tr>
    <tr style="height: 26px;">
      <td class="backgroundGray" rowspan="1" colspan="2">订单编号</td>
      <td class="backgroundGray" rowspan="1" colspan="">合同编号</td>
      <td class="backgroundGray" rowspan="1" colspan="">收货方</td>
      <td class="backgroundGray" rowspan="1" colspan="">发货时间</td>
      <td class="backgroundGray" rowspan="1" colspan="">发货地址</td>
      <td class="backgroundGray" rowspan="1" colspan="">收货地址</td>
      <td class="backgroundGray" rowspan="1" colspan="">总数量</td>
      <td class="backgroundGray" rowspan="1" colspan="1">总重量（公斤）</td>
      <td class="backgroundGray" rowspan="1" colspan="1">总体积（立方米）</td>
    </tr>
    <tr style="height: 26px; display: none;"  class="" fb-options="{'rowid':'MinPrice','initialRows':'','maxrows':'','content':''}" rowid="OrderContains">
      <td class="" rowspan="1" colspan="2">
      <input type="text" disabled placeholder="点击进行订单选择" style="cursor:pointer;"  title="订单编号" oc="dialogue" class="edit form-control transparent" name="code" f-options="{'code':'code','type':'dialogue','etype':'editable','len':'8','cls':'frame','url':'LongCitySelector.aspx','vals':'orderid=id,weight=Weight,volume=Volume,code=Code','modalWindow':'1'}" verify="{'title':'订单编号','length':'8','required':true}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="pactcode" readonly class="edit form-control transparent" f-options="{'code':'pactcode','type':'number','etype':'','len':''}" verify="{}">
      </td>         <td class="" rowspan="1" colspan="">
        <input name="endusername" readonly class="edit form-control transparent" f-options="{'code':'endusername','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="FromTime" readonly class="edit form-control transparent" f-options="{'code':'FromTime','type':'date','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="from" readonly class="edit form-control transparent" f-options="{'code':'to','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="to" readonly class="edit form-control transparent" f-options="{'code':'weight','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="amount" readonly class="edit form-control transparent" f-options="{'code':'amount','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="1">
        <input name="weight" readonly class="edit form-control transparent" f-options="{'code':'weight','type':'number','etype':'','len':''}" verify="{'title':'weight','length':'','textarea1':true}">
      </td>
      <td class="" rowspan="1" colspan="1">
        <input name="volume" readonly class="edit form-control transparent" f-options="{'code':'volume','type':'number','etype':'','len':''}" verify="{'title':'volume','length':'','textarea1':true}">
      </td>
    </tr>
    <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="" rowspan="1" colspan="10" style="border:0;font-size:13px;"><span class="glyphicon glyphicon-record"></span>价格</td>
    </tr>
    <tr style="height: 26px;background-color: rgb(242, 242, 242);">
      <td class="backgroundGray">零担(RMB/元)</td>
      <td class="backgroundGray">整车(RMB/元)</td>
      <td class="backgroundGray">提货(RMB/元)</td>
      <td class="backgroundGray">送货(RMB/元)</td>
      <td class="backgroundGray">装货(RMB/元)</td>
      <td class="backgroundGray">卸货(RMB/元)</td>
      <td class="backgroundGray">附加费(RMB/元)</td>
      <td class="backgroundGray">保险费(RMB/元)</td>
      <td class="backgroundGray">税费(RMB/元)</td>
      <td class="backgroundGray">合计(RMB/元)</td>
    </tr>
    <tr class="" style="display: none;" fb-options="{'rowid':'CombineOrderPrice','initialRows':'','maxrows':'','content':''}" rowid="CombineOrderPrice" style="height: 26px;">
      <td class="">
        <input name="LessLoadPrice" readonly class="edit form-control transparent" f-options="{'code':'LessLoadPrice','type':'number','etype':'','len':''}" verify="{'title':'LessLoadPrice','length':'','required':true,'textarea1':true}">
      </td>
      <td class="">
        <input name="FullLoadPrice" readonly class="edit form-control transparent" f-options="{'code':'FullLoadPrice','type':'number','etype':'','len':''}" verify="{'title':'FullLoadPrice','length':'','required':true,'textarea1':true}">
      </td>
      <td class="">
        <input name="PickPrice" readonly class="edit form-control transparent" f-options="{'code':'PickPrice','type':'number','etype':'','len':''}" verify="{'title':'PickPrice','length':'','required':true,'textarea1':true}">
      </td>
       <td class="">
        <input name="DeliveryPrice" readonly class="edit form-control transparent" f-options="{'code':'DeliveryPrice','type':'number','etype':'','len':''}" verify="{'title':'DeliveryPrice','length':'','required':true,'textarea1':true}">
      </td>
      <td class="">
        <input name="OnLoadPrice" readonly class="edit form-control transparent" f-options="{'code':'OnLoadPrice','type':'number','etype':'','len':''}" verify="{'title':'OnLoadPrice','length':'','required':true,'textarea1':true}">
      </td>
      <td class="">
        <input name="OffLoadPrice" readonly class="edit form-control transparent" f-options="{'code':'OffLoadPrice','type':'number','etype':'','len':''}" verify="{'title':'OffLoadPrice','length':'','required':true,'textarea1':true}">
      </td>
      <td class="">
        <input name="AdditionPrice" readonly class="edit form-control transparent" f-options="{'code':'AdditionPrice','type':'number','etype':'','len':''}" verify="{'title':'AdditionPrice','length':'','required':true,'textarea1':true}">
      </td>
      <td class="">
        <input name="InsuranceCost" class="edit form-control transparent" f-options="{'code':'InsuranceCost','type':'number','etype':'','len':''}" verify="{'title':'InsuranceCost','length':'','required':true,'textarea1':true}">
      </td>
      <td class="" >
        <input name="TaxPrice" readonly class="edit form-control transparent" f-options="{'code':'TaxPrice','type':'number','etype':'','len':''}" verify="{'title':'TaxPrice','length':'','required':true,'textarea1':true}">
      </td>
      <td class="nozero"  colspan="">
        <input name="TotalAmounts"  readonly class="edit form-control transparent" f-options="{'code':'TotalAmounts','type':'number','etype':'','len':''}" verify="">
      </td>
    </tr>
      <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    <tr>
        <td class="td_name" colspan="11">备注</td>
    </tr> 
     <tr>
        <td colspan="11" style="height:100px;">
          <textarea name="Description" readonly style="line-height: 28px;height:100px;"  class="edit form-control transparent" f-options="{'code':'Description','type':'richtext','etype':'','len':''}" verify="{'title':'Description','length':'','textarea1':true}"></textarea>
        </td>
    </tr>
    <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
      <tr style="height: 26px;">
		<td class="td_name" colspan="10">报价单跟踪信息</td>
	</tr>                
	<tr class="" name="TrackDetail" style="height: 26px;">
		<td  colspan="10">
			<span name="History"></span>
			<div style="display:none">
				<span name="InsertTime" view-fld='{fld:"InsertTime",method:"show"}'></span>
				<span name="CreatorName" view-fld='{fld:"Creator",method:"show"}'></span>
				<span name="SrcStatusName" view-fld='{fld:"SrcStatus",method:"show"}' ></span>
				<span name="DstStatusName" view-fld='{fld:"DstStatus",method:"show"}'></span>
				<span name="Operation" view-fld='{fld:"Operation",method:"show"}'></span>
				<span name="Descriptions" view-fld='{fld:"description",method:"show"}'></span>
				<span name="CompanyName" view-fld='{fld:"CompanyName",method:"show"}'></span>
			</div>
		</td>
	</tr>
     
  </tbody>
 </table>
<!-- 表单结尾 -->
</div>
<div class="page"></div>
    <div name="first-ds-pag">
        <div style="text-align:center;display:none">
            <ul class="pag pagination">
                <li class="bord_li prev"><a href="#">
                    <img src="/assets/NSF/images/left.png" /></a>
                </li>
                <li class="bord_li next"><a href="#">
                    <img src="/assets/NSF/images/right.png" /></a>
                </li>
                <li class="bord_li border_li_marg showrec">每页<span class="pagesize"></span>条 ， 共<span class="recamount"></span>条</li>
            </ul>
        </div>
    </div>
<!--通用页尾开始-->
<!--#include file="/Controls/PMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        setTimeout("initTableForm($('#cf7f9153-cb57-415d-8a41-6a4695b6dd1a')),autoHead()", 300);//初始化固定头部的宽度
        setTimeout( 'carNmae(),SetOrderID();hoverTips()', 2000 );
        var _docid = getUrlParam('id');
        $("body").attr( "code", getUrlParam( 'code' ) );

        if (getUrlParam('code') == 'SelfSent')
        {
            $('.agreenBtn').css('display', 'none');
            $('.noBtn').css('display', 'none');
            $('.saveBtn').css('display', 'none');
            $('.sendBtn').css('display', 'none');
        }

        $('tr[name="TrackDetail"]').attr('view-id', '{ id:"pml_0026",cross:"false", rowIdentClass:"TrackDetail", paras:[{"name":"docid","value":' + _docid + '}]}');
        var _myEvents = new NSF.System.Data.Grid();
        _myEvents.Pagination("first-ds-pag", $("div[name='first-ds-pag']"));
        _myEvents.Initialize("/", "TrackDetail", $("tr[name='TrackDetail']").attr("view-id"), $("tr[name='TrackDetail']"));
        $('.TrackDetail').each(function (index) {
            var _History;
            var _InsertTime = $(this).find('span[name="InsertTime"]').text();
            var _CreatorName = $(this).find('span[name="CreatorName"]').text();
            var _SrcStatusName = $(this).find('span[name="SrcStatusName"]').text();
            var _DstStatusName = $(this).find('span[name="DstStatusName"]').text();
            var _Operation = $(this).find('span[name="Operation"]').text();
            var _Description = $(this).find('span[name="Descriptions"]').text();
			var _CompanyName = $( this ).find( 'span[name="CompanyName"]' ).text();

            if (_Operation == '0') {
                _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CompanyName + '：' + _CreatorName + '发送了报价单，并将报价单状态从' + _SrcStatusName + '变成' + _DstStatusName;
            }
            else if (_Operation == '1') {
                _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CompanyName + '：' + _CreatorName + '拒绝了报价单，将报价单打回到待发送列表，订单状态变成' + _DstStatusName + '，拒绝原因：' + _Description;
            }
            if (_DstStatusName == "待审核") {
                $('.saveBtn').css('display', 'none');
                $('.agreenBtn').css('display', 'inline-block');
            } else {
                $('.agreenBtn').css('display', 'none');
            }

            $(this).find('span[name="History"]').text(_History);
        });

        $('body').attr( 'code', getUrlParam('code'));
    };
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script type="text/javascript">
    function carNmae()
    {
        for ( var i = 0; i < $( 'input[name="CarType"]' ).length; i++ )
        {
            var index = $( 'tr[nrowid="PMS_FullLoad"] input[name="CarType"]' ).eq( i ).parent().parent().index();
            var cartype = $( 'table tr' ).eq( index ).find( 'input[name="CarType"]' ).val();
            CarTypes( cartype, index );
        }
    }
    function GetOrderID( val ){
        $('input[name="Code"]').attr('onclick', 'location.href="index_edit.aspx?id='+ val +'"');

        return true;
    }
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/PMS/JS.aspx"-->
<script type="text/javascript">
    /*浏览器窗口变化时，固定头部宽度赋值*/
    $(window).resize(function () {
        autoHead();
    });
    /*固定头部宽度赋值*/
    function autoHead() {
        var autoW = $('.formcontainer').width() + 2-10;//+2是为了解决兼容边框
        $('.tr-fixed').css('width', autoW + 'px');
    }
</script>
<script src="/assets/request_minify.js"></script>
</body>
</html>
