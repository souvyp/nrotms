//data[0].rs[0] != undefined   用 data[0].rs[0] != undefined 替换

window.APP = function() {};
APP.Name = "APP Javascript Framework";
APP.Author = "Guo HongLiang";
APP.Version = "0.1.4";
APP.PublishDate = "2014-9-1";
APP.init8 = function() {
	this.Name = "APP";
	this.Author = "S";
	this.Version = "0.0.1";
	this.PublishDate = "2016-11-14";
	
	nineth('main0_3');    
	
	second('main0_1');  //市内
	
	third('main0_2');   //线路
	
	fourth('main0_0');   
   
	fifth('main0_4');
	
	sixth('main0_5');
		
	seventh('main0_6');
			
	eighth('main0_7');
//	var a = NF.System.Attach.style_add (10,10); 
//	var b = NF.System.Attach.style_sub (10,10); 
//	var c = NF.System.Attach.style_mul (10,10); 
//	var d = NF.System.Attach.style_div (10,10); 
//	var e = NF.System.Attach.countInput ('asdf11'); 
//	var f = NF.System.Attach.countText ('asdf'); 
//		
//	console.log(a,b,c,d,e,f);
 
};

APP.init5_1 = function() {
 
	
	fifth('main1_0');
	
	sixth('main1_1');
	
	seventh('main1_2');
	
	eighth('main1_3');
 
	fifth('min_main51');
 
 
};

APP.init5_2 = function() {
 
	
	nineth('main1_4');
	
	second('main1_5');
	
	third('main1_6');
	
	fourth('main1_7');
 
	nineth('min_main52');
 
 
};

APP.init2 = function() {
 
	nineth('main4_0');    
	fifth('main4_1');

 
};





 // 大饼     rms_0067
function first(Id_Name){
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0067';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		var arrays_CN = new Array();
		var arrays_BF = new Array();
		var arrays_FJ = new Array();
		var arrays_LD = new Array();
		var arrays_SF = new Array();
		var arrays_SH = new Array();
		var arrays_TH = new Array();
		var arrays_XH = new Array();
		var arrays_ZC = new Array();
		var arrays_ZH = new Array();
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
					var len = data[0].rs[0].rows.length / 10;
					 
					for(var i = 0; i < data[0].rs[0].rows.length; i++){
						arrays_CN[i] = data[0].rs[0].rows[i].CustomerName.substring(0,4);
						arrays_BF[i] = (data[0].rs[0].rows[i].BF/10000).toFixed(2);
						arrays_FJ[i] = (data[0].rs[0].rows[i].FJ/10000).toFixed(2);
						arrays_LD[i] = (data[0].rs[0].rows[i].LD/10000).toFixed(2);
						arrays_SF[i] = (data[0].rs[0].rows[i].SF/10000).toFixed(2);
						arrays_SH[i] = (data[0].rs[0].rows[i].SH/10000).toFixed(2);
						arrays_TH[i] = (data[0].rs[0].rows[i].TH/10000).toFixed(2);
						arrays_XH[i] = (data[0].rs[0].rows[i].XH/10000).toFixed(2);
						arrays_ZC[i] = (data[0].rs[0].rows[i].ZC/10000).toFixed(2);
						arrays_ZH[i] = (data[0].rs[0].rows[i].ZH/10000).toFixed(2);
 
					}	
//					console.log(arrays);
				} else {
					 
				}
			});
		var chartsName ='中联达啊啊啊';
				 
 
 
	   	if(Id_Name == undefined || Id_Name == ''){
	   		Customized_zhu_hmax('main11',arrays_CN,arrays_BF,arrays_FJ,arrays_LD,arrays_SF,arrays_SH,arrays_TH,arrays_XH,arrays_ZC,arrays_ZH);
	   	}else{
	   		$('#' + Id_Name).empty();
	   		Customized_zhu_hmax(Id_Name,arrays_CN,arrays_BF,arrays_FJ,arrays_LD,arrays_SF,arrays_SH,arrays_TH,arrays_XH,arrays_ZC,arrays_ZH);
	   	}
 		

}

