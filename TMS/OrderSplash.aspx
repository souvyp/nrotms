<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="techns">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>下单指南-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
    <meta content="" name="keywords" />
    <meta content="" name="description" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="data-spm" content="" />
    <meta name="_ww_csrf_header" content="8fffa1a0-0317-429b-a565-0c6be9132835" />
    <link rel="shortcut icon" href="/images/otms.ico" type="image/x-icon" />
    <link rel="stylesheet" href="/assets/plugins/bootstrap/css/bootstrap.min.css" />
    <link href="/css/guide.css"  rel="stylesheet" type="text/css"/>    
 
	<script src="/assets/js/jquery-1.11.1.min.js"></script>	
	<!--#include file="/Controls/TMS/JS.aspx"-->

</head>
<body>
   <div class="guideCon">
         <div class="guideHeader">
             <p class="studyPro"><span class="firstDec"></span><span></span><span></span><span></span><span class="lastDec"></span></p>
             <a class="jumpGuide" href="/TMS/OrdersRes.aspx">跳过学习指南</a>
         </div>
         <div class="guideBody">
             <ul class="list-unstyled">
                 <li class="active">
                     <div class="guideContent clearfix">
                        <div class="welcomWorld pull-left">
                            <div>


                                <h4>欢迎使用下单指南！</h4>
                                <p>我是Mr. L，现在就和我一起了解如何创建订单吧！</p>
                            </div>
                        </div>
                        <img class="pull-right" src="/images/guide/001.png" />
                     </div>
                     <div class="guideFooter clearfix">
                          <span class="pull-right studyBtn">开始学习指南</span>
                     </div>
                 </li>
                 <li>
                     <div class="guideContent clearfix">
                        <img class="fullImg" src="/images/guide/01.png" />
                     </div>
                     <div class="guideFooter clearfix">
                          <div class="pull-left">
                             <img class="footDec" src="/images/guide/002.png" />
                             <h5>新增物品类型</h5>
                             <p>点击客户资源管理栏目，选择基础信息的物品类型项，点击新增按钮进入物品类型信息页面，填写相关信息。</p>
                          </div>
                          <span class="pull-right studyBtn">继 续</span>
                     </div>
                 </li>
                 <li>
                     <div class="guideContent clearfix">
                        <img class="fullImg" src="/images/guide/02.png" />
                     </div>
                     <div class="guideFooter clearfix">
                          <div class="pull-left">
                             <img class="footDec" src="/images/guide/002.png" />
                             <h5>新增客户物品</h5>
                             <p>点击客户资源管理栏目，选择基础信息的客户物品项，点击新增按钮进入客户物品信息页面，填写相关信息。</p>
                          </div>
                          <span class="pull-right studyBtn">继 续</span>
                     </div>
                 </li>
                 <li>
                     <div class="guideContent clearfix">
                        <img class="fullImg" src="/images/guide/03.png" />
                     </div>
                     <div class="guideFooter clearfix">
                          <div class="pull-left">
                             <img class="footDec" src="/images/guide/002.png" />
                             <h5>填写订单基础信息</h5>
                             <p>点击客户订单栏目，选择创建订单，进入创建订单页面，填写订单的运输信息。</p>
                          </div>
                          <span class="pull-right studyBtn">继 续</span>
                     </div>
                 </li>
                 <li>
                     <div class="guideContent clearfix">
                        <img class="fullImg" src="/images/guide/04.png" />
                     </div>
                     <div class="guideFooter clearfix">
                          <div class="pull-left">
                             <img class="footDec" src="/images/guide/002.png" />
                             <h5>填写订单运输信息</h5>
                             <p>点击客户订单栏目，选择创建订单，进入创建订单页面，填写订单的运输信息。</p>
                          </div>
                          <span class="pull-right studyBtn">继 续</span>
                     </div>
                 </li>
                 
                 <li>
                     <div class="guideContent clearfix">
                        <img class="fullImg" src="/images/guide/05.png" />
                     </div>
                     <div class="guideFooter clearfix">
                          <div class="pull-left">
                             <img class="footDec" src="/images/guide/002.png" />
                             <h5>填写订单物品信息</h5>
                             <p>点击客户订单栏目，选择创建订单，进入创建订单页面，填写订单的物品信息，最后点击保存按钮完成下单。</p>
                          </div>
                          <a href="/TMS/OrdersRes.aspx"><span class="pull-right goSystem">立 即 体 验</span></a>
                     </div>
                 </li>                 
             </ul>
         </div> 
    </div>

    <script type="text/javascript">
        $(function () {
            var bodyNum = 0, progressNum = 0;
            var totalBodyNum = $('.guideBody ul li').length;
            $('.studyBtn').click(function () {
                bodyNum = $(this).parents('li').index();
                progressNum = $(this).parents('li').index();
                bodyNum++;
                $('.guideBody ul li').removeClass('active');
                $('.guideBody ul li').eq(bodyNum).addClass('active');
                $('.studyPro span').eq(progressNum).css('background-color', '#F27302');
            });
        });
    </script>
<style type="text/css">
	.guideContent_1 {width:70%; margin:auto; height:70%; margin-top: 10px;}
</style>
</body>
</html>