<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="techns">
<head>
    <meta charset="utf-8" />

    <title>关于-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta content="" name="keywords" />
    <meta content="" name="description" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="data-spm" content="" />
    <meta name="_ww_csrf_header" content="8fffa1a0-0317-429b-a565-0c6be9132835" />
    <!--静态资源公共部分-->
    <link rel="shortcut icon" href="images/otms.ico" type="image/x-icon" />
    <link rel="stylesheet" href="css/bootstrap-style.css" />
    <link rel="stylesheet" href="/css/login.css" />
    <link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css" />

    <script type="text/javascript" src="assets/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <%--NSF--%>
    <script src="http://otms.zld.com.cn/assets/NSF/js/NSF.0.0.3.min.js"></script>
    <%--<script  type="text/javascript" src="assets/NSF/js/NSF.js"></script>
    <script  type="text/javascript" src="assets/NSF/js/NSF.System.js"></script>
    <script  type="text/javascript" src="assets/NSF/js/NSF.System.Network.js"></script>
    <script  type="text/javascript" src="assets/NSF/js/NSF.System.Data.js"></script>--%>
    <%--others--%>
    <script  type="text/javascript" src="js/login.js"></script>
    <script  type="text/javascript" src="js/login-ui.js"></script>
</head>
<body>
    <div class="login_container">
         <div class="container">
             <div class="row">
                 <div class="col-md-6 login_margin" style="margin-left:25%; margin-top:180px;">
                      <div class="login_main_container">
                          <div class="login_logo" style="border-top-left-radius:10px; border-top-right-radius:10px; padding:3px 25px 0;">
                              <h3 style="color:#f60;"><img src="images/A.png" style="width:60px; margin-left:-20px;"/>关于<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%><a href="javascript:history.go(-1)"><span class="glyphicon glyphicon-remove pull-right" style="color:#f90; position:relative; top:10px;"></span></a></h3>
                          </div>
                          <div class="form-horizontal login_form" style="background-color:rgba(255,255,255,0.8);border-bottom-left-radius:10px; border-bottom-right-radius:10px; padding:30px 25px 5px;">
                              <p style="color:#666; font-size:12px; line-height:25px;">版本：<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%> V<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductVersion")%><br />
                                 网址：<a href="http://www.wlyuan.com.cn/">www.wlyuan.com.cn</a><br />
                                 版权所有：<a href="http://www.techns.com.cn"> 上海南软信息科技有限公司</a>
                               </p>
                              <p class="text-right" style="margin-top:80px;"><%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%>&nbsp;<a href="construct.aspx" style="color:#0099CB;">服务条款</a></p>
                          </div>
                      </div>
                 </div>
                 <p class="col-md-12 login_copyright text-center">Copyright©<%=DateTime.Now.Year%>&nbsp;&nbsp;上海南软信息科技有限公司版权所有&nbsp;&nbsp;沪ICP备15052516号-1</p>
             </div>
             
         </div>
    </div>
    <script type="text/javascript">
		$(function(){
			var wh=$(window).height();
			$('.login_container').css('height',wh+'px');
		})
    </script>
</body>
</html>
