//  饼状图						//ID名，起始时间，名称，数据,统计名称
function Customized_Pie(IdName, ShowStart, ShowEnd, chartsName, seriesd, StatName) {
	var myChart = echarts.init(document.getElementById(IdName));

	var itemStyle = {
		normal: {
			opacity: 0.7,
			color: {

				repeat: 'repeat'
			},
			borderWidth: 3,
			borderColor: '#235894'
		}
	};
	option_1 = {
		backgroundColor: 'rgba(255, 255, 255, 0.0)',
		title: {
			text: '',
			subtext: '',
			x: 'center',
			top: '10%',
			textStyle: {
				color: '#ffffff',
				fontSize: 24
			}
		},
		tooltip: {
			trigger: 'item',
			formatter: "{a} <br/>{b} : {c} ({d}%)"
		},
		legend: {
			orient: 'vertical',
			left: 'left',
			data: ['直接访问', '邮件营销', '联盟广告', '视频广告', '搜索引擎']
		},
		series: [{
			name: '访问来源',
			type: 'pie',
			radius: '55%',
			center: ['50%', '60%'],
			data: seriesd,
			label: {
				normal: {
					textStyle: {
						fontSize: 18,
						color: '#ffffff'
					}
				}
			},
			labelLine: {
				normal: {
					lineStyle: {
						color: '#ffffff'
					}
				}
			},
			itemStyle: {
				emphasis: {
					shadowBlur: 10,
					shadowOffsetX: 0,
					shadowColor: 'rgba(0, 0, 0, 0.5)'
				}
			}
		}]
	};
	myChart.setOption(option_1);
}

//线路流动图  
function Customized_liu(IdName, seriesd, seriesd_c) {
	var myChart = echarts.init(document.getElementById(IdName));

	option = {
		animationDuration:2000,
		title: {
			text: '',
			left: 'center',
			top: 100,
			textStyle: {
				color: '#fff',
				fontSize: 62
			}
		},
		legend: {
			show: false,
			orient: 'vertical',
			top: 'bottom',
			left: 'right',
			data: ['地点', '线路'],
			textStyle: {
				color: '#fff'
			}
		},
		geo: {
			map: 'china',
			label: {
				emphasis: {
					show: false
				}
			},
			zoom: 1.2,
			roam: true,
			itemStyle: {
				normal: {
					areaColor: 'rgba(9, 75, 151, 0.4)',
					borderColor: '#00dae4'
				},
				emphasis: {
					areaColor: '#2a333d'
				}
			}
		},
		series: [{
			name: '地点',
			type: 'effectScatter',
			coordinateSystem: 'geo',
			zlevel: 2,
			rippleEffect: {
				brushType: 'stroke'
			},
			label: {
				emphasis: {
					show: true,
					position: 'right',
					formatter: '{b}'
				}
			},
			symbolSize: 2,
			showEffectOn: 'render',
			itemStyle: {
				normal: {
					color: '#ffffff'
				}
			},
			data: seriesd_c
		}, {
			name: '线路',
			type: 'lines',
			coordinateSystem: 'geo',
			zlevel: 2,
			large: true,
			effect: {
				show: true,
				constantSpeed: 30,
				symbol: 'pin',
				symbolSize: 3,
				trailLength: 0,
			},
			lineStyle: {
				normal: {
					color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
						offset: 0,
						color: '#F58158' // cheng
					}, {
						offset: 1,
						color: '#f7e231' // lanse
					}], false),
					width: 1,
					opacity: 0.3,
					curveness: 0.1
				}
			},
			data: seriesd
		}]
	};

	myChart.setOption(option);
}

function Customized_zhu_s(IdName, seriesd, seriesdd) {
	var myChart = echarts.init(document.getElementById(IdName));

	option = {
		animationDuration: 2000,
		title: {
			text: ' ',
			subtext: ' ',

		},
		tooltip: {
			trigger: 'axis',
			axisPointer: { // 坐标轴指示器，坐标轴触发有效
				type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
			}
		},
		legend: {
			data: ['市内', '长途'],
			left: '14%',
			top: 7,
			textStyle: {
				color: '#ffffff',
				fontSize: 20
			}
		},
		toolbox: {
			show: false,

		},
		calculable: false,
		xAxis: [{

			axisLine: {
				lineStyle: {
					color: "#ffffff",
					width: 1, //这里是为了突出显示加上的
				}

			},
			axisLabel: {
				textStyle: {
					fontSize: 20
				}
			},
			type: 'category',

			data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']

		}],
		yAxis: [{
			type: 'value',
			name: '单位/方',
			nameGap: 30,
			nameTextStyle: {
				fontSize: 20
			},
			splitLine: false,
			axisLine: {
				lineStyle: {
					color: '#ffffff',
					width: 1 //这里是为了突出显示加上的
				}
			},
			axisLabel: {
				textStyle: {
					fontSize: 20
				}
			}

		}],
		series: [{
			name: '市内',
			type: 'bar',
			data: seriesd,
			label: {
				normal: {
					show: true,
					position: 'top',
					textStyle: {
						fontSize: 22,
						color: '#ffffff'
					}
				},
				emphasis: {
					show: true
				}
			},
			//          markPoint : {
			//              data : [
			//                  {type : 'max', name: '最大值'},
			//                  {type : 'min', name: '最小值'}
			//              ]
			//          },

			itemStyle: {
				normal: {
					color: 'rgba(255,144,128,1)',

				}
			}
		}, {
			name: '长途',
			type: 'bar',
			data: seriesdd,
			label: {
				normal: {
					show: true,
					position: 'top',
					textStyle: {
						fontSize: 22,
						color: '#ffffff'
					}
				},
				emphasis: {
					show: true
				}
			},
			//          markPoint : {
			//              data : [
			//                  {type : 'max', name: '最大值'},
			//                  {type : 'min', name: '最小值'}
			//              ]
			//          },

			itemStyle: {
				normal: {
					color: '#00ccff',

				}
			}
		}]
	};

	myChart.setOption(option);
}

