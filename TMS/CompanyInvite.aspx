<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyInvite.aspx.cs" Inherits="OTMS.CompanyInvite" %>
<!doctype html>
<html>
<head>
    <title>邀请</title>
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

    <form id="form1" runat="server">
    <asp:Panel ID="Panel1" runat="server" Visible="False">
        <div class="col-sm-12 container-fluid">
            <div class="content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H1">邀请
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
                    <button type="submit" class="btn btn-default">邀请</button>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="Panel2" runat="server" Visible="False">
    <div class="col-sm-4 container-fluid" style="margin:60px 100px;">
        <div class="content">
                
                <div class="modal-body">
                    <div class="container">
                        <div class="col-md-6">
                            <div class="col-md-12">
                                <label class="col-md-6 control-label">请扫描右<br />边的二维<br />码,关注注<br />册地址</label>
                                <div class="col-md-6 weixing" ></div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="col-md-6">
                            <div class="col-md-12">
                                <label class="col-md-6 control-label">注册地址</label>
                                <div class="col-md-6" >
                                    <%=RegisterUrl%>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-6">
                            <div class="col-md-12">
                                <div class="col-md-6" >
                                <button type="button" class="btn btn-default" onclick="back()">返回</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    </asp:Panel>
    
    <asp:Panel ID="Panel3" runat="server" Visible="False">
    <div class="col-sm-4 container-fluid" style="margin:140px 300px;">
        <div class="content">
                <div class="modal-body">
                    <div class="container">
                        <div>
                            邀请成功！
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="col-md-6">
                            <button type="button" class="btn btn-default" onclick="back()">返回</button>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    </asp:Panel>

    <!--通用页尾开始-->
    <!--#include file="/Controls/TMS/footer.aspx"-->
    <!--通用页尾结尾-->

    <script type="text/javascript">
        var reqeustDone = function ()
        {
            /*所有JS加载完成以后执行*/
            if ( typeof ( initHeader ) != "undefined" ) initHeader();					/*初始化页面通用头部*/
            if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/

            var _qrObj = $( ".weixing" );
            if ( _qrObj.length > 0 )
            {
                var _url = "<%=RegisterUrl%>";
                if ( _url == "" )
                {
                    _url = "http://otms.techns.com.cn/register.aspx";
                }
                NSF.System.Widgets.QRCode( _qrObj, _url, 100, 100 );
            }

            NSF.System.Data.RecordSet( "/", { id: "company_reading", cross: "false", paras: [{}] }, CompanyDetail );
            
        }

        function CompanyDetail( result, config, data )
        {
            if ( result )
            {
                var _row = data[0].rows[0];
                $( 'input[name="SrcID"]' ).val( _row.id );
                $( 'input[name="SrcName"]' ).val( _row.Name );
            }

        }
    </script>
     <!--其他JS开始-->
    <!--#include file="/Controls/JS.aspx"-->
	<!--#include file="/Controls/TMS/JS.aspx"-->
    <!--其他JS结尾-->
    <script src="/assets/request_list.js"></script>
    </form>
</body>
</html>
