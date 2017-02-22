var MISC_FILE='/code/files/misc.chi';
var MISC_ACCOUNT='/code/account/misc.chi';
var MISC_PROJECT='/code/projects/misc.chi';
var LAY_DATA='COMMON/ITEMS.ZLAY';
var PAGE_DATA='PAGES';

function makeItemDialog(box){
	var that=$('#configModal');
	if(box){
		that.find('input[name="iid"]').val(box.attr("iid"));
		that.find('input[name="title"]').val(box.find(".preview").text().trim());
		that.find('textarea[name="cont"]').val(box.find(".view").html().trim());
	}
	else{
		that.find('input[name="iid"]').val(uuid());
		that.find('input[name="title"]').val('');
		that.find('textarea[name="cont"]').val('');
	}
	
	clearDataTemplate('configModal');
	
	if(box){
		var conf=box.find('.configuration');
		
		for(var i=0;i<conf.children().length;i++){
			var item=conf.children(':eq('+i+')');
			var txt='';
			var tInx=0;

			if(item.get(0).tagName=="BUTTON"){
				if(item.attr('data-target')=='#dataModal'){
					that.find('input[name="dataBtn"]').attr("checked",'checked');
					that.find('input[name="dataBtn"]').parent().addClass("active");
				}
				else  if(item.attr('data-target')=='#editorModal'){
					that.find('input[name="editBtn"]').attr("checked",'checked');
					that.find('input[name="editBtn"]').parent().addClass("active");
				}
			}
			else if(item.get(0).tagName=="A"){
				if(item.hasClass('btn')){
					txt=$(item).text();
					tInx=1;
					txt +='('+$(item).attr('rel')+')';
				}
			}
			else if(item.get(0).tagName=='SPAN'){
				var dropdown=item.find('a.dropdown-toggle');
				txt=dropdown.text().trim()+':';
				var items=item.find('ul.dropdown-menu li a');
				for(var j=0;j<items.length;j++){
					if(j>0)txt+=',';
					txt+=$(items[j]).text()+'('+$(items[j]).attr('rel')+')';
				}
				tInx=2;
			}
			if(tInx>0){
				var row=newDataTemplate(that.find('.dataInput:eq(0)').find('.col-md-12'));
				row.find('input[name="target"]').val(txt);
				var t=row.find('input[name="type"]');
				t.val(tInx);
				if(tInx==1)
					t.next().html('单选按钮'+' <span class="caret"></span>');
				else
					t.next().html('下拉选项'+' <span class="caret"></span>');
			}
		}
	}
}

function genItemsData(){
	var itemDatas=[];
	$('.sidebar-nav .accordion-group .nav-header').each(function(index){
		if(index>0){
			var txt=$(this).text().trim();
			txt=txt.substring(0,txt.indexOf(' '));
			var datas=[];
			$(this).next().find('.box-element').each(function(){
				makeItemDialog($(this));
				datas.push($('#configModal form').serializeObject());
			})
			itemDatas.push({text:txt,items:datas});
		}
	})
	return itemDatas;
}

function saveConfDatas(){
	var data=genItemsData();
	var cont=JSON.stringify(data);
	$.ajax({
		url: MISC_FILE,
		type: "post",
		dataType:'json',
		data:{param:'save',path:LAY_DATA,cont:cont},
		success: function (data) {
			alert('保存成功!');
		}
	});
}

