<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>运输订单首页-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<link href="../../css/guideBrows.css" rel="stylesheet" type="text/css"/>
</head>
<body code="DeliveryRes">
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
                    <!--<div class="col-md-3">
                       <h4>运输计划</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/002.png" />
                          </div>
                          <div class="pull-right mt30">
                            <p>在此可以提交<br />您的运输计划</p>
                            <a class="lookBtn" href="OrderAllocation.aspx">提交计划</a>
                          </div>
                       </div>
                    </div>-->
                    <div class="col-md-3">
                       <h4>订单调度</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/002.png" />
                          </div>
                          <div class="pull-right">
                            <a href="OrderSend.aspx" class="colorO">市内待调度订单</a>
                            <a href="OrderLongSend.aspx" class="colorO">长途待调度订单</a>
                            <a href="Commissioned.aspx">已委托订单</a>
                            <a href="OrderSendCar.aspx" class="colorO">拼车待调度</a>
                            <a href="CommissionedCar.aspx">已委托拼车单</a>
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
                            <a href="SignManage.aspx" class="colorO">待签收订单</a>
                            <%--<a href="SignManage.aspx">已签收订单</a>--%>
                          </div>
                       </div>
                    </div>
                     <div class="col-md-3">
                       <h4>回单管理</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/005.png" />
                          </div>
                          <div class="pull-right mt35"  style="margin-top:50px;">
                            <a href="ReceiptManage.aspx" class="colorO">待回单订单</a>
                            <%--<a href="ReceiptManage.aspx">已回单订单</a>--%>
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
                            <p>再次可以查看<br />您的订单费用</p>
                            <a class="lookBtn" href="PriceManage.aspx">立即查看</a>
                          </div>
                       </div>
                    </div>
                    <div class="col-md-3">
                       <h4>订单查询</h4>
                       <div class="clearfix searchList">
                           <div class="inputGroup mt20">
                              <input type="text" class="form-control" placeholder="例如：ORD2016012101201">
                              <span class="input-group-btn">
                                <a onclick="queryDelivery(this)"  class="glyphicon glyphicon-search"></a>
                              </span>
                              <label style="margin-bottom: 0px !important; margin-top: 7px; line-height: 14px;">请输入准确的单据编号</label>
                              <label style="margin-bottom: 10px !important;">如错误将没有数据！</label>
                            </div>
                            <a class="lookBtn" onclick="queryDelivery(this)" >立即查询</a>
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
