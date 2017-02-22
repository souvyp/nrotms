<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>角色分配-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/AMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="DriverUserList">

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
    <!-- modal 页面显示-->
  <div class="modal fade" id="supModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog">
          <div class="modal-content" style="width:400px;margin-left:78px;margin-top:50px;" >
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">使用提醒</p>
                    </div>
                </h4>
                </div>
                <div class="modal-body" style="font-size:12px;padding-bottom:50px;padding-top:35px;font-family:'微软雅黑';">
                   		 
                </div>
             
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
 </div>	
<!--通用头部文件开始-->
<!--#include file="/Controls/AMS/header.aspx"-->
<!--通用头部文件结尾-->

<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
    var __saveNdtCfg = '{"main":{"insertVml":"tms_0060","updateVml":"tms_0049","queryVml":""}}';
</script>
    <form role="form" id="GeneralForm">
         <table class="FormTable Y_alter" style="width:100%;" id="aac020bc-8346-4ed4-8241-643afe621e3d" path="OTMS_TEST/UserList" code="UserList">
          <colgroup>
            <col style="width: 120px;">
            <col style="width: 120px;">
            <col style="width: 120px;">
            <col style="width: 120px;">
            <col class="" style="width: 120px;">
            <col style="width:120px;" class="">
            <col style="width:120px;">
            <col style="width:120px;">
          </colgroup>
          <tbody>
            <tr>
              <td class="text-left" rowspan="1" colspan="4" style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">角色分配</p></div></td>
              <td colspan="4" style="border:0; border-bottom:1px solid #e1e6eb;">
                <input type="hidden" name="id">
                <div class="toolbar">
                  <div style="text-align:right;" class="button_workflow">
