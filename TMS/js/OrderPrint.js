//添加默认样式页
function Print_AddPages(_pages){

	var pages = _pages;
	var totlapage = _pages;
	var pageindex = 1;
	
	sum[0] = [];
	
	var dataitem1 = $(".datatable tbody tr:eq(0) td");
	
	while(pages>0){
		//添加默认样式的页
		var copydefault = $(".default").clone();
		copydefault.removeClass("default");
		copydefault.addClass("page0");
		copydefault.addClass("page"+pageindex);
		$("body").append(copydefault);
		
		
		//添加页码到.pagecode
		var code = "第"+pageindex+"页    共"+totlapage+"页";
		$(".page"+pageindex+" .pagecode").text(code);
			
		//为每页加入打印分隔符	
		if(pages==1){
		
		}else{$(".page"+pageindex).css("page-break-after","always");}		
		
		sum[pageindex] = [];	//定义元素数组
		
		//初始化合计数组各元素
		for(var i=0;i<dataitem1.length;i++){
			sum[0][i] = 0.0;
			sum[pageindex][i] = 0.0;
		}
		
		pageindex++;
		pages--;
	}
	
	
	//每页添加表格
	$(".body").append("<table></table>");
	//添加表格的标题
	$(".body table").append($(".datatable thead").clone());
	//添加表格的表体
	$(".body table").append("<tbody></tbody>");	
}

