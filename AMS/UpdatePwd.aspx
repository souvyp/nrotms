<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>修改密码-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/AMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="UpdatePwd">


<!--通用头部文件开始-->
<!--#include file="/Controls/AMS/header.aspx"-->
<!--通用头部文件结尾-->

<!-- 通用对话框开始-->
    <div class="row">
	    <div class="col-sm-12">
		    <div class="content" >
                    <div class="modal-header" style="padding-left:0;padding-top:25px;">
                        <div class="modal-title" id="gridSystemModalLabel" style="background-color:#f27302; position:relative;">
                            <p style="margin-left:3px; padding-left:10px; background-color:white;">修改密码</p>
                            <span style=" position:absolute; right:-14px; top:0;">  
                                <button type="button" class="btn footKeepBtn" onclick="UpdatePwdSave()">提交&nbsp;<span class="glyphicon glyphicon-ok-circle" style=""></span></button>
                               <button type="button" class="btn" onclick="passWordReset()" >重置&nbsp;<span class="glyphicon glyphicon-refresh"></span></button>
                            </span>
                        </div>
                    </div>
                <div class="" style="padding:20px;padding-left:0;position:relative;"><!--modal-body-->
                    <div class="container" style="padding-left:0;">
                        <div class="row col-md-6" style="padding-left:0;">
                            <label class="col-md-3 control-label accountLab">用户账号：</label>
                            <div class="col-md-6 ">
                                <input type="hidden" name="CompanyID" />
                                 <asp:Label ID="Label2" runat="server">
                                    <input type="text" class="form-control" readonly name="Username" value=<%=GetUsername()%>  />
                                </asp:Label>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6" style="padding-left:0;">
                            <label class="col-md-3 control-label passLab">输入原密码：</label>
                            <div class="col-md-6">
                                <input type="password"  class="form-control" name="OldPwd" placeholder="请输入原密码"/>
                            </div>
                            <p class="tipsP"><span class="need_write">*</span></p>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6" style="padding-left:0;">
                            <label class="col-md-3 control-label newPassLab">请输入新密码：</label>
                            <div class="col-md-6">
                                <input type="password"  class="form-control" name="NewPwd" placeholder="请输入新密码"/>
                            </div>
                            <p class="tipsP"><span class="need_write">*</span>强度：密码长度6-14位，字母区分大小写</p>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6" style="padding-left:0;">
                            <label class="col-md-3 control-label rNPassLab">重新输入新密码：</label>
                            <div class="col-md-6">
                                <input type="password"  class="form-control" name="ReOldPwd" placeholder="请重新输入新密码"/>
                            </div>
                            <p class="tipsP"><span class="need_write">*</span></p>
                        </div>
                    </div>
                </div>
		    </div>
	    </div>
    </div>
<!--通用页尾开始-->
<!--#include file="/Controls/AMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if ( typeof ( initHeader ) != "undefined" ) initHeader();					/*初始化页面通用头部*/
        if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/
        $( 'input[name="NewPwd"],input[name="ReOldPwd"]' ).change( function ()
        {
            if ( $( this ).val().length < 5 || $( this ).val().length > 14 )
            {
                alert( '密码长度为6-14位' );
                $( this ).val( '' );
            }
        } );
    };

    var _jsUrl = "<%=MinifyUrl("FormJs")%>";
    function passWordReset() {
        $('input[name="OldPwd"],input[name="NewPwd"],input[name="ReOldPwd"]').val('');
    };
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/AMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