// 柱体  rms_0061 长途市内
function second(Id_Name){
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0061';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		var arrays = new Array();
		var arrayss = new Array();
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
 					if(data[0].rs[0] != undefined){
						var len = data[0].rs[0].rows.length / 10;
						 
						for(var i = 0; i < 1; i++){
							arrays.push(parseFloat(data[0].rs[0].rows[i][1]).toFixed(2), parseFloat(data[0].rs[0].rows[i][2]).toFixed(2), parseFloat(data[0].rs[0].rows[i][3]).toFixed(2), parseFloat(data[0].rs[0].rows[i][4]).toFixed(2), parseFloat(data[0].rs[0].rows[i][5]).toFixed(2), parseFloat(data[0].rs[0].rows[i][6]).toFixed(2), parseFloat(data[0].rs[0].rows[i][7]).toFixed(2), parseFloat(data[0].rs[0].rows[i][8]).toFixed(2), parseFloat(data[0].rs[0].rows[i][9]).toFixed(2), parseFloat(data[0].rs[0].rows[i][10]).toFixed(2), parseFloat(data[0].rs[0].rows[i][11]).toFixed(2), parseFloat(data[0].rs[0].rows[i][12]).toFixed(2));
	 
						}	
						for(var i = 1; i < 2; i++){
	 
							arrayss.push(parseFloat(data[0].rs[0].rows[i][1]).toFixed(2), parseFloat(data[0].rs[0].rows[i][2]).toFixed(2), parseFloat(data[0].rs[0].rows[i][3]).toFixed(2), parseFloat(data[0].rs[0].rows[i][4]).toFixed(2), parseFloat(data[0].rs[0].rows[i][5]).toFixed(2), parseFloat(data[0].rs[0].rows[i][6]).toFixed(2), parseFloat(data[0].rs[0].rows[i][7]).toFixed(2), parseFloat(data[0].rs[0].rows[i][8]).toFixed(2), parseFloat(data[0].rs[0].rows[i][9]).toFixed(2), parseFloat(data[0].rs[0].rows[i][10]).toFixed(2), parseFloat(data[0].rs[0].rows[i][11]).toFixed(2), parseFloat(data[0].rs[0].rows[i][12]).toFixed(2));
	 
						}		
 					}else{
 						
 					}

				} else {
					 
				}
			});
		var series = arrays;
		var seriess = arrayss;
	   	if(Id_Name == undefined || Id_Name == ''){
	   		Customized_zhu_s('min_main',series,seriess);
	   	}else{
	   		$('#' + Id_Name).empty();	   		
	   		Customized_zhu_s(Id_Name,series,seriess);
	   	}
 
}


// 柱体  rms_0062 线路统计图
function third(Id_Name){
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0062';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		var arrays = new Array();
 		var arraysc = new Array();
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
				 	var _index = 0;
					for(var i = 9; i > -1; i--){
						arraysc[_index] = data[0].rs[0].rows[i].FromCity + ' → ' + data[0].rs[0].rows[i].toArea ;
						arrays[_index] = data[0].rs[0].rows[i].TotalVolume ;
						_index++;
					}
			 
		 
				} else {
					 
				}
			});
		var series = arrays;
		var seriesc = arraysc;
	   	if(Id_Name == undefined || Id_Name == ''){
	   		Customized_zhu_h('min_main',series,seriesc);
	   	}else{
	   		$('#' + Id_Name).empty();	   		
	   		Customized_zhu_h(Id_Name,series,seriesc);
	   	}
 
}