//添加数据判断首页末页特殊处理判断合计
function Print_AddDatas(_firstrownum,_rownum,_lastrownum,_pages,data,_special){
	var firstrownum = _firstrownum;
	var rownum = _rownum;
	var lastrownum = _lastrownum;
	var pagesum = false;
	var pages = _pages;
	var special = _special;
	
	var rowindex = 1;
	var pageindex2 = 1;
	var dataitem1 = $(".datatable tbody tr:eq(0) td");
	
	for(var i=0;i<data[0].rs[0].rows.length;i++){
	
		var commodityinfo = data[0].rs[0].rows[i];
		
		if(typeof(firstrownum)=='undefined'&&typeof(lastrownum)=='undefined'){
			
			if(rowindex%rownum==0){							//1.1、页尾行的处理
				//1.1.1、增加一行
				$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
				//1.1.2、添加数据	
				for(var j=0;j<dataitem1.length;j++){
					
					$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
					
					if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
					
						sum[pageindex2][j] = 0.0;
						
						$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
						
						for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
							var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
							$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
						}
						
					}else{
					
						var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
						$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
						
						if(isNaN(parseFloat(info))){
							sum[pageindex2][j] = 0.0;
						}else{
							sum[pageindex2][j] += parseFloat(info);
						}
					}
				}
				
				for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
					if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
						pagesum = true;
					}else{
						//do nothing
					}
				}
				
				if(pagesum){														//根据条件添加每页合计
					$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
					
					for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
						if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
						}else{
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
						}
					}
				}else{
						//do nothing
				}
				
				rowindex++;
				pageindex2++;
				
			}else{													//1.2、一般行的处理	
				//1.2.1、增加一行
				$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
				//1.2.2、添加数据	
				for(var j=0;j<dataitem1.length;j++){
					
					$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
					
					if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
					
						sum[pageindex2][j] = 0.0;
						
						$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
						
						for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
							var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
							$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
						}
						
					}else{
					
						var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
						$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
						
						if(isNaN(parseFloat(info))){
							sum[pageindex2][j] = 0.0;
						}else{
							sum[pageindex2][j] += parseFloat(info);
						}
					}
				}
				rowindex++;
			}
		}else if(typeof(firstrownum)!=='undefined'&&typeof(lastrownum)=='undefined'){
			if(pages==1){
				if(rowindex%firstrownum==0){											//1.1、页尾行的处理
					//1.1.1、增加一行
					$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
					//1.1.2、添加数据	
					for(var j=0;j<dataitem1.length;j++){
						
						$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
						
						if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
						
							sum[pageindex2][j] = 0.0;
							
							$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
							
							for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
								var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
								$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
							}
							
						}else{
						
							var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
							$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
							
							if(isNaN(parseFloat(info))){
								sum[pageindex2][j] = 0.0;
							}else{
								sum[pageindex2][j] += parseFloat(info);
							}
						}
					}
					
					for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
						if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
							pagesum = true;
						}else{
							//do nothing
						}
					}
					
					if(pagesum){														//根据条件添加每页合计
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						
						for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
							if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
							}else{
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							}
						}
					}else{
							//do nothing
					}
					
					rowindex++;
					pageindex2++;
					
				}else{																	//1.2、一般行的处理	
					//1.2.1、增加一行
					$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
					//1.2.2、添加数据	
					for(var j=0;j<dataitem1.length;j++){
						
						$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
						
						if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
						
							sum[pageindex2][j] = 0.0;
							
							$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
							
							for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
								var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
								$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
							}
							
						}else{
						
							var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
							$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
							
							if(isNaN(parseFloat(info))){
								sum[pageindex2][j] = 0.0;
							}else{
								sum[pageindex2][j] += parseFloat(info);
							}
						}
					}
					rowindex++;
				}
			}else{
				if(pageindex2==1){
					if(rowindex%firstrownum==0){							//1.1、页尾行的处理
						//1.1.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.1.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						
						for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
							if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
								pagesum = true;
							}else{
								//do nothing
							}
						}
						
						if(pagesum){														//根据条件添加每页合计
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							
							for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
								if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
								}else{
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								}
							}
						}else{
								//do nothing
						}
						
						rowindex++;
						pageindex2++;
						
					}else{													//1.2、一般行的处理	
						//1.2.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.2.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						rowindex++;
					}
				}else{
					if((rowindex-firstrownum)%rownum==0){							//1.1、页尾行的处理
						//1.1.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.1.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						
						for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
							if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
								pagesum = true;
							}else{
								//do nothing
							}
						}
						
						if(pagesum){														//根据条件添加每页合计
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							
							for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
								if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
								}else{
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								}
							}
						}else{
								//do nothing
						}
						
						rowindex++;
						pageindex2++;
						
					}else{													//1.2、一般行的处理	
						//1.2.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.2.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						rowindex++;
					}
				}
			}
		}else if(typeof(firstrownum)=='undefined'&&typeof(lastrownum)!=='undefined'){
			if(special){
				//特殊情况 num%rownum 大于 lastrownum 又小于 rownum 需要补充一页空行页 所有数据行都按rownum容量
				if(rowindex%rownum==0){								//1.1、页尾行的处理
					//1.1.1、增加一行
					$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
					//1.1.2、添加数据	
					for(var j=0;j<dataitem1.length;j++){
						
						$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
						
						if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
						
							sum[pageindex2][j] = 0.0;
							
							$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
							
							for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
								var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
								$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
							}
							
						}else{
						
							var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
							$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
							
							if(isNaN(parseFloat(info))){
								sum[pageindex2][j] = 0.0;
							}else{
								sum[pageindex2][j] += parseFloat(info);
							}
						}
					}
					
					for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
						if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
							pagesum = true;
						}else{
							//do nothing
						}
					}
					
					if(pagesum){														//根据条件添加每页合计
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						
						for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
							if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
							}else{
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							}
						}
					}else{
							//do nothing
					}
					
					rowindex++;
					pageindex2++;
					
				}else{													//1.2、一般行的处理	
					//1.2.1、增加一行
					$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
					//1.2.2、添加数据	
					for(var j=0;j<dataitem1.length;j++){
						
						$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
						
						if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
						
							sum[pageindex2][j] = 0.0;
							
							$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
							
							for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
								var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
								$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
							}
							
						}else{
						
							var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
							$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
							
							if(isNaN(parseFloat(info))){
								sum[pageindex2][j] = 0.0;
							}else{
								sum[pageindex2][j] += parseFloat(info);
							}
						}
					}
					rowindex++;
				}
			}else{
				if(pages==1){	//every bottom 只有一页 行数就是lastrownum
					if(rowindex%lastrownum==0){								//1.1、页尾行的处理
						//1.1.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.1.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						
						for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
							if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
								pagesum = true;
							}else{
								//do nothing
							}
						}
						
						if(pagesum){														//根据条件添加每页合计
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							
							for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
								if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
								}else{
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								}
							}
						}else{
								//do nothing
						}
						
						rowindex++;
						pageindex2++;
						
					}else{																	//1.2、一般行的处理	
						//1.2.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.2.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						rowindex++;
					}
				}else{																		//无特殊情况不止一页
					if(pageindex2==pages){
						if((rowindex%rownum)==lastrownum){											//1.1、页尾行的处理
							//1.1.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.1.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}

							for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
								if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
									pagesum = true;
								}else{
									//do nothing
								}
							}
							
							if(pagesum){														//根据条件添加每页合计
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
									if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
									}else{
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
									}
								}
							}else{
									//do nothing
							}
							
							rowindex++;
							pageindex2++;
							
						}else{													//1.2、一般行的处理	
							//1.2.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.2.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							rowindex++;
						}
					}else{
						if(rowindex%rownum==0){								//1.1、页尾行的处理
							//1.1.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.1.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							
							for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
								if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
									pagesum = true;
								}else{
									//do nothing
								}
							}
							
							if(pagesum){														//根据条件添加每页合计
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
									if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
									}else{
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
									}
								}
							}else{
									//do nothing
							}
							
							rowindex++;
							pageindex2++;
							
						}else{													//1.2、一般行的处理	
							//1.2.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.2.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							rowindex++;
						}
					}
				}
			}
		}else if(typeof(firstrownum)!=='undefined'&&typeof(lastrownum)!=='undefined'){
			if(special){
				if(pageindex2==1){
					if(rowindex%firstrownum==0){							//1.1、页尾行的处理
						//1.1.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.1.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						
						for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
							if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
								pagesum = true;
							}else{
								//do nothing
							}
						}
						
						if(pagesum){														//根据条件添加每页合计
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							
							for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
								if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
								}else{
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								}
							}
						}else{
								//do nothing
						}
						
						rowindex++;
						pageindex2++;
						
					}else{													//1.2、一般行的处理	
						//1.2.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.2.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						rowindex++;
					}
				}else{
					if((rowindex-firstrownum)%rownum==0){							//1.1、页尾行的处理
						//1.1.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.1.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						
						for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
							if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
								pagesum = true;
							}else{
								//do nothing
							}
						}
						
						if(pagesum){														//根据条件添加每页合计
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							
							for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
								if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
								}else{
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								}
							}
						}else{
								//do nothing
						}
						
						rowindex++;
						pageindex2++;
						
					}else{													//1.2、一般行的处理	
						//1.2.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.2.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						rowindex++;
					}
				}
			}else{
				if(pages==1){
					if(rowindex%(lastrownum+firstrownum-rownum)==0){							//1.1、页尾行的处理
						//1.1.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.1.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						
						for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
							if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
								pagesum = true;
							}else{
								//do nothing
							}
						}
						
						if(pagesum){														//根据条件添加每页合计
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							
							for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
								if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
								}else{
									$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								}
							}
						}else{
								//do nothing
						}
						
						rowindex++;
						pageindex2++;
						
					}else{													//1.2、一般行的处理	
						//1.2.1、增加一行
						$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
						//1.2.2、添加数据	
						for(var j=0;j<dataitem1.length;j++){
							
							$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
							
							if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
							
								sum[pageindex2][j] = 0.0;
								
								$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
								
								for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
									var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
									$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
								}
								
							}else{
							
								var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
								$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
								
								if(isNaN(parseFloat(info))){
									sum[pageindex2][j] = 0.0;
								}else{
									sum[pageindex2][j] += parseFloat(info);
								}
							}
						}
						rowindex++;
					}
				}else if(pages==2){
					if(pageindex2==1){
						if(rowindex%firstrownum==0){							//1.1、页尾行的处理
							//1.1.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.1.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							
							for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
								if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
									pagesum = true;
								}else{
									//do nothing
								}
							}
							
							if(pagesum){														//根据条件添加每页合计
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
									if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
									}else{
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
									}
								}
							}else{
									//do nothing
							}
							
							rowindex++;
							pageindex2++;
							
						}else{													//1.2、一般行的处理	
							//1.2.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.2.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							rowindex++;
						}
					}else if(pageindex2==2){
						if(rowindex%lastrownum==0){							//1.1、页尾行的处理
							//1.1.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.1.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							
							for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
								if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
									pagesum = true;
								}else{
									//do nothing
								}
							}
							
							if(pagesum){														//根据条件添加每页合计
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
									if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
									}else{
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
									}
								}
							}else{
									//do nothing
							}
							
							rowindex++;
							pageindex2++;
							
						}else{													//1.2、一般行的处理	
							//1.2.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.2.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							rowindex++;
						}
					}
				}else{
					if(pageindex2==1){
						if(rowindex%firstrownum==0){							//1.1、页尾行的处理
							//1.1.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.1.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							
							for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
								if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
									pagesum = true;
								}else{
									//do nothing
								}
							}
							
							if(pagesum){														//根据条件添加每页合计
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
									if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
									}else{
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
									}
								}
							}else{
									//do nothing
							}
							
							rowindex++;
							pageindex2++;
							
						}else{													//1.2、一般行的处理	
							//1.2.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.2.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							rowindex++;
						}
					}else if(pageindex2==pages){
						if((rowindex-firstrownum-(pages-2)*rownum)%lastrownum==0){							//1.1、页尾行的处理
							//1.1.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.1.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							
							for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
								if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
									pagesum = true;
								}else{
									//do nothing
								}
							}
							
							if(pagesum){														//根据条件添加每页合计
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
									if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
									}else{
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
									}
								}
							}else{
									//do nothing
							}
							
							rowindex++;
							pageindex2++;
							
						}else{													//1.2、一般行的处理	
							//1.2.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.2.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							rowindex++;
						}
					}else{
						if((rowindex-firstrownum)%rownum==0){							//1.1、页尾行的处理
							//1.1.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.1.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							
							for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//判断是否添加每页合计
								if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
									pagesum = true;
								}else{
									//do nothing
								}
							}
							
							if(pagesum){														//根据条件添加每页合计
								$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
								
								for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
									if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td>"+sum[pageindex2][y]+"</td>");
									}else{
										$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
									}
								}
							}else{
									//do nothing
							}
							
							rowindex++;
							pageindex2++;
							
						}else{													//1.2、一般行的处理	
							//1.2.1、增加一行
							$(".page"+pageindex2+" .body table tbody").append("<tr></tr>");
							//1.2.2、添加数据	
							for(var j=0;j<dataitem1.length;j++){
								
								$(".page"+pageindex2+" .body table tbody tr").last().append("<td></td>");
								
								if($(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").length==1){
								
									sum[pageindex2][j] = 0.0;
									
									$(".page"+pageindex2+" .body table tbody tr td").last().append("<ul></ul>");
									
									for(var k=0;k<$(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").length;k++){
										var info = eval('commodityinfo.' + $(".datatable tbody tr:eq(0) td:eq("+j+")").children("ul").children("li").eq(k).text());
										$(".page"+pageindex2+" .body table tbody tr td ul").last().append("<li>"+info+"</li>");
									}
									
								}else{
								
									var info = eval('commodityinfo.'+$(".datatable tbody tr:eq(0) td:eq("+j+")").text());
									$(".page"+pageindex2+" .body table tbody tr td").last().append(info);
									
									if(isNaN(parseFloat(info))){
										sum[pageindex2][j] = 0.0;
									}else{
										sum[pageindex2][j] += parseFloat(info);
									}
								}
							}
							rowindex++;
						}
					}	
				}
			}
		}	
	}
}

