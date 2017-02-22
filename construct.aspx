<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>服务条款-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="../../images/otms.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/login.css" />
</head>
<body code="TMS_construct">
    <div class="login_container">
         <div class="container">
             <div class="row">
                 <p class="constructTip">
                      服务条款内容整理中。。。
                 </p>
                <p class="col-md-12 login_copyright text-center">Copyright©<%=DateTime.Now.Year%>&nbsp;&nbsp;上海南软信息科技有限公司版权所有&nbsp;&nbsp;沪ICP备15052516号-1</p>
             </div>
             
         </div>
    </div>
	<script type="text/javascript">
		var reqeustDone = function () {		/*所有JS加载完成以后执行*/
			//
		};

	</script>
	<script src="/assets/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript">
		$(function(){
			var wh=$(window).height();
			$('.login_container').css('height',wh+'px');
		} )
		function tab_collapse( that )
		{
		    $( '.collapse' ).collapse( 'hide' )
		    $( that ).next( '.collapse' ).collapse( 'show' )
		}
    </script>
    <style>
		.login_container h4
		{
			margin-bottom:0;
            font-size:14px;
		}
		.panel-heading
		{
			background-color:#2A518C !important;
			border-color:#2A518C !important;
		}
		.panel-heading a
		{
			display:block;
		}
        .panel-heading a:hover
        {
            color:#f60;
        }
        .constructTip {
            font-size:25px; color:white; font-family:'微软雅黑';text-align:center; margin-top:300px;
         }
	</style>
</body>
</html>
