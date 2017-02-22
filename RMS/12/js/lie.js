 
/************上墙      *********************上墙      ***************************上墙      ******************************/
//  时间 显示 年月日 
var timerID = null
var timerRunning = false

function MakeArray(size) {
	this.length = size;
	for(var i = 1; i <= size; i++) {
		this[i] = "";
	}
	return this;
}

function stopclock() {
	if(timerRunning)
		clearTimeout(timerID);
	timerRunning = false
}

function showtime() {
	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth() + 1;
	var date = now.getDate();
	var hours = now.getHours();
	var minutes = now.getMinutes();
	var seconds = now.getSeconds();
	var day = now.getDay();
	Day = new MakeArray(7);
	Day[0] = "星期天";
	Day[1] = "星期一";
	Day[2] = "星期二";
	Day[3] = "星期三";
	Day[4] = "星期四";
	Day[5] = "星期五";
	Day[6] = "星期六";
	var timeValue = "";
	timeValue += year + "年";
	timeValue += ((month < 10) ? "0" : "") + month + "月";
	timeValue += date + "日 ";
	timeValue += (Day[day]) + " ";
	timeValue += (hours < 12) ? "上午" : "下午";
	timeValue += ((hours <= 12) ? hours : hours - 12);
	timeValue += ((minutes < 10) ? ":0" : ":") + minutes;
	timeValue += ((seconds < 10) ? ":0" : ":") + seconds;

	document.jsfrm.face.value = timeValue;
	timerID = setTimeout("showtime()", 1000);
	timerRunning = true
}

function startclock() {
	stopclock();
	showtime()
}

//  时间 显示 年月日

//rms_0048 年线路
function b_year() {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0048';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
		function(result, data) {
			if(result) {
				var _html = '';
				$('.jplistYL').html('');
				$('.text-pos').addClass('jplist-hidden');
				var length = data[0].rs.length;
				if(length != 0) {
					var len = data[0].rs[0].rows.length / 10;
 
					for(var j = 0; j < data[0].rs[0].rows.length; j++) {
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div class="S_CName" >' + data[0].rs[0].rows[j].fromcity + ' → ' + data[0].rs[0].rows[j].tocity + '</div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';	
								
						$('.tableCont_bd_47').append(con1);
					}
					jQuery(".slideTxtBox_y1").slide({
						titCell: ".hd_47 ul",
						mainCell: ".bd_47 ul",
						effect: "topLoop",
						interTime: 22200,
						vis: 7,
						scroll: 7,
						autoPlay: true,
						autoPage: true
					});
				} else {
					console.log('arrays');
				}

			}
		})

}

//rms_0049 月线路
function b_month() {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0049';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
		function(result, data) {
			if(result) {
				var _html = '';
				$('.jplistYL').html('');
				$('.text-pos').addClass('jplist-hidden');
				var length = data[0].rs.length;
				if(length != 0) {
					var len = data[0].rs[0].rows.length / 10;
					//					var arrays = new Array();
					//					for(var i = 0; i < data[0].rs[0].rows.length; i++){
					//					    arrays[i] = {
					//					        id:data[0].rs[0].rows[i].Index_CreatorCompanyID,
					//					        ComapanyName:data[0].rs[0].rows[i].ComapanyName,
					//					        TotalAmount:data[0].rs[0].rows[i].TotalAmount,
					//					        TotalCost:data[0].rs[0].rows[i].TotalCost,
					//					        TotalWeight:data[0].rs[0].rows[i].TotalWeight,
					//					        TotalVolume:data[0].rs[0].rows[i].TotalVolume,
					//					    }
					//					}	
					//	 i  判断 调整             j  判断 调整    

					for(var j = 0; j < data[0].rs[0].rows.length; j++) {
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div class="S_CName" >' + data[0].rs[0].rows[j].fromcity + ' → ' + data[0].rs[0].rows[j].tocity + '</div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';	
   
						$('.tableCont_bd_48').append(con1);
					}
					jQuery(".slideTxtBox_m1").slide({
						titCell: ".hd_48 ul",
						mainCell: ".bd_48 ul",
						effect: "topLoop",
						interTime: 15020,
						vis: 7,
						scroll: 7,
						autoPlay: true,
						autoPage: true
					});
				} else {
					console.log('arrays');
				}

			}
		})

}