function Print_AddEmptyrow(_num,_firstrownum,_rownum,_lastrownum,_pages){
	var num = _num;
	var firstrownum = _firstrownum;
	var rownum = _rownum;
	var lastrownum = _lastrownum;
	var pages = _pages;
	var dataitem1 = $(".datatable tbody tr:eq(0) td");
	var pagesum1 = false;
	var pagesum2 = false;
	
	if(typeof(firstrownum)=='undefined'&&typeof(lastrownum)=='undefined'){
		if(num%rownum==0){
			var rowextra1 = 0;
		}else{
			var rowextra1 = rownum - num%rownum;
		}
	}else if(typeof(firstrownum)!=='undefined'&&typeof(lastrownum)=='undefined'){
		if(num<=firstrownum){
			var rowextra1 = firstrownum - num;
		}else{
			if((num-firstrownum)%rownum==0){
				var rowextra1 = 0;
			}else{
				var rowextra1 = rownum - (num-firstrownum)%rownum;
			}
		}
	}else if(typeof(firstrownum)=='undefined'&&typeof(lastrownum)!=='undefined'){
		if(pages==1){
			var rowextra1 = lastrownum - num;
		}else{
			if(num%rownum==0){
				var rowextra1 = lastrownum;
			}else if(num%rownum>lastrownum){
				var rowextra1 = rownum - num%rownum;
				var rowextra2 = lastrownum;
			}else if(num%rownum<=lastrownum){
				var rowextra1 = lastrownum - num%rownum;
			}
		}
	}else if(typeof(firstrownum)!=='undefined'&&typeof(lastrownum)!=='undefined'){
		if(pages==1){
			if((firstrownum+lastrownum-rownum)==num){
				var rowextra1 = 0;
			}else{
				var rowextra1 = firstrownum+lastrownum-rownum-num;
			}
		}else if(pages==2){
			if((num-firstrownum)==lastrownum){
				var rowextra1 = 0;
			}else{
				var rowextra1 = lastrownum - (num-firstrownum);
			}
		}else{
			if((num-firstrownum)%rownum==0){
				var rowextra1 = lastrownum;
			}else if((num-firstrownum)%rownum>lastrownum){
				var rowextra1 = (rownum - (num - firstrownum)%rownum);
				var rowextra2 = lastrownum;
			}else if((num-firstrownum)%rownum<lastrownum){
				var rowextra1 = lastrownum - (num-firstrownum)%rownum;
			}
		}
	}
	
	if(rowextra1==0){
		var addpagesum = false;
	}else{
		var addpagesum = true;
	}
	
	if(typeof(rowextra2)=='undefined'){
	
		while(rowextra1>=1){
			$(".page"+pages+" .body table tbody").append("<tr></tr>");
			
			for(var i=0;i<$(".datatable tbody tr:eq(1) td").length;i++){
				$(".page"+pages+" .body table tbody tr").last().append("<td></td>");
			}
			rowextra1--;
		}
		
		if(addpagesum){	//如果没有空行需要加，表示每页合计已经在添加数据的时候添加了
			for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//最后一行判断是否添加每页合计
				if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
					pagesum1 = true;
				}else{
					//do nothing
				}
			}
			
			if(pagesum1){														//最后一行根据条件添加每页合计
				
				$(".page"+pages+" .body table tbody").append("<tr></tr>");
				
				for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
					if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
						$(".page"+pages+" .body table tbody tr").last().append("<td>"+sum[pages][y]+"</td>");
					}else{
						$(".page"+pages+" .body table tbody tr").last().append("<td></td>");
					}
				}
				
			}else{
					//do nothing
			}
		}else{
			
		}
		
	}else{
	
		while(rowextra1>=1){
			$(".page"+(pages-1)+" .body table tbody").append("<tr></tr>");
			
			for(var i=0;i<$(".datatable tbody tr:eq(1) td").length;i++){
				$(".page"+(pages-1)+" .body table tbody tr").last().append("<td></td>");
			}
			rowextra1--;
		}
		
		for(var x=0;x<$(".datatable tbody tr:eq(1) td").length;x++){ 		//最后一行判断是否添加每页合计
			if($(".datatable tbody tr:eq(1) td").eq(x).text()=="pagesum"){
				pagesum1 = true;
			}else{
				//do nothing
			}
		}
		
		if(pagesum1){														//最后一行根据条件添加每页合计
			
			$(".page"+(pages-1)+" .body table tbody").append("<tr></tr>");
			
			for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
				if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
					$(".page"+(pages-1)+" .body table tbody tr").last().append("<td>"+sum[pages-1][y]+"</td>");
				}else{
					$(".page"+(pages-1)+" .body table tbody tr").last().append("<td></td>");
				}
			}
			
		}else{
				//do nothing
		}
		
		while(rowextra2>=1){
			$(".page"+pages+" .body table tbody").append("<tr></tr>");
			
			for(var i=0;i<$(".datatable tbody tr:eq(1) td").length;i++){
				$(".page"+pages+" .body table tbody tr").last().append("<td></td>");
			}
			rowextra2--;
		}
		
		for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){ 		//最后一行判断是否添加每页合计
			if($(".datatable tbody tr:eq(1) td").eq(y).text()=="pagesum"){
				pagesum2 = true;
			}else{
				//do nothing
			}
		}
		
		if(pagesum2){														//最后一行根据条件添加每页合计
			$(".page"+pages+" .body table tbody").append("<tr></tr>");
			
			for(var y=0;y<$(".datatable tbody tr:eq(1) td").length;y++){
				$(".page"+pages+" .body table tbody tr").last().append("<td></td>");
			}
		}else{
				//do nothing
		}
	}		

	//标题如何显示
	if(__config.body.titleshowmode=="once"){
		for(var i=2;i<=pages;i++){
			$(".page"+i+" table thead tr td").css("display","none");
		}
	}else{
		//do nothing
	}

}