function Customized_zhu_h(IdName, seriesd, seriesd_c) {
	var myChart = echarts.init(document.getElementById(IdName));

	option = {
		animationDuration: 2000,
		title: {
			text: ' ',

		},
		tooltip: {
			trigger: 'axis',
			axisPointer: {
				type: 'shadow'
			}
		},
		legend: {
			data: ['市内', '长途'],
			left: '16%',
			top: 10,
			textStyle: {
				color: '#ffffff',
				fontSize: 20
			}
		},
		grid: {
			left: '3%',
			right: '4%',
			bottom: '3%',
			containLabel: true
		},
		xAxis: {
			type: 'value',
			name: ' ',
			nameTextStyle: {
				fontSize: 20
			},
			boundaryGap: [0, 0.01],
			nameLocation : 'end',
			axisLine: {
				lineStyle: {
					color: "#ffffff",
					width: 1, //这里是为了突出显示加上的
				}

			},
			axisLabel: {
				textStyle: {
					fontSize: 20
				}
			},
			splitLine: {
				show: false
			}
		},
		yAxis: {
			splitLine: {
				show: false
			},
			axisLine: {
				lineStyle: {
					color: "#ffffff",
					width: 1, //这里是为了突出显示加上的
				}

			},
			axisLabel: {
				textStyle: {
					fontSize: 20
				}
			},
			name: '',
			nameTextStyle: {
				fontSize: 20
			},
			type: 'category',
			data: seriesd_c
		},
		series: [

			{
				name: '今年',
				type: 'bar',
				itemStyle: {
					normal: {
						color: '#00ccff'

					}
				},
				label: {
					normal: {
						show: true,
						position: 'right',
						textStyle: {
						    fontSize: 20,
							color: '#ffffff'
						}
					},
					emphasis: {
						show: true
					}
				},
				data: seriesd
			}
		]
	};

	myChart.setOption(option);
}

function Customized_zhu_hx(IdName, seriesz, seriesl, seriesh) {
	var myChart = echarts.init(document.getElementById(IdName));

	option = {
		animationDuration: 2000,
		"title": {
			textStyle: {
				color: '#fff',
				fontSize: '22'
			},
			subtextStyle: {
				color: '#90979c',
				fontSize: '16',

			},
		},
		"tooltip": {
			"trigger": "axis",
			"axisPointer": {
				"type": "shadow",
				textStyle: {
					color: "#fff"
				}

			},
		},
		"grid": {
			"borderWidth": 0,
			"top": 110,
			"bottom": 95,
			textStyle: {
				color: "#fff"
			}
		},
		legend: {
			data: ['整车', '零担'],
			left: '14%',
			top: 56,
			textStyle: {
				color: '#ffffff',
				fontSize: 20
			}
		},
		"calculable": true,
		xAxis: [{

			axisLine: {
				lineStyle: {
					color: "#ffffff",
					width: 1, //这里是为了突出显示加上的
				}

			},
			axisLabel: {
				textStyle: {
					fontSize: 20
				}
			},
			type: 'category',

			data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']

		}],
		yAxis: [{
			type: 'value',
			name: '单位/方',
			nameGap: 30,
			nameTextStyle: {
				fontSize: 20
			},
			splitLine: false,
			axisLine: {
				lineStyle: {
					color: '#ffffff',
					width: 1 //这里是为了突出显示加上的
				}
			},
			axisLabel: {
				textStyle: {
					fontSize: 20
				}
			}

		}],

		"series": [{
				"name": "整车",
				"type": "bar",
				"stack": "总量",
				"barMaxWidth": 35,
				"barGap": "10%",
				"itemStyle": {
					"normal": {
						"color": "rgba(255,144,128,1)",
						"label": {
							"show": true,
							"textStyle": {
							    fontSize: 20,
								"color": "#fff"
							},
							"position": "insideTop",
							formatter: function(p) {
								return p.value > 0 ? (p.value) : '';
							}
						}
					}
				},
				"data": seriesz,
			},

			{
				"name": "零担",
				"type": "bar",
				"stack": "总量",
				"itemStyle": {
					"normal": {
						"color": "rgba(0,191,183,1)",
						"barBorderRadius": 0,
						"label": {
						    "show": true,
						    "textStyle": {
						        fontSize: 20,
						        "color": "#fff"
						    },
							"position": "top",
							formatter: function(p) {
								return p.value > 0 ? (p.value) : '';
							}
						}
					}
				},
				"data": seriesl
			}, {
				"name": "总",
				"type": "line",
				"stack": "总量",
				symbolSize: 20,
				symbol: 'circle',
				"itemStyle": {
					"normal": {
						"color": "rgba(252,230,48,1)",
						"barBorderRadius": 0,
						"label": {
						    "show": true,
						    "textStyle": {
						        fontSize: 20,
						        "color": "#fff"
						    },
							"position": "top",
							formatter: function(p) {
								return p.value > 0 ? (p.value) : '';
							}
						}
					}
				},
				"data": seriesh
			},
		]
	}
	myChart.setOption(option);
}

