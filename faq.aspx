<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>FAQ-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="../../images/otms.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/login.css" />
</head>
<body code="TMS_FAQ">
    <div class="login_container">
         <div class="container">
             <div class="row">
                 <div class="col-md-6 login_margin" style="margin:auto; margin-top:150px;float: none;">
					<div class="login_logo" style="border-top-left-radius:10px; border-top-right-radius:10px; padding:3px 25px 0;">
						<h3 style="color:#f60;"><a href="Index.aspx"><img src="/images/A.png" style="width:60px; margin-left:-20px;"></a>FAQ<a href="javascript:history.go(-1)"><span class="glyphicon glyphicon-remove pull-right" style="color:#f90; position:relative; top:10px;"></span></a></h3>
					</div>
					<div style="padding:20px;background:rgba(255,255,255,0.8);border-radius:0 0 5px 5px">						
						<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
							<div class="panel panel-default">
								<div class="panel-heading" role="tab" onclick="tab_collapse(this)">
									<h4 class="panel-title">
										<a role="button" data-toggle="collapse" data-parent="#accordion" href="">
											Q：密码忘记了？
										</a>
									</h4>
								</div>
								<div class="panel-collapse collapse">
									<div class="panel-body">
										A：请公司的管理员重置密码。
									</div>
								</div>
							</div>
						</div>
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
		var _jsUrl = "<%=MinifyUrl("ListJs")%>";
	</script>
	<script src="/assets/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var wh = $(window).height();
            $('.login_container').css('height', wh + 'px');
        })
        function tab_collapse(that) {
            $('.collapse').collapse('hide')
            $(that).next('.collapse').collapse('show')
        }
    </script>
	<script src="/assets/request_minify.js"></script>
    
    <style>
		.login_container h4
		{
			margin-bottom:0;
            font-size:14px;
		}
		.panel-heading
		{
			background-color:transparent !important;
			border-color:transparent !important;
			/*background-color:#2A518C !important;
			border-color:#2A518C !important;*/
		}
		.panel-heading a
		{
			display:block;
			color:#2A518C;
		}
        .panel-heading a:hover
        {
            color:#f60;
        }
		.panel{background-color:transparent; border:0; box-shadow:none;}
		.panel-body{ border:0 !important; padding-left:15px;}
	</style>
</body>
</html>
