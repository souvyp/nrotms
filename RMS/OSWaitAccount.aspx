<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>待结账运输订单-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/RMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="OSWaitAccount">

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
<!--#include file="/Controls/RMS/header.aspx"-->
<!--通用头部文件结尾-->

<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
		<div id="demo" class="box jplist">
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">待结账运输订单</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow anothertab_martop">
                    <div class="list-item box jplist-panel tabbtn">
	                    <div class=""><!-- block right -->
		                    <table class="jptable table table-border">
			                    <thead>
				                    <tr class="trtitle">
                                        <td class="title">单据编号</td>
					                    <td class="title">承运商名称</td>
					                    <td class="title">订单日期</td>
					                    <td class="title">总体积</td>
					                    <td class="title">总重量</td>
					                    <td class="title">总运费</td>
                                        <td class="title">出发城市</td>
                                        <td class="title">到达城市</td>
                                        <td class="title">单据状态</td>
				                    </tr>
			                    </thead>
			                    <tbody class="OswYL">

			                    </tbody>
		                    </table>
	                    </div>
                    </div>
				</div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>没有数据</p>
				</div>
			</div>
		</div>
		<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				

<!--通用页尾开始-->
<!--#include file="/Controls/RMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
        Oswait();
        // 待结账运输单查询
        function Oswait()
        {
            var vml = '[{"namespace":"protocol","cmd":"data","version":1,"id":"rms_0008","paras":[]}]';
            NSF.System.Network.Ajax( '/Portal.aspx',
            vml,
            'POST',
            false,
            function ( result, data )
            {
                if ( result )
                {
                    var _html = '';
                    $( '.OswYL' ).html( '' );
                    $( '.text-pos' ).addClass( 'jplist-hidden' );
                    var length = data[0].rs.length;
                    if ( length != 0 )
                    {
                        for ( var i = 0; i < data[0].rs[0].rows.length; i++ )
                        {
                            _html += '<tr>';
                            _html += '<td title="'+ data[0].rs[0].rows[i].Code + '">' + data[0].rs[0].rows[i].Code + '</td><td title="'+ data[0].rs[0].rows[i].SupplierName + '">' + data[0].rs[0].rows[i].SupplierName + '</td>';
                            _html += '<td title="'+ data[0].rs[0].rows[i].CreateTime + '">' + data[0].rs[0].rows[i].CreateTime + '</td><td title="'+ data[0].rs[0].rows[i].Volume + '">' + data[0].rs[0].rows[i].Volume + '</td>';
                            _html += '<td title="'+ data[0].rs[0].rows[i].Weight + '">' + data[0].rs[0].rows[i].Weight + '</td><td title="'+ data[0].rs[0].rows[i].Total + '">' + data[0].rs[0].rows[i].Total + '</td>';
                            _html += '<td title="'+ data[0].rs[0].rows[i].From + '">' + data[0].rs[0].rows[i].From + '</td><td title="'+ data[0].rs[0].rows[i].To + '">' + data[0].rs[0].rows[i].To + '</td>';
                            _html += '<td title="'+ data[0].rs[0].rows[i].StatusName + '">' + data[0].rs[0].rows[i].StatusName + '</td></tr>';
                        }
                    }
                    else
                    {
                        _html += '<tr><td colspan="9" style="text-align:center !important">没有数据！！！</td></tr>';
                    }
                    $( '.OswYL' ).append( _html );
                }

            }
         )
        }
    };
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/RMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