function Customized_zhu_hmax(IdName, series_CN, seriesd_BF, seriesd_FJ, seriesd_LD, seriesd_SF, seriesd_SH, seriesd_TH, seriesd_XH, seriesd_ZC, seriesd_ZH) {
	var myChart = echarts.init(document.getElementById(IdName));

	option = {
		animationDuration: 2000,
		tooltip: {
			trigger: 'axis',
			axisPointer: { // 坐标轴指示器，坐标轴触发有效
				type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
			}
		},
		legend: {
			show: false,
			data: ['保费', '附加费', '零担', '税费', '送货费', '提货费', '卸货费', '整车费', '装货费'],
			textStyle: {
				color: '#fff',
				fontSize: 14
			},
			top: 10
		},
		grid: {
			left: '3%',
			right: '4%',
			bottom: '3%',
			containLabel: true
		},
		xAxis: {
			type: 'value',
			axisLine: {
				lineStyle: {
					color: "#ffffff",
					width: 1, //这里是为了突出显示加上的
				}

			},
			splitLine: {
				show: false
			},
			axisLabel: {
				textStyle: {
					fontSize: 20
				}
			}
		},
		yAxis: {
			type: 'category',
			data: series_CN,
			splitLine: {
				show: false
			},
			axisLine: {
				lineStyle: {
					color: "#ffffff",
					width: 1, //这里是为了突出显示加上的
				}

			},
			axisLabel: {
				textStyle: {
					fontSize: 20
				}
			}
		},
		series: [{
			name: '保费',
			type: 'bar',
			stack: '总量',
			label: {
				normal: {
					show: true,
					position: 'insideRight'
				}
			},
			data: seriesd_BF
		}, {
			name: '附加费',
			type: 'bar',
			stack: '总量',
			label: {
				normal: {
					show: true,
					position: 'insideRight'
				}
			},
			data: seriesd_FJ
		}, {
			name: '零担',
			type: 'bar',
			stack: '总量',
			label: {
				normal: {
					show: true,
					position: 'insideRight'
				}
			},
			data: seriesd_LD
		}, {
			name: '税费',
			type: 'bar',
			stack: '总量',
			label: {
				normal: {
					show: true,
					position: 'insideRight'
				}
			},
			data: seriesd_SF
		}, {
			name: '送货费',
			type: 'bar',
			stack: '总量',
			label: {
				normal: {
					show: true,
					position: 'insideRight'
				}
			},
			data: seriesd_SH
		}, {
			name: '提货费',
			type: 'bar',
			stack: '总量',
			label: {
				normal: {
					show: true,
					position: 'insideRight'
				}
			},
			data: seriesd_TH
		}, {
			name: '卸货费',
			type: 'bar',
			stack: '总量',
			label: {
				normal: {
					show: true,
					position: 'insideRight'
				}
			},
			data: seriesd_XH
		}, {
			name: '整车费',
			type: 'bar',
			stack: '总量',
			label: {
				normal: {
					show: true,
					position: 'insideRight'
				}
			},
			data: seriesd_ZC
		}, {
			name: '装货费',
			type: 'bar',
			stack: '总量',
			label: {
				normal: {
					show: true,
					position: 'insideRight'
				}
			},
			data: seriesd_ZH
		}]
	};

	myChart.setOption(option);
}

