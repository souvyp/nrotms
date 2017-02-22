<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>收货方信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="EndUser">

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
	var __saveNdtCfg = '{"main":{"insertVml":"tms_0052","updateVml":"tms_0052","queryVml":"tms_0054"}}';
</script>
 <table class="FormTable Y_alter FormTable6" style="width:100%;" id="ff16d45e-2a27-410c-b34b-797bbe0a943b" path="OTMS/ouoaevwb" code="ouoaevwb">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col class="" style="width: 120px;">
    <col style="width:120px;">
  </colgroup>
  <tbody>
    <tr>
      <td class="text-left" rowspan="1" colspan="3" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">收货方信息</p></div></td>
      <td colspan="3" style="border:0; border-bottom:1px solid #e1e6eb;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#ff16d45e-2a27-410c-b34b-797bbe0a943b'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
            <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
    <tr>
      <td rowspan="1" colspan="6" style="background-color:white; border:0;height:15px;"></td>
    </tr>
    <tr style="height: 26px;display:none;">
      <td class="styleCenter" rowspan="1" colspan="6" style="font-size: 18px;background-color: rgb(242, 242, 242);">
          <input type="hidden" name="EndUserID"> />
      </td>
    </tr>
    <tr style="height: 26px;">
       <td class="td_name">
                <input type="hidden" name="CustomerID" value="0" >所属客户
        </td>
        <td class="" rowspan="1" colspan="1">
            <input name="CustomerName" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'所属客户','length':'50'}">
        </td>
      <td class="td_name">公司全称</td>
      <td class="" rowspan="1" colspan="1">
        <input name="Name" title="公司全称" oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'300'}" verify="{'title':'公司全称','length':'300','required':true,'textarea1':true,'validate':'{\'pattern\': \'^[ |a-zA-Z|\u4e00-\u9fa5|\（）|\()|-]*$\',\'message\': \'格式不正确，请重新输入！\'}'}">
      </td>
      <td class="td_name" rowspan="4" style="text-align:center;">公司logo</td>
      <td rowspan="4">
        <input type="file" oc="image" class="edit form-control droparea spot"  name="Logo" data-post="/ImageUploader.aspx?filename=Logo&mode=droparea" data-width="50" data-height="50" data-crop="true" f-options="{'code':'Logo','type':'image','etype':'editable','len':'300'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">所属行业</td>
      <td class="">
        <input type="hidden" name="Industry">
        <select name="Industry_id" title="所属行业" oc="combobox" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);" f-options="{'code':'Industry','type':'combobox','etype':'editable','len':'32'}" verify="{}">
           <option value="0">---------------------------</option>
            <option value="1">信息产业</option>
            <option value="2">金融/银行</option>
            <option value="3">建筑/建材</option>
            <option value="4">物流/运输</option>
            <option value="5">医药卫生</option>
            <option value="6">机械机电</option>
            <option value="7">轻工食品</option>
            <option value="8">服装纺织</option>
            <option value="9">水利水电</option>
            <option value="10">环保绿化</option>
            <option value="11">其它行业</option>
        </select>
      </td>
      <td class="td_name">公司网站</td>
      <td class="" rowspan="1" colspan="1">
        <input name="Web" title="公司网站" placeholder="例如：www.wlyuan.com.cn"  oc="text" class="edit form-control transparent" f-options="{'code':'Web','type':'text','etype':'editable','len':'300'}" verify="{'title':'公司网站','length':'300','url':true}" style="border:0;">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">公司简称</td>
      <td class="">
        <input name="ShortName" title="公司简称" oc="text" class="edit form-control transparent" f-options="{'code':'ShortName','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
      <td class="td_name">公司英文名</td>
      <td class="">
        <input name="EnName" class="edit form-control transparent"  f-options="{'code':'EnName','type':'text','etype':'editable','len':'200'}" verify="{'title':'公司英文名','length':'200','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^[A-Za-z]+$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">英文简称</td>
      <td class="">
        <input name="ShortEnName"  class="edit form-control transparent" f-options="{'code':'ShortEnName','type':'text','etype':'editable','len':'50'}" verify="{'title':'英文简称','length':'50','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^[A-Za-z]+$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
      </td>
      <td class="td_name">企业法人</td>
      <td class="">
        <input name="Master" class="edit form-control transparent" f-options="{'code':'Master','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
    <tr style="height:26px;">
      <td class="td_name">联系人</td>
      <td class="">
        <input name="Contact" title="联系人" oc="text" class="edit form-control transparent" f-options="{'code':'Contact','type':'text','etype':'editable','len':'300'}" verify="{}">
      </td>
      <td class="td_name">联系电话</td>
      <td class="">
        <input name="Phone" title="联系电话"  oc="text" class="edit form-control transparent" f-options="{'code':'Phone','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','required':true,'textarea1':true,'validate':'{\'pattern\': \'^((([0\+][0-9]{2,3}-)?(0[0-9]{2,3})-)?([0-9]{7,8})?(([0-9]{7,8})(-([0-9]{3,}))?))?(([1][3|4|5|7|8][0-9])[0-9]{8})?$\',\'message\': \'格式不正确，请重新输入！\'}'}">
      </td>
      <td class="td_name" rowspan="5" style="text-align:center">营业执照</td>
      <td class="" rowspan="5">
        <input type="file" oc="image" class="edit form-control droparea spot"  name="License" data-post="/ImageUploader.aspx?filename=License&mode=droparea" data-width="50" data-height="50" data-crop="true" f-options="{'code':'License','type':'image','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">传真</td>
      <td class="">
        <input name="Fax" title="传真" oc="text"  class="edit form-control transparent" f-options="{'code':'Fax','type':'text','etype':'editable','len':'100'}" verify="{'title':'传真','length':'100','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^[+]{0,1}([0-9]){1,3}[ ]?([-]?(([0-9])|[ ]){1,12})+$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
      </td>
      <td class="td_name">邮箱</td>
      <td class="">
        <input name="Mail" placeholder="例如：support@wlyuan.com.cn" title="support@wlyuan.com.cn"  class="edit form-control transparent"  f-options="{'code':'Mail','type':'text','etype':'editable','len':'200'}" verify="{'title':'邮箱','length':'200','mail':true}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">地址</td>
      <td class="">
        <input name="Address" class="edit form-control transparent" f-options="{'code':'Address','type':'text','etype':'editable','len':'300'}" verify="{}">
      </td>
      <td class="td_name">邮编</td>
      <td>
        <input name="Zip" placeholder="例如：200000" class="edit form-control transparent"  f-options="{'code':'Zip','type':'text','etype':'editable','len':'100'}" verify="{'title':'邮编','length':'100','textarea1':true,'validate':'\t\t\t\t\t\t\t\t\t\t\t{\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'pattern\': \'^[1-9][0-9]{5}(?![0-9])$\',\r\n\t\t\t\t\t\t\t\t\t\t\t\t\'message\': \'格式不正确，请重新输入！\'\r\n\t\t\t\t\t\t\t\t\t\t\t}\r\n\t\t\t\t\t\t\t\t\t\t'}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">微信公众号</td>
      <td class="">
        <input name="WeiXin" class="edit form-control transparent" f-options="{'code':'WeiXin','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
      <td class="td_name">公司开户行</td>
      <td class="">
        <input name="Bank" class="edit form-control transparent" f-options="{'code':'Bank','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
    <tr style="height:26px;">
      <td class="td_name">银行账号</td>
      <td class="" colspan="3">
        <input name="BankAccount" class="edit form-control transparent" f-options="{'code':'BankAccount','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 100px;">
      <td  rowspan="1" class="td_name">公司简介</td>
      <td class="" rowspan="1" colspan="5" >
        <textarea style="padding:0;" name="Description" class="edit form-control transparent" f-options="{'code':'Description','type':'richtext','etype':'editable','len':'65536'}" verify="{}"></textarea>
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
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        setTimeout("initTableForm($('#ff16d45e-2a27-410c-b34b-797bbe0a943b'))", 300);

        var pmls = '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0099","paras":[]}]';
        NSF.System.Network.Ajax( '/Portal.aspx',
          pmls,
          'POST',
          false,
          function ( result, data )
          {
            if( result )
            {
              $('input[name="CustomerName"]').attr('placeholder',data[0].rs[0].rows[0].name);
              $('input[name="CustomerName"]').val(data[0].rs[0].rows[0].name);
              $('input[name="CustomerID"]').val(data[0].rs[0].rows[0].id);
              $('input[name="CompanyID"]').val(data[0].rs[0].rows[0].companyid);
            }
          } );

          $('input:not(.droparea),textarea').attr('readonly', 'readonly');
          $('select').attr('disabled', 'disabled');

          setTimeout(function() {
            $('input.droparea').attr('type', '');
          }, 2000);
    };
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
