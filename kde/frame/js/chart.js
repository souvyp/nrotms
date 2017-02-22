Highcharts.setOptions({
	lang: {
		months: ['一月', '二月', '三月', '四月', '五月', '六月',  '七月', '八月', '九月', '十月', '十一月', '十二月'],
		weekdays: ['星期天', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
		resetZoom:'重置缩放',
		downloadJPEG:'下载JPEP',
		downloadPDF:'下载PDF',
		downloadPNG:'下载PNG',
		downloadSVG:'下载SVG',
		contextButtonTitle:'内容标题',
		printChart:'打印图表',
		resetZoomTitle:'重置缩放'
	}
});

	
function Perspective(gridId,title){
	var jx=0,jo=0;
	var cfs = $('#'+gridId).datagrid('getColumnFields');
	var colCount = cfs.length;
	var checkx='',checky='',checko='';
	for (var i = 0; i < colCount; i++) {
		if (cfs[i] != '') {
			var c = $('#'+gridId).datagrid('getColumnOption',cfs[i]);
			if(c.perspective){
				checko+='<input type="checkbox" id="'+gridId+'_o_'+c.field+'" name="oField" value="'+c.field+'" class="checkbox"><label for="'+gridId+'_o_'+c.field+'">'+c.title+'</label>';
				if(jo>3){
					checko+='<br />';
					jo=0;
				}
				else
					jo++;
				if(c.edittype==13){
					checky+='<tr><td><input type="checkbox" id="'+gridId+'_y_'+c.field+'" name="yField" value="'+c.field+'" checked class="checkbox"><label for="'+gridId+'_y_'+c.field+'">'+c.title+'</label></td>';
					checky+='<td><select class="easyui-combobox" style="width:75px;">';
					checky+='<option value="sum">合计</option>';
					checky+='<option value="avg">平均</option>';
					checky+='<option value="count">计数</option>';
					checky+='</select></td>';
					checky+='<td><select class="easyui-combobox" style="width:75px;">';
					checky+='<option value="column">柱型图</option>';
					checky+='<option value="spline">线型图</option>';					
					checky+='<option value="pie">饼图</option>';
					checky+='</select></td></tr>';
				}
				else{
					checkx+='<input type="checkbox" id="'+gridId+'_x_'+c.field+'" name="xField" value="'+c.field+'" checked class="checkbox"><label for="'+gridId+'_x_'+c.field+'">'+c.title+'</label>';
					if(jx>3){
						checkx+='<br />';
						jx=0;
					}
					else
						jx++;
				}
			}
		}
	}
	
	var cont='<form method="post" enctype="multipart/form-data" id="view_report'+gridId+'"><table class="formTable"><tr><th>字段:</th><td style="border:1px solid #E0ECFF;padding: 5px;">'+checkx+'</td></tr>';
	cont+='<tr><th>内容:</th><td style="border:1px solid #E0ECFF;padding: 5px;"><table>'+checky+'</table></td></tr>';
	cont+='<tr><th>排序:</th><td style="border:1px solid #E0ECFF;padding: 5px;">'+checko+'</td></tr>';
	cont+='<tr><th>数据:</th><td style="border:1px solid #E0ECFF;padding: 5px;">';
	cont+='<input type="radio" id="'+gridId+'_current_filter" name="data_flt" value="1" checked class="checkbox"><label for="'+gridId+'_current_filter">当前数据</label>'
	cont+='<input type="radio" id="'+gridId+'_all" name="data_flt" value="2" class="checkbox"><label for="'+gridId+'_all">全部数据</label>'
	cont+='</div></table></form>';
	
			
	showWindow(cont,'数据透视 - '+title,'auto','auto',function(){
	
		},function(wid){
			var tt=$('#'+gridId).EasyGrid('getThis');	
			var flt='';
			if($('#view_report'+gridId+" input[name='data_flt']:checked").val()=='1')flt=tt.oldFilter;
			var xVal='';
			var xDatas=[];
			var xTitles=[];
			$('#view_report'+gridId+" input[name='xField']:checked").each(function () {
                 if(xVal!=="")xVal+=",";
				 xVal+=this.value;
				 xDatas.push(this.value);
				 xTitles.push($(this).next().text());
            });
			var yVal='';
			var yDatas=[];
			var yTitles=[];
			var yOpt=[];
			var yAx=[];
			$('#view_report'+gridId+" input[name='yField']:checked").each(function () {
                 if(yVal!=="")yVal+=",";
				 yVal+=$(this).parent().next().children().eq(0).val()+'('+this.value+') '+this.value;
				 yDatas.push(this.value);
				 yTitles.push($(this).next().text());
				 yAx.push($(this).parent().next().next().children().eq(0).val());
				 yOpt.push($(this).parent().next().children().eq(0).find("option:selected").text())
            });
			var oVal='';
			$('#view_report'+gridId+" input[name='oField']:checked").each(function () {
                 if(oVal!=="")oVal+=",";
				 oVal+=this.value;
            });
			var wwid=wid;
			mask();
			get("admin/grid.cn",{param:'group',code:tt.Code,path:tt.Path,flt:flt,xVal:xVal,yVal:yVal,oVal:oVal},'json',function(rows){
				var data=makeTableData(gridId,rows);
				var table=makeSQLTable(gridId,data,yDatas,yOpt);
				$('#'+wwid).dialog('close');
				unmask();
				var tcont='<div class="easyui-tabs"><div title="'+title+'" style="padding:5px">';
				tcont+=table;
				tcont+='</div>';
				
				for(var i=0;i<xTitles.length;i++){
					tcont+='<div fld="'+xDatas[i]+'" title="'+xTitles[i]+'"></div>';
				}
				tcont+='</div>';		
				var w=$(window).width()*0.8;
				var h=$(window).height()*0.8;
				showWindow(tcont,'数据透视 - '+title,w,h,function(wid){
					$('#'+wid+' table.easyui-datagrid').datagrid();
					$('#'+wid+' div.easyui-tabs').tabs({tabPosition:'left',border:false,fit:true,plain:true,headerWidth:80});
					for(var i=0;i<xTitles.length;i++){
						var dat={};
						var fld=xDatas[i];
						var tab=$('#'+wid+' div.easyui-tabs .tabs-panels div[fld="'+fld+'"]');
						tab.width(w-110);
						tab.height(h-40);
						dat.title=xTitles[i];
						dat.categories=[];
						dat.series=[];
						dat.yAxis=[];
						for(var k=0;k<yDatas.length;k++){
							dat.series.push({
								name:yOpt[k]+yTitles[k],
								type:yAx[k],
								yAxis:k,
								data:[]
							});
							dat.yAxis.push({
								labels: {
									style: {
										color: Highcharts.getOptions().colors[k]
									}
								},
								title: {
									text: yOpt[k]+yTitles[k],
									style: {
										color: Highcharts.getOptions().colors[k]
									}
								},
								opposite:k%2==0
							})
						}
						var oldg='';
						SortData(data.rows,fld);
						for(var n=0;n<data.rows.length;n++){
							var g=data.rows[n][fld];
							if(oldg!==g){
								dat.categories.push(g);
							}
							for(var k=0;k<yDatas.length;k++){
								var f=pFloat(data.rows[n][yDatas[k]])
								if(oldg==g){
									var len=dat.series[k].data.length;
									if(len>0)
										dat.series[k].data[len-1][yDatas[k]]+=f;
								}
								else
									dat.series[k].data.push(f);
							}
							oldg=g;
						}
						makeChartFromData(tab,dat);
					}
					
				})
			});
		},
		function(wid){
			$('#'+wid).dialog('close');
		}
	);
}

function pFloat(f){
	var v=0;
	try{
		v=parseFloat(f);
		v=Math.round(v*100)/100;
		
	}catch(e){}
	return v;		
}

function makeTableData(gridId,data){
	var cfs = $('#'+gridId).datagrid('getColumnFields');
	var colCount = cfs.length;
	var cols=[];
	for (var i = 0; i < colCount; i++) {
		if (cfs[i] != '') {
			var c = $('#'+gridId).datagrid('getColumnOption',cfs[i]);
			if(c.perspective){
				cols.push(c);
			}
		}
	}
	for(var i=0;i<data.rows.length;i++){
		var row=data.rows[i];
		var j=0;
		for(var key in row){
			if(cols[j].formatter){
				data.rows[i][key]=cols[j].formatter(row[key],row,i);
			}
			j++;
		}
	}
	return data;
}

function makeSQLTable(gridId,data,ys,yo){
	var table='<table class="easyui-datagrid"><thead><tr>';
	var cfs = $('#'+gridId).datagrid('getColumnFields');
	var colCount = cfs.length;
	var row0=data.rows[0];
	for (var i = 0; i < colCount; i++) {
		if (cfs[i] != '') {
			var c = $('#'+gridId).datagrid('getColumnOption',cfs[i]);
			if(c.perspective){
				if(c.field in row0){	
					var tt=c.title;
					var j=ys.indexOf(c.field);
					if(j>=0)tt=yo[j]+tt;
					table+='<th data-options="field:\''+c.field+'\'">'+tt+'</th>';
				}
			}
		}
	}
	table+='</tr></thead><tbody>';
	for(var i=0;i<data.rows.length;i++){
		table+='<tr>';
		var row=data.rows[i];
		for(var key in row){
			var v=row[key];
			if(ys.indexOf(key)>=0){
				v=pFloat(v);
			}
			table+='<td>'+v+'</td>';
		}
		table+='</tr>';
	}
	table+='</tbody></table>';
	return table;
}

function makeChartFromData(hid,data){
	 hid.highcharts({
			chart: {
				zoomType: 'xy',
				backgroundColor:'transparent'
			},
			credits: {
                enabled: false
            },
			title: {
				text: data.title
			},
			subtitle: {
				text: data.subtitle
			},
			xAxis: [{
				categories: data.categories,
				labels: {
					rotation:data.categories[0].length>5||data.categories.length>10?-45:0,
					align: 'right'
				}//,
				//tickPixelInterval:10
			}],
			yAxis:data.yAxis,
			tooltip: {
				shared: true
			},
			series: data.series
		});
}
