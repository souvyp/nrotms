<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>API信息-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/AMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="API">


<!--通用头部文件开始-->
<!--#include file="/Controls/AMS/header.aspx"-->
<!--通用头部文件结尾-->

<!-- 通用对话框开始-->
    <div class="row">
	    <div class="col-sm-12">
		    <div class="content" >
                    <div class="modal-header" style="padding-left:0;padding-top:25px;">
                        <div class="modal-title" id="gridSystemModalLabel" style="background-color:#f27302; position:relative;">
                            <p style="margin-left:3px; padding-left:10px; background-color:white;">API信息</p>
                            <span style=" position:absolute; right:-14px; top:0;">  
                               <button type="button" class="btn" onclick="exit()" >返回&nbsp;<span class="glyphicon glyphicon-share-alt" ></span></button>
                            </span>
                        </div>
                    </div>
                <div class="" style="padding:20px;padding-left:0;position:relative;"><!--modal-body-->
                    <div class="container" style="padding-left:0;">
                        <div class="row col-md-6 into " style="padding-left:0;">
                            <label class="col-md-3 control-label newPassLab">AppID：</label>
                            <div class="col-md-6">
                                <label id="RegAppID" class="col-md-3 control-label rNPassLab"></label>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6 into " style="padding-left:0;">
                            <label class="col-md-3 control-label newPassLab">是否审核:</label>
                            <div class="col-md-6">
                                <label id="confirmed" class="col-md-3 control-label rNPassLab"></label>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6" style="padding-left:0;">
                            <label class="col-md-3 control-label accountLab">API申请：</label>
                            <div class="col-md-6 ">
                                <button type="button" class="btn footKeepBtn register" onclick="RegisterLicense()" title="申请">申请</button>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6" style="padding-left:0;">
                            <label class="col-md-3 control-label passLab">API接入：</label>
                            <div class="col-md-6">
                                <button type="button" class="btn footKeepBtn" onclick="IntoLicense()" title="接入">接入</button>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6 into hide" style="padding-left:0;">
                            <label class="col-md-3 control-label newPassLab">AppID：</label>
                            <div class="col-md-6">
                                <label id="AppID" class="col-md-3 control-label rNPassLab"></label>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6 into hide" style="padding-left:0;">
                            <label class="col-md-3 control-label rNPassLab">HelloToken：</label>
                            <div class="col-md-6">
                                <label id="HelloToken" class="col-md-3 control-label rNPassLab"></label>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6 into hide" style="padding-left:0;">
                            <label class="col-md-3 control-label rNPassLab">AesKey：</label>
                            <div class="col-md-6">
                                <label id="AesKey" class="col-md-3 control-label rNPassLab"></label>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6 into hide" style="padding-left:0;">
                            <label class="col-md-3 control-label rNPassLab">ClientUrl：</label>
                            <div class="col-md-6">
                              <textarea class="form-control" id="ClientUrl"></textarea>
                                <input type="hidden" id="LicenseID">
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="row col-md-6 into hide" style="padding-left:0;">
                            <label class="col-md-3 control-label rNPassLab"></label>
                            <div class="col-md-6">
                                <button type="button" class="btn footKeepBtn" onclick="checkLicense()" title="检测">检测</button>
                            </div>
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
        var pmls = '[{"namespace":"protocol","cmd":"data","version":1,"id":"API_003","paras":[]}]';
        NSF.System.Network.Ajax("/Portal.aspx" ,
        pmls,
        'POST',
        false,
        function(result, data) {
            if (data[0].result) {
                if (data[0].rs.length != 0) {
                    $('#RegAppID').text(data[0].rs[0].rows[0].appid);
                    $('.register').addClass('disabled');
                    $('.register').removeClass('footKeepBtn');
                    if (data[0].rs[0].rows[0].Confirmed == "1") {
                        $('#confirmed').text('是');
                    } else {
                        $('#confirmed').text('否');
                    }
                } 
            } else {
                alert( data[0].msg );
            }
        });
    };

    var _jsUrl = "<%=MinifyUrl("FormJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/AMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