<%--                    <button type="button" class="btn user-submit fr" ev="%23saveNDT%23"  onclick="UserAdd()" >提交&nbsp;<span class="glyphicon glyphicon-ok-circle"></span></button>--%>
                     <a class="btn btn-red footKeepBtn" href="javascript:void(0);"  onclick="UserAdd(this)">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk"></span></a>
                      <a  class="btn fr" onclick="back()" >返回&nbsp;<span class="glyphicon glyphicon-share-alt" style=" transform:rotateY(180deg);"></span></a>
                  </div>
                  <div class="clear"></div>
                  <div class="content_workflow"></div>
                </div>
              </td>
            </tr>
            <tr>
              <td rowspan="1" colspan="8" style="background-color:white; border:0;height:15px;"></td>
            </tr>
            <tr style="height: 26px;" class="">
              <td class="td_name">账号<span class="need_write">*</span></td>
              <td class="" rowspan="1" colspan="2">
                <input name="Acccount" title="只包含字母、数字、下划线、中杠、点；不允许使用特殊字符和汉字" oc="text" class="edit form-control transparent" f-options="{'code':'Acccount','type':'text','etype':'editable','len':'100'}" verify="{'title':'账号','length':'100','required':true,'textarea1':true,'validate':'{\'pattern\': \'^[a-zA-Z_0-9.-]{1,100}$\',\'message\':\' 格式不正确，请重新输入！\'}'}">
              </td>
              <td class="td_name">密码<span class="need_write">*</span></td>
              <td class="" rowspan="1" colspan="2">
                <input name="Password"  type="password" title="密码长度6-14位，字母区分大小写" oc="text" class="edit form-control transparent" f-options="{'code':'Password','type':'text','etype':'editable','len':'100'}" verify="{'title':'密码','length':'100','required':true}">
              </td>
              <td rowspan="6" colspan="2">
                <input type="file" title="头像" oc="image" class="edit form-control droparea spot" name="Photo" data-post="/ImageUploader.aspx?filename=Photo&mode=droparea" data-width="50" data-height="50" data-crop="true" f-options="{'code':'Photo','type':'image','etype':'editable','len':'255'}" verify="{}">
              </td>
            </tr>
            <tr style="height: 26px;">
              <td class="td_name">角色<span class="need_write">*</span></td>
              <td class="" rowspan="1" colspan="2">
              		<span name="RoleID" class="hide">547</span>
              		<input type="hidden"  name="RoleID" value="547" />
              		<span name=" " value="547" >
              			
              			<span class="hide gou-btn gouChecked"></span>
              		 	<input type="checkbox"  class="hide" name="RoleID_id" value="547" checked="true" /></li>
              		 	个体司机
              		</span>
                   	<span class="hide" name="UserType">2</span>
                   	<input type="hidden"  name="UserType" value="2" />                		
                </ul>
              </td>
              <td class="td_name">再次输入密码<span class="need_write">*</span></td>
              <td class="" rowspan="1" colspan="2">
                <input name="RePassword"  type="password" title="密码长度6-14位，字母区分大小写" oc="text" class="edit form-control transparent" f-options="{'code':'Password','type':'text','etype':'editable','len':'100'}" verify="{'title':'密码','length':'100','required':true}">
              </td>              
            </tr>
            <tr style="height: 26px;">
              <td class="td_name">昵称</td>
              <td rowspan="1" colspan="2">
                <input name="Nickname" title="昵称" oc="text" class="edit form-control transparent" f-options="{'code':'Nickname','type':'text','etype':'editable','len':'100'}" verify="{}">
              </td>
              <td class="td_name">姓名<span class="need_write">*</span></td>
              <td class="" rowspan="1" colspan="2">
                <input name="Name" title="姓名" oc="text" class="edit form-control transparent" f-options="{'code':'Name','type':'text','etype':'editable','len':'100'}" verify="{'title':'姓名','length':'100','required':true}">
              </td>
            </tr>
            <tr style="height: 26px;">
              <td class="td_name">生日</td>
              <td class="" rowspan="1" colspan="2">
                <input name="Birthday" title="生日" oc="date" class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'Birthday','type':'date','etype':'editable','len':'50'}" verify="{}">
              </td>
              <td class="td_name">性别</td>
              <td rowspan="1" colspan="2">
                  <ul class="edit form-control list-inline" name="Gender" type="radio" f-options="{'code':'Gender','type':'radio','etype':'editable','len':'1','cls':'list','url':'男\r\n女','id':'','text':''}" verify="{}">
                    <li>
                      <input type="radio" name="Gender" value="0" class="edit-list transparent" checked>男
                    </li>
                    <li>
                      <input type="radio" name="Gender" value="1" class="edit-list transparent">女
                    </li>
                  </ul>

              </td>
            </tr>
            <tr style="height: 26px;">
              <td class="td_name">联系电话</td>
              <td class="" rowspan="1" colspan="2">
                <input name="Phone" title="联系电话" oc="number" class="edit form-control transparent" f-options="{'code':'Phone','type':'number','etype':'editable','len':'100'}" verify="{'title':'联系电话','length':'100','textarea1':true,'validate':'{\'pattern\': \'^((([0\+][0-9]{2,3}-)?(0[0-9]{2,3})-)?([0-9]{7,8})?(([0-9]{7,8})(-([0-9]{3,}))?))?(([1][3|4|5|7|8][0-9])[0-9]{8})?$\',\'message\': \'格式不正确，请重新输入！\'}'}">
              </td>
              <td class="td_name">所属组织</td>
              <td class="" rowspan="1" colspan="2">
                <input name="Dept" title="所属组织" oc="text" class="edit form-control transparent" f-options="{'code':'Dept','type':'text','etype':'editable','len':'100'}" verify="{}">
              </td>
            </tr>
            <tr style="height: 26px;">
              <td class="td_name">职位</td>
              <td class="" rowspan="1" colspan="5">
                <input name="Duty" title="职位" oc="text" class="edit form-control transparent" f-options="{'code':'Duty','type':'text','etype':'editable','len':'100'}" verify="{}">
              </td>
            </tr>
          </tbody>
         </table>
    </form>
<!-- 表单结尾 -->
</div>

<!--通用页尾开始-->
<!--#include file="/Controls/AMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    function _DoPageLoad()
    {
        initTableForm($('#aac020bc-8346-4ed4-8241-643afe621e3d'), false, function () {
            ifChecked();
            ifBoxChecked();   
            $('.gou-btn').css({ "background": "url(../images/gou.png)", "background-size": "10px 10px", 'border': '1px solid #f27302' });
          $('.gou-btn').next('input').attr("checked", true);
          $('.gou-btn').unbind('click');         
        });
    }
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/

        setTimeout("_DoPageLoad()", 500);
    };
	
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/AMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
