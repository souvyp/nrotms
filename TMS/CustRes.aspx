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
<body code="CustRes">
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
                	<%					
					if (OTMS.UserRole.Equal( GetUserInfo().RoleId, OTMS.UserRole.OrderCreator ))
					{
					%>
	                    <div class="col-md-3">
	                       <h4>承运方管理</h4>
	                       <div class="clearfix">
	                          <div class="pull-left">
	                  	        <img src="../../images/guideBrows/008.png" />
	                          </div>
	                          <div class="pull-right mt35">
	                            <a class="colorO" href="SupplierList_edit.aspx">新增承运方</a>
	                            <a href="SupplierList.aspx">承运方列表</a>
	                          </div>
	                       </div>
	                    </div>
                    <%
					}
					%>
					
                    <div class="col-md-3">
                       <h4>资源管理</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/009.png" />
                          </div>
                          <div class="pull-right mt20">
                          	<%							
							if (OTMS.UserRole.Equal( GetUserInfo().RoleId, OTMS.UserRole.OrderCreator ))
							{
							%>
	                            <a href="driver.aspx">司机管理</a>
	                            <a href="Cars.aspx">车辆管理</a>
	                            <a href="MSymbol.aspx">承运方标识</a>
                            <%
							}
							%>
							<%							
							if (OTMS.UserRole.Equal( GetUserInfo().RoleId, OTMS.UserRole.OrderReceiver ))
							{
							%>
								<a href="OrderMSymbol.aspx">客户标识</a>
							<%
							}
							%>
                          </div>
                       </div>
                    </div>
                    <%                  
                    if (OTMS.UserRole.Equal( GetUserInfo().RoleId, OTMS.UserRole.OrderReceiver ))
					{
					%>
	                     <div class="col-md-3">
	                       <h4>客户资源管理</h4>
	                       <div class="clearfix">
	                          <div class="pull-left">
	                  	        <img src="../../images/guideBrows/010.png" />
	                          </div>
	                          <div class="pull-right mt20">
	                            <a href="GoodsType.aspx" class="colorO">物品类型</a>
	                            <a href="goods.aspx">客户物品</a>
	                            <a href="EndUser.aspx" class="colorO">收货方管理</a>
	                          </div>
	                       </div>
	                    </div>
                    <%
					}
					%>
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
