<script>
	var MENU_DEF_ZMMP = "<%=MindMapMenuUrl("ams")%>";
    function initHeader()
    {
        loadJSS( 
		[
            "/AMS/js/SinceWriting.js"
		] );
    }
    function showqrcode(){
    	$("#QC1").attr("style","width:200px;left:-76px;display:block;");
    	$("#QC2").attr("style","left:110px;display:block;");
    	$("#QC3").attr("style","width:201px;height: 201px;display:block;");
    }
    function hideqrcode(){
    	$("#QC1").attr("style","width:200px;left:-76px;display:none;");
    	$("#QC2").attr("style","left:110px;display:none;");
    	$("#QC3").attr("style","width:201px;height: 201px;display:none;");
    }
</script> 
    <div class="aliyun-console-topbar">
        <div class="topbar-wrap topbar-clearfix">
            <div class="topbar-head topbar-left">
                <a href="index.aspx" target="_blank" class="topbar-logo topbar-left">
                    <span class="logo">
                        <img src="/images/logo.png" style="position:relative;left:-1px; top:-2px;" /><%--position:relative;top:12px--%>
                    </span>
                </a>
                <!--a href="index.aspx" target="_self" class="topbar-home topbar-left">
                    <span class="glyphicon glyphicon-home"></span>
                </a-->
            </div>
            <div class="topbar-nav topbar-left">
                <ul class="list-inline topbar_nav">
                   
                </ul>
            </div>
            <div class="topbar-info topbar-right">
				
            	<div class="topbar-left">
				    <a title="在线咨询" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=3503985934&site=qq&menu=yes">
				    	<img src="../../images/qq.png" style="padding: 15px 0 0 15px;">
				    </a> 
				</div>
				
				<div class="topbar-left">
					<div class="dropdown topbar-notice topbar-btn topbar-left">
	                    <a href="#" class="dropdown-toggle topbar-btn-notice" data-toggle="dropdown" onmouseover="showqrcode()" onmouseout="hideqrcode()">
	                        <img src="../../images/weixin.png" style="padding: 0 10px 0 25px;">
	                    </a>
	                    <div class="topbar-notice-panel" style="width:200px;left:-76px;" id="QC1" onmouseover="showqrcode()" onmouseout="hideqrcode()">
	                        <div class="topbar-notice-arrow" style="left:110px;" id="QC2"></div>
	                        <div class="topbar-notice-body" style="width:201px;height: 201px;" id="QC3">
                                <img src="../../images/QRCode.png" style="width: 200px;height: 200px;">
	                        </div>
	                    </div>
                    </div>
				</div>
                <!--<div class="topbar-left">
                    <div class="dropdown topbar-notice topbar-btn topbar-left">
                        <a  title="消息" href="#" class="dropdown-toggle topbar-btn-notice" data-toggle="dropdown">
                            <span class="topbar-btn-notice-icon glyphicon glyphicon-bell"></span>
                            <span class="topbar-btn-notice-num">0</span>
                        </a>
                        <div class="topbar-notice-panel" style="width:300px; left:-120px;">
                            <div class="topbar-notice-arrow" style="left:150px;"></div>
                            <div class="topbar-notice-head">
                                <span>站内消息通知</span>
                            </div>
                            <div class="topbar-notice-body">
                                <ul name="MyEvents">
                                    <li view-fld='{fld:"Event_Type",method:"template",template:"<div style=\"display:none;\"><span name=\"Event_Result\">@event_result@</span><span name=\"Event_Type\">@event_type@</span><span name=\"Event_SrcCompanyName\">@event_srccompanyname@</span><span name=\"Event_DstCompanyName\">@event_dstcompanyname@</span><span name=\"Event_Ext\">@event_ext@</span></div><a  href=\"javascript:void(0)\"  style=\"display:block;height:100%;padding:10px 10px;background:#fff;color:#333;\"  class=\"clearfix\"><span class=\"inline-block\"><span class=\"topbar-notice-link\" name=\"Event\"></span></span><span class=\"inline-block topbar-notice-class\"><span class=\"topbar-notice-class-name\" >@event_time@</span></span></span></a>"}'>
                                    </li>
                                </ul>
                            </div>
                            <div class="topbar-notice-foot">
                                <a class="topbar-notice-more"  href="MyEvents.aspx">查看更多</a>
                            </div>
                            <div class="page"></div>
                                <div name="first-ds-pag">
                                    <div style="text-align:center;display:none">
                                        <ul class="pag pagination">
                                            <li class="bord_li prev"><a href="#">
                                                <img src="/assets/NSF/images/left.png" /></a>
                                            </li>
                                            <li class="bord_li next"><a href="#">
                                                <img src="/assets/NSF/images/right.png" /></a>
                                            </li>
                                            <li class="bord_li border_li_marg showrec">每页<span class="pagesize"></span>条 ， 共<span class="recamount"></span>条</li>
                                        </ul>
                                    </div>
                                </div>                  

                        </div>
                    </div>
                </div> -->     

                <div class="topbar-left">
                    <div class="dropdown topbar-notice topbar-btn topbar-left">
                        <a title="帮助" href="#" class="dropdown-toggle topbar-btn-notice" data-toggle="dropdown" >
                            <span class="glyphicon glyphicon-question-sign" style="padding:0 20px 0 10px; color:white; font-size:18px; top:5px;"></span>
                        </a>
                        <div class="topbar-notice-panel" style="width:200px;left:-76px;">
                            <div class="topbar-notice-arrow" style="left:100px;"></div>
                            <div class="topbar-notice-body" style="width:200px;">
                                <ul name="topbar-notice-head">
                                    <li class="topbar-info-btn" style="height:40px;">
                                        <a href="faq.aspx" style="padding:0 10px; font-weight:normal;">
                                            <span>新版FAQ</span>
                                        </a>
                                    </li>
                                    <li class="topbar-info-btn" style="height:40px;">
                                        <a href="help.aspx" style="padding:0 10px; font-weight:normal;">
                                            <span>帮助中心</span>
                                        </a>
                                    </li>
                                   <%-- <li class="topbar-info-btn" style="height:40px;">
                                        <a href="" target="_blank" style="padding:0 10px; font-weight:normal;">
                                            <span>文档中心</span>
                                        </a>
                                    </li>--%>
                                    <li class="topbar-info-btn" style="height:40px;">
                                        <a href="/about.aspx" style="padding:0 10px; font-weight:normal;" >
                                            <span>关于<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
				<div class="topbar-left">
					<span class="topbar-info-gap"></span>
					<div class="dropdown topbar-info-item" >
						<a href="#" class="dropdown-toggle topbar-btn text-center" data-toggle="dropdown" >
							<asp:Label ID="Label1" runat="server">
								<span class="zld_username"><%=GetTruename()%></span><span id="Span2" style="display:none"><% =GetUserID()%></span>
							</asp:Label>&nbsp;&nbsp;&nbsp;
							<span class="icon-arrow-down"></span>
						</a>
						<ul class="dropdown-menu" style="padding:0px;" >
							<li class="topbar-info-btn"><a href="UpdatePwd.aspx"><span>个人中心</span></a></li>
							<li class="topbar-info-btn"><a href="#" target="_self" onclick="Exit()"><span>退出</span></a></li>
						</ul>
					</div>
				</div>
            </div>
        </div>
    </div>
    <!--左侧 nav -->
    <div style="z-index: 99" class="viewFramework-body viewFramework-sidebar-mini">
        <div class="viewFramework-sidebar">
            <div>
                <div class="sidebar-content">
                    <div class="sidebar-nav main-nav">
                        <!-- 一级菜单-->
                    </div>
                </div>
            </div>
        </div>
        <!-- 左侧第二级导航 -->
        <div class="viewFramework-product viewFramework-product-col-1" click-class="viewFramework-product-col-1">
            <div class="viewFramework-product-navbar">
                <!--product nav-->
                <div class="product-nav-stage product-nav-stage-main">
                    <div class="product-nav-scene product-nav-main-scene">
                        <%--<div class="product-nav-title">我的公司</div>
                        <div class="product-nav-list">
                            <ul class="top-level">
                                <!--二级菜单-->
                            </ul>
                        </div>--%>
                    </div>
                </div>
            </div>
            <!-- 二级 nav 收缩 -->
            <div class="viewFramework-product-navbar-collapse ng-scope" onclick="collapseNavbar()">
                <div class="product-navbar-collapse-inner">
                    <div class="product-navbar-collapse-bg"></div>
                    <div class="product-navbar-collapse">
                        <span class="icon-collapse-left"></span>
                        <span class="icon-collapse-right"></span>
                    </div>
                </div>
            </div>
            <!-- 右侧主体内容 -->
            <div class="viewFramework-product-body">
                <!--product body-->
                <div class="console-container" data-spm="n2" data-spm-max-idx="75">
                    <div class="row">
                        <div class="col-sm-12">
                           