function Print_Goods(orderid){
	
	var headerconfig = __config.header;
	var bodyconfig = __config.body;
	var footerconfig = __config.footer;
	var pageconfig = __config.page;
	
	var vml =
 '[{"namespace":"protocol","cmd":"data","version":1,"id":"'+bodyconfig.id+'","paras":[{"name":"createtime","value":"' + orderid + '"}]}]';
	
	NSF.System.Network.Ajax('/Portal.aspx',
		vml,
		'POST',
		false,
		function(result, data) {
			if(result) {
			
			sum = [];										//每页数据合计二维数组
			var num = data[0].rs[0].rows.length;			//总数据行
			var pagesum = false;
				
			//判断是否有合计	
			for(var i=0;i<$(".datatable tbody tr:eq(1) td").length;i++){
				if($(".datatable tbody tr:eq(1) td").eq(i).text()=="pagesum"){
					pagesum = true;
				}else{
					
				}
			}	
				
			if(__config.header.showmode=="every"&&__config.footer.showmode=="every"){
				//有合计
				if(pagesum){
					var firstrownum;
					var rownum = Math.floor((__config.page.height-__config.header.height-__config.footer.height-__config.body.rowheight-__config.body.titleheight)/__config.body.rowheight);
					var lastrownum;
					
					var pages = Math.ceil(num/rownum);				  		
									  		
					Print_AddPages(pages);												 //1、增加页数
					Print_AddDatas(firstrownum,rownum,lastrownum,pages,data,special);						 //2、分页添加物品信息
					Print_AddEmptyrow(num,firstrownum,rownum,lastrownum,pages);							 //3、补充空行
				//无合计
				}else{
					var firstrownum;
					var rownum = Math.floor((__config.page.height-__config.header.height-__config.footer.height-__config.body.titleheight)/__config.body.rowheight);
					var lastrownum;
					
					var pages = Math.ceil(num/rownum);
					
					Print_AddPages(pages);																//1、增加页数			
					Print_AddDatas(firstrownum,rownum,lastrownum,pages,data,special);					//2、分页添加物品信息	  		
					Print_AddEmptyrow(num,firstrownum,rownum,lastrownum,pages);							//3、补充空行			
				}
			}else if(__config.header.showmode=="every"&&__config.footer.showmode=="once"){
				//有合计
				if(pagesum){
					var firstrownum;
					var rownum = Math.floor((__config.page.height - __config.header.height - __config.body.rowheight-__config.body.titleheight)/__config.body.rowheight);
					var lastrownum = Math.floor((__config.page.height - __config.header.height - __config.footer.height - __config.body.rowheight-__config.body.titleheight)/__config.body.rowheight);
					
					var special = false;
					
					if(num<=lastrownum){
						var pages = 1;
					}else if(num<=rownum){
						var pages = 2;
					}else if(num%rownum<=lastrownum){
						var pages = Math.ceil(num/rownum);
					}else if(num%rownum>lastrownum){
						var pages = Math.ceil(num/rownum) + 1;
						var special = true;
					}
					
					Print_AddPages(pages);																 //1、增加页数	
					Print_AddDatas(firstrownum,rownum,lastrownum,pages,data,special);	 			  	 //2、分页添加物品信息
					Print_AddEmptyrow(num,firstrownum,rownum,lastrownum,pages);							 //3、补充空行
					
				//无合计
				}else{
					var firstrownum;
					var rownum = Math.floor((__config.page.height - __config.header.height-__config.body.titleheight)/__config.body.rowheight);
					var lastrownum = Math.floor((__config.page.height - __config.header.height - __config.footer.height - __config.body.rowheight-__config.body.titleheight)/__config.body.rowheight);
					
					var special = false;
					
					if(num<=lastrownum){
						var pages = 1;
					}else if(num<=rownum){
						var pages = 2;
					}else if(num%rownum<=lastrownum){
						var pages = Math.ceil(num/rownum) + 1;
					}else if(num%rownum>lastrownum){
						var pages = Math.ceil(num/rownum) + 2;
						var special = true;
					}
					
					Print_AddPages(pages);			 									 //1、增加页数	
					Print_AddDatas(firstrownum,rownum,lastrownum,pages,data,special);						 //2、分页添加物品信息
					Print_AddEmptyrow(num,firstrownum,rownum,lastrownum,pages);							 //3、补充空行
					
				}
				
					$(".footer").css("display","none");
					$(".page"+pages+" .footer").css("display","block");
			}else if(__config.header.showmode=="once"&&__config.footer.showmode=="every"){
				//有合计
				if(pagesum){
					var firstrownum = Math.floor((__config.page.height - __config.header.height - __config.footer.height - __config.body.rowheight-__config.body.titleheight)/__config.body.rowheight);
					if(__config.body.titleshowmode=="every"){
						var rownum = Math.floor((__config.page.height - __config.footer.height - __config.body.rowheight-__config.body.titleheight)/__config.body.rowheight);
					}else{
						var rownum = Math.floor((__config.page.height - __config.footer.height - __config.body.rowheight)/__config.body.rowheight);
					}
					var lastrownum;
					
					if(num<=firstrownum){
						var pages = 1;
					}else{
						var pages = Math.ceil((num - firstrownum)/rownum) + 1;
					}
					
					Print_AddPages(pages);			 									 //1、增加页数	
					Print_AddDatas(firstrownum,rownum,lastrownum,pages,data,special);						 //2、分页添加物品信息
					Print_AddEmptyrow(num,firstrownum,rownum,lastrownum,pages);							 //3、补充空行
				//无合计
				}else{
					var firstrownum = Math.floor((__config.page.height - __config.header.height - __config.footer.height-__config.body.titleheight)/__config.body.rowheight);
					if(__config.body.titleshowmode=="every"){
						var rownum = Math.floor((__config.page.height - __config.footer.height -__config.body.titleheight)/__config.body.rowheight);
					}else{
						var rownum = Math.floor((__config.page.height - __config.footer.height)/__config.body.rowheight);
					}
					var lastrownum;
					
					var pageextra = Math.ceil((num - firstrownum)/rownum);
					var pages = pageextra + 1;
					
					Print_AddPages(pages);												 //1、增加页数	
					Print_AddDatas(firstrownum,rownum,lastrownum,pages,data,special);						 //2、分页添加物品信息
					Print_AddEmptyrow(num,firstrownum,rownum,lastrownum,pages);							 //3、补充空行
				}
				
					$(".header").css("display","none");
					$(".page1 .header").css("display","block");
			}else if(__config.header.showmode=="once"&&__config.footer.showmode=="once"){
				//有合计
				if(pagesum){
					var firstrownum = Math.floor((__config.page.height - __config.header.height - __config.body.rowheight - __config.body.titleheight)/__config.body.rowheight);
					if(__config.body.titleshowmode=="every"){
						var rownum = Math.floor((__config.page.height - __config.body.rowheight-__config.body.titleheight)/__config.body.rowheight);
						var lastrownum = Math.floor((__config.page.height - __config.footer.height - __config.body.rowheight-__config.body.titleheight)/__config.body.rowheight);
					}else{
						var rownum = Math.floor((__config.page.height - __config.body.rowheight)/__config.body.rowheight);
						var lastrownum = Math.floor((__config.page.height - __config.footer.height - __config.body.rowheight)/__config.body.rowheight);
					}
					
					var special = false;
					
					var onepagerow = Math.ceil((__config.page.height - __config.header.height - __config.footer.height - __config.body.rowheight - __config.body.titleheight)/__config.body.rowheight);
					
					if(onepagerow>=num){
						var pages = 1;
					}else if((firstrownum+lastrownum)>=num){
						var pages = 2;
					}else{
						if((num-firstrownum)%rownum>lastrownum){
							var pages = Math.floor((num-firstrownum)/rownum)+3;
							var special = true;
						}else{
							var pages = Math.ceil((num-firstrownum)/rownum)+2;
						}
					}
					
					Print_AddPages(pages);			 									 //1、增加页数	
					Print_AddDatas(firstrownum,rownum,lastrownum,pages,data,special);				 //2、分页添加物品信息
					Print_AddEmptyrow(num,firstrownum,rownum,lastrownum,pages);							 //3、补充空行
				//无合计
				}else{
					var firstrownum = Math.floor((__config.page.height - __config.header.height-__config.body.titleheight)/__config.body.rowheight);
					if(__config.body.titleshowmode=="every"){
						var rownum = Math.floor((__config.page.height -__config.body.titleheight)/__config.body.rowheight);
						var lastrownum = Math.floor((__config.page.height - __config.footer.height -__config.body.titleheight)/__config.body.rowheight);
					}else{
						var rownum = Math.floor(__config.page.height/__config.body.rowheight);
						var lastrownum = Math.floor((__config.page.height - __config.footer.height)/__config.body.rowheight);
					}
					var special = false;
					
					var onepagerow = Math.ceil((__config.page.height - __config.header.height - __config.footer.height - __config.body.rowheight - __config.body.titleheight)/__config.body.rowheight);
					
					if(onepagerow>=num){
						var pages = 1;
					}else if((firstrownum+lastrownum)>=num){
						var pages = 2;
					}else{
						if((num-firstrownum)%rownum>lastrownum){
							var pages = Math.floor((num-firstrownum)/rownum)+3;
							var special = true;
						}else{
							var pages = Math.ceil((num-firstrownum)/rownum)+2;
						}
					}
					
					Print_AddPages(pages);			 									 //1、增加页数	
					Print_AddDatas(firstrownum,rownum,lastrownum,pages,data,special); 					 //2、分页添加物品信息
					Print_AddEmptyrow(num,firstrownum,rownum,lastrownum,pages);							 //3、补充空行
				}
				
					$(".header").css("display","none");
					$(".footer").css("display","none");
					$(".page1 .header").css("display","block");
					$(".page"+pages+" .footer").css("display","block");
				}
			}
				
			$(".page0 .body table thead tr td").css("height",__config.body.titleheight+"cm");	
			$(".page0 .body table thead tr td").css("line-height",__config.body.titleheight+"cm");
		})
		
		$(".page0").css("height",pageconfig.page+"cm");
		$(".header").css("height",headerconfig.height+"cm");
		$(".footer").css("height",footerconfig.height+"cm");
		$(".body table tbody tr").css("height",__config.body.rowheight+"cm");
		$(".pagecode").css("height",__config.pagecode.height+"cm");
		$(".pagecode").css("line-height",__config.pagecode.height+"cm");
		$(".pagecode").css("font-size",__config.pagecode.fontsize+"pt");
	}