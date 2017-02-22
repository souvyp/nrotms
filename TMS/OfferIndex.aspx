<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>个人中心-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<link href="../../css/guideBrows.css" rel="stylesheet" type="text/css"/>
</head>
<body code="Index">
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
                       <h4>创建报价单</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/011.png" />
                          </div>
                          <div class="pull-right mt10">
                            <a href="" class="colorO">按单报价</a>
                            <a href="" class="colorO">合约报价</a>
                            <a href="" class="colorO">补充报价</a>
                            <a href="" class="colorO">合单报价</a>
                          </div>
                       </div>
                    </div>
                    <div class="col-md-3">
                       <h4>我的报价</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/012.png" />
                          </div>
                          <div class="pull-right mt10">
                            <a href="">已发送报价单</a>
                            <a href="" class="colorO">待发送报价单</a>
                            <a href="">已过期报价单</a>
                            <a href="">已关闭报价单</a>
                          </div>
                       </div>
                    </div>
                     <div class="col-md-3">
                       <h4>报价单审核</h4>
                       <div class="clearfix">
                          <div class="pull-left">
                  	        <img src="../../images/guideBrows/013.png" />
                          </div>
                          <div class="pull-right mt20">
                            <a href="">已审核报价单</a>
                            <a href="" class="colorO">待审核报价单</a>
                            <a href="">已过期报价单</a>
                          </div>
                       </div>
                    </div>
                    <div class="col-md-3">
                       <h4>报价单查询</h4>
                       <div class="clearfix searchList">
                           <div class="inputGroup mt20">
                              <input type="text" class="form-control" placeholder="例如：ORD2016012101201">
                              <span class="input-group-btn">
                                <a href=""  class="glyphicon glyphicon-search"></a>
                              </span>
                              <label>请输入报价单名或报价单号或客户名</label>
                            </div>
                            <a class="lookBtn" href="">立即查询</a>
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