function getConfDatas(){
	var defData=[{"text":"基础CSS","items":[{"iid":"cd9c7d2b-0427-44a4-853d-46f3618b1cc8","title":"标题","cont":"<h3 contenteditable=\"true\">这是一个标题</h3>","datas":"","target":["对齐                                :默认(),左对齐(text-left),居中(text-center),右对齐(text-right)","强调样式                                :默认(),灰色(text-muted),蓝色(text-primary),绿色(text-success),青色(text-info),橙色(text-warning),红色(text-danger)",""],"editBtn":"1","dataBtn":"1"},{"iid":"e072a64d-8312-40c1-aa28-2c9cad306ee1","title":"段落","cont":"<p contenteditable=\"true\">这里是一个段落</p>","datas":"","target":["对齐                        :默认(),左对齐(text-left),居中(text-center),右对齐(text-right)","强调样式                        :默认(),灰色(text-muted),蓝色(text-primary),绿色(text-success),青色(text-info),橙色(text-warning),红色(text-danger)","加大(lead)",""],"editBtn":"1","dataBtn":"1"},{"iid":"dfbd4c0f-7ce1-4eb4-a61e-e519000e22a6","title":"地址","cont":"<address contenteditable=\"true\"> <strong>XXX公司</strong><br> 地址：某某工业区<br> 邮编：000000 </address>","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"261244c1-e524-4068-8c4f-78f2f655ac4d","title":"引用块","cont":"<blockquote contenteditable=\"true\"> \r\n           <p>这里是一个引用块的内容</p> \r\n           <small>可以设置右对齐</small> \r\n          </blockquote>","datas":"","target":["右对齐(pull-right)",""],"editBtn":"1","dataBtn":"1"},{"iid":"808c2c67-6c20-45b6-889e-386ebbe6e968","title":"无序列表","cont":"<ul contenteditable=\"true\"> \r\n           <li>标题一</li> \r\n           <li>标题二</li> \r\n           <li>标题三</li> \r\n           <li>标题四</li> \r\n           <li>标题五</li> \r\n          </ul>","datas":"","target":["无样式(list-unstyled)","嵌入(list-inline)",""],"editBtn":"1","dataBtn":"1"},{"iid":"4585eb7c-b693-46ec-80fb-18d9ed68fff6","title":"有序列表","cont":"<ol contenteditable=\"true\"> \r\n           <li>标题一</li> \r\n           <li>标题二</li> \r\n           <li>标题三</li> \r\n           <li>标题四</li> \r\n           <li>标题五</li> \r\n          </ol>","datas":"","target":["嵌入(list-inline)","无样式(list-unstyled)",""],"editBtn":"1","dataBtn":"1"},{"iid":"4906d7d3-360e-4475-aeb3-192e58c8dec1","title":"详细描述","cont":"<dl contenteditable=\"true\"> \r\n           <dt>\r\n             产品名称： \r\n           </dt> \r\n           <dd>\r\n             XXXX产品 \r\n           </dd> \r\n           <dt>\r\n             产品型号： \r\n           </dt> \r\n           <dd>\r\n             Xs-201 \r\n           </dd> \r\n           <dt>\r\n             产品尺寸： \r\n           </dt> \r\n           <dd>\r\n             210x451x50 \r\n           </dd> \r\n           <dt>\r\n             产品说明： \r\n           </dt> \r\n           <dd>\r\n             这里是产品的说明内容啦！ \r\n           </dd> \r\n          </dl>","datas":"","target":["竖向对齐(dl-horizontal)",""],"editBtn":"1","dataBtn":"1"},{"iid":"5b438354-960e-4b75-b61e-4fd8d7f4edc7","title":"表格","cont":"<table class=\"table\" contenteditable=\"true\"> \r\n           <thead> \r\n            <tr> \r\n             <th>编号</th> \r\n             <th>产品</th> \r\n             <th>上线时间</th> \r\n             <th>状态</th> \r\n            </tr> \r\n           </thead> \r\n           <tbody> \r\n            <tr> \r\n             <td>1</td> \r\n             <td>TB - Monthly</td> \r\n             <td>01/04/2012</td> \r\n             <td>Default</td> \r\n            </tr> \r\n            <tr class=\"active\"> \r\n             <td>1</td> \r\n             <td>TB - Monthly</td> \r\n             <td>01/04/2012</td> \r\n             <td>Approved</td> \r\n            </tr> \r\n            <tr class=\"success\"> \r\n             <td>2</td> \r\n             <td>TB - Monthly</td> \r\n             <td>02/04/2012</td> \r\n             <td>Declined</td> \r\n            </tr> \r\n            <tr class=\"warning\"> \r\n             <td>3</td> \r\n             <td>TB - Monthly</td> \r\n             <td>03/04/2012</td> \r\n             <td>Pending</td> \r\n            </tr> \r\n            <tr class=\"danger\"> \r\n             <td>4</td> \r\n             <td>TB - Monthly</td> \r\n             <td>04/04/2012</td> \r\n             <td>Call in to confirm</td> \r\n            </tr> \r\n           </tbody> \r\n          </table>","datas":"","target":["紧凑(table-condensed)","鼠标悬停(table-hover)","样式                     :默认(),条纹(table-striped),边框(table-bordered)",""],"editBtn":"1","dataBtn":"1"},{"iid":"76f603a6-15b4-4d86-8472-1309e2db6716","title":"提交表单","cont":"<form role=\"form\"> \r\n           <div class=\"form-group\"> \r\n            <label for=\"exampleInputEmail1\">邮箱：</label> \r\n            <input class=\"form-control\" id=\"exampleInputEmail1\" type=\"email\" placeholder=\"请输入您的邮箱账号！\"> \r\n           </div> \r\n           <div class=\"form-group\"> \r\n            <label for=\"exampleInputPassword1\">密码：</label> \r\n            <input class=\"form-control\" id=\"exampleInputPassword1\" type=\"password\" placeholder=\"请输入您的密码！\"> \r\n           </div> \r\n           <div class=\"form-group\"> \r\n            <label for=\"exampleInputFile\">附件：</label> \r\n            <input id=\"exampleInputFile\" type=\"file\"> \r\n            <p class=\"help-block\">请上传您的附件！</p> \r\n           </div> \r\n           <div class=\"checkbox\"> \r\n            <label> <input type=\"checkbox\"> 同意请打勾 </label> \r\n           </div> \r\n           <button class=\"btn btn-default\" type=\"submit\">提交</button> \r\n          </form>","datas":"","target":["嵌入(form-inline)",""],"editBtn":"1","dataBtn":"1"},{"iid":"33807142-81ac-4615-ba35-d643fdf7d864","title":"用户登录","cont":"<form class=\"form-horizontal\" role=\"form\"> \r\n           <div class=\"form-group\"> \r\n            <label class=\"col-sm-2 control-label\" for=\"inputEmail3\">邮箱：</label> \r\n            <div class=\"col-sm-10\"> \r\n             <input class=\"form-control\" id=\"inputEmail3\" type=\"email\" placeholder=\"请输入您的邮箱账号！\"> \r\n            </div> \r\n           </div> \r\n           <div class=\"form-group\"> \r\n            <label class=\"col-sm-2 control-label\" for=\"inputPassword3\">密码：</label> \r\n            <div class=\"col-sm-10\"> \r\n             <input class=\"form-control\" id=\"inputPassword3\" type=\"password\" placeholder=\"请输入您的密码！\"> \r\n            </div> \r\n           </div> \r\n           <div class=\"form-group\"> \r\n            <div class=\"col-sm-offset-2 col-sm-10\"> \r\n             <div class=\"checkbox\"> \r\n              <label> <input type=\"checkbox\"> 记住我 </label> \r\n             </div> \r\n            </div> \r\n           </div> \r\n           <div class=\"form-group\"> \r\n            <div class=\"col-sm-offset-2 col-sm-10\"> \r\n             <button class=\"btn btn-default\" type=\"submit\">登录</button> \r\n            </div> \r\n           </div> \r\n          </form>","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"9be7dc62-c5ab-4dce-b094-dc11ab9fa021","title":"按钮","cont":"<button class=\"btn btn-default\" contenteditable=\"true\" type=\"button\">默认</button>","datas":"","target":["禁用(disabled)","按下(active)","通栏(btn-block)","尺寸                     :大(btn-lg),默认(btn-default),小(btn-sm),微型(btn-xs)","样式                     :默认(btn-default),蓝色(btn-primary),绿色(btn-success),青色(btn-info),橙色(btn-warning),红色(btn-danger),链接(btn-link)",""],"editBtn":"1","dataBtn":"1"},{"iid":"7265e322-7d2c-4fe3-8591-42b6ee115185","title":"文字按钮","cont":"<a class=\"btn\" contenteditable=\"true\" href=\"#\" type=\"button\">按钮</a>","datas":"","target":["禁用(disabled)","按下(active)","通栏(btn-block)","尺寸                     :大(btn-lg),默认(btn-default),小(btn-sm),微型(btn-xs)","样式                     :默认(btn-default),蓝色(btn-primary),绿色(btn-success),青色(btn-info),橙色(btn-warning),红色(btn-danger),链接(btn-link)",""],"editBtn":"1","dataBtn":"1"},{"iid":"edf1ec72-31ab-4dd9-8e9f-fa226c79ee4c","title":"图片","cont":"<img alt=\"140x140\" src=\"assets/img/140.jpg\">","datas":"","target":["样式                     :默认(),圆角(img-rounded),圆圈(img-circle),相框(img-thumbnail)",""],"editBtn":"1","dataBtn":"1"}]},{"text":"基础组件","items":[{"iid":"973ddbab-a375-4367-929f-ea0d547f4030","title":"按钮组","cont":"<div class=\"btn-group\"> \r\n           <button class=\"btn btn-default\" type=\"button\"><i class=\"glyphicon glyphicon-align-left\"></i> 1</button> \r\n           <button class=\"btn btn-default\" type=\"button\"><i class=\"glyphicon glyphicon-align-center\"></i> 2</button> \r\n           <button class=\"btn btn-default\" type=\"button\"><i class=\"glyphicon glyphicon-align-right\"></i> 3</button> \r\n           <button class=\"btn btn-default\" type=\"button\"><i class=\"glyphicon glyphicon-align-justify\"></i> 4</button> \r\n          </div>","datas":"","target":["垂直(btn-group-vertical)","尺寸                     :默认(),大(btn-group-lg),中(btn-group-md),小(btn-group-sm),微型(btn-group-xs)",""],"editBtn":"1","dataBtn":"1"},{"iid":"d5ef49d5-e5e6-41f3-811e-1909ac26bc78","title":"下拉菜单","cont":"<div class=\"btn-group\"> \r\n           <button class=\"btn btn-default\" contenteditable=\"true\">动作</button> \r\n           <button class=\"btn btn-default dropdown-toggle\" data-toggle=\"dropdown\"><span class=\"caret\"></span></button> \r\n           <ul class=\"dropdown-menu\" contenteditable=\"true\"> \r\n            <li><a href=\"#\">操作</a></li> \r\n            <li class=\"disabled\"><a href=\"#\">禁止操作</a></li> \r\n            <li class=\"divider\"></li> \r\n            <li><a href=\"#\">更多设置</a></li> \r\n           </ul> \r\n          </div>","datas":"","target":["上拉(dropup)",""],"editBtn":"1","dataBtn":"1"},{"iid":"e072c7db-03fd-4e0f-83d3-bc96ebc5d92c","title":"导航","cont":"<ul class=\"nav nav-tabs\" contenteditable=\"true\"> \r\n           <li class=\"active\"><a href=\"#\">首页</a></li> \r\n           <li><a href=\"#\">资料</a></li> \r\n           <li class=\"disabled\"><a href=\"#\">消息</a></li> \r\n           <li class=\"dropdown pull-right\"> <a class=\"dropdown-toggle\" href=\"#\" data-toggle=\"dropdown\">下拉菜单 <b class=\"caret\"></b></a> \r\n            <ul class=\"dropdown-menu\"> \r\n             <li><a href=\"#\">列表一</a></li> \r\n             <li><a href=\"#\">列表二</a></li> \r\n             <li><a href=\"#\">列表三</a></li> \r\n             <li class=\"divider\"></li> \r\n             <li><a href=\"#\">更多列表</a></li> \r\n            </ul> </li> \r\n          </ul>","datas":"","target":["切换格式(nav-stacked)","样式                     :默认(nav-tabs),图钉(nav-pills)",""],"editBtn":"1","dataBtn":"1"},{"iid":"c320a56e-8fdb-4c91-800f-f9491e0742d3","title":"面包屑导航","cont":"<ul class=\"breadcrumb\"> \r\n           <li><a contenteditable=\"true\" href=\"#\">首页</a></li> \r\n           <li><a contenteditable=\"true\" href=\"#\">关于我们</a></li> \r\n           <li class=\"active\" contenteditable=\"true\">公司简介</li> \r\n          </ul>","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"dd464aa8-6322-41bd-92f0-300e4c58028b","title":"分页","cont":"<ul class=\"pagination\" contenteditable=\"true\"> \r\n           <li><a href=\"#\">上一页</a></li> \r\n           <li><a href=\"#\">1</a></li> \r\n           <li><a href=\"#\">2</a></li> \r\n           <li><a href=\"#\">3</a></li> \r\n           <li><a href=\"#\">4</a></li> \r\n           <li><a href=\"#\">5</a></li> \r\n           <li><a href=\"#\">下一页</a></li> \r\n          </ul>","datas":"","target":["尺寸                     :大(pagination-lg),中(),小(pagination-sm)",""],"editBtn":"1","dataBtn":"1"},{"iid":"87aee464-32d1-42a3-9d65-04d3b5331c27","title":"文字标签","cont":"<span class=\"label label-default\" contenteditable=\"true\">文字标签</span> \r\n          <span class=\"label label-primary\" contenteditable=\"true\">文字标签</span> \r\n          <span class=\"label label-success\" contenteditable=\"true\">文字标签</span> \r\n          <span class=\"label label-info\" contenteditable=\"true\">文字标签</span> \r\n          <span class=\"label label-warning\" contenteditable=\"true\">文字标签</span> \r\n          <span class=\"label label-danger\" contenteditable=\"true\">文字标签</span>","datas":"","target":["样式                     :默认(label-default),蓝色(label-primary),绿色(label-success),青色(label-info),橙色(label-warning),红色(label-danger)",""],"editBtn":"1","dataBtn":"1"},{"iid":"a6c192fb-4d79-4f40-9073-ff03680f49aa","title":"微标","cont":"<ul class=\"nav nav-pills\" contenteditable=\"true\"> \r\n           <li class=\"active\"> <a href=\"#\"> <span class=\"badge pull-right\">42</span> 新信息 </a> </li> \r\n           <li> <a href=\"#\"> <span class=\"badge pull-right\">16</span> 新信息 </a> </li> \r\n          </ul>","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"3b7beeb2-d351-4031-8a17-dba84dfa02c5","title":"概述","cont":"<div class=\"jumbotron\" contenteditable=\"true\"> \r\n           <h2>概述标题</h2> \r\n           <p>这是简短的概述内容，这是简短的概述内容，这是简短的概述内容，这是简短的概述内容，这是简短的概述内容，</p> \r\n           <p><a class=\"btn btn-primary btn-large\" href=\"#\">查看更多 ?</a></p> \r\n          </div>","datas":"","target":["嵌入(well)",""],"editBtn":"1","dataBtn":"1"},{"iid":"f4a86ad2-2206-4754-85e8-87452332b24d","title":"页标题","cont":"<div class=\"page-header\"> \r\n           <h1 contenteditable=\"true\">页标题范例 <small>此处编写页标题</small></h1> \r\n          </div>","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"39f4d42d-f399-44a4-85fe-03e4998ef096","title":"文本","cont":"<h2 contenteditable=\"true\">标题</h2> \r\n          <p contenteditable=\"true\">是的，这部分就是内容啦！</p> \r\n          <p><a class=\"btn\" contenteditable=\"true\" href=\"#\">查看更多 ?</a></p>","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"25980cc9-74ff-459c-8f63-97b6dea64ce4","title":"预览列表","cont":"<div class=\"row\"> \r\n           <div class=\"col-md-4\"> \r\n            <div class=\"thumbnail\"> \r\n             <img alt=\"300x200\" src=\"assets/img/people.jpg\"> \r\n             <div class=\"caption\" contenteditable=\"true\"> \r\n              <h3>标题一</h3> \r\n              <p>是的，这部分就是内容啦！</p> \r\n              <p><a class=\"btn btn-primary\" href=\"#\">浏览</a> <a class=\"btn\" href=\"#\">更多 ?</a></p> \r\n             </div> \r\n            </div> \r\n           </div> \r\n           <div class=\"col-md-4\"> \r\n            <div class=\"thumbnail\"> \r\n             <img alt=\"300x200\" src=\"assets/img/city.jpg\"> \r\n             <div class=\"caption\" contenteditable=\"true\"> \r\n              <h3>标题二</h3> \r\n              <p>对的，这部分就是内容啦！</p> \r\n              <p><a class=\"btn btn-primary\" href=\"#\">浏览</a> <a class=\"btn\" href=\"#\">更多 ?</a></p> \r\n             </div> \r\n            </div> \r\n           </div> \r\n           <div class=\"col-md-4\"> \r\n            <div class=\"thumbnail\"> \r\n             <img alt=\"300x200\" src=\"assets/img/sports.jpg\"> \r\n             <div class=\"caption\" contenteditable=\"true\"> \r\n              <h3>标题三</h3> \r\n              <p>没错，这部分就是内容啦！</p> \r\n              <p><a class=\"btn btn-primary\" href=\"#\">浏览</a> <a class=\"btn\" href=\"#\">更多 ?</a></p> \r\n             </div> \r\n            </div> \r\n           </div> \r\n          </div>","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"b4995e5d-ca31-41b3-8bad-9a832ca79f19","title":"进度条","cont":"<div class=\"progress\"> \r\n           <div class=\"progress-bar progress-success\" style=\"width: 60%;\"></div> \r\n          </div>","datas":"","target":["动画(active)","条纹(progress-striped)",""],"editBtn":"1","dataBtn":"1"},{"iid":"661b56fd-8767-4edb-ac8b-654c767f35d6","title":"媒体对象","cont":"<div class=\"media\"> \r\n           <a class=\"pull-left\" href=\"#\"> <img class=\"media-object\" src=\"assets/img/64.jpg\"> </a> \r\n           <div class=\"media-body\" contenteditable=\"true\"> \r\n            <h4 class=\"media-heading\">新标题</h4> 这里是简介内容区域！ \r\n            <div class=\"media\"> \r\n             <a class=\"pull-left\" href=\"#\"> <img class=\"media-object\" src=\"assets/img/64.jpg\"> </a> \r\n             <div class=\"media-body\" contenteditable=\"true\"> \r\n              <h4 class=\"media-heading\">新标题</h4> 这里是简介内容区域！ \r\n             </div> \r\n            </div> \r\n           </div> \r\n          </div>","datas":"","target":["嵌入(well)",""],"editBtn":"1","dataBtn":"1"},{"iid":"337a6468-9c8f-4001-8641-1efa8fbb3d47","title":"列表组","cont":"<div class=\"list-group\" contenteditable=\"true\"> \r\n           <a class=\"list-group-item active\" href=\"#\">首页</a> \r\n           <div class=\"list-group-item\">\r\n             列表头部 \r\n           </div> \r\n           <div class=\"list-group-item\"> \r\n            <h4 class=\"list-group-item-heading\">列表内容</h4> \r\n            <p class=\"list-group-item-text\">...</p> \r\n           </div> \r\n           <div class=\"list-group-item\"> \r\n            <span class=\"badge\">14</span>产品展示 \r\n           </div> \r\n           <a class=\"list-group-item active\"><span class=\"badge\">14</span>案例展示</a> \r\n          </div>","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"1ec67762-5c1d-424a-9e4c-bcc85f2e30e3","title":"面版","cont":"<div class=\"panel panel-default\"> \r\n           <div class=\"panel-heading\"> \r\n            <h3 class=\"panel-title\" contenteditable=\"true\">面版标题</h3> \r\n           </div> \r\n           <div class=\"panel-body\" contenteditable=\"true\">\r\n             面版内容 \r\n           </div> \r\n           <div class=\"panel-footer\" contenteditable=\"true\">\r\n             面版底部 \r\n           </div> \r\n          </div>","datas":"","target":["样式                     :默认(panel-default),蓝色(panel-primary),绿色(panel-success),青色(panel-info),橙色(panel-warning),红色(panel-danger)",""],"editBtn":"1","dataBtn":"1"}]},{"text":"交互组件","items":[{"iid":"3bf4cfb8-2604-4f28-86a0-1ece8dc7ad0f","title":"弹窗","cont":"<!-- Button to trigger modal --> \r\n          <a class=\"btn\" id=\"myModalLink\" role=\"button\" href=\"#myModalContainer\" data-toggle=\"modal\">触发弹窗</a> \r\n          <!-- Modal --> \r\n          <div tabindex=\"-1\" class=\"modal fade\" id=\"myModalContainer\" role=\"dialog\" aria-hidden=\"true\" aria-labelledby=\"myModalLabel\"> \r\n           <div class=\"modal-dialog\"> \r\n            <div class=\"modal-content\"> \r\n             <div class=\"modal-header\"> \r\n              <button class=\"close\" aria-hidden=\"true\" type=\"button\" data-dismiss=\"modal\">×</button> \r\n              <h4 class=\"modal-title\" id=\"myModalLabel\" contenteditable=\"true\">标题</h4> \r\n             </div> \r\n             <div class=\"modal-body\" contenteditable=\"true\">\r\n               这里是弹窗的内容 \r\n             </div> \r\n             <div class=\"modal-footer\"> \r\n              <button class=\"btn btn-default\" contenteditable=\"true\" type=\"button\" data-dismiss=\"modal\">关闭</button> \r\n              <button class=\"btn btn-primary\" contenteditable=\"true\" type=\"button\">保存</button> \r\n             </div> \r\n            </div> \r\n            <!-- /.modal-content --> \r\n           </div> \r\n           <!-- /.modal-dialog --> \r\n          </div> \r\n          <!-- /.modal -->","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"731812b3-8d04-41bd-8b7b-0b51dd772b37","title":"导航条","cont":"<nav class=\"navbar navbar-default\" role=\"navigation\"> \r\n           <!-- Brand and toggle get grouped for better mobile display --> \r\n           <div class=\"navbar-header\"> \r\n            <button class=\"navbar-toggle\" type=\"button\" data-toggle=\"collapse\" data-target=\"#bs-example-navbar-collapse-1\"> <span class=\"sr-only\">切换导航</span> <span class=\"icon-bar\"></span> <span class=\"icon-bar\"></span> <span class=\"icon-bar\"></span> </button> \r\n            <a class=\"navbar-brand\" href=\"#\">导航</a> \r\n           </div> \r\n           <!-- Collect the nav links, forms, and other content for toggling --> \r\n           <div class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\"> \r\n            <ul class=\"nav navbar-nav\"> \r\n             <li class=\"active\"><a href=\"#\">链接</a></li> \r\n             <li><a href=\"#\">链接</a></li> \r\n             <li class=\"dropdown\"> <a class=\"dropdown-toggle\" href=\"#\" data-toggle=\"dropdown\">下拉菜单 <b class=\"caret\"></b></a> \r\n              <ul class=\"dropdown-menu\"> \r\n               <li><a href=\"#\">列表一</a></li> \r\n               <li><a href=\"#\">列表二</a></li> \r\n               <li><a href=\"#\">列表三</a></li> \r\n               <li class=\"divider\"></li> \r\n               <li><a href=\"#\">更多列表</a></li> \r\n               <li class=\"divider\"></li> \r\n               <li><a href=\"#\">更多列表</a></li> \r\n              </ul> </li> \r\n            </ul> \r\n            <form class=\"navbar-form navbar-left\" role=\"search\"> \r\n             <div class=\"form-group\"> \r\n              <input class=\"form-control\" type=\"text\" placeholder=\"请输入搜索内容\"> \r\n             </div> \r\n             <button class=\"btn btn-default\" type=\"submit\">搜索</button> \r\n            </form> \r\n            <ul class=\"nav navbar-nav navbar-right\"> \r\n             <li><a href=\"#\">链接</a></li> \r\n             <li class=\"dropdown\"> <a class=\"dropdown-toggle\" href=\"#\" data-toggle=\"dropdown\"> 下拉菜单 <b class=\"caret\"></b></a> \r\n              <ul class=\"dropdown-menu\"> \r\n               <li><a href=\"#\">列表一</a></li> \r\n               <li><a href=\"#\">列表二</a></li> \r\n               <li><a href=\"#\">列表三</a></li> \r\n               <li class=\"divider\"></li> \r\n               <li><a href=\"#\">更多列表</a></li> \r\n               <li class=\"divider\"></li> \r\n               <li><a href=\"#\">更多列表</a></li> \r\n              </ul> </li> \r\n            </ul> \r\n           </div> \r\n           <!-- /.navbar-collapse --> \r\n          </nav>","datas":"","target":["反向(navbar-inverse)","定位                     :默认(),相对顶部(navbar-static-top),固定顶部(navbar-fixed-top),固定底部(navbar-fixed-bottom)",""],"editBtn":"1","dataBtn":"1"},{"iid":"f503716c-81d0-470f-8ef0-f5e9d5bdade3","title":"选项卡","cont":"<div class=\"tabbable\" id=\"myTabs\"> \r\n           <!-- Only required for left/right tabs --> \r\n           <ul class=\"nav nav-tabs\"> \r\n            <li class=\"active\"><a contenteditable=\"true\" href=\"#tab1\" data-toggle=\"tab\">选项卡一</a></li> \r\n            <li><a contenteditable=\"true\" href=\"#tab2\" data-toggle=\"tab\">选项卡二</a></li> \r\n           </ul> \r\n           <div class=\"tab-content\"> \r\n            <div class=\"tab-pane active\" id=\"tab1\"> \r\n             <p contenteditable=\"true\">选项卡一内容</p> \r\n            </div> \r\n            <div class=\"tab-pane\" id=\"tab2\"> \r\n             <p contenteditable=\"true\">选项卡二内容</p> \r\n            </div> \r\n           </div> \r\n          </div>","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"0e81e048-fb7b-44e7-bae1-6914c1e18f2b","title":"警告框","cont":"<div class=\"alert alert-success alert-dismissable\" contenteditable=\"true\"> \r\n           <button class=\"close\" aria-hidden=\"true\" type=\"button\" data-dismiss=\"alert\">×</button> \r\n           <h4>警告！</h4> \r\n           <strong>警告！</strong> 这里是警告的内容 \r\n           <a class=\"alert-link\" href=\"#\">查看</a> \r\n          </div>","datas":"","target":["样式                     :绿色(alert-success),青色(alert-info),橙色(alert-warning),红色(alert-danger)",""],"editBtn":"1","dataBtn":"1"},{"iid":"aab94215-8c13-47c2-8bb2-f575aa28af05","title":"折叠列表","cont":"<div class=\"panel-group\" id=\"myAccordion\"> \r\n           <div class=\"panel panel-default\"> \r\n            <div class=\"panel-heading\"> \r\n             <a class=\"panel-title\" contenteditable=\"true\" href=\"#collapseOne\" data-toggle=\"collapse\" data-parent=\"#myAccordion\"> 折叠一 </a> \r\n            </div> \r\n            <div class=\"panel-collapse collapse in\" id=\"collapseOne\"> \r\n             <div class=\"panel-body\" contenteditable=\"true\">\r\n               折叠一的内容... \r\n             </div> \r\n            </div> \r\n           </div> \r\n           <div class=\"panel panel-default\"> \r\n            <div class=\"panel-heading\"> \r\n             <a class=\"panel-title\" contenteditable=\"true\" href=\"#collapseTwo\" data-toggle=\"collapse\" data-parent=\"#myAccordion\"> 折叠二 </a> \r\n            </div> \r\n            <div class=\"panel-collapse collapse\" id=\"collapseTwo\"> \r\n             <div class=\"panel-body\" contenteditable=\"true\">\r\n               折叠二的内容... \r\n             </div> \r\n            </div> \r\n           </div> \r\n          </div>","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"0886ebbe-a7a8-416a-993e-d3c771f0a641","title":"轮播","cont":"<div class=\"carousel slide\" id=\"myCarousel\"> \r\n           <ol class=\"carousel-indicators\"> \r\n            <li class=\"active\" data-target=\"#myCarousel\" data-slide-to=\"0\"></li> \r\n            <li data-target=\"#myCarousel\" data-slide-to=\"1\"></li> \r\n            <li data-target=\"#myCarousel\" data-slide-to=\"2\"></li> \r\n           </ol> \r\n           <div class=\"carousel-inner\"> \r\n            <div class=\"item active\"> \r\n             <img alt=\"\" src=\"assets/img/1.jpg\"> \r\n             <div class=\"carousel-caption\"> \r\n              <h4>焦点图一</h4> \r\n              <p>焦点图一的描述,焦点图一的描述,焦点图一的描述,焦点图一的描述,焦点图一的描述,</p> \r\n             </div> \r\n            </div> \r\n            <div class=\"item\"> \r\n             <img alt=\"\" src=\"assets/img/2.jpg\"> \r\n             <div class=\"carousel-caption\"> \r\n              <h4>焦点图二</h4> \r\n              <p>焦点图二的描述,焦点图二的描述,焦点图二的描述,焦点图二的描述,焦点图二的描述,焦点图二的描述,</p> \r\n             </div> \r\n            </div> \r\n            <div class=\"item\"> \r\n             <img alt=\"\" src=\"assets/img/3.jpg\"> \r\n             <div class=\"carousel-caption\"> \r\n              <h4>焦点图三</h4> \r\n              <p>焦点图三的描述，焦点图三的描述，焦点图三的描述，焦点图三的描述，焦点图三的描述，</p> \r\n             </div> \r\n            </div> \r\n           </div> \r\n           <a class=\"left carousel-control\" href=\"#myCarousel\" data-slide=\"prev\"> <span class=\"glyphicon glyphicon-chevron-left\"></span> </a> \r\n           <a class=\"right carousel-control\" href=\"#myCarousel\" data-slide=\"next\"> <span class=\"glyphicon glyphicon-chevron-right\"></span> </a> \r\n          </div>","datas":"","target":"","editBtn":"1","dataBtn":"1"}]},{"text":"扩展组件","items":[{"iid":"3a7cebe4-8c88-4ccf-8e9b-76a852e17f69","title":"网站顶部","cont":"<!-- 网站顶部 start --> \r\n          <div id=\"top\"> \r\n           <div id=\"topBar\"> \r\n            <div class=\"userPanel\"> \r\n             <ul> \r\n              <li><a href=\"#\">手机版</a></li> \r\n              <li><a href=\"#\">设为首页</a></li> \r\n              <li><a href=\"#\">加入收藏</a></li> \r\n              <li><a href=\"#\">联系我们</a></li> \r\n             </ul> \r\n            </div> \r\n            <div class=\"welcome\">\r\n              欢迎光临未命名网站！ \r\n            </div> \r\n           </div> \r\n           <!-- topBar end --> \r\n          </div> \r\n          <!-- 网站顶部 end -->","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"1098a53c-ea88-45cc-b7d6-282a97409367","title":"网站LOGO","cont":"<!-- 网站LOGO start --> \r\n          <div id=\"header\"> \r\n           <div class=\"topAD\">\r\n             专业、专注、专心 \r\n           </div> \r\n           <div class=\"logo\">\r\n             未命名标准网站 \r\n           </div> \r\n          </div> \r\n          <!-- 网站LOGO end -->","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"6e1982eb-6f6a-48ec-868a-9506781d8814","title":"通用信息列表","cont":"<!-- 通用信息列表 start --> \r\n          <ul class=\"infoList\"> \r\n           <li> <span class=\"date\">01-02</span> <a href=\"#\">红木家具保养七绝技</a> </li> \r\n           <li> <span class=\"date\">01-02</span> <a href=\"#\">何时购买红木家具最合适？</a> </li> \r\n           <li> <span class=\"date\">01-02</span> <a href=\"#\">红木家具绿色环保</a> </li> \r\n           <li> <span class=\"date\">01-02</span> <a href=\"#\">选购和定制家具，消费者如…</a> </li> \r\n           <li> <span class=\"date\">01-02</span> <a href=\"#\">享受古典家具 红木家具难弃爱</a> </li> \r\n           <li> <span class=\"date\">01-02</span> <a href=\"#\">红木家具保养七绝技</a> </li> \r\n           <li> <span class=\"date\">01-02</span> <a href=\"#\">何时购买红木家具最合适？</a> </li> \r\n           <li> <span class=\"date\">01-02</span> <a href=\"#\">红木家具绿色环保</a> </li> \r\n           <li> <span class=\"date\">01-02</span> <a href=\"#\">选购和定制家具，消费者如…</a> </li> \r\n           <li> <span class=\"date\">01-02</span> <a href=\"#\">享受古典家具 红木家具难弃爱</a> </li> \r\n          </ul> \r\n          <!-- 通用信息列表 end -->","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"50e01791-f87c-44c5-84ca-cc5651498943","title":"网站底部","cont":"<!-- 网站底部 start --> \r\n          <div id=\"footer\"> \r\n           <div class=\"footerNav\"> \r\n            <a href=\"#\">关于我们</a> | \r\n            <a href=\"#\">服务条款</a> | \r\n            <a href=\"#\">免责声明</a> | \r\n            <a href=\"#\">网站地图</a> | \r\n            <a href=\"#\">联系我们</a> \r\n           </div> \r\n           <div class=\"copyRight\">\r\n             Copyright ?2010-2014未命名 版权所有 \r\n           </div> \r\n          </div> \r\n          <!-- 网站底部 end -->","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"f3c56d8a-4558-47d6-80cd-0c68d1ed7205","title":"侧栏导航菜单","cont":"<!-- 侧栏导航菜单 start --> \r\n          <div class=\"sideBox\" id=\"sideMenu\"> \r\n           <div class=\"hd\"> \r\n            <h3><span>关于我们</span></h3> \r\n           </div> \r\n           <div class=\"bd\"> \r\n            <ul class=\"menuList\"> \r\n             <li><a href=\"#\">公司简介</a></li> \r\n             <li><a href=\"#\">企业文化</a></li> \r\n             <li><a href=\"#\">组织结构</a></li> \r\n             <li><a href=\"#\">资质认证</a></li> \r\n             <li><a href=\"#\">联系我们</a></li> \r\n            </ul> \r\n           </div> \r\n          </div> \r\n          <!-- 侧栏导航菜单 end -->","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"8f13f120-282c-4108-8926-57f020794e26","title":"文章子列表页","cont":"<!-- 文章子列表页 start --> \r\n          <div class=\"box ui-draggable\" id=\"mainBox\"> \r\n           <div class=\"mHd\"> \r\n            <div class=\"path\"> \r\n             <em>您现在位置：</em> \r\n             <a class=\"home\" href=\"index.html\">首页</a>&gt; \r\n             <a href=\"#\" target=\"_self\">关于我们</a>&gt; \r\n             <a href=\"#\" target=\"_self\">公司简介</a> \r\n            </div> \r\n            <h3><span>公司简介</span></h3> \r\n           </div> \r\n           <div class=\"mBd\"> \r\n            <ul class=\"newsList\"> \r\n             <li> <span class=\"date\">01-02</span> <a href=\"#\">红木家具保养七绝技</a> </li> \r\n             <li> <span class=\"date\">01-02</span> <a href=\"#\">何时购买红木家具最合适？</a> </li> \r\n             <li> <span class=\"date\">01-02</span> <a href=\"#\">红木家具绿色环保</a> </li> \r\n             <li> <span class=\"date\">01-02</span> <a href=\"#\">选购和定制家具，消费者如…</a> </li> \r\n             <li> <span class=\"date\">01-02</span> <a href=\"#\">享受古典家具 红木家具难弃爱</a> </li> \r\n             <li class=\"split\"></li> \r\n             <li> <span class=\"date\">01-02</span> <a href=\"#\">红木家具保养七绝技</a> </li> \r\n             <li> <span class=\"date\">01-02</span> <a href=\"#\">何时购买红木家具最合适？</a> </li> \r\n             <li> <span class=\"date\">01-02</span> <a href=\"#\">红木家具绿色环保</a> </li> \r\n             <li> <span class=\"date\">01-02</span> <a href=\"#\">选购和定制家具，消费者如…</a> </li> \r\n             <li> <span class=\"date\">01-02</span> <a href=\"#\">享受古典家具 红木家具难弃爱</a> </li> \r\n            </ul> \r\n           </div> \r\n          </div> \r\n          <!-- 文章子列表页 end -->","datas":"","target":"","editBtn":"1","dataBtn":"1"},{"iid":"f0f897d9-7f7f-49bb-82e8-a30d321b2ab9","title":"文章内容页","cont":"<!-- 文章内容页 start --> \r\n          <div class=\"articleContent\"> \r\n           <h2 class=\"title\">选购和定制家具，消费者如何少花钱？</h2> \r\n           <div class=\"property\"> \r\n            <span>文章来源：互联网</span> \r\n            <span>作者：朱春</span> \r\n            <span>发布时间：2013年12月03日</span> \r\n            <span>点击数：25</span> \r\n            <span>【字号：<a class=\"fontZoomA\" href=\"javascript:fontZoomA();\">小</a><a class=\"fontZoomB\" href=\"javascript:fontZoomB();\">大</a>】</span> \r\n           </div> \r\n           <div id=\"contentTxt\"> \r\n            <p style=\"text-align: center;\"><img src=\"assets/images/banner1.jpg\"></p> \r\n            <p> 五金、建材的价格涨了，家具也要提价了，打算定制家具的业主要如何省钱？一些整体衣柜企业从厂家的角度提出了几条非常实用的建议，消费者不妨看看。</p> \r\n            <p> 第一可以选择到性价比比较高的厂家定制家具。高性价比意味着产品品质有保证，价钱又比较实惠。而且即使涨价，这类品牌的产品也不会涨太多。</p> \r\n            <p> 还有就是可以选择参加厂家举行的团购。一般来说，厂家在团购会提供的产品，价格要比市场价优惠，而且产品质量也有保证。对于定制衣柜等大量家具的消费者来说，通过团购，能节省不少费用。这也是团购会收到热烈欢迎的一个原因。同时，通过参加团购提早签单，也是避免涨价风险的一个好办法。厂家推荐的其他装修省钱之道还有多了解市场行情、在节假日时选购家具、参加网购等。</p> \r\n           </div> \r\n          </div> \r\n          <!-- 文章内容页 end -->","datas":"","target":"","editBtn":"1","dataBtn":"1"}]}];
	function makeDataDef(data){
		for(var i=0;i<data.length;i++){
			var boxs=$('.sidebar-nav .accordion-group:eq('+(i+1)+') li.boxes');
			boxs.find('.box-element').each(function(){
				$(this).remove();
			});
			var items=data[i].items;
			for(var j=0;j<items.length;j++){
				createBoxItem(boxs,items[j]);
			};
		}		
	}
	
	$.ajax({
		url: MISC_FILE,
		type: "get",
		dataType:'json',
		data:{param:'file',path:LAY_DATA},
		success: function (data) {
			makeDataDef(data);	
		},
		error: function (e) {
			makeDataDef(defData);
		}
	});
}