//rms_0063 整车零担
function fourth(Id_Name){
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0063';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		var arrayz = new Array();
		var arrayl = new Array();
		var arrayh = new Array();
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
					var len = data[0].rs[0].rows.length / 10;
 
					if(data[0].rs[0].rows[0][1] != undefined){
						for(var i = 0; i < 1; i++){
							arrayz.push(parseFloat(data[0].rs[0].rows[i][1]).toFixed(2), parseFloat(data[0].rs[0].rows[i][2]).toFixed(2), parseFloat(data[0].rs[0].rows[i][3]).toFixed(2), parseFloat(data[0].rs[0].rows[i][4]).toFixed(2), parseFloat(data[0].rs[0].rows[i][5]).toFixed(2), parseFloat(data[0].rs[0].rows[i][6]).toFixed(2), parseFloat(data[0].rs[0].rows[i][7]).toFixed(2), parseFloat(data[0].rs[0].rows[i][8]).toFixed(2), parseFloat(data[0].rs[0].rows[i][9]).toFixed(2), parseFloat(data[0].rs[0].rows[i][10]).toFixed(2), parseFloat(data[0].rs[0].rows[i][11]).toFixed(2), parseFloat(data[0].rs[0].rows[i][12]).toFixed(2));
	 
						}	
					}else if(data[0].rs[0].rows[1][1] != undefined ){

						for(var i = 1; i < 2; i++){
	 
							arrayl.push(parseFloat(data[0].rs[0].rows[i][1]).toFixed(2), parseFloat(data[0].rs[0].rows[i][2]).toFixed(2), parseFloat(data[0].rs[0].rows[i][3]).toFixed(2), parseFloat(data[0].rs[0].rows[i][4]).toFixed(2), parseFloat(data[0].rs[0].rows[i][5]).toFixed(2), parseFloat(data[0].rs[0].rows[i][6]).toFixed(2), parseFloat(data[0].rs[0].rows[i][7]).toFixed(2), parseFloat(data[0].rs[0].rows[i][8]).toFixed(2), parseFloat(data[0].rs[0].rows[i][9]).toFixed(2), parseFloat(data[0].rs[0].rows[i][10]).toFixed(2), parseFloat(data[0].rs[0].rows[i][11]).toFixed(2), parseFloat(data[0].rs[0].rows[i][12]).toFixed(2));
	 
						}

					}else{
						
					}
					    for(var i = 0; i < arrayz.length; i++) {
					      arrayh[i] = arrayz[i]*1 + arrayl[i]*1;
					    }	
				} else {
					 
				}
			});
		var seriez = arrayz;
		var seriel = arrayl;
		var serieh = arrayh;
	   	if(Id_Name == undefined || Id_Name == ''){
	   		Customized_zhu_hx('min_main',seriez , seriel , serieh);
	   	}else{
	   		$('#' + Id_Name).empty();	   		
	   		Customized_zhu_hx(Id_Name,seriez , seriel , serieh);
	   	}
 
}



//全国货物流向   rms_0060 
function fifth(Id_Name){
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0060';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		var arrays = new Array();
 		var arraysc = new Array();
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
					var len = data[0].rs[0].rows.length / 10;
					
 
					for(var i = 0; i < data[0].rs[0].rows.length; i++){
						if(data[0].rs[0].rows[i].coords == '' || data[0].rs[0].rows[i].coords == undefined){
//							console.log(i);
						}else{
							var coords = data[0].rs[0].rows[i].coords.split(';');
							var coords_1 = coords[0].split(',');
							var coords_2 = coords[1].split(',');
							var coords_3 = [coords_1,coords_2];
							arrays[i] = {
								fromName:data[0].rs[0].rows[i].FromCity,
								toName:data[0].rs[0].rows[i].toArea,
								coords:coords_3
							}							
						}

					}	
			 
					 
				} else {
					 
				}
			});
			
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0069';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
	 
 
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
					var len = data[0].rs[0].rows.length / 10;
					
 
					for(var i = 0; i < data[0].rs[0].rows.length; i++){
						if(data[0].rs[0].rows[i].Location == '' || data[0].rs[0].rows[i].Location == undefined){
//							console.log(i);
						}else{
							var _Location = data[0].rs[0].rows[i].FromLocation.split(',');
 							var _Type = data[0].rs[0].rows[i].Type;
//		console.log(_Type);   // 1 发货城市 2 收货 城市 3 收发货城市 
 							if(_Type == 1 ){ //
								arraysc[i] = {
									 
									symbolSize:2,
									value:_Location,
							        itemStyle: {normal: {color:'#ff0006'}}
								}	 								
 							}else if(_Type == 2){
								arraysc[i] = {
									 
									symbolSize:2,
									value:_Location,
							        itemStyle: {normal: {color:'#f7e231'}}
								}		
 							}else{
								arraysc[i] = {
									 
									symbolSize:2,
									value:_Location,
							        itemStyle: {normal: {color:'#F58158'}}
								}		
 							}
						
						}

					}	
			 
					 
				} else {
					 
				}
			});
		var chartsName ='线路流动图';

		var series = arrays;		 
	   	var seriesc = arraysc;
