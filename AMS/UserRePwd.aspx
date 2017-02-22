<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>

<!doctype html>
<html>
<head>
    <title>重置用户密码</title>
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

<div class="row">
    <div class="col-sm-12">
        <div class="content">
            <div class="modal-header" style="padding-left:0;padding-top:25px;">
                <div class="modal-title" id="gridSystemModalLabel" style="background-color:#f27302; position:relative;">
                    <p style="margin-left:3px; padding-left:10px; background-color:white;">重置用户密码</p>
                    <span style=" position:absolute; right:-14px; top:0;">
                        <button type="button" class="btn footKeepBtn" onclick="ReUserPwd($('input[name=\'Username\']').val(), $('input[name=\'Pwd\']').val())">保存&nbsp;<span class="glyphicon glyphicon-floppy-disk" style=""></span></button>
                        <button type="button" class="btn" onclick="back()" >返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></button>
                    </span>
                </div>
            </div>
            <div class="modal-user" style="padding-left:0;padding-top:20px">
                <div class="container" style="padding-left:0;">
                    <div class="row col-md-6" style="padding-left:0;">
                        <label class="col-md-3 control-label">用户账号：</label>
                        <div class="col-md-6 ">
                            <input type="text" class="form-control"  name="Username" placeholder="用户账号：" />
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <br />
                    <div class="row col-md-6" style="padding-left:0;">
                        <label class="col-md-3 control-label">用户密码：</label>
                        <div class="col-md-6">
                            <input type="password" class="form-control" name="Pwd" placeholder="用户密码" />
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>

    <!--通用页尾开始-->
    <!--#include file="/Controls/TMS/footer.aspx"-->
    <!--通用页尾结尾-->

    <script type="text/javascript">
        var reqeustDone = function () {		/*所有JS加载完成以后执行*/
            if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
            if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/

            $('input[name="Username"]').val(NSF.UrlVars.Get('account', location.href));
            $('input[name="Pwd"]').val('');
        };

        var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/AMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