function Customized_zhu_p(IdName, series_CN, seriesd_ZC, seriesd_LD, seriesd_TH, seriesd_SH, seriesd_ZH, seriesd_XH, seriesd_SF, seriesd_BF, seriesd_FJ) {
	var myChart = echarts.init(document.getElementById(IdName));

	var dataMap = {};

	function dataFormatter(obj) {
		var pList = ['整车费', '零担费', '提货费', '送货费', '装货费', '卸货费', '税费', '保费', '附加费'];
		var temp;
		for(var year = 2002; year <= 2011; year++) {
			var max = 0;
			var sum = 0;
			temp = obj[year];
			for(var i = 0, l = temp.length; i < l; i++) {
				max = Math.max(max, temp[i]);
				sum += temp[i];
				obj[year][i] = {
					name: pList[i],
					value: temp[i]
				}
			}
			obj[year + 'max'] = Math.floor(max / 100) * 100;
			obj[year + 'sum'] = sum;
		}
		return obj;
	}

	dataMap.dataPI = dataFormatter({
		//max : 4000,
		2011: [seriesd_ZC[9], seriesd_LD[9], seriesd_TH[9], seriesd_SH[9], seriesd_ZH[9], seriesd_XH[9], seriesd_SF[9], seriesd_BF[9], seriesd_FJ[9]],
		2010: [seriesd_ZC[8], seriesd_LD[8], seriesd_TH[8], seriesd_SH[8], seriesd_ZH[8], seriesd_XH[8], seriesd_SF[8], seriesd_BF[8], seriesd_FJ[8]],
		2009: [seriesd_ZC[7], seriesd_LD[7], seriesd_TH[7], seriesd_SH[7], seriesd_ZH[7], seriesd_XH[7], seriesd_SF[7], seriesd_BF[7], seriesd_FJ[7]],
		2008: [seriesd_ZC[6], seriesd_LD[6], seriesd_TH[6], seriesd_SH[6], seriesd_ZH[6], seriesd_XH[6], seriesd_SF[6], seriesd_BF[6], seriesd_FJ[6]],
		2007: [seriesd_ZC[5], seriesd_LD[5], seriesd_TH[5], seriesd_SH[5], seriesd_ZH[5], seriesd_XH[5], seriesd_SF[5], seriesd_BF[5], seriesd_FJ[5]],
		2006: [seriesd_ZC[4], seriesd_LD[4], seriesd_TH[4], seriesd_SH[4], seriesd_ZH[4], seriesd_XH[4], seriesd_SF[4], seriesd_BF[4], seriesd_FJ[4]],
		2005: [seriesd_ZC[3], seriesd_LD[3], seriesd_TH[3], seriesd_SH[3], seriesd_ZH[3], seriesd_XH[3], seriesd_SF[3], seriesd_BF[3], seriesd_FJ[3]],
		2004: [seriesd_ZC[2], seriesd_LD[2], seriesd_TH[2], seriesd_SH[2], seriesd_ZH[2], seriesd_XH[2], seriesd_SF[2], seriesd_BF[2], seriesd_FJ[2]],
		2003: [seriesd_ZC[1], seriesd_LD[1], seriesd_TH[1], seriesd_SH[1], seriesd_ZH[1], seriesd_XH[1], seriesd_SF[1], seriesd_BF[1], seriesd_FJ[1]],
		2002: [seriesd_ZC[0], seriesd_LD[0], seriesd_TH[0], seriesd_SH[0], seriesd_ZH[0], seriesd_XH[0], seriesd_SF[0], seriesd_BF[0], seriesd_FJ[0]]
	});

	option = {
		baseOption: {
			timeline: {
				// y: 0,
				axisType: 'category',
				// realtime: false,
				// loop: false,
				autoPlay: true,
				// currentIndex: 2,
				playInterval: 4000,
				// controlStyle: {
				//     position: 'left'
				// },
				lineStyle: {
					color: '#ffffff',
					 
				},
				itemStyle: {
					normal: {
						color:'#ffffff',
					},
					emphasis: {
						color:'rgba(0,191,183,1)',
					}
				},
				checkpointStyle: {
					color:'rgba(0,191,183,1)',
					borderColor :'rgba(0,191,183,1)'
				},
				label: {
					normal: {
						show: false
					},
					emphasis: {
						show: false
					}

				},
				controlStyle: {
					show: false
				},
				data: [
					'2002-01-01', '2003-01-01', '2004-01-01', '2005-01-01', '2006-01-01', '2007-01-01', '2008-01-01', '2009-01-01', '2010-01-01', '2011-01-01'
				]
			},
			title: {
				subtext: ' '
			},
			tooltip: {},
			legend: {
				show: false,
				x: 'right',
				data: ['第一产业'],
				selected: {
					'GDP': false,
					'金融': false,
					'房地产': false
				}
			},
			calculable: true,
			grid: {
				top: 80,
				bottom: 100
			},
			xAxis: [{
				'type': 'category',
				'axisLabel': {
					'interval': 0
				},
//				splitLine: {
//					show: false
//				},
				'data': ['整车费', '零担费', '提货费', '送货费', '装货费', '卸货费', '税费', '保费', '附加费'],
				splitLine: {
					show: false
				},
				axisLine: {
					lineStyle: {
						color: "#ffffff",
						width: 1, //这里是为了突出显示加上的
					}

				},
				axisLabel: {
					textStyle: {
						fontSize: 20
					}
				},
			}],
			yAxis: [{
				type: 'value',
				name: '单位/万元',
				nameTextStyle: {
					fontSize: 20
				},
				axisLine: {
					lineStyle: {
						color: "#ffffff",
						width: 1, //这里是为了突出显示加上的
					}

				},
//				splitLine: {
// 内部线条			show: false
//				},
				axisLabel: {
					textStyle: {
						fontSize: 20
					}
				},
			}],
			series: [

				{
					name: '第一产业',
					type: 'bar',
					label: {
						normal: {
							show: true,
							position: 'top',
							textStyle: {
								fontSize: 20,
								color: '#ffffff'
							}
						}
					},
					itemStyle: {
						normal: {
							color: 'rgba(0,191,183,1)',
							label: {
								show: true,
								position: "top"
								 
							}
						}
					},
				},

			]
		},
		options: [{
			title: {
				text: series_CN[0] + '费用统计图',
				left: 'center',
				textStyle: {
					color: '#fff',
					fontSize: '22',
					fontWeight: '300'
				}
			},
			series: [

				{
					barWidth: 45,
					data: dataMap.dataPI['2002']
				},

			]
		}, {
			title: {
				text: series_CN[1] + '费用统计图',
				left: 'center',
				top: '20',
				textStyle: {
					color: '#fff',
					fontSize: '22'
				}
			},
			series: [

				{
					data: dataMap.dataPI['2003']
				},

			]
		}, {
			title: {
				text: series_CN[2] + '费用统计图',
				textStyle: {
					color: '#fff',
					fontSize: '22'
				}
			},
			series: [

				{
					data: dataMap.dataPI['2004']
				},

			]
		}, {
			title: {
				text: series_CN[3] + '费用统计图',
				textStyle: {
					color: '#fff',
					fontSize: '22'
				}
			},
			series: [

				{
					data: dataMap.dataPI['2005']
				},

			]
		}, {
			title: {
				text: series_CN[4] + '费用统计图',
				textStyle: {
					color: '#fff',
					fontSize: '22'
				}
			},
			series: [

				{
					data: dataMap.dataPI['2006']
				},

			]
		}, {
			title: {
				text: series_CN[5] + '费用统计图',
				textStyle: {
					color: '#fff',
					fontSize: '22'
				}
			},
			series: [

				{
					data: dataMap.dataPI['2007']
				},

			]
		}, {
			title: {
				text: series_CN[6] + '费用统计图',
				textStyle: {
					color: '#fff',
					fontSize: '22'
				}
			},
			series: [

				{
					data: dataMap.dataPI['2008']
				},

			]
		}, {
			title: {
				text: series_CN[7] + '费用统计图',
				textStyle: {
					color: '#fff',
					fontSize: '22'
				}
			},
			series: [

				{
					data: dataMap.dataPI['2009']
				},

			]
		}, {
			title: {
				text: series_CN[8] + '费用统计图',
				textStyle: {
					color: '#fff',
					fontSize: '22'
				}
			},
			series: [

				{
					data: dataMap.dataPI['2010']
				},

			]
		}, {
			title: {
				text: series_CN[9] + '费用统计图',
				textStyle: {
					color: '#fff',
					fontSize: '22'
				}
			},
			series: [

				{
					data: dataMap.dataPI['2011']
				},

			]
		}]
	};

	myChart.setOption(option);
}