//rms_0050 日线路
function b_today() {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0050';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		
		
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
		function(result, data) {
			if(result) {
				var _html = '';
				$('.jplistYL').html('');
				$('.text-pos').addClass('jplist-hidden');
				var length = data[0].rs.length;
				if(length != 0) {
					var len = data[0].rs[0].rows.length / 10;
					//					var arrays = new Array();
					//					for(var i = 0; i < data[0].rs[0].rows.length; i++){
					//					    arrays[i] = {
					//					        id:data[0].rs[0].rows[i].Index_CreatorCompanyID,
					//					        ComapanyName:data[0].rs[0].rows[i].ComapanyName,
					//					        TotalAmount:data[0].rs[0].rows[i].TotalAmount,
					//					        TotalCost:data[0].rs[0].rows[i].TotalCost,
					//					        TotalWeight:data[0].rs[0].rows[i].TotalWeight,
					//					        TotalVolume:data[0].rs[0].rows[i].TotalVolume,
					//					    }
					//					}	
					//	 i  判断 调整             j  判断 调整    

					for(var j = 0; j < data[0].rs[0].rows.length; j++) {
						 
 
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div class="S_CName" >' + data[0].rs[0].rows[j].fromcity + ' → ' + data[0].rs[0].rows[j].tocity + '</div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';	
						 
						$('.tableCont_bd_49').append(con1);
					}
					jQuery(".slideTxtBox_t1").slide({
						titCell: ".hd_49 ul",
						mainCell: ".bd_49 ul",
						effect: "topLoop",
						interTime: 7000,
						vis: 7,
						scroll: 7,
						autoPlay: true,
						autoPage: true
					});
				} else {
					console.log('arrays');
				}

			}
		})

}

//  rms_0051 年客户
function c_year() {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0051';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
		function(result, data) {
			if(result) {
				var _html = '';
				$('.jplistYL').html('');
				$('.text-pos').addClass('jplist-hidden');
				var length = data[0].rs.length;
				if(length != 0) {
					var len = data[0].rs[0].rows.length / 10;
					//					var arrays = new Array();
					//					for(var i = 0; i < data[0].rs[0].rows.length; i++){
					//					    arrays[i] = {
					//					        id:data[0].rs[0].rows[i].Index_CreatorCompanyID,
					//					        ComapanyName:data[0].rs[0].rows[i].ComapanyName,
					//					        TotalAmount:data[0].rs[0].rows[i].TotalAmount,
					//					        TotalCost:data[0].rs[0].rows[i].TotalCost,
					//					        TotalWeight:data[0].rs[0].rows[i].TotalWeight,
					//					        TotalVolume:data[0].rs[0].rows[i].TotalVolume,
					//					    }
					//					}	
					//	 i  判断 调整             j  判断 调整    				

					for(var j = 0; j < data[0].rs[0].rows.length; j++) {
						var n_len = data[0].rs[0].rows[j].CustomerName.length;
						if(n_len > 25){
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div style="height:26px; overflow: hidden;" class="S_CName" ><marquee scrollamount="1" >' + data[0].rs[0].rows[j].CustomerName + '</marquee></div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';		
						}else{
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div class="S_CName" >' + data[0].rs[0].rows[j].CustomerName + '</div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';	
						}
						$('.tableCont_bd_50').append(con1);
					}
					jQuery(".slideTxtBox_y2").slide({
						titCell: ".hd_50 ul",
						mainCell: ".bd_50 ul",
						effect: "topLoop",
						interTime: 22200,						
						vis: 7,
						scroll: 7,
						autoPlay: true,
						autoPage: true
					});
				} else {
					console.log('arrays');
				}

			}
		})

}

