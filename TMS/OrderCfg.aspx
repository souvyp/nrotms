<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>配置信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="OrderCfg">


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

<!--通用头部文件开始-->
<!--#include file="/Controls/TMS/header.aspx"-->
<!--通用头部文件结尾-->

<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
	var __saveNdtCfg = '{"main":{"insertVml":"tms_0216","updateVml":"tms_0216","queryVml":"tms_0217"}}';
</script>
 <table class="FormTable Y_alter FormTable6" style="width:100%;" id="1f0f7b31-aaf6-483c-b7b1-1d4c6304f1a5" path="OTMS/company" code="CompanyCfg">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
  </colgroup>
  <tbody>
    <tr>
      <td class="text-left" rowspan="1" colspan="5" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">配置信息</p></div></td>
      <td colspan="" style="border:0; border-bottom:1px solid #e1e6eb;">
        <input type="hidden" name="id">
        <asp:Label ID="Label2" runat="server">
                <input type="hidden" class="form-control"  name="UserID" value=<%=GetUserID()%>  />
         </asp:Label>
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <a class="btn btn-red footKeepBtn" href="javascript:void(0);" onclick="orderCfg(this)">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>
            <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#1f0f7b31-aaf6-483c-b7b1-1d4c6304f1a5'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
    <tr>
      <td rowspan="1" colspan="6" style="background-color:white; border:0;height:15px;"></td>
    </tr>
    
    <tr style="height: 26px;">
		<td class="td_name">计费模式</td>
		<td class="" colspan="2">
			<input type="hidden" name="ChargeMode" value="0">
			<select name="ChargeMode_id" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);Unit(this)" f-options="{'code':'ChargeMode','type':'combobox','etype':'','len':''}" verify="{'title':'计费模式','length':'','textarea1':true}">
			  <option value="">-------------------------</option>
			  <option value="1">重量</option>
			  <option value="2">体积</option>
			  <option value="3">数量</option>
			</select>
		 </td>
		<td class="td_name">价格单位</td>
	   <td class="" colspan="2">
		<input type="hidden" name="PriceUnit" value="0">
		<select name="PriceUnit_id" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);UnitType(this)" f-options="{'code':'PriceUnit','type':'combobox','etype':'','len':''}" verify="{'title':'价格单位','length':'','textarea1':true}">
		  <option value="">-------------------------</option>
		  <!--#include file="/Controls/Unit.aspx"-->
		</select>
	  </td>
	</tr>
	
	<tr style="height: 26px;">
		<td class="td_name">包装方式</td>
		<td class="" colspan="2">
			<ul class="list-inline">
				<li>
					<label><input type="radio" name="PackageMode" value="1">散箱</label></li>
				<li>
					<label><input type="radio" name="PackageMode" value="2">托盘或木箱</label></li>
				<li>
					<label><input type="radio" name="PackageMode" value="3">托盘、木箱或不规则形状</label></li>
			</ul>
		</td>
	 <td class="td_name">货物分类</td>
	  <td class="" rowspan="1" colspan="2">
		  <ul class="list-inline" >
			<li><input type="hidden"   name="GoodsCategory" value="" />
			<input type="checkbox"  class="control-check" name="Goodscategory" value="1"  /><span class="goods">普通货物</span></li>
			<li><input type="checkbox"  class="control-check" name="Goodscategory" value="2"  /><span class="goods">危险品</span></li>
			<li><input type="checkbox"  class="control-check" name="Goodscategory" value="4"  /><span class="goods">温控货物</span></li>
		</ul>
	  </td>
	</tr>
	<tr style="height: 26px;">
		<td class="td_name">是否提货</td>
        <td class="" colspan="2">                       
            <ul class="list-inline">
                <li>
                    <label><input type="radio" name="IsPick" value="1">是</label></li>
                <li>
                    <label><input type="radio" name="IsPick" value="0"  >否</label></li>            	
 
            </ul>                   
        </td> 
        <td class="td_name">是否装货</td>
        <td class="" colspan="2">                       
            <ul class="list-inline">
                <li>
                    <label><input type="radio" name="IsOnLoad" value="1">是</label></li>
                <li>
                    <label><input type="radio" name="IsOnLoad" value="0"  >否</label></li>
            </ul>                   
        </td> 
    </tr>
    <tr style="height: 26px;">
    	<td class="td_name">是否送货</td>
        <td class="" colspan="2">
            <ul class="list-inline">
                <li>
                    <label><input type="radio" name="IsDelivery" value="1">是</label></li>
                <li>
                    <label><input type="radio" name="IsDelivery" value="0"  >否</label></li>
            </ul>   
        </td>
        <td class="td_name">是否卸货</td>
        <td class="" colspan="2">                       
            <ul class="list-inline">
                <li>
                    <label><input type="radio" name="IsOffLoad" value="1">是</label></li>
                <li>
                    <label><input type="radio" name="IsOffLoad" value="0"  >否</label></li>
            </ul>                   
        </td>                    
    </tr>
	<tr style="height: 26px;">
		<td class="td_name">是否保价</td>
		<td class="" colspan="5">
			<ul class="list-inline">
				<li>
					<label><input type="radio"  name="IsInsurance" value="1"  >是</label></li>
				<li>
					<label><input type="radio"  name="IsInsurance" value="0">否</label></li>                            
			</ul>
		</td>
	</tr>
	
  </tbody>
 </table>
<!-- 表单结尾 -->
</div>

<!--通用页尾开始-->
<!--#include file="/Controls/TMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    function _DoPageLoad() {
        initTableForm($('#1f0f7b31-aaf6-483c-b7b1-1d4c6304f1a5'), false, function () {
            selectBs();
            GoodsCategory();
            ifChecked();
            ifBoxChecked();
        },'dbo.fn_pub_user_User2CompanyID(@Operator,0)');
    }
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        setTimeout("_DoPageLoad()", 300);

        
    };
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/AMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