function Customized_re(IdName, seriesd) {
	var myChart = echarts.init(document.getElementById(IdName), 'wlyuan');

	var geoCoordMap = {
		"海门": [121.15, 31.89],
		"鄂尔多斯": [109.781327, 39.608266],
		"招远": [120.38, 37.35],
		"舟山": [122.207216, 29.985295],
		"齐齐哈尔": [123.97, 47.33],
		"盐城": [120.13, 33.38],
		"赤峰": [118.87, 42.28],
		"青岛": [120.33, 36.07],
		"乳山": [121.52, 36.89],
		"金昌": [102.188043, 38.520089],
		"泉州": [118.58, 24.93],
		"莱西": [120.53, 36.86],
		"日照": [119.46, 35.42],
		"胶南": [119.97, 35.88],
		"南通": [121.05, 32.08],
		"拉萨": [91.11, 29.97],
		"云浮": [112.02, 22.93],
		"梅州": [116.1, 24.55],
		"文登": [122.05, 37.2],
		"上海": [121.48, 31.22],
		"攀枝花": [101.718637, 26.582347],
		"威海": [122.1, 37.5],
		"承德": [117.93, 40.97],
		"厦门": [118.1, 24.46],
		"汕尾": [115.375279, 22.786211],
		"潮州": [116.63, 23.68],
		"丹东": [124.37, 40.13],
		"太仓": [121.1, 31.45],
		"曲靖": [103.79, 25.51],
		"烟台": [121.39, 37.52],
		"福州": [119.3, 26.08],
		"瓦房店": [121.979603, 39.627114],
		"即墨": [120.45, 36.38],
		"抚顺": [123.97, 41.97],
		"玉溪": [102.52, 24.35],
		"张家口": [114.87, 40.82],
		"阳泉": [113.57, 37.85],
		"莱州": [119.942327, 37.177017],
		"湖州": [120.1, 30.86],
		"汕头": [116.69, 23.39],
		"昆山": [120.95, 31.39],
		"宁波": [121.56, 29.86],
		"湛江": [110.359377, 21.270708],
		"揭阳": [116.35, 23.55],
		"荣成": [122.41, 37.16],
		"连云港": [119.16, 34.59],
		"葫芦岛": [120.836932, 40.711052],
		"常熟": [120.74, 31.64],
		"东莞": [113.75, 23.04],
		"河源": [114.68, 23.73],
		"淮安": [119.15, 33.5],
		"泰州": [119.9, 32.49],
		"南宁": [108.33, 22.84],
		"营口": [122.18, 40.65],
		"惠州": [114.4, 23.09],
		"江阴": [120.26, 31.91],
		"蓬莱": [120.75, 37.8],
		"韶关": [113.62, 24.84],
		"嘉峪关": [98.289152, 39.77313],
		"广州": [113.23, 23.16],
		"延安": [109.47, 36.6],
		"太原": [112.53, 37.87],
		"清远": [113.01, 23.7],
		"中山": [113.38, 22.52],
		"昆明": [102.73, 25.04],
		"寿光": [118.73, 36.86],
		"盘锦": [122.070714, 41.119997],
		"长治": [113.08, 36.18],
		"深圳": [114.07, 22.62],
		"珠海": [113.52, 22.3],
		"宿迁": [118.3, 33.96],
		"咸阳": [108.72, 34.36],
		"铜川": [109.11, 35.09],
		"平度": [119.97, 36.77],
		"佛山": [113.11, 23.05],
		"海口": [110.35, 20.02],
		"江门": [113.06, 22.61],
		"章丘": [117.53, 36.72],
		"肇庆": [112.44, 23.05],
		"大连": [121.62, 38.92],
		"临汾": [111.5, 36.08],
		"吴江": [120.63, 31.16],
		"石嘴山": [106.39, 39.04],
		"沈阳": [123.38, 41.8],
		"苏州": [120.62, 31.32],
		"茂名": [110.88, 21.68],
		"嘉兴": [120.76, 30.77],
		"长春": [125.35, 43.88],
		"胶州": [120.03336, 36.264622],
		"银川": [106.27, 38.47],
		"张家港": [120.555821, 31.875428],
		"三门峡": [111.19, 34.76],
		"锦州": [121.15, 41.13],
		"南昌": [115.89, 28.68],
		"柳州": [109.4, 24.33],
		"三亚": [109.511909, 18.252847],
		"自贡": [104.778442, 29.33903],
		"吉林": [126.57, 43.87],
		"阳江": [111.95, 21.85],
		"泸州": [105.39, 28.91],
		"西宁": [101.74, 36.56],
		"宜宾": [104.56, 29.77],
		"呼和浩特": [111.65, 40.82],
		"成都": [104.06, 30.67],
		"大同": [113.3, 40.12],
		"镇江": [119.44, 32.2],
		"桂林": [110.28, 25.29],
		"张家界": [110.479191, 29.117096],
		"宜兴": [119.82, 31.36],
		"北海": [109.12, 21.49],
		"西安": [108.95, 34.27],
		"金坛": [119.56, 31.74],
		"东营": [118.49, 37.46],
		"牡丹江": [129.58, 44.6],
		"遵义": [106.9, 27.7],
		"绍兴": [120.58, 30.01],
		"扬州": [119.42, 32.39],
		"常州": [119.95, 31.79],
		"潍坊": [119.1, 36.62],
		"重庆": [106.54, 29.59],
		"台州": [121.420757, 28.656386],
		"南京": [118.78, 32.04],
		"滨州": [118.03, 37.36],
		"贵阳": [106.71, 26.57],
		"无锡": [120.29, 31.59],
		"本溪": [123.73, 41.3],
		"克拉玛依": [84.77, 45.59],
		"渭南": [109.5, 34.52],
		"马鞍山": [118.48, 31.56],
		"宝鸡": [107.15, 34.38],
		"焦作": [113.21, 35.24],
		"句容": [119.16, 31.95],
		"北京": [116.46, 39.92],
		"徐州": [117.2, 34.26],
		"衡水": [115.72, 37.72],
		"包头": [110, 40.58],
		"绵阳": [104.73, 31.48],
		"乌鲁木齐": [87.68, 43.77],
		"枣庄": [117.57, 34.86],
		"杭州": [120.19, 30.26],
		"淄博": [118.05, 36.78],
		"鞍山": [122.85, 41.12],
		"溧阳": [119.48, 31.43],
		"库尔勒": [86.06, 41.68],
		"安阳": [114.35, 36.1],
		"开封": [114.35, 34.79],
		"济南": [117, 36.65],
		"德阳": [104.37, 31.13],
		"温州": [120.65, 28.01],
		"九江": [115.97, 29.71],
		"邯郸": [114.47, 36.6],
		"临安": [119.72, 30.23],
		"兰州": [103.73, 36.03],
		"沧州": [116.83, 38.33],
		"临沂": [118.35, 35.05],
		"南充": [106.110698, 30.837793],
		"天津": [117.2, 39.13],
		"富阳": [119.95, 30.07],
		"泰安": [117.13, 36.18],
		"诸暨": [120.23, 29.71],
		"郑州": [113.65, 34.76],
		"哈尔滨": [126.63, 45.75],
		"聊城": [115.97, 36.45],
		"芜湖": [118.38, 31.33],
		"唐山": [118.02, 39.63],
		"平顶山": [113.29, 33.75],
		"邢台": [114.48, 37.05],
		"德州": [116.29, 37.45],
		"济宁": [116.59, 35.38],
		"荆州": [112.239741, 30.335165],
		"宜昌": [111.3, 30.7],
		"义乌": [120.06, 29.32],
		"丽水": [119.92, 28.45],
		"洛阳": [112.44, 34.7],
		"秦皇岛": [119.57, 39.95],
		"株洲": [113.16, 27.83],
		"石家庄": [114.48, 38.03],
		"莱芜": [117.67, 36.19],
		"常德": [111.69, 29.05],
		"保定": [115.48, 38.85],
		"湘潭": [112.91, 27.87],
		"金华": [119.64, 29.12],
		"岳阳": [113.09, 29.37],
		"长沙": [113, 28.21],
		"衢州": [118.88, 28.97],
		"廊坊": [116.7, 39.53],
		"菏泽": [115.480656, 35.23375],
		"合肥": [117.27, 31.86],
		"武汉": [114.31, 30.52],
		"大庆": [125.03, 46.58]
	};

	var convertData = function(seriesd) {
		var res = [];
		for(var i = 0; i < seriesd.length; i++) {
			var geoCoord = geoCoordMap[seriesd[i].name];
			if(geoCoord) {
				res.push(geoCoord.concat(seriesd[i].value));
			}
		}
		return res;
	};

	option = {
		title: {
			text: ' ',
			subtext: '',
			sublink: '',
			left: 'center',
			textStyle: {
				color: '#fff'
			}
		},
		backgroundColor: '#404a59',
		visualMap: {
			min: 0,
			max: 500,
			splitNumber: 5,
			inRange: {
				color: ['#d94e5d', '#eac736', '#50a3ba'].reverse()
			},
			textStyle: {
				color: '#fff'
			}
		},
		geo: {
			map: 'china',
			label: {
				emphasis: {
					show: false
				}
			},
			roam: true,
			itemStyle: {
				normal: {
					areaColor: '#323c48',
					borderColor: '#111'
				},
				emphasis: {
					areaColor: '#2a333d'
				}
			}
		},
		series: [{
			name: 'AQI',
			type: 'heatmap',
			coordinateSystem: 'geo',
			data: convertData(seriesd)
		}]
	};

	myChart.setOption(option);
}