//  rms_0052 月客户
function c_month() {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0052';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
		function(result, data) {
			if(result) {
				var _html = '';
				$('.jplistYL').html('');
				$('.text-pos').addClass('jplist-hidden');
				var length = data[0].rs.length;
				if(length != 0) {
					var len = data[0].rs[0].rows.length / 10;
					//					var arrays = new Array();
					//					for(var i = 0; i < data[0].rs[0].rows.length; i++){
					//					    arrays[i] = {
					//					        id:data[0].rs[0].rows[i].Index_CreatorCompanyID,
					//					        ComapanyName:data[0].rs[0].rows[i].ComapanyName,
					//					        TotalAmount:data[0].rs[0].rows[i].TotalAmount,
					//					        TotalCost:data[0].rs[0].rows[i].TotalCost,
					//					        TotalWeight:data[0].rs[0].rows[i].TotalWeight,
					//					        TotalVolume:data[0].rs[0].rows[i].TotalVolume,
					//					    }
					//					}	
					//	 i  判断 调整             j  判断 调整    				

					for(var j = 0; j < data[0].rs[0].rows.length; j++) {
						var n_len = data[0].rs[0].rows[j].CustomerName.length;
						if(n_len > 25){
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div style="height:26px; overflow: hidden;" class="S_CName" ><marquee scrollamount="1" >' + data[0].rs[0].rows[j].CustomerName + '</marquee></div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';		
						}else{
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div class="S_CName" >' + data[0].rs[0].rows[j].CustomerName + '</div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';	
						}
						$('.tableCont_bd_51').append(con1);
					}
					jQuery(".slideTxtBox_m2").slide({
						titCell: ".hd_51 ul",
						mainCell: ".bd_51 ul",
						effect: "topLoop",
						interTime: 15020,
						vis: 7,
						scroll: 7,
						autoPlay: true,
						autoPage: true
					});

				} else {
					console.log('arrays');
				}

			}
		})

}

//   rms_0053 日客户
function c_today() {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0053';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
		function(result, data) {
			if(result) {
				var _html = '';
				$('.jplistYL').html('');
				$('.text-pos').addClass('jplist-hidden');
				var length = data[0].rs.length;
				if(length != 0) {
					var len = data[0].rs[0].rows.length / 10;
					//					var arrays = new Array();
					//					for(var i = 0; i < data[0].rs[0].rows.length; i++){
					//					    arrays[i] = {
					//					        id:data[0].rs[0].rows[i].Index_CreatorCompanyID,
					//					        ComapanyName:data[0].rs[0].rows[i].ComapanyName,
					//					        TotalAmount:data[0].rs[0].rows[i].TotalAmount,
					//					        TotalCost:data[0].rs[0].rows[i].TotalCost,
					//					        TotalWeight:data[0].rs[0].rows[i].TotalWeight,
					//					        TotalVolume:data[0].rs[0].rows[i].TotalVolume,
					//					    }
					//					}	
					//	 i  判断 调整             j  判断 调整    				

					for(var j = 0; j < data[0].rs[0].rows.length; j++) {
						var n_len = data[0].rs[0].rows[j].CustomerName.length;
						if(n_len > 25){
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div style="height:26px; overflow: hidden;" class="S_CName" ><marquee scrollamount="1" >' + data[0].rs[0].rows[j].CustomerName + '</marquee></div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';		
						}else{
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div class="S_CName" >' + data[0].rs[0].rows[j].CustomerName + '</div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';	
						}
						$('.tableCont_bd_52').append(con1);
					}
					jQuery(".slideTxtBox_t2").slide({
						titCell: ".hd_52 ul",
						mainCell: ".bd_52 ul",
						effect: "topLoop",
						interTime:7000,
						vis: 7,
						scroll: 7,
						autoPlay: true,
						autoPage: true
					});
				} else {
					console.log('arrays');
				}

			}
		})

}

//   rms_0054 年承运商
function f_year() {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0054';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
		function(result, data) {
			if(result) {
				var _html = '';
				$('.jplistYL').html('');
				$('.text-pos').addClass('jplist-hidden');
				var length = data[0].rs.length;
				if(length != 0) {
					var len = data[0].rs[0].rows.length / 10;
					//					var arrays = new Array();
					//					for(var i = 0; i < data[0].rs[0].rows.length; i++){
					//					    arrays[i] = {
					//					        id:data[0].rs[0].rows[i].Index_CreatorCompanyID,
					//					        ComapanyName:data[0].rs[0].rows[i].ComapanyName,
					//					        TotalAmount:data[0].rs[0].rows[i].TotalAmount,
					//					        TotalCost:data[0].rs[0].rows[i].TotalCost,
					//					        TotalWeight:data[0].rs[0].rows[i].TotalWeight,
					//					        TotalVolume:data[0].rs[0].rows[i].TotalVolume,
					//					    }
					//					}	
					//	 i  判断 调整             j  判断 调整    				

					for(var j = 0; j < data[0].rs[0].rows.length; j++) {
						var n_len = data[0].rs[0].rows[j].SupplierName.length;
						if(n_len > 25){
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div style="height:26px; overflow: hidden;" class="S_CName" ><marquee scrollamount="1" >' + data[0].rs[0].rows[j].SupplierName + '</marquee></div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';		
						}else{
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div class="S_CName" >' + data[0].rs[0].rows[j].SupplierName + '</div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';	
						}
						$('.tableCont_bd_53').append(con1);
					}
					jQuery(".slideTxtBox_y3").slide({
						titCell: ".hd_53 ul",
						mainCell: ".bd_53 ul",
						effect: "topLoop",
						interTime: 22200,						
						vis: 7,
						scroll: 7,
						autoPlay: true,
						autoPage: true
					});
				} else {
					console.log('arrays');
				}

			}
		})

}

