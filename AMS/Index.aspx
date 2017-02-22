<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>公司信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/AMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="Index">


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
<!--#include file="/Controls/AMS/header.aspx"-->
<!--通用头部文件结尾-->

<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
	var __saveNdtCfg = '{"main":{"insertVml":"tms_0044","updateVml":"tms_0045","queryVml":"company_reading"}}';
</script>
 <table class="FormTable Y_alter FormTable6" style="width:100%;" id="1f0f7b31-aaf6-483c-b7b1-1d4c6304f1a5" path="OTMS/company" code="company">
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
      <td class="text-left" rowspan="1" colspan="3" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">公司信息</p></div></td>
      <td colspan="3" style="border:0; border-bottom:1px solid #e1e6eb;">
        <input type="hidden" name="id">
        <asp:Label ID="Label2" runat="server">
                <input type="hidden" class="form-control"  name="UserID" value=<%=GetUserID()%>  />
         </asp:Label>
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <a class="btn btn-red footKeepBtn" href="javascript:void(0);" ev="%23saveNDT%23">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>
            <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#1f0f7b31-aaf6-483c-b7b1-1d4c6304f1a5'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
    <tr>
      <td class="td_name">公司全称<span class="need_write">*</span></td>
      <td rowspan="1">
        <input name="Name" title="公司全称" readonly oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'300'}" verify="{'title':'公司全称','required':true}">
      </td>
      <td class="td_name">企业法人<span class="need_write">*</span></td>
      <td class="">
        <input name="Master" title="企业法人" oc="text" class="edit form-control transparent" f-options="{'code':'Master','type':'text','etype':'editable','len':'100'}" verify="{'title':'企业法人','required':true}">
      </td>      
      <td class="td_name" rowspan="5" style="text-align:center;">公司logo</td>
      <td class="" rowspan="5">
         <input type="file" title="图片" oc="image" class="edit form-control droparea spot" name="Logo" data-post="/ImageUploader.aspx?filename=Logo&mode=droparea" data-width="50" data-height="50" data-crop="true" f-options="{'code':'Logo','type':'image','etype':'editable','len':'300'}" verify="{}">      
      </td>      
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">公司编号</td>
      <td class="">
        <input name="ClientCode" title="公司编号" readonly oc="text" class="edit form-control transparent" f-options="{'code':'ClientCode','type':'text','etype':'editable','len':'50'}" verify="{}">
      </td>
      <td class="td_name">公司网站</td>
      <td class="" rowspan="1" colspan="">
        <input name="Web" title="公司网站" placeholder="例：www.wlyuan.com.cn" oc="text" class="edit form-control transparent" f-options="{'code':'Web','type':'text','etype':'editable','len':'300'}" verify="{}">
      </td>

    </tr>
    <tr style="height: 26px;">
      <td class="td_name">所属行业</td>
      <td class="">
       <input type="hidden" name="Industry">
        <select name="Industry_id" title="---------------------------" oc="combobox" class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);" f-options="{'code':'Industry','type':'combobox','etype':'editable','len':'32'}" verify="{}">
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
      <td class="td_name">公司英文名</td>
      <td class="">
        <input name="EnName" title="公司英文名" oc="text" class="edit form-control transparent" f-options="{'code':'EnName','type':'text','etype':'editable','len':'200'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">公司简称</td>
      <td class="">
        <input name="ShortName" title="公司简称" oc="text" class="edit form-control transparent" f-options="{'code':'ShortName','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
      <td class="td_name">我是个体司机</td>
      <td class="" rowspan="1" colspan="">
        <input name="IsPersonal" type="hidden">
        <input name="PersonalName" title="我是个体司机" oc="text" class="edit form-control transparent" f-options="{'code':'PersonalName','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">英文简称</td>
      <td class="">
        <input name="ShortEnName" title="英文简称" oc="text" class="edit form-control transparent" f-options="{'code':'ShortEnName','type':'text','etype':'editable','len':'200'}" verify="{}">
      </td>
      <td class="td_name">我是园区</td>
      <td class="" rowspan="1" colspan="">
          <ul class="list-inline">
            <li><input type="checkbox"  class="control-check" name="IsZone" value="1"  /></li>
        </ul>
      </td>
    </tr>
    <tr style="height:26px;">
      <td class="td_name">联系人<span class="need_write">*</span></td>
      <td class="" colspan="">
        <input name="Contact" title="联系人" oc="text" class="edit form-control transparent" f-options="{'code':'Contact','type':'text','etype':'editable','len':'300'}" verify="{'title':'联系人','required':true}">
      </td>
      <td class="td_name">我是集团本部</td>
      <td class="" rowspan="1" colspan="">
          <ul class="list-inline">
            <li><input type="checkbox"  class="control-check" name="IsGroup" value="1"  /></li>
        </ul>
      </td>
      <td class="td_name" rowspan="5" style="text-align:center;">营业执照</td>
       <td class="" rowspan="5">
         <input type="file" title="营业执照" oc="image" class="edit form-control droparea spot" name="LicensePic" data-post="/ImageUploader.aspx?filename=LicensePic&mode=droparea" data-width="50" data-height="50" data-crop="true" f-options="{'code':'LicensePic','type':'image','etype':'editable','len':'50'}" verify="{}">      
       </td>      
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">联系电话<span class="need_write">*</span></td>
      <td class="">
        <input name="Phone" title="联系电话" oc="text" class="edit form-control transparent" f-options="{'code':'Phone','type':'text','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','required':true,'textarea1':true,'validate':'{\'pattern\': \'^((([0\+][0-9]{2,3}-)?(0[0-9]{2,3})-)?([0-9]{7,8})?(([0-9]{7,8})(-([0-9]{3,}))?))?(([1][3|4|5|7|8][0-9])[0-9]{8})?$\',\'message\': \'格式不正确，请重新输入！\'}'}">
      </td>
      <td class="td_name">传真</td>
      <td class="">
        <input name="Fax" title="传真" oc="text" class="edit form-control transparent" f-options="{'code':'Fax','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>

    </tr>
    <tr style="height: 26px;">
      <td class="td_name">邮箱</td>
      <td class="">
        <input name="Mail" class="edit form-control transparent" f-options="{'code':'Mail','type':'text','etype':'editable','len':'200'}" verify="{}">
      </td>
      <td class="td_name">地址<span class="need_write">*</span></td>
      <td class="">
        <input name="Address" class="edit form-control transparent" f-options="{'code':'Address','type':'text','etype':'editable','len':'300'}" verify="{'title':'地址','required':true}">
      </td>
    </tr>
    <tr style="height:26px;">
       <td class="td_name">邮编</td>
      <td>
        <input name="Zip" placeholder="例：200000" class="edit form-control transparent" f-options="{'code':'Zip','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
      <td class="td_name">微信公众号</td>
      <td class="">
        <input name="WeiXin" class="edit form-control transparent" f-options="{'code':'WeiXin','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name">公司开户行</td>
      <td class="">
        <input name="Bank" class="edit form-control transparent" f-options="{'code':'Bank','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
      <td class="td_name">银行账号</td>
      <td class="">
        <input name="BankAccount" class="edit form-control transparent" f-options="{'code':'BankAccount','type':'text','etype':'editable','len':'100'}" verify="{}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td  rowspan="1" class="td_name">公司简介</td>
      <td class="" rowspan="1" colspan="5" style="height:60px;">
        <textarea style="padding:0;" name="Description" class="edit form-control transparent" f-options="{'code':'Description','type':'richtext','etype':'editable','len':'300'}" verify="{}"></textarea>
      </td>
    </tr>
  </tbody>
 </table>
<!-- 表单结尾 -->
</div>

<!--通用页尾开始-->
<!--#include file="/Controls/AMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        initTableForm($('#1f0f7b31-aaf6-483c-b7b1-1d4c6304f1a5'),0,function() {
          var _isPerson = $('input[name="IsPersonal"]').val();
          if ( _isPerson == "1") {
              $('input[name="PersonalName"]').val('是');
          } else {
              $('input[name="PersonalName"]').val('否');
          }
        },'dbo.fn_pub_user_User2CompanyID(@Operator,0)' )
        setTimeout("hoverTips()", 700);
        //2067 公司管理员：勾选我是本部，点击保存后，页面我是本部勾选消失，刷新后才可出现
        setTimeout("ifBoxChecked()", 1000);
         
    };
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/AMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