$(function(){	
	$('#button-open-modal').click(function(){		
		$.ajax({
			url: MISC_FILE,
			type: "get",
			dataType:'json',
			data:{param:'files',path:PAGE_DATA},
			success: function (data) {
				var html='';
				for(var i=0;i<data.length;i++){
					var fname=unescape(data[i].text);
					if(fname.indexOf('.org')>0)
						html+='<li><a href="#">'+fname.replace('.org','')+'</a></li>';
				}			
				$('#fileList .fileList').html(html);
			},
			error: function (e) {
				console.log(e);
			}		
		})
	})
	
	$('#previewCode').click(function(){		
		getLayoutHtml(function(html){
			var myWindow=window.open() ;
			myWindow.document.write(html); 
			myWindow.focus();
		})
	})
	
	$('#previewTemplate').click(function(){
		var cont=$("#downloadModal textarea").val();
		var filename=$('#_fileName').html();
		filename+='.temp';
		$.ajax({
			url: MISC_FILE,
			type: "post",
			dataType:'json',
			data:{param:'save',path:filename,cont:cont},
			success: function (data) {
				var url='/users/'+$('body').attr('developer')+'/'+$('body').attr('appcode')+'/assets/template.chi?code='+filename;
				window.open(url);
			}
		});
	})
	
	$('#createTemplate').click(function(){
		var appcode=$('body').attr('appcode');
		var fname=$('#_fileName').html();
		var i=fname.lastIndexOf('/');
		var code=fname.substring(0,i);
		i=code.indexOf('/');
		code=code.substring(i+1,code.length);
		$.ajax({
			url: MISC_FILE,
			type: "post",
			dataType:'html',
			data:{param:'file',path:appcode+'/assets/template.txt'},
			success: function (html) {
				var cont=$("#downloadModal textarea").val();				
				var cnt=html.replace('<!--div class="container"></div-->',cont).replace('#ACODE#',fname);
				$.ajax({
					url: MISC_FILE,
					type: "post",
					dataType:'json',
					data:{param:'save',path:appcode+'/assets/'+code+'.chi',cont:cnt},
					success: function (data) {
						
					}
				});
			}
		});
	})
})