//		console.log(series);
//		console.log(seriesc); 
	   	if(Id_Name == undefined || Id_Name == ''){
	   		Customized_liu('main00',series,seriesc);
	   	}else{
	   		$('#' + Id_Name).empty();	   		
	   		Customized_liu(Id_Name,series,seriesc);
	   	}
}

// 货物流通热力图     rms_0057 
function sixth(Id_Name){
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0068';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		var arrays_cs = new Array();
 		var arrays_shu = new Array();
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
					var len = data[0].rs[0].rows.length / 10;
 
 						var _index = 0;
						for(var i = 9; i > -1; i--){
							arrays_cs[_index] = data[0].rs[0].rows[i].toArea;
							arrays_shu[_index] = data[0].rs[0].rows[i].TotalVolume ;
							
							_index++;
						}
 
				} else {
					 
				}
			});
	
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0057';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		var arrays = new Array();
 
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
					var len = data[0].rs[0].rows.length / 10;

					for(var i = 0; i < data[0].rs[0].rows.length; i++){
   
						arrays[i] = {
				 
							name:data[0].rs[0].rows[i].toArea,
							value:Math.ceil(data[0].rs[0].rows[i].Total/30)
					 
						};
					}	
   
					var rowss= data[0].rs[0].rows;
					var obj={};
					rowss.forEach(function(item){
					 	obj[item.toArea]=item.To.split(',');
					})	
//					console.log(arrays_cs);	 
//					console.log(arrays_shu);	
					
				   	if(Id_Name == undefined || Id_Name == ''){
				   		Customized_re3('main00',arrays , obj ,arrays_cs ,arrays_shu);
				   	}else{
				   		$('#' + Id_Name).empty();	   		
				   		Customized_re3(Id_Name,arrays , obj ,arrays_cs ,arrays_shu);
				   	}					
					
				} else {
					 
				}
			});

	    
}



//rms_0058 客户所在城市
function seventh(Id_Name){
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0058';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		var arrays = new Array();
		var arraysc = new Array();
	   	var seriesc;
		 
		var arsr = [];
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
 //
 					if(data[0].rs[0] != undefined){
 						
 				 
						for(var i = 0; i < data[0].rs[0].rows.length; i++){
	 						
	// 						var w_time = Math.ceil(data[0].rs[0].rows[i].WillTime);
	// 						if(w_time < 0 || w_time == 0){
	// 							w_time = 0;
	// 						}else if(w_time < 24 && w_time > 0 ){
	// 							w_time = 1;
	// 						}else if(w_time > 24 && w_time < 48){
	// 							w_time = 2;
	// 						}else if(w_time > 48){
	// 							w_time = 3;
	// 						}else{
	// 							w_time = 4;
	// 						}
							arrays[i] = {
					 
								name:data[0].rs[0].rows[i].PactCode + ' ' + data[0].rs[0].rows[i].Line,
								value:data[0].rs[0].rows[i].WillTime,
						 
							};
						}	
	 
						var rowss= data[0].rs[0].rows;
						var obj={};
						rowss.forEach(function(item){
						 	obj[item.PactCode + ' ' + item.Line]=item.To.split(',');
						})	
						console.log(arrays);	 
						console.log(obj);	
					   	if(Id_Name == undefined || Id_Name == ''){
					   		Customized_re2('main00',arrays , obj);
					   	}else{
					   		$('#' + Id_Name).empty();	   		
					   		Customized_re2(Id_Name,arrays , obj);
					   	}					
 					}	else {
 						
 					}
 					
				} else {
					 
				}
			});

	    

}