// 热力点 
function Customized_re2(IdName, seriesd, seriesd_c) {
	var myChart = echarts.init(document.getElementById(IdName));

	var geoCoordMap = seriesd_c;
	//
	// 		console.log(seriesd);
	// 		console.log(seriesd_c);

	var convertData = function(data) {
		var res = [];
		for(var i = 0; i < data.length; i++) {
			var geoCoord = geoCoordMap[data[i].name];
			if(geoCoord) {
				res.push({
					name: data[i].name,
					value: geoCoord.concat(data[i].value)
				});
			}
		}
		return res;
	};

	option = {
		animationDuration: 2000,
		title: {
			//      text: '全国主要城市空气质量',
			//      subtext: 'data from PM25.in',
			//      sublink: 'http://www.pm25.in',
			x: 'center',
			textStyle: {
				color: '#fff'
			}
		},
		tooltip: {
			      trigger: 'item',
			      formatter: function (params) {
			          return params.name  + ' , ' + params.value[2] + ' 小时 ';
			      }
		},
		legend: {
			//      orient: 'vertical',
			//      y: 'bottom',
			//      x:'right',
			//      data:['pm2.5'],
			//      textStyle: {
			//          color: '#fff'
			//      }
		},
	    visualMap: {   //左下 颜色
			show: true,
	        min: 0,
	        max: 72,
	        calculable: true,
	        color: ['#67f313','#eaff00','#ff0000'],
	        textStyle: {
	            color: '#fff'
	        },
	        text: ['小时',' ']
	    },
		geo: {
			map: 'china',
			label: {
				emphasis: {
					show: false
				}
			},
			zoom: 1.2,
			itemStyle: {
				normal: {
					areaColor: 'rgba(9, 75, 151, 0.9)',
					borderColor: '#00dae4'
				},
				emphasis: {
					areaColor: '#2a333d'
				}
			}
		},
		series: [{
			name: '',
			type: 'scatter',
			coordinateSystem: 'geo',
			data: convertData(seriesd),
			symbolSize: 5,
			label: {
				normal: {
					show: false
				},
				emphasis: {
					show: false
				}
			},
			itemStyle: {
				normal: {
					borderColor: '#cccccc',
					borderWidth: 0.1
				}
			}
		}]
	}

	myChart.setOption(option);
}