function getLayoutHtml(h){
	var html='<!DOCTYPE html><html><head><link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.2/css/bootstrap.min.css">'+
			'<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">'+
			'<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>'+
			'<script src="http://cdn.bootcss.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>'+
			'<link href="//libs.baidu.com/fontawesome/4.0.3/css/font-awesome.min.css" rel="stylesheet">'+
//			'<link rel="stylesheet" href="assets/css/base.css">'+
			'</head><body>';
	html+=$("#downloadModal textarea").val();
	html+='</body></html>';
	if(h)h(html)
	else return html;
}

function saveLayoutClick(){
	downloadLayoutSrc();
	var cont= getLayoutHtml();
	$.ajax({
		url: MISC_FILE,
		type: "post",
		dataType:'json',
		data:{param:'save',path:PAGE_DATA+'/'+$('#file_name').val(),cont:cont},
		success: function (data) {
			alert('保存成功!');
		}
	});
	$.ajax({
		url: MISC_FILE,
		type: "post",
		dataType:'json',
		data:{param:'save',path:PAGE_DATA+'/'+$('#file_name').val()+'.org',cont:$('.demo').html()}
	});
}

function showConfig(iid){
	var box=$('.sidebar-nav [iid="'+iid+'"]');
	if(box.length==0)box=null;
	makeItemDialog(box);
	$('#configModal').modal('show');
	$('#saveConfigBtn').unbind('click');
	$('#saveConfigBtn').bind('click',function(){
		var data=$('#configModal form').serializeObject();
		if(!box)box=$('#extentBox');
		createBoxItem(box,data);
	});
	if(!box){
		$('#delConfigBtn').hide();
	}
	else{
		$('#delConfigBtn').show();
		$('#delConfigBtn').unbind('click');
		$('#delConfigBtn').bind('click',function(){
			$('#configModal').modal('hide');
			box.remove();
		});
	}
}

