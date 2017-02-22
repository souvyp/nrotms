<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>集团营业额总览报表-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/GMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="Index">
<style type="text/css">
#demo .jptable tr td button
{
margin:0px 5px;
padding:0;
}
 .jptable tr td:first-child{
        width:2% !important;
    }
</style>
<!--额外的css结尾-->

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
<!--审核申请-->
<div class="modal fade" id="ConfirmModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    
                    <h4 class="modal-title text-left" id="H1">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">审核集团申请</p>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <label class="col-md-2 control-Label">说明</label>
                        <div class="col-md-10">
                            <textarea name="Description" class="form-control" rows="3" cols="70"></textarea>
                            <input type="hidden" name="BranchID" value="0" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="同意" onclick="ConfirmGroupReq( 1, $(this).closest('div#ConfirmModal') )" ><span aria-hidden="true" class="">同意</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="拒绝" onclick="ConfirmGroupReq( 0, $(this).closest('div#ConfirmModal') )" ><span aria-hidden="true" class="">拒绝</span><span class="glyphicon glyphicon-ban-circle" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
<!--通用头部文件开始-->
<!--#include file="/Controls/GMS/header.aspx"-->
<!--通用头部文件结尾-->
 

<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
		<div id="demo" class="box jplist">
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">集团营业额-总览报表</p>
            </div>
            <select class="year_"  onchange="Group_t_Report_yye()">
            	<option value="2016">2016</option>
            	<option value="2015">2015</option>
            	<option value="2014">2014</option>            	
            </select>
            
 			<div class="list box text-shadow anothertab_martop"></div>
			<div style="min-height:800px;">
				<!-- 异步加载内容 -->
				
				<!-- no result found -->
				<div class="Group_t_R text-pos box jplist-no-results text-shadow align-center jplist-hidden">
  
					<div class="highcharts" style="width:80%;height:400px"></div>					
				</div>
			</div>
			<!-- 手机自适应按钮 -->
		 
            <!-- 操作面板 -->
 
		</div>
		<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				

<!--通用页尾开始-->
<!--#include file="/Controls/GMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    function resizeTable() {
        if ($("#demoList").length == 0) {
            return;
        }
        else {
            $("#demoList").colResizable({ liveDrag: true });

            resizeCols = clearInterval(resizeCols);
        }
    }
    var resizeCols = null;
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/
   
    	Group_t_Report_yye();
		 
    };
	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script><!--#include file="/Controls/GMS/JS.aspx"-->
<script src="/assets/plugins/jquery/colResizable-1.5.min.js"></script>
<script src="/assets/request_minify.js"></script>
<script src="/assets/plugins/highcharts/highcharts.js"></script>
</body>
</html>
