<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>HELP-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="../../images/otms.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/login.css" />
    <style>
        .helpList li a {
            line-height:30px;
            padding-left:10px;
            color:#2A518C;
        }
    </style>
</head>
<body code="TMS_HELP">
    <div class="login_container">
         <div class="container">
             <div class="row">
                 <div class="col-md-6 login_margin" style="margin:auto; margin-top:150px;float: none;">
					<div class="login_logo" style="border-top-left-radius:10px; border-top-right-radius:10px; padding:3px 25px 0;">
						<h3 style="color:#f60;"><a href="Index.aspx"><img src="/images/A.png" style="width:60px; margin-left:-20px;"></a>HELP<a href="javascript:history.go(-1)"><span class="glyphicon glyphicon-remove pull-right" style="color:#f90; position:relative; top:10px;"></span></a></h3>
					</div>
					<div style="padding:20px;background:rgba(255,255,255,0.8);border-radius:0 0 5px 5px">						
						<ul class="helpList">
                            <li><a href="物流源报价系统操作手册.pdf">物流源报价系统操作手册</a></li>
                            <li><a href="物流源快速入门指南.pdf">物流源快速入门指南</a></li>
                            <li><a href="物流源产品白皮书.pdf">物流源产品白皮书</a></li>
						</ul>
					</div>
                </div>
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
	</style>
</body>
</html>