//热力图   rms_0066  省份 发货量
function eighth(Id_Name){
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0066';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		var arrays = new Array();
 
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
					var len = data[0].rs[0].rows.length / 10;

					for(var i = 0; i < data[0].rs[0].rows.length; i++){
						var Total = Math.ceil(data[0].rs[0].rows[i].Total/100);
						
						arrays[i] = {
//							var str = data[0].rs[0].rows[i].toArea;
//							var i = str.indexOf("省");
//							var io = str.substr(0,i);
							name:data[0].rs[0].rows[i].toArea,
							value:data[0].rs[0].rows[i].TotalVolume,
					 
						};
 
					 
 
 					}
			 
					 
				} else {
					 
				}
			});
		var chartsName ='热力图';
				 
	   	var seriess = arrays;
 

	   	if(Id_Name == undefined || Id_Name == ''){
	   		Customized_re5('main00',seriess);
	   	}else{
	   		$('#' + Id_Name).empty();	   		
	   		Customized_re5(Id_Name,seriess );
	   	}
}


 //  第四张图     rms_0067
function nineth(Id_Name){
		var pmls = [{}];
		pmls[0].namespace = 'protocol';
		pmls[0].cmd = 'data';
		pmls[0].version = 1;
		pmls[0].id = 'rms_0067';

		var _paras = [{}];
		_paras[0].name = 'operator';
		_paras[0].value = $('#Span2').text();
	 
		pmls[0].paras = _paras;
		var arrays_CN = new Array();
		var arrays_BF = new Array();
		var arrays_FJ = new Array();
		var arrays_LD = new Array();
		var arrays_SF = new Array();
		var arrays_SH = new Array();
		var arrays_TH = new Array();
		var arrays_XH = new Array();
		var arrays_ZC = new Array();
		var arrays_ZH = new Array();
		NSF.System.Network.Ajax('/Portal.aspx',
			NSF.System.Json.ToString(pmls),
			'POST',
			false,
			function(result, data) {
				if(data[0].rs[0] != undefined) {
 					if(data[0].rs[0] != undefined){
						var len = data[0].rs[0].rows.length / 10;
						 
						for(var i = 0; i < data[0].rs[0].rows.length; i++){
							arrays_CN[i] = data[0].rs[0].rows[i].CustomerName;
							arrays_ZC[i] = (data[0].rs[0].rows[i].ZC/10000).toFixed(2);
							arrays_LD[i] = (data[0].rs[0].rows[i].LD/10000).toFixed(2);
							arrays_TH[i] = (data[0].rs[0].rows[i].TH/10000).toFixed(2);
							arrays_SH[i] = (data[0].rs[0].rows[i].SH/10000).toFixed(2);
							arrays_ZH[i] = (data[0].rs[0].rows[i].ZH/10000).toFixed(2);
							arrays_XH[i] = (data[0].rs[0].rows[i].XH/10000).toFixed(2);
							arrays_SF[i] = (data[0].rs[0].rows[i].SF/10000).toFixed(2);
							arrays_BF[i] = (data[0].rs[0].rows[i].BF/10000).toFixed(2);
							arrays_FJ[i] = (data[0].rs[0].rows[i].FJ/10000).toFixed(2);
	//                      ['整车费', '零担费', '提货费', '送货费', '装货费', '卸货费', '税费','保费','附加费']
						}	
	//					console.log(arrays);	
 					}else{
 						
 					}

				} else {
					 
				}
			});
		var chartsName ='中联达啊啊啊';
				 
 
 
	   	if(Id_Name == undefined || Id_Name == ''){
	   		Customized_zhu_p('main11',arrays_CN,arrays_ZC,arrays_LD,arrays_TH,arrays_SH,arrays_ZH,arrays_XH,arrays_SF,arrays_BF,arrays_FJ);
	   	}else{
	   		$('#' + Id_Name).empty();
	   		Customized_zhu_p(Id_Name,arrays_CN,arrays_ZC,arrays_LD,arrays_TH,arrays_SH,arrays_ZH,arrays_XH,arrays_SF,arrays_BF,arrays_FJ);
	   	}
 		

}