function resetForm(ModalID){
	$('#'+ModalID+' form')[0].reset()
}

function createBoxItem(boxes,data){
	var box='<div class="box box-element" iid="'+data.iid+'" datas="'+data.datas+'"> <a href="#close" class="remove label label-danger"><i class="glyphicon glyphicon-remove"></i> 删除</a>'; 
    box+='<span class="drag label label-default"><i class="glyphicon glyphicon-move"></i> 拖动</span>';
	box+='<span class="configuration">';
	if(data.dataBtn==1){
		box+='<button type="button" class="btn btn-default btn-xs" data-target="#dataModal" role="button" data-toggle="modal">数据</button> ';
	}
	if(data.editBtn==1){
		box+='<button type="button" class="btn btn-default btn-xs" data-target="#editorModal" role="button" data-toggle="modal">编辑</button> ';
	}
	if(data.target){
		for(var i=0;i<data.target.length;i++){
			var target=data.target[i];
			if(target!==""){
				var targets=target.split(':');
				if(targets.length==1){
					var rels=target.split('(');
					var rel=rels[1].substring(0,rels[1].indexOf(')'));
					box+='<a class="btn btn-xs btn-default" href="#" rel="'+rel+'">'+rels[0]+'</a> ';
				}
				else if(targets.length==2){
					box+='<span class="btn-group btn-group-xs"> <a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="#">'+targets[0]+' <span class="caret"></span></a><ul class="dropdown-menu">';
					var tarA=targets[1].split(',');
					var cls='active';
					for(var j=0;j<tarA.length;j++){
						if(j>0) cls='';
						var rels=tarA[j].split('(');
						var rel=rels[1].substring(0,rels[1].indexOf(')'));
						box+='<li class="'+cls+'"><a href="#" rel="'+rel+'">'+rels[0]+'</a></li>'; 
					}
					box+='</ul> </span> ';
				}
			}
		}
	}
	box+='</span>';	
	box+='<div class="preview"><a href="#" onclick=showConfig("'+data.iid+'")>'+data.title+'</a></div>';
	box+='<div class="view">'+data.cont+'</div>';

	if($('.sidebar-nav [iid="'+data.iid+'"]').length>0){
		$('.sidebar-nav [iid="'+data.iid+'"]').replaceWith($(box));
	}
	else{
		boxes.append($(box));		
	}
	dragBox($('.sidebar-nav [iid="'+data.iid+'"]'));	
}        
		