//   rms_0055 月承运商
function f_month() {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0055';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
		function(result, data) {
			if(result) {
				var _html = '';
				$('.jplistYL').html('');
				$('.text-pos').addClass('jplist-hidden');
				var length = data[0].rs.length;
				if(length != 0) {
					var len = data[0].rs[0].rows.length / 10;
					//					var arrays = new Array();
					//					for(var i = 0; i < data[0].rs[0].rows.length; i++){
					//					    arrays[i] = {
					//					        id:data[0].rs[0].rows[i].Index_CreatorCompanyID,
					//					        ComapanyName:data[0].rs[0].rows[i].ComapanyName,
					//					        TotalAmount:data[0].rs[0].rows[i].TotalAmount,
					//					        TotalCost:data[0].rs[0].rows[i].TotalCost,
					//					        TotalWeight:data[0].rs[0].rows[i].TotalWeight,
					//					        TotalVolume:data[0].rs[0].rows[i].TotalVolume,
					//					    }
					//					}	
					//	 i  判断 调整             j  判断 调整    				

					for(var j = 0; j < data[0].rs[0].rows.length; j++) {
						var n_len = data[0].rs[0].rows[j].SupplierName.length;
						if(n_len > 25){
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div style="height:26px; overflow: hidden;" class="S_CName" ><marquee scrollamount="1" >' + data[0].rs[0].rows[j].SupplierName + '</marquee></div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';		
						}else{
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div class="S_CName" >' + data[0].rs[0].rows[j].SupplierName + '</div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';	
						}
						$('.tableCont_bd_54').append(con1);

					}

					jQuery(".slideTxtBox_m3").slide({
						titCell: ".hd_54 ul",
						mainCell: ".bd_54 ul",
						effect: "topLoop",
						interTime: 15020,
						vis: 7,
						scroll: 7,
						autoPlay: true,
						autoPage: true
					});

				} else {
					console.log('arrays');
				}

			}
		})

}