//  地图和横 柱体  联合
function Customized_re3(IdName, seriesd, seriesd_c ,series_hcs ,series_shu) {
	var myChart = echarts.init(document.getElementById(IdName));

	var geoCoordMap = seriesd_c;
	var data = seriesd;
	// 		console.log(seriesd);
	// 		console.log(seriesd_c);
	// 用地图geoCoordMap里的名字,匹配 data 里面的数据  生成 数据  res
	var convertData = function(data) {
		var res = [];
		for(var i = 0; i < data.length; i++) {
			var geoCoord = geoCoordMap[data[i].name];
			if(geoCoord) {
				res.push({
					name: data[i].name,
					value: geoCoord.concat(data[i].value)
				});
			}
		}
		return res;
	};

	//  图中  6大   被选出
	var convertedData = [
		convertData(data),
		convertData(data.sort(function(a, b) { //sort是排序          a - b  从小到大      b - a  从大到小
			return b.value - a.value;
		}).slice(0, 10)) //slice()  从已有的数组中返回选定的元素。  （0，6） 前    6 位
	];

	option = {

		animation: true, //
		animationDuration: 2000,
		animationEasing: 'cubicInOut',
		animationDurationUpdate: 1000,
		animationEasingUpdate: 'cubicInOut',
		title: [{
			text: ' ',
			//副标题                                      subtext: 'data from yunqicl',
			left: 100,
			top: 30,
			textStyle: {
				color: '#fff',
				fontSize: 50
			}
		}, {
			show: false,
			id: 'statistic', //平均值的  id
			right: 120,
			top: 40,
			width: 100,
			textStyle: {
				color: '#fff', //平均值的颜色
				fontSize: 16
			}
		}],
		toolbox: { //工具栏
			show: false,
			iconStyle: { //公共
				normal: {
					borderColor: '#fff' //工具的颜色
				},
				emphasis: {
					borderColor: '#b1e4ff' //工具被选中的颜色
				}
			},
			feature: { //各工具配置项。
				dataZoom: {},
				brush: {
					type: ['rect', 'polygon', 'clear']
				},
				saveAsImage: {
					show: true
				}
			}
		},
 
		geo: {
			name: 'china',
			type: 'scatter',
			map: 'china',
			zoom: 1.2,
			label: {
				emphasis: {
					show: false
				}
			},
			itemStyle: {
				normal: {
					areaColor: 'rgba(9, 75, 151, 0.9)',
					borderColor: '#00dae4'
				},
				emphasis: {
					areaColor: '#2a333d'
				}
			}
		},
		tooltip: {
			trigger: 'item'
		},
		grid: {
			right: 140,
			top: 575,
			bottom: 40,
			width: '15%',
			height: '24%'
		},
		xAxis: {
			type: 'value',
			scale: true,
			name: '单位/方',
			nameGap : 20,
			nameLocation : 'end',
			nameTextStyle: {
				fontSize: 14,
				color: "#ffffff",
				
			},
			axisLine: {
				lineStyle: {
					color: "#ffffff",
					width: 1, //这里是为了突出显示加上的
				}

			},
			position: 'top',
			boundaryGap: false,
			splitLine: {
				show: false
			},
			axisLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			axisLabel: {
				margin: 2,
				textStyle: {
					color: '#aaa'
				}
			}, // 柱状图  X 轴  那些 上的 颜色
		},
		yAxis: {
			type: 'category',
			name: 'TOP 10',
			nameGap: 22,
			axisLine: {
				show: false,
				lineStyle: {
					color: '#ddd'
				}
			}, //  Y 轴  ‘top10’ 文字的颜色
			axisTick: {
				show: false,
				lineStyle: {
					color: '#ddd'
				}
			},
			axisLabel: {
				interval: 0,
				textStyle: {
					color: '#ddd'
				}
			}, //  Y 轴 各个城市名字的颜色
			data: series_hcs
		},
		series: [{
			name: 'pm2.5',
			type: 'scatter',
			coordinateSystem: 'geo',
			data: convertedData[0],
			symbolSize: function(val) {
				return Math.max(val[2] / 10, 5);
			},
			label: {
				normal: {
					formatter: '{b}',
					position: 'right',
					show: false
				},
				emphasis: {
					show: true
				}
			},
			itemStyle: {
				normal: {
					color: '#ddb926'
				}
			}
		}, {
			name: 'Top 5',
			type: 'effectScatter',
			coordinateSystem: 'geo',
			data: convertedData[1],
			symbolSize: function(val) {
				return Math.max(val[2] / 5, 8);
			},
			showEffectOn: 'render',
			rippleEffect: {
				brushType: 'stroke'
			},
			hoverAnimation: true,
			label: {
				normal: {
					formatter: '{b}',
					position: 'right',
					show: true
				}
			},
			itemStyle: {
				normal: {
					color: '#f4e925',
					shadowBlur: 10,
					shadowColor: '#333'
				}
			},
			zlevel: 1
		}, {
			id: 'bar',
			zlevel: 2,
			type: 'bar',
			symbol: 'none',
			itemStyle: {
				normal: {
					color: '#ddb926'
				}
			},
			data: series_shu
		}]
	};

 
 
	myChart.setOption(option);
}

