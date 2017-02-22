<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>订单首页-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<link href="../../css/guideBrows.css" rel="stylesheet" type="text/css"/>
</head>
<body code="OrdersRes">
<!-- 通用对话框开始-->
<div class="modal fade text-center" id="win-Common-Dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-body">
				<div class="content">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 通用对话框结尾 -->

<!--通用头部文件开始-->
<!--#include file="/Controls/TMS/header.aspx"-->
<!--通用头部文件结尾-->


<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
		<div id="demo" class="box jplist">
			  <div class="container" style="width:100%;">
                <div class="row globalList">
                    <div class="col-md-3">
                       <h4>创建订单</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/001.png"/>
                          </div>
                          <div class="pull-right mt30">
                            <a href="orderIndex.aspx" class="colorO" style="border-bottom:0;width:100px;text-align:center;padding-left:0;margin-bottom:15px;">我的订单</a>
                            <a class="lookBtn" href="Order_edit.aspx">创建订单</a>
                            <a style="border-bottom:0;width:100px;text-align:center;padding-left:0;margin-top:5px;" href="OrderSplash.aspx"  ><span class="glyphicon glyphicon-question-sign" style="color: rgb(255, 138, 0); font-size:24px;" title="下单指南"> </span></a>
                          </div>
                       </div>
                    </div>
                    <div class="col-md-3">
                       <h4>订单接收</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/003.png"  />
                          </div>
                          <div class="pull-right mt35">
                            <a href="OrderAccept.aspx" class="colorO">待接收普通单</a>
                            <a href="OrderAcceptCar.aspx" class="colorO">待接收拼车单</a>
                            <a href="OrderAcceptedCar.aspx">已接收拼车单</a>
                          </div>
                       </div>
                    </div>
            
                     <div class="col-md-3">
                       <h4>签收管理</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/004.png" />
                          </div>
                          <div class="pull-right mt35" style="margin-top:50px;">
                            <a href="OrderSign.aspx" class="colorO">待签收订单</a>
                            <%--<a href="OrderSign.aspx">已签收订单</a>--%>
                          </div>
                       </div>
                    </div>
                    <div class="col-md-3">
                       <h4>回单管理</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/005.png"/>
                          </div>
                          <div class="pull-right mt35" style="margin-top:50px;">
                            <a href="OrderReceipt.aspx" class="colorO">待回单订单</a>
                            <%--<a href="OrderReceipt.aspx">已回单订单</a>--%>
                          </div>
                       </div>
                    </div>
                    <div class="col-md-3">
                       <h4>费用管理</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/006.png"/>
                          </div>
                          <div class="pull-right mt30">
                            <p>在此可以查看<br />您的订单费用</p>
                            <a class="lookBtn" href="OrderPrice.aspx">立即查看</a>
                          </div>
                       </div>
                    </div>
                    <div class="col-md-3">
                       <h4>订单查询</h4>
                       <div class="clearfix searchList">
                           <div class="inputGroup mt20">
                              <input type="text" class="form-control" placeholder="例如：ORD2016012101201">
                              <span class="input-group-btn">
                                <a onclick="queryRes(this)"  class="glyphicon glyphicon-search"></a>
                              </span>
                              <label>请输入单据编号</label>
                            </div>
                            <a class="lookBtn" onclick="queryRes(this)" >立即查询</a>
                       </div>
                    </div>
            
                </div>
            </div>
		</div>
		<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				

<!--通用页尾开始-->
<!--#include file="/Controls/TMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
    };
    var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
