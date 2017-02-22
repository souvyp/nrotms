<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>合单补充报价- <%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="MySending">

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
<!-- 通用对话框开始1-->
<div class="modal fade text-center" id="CarType_Length" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" style="width:auto;display: inline-block;">
        <div class="modal-content">
			<div class="modal-header" style="padding: 5px 10px;">
			</div>
            <div class="" style="padding:20px;position:relative">
                <div class="content">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 通用对话框1结尾 -->
<!-- 通用对话框2开始 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    

                    <h4 class="modal-title text-left" id="myModalLabel">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">发送报价单</p>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    是否确定发送报价单
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                    <button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="AdditionSend(1)"><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left: 2px;"></span></button>
                    <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left: 2px; color: #888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
<!-- 通用对话框2结尾 -->
<!--通用头部文件开始-->
<!--#include file="/Controls/PMS/header.aspx"-->
<!--通用头部文件结尾-->

<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
    var __saveNdtCfg = '{"main":{"insertVml":"tms_0226","updateVml":"tms_0226","queryVml":"pml_0035"},"AdditionPrice":{"insertVml":"","updateVml":"","queryVml":"city_addition_query","deleteVml":"pml_0018"},"OrderContains":{"insertVml":"","updateVml":"","queryVml":"pml_0036","deleteVml":""}}';
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
                  <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">合单补充报价</p>
              </div>
          </div>
      </td>
      
      <td colspan="5" style="border: 0;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <a class="btn btn-red footKeepBtn saveBtn" href="javascript:void(0);"  onclick="AdditionSend(0)">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>
            <a class="btn btn-red footKeepBtn sendBtn" href="javascript:void(0);" title="发送报价单" onclick="IsSend()">发送&nbsp;<span class="glyphicon glyphicon-send"></span></a>
            <a class="btn btn-red footKeepBtn agreenBtn" href="javascript:void(0);" onclick="VerifyDoc()" style="display:none;">同意&nbsp;<span class="glyphicon glyphicon-ok-sign"></span></a>
              <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#cf7f9153-cb57-415d-8a41-6a4695b6dd1a'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
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
          <input name="Code" title="单据编号" oc="text" placeholder="系统自动生成" readonly class="edit form-control transparent" f-options="{'code':'Code','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
      <td class="td_name">制单日期</td>
      <td class="" rowspan="1" colspan="2">
          <input name="CreateTime" title="制单日期" style="font-size:12px;" placeholder="系统自动生成" oc="date" disabled class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'CreateTime','type':'date','etype':'editable','len':'50'}" verify="">
          <input type="hidden"  name="DocID" value=0>    <!--报价单ID-->
          <input type="hidden"  name="Issend"  id="Issend"/>     <!--1:发送 0保存-->
          <input type="hidden"  name="Type" value="5">
          <input type="hidden" name="OrderID" value=0 >
          <input type="hidden" name="Name" value=0 >        <!--报价单名称-->
          <input type="hidden" name="CustomerID" value="0"/>
          <input type="hidden" name="AddpriceLst" value=""/>
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
      </td>
      <td class="" rowspan="1" colspan="2">
         <input name="CustomerName" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'CustomerName','length':'50','required':true}">
      </td>
      <td class="td_name">承运方</td>
      <td class="" rowspan="1" colspan="3">
          <input name="SupplierName" title="" oc="text" placeholder="" readonly class="edit form-control transparent" f-options="{'code':'SupplierName','type':'text','etype':'editable','len':'100'}" verify="{}">
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
      <td class="backgroundGray" rowspan="1" colspan="1">收货方</td>
      <td class="backgroundGray" rowspan="1" colspan="">发货时间</td>
      <td class="backgroundGray" rowspan="1" colspan="1">发货地址</td>
      <td class="backgroundGray" rowspan="1" colspan="1">收货地址</td>
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
      </td>
      <td class="" rowspan="1" colspan="1">
        <input name="endusername" readonly class="edit form-control transparent" f-options="{'code':'endusername','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="">
        <input name="FromTime" readonly class="edit form-control transparent" f-options="{'code':'FromTime','type':'date','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="1">
        <input name="from" readonly class="edit form-control transparent" f-options="{'code':'to','type':'number','etype':'','len':''}" verify="{}">
      </td>
      <td class="" rowspan="1" colspan="1">
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
    <tr style="height: 26px;">
      <td class="td_name" colspan="">零担</td>
      <td class="td_name" colspan="">整车</td>
      <td class="td_name" colspan="">提货费</td>
      <td class="td_name" colspan="">送货费</td>
      <td class="td_name" colspan="">装货费</td>
      <td class="td_name" colspan="">卸货费</td>
      <td class="td_name" colspan="">保险费</td>
      <td class="td_name" colspan="">税费</td>
      <td class="td_name" colspan="">附加费</td>
      <td class="td_name" colspan="">合计</td>
    </tr>
    <tr style="height: 26px;">
      <td class="" >
          <input name="LessLoad"   readonly placeholder="" class="edit form-control transparent" >
      </td>
      <td class="" >
          <input name="FullLoad"   readonly placeholder="" class="edit form-control transparent" >
      </td>
      <td class="" >
          <input name="Pick"   readonly placeholder="" class="edit form-control transparent" >
      </td>
      <td class="" >
          <input name="Delivery"   readonly placeholder="" class="edit form-control transparent" >
      </td>
      <td class="" >
          <input name="OnLoad"   readonly placeholder="" class="edit form-control transparent" >
      </td>
      <td class="" >
          <input name="OffLoad"   readonly placeholder="" class="edit form-control transparent" >
      </td>
      <td class="" >
          <input name="InsuranceCost"   readonly placeholder="" class="edit form-control transparent" >
      </td>
      <td class="" >
          <input name="Tax"   readonly placeholder="" class="edit form-control transparent" >
      </td>
      <td class="" >
          <input name="Addition"   readonly placeholder="" class="edit form-control transparent" >
      </td>
      <td class="" >
          <input name="Total"   readonly placeholder="" class="edit form-control transparent" >
      </td>
      
    </tr>
      <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="" rowspan="1" colspan="10" style="border:0;font-size:13px;"><span class="glyphicon glyphicon-record"></span>附加费</td>
    </tr>
    <tr style="height: 26px;">
      <td class="backgroundGray" rowspan="1" colspan="1"  style="border-right:0;">价格</td>
    <td class="backgroundGray" rowspan="1" colspan="2" style="border-right:0;">费用类型</td>  
      <td class="backgroundGray" rowspan="1" colspan="1" style="border-right:0;">说明</td>
      <td class="backgroundGray" style="border:none;"></td>
      <td class="backgroundGray" style="border:none;"></td>
      <td class="backgroundGray" style="border:none;"></td>
      <td class="backgroundGray" style="border:none;"></td>
      <td class="backgroundGray" style="border-left:0;"></td>
      <td class="backgroundGray">
        <a href="javascript:void(0);" tar="AdditionPrice" name="add" class="button edit" executecode="%23add%23" f-options="{'code':'add','type':'_button','etype':'','len':''}" verify="{'title':'add','length':'','textarea1':true}">新增</a>
      </td>
    </tr>
    <tr style="height: 26px; display: none;" nrowkey="DetailID" class="AdditionPrice" fb-options="{'rowid':'MinPrice','initialRows':'','maxrows':'','content':''}" rowid="AdditionPrice">
      <td class="" rowspan="1" colspan="1">
    <input type="hidden" name="DetailID" value="0" />
                      <!--1966 补充报价，允许填入负数-->
        <input name="Price" onkeyup="value=value.replace(/[^\d.-]/g,'')" class="edit form-control transparent" f-options="{'code':'Price','type':'number','etype':'','len':''}" verify="{'title':'Price','length':'','required':true}">
      </td>
      <td class="" colspan="2">
            <input type="hidden" name="AdditionType" value="0" >
        <select name="AdditionType_id" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);" f-options="{'code':'AdditionType_id','type':'combobox','etype':'','len':'','cls':'vml','vml':'','id':'','text':'','linkfield':'','linkcombo':''}" verify="{}">
              <option value="0">无</option>
              <option value="1">上楼费</option>
              <option value="2">倒车费</option>
              <option value="999">其它</option>
          </select>
      </td>      
      <td class="" rowspan="1" colspan="6">
        <textarea name="Description" class="edit form-control transparent" f-options="{'code':'Description','type':'richtext','etype':'','len':''}" verify="{'title':'Description','length':'','textarea1':true}"></textarea>
      </td>
      <td class="">
        <a href="javascript:void(0);" tar="AdditionPrice" class="button edit" executecode="%23delete%23" f-options="{'code':'','type':'_button','etype':'','len':''}" verify="{'title':'','length':'','textarea1':true}">删除</a>
      </td>
    </tr>
      <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
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
        var _docid = getUrlParam('id');
        setTimeout( 'CarName();rowAdd();SetOrderID();OrderPriceShow('+ getUrlParam("OrderID") +');hoverTips()', 2000 );

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
            /*if (_DstStatusName == "待审核") {
                $('.saveBtn').css('display', 'none');
                $('.agreenBtn').css('display', 'inline-block');
            } else {
                $('.agreenBtn').css('display', 'none');
            }*/

            $(this).find('span[name="History"]').text(_History);
            
        });
        EdtCombPrice_Keydown();
    };
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script type="text/javascript">
    
    function GetOrderID( val ){
        $('input[name="Code"]').attr('onclick', 'location.href="index_edit.aspx?id='+ val +'"');

        return true;
    }
</script>

 
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/PMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
