<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="techns">
<head>
    <meta charset="utf-8" />

    <title>注册 - <%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta content="" name="keywords" />
    <meta content="" name="description" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
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
    <script src="assets/NSF/js/NSF.0.0.3.min.js"></script>
    <%--others--%>
    <script  type="text/javascript" src="js/login.js"></script>
    <script  type="text/javascript" src="js/login-ui.js"></script>
    <!--placeholder-->
    <script type="text/javascript" src="js/jquery.placeholder.min.js"></script>
    <style type="text/css">
        .login_container {
            min-height:580px;
        }
        ul li {
            height:50px;
            list-style:none;
        }
		.register_input{ width:95% !important; float:left;}
		.need_write{ font-size:16px; color:red; line-height:34px; float:right;}
    </style>
</head>
<body>
<div class="login_container">
    <div class="container">
        <div class="col-md-4 col-md-push-4" style="margin-top:80px;">
            <!--<h4 style="font-family:'微软雅黑'; margin-bottom:10px; color:#eee;">系统用户注册</h4>-->
            <form  role="form" class="clearfix" style="box-shadow: 5px 5px 5px rgba(0,0,0,0.2);position:relative;border-radius:10px;background-color:rgba(255,255,255,0.8);">
                <div style="border-bottom:3px solid white; margin-bottom:30px; text-align:center;">
                    <img src="images/logo_new.png" style="padding:15px 0;  width:220px;">
                    <!--<h4 style='color:white;;font-family:"微软雅黑";font-size: 23px; position:absolute; top:35px; left:110px;'>南&nbsp;&nbsp;软&nbsp;&nbsp;OTMS&nbsp;&nbsp;系&nbsp;&nbsp;统</h4>-->
                </div>

                <div >
                    <ul class="col-md-10 col-xs-10 col-xs-push-1">
                        <li>
                            <input type="text" class="form-control register_input" name="name" placeholder="姓名" value="<%=GetUrlDstCompanyName()%>"/><span class="need_write">*</span>
                            <input type="hidden" name="ReferCompanyID" placeholder="推荐公司" value="<%=GetUrlSrcCompanyID()%>"/>
                        </li>
                        <li>
                            <input type="text" onblur="GetCompany()" class="form-control register_input data" name="phone" placeholder="手机号码" /><span class="need_write">*</span>
                        </li>
                        <li>
                            <input type="text" onblur="GetCompany()" class="form-control register_input data" name="mail" placeholder="邮箱" /><span class="need_write">*</span>
                        </li>
                        <li>
                            <input type="text" onblur="GetCompany()" class="form-control register_input data" name="companyname" placeholder="公司" /><span class="need_write">*</span>
                        </li>
                        <li>
                            <span class="gou-btn"></span> <font style="color: #666;">个体承运方</font> 
                        	<input type="hidden" name="_driver" value>
                        </li>
                        <!--<li>
                            <select style="width:100%;" class="form-control register_input">
                                <option>从何处了解到OTMS</option>
                            </select>
                        </li>-->
                        <li>
                            <span>
                                <input type="text" id="inputCode1" class="form-control" style="width:57% !important;" placeholder="验证码" />
                            </span>
                            <span class="nose" style=" float:right; margin-top:-25px; cursor:pointer;">
                                <span id="checkCode1" onclick="createCode1()" style=" border:1px solid #ccc; padding:5px 12px; border-radius:4px; background:url(images/bg-0069.gif) 0 0 no-repeat; background-size:100% 100%;"></span>
                                <span style="color:#0099CB; font-size:12px;" onclick="createCode1()">看不清?</span>
                            </span>
                        </li>
                        <li>
                            <button type="submit"  class="btn register" style="width: 100%; color:white; background-color:#f60;">注册</button>
                        </li>
                        <li style="height:30px; font-size:12px;">
                            如已有账户，请 <a href="Login.aspx" style="color:#0099CB; font-size:13px;">登录</a>
                        </li>
                    </ul>
                </div>
            </form>
        </div>
    </div>

    <div style="text-align:center;font-family:'微软雅黑';font-size:12px; color:white; position:absolute; bottom:10px; width:100%; letter-spacing:1px;">
        <span>Copyright©<%=DateTime.Now.Year%> 上海南软信息科技有限公司版权所有 沪ICP备15052516号-1</span>
    </div>
</div>
    <script type="text/javascript">

        var _name ;
        var _phone ;
        var _email ;
        var _company ;
        var _license;$( 'input[name="license"]' ).val()

        $( 'form' ).submit( function ()
        {
            if ( validateCode1() )
            {
                _name = $( 'input[name="name"]' ).val();
                _phone = $( 'input[name="phone"]' ).val();
                _email = $( 'input[name="mail"]' ).val();
                _company = $( 'input[name="companyname"]' ).val();
                _driver = $( 'input[name="_driver"]' ).val();

                if ( _name == '' )
                {
                    alert( "姓名不能为空!" );
                }
                else if ( _phone == "" )
                {
                    alert( "手机号码不能为空！" );
                }
                else if ( _email == "" )
                {
                    alert( "email不能为空！" );
                }
                else if ( _company == "" )
                {
                    alert( "公司名称不能为空！" );
                }
                 
                else
                {
                    //var _pattern = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i;
                    var _pattern = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
                    var _patPhone = /^1[3|5|7|8|][0-9]{9}$/
                    if ( !_pattern.test( _email ) )
                    {
                        alert( '不是合法的邮箱，请检查邮箱格式是否正确、是否输入了空格！' );
                    }
					else if ( !_patPhone.test( _phone ) )
                    {
                        alert( '请检查手机号码是否输入正确，是否输入了空格！' );
                    }
                    else
                    {
                        $( '.register' ).text( '注册中......' );
                        DoRegister( _company, _phone, _email, _name,_driver, _RegisterComplete );
                    }
                }

            }
            return false;
        } );

		$(function(){
		    var wh = $(document).height();
			$( '.login_container' ).css( 'height', wh + 'px' );
			$(window).resize(function () {
			    var wh2 = $(document).height();
			    $('.login_container').css({ 'height': wh2 + 'px' });
			});
		})
		$('.gou-btn').click(function () {
		    if ($(this).hasClass('gouChecked')) {
		        $(this).removeClass('gouChecked');
		        $(this).next().next().attr('value','0'); 
		    } else {
		        $(this).addClass('gouChecked');
		        $(this).next().next().attr('value','1');  
		    }
		
		})	
    </script>
</body>
</html>
