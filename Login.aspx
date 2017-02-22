<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="techns">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>登录- <%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta content="" name="keywords" />
    <meta content="" name="description" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="data-spm" content="" />
    <meta name="_ww_csrf_header" content="8fffa1a0-0317-429b-a565-0c6be9132835" />
	<!--#include file="/Controls/Meta.aspx"-->
    <!--静态资源公共部分-->
    <link rel="shortcut icon" href="images/otms.ico" type="image/x-icon" />
    <link rel="stylesheet" href="css/bootstrap-style.css" />
    <link rel="stylesheet" href="/css/login.css" />
    <link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css" />

    <script type="text/javascript" src="assets/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <%--NSF--%>
    <script src="assets/NSF/js/NSF.0.0.3.min.js"></script>
    <%--others--%>
    <script  type="text/javascript" src="js/login.js"></script>
    <script  type="text/javascript" src="js/login-ui.js"></script>
<style>
    .login_margin{ margin-top:0 !important;}
.login_main_container{ width:40%; margin:auto;}
.login_logo{  text-align:center;}
.login_logo img{ max-width:90%; margin-left:0; }
@media (max-width:998px)
{
	.login_main_container{ width:80%;}
	.login_form .col-md-4,.login_form .col-md-6{ float:left;}
    .login_form .col-md-4{ width:35%;}
	.login_form .col-md-6{ width:65%;}
}
@media (max-width:340px)
{
	.login_main_container{ width:85%;}
	.login_form .col-md-4{ width:38%;}
	.login_form .col-md-6{ width:62%;}
}
</style>
</head>
<body>
    <!--密码账号错误的模态框-->
  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog">
          <div class="modal-content" style="width:400px;margin-left:78px;margin-top:50px;" >
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                <%--<button type="button" class="close" 
                    data-dismiss="modal" aria-hidden="true">
                        &times;
                </button>--%>
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">登录失败</p>
                    </div>
                </h4>
                </div>
                <div class="modal-body" style="font-size:12px;padding-bottom:50px;padding-top:35px;font-family:'微软雅黑';">
                    您输入的账号密码不匹配或者授权已过期，请与管理员联系！
                </div>
               <%-- <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                    <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>--%>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
 </div>

    <!--当用户使用的浏览器不是火狐、360、谷歌时，登陆页面显示-->
  <div class="modal fade" id="myModal_2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog">
          <div class="modal-content" style="width:400px;margin-left:78px;margin-top:50px;" >
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                <%--<button type="button" class="close" 
                    data-dismiss="modal" aria-hidden="true">
                        &times;
                </button>--%>
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">浏览器使用提醒</p>
                    </div>
                </h4>
                </div>
                <div class="modal-body" style="font-size:12px;padding-bottom:50px;padding-top:35px;font-family:'微软雅黑';">
                    	您使用的浏览器不是火狐、360、谷歌，建议使用这三种浏览器！
                </div>
               <%-- <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                    <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>--%>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
 </div>

    <div class="login_container">
         <div class="container allContainer">
                 <div class="login_margin">
                      <!--<h4>系统用户登录</h4>-->
                      <div class="login_main_container">
                          <div class="login_logo">
                              <a href="index.html"><img src="images/logo_new.png"/></a>
                              <!--<p style="letter-spacing:30px; font-size:35px; margin-left:20px;"><%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></p>-->
                          </div>
                          <div class="form-horizontal login_form">
                              <div class="form-group row">
                                 <label class="col-md-4">用户名</label>
                                 <div class="col-md-6">
                                     <input type="text" name="loginUsername" class="form-control" />
                                 </div>
                              </div>
                              <div class="form-group row">
                                 <label class="col-md-4">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
                                 <div class="col-md-6">
                                     <input type="password" name="loginPassword" class="form-control" />
                                 </div>
                              </div>
                              <div class="form-group row">
                                <div class="clearfix col-md-6 col-md-offset-4">
                                  <div class="pull-left">
                                    <input type="checkbox" class="userpwd" style="position:relative;top:2px;" />&nbsp;<span style="font-size:12px">记住用户名密码</span>
                                   </div>
                                    <a class="pull-right" href="faq.aspx" style="font-size:12px;line-height:22px;">忘记密码？</a>
                                </div>
                                 
                              </div>
                              <div class="form-group row" style="margin-bottom:10px;" >
                                  <label class="col-md-4"></label>
                                 <div class="col-md-6 login_btn">
                                 	<button onclick="Login( this )" class="form-control">登 录</button>
                                 </div>
                              </div>
                              <div class="from-group row">
                                  <label class="loginUser col-md-4"></label>
                                   <div class="col-md-6" style="font-size:12px; text-align:left;">您还没有帐号？请先<a href="register.aspx"  style="color:#0099CB;">注册</a></div>
                              </div>
                      </div>
                 </div>
                 <p class="login_copyright text-center" style="position:static !important;margin-bottom:0;">Copyright©<%=DateTime.Now.Year%> 上海南软信息科技有限公司版权所有 沪ICP备15052516号-1</p>
             </div>
             
         </div>
    </div>
    <script type="text/javascript">
    location.onload = GetLastUser();
        function Login( button )
        {
            var _user = $( 'input[name="loginUsername"]' ).val();
            var _pwd = $( 'input[name="loginPassword"]' ).val();

            $( 'input[name="loginUsername"]' ).val(_user.replace(/(^\s*)|(\s*$)/g, ""));

            if ( _user == '' || _pwd == '' )
            {
                alert( '请输入用户名或密码！' );
            }
            else
            {
                $( button ).text( '登录中......' );

                //将最后一个用户信息写入到Cookie
                SetLastUser(_user);
                if( $('input.userpwd')[0].checked ){

                  var expdate = new Date();
                  expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));

                  SetCookie(_user, _pwd, expdate);   //将用户名和密码写入到Cookie
                }else{
                    ResetCookie();    //如果没有选中记住密码,则立即过期
                }

                

                DoLogin( _user, _pwd, _LoginComplete );
            }
        }
        $( "input[name='loginPassword']" ).on( "keydown", function ( e )
        {
            $('.login_btn button').text('登 录');
            $( 'input[name="loginUsername"]' ).val($( 'input[name="loginUsername"]' ).val().replace(/(^\s*)|(\s*$)/g, ""));
            var key = e.which;
            if ( key == 13 )
            {
                Login();                    //触发上面绑定的click事情
            }
        } );
		
        $(function () {
            var wh = $(window).height();
            console.log(wh);
            $('.login_container').css({ 'height': wh + 'px' });
//          var loginH = $('.login_main_container').height();
	//      loginH取固定值  兼容 苹果浏览器
			      var loginH = 427;
            console.log(loginH);
            var mt = (wh - loginH)/2;
            var footMt=mt-25;
            console.log(mt);
            $('.allContainer').css('padding-top', mt + 'px');
            $('.login_copyright').css('margin-top', footMt + 'px');

            $(window).resize(function () {
                var wh = $(window).height();
                $('.login_container').css({ 'height': wh + 'px' });
	              //var loginH = $('.login_main_container').height();
		            //loginH取固定值  兼容 苹果浏览器
				        var loginH = 427;
                var mt = (wh - loginH) / 2;
                var footMt = mt - 25;

                $('.allContainer').css('padding-top', mt + 'px');
                $('.login_copyright').css('margin-top', footMt + 'px');
            })
		})

        $('#myModal .close').click(function () {
            $('#myModal').on('hidden.bs.modal', function () {
                $('input[name="loginPassword"]').focus();
            });
        });
        
        $('#myModal_2 .close').click(function () {
            $('#myModal_2').on('hidden.bs.modal', function () {
                $('input[name="loginPassword"]').focus();
            });
        });
        
        $(function () {
    			var explorer = window.navigator.userAgent ;
    			//ie 
    			if (explorer.indexOf("MSIE") >= 0) {
    				$('#myModal_2').modal('show');		
    			}
    			//firefox 
    			else if (explorer.indexOf("Firefox") >= 0) {
    			}
    			//Chrome
    			else if(explorer.indexOf("Chrome") >= 0){
    			}
    			//Opera
    			else if(explorer.indexOf("Opera") >= 0){
    				$('#myModal_2').modal('show');		
    			}
    			//Safari
    			else if(explorer.indexOf("Safari") >= 0){
    				$('#myModal_2').modal('show');
    			}
    			//Netscape
    			else if(explorer.indexOf("Netscape")>= 0) { 
    				$('#myModal_2').modal('show');
    			} 			
    		})          
        
    </script>
</body>
</html>
