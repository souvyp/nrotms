<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>承运方信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="SupplierList">

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

<div class="modal fade" id="supModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog">
          <div class="modal-content" >
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">邀请承运方</p>
                    </div>
                </h4>
                </div>
                <div class="modal-body">
                    邀请成功，是否继续邀请承运方!
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                <button type="button" class="btn btn-default  okButton footKeepBtn" onclick="javascript:location.href='SupplierList_edit.aspx'" style="margin-right:8px; box-shadow:none; text-shadow:none;" aria-label="OK" title="确定"  ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
                <button type="button" class="btn btn-default " onclick="javascript:location.href='SupplierList.aspx'" data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
    </div>

<!--通用头部文件开始-->
<!--#include file="/Controls/PMS/header.aspx"-->
<!--通用头部文件结尾-->

<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
    var __saveNdtCfg = '{"main":{"insertVml":"tms_0062","updateVml":"","queryVml":"tms_0085"}}';
</script>
 <table class="FormTable Y_alter" style="width:100%;" id="60eeb3b4-c3e1-4225-943d-2b83f7377390" path="OTMS_TEST/eonrfvtq" code="eonrfvtq">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
  </colgroup>
  <tbody>
    <tr>
      <td class="text-left" colspan="4"  style="font-size: 14px; border:0; border-bottom:1px solid #e1e6eb;padding-right:0; padding-left:0;"><div style="padding-left:3px; background-color:#f27302;"><p style="background-color:white;padding-left:8px;height:20px; line-height:20px; margin-bottom:25px; ">承运方信息</p></div></td>
      <td colspan="4" style="border:0; border-bottom:1px solid #e1e6eb;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
            <a class="btn btn-red footKeepBtn" href="javascript:void(0);" ev="%23saveNDT%23">发送&nbsp;<span class="glyphicon glyphicon-send"></span></a>
            <%--<a class="btn btn-red" href="javascript:void(0);" onclick="printURLTable($('#60eeb3b4-c3e1-4225-943d-2b83f7377390'))">打印&nbsp;<span class="glyphicon glyphicon-print"></span></a>--%>
            <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
    <tr>
       <td rowspan="1" colspan="8" style="height:15px; border:0; background-color:white;"></td>
    </tr>
    <tr style="height: 26px;">
        <td class="td_name"  > 
                公司编号
        </td>
        <td class=""  colspan="7">
            <input name="CompanyCode" class="edit form-control transparent"  f-options="{'code':'CompanyCode','type':'text','etype':'editable','len':'100'}" verify="{'title':'公司编号','length':'100','required':true}">
        </td>    

    </tr>

  <tr style="height: 26px;">
        <td class="td_name"  > 
                公司名称
        </td>
        <td class=""  colspan="7">
            <input class="edit form-control transparent com"  name="CompanyName" f-options="{'code':'CompanyName','type':'text','etype':'editable','len':'100'}" readonly placeholder="根据公司编号自动获取" />
        </td>    

    </tr>
    <tr style="height: 100px;">
      <td class="td_name" colspan="1">邀请信</td>
      <td colspan="7">
        <textarea name="InviteDesc" class="edit form-control transparent" f-options="{'code':'InviteDesc','type':'richtext','etype':'editable','len':'600'}" verify="{'title':'邀请信','length':'600','required':true}"></textarea>
  </tbody>
 </table>
<!-- 表单结尾 -->
</div>

<!--通用页尾开始-->
<!--#include file="/Controls/PMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        setTimeout( "initTableForm($('#60eeb3b4-c3e1-4225-943d-2b83f7377390'))", 300 );
        $( 'input[name="CompanyCode"]' ).change( function ()
        {
            NSF.System.Data.RecordSet( "/", { id: "tms_0200", cross: "false", paras: [{ "name": "ClientCode", "value": $( this ).val() }] }, function ( result, config, data )
            {
                if ( data[0].rows[0].Name != '' )
                {
                    $( '.com' ).val( data[0].rows[0].Name );
                }
                else
                {

                    $( 'input[name="CompanyCode"]' ).val( '' ); $( '.com' ).val( '' );
                    $( 'input[name="CompanyCode"]' ).attr( 'placeholder', '编号对应承运方不存在，请核对' );
                }
            } );
        } );

    };
	var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/PMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
