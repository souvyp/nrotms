<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>报价系统用户-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/AMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="PMSUserList">

<!--通用头部文件开始-->
<!--#include file="/Controls/AMS/header.aspx"-->
<!--通用头部文件结尾-->

<!-- 模板开始-->
<script id="jplist-template" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable table">
			<thead>
				<tr class="trtitle">
					<td style="width:35px;"></td>
					<td class="title">姓名</td>
					<td class="title">性别</td>
					<td class="title">出生日期</td>
					<td class="title">联系电话</td>
					<td class="title">账号</td>
					<td class="title">角色</td>
					<td class="title">是否失效</td>
					<td class="title">操作</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
					<td class="title" fld="Name"><a  href="PMSUserList_edit.aspx?id={{$value.id}}" >{{$value.Name}}</a></td>
					<td class="title" fld="Gender">
                        {{ if $value.Gender == '0' }}
                            男
                        {{ else if $value.Gender == "1"}}
                            女
                        {{/if}}
                    </td>
					<td class="title" fld="Birthday">{{$value.Birthday}}</td>
					<td class="title" fld="Phone">{{$value.Phone}}</td>
					<td class="title" fld="Account">{{$value.Account}}</td>
					<td class="title" fld="RoleID">
						{{if $value.RoleID == "32" }}
							采购
						{{else if $value.RoleID == "512" }}
							业务员
						{{else if $value.RoleID == "544" }}
							采购 业务员
						{{/if}}

					</td>
					<td class="title" fld="Invalid">
						{{if $value.Invalid=="0"}}
							有效
						{{else if $value.Invalid=="1"}}
							失效
						{{/if}}
					</td>
					<td class="title">
						{{if $value.Invalid=="0"}}
                        <span readonly style="margin-right:5px;">启用</span>
                        {{else}}
                        <button type="button"  title="启用"   onclick =  EODUser('1','{{$value.id}}') style="margin-left:0" >启用</button>
                        {{/if}}
                        {{if $value.Invalid=="1"}}
                        <span readonly style="margin-right:5px;">禁用</span>
                        {{else}}
                        <button type="button"  title="禁用" onclick =  EODUser('0','{{$value.id}}') style="margin-left:0;">禁用</button>
                        {{/if}}
                        <button type="button"  title="重置密码" onclick = "GetAccount('{{$value.Account}}')" style="margin-left:0;">重置密码</button>
					</td>
                </tr>
			{{/each}}
			</tbody>
		</table>
	</div>
</div>
</script>
<!-- 模板结尾 -->

<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
		<div id="demo" class="box jplist">
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">报价系统用户</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
				<button type="button" class="form_sub" onclick="userAdd();">新增&nbsp;<i class="glyphicon glyphicon-plus-sign"></i></button>
				<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<span class="glyphicon glyphicon-refresh"></span></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li class="active"><span data-path="id" data-order="asc" data-type="number">排序</span></li>
						<li><span data-path="name" data-order="asc" data-type="text">姓名</span></li>
					</ul>
				</div>
                <div class="text-filter-box" style="display:none;"><input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/><button type="button" id="opt_status-search-button"></button></div>
				<div class="text-filter-box"><!--[if lt IE 10]><div class="jplist-label">姓名:</div><![endif]--><input data-path="name" data-button="#name-search-button" type="text" value="" placeholder="姓名" data-control-type="textbox" data-control-name="name" data-control-action="filter"> <button type="button" id="name-search-button"><span class="glyphicon glyphicon-search"></span></button></div>
				
				<!-- 加载数据时显示 -->
				<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow anothertab_martop"></div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>没有数据</p>
				</div>
			</div>
            <div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<span class="glyphicon glyphicon-refresh"></span></button>
				<div class="jplist-drop-down" data-control-type="items-per-page-drop-down" data-control-name="paging" data-control-action="paging">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>
                <!-- 分页结果 -->
				<div class="jplist-label" data-type="第 {current} 页，共 {pages} 页" data-control-type="pagination-info" data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging" data-control-action="paging"></div>
            </div>
		</div>
		<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				

<!--通用页尾开始-->
<!--#include file="/Controls/AMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/


        InitList($("#demo"), $("#demo .list"), $("#jplist-template").html(), "usermanager", "/Widget.aspx?param=jplist&vid=grid_jplist_0044");
    };

	var _jsUrl = "<%=MinifyUrl("ListJs")%>";
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/AMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>
