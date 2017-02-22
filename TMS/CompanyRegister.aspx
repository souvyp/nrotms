<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyInvite.aspx.cs" Inherits="OTMS.CompanyInvite" %>
<!doctype html>
<html>
<head>
    <title>注册</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
</head>
<body code="CompanyInvite">
    <!--额外的css开始-->
    <!--#include file="/Controls/CSS.aspx"-->
    <!--额外的css结尾-->


    <!--通用头部文件开始-->
    <!--#include file="/Controls/TMS/header.aspx"-->
    <!--通用头部文件结尾-->


    <div class="col-sm-12 container-fluid">
        <div class="content">
            <form role="form" action="/CompanyInvite.aspx">
                <div class="modal-header">
                    <h4 class="modal-title" id="H1">注册
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row col-md-6">
                            <label class="col-md-3 control-label">邀请公司名称</label>
                            <div class="col-md-6 ">
                                <input type="text" class="form-control" name="DstName" placeholder="公司名称" />
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6">
                            <input type="radio" class="col-md-1" value="1" name="InviteMode" />
                            <label class="col-md-2 control-label">邮件</label>
                            <div class="col-md-6">
                                <input type="email" class="form-control" name="DstMail" placeholder="邮件地址" />
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6">
                            <input type="radio" class="col-md-1" name="InviteMode" value="2" />
                            <label class="col-md-3 control-label">微信</label>
                            <input type="hidden" name="SrcID" placeholder="邀请者的公司编号" />
                            <input type="hidden" name="SrcName" placeholder="邀请者的公司名称" />
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6">
                            
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="back()">返回</button>
                    <button type="submit" class="btn btn-default">注册</button>
                </div>
            </form>
        </div>
    </div>



    <!--通用页尾开始-->
    <!--#include file="/Controls/TMS/footer.aspx"-->
    <!--通用页尾结尾-->

    <script type="text/javascript">
        var reqeustDone = function ()
        {		/*所有JS加载完成以后执行*/
            if ( typeof ( initHeader ) != "undefined" ) initHeader();					/*初始化页面通用头部*/
            if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/
        }
    </script>
     <!--其他JS开始-->
    <!--#include file="/Controls/JS.aspx"-->
	<!--#include file="/Controls/TMS/JS.aspx"-->
    <!--其他JS结尾-->
    <script src="/assets/request_form.js"></script>
</body>
</html>