//  星星点点  eq ：微博签到图
function Customized_re4(IdName, seriess, seriesm, seriesb) {
	var myChart = echarts.init(document.getElementById(IdName));

	var uploadedDataURL = "data-1461574801505-SJtcnUog.json";

	myChart.showLoading();

	$.getJSON(uploadedDataURL, function(weiboData) {
		myChart.hideLoading();

		myChart.setOption(option = {

			title: {
				text: '',
				subtext: '',
				sublink: '',
				left: 'center',
				top: 'top',
				textStyle: {
					color: '#fff'
				}
			},
			legend: {
				left: 'left',
				data: ['强', '中', '弱'],
				textStyle: {
					color: '#ccc'
				}
			},
			geo: {
				name: '强',
				type: 'scatter',
				map: 'china',
				zoom: 1.2,
				label: {
					emphasis: {
						show: false
					}
				},
				itemStyle: {
					normal: {
						areaColor: 'rgba(9, 75, 151, 0.9)',
						borderColor: '#00dae4'
					},
					emphasis: {
						areaColor: '#2a333d'
					}
				}
			},
			series: [{
				name: '弱',
				type: 'scatter',
				coordinateSystem: 'geo',
				symbolSize: 2,
				large: true,
				itemStyle: {
					normal: {
						shadowBlur: 2,
						shadowColor: 'rgba(37, 140, 249, 0.8)',
						color: 'rgba(37, 140, 249, 0.8)'
					}
				},
				data: seriess
			}, {
				name: '中',
				type: 'scatter',
				coordinateSystem: 'geo',
				symbolSize: 2,
				large: true,
				itemStyle: {
					normal: {
						shadowBlur: 2,
						shadowColor: 'rgba(14, 241, 242, 0.8)',
						color: 'rgba(14, 241, 242, 0.8)'
					}
				},
				data: seriesm
			}, {
				name: '强',
				type: 'scatter',
				coordinateSystem: 'geo',
				symbolSize: 2,
				large: true,
				itemStyle: {
					normal: {
						shadowBlur: 2,
						shadowColor: 'rgba(255, 255, 255, 0.8)',
						color: 'rgba(255, 255, 255, 0.8)'
					}
				},
				data: seriesb
			}]
		});
	});

}

function Customized_re5(IdName, seriesd) {
	var myChart = echarts.init(document.getElementById(IdName));
//	console.log(seriesd);

	function randomData() {
		return Math.round(Math.random() * 1000);
	}

	option = {
		animationDuration: 2000,
		title: {
			text: ' ',
			subtext: ' ',
			left: 'center'
		},
		tooltip: {
			show: false,
			trigger: 'item'
		},
		legend: {
			show: false,
			orient: 'vertical',
			left: 'left',
			data: ['iphone3', 'iphone4', 'iphone5']
		},
		visualMap: { //左下 颜色
			min: 0,
			max: 13000,
            left: 100,
			calculable: true,
			color: ['#d94e5d', '#eac736', '#50a3ba'], //柱体
			textStyle: {
				color: '#fff' // 文字
			},
			text: ['单位/方',''],           // 文本，默认为数值文本
		},

		toolbox: {
			show: false,
			orient: 'vertical',
			left: 'right',
			top: 'center',
			feature: {
				dataView: {
					readOnly: false
				},
				restore: {},
				saveAsImage: {}
			}
		},
		series: [{
			name: ' ',
			type: 'map',
			mapType: 'china',
			roam: true,
			zoom: 1.2,
			itemStyle: {
				normal: {
					areaColor: 'rgba(9, 75, 151, 0.9)',
					borderColor: '#00dae4'
				},
				emphasis: {
                    color: '#000000',
					areaColor: '#ffffff'
				}
			},
			label: {
				normal: {
					show: true
				},
				emphasis: {
					show: true
				}
			},
			data: seriesd
		}]
	};	myChart.setOption(option);
}


function text(IdName, seriesd, seriesd_c){
 


}