function newDataTemplate(obj){
	var row=$(obj).parents(".dataInput");
	var nrow=row.clone();
	row.before(nrow);
	return nrow;
}

function delDataTemplate(obj){
	var row=$(obj).parents(".dataInput");
	if(row.parent().children(".dataInput").length>1){		
		row.remove();
	}
}

function clearDataTemplate(iid){
	var box=$('#'+iid);
	box.find('input[name="dataBtn"]').button('reset');
	box.find('input[name="editBtn"]').button('reset');
	var rows=$('#'+iid+' .dataInput');
	for(var i=0;i<rows.length;i++){
		if(i==0)
			rows.find('input[name="target"]').val('');
		else 
			rows.eq(i).remove();
	}
	
}

function typeSelect(obj){
	var inputGroup=$(obj).parent().parent().parent();
	inputGroup.find("button").html($(obj).text()+' <span class="caret"></span>');
	inputGroup.find('input[name="type"]').val($(obj).attr("value"));
}

function alert(m){
	$('#myAlert .modal-body p').text(m);
	$("#myAlert").modal('show');
}

$.fn.serializeObject = function()    
{    
   var o = {};    
   var a = this.serializeArray();    
   $.each(a, function() {    
       if (o[this.name]) {    
           if (!o[this.name].push) {    
               o[this.name] = [o[this.name]];    
           }    
           o[this.name].push(this.value || '');    
       } else {    
           o[this.name] = this.value || '';    
       }    
   });    
   return o;    
};  

function uuid() {
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";
 
    var uuid = s.join("");
    return uuid;
}


function exportLayout(){
	var cont= $(".demo").html();
	var link = document.createElement("a");
	var _fileName=$('#_fileName').html();
	var si=_fileName.indexOf('/');
	var ei=_fileName.lastIndexOf('/');
	link.download = _fileName.substring(si+1,ei)+'.zlay';
	link.href = "data:text/plain;base64," + btoa(unescape(encodeURIComponent(cont)));
	document.body.appendChild(link);
	link.click();
	link.parentNode.removeChild(link);
}

function importLayout(that){
	if(!that.input){
		that.input=document.createElement("input");
		that.input.type = "file";

		that.input.onchange = function(e) {
			var file = e.target.files[0];
			if (!file) { return; }

			var reader = new FileReader();
			reader.onload = function() { 
				$(".demo").html(reader.result);
				initContainer();
			}
			reader.onerror = function() { console.log(reader.error); }
			reader.readAsText(file);
		}.bind(this);
	}
	that.input.click();
}