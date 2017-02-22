<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="techns">
<head>
    <meta charset="utf-8" />

    <title>注册</title>
    <meta content="" name="keywords" />
    <meta content="" name="description" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="data-spm" content="" />
    <meta name="_ww_csrf_header" content="8fffa1a0-0317-429b-a565-0c6be9132835" />
    <!--静态资源公共部分-->
    <link rel="shortcut icon" href="Resources/others/images/logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="css/bootstrap-style.css" />
    <link rel="stylesheet" href="/css/login.css" />
    <link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css" />

    <script type="text/javascript" src="assets/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <%--NSF--%>
    <script  type="text/javascript" src="assets/NSF/js/NSF.0.0.3.min.js"></script>
    <%--others--%>
    <script  type="text/javascript" src="js/login.js"></script>
    <script  type="text/javascript" src="js/login-ui.js"></script>
    <style type="text/css">
        ul li {
            height:60px;
            list-style:none;
        }
    </style>
</head>
<body class="register_resultcon" style="background:url(images/bg2.jpg) 0 0 no-repeat; background-size:100% 100%;">
    <div class="container" style="height:612px;">
         <div class="">
        <div class="content">
                <div class="modal-body">
                    <div class="container ">
                        <div style="text-align:center; margin-top:180px;">
                            <div>
                                <img src="images/zhucechenggong.png" width="80">
                            </div>
                            <div style="color:white;">
                                 <h1>恭喜您注册成功！</h1>
                                 <p>请耐心等待管理员的审核......</p>
                            </div>
                            <br />
                            <br />
                            <div>
                                <button onclick="location.href='Login.aspx'" class="btn btn-default" style="color: #EB662B;font-family: '微软雅黑';font-weight: bold;">返回登录</button>
                                <button onclick="location.href='Register.aspx'" class="btn btn-default" style="color: #EB662B;font-family: '微软雅黑';font-weight: bold;">继续注册</button>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    </div>
    
    <div style="text-align:center;font-family:'微软雅黑';font-size:1px; position:absolute; width:100%; bottom:0;">
        <!--<img src="images/sol-circle-v.png" style="width:100%;" />-->
        <!--<span>Copyright &nbsp; 2015 &nbsp; 湖南南软信息科技有限公司 &nbsp; 版权所有&nbsp; 湘ICP备15002327号</span>-->
    </div>
    
    <script type="text/javascript">
	    $(function(){
			$(function(){
				var wh=$(window).height();
				$('.register_resultcon').css('height',wh+'px');
			})
		})
	</script>
    
</body>
</html>