//   rms_0056 日承运商
function f_today() {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0056';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
		function(result, data) {
			if(result) {
				var _html = '';
				$('.jplistYL').html('');
				$('.text-pos').addClass('jplist-hidden');
				var length = data[0].rs.length;
				if(length != 0) {

					var len = Math.ceil(data[0].rs[0].rows.length / 6);
					console.log(len);
					//					var arrays = new Array();
					//					for(var i = 0; i < data[0].rs[0].rows.length; i++){
					//					    arrays[i] = {
					//					        id:data[0].rs[0].rows[i].Index_CreatorCompanyID,
					//					        ComapanyName:data[0].rs[0].rows[i].ComapanyName,
					//					        TotalAmount:data[0].rs[0].rows[i].TotalAmount,
					//					        TotalCost:data[0].rs[0].rows[i].TotalCost,
					//					        TotalWeight:data[0].rs[0].rows[i].TotalWeight,
					//					        TotalVolume:data[0].rs[0].rows[i].TotalVolume,
					//					    }
					//					}	
					//	 i  判断 调整             j  判断 调整    				
					//
					for(var j = 0; j < data[0].rs[0].rows.length; j++) {
						var n_len = data[0].rs[0].rows[j].SupplierName.length;
						if(n_len > 25){
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div style="height:26px; overflow: hidden;" class="S_CName" ><marquee scrollamount="1" >' + data[0].rs[0].rows[j].SupplierName + '</marquee></div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';		
						}else{
							var con1 = '<li class="clearfix tableCont_a_li tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
	
								'<div class="S_CName" >' + data[0].rs[0].rows[j].SupplierName + '</div>' +
								'<div class="TotalAmount" >' + parseInt(parseInt(data[0].rs[0].rows[j].Total)) + '</div>' +
	
								'<div class="TotalWeight" >' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
								'<div class="TotalVolume" >' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
								'</li>';	
						}
   
						$('.tableCont_bd_55').append(con1);
					 
					}

					jQuery(".slideTxtBox_t").slide({
						titCell: ".hd_55 ul",
						mainCell: ".bd_55 ul",
						effect: "topLoop",
						interTime: 7000,
						vis: 7,
						scroll: 7,
						autoPlay: true,
						autoPage: true
					});

				} else {
					console.log('arrays');
				}

			}
		})

}


 
//   rms_xxxxx    
//   rms_0053   集团总运量承运方年表   forwarder 
function rms_xxxxx() {
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0048';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
		function(result, data) {
			if(result) {
				var _html = '';
				$('.jplistYL').html('');
				$('.text-pos').addClass('jplist-hidden');
				var length = data[0].rs.length;
				if(length != 0) {
					var len = data[0].rs[0].rows.length / 10;
					//					var arrays = new Array();
					//					for(var i = 0; i < data[0].rs[0].rows.length; i++){
					//					    arrays[i] = {
					//					        id:data[0].rs[0].rows[i].Index_CreatorCompanyID,
					//					        ComapanyName:data[0].rs[0].rows[i].ComapanyName,
					//					        TotalAmount:data[0].rs[0].rows[i].TotalAmount,
					//					        TotalCost:data[0].rs[0].rows[i].TotalCost,
					//					        TotalWeight:data[0].rs[0].rows[i].TotalWeight,
					//					        TotalVolume:data[0].rs[0].rows[i].TotalVolume,
					//					    }
					//					}	
					//	 i  判断 调整             j  判断 调整    				

					for(var j = 0; j < data[0].rs[0].rows.length; j++) {
//						var i =  parseInt(parseInt(j)+1);
//						var con1 = '<li class="clearfix  tableTitle8 marTBLR0" name="AllList_' + j + '" >' +
//							'<div class="S_Cid">' + i + '</div>' +
//							'<div class="S_Cn">' + data[0].rs[0].rows[j].SupplierName + '</div>' +
//							'<div class="S_C_else">' + parseInt(parseInt(data[0].rs[0].rows[j].TotalAmount)) + '</div>' +
//							'<div class="S_C_else">' + data[0].rs[0].rows[j].TotalCost + '</div>' +
//							'<div class="S_C_else">' + Math.ceil(data[0].rs[0].rows[j].TotalWeight) + '</div>' +
//							'<div class="S_C_else">' + Math.ceil(data[0].rs[0].rows[j].TotalVolume) + '</div>' +
//							'</li>';
//						$('.tableCont_bd_more').append(con1);
					}
//					jQuery(".slideTxtBox_m").slide({
//						titCell: ".hd_m ul",
//						mainCell: ".bd_m ul",
//						effect: "topLoop",
//						interTime: 22200,
//						vis: 10,
//						scroll: 10,
//						autoPlay: true,
//						autoPage: true
//					});
				} else {
					console.log('arrays');
				}

			}
		})

}

 
 

// 年份选择 初始化
			$(document).ready(function() {
				$('.year_').addClass('form-control');
				$('.year_').empty();
				var defaults = {
					YearSelector: ".year_",

				};
				var opts = $.extend({}, defaults, ".year_");
				var $YearSelector = $(opts.YearSelector);

				// 年份列表
				var yearNow = 2022;
				var yearSel = 2016;
				for(var i = yearNow; i >= 2014; i--) {
					var sed = yearSel == i ? "selected" : "";
					var yearStr = "<option value=\"" + i + "\" " + sed + ">" + i + "</option>";
					$YearSelector.append(yearStr);
				}
			});
			

function js_lock(){
	var myDate = new Date();
	var h = myDate.getHours();       //获取当前小时数(0-23)
	if( h == 23){
		window.location.reload();
	} 
}
