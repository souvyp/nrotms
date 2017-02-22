﻿ 
 
<html>
<head>
    <meta charset="utf-8">
    <!-- 引入 ECharts 文件 -->
    <link rel="stylesheet" href="/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/show.css">
	<script type="text/javascript" src="/assets/plugins/jquery/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="/assets/plugins/jquery/jQueryRotate.js"></script>
	<script language="javascript" src="/assets/plugins/jquery/socket.io.min.js"></script>
    <script src="js/echarts.min.js"></script>
    <script src="js/wlyuan.js"></script>
    <script src="js/china.js"></script>    
    <script src="js/index2.js"></script>
	<script src="js/app.js"></script>    
    <script src="js/lie.js"></script>
	<script type="text/javascript" src="js/jquery.SuperSlide.js"></script>    	
	<script src="/assets/NSF/js/NSF.js"></script>
 	<script src="/assets/NSF/js/NSF.System.js"></script>		 	
 	<script src="/assets/NSF/js/NSF.System.Network.js"></script>    
 	<style type="text/css">
 		body{
 			background-image: url(img/bg001.jpg);
 			background-repeat: no-repeat;
 			background-size: cover;
 			margin: 0;
 			padding: 0;
 		}
 		.main1{
 		 
 			width: 3840px;
 			height: 1080px;
 		}
 		.main1 div{
 			float: left;
 			display: block;
 		 
 		}
 
 		.main2{
 			overflow: hidden;
 			width: 3840px;
 			height: 1080px;
 		}
 	
 		
 		.main3{
 			overflow: hidden;
 			width: 3840px;
 			height: 1080px;
 		}
 
 		
 		.main4{
 			overflow: hidden;
 			width: 3840px;
 			height:1080px;
 		}
 		.main5{
 			overflow: hidden;
 			width: 3840px;
 			height:1080px;
 		}
 		.hide{
 			display: none;
 		}			
 	</style>
 	<link rel="stylesheet" type="text/css" href="css/donghua.css">
</head>
<body>
<div class="cenenn">
	

	
	<div class="main1" style="width: 3840px; height: 1080px; overflow: hidden;">
		<div class="" style="width: 960px;height:540px; overflow: hidden;">
			<div id="main0_name" class="wings" style="">
					<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 10%; top: 30px; z-index: 99;">整车与零担统计图</font>
			</div>
		    <div id="main0_0" class="content-top-in" style="width: 960px;height:540px;">
		
		    </div>
		</div>

		<div class="" style="width: 960px;height:540px; overflow: hidden;">
			<div id="main0_name" class="wings" style="">
					<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 36%; top: 30px; z-index: 99;">市内与长途统计图</font>
			</div>
		    <div id="main0_1" class="content-top-in"  style="width: 960px;height:460px; margin-top: 50px; ">
		
		    </div>	
		</div>
		<div class="" style="width: 960px;height:540px; overflow: hidden;">
			<div id="main0_name" class="wings" style="">
					<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 62%; top: 10px; z-index: 99;">线路统计图(单位/方)</font>
			</div>
		    <div id="main0_2" class="content-top-in"  style="width: 960px;height:540px;">
		
		    </div>	
		</div>
		<div class="" style="width: 960px;height:540px; overflow: hidden;">
			<div id="main0_name" class="wings" style="">
					<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 85%; top: 10px; z-index: 99;"> </font>
			</div>
		    <div id="main0_3" class="content-top-in"  style="width: 960px;height:540px; ">
		
		    </div>	
		</div>
	    
		<div class="" style="width: 960px;height:540px; overflow: hidden;">
			<div id="main0_name" class="wings" style="">
					<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 1%; top: 52%;  z-index: 99;">全国货源流向图</font>
			</div>
		    <div id="main0_4" class="content-right-in"  style="width: 960px;height:540px;">
		
		    </div>	
		</div>
		<div class="" style="width: 960px;height:540px; overflow: hidden;">
			<div id="main0_name" class="wings" style="">
					<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 27%; top: 52%; z-index: 99;">城市发货量热力图</font>
			</div>
		    <div id="main0_5" class="content-bottom-in"  style="width: 960px;height:540px;">
		
		    </div>	
		</div>
		<div class="" style="width: 960px;height:540px; overflow: hidden;">
			<div id="main0_name" class="wings" style="">
					<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 52%; top: 52%; z-index: 99;">货物在途信息图</font>
			</div>
		    <div id="main0_6" class="wings"  style="width: 960px;height:540px;">
		
		    </div>
		</div>
		<div class="" style="width: 960px;height:540px; overflow: hidden;">
			<div id="main0_name" class="wings" style="">
					<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 77%; top: 52%; z-index: 99;">省份发货量热力图</font>
			</div>
		    <div id="main0_7" class="wings"  style="width: 960px;height:540px;">
		
		    </div>	
		</div>

	    
	    
	</div>
 
	<div class="main2 hide">
		<div class="" style="float: left;width: 960px;height: 1080px;">
			<div class="" style="width: 960px;height:540px; overflow: hidden;">
				<div id="main51_name" class="wings" style="">
						<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 1%; top: 10px;  z-index: 99;">全国货源流向图</font>
				</div>
			    <div id="main1_0" onclick="huan_1()"  class="content-top-in"  style=" width: 960px;height:540px; ">
			
			    </div>
			</div>

			<div class="" style="width: 960px;height:540px; overflow: hidden;">
				<div id="main51_name" class="wings" style="">
						<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 1%; top: 50.5%;  z-index: 99;">城市发货量热力图</font>
				</div>
			    <div id="main1_1" onclick="huan_2()"   class="content-bottom-in"  style=" width: 960px;height:540px;  ">
			
			    </div>	
			</div>
		</div>
		<div class=" " style="float: left; width: 1920px;height:1080px;">
		    <div id="main51_name" class="object-opacity-hide wings" style="">
				<font class="name_h51" style="font-size: 60px; height: 80px; position: absolute; color: #FFFFFF; left: 45%; top: 60px; z-index: 99;">全国货源流向图</font>
		    </div>
		    <div id="min_main51"  class="wings"  style=" width: 1920px;height:880px; margin: 100px 0px;">
		
		    </div>	
		</div>
	    
		<div class="" style="float: left;width: 960px;height: 1080px;">
			<div class="" style="width: 960px;height:540px; overflow: hidden;">
				<div id="main51_name" class="wings" style="">
						<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 77%; top: 10px;  z-index: 99;">货物在途信息图</font>
				</div>
			    <div id="main1_2" onclick="huan_3()"  class="content-top-in"   style=" width: 960px;height:540px; ">
			
			    </div>		
			</div>
			<div class="" style="width: 960px;height:540px; overflow: hidden;">
				<div id="main51_name" class="wings" style="">
						<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 77%; top: 52%;  z-index: 99;">省份发货量热力图</font>
				</div>
			    <div id="main1_3" onclick="huan_4()"  class="content-bottom-in"    style=" width: 960px;height:540px; ">
			
			    </div>		
			</div> 
		</div>	
	</div>
	 
	<div class="main3 hide">
		<div class="" style="float: left;width: 960px;height: 1080px;">
			<div class="" style="width: 960px;height:540px; overflow: hidden;">
				<div id="main52_name" class="wings" style="">
						<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 1%; top: 10px;  z-index: 99;"> </font>
				</div>
			    <div id="main1_4" onclick="huan_5()"  class="content-top-in"  style=" width: 960px;height:540px; ">
			
			    </div>
			</div>

			<div class="" style="width: 960px;height:540px; overflow: hidden;">
				<div id="main52_name" class="wings" style="">
						<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 10%; top: 52%;  z-index: 99;">市内与长途统计图</font>
				</div>
			    <div id="main1_5" onclick="huan_6()"   class="content-bottom-in"  style=" width: 960px;height:540px;  ">
			
			    </div>	
			</div>

		</div>
		<div class=" " style="float: left; width: 1920px;height:1080px;">
		    <div id="main52_name" class="object-opacity-hide wings" style="">
				<font class="name_h52" style="font-size: 60px; height: 80px; position: absolute; color: #FFFFFF; left: 45%; top: 60px; z-index: 99;"> </font>
		    </div>
		    <div id="min_main52"  class="wings"  style=" width: 1920px;height:1000px; margin-top: 80px; ">
		
		    </div>	
		</div>
	    
		<div class="" style="float: left;width: 960px;height: 1080;">
			<div class="" style="width: 960px;height:540px; overflow: hidden;">
				<div id="main52_name" class="wings" style="">
						<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 87%; top: 10px;  z-index: 99;">线路统计图(单位/方)</font>
				</div>
			    <div id="main1_6" onclick="huan_7()"  class="content-top-in"   style=" width: 960px;height:540px; ">
			
			    </div>		
			</div>
			<div class="" style="width: 960px;height:540px; overflow: hidden;">
				<div id="main52_name" class="wings" style="">
						<font style="font-size: 20px; color: #FFFFFF; position: absolute; left: 87%; top: 52%;  z-index: 99;">整车与零担统计图</font>
				</div>
			    <div id="main1_7" onclick="huan_8()"   class="content-bottom-in"    style=" width: 960px;height:540px; ">
			
			    </div>		
			</div> 

		</div>	
	</div>

	<div class="main4 hide">
		<div class="" style=" float: left; width: 1920px;height:1080px;" class="object-opacity-hide wings" >
		    <div id="main40_name"style="">
				<font class="name_h40" style="font-size: 60px; height: 80px; position: absolute; color: #FFFFFF; left: 20%; top: 60px; z-index: 99;">整车与零担统计图</font>
		    </div>
		    <div id="main4_0" style=" width: 1920px;height:1000px; margin-top: 80px; ">
		
		    </div>
		   
		</div>
		<div class="" style=" float: left; width: 1920px;height:1080px;" class="content-right-in" >
		    <div id="main41_name"style="" class="object-opacity-hide wings" >
				<font class="name_h41" style="font-size: 60px; position: absolute; color: #FFFFFF; left: 70%; top: 60px; z-index: 99;">全国货物流向图</font>
		    </div>
		    <div id="main4_1" style=" width: 1920px;height:1080px; " class="content-right-in">
		
		    </div>	
		</div>
	</div>

	<div class="main5 hide">
		<div class="" style=" float: left; width: 1920px;height:1080px;" class="object-opacity-hide wings" >
		    <div id="main50_name"style="">
				<font class="name_h5_1" style="font-size: 60px; height: 80px; position: absolute; color: #FFFFFF; left: 20%; top: 60px; z-index: 99;">整车与零担统计图</font>
		    </div>
		    <div id="main5_1" style=" width: 1920px;height:1080px; ">
		
		    </div>
		   
		</div>
	</div>
	
	<div class="main9 hide">
 			<div>
 				<div class="show_title" style="padding-top: 30px; height: 150px;">
 					<div class="show_title_left">
 						 
 					</div>			 
 					<font style="font-family: '微软雅黑'; font-size: 60px;">公司总运输量报表</font>
 					<div class="show_title_right">
						<form class="show_title_right_f" name='jsfrm'>
							<input style="" readonly="" type=text name='face' size=34 value=''>
						</form>
 					</div>
 				</div>
            	<div class="clear"></div> 				
 				<div class="show_a_content">
	 				<div class="show_title" style="background: #010d6f; margin-bottom: 30px;border: solid 1px #106667;">
	 					<div class="show_title_left2">
	 							今日 
	 					</div>			 
	 					<div class="show_title_left2">
	 							本月 
	 					</div>		
	 					<div class="show_title_left2">
	 							今年 
	 					</div>	
	 				</div>
					<div class="show_a_today"><!--今日-->
			 
						<div style="margin-bottom: 20px;">
							<div class="show_c" style="margin: 0 auto; width:100%;height:258px">
								<div class="backWhite has-feedback">
	 
	                                    <ul class="clearfix tableTitle_a tableTitle8 marTBLR0">
	       									 
											<li>线路名称</li>
											<li>订单总数</li>
											 
											<li>总重量(吨)</li>
											<li>总体积(方)</li>
	                                    </ul> 
	                                
	                                    <div class="slideTxtBox_t1 leftLoop">
											<div class="hd hd_49 hide">
												<ul></ul> 
											</div>	                                    	
		                                    <div class="bd bd_49">
												<ul class="tableCont_bd_49">
 
												</ul>                                 
			                                </div>		                        			                                    
		                                </div>		                                
								</div>
							</div>							
							
							
						</div>
						
						<div style="margin-bottom: 20px;">
							<div class="show_c" style="margin: 0 auto; width:100%;height:258px">
								<div class="backWhite has-feedback">
	 
	                                    <ul class="clearfix tableTitle_a tableTitle8 marTBLR0">
	       									 
											<li>客户名称</li>
											<li>订单总数</li>
											 
											<li>总重量(吨)</li>
											<li>总体积(方)</li>
	                                    </ul> 
	                                    <div class="slideTxtBox_t2 leftLoop">
											<div class="hd hd_52 hide">
												<ul></ul> 
											</div>	                                    	
		                                    <div class="bd bd_52">
												<ul class="tableCont_bd_52">
													
												</ul>                                 
			                                </div>		                        			                                    
		                                </div>
								</div>
							</div>							
							
							
						</div>
						
						<div>
							<div class="show_c" style="margin: 0 auto; width:100%;height:258px">
								<div class="backWhite has-feedback">
	 
	                                    <ul class="clearfix tableTitle_a tableTitle8 marTBLR0">
	       									 
											<li>承运商名称</li>
											<li>订单总数</li>
											 
											<li>总重量(吨)</li>
											<li>总体积(方)</li>
	                                    </ul> 
	                                    <div class="slideTxtBox_t leftLoop">
											<div class="hd hd_55 hide">
												<ul></ul> 
											</div>	                                    	
		                                    <div class="bd bd_55">
												<ul class="tableCont_bd_55">
													
												</ul>                                 
			                                </div>		                        			                                    
		                                </div>
								</div>
							</div>							
							
							
						</div>
						 
					</div>
					
					<!--本月-->
					<div class="show_a_month"><!--本月-->
						 
						<div style="margin-bottom: 20px;">
							<div class="show_c" style="margin: 0 auto; width:100%;height:258px">
								<div class="backWhite has-feedback">
	 
	                                    <ul class="clearfix tableTitle_a tableTitle8 marTBLR0">
	       									 
											<li>线路名称</li>
											<li>订单总数</li>
											 
											<li>总重量(吨)</li>
											<li>总体积(方)</li>
	                                    </ul> 
	                                    <div class="slideTxtBox_m1 leftLoop">
											<div class="hd hd_48 hide">
												<ul></ul> 
											</div>	                                    	
		                                    <div class="bd bd_48">
												<ul class="tableCont_bd_48">
													
												</ul>                                 
			                                </div>		                        			                                    
		                                </div>
								</div>
							</div>							
							
							
						</div>
						
						<div style="margin-bottom: 20px;">
							<div class="show_c" style="margin: 0 auto; width:100%;height:258px">
								<div class="backWhite has-feedback">
	 
	                                    <ul class="clearfix tableTitle_a tableTitle8 marTBLR0">
	       									 
											<li>客户名称</li>
											<li>订单总数</li>
											 
											<li>总重量(吨)</li>
											<li>总体积(方)</li>
	                                    </ul> 
 
	                                    <div class="slideTxtBox_m2 leftLoop">
											<div class="hd hd_51 hide">
												<ul></ul> 
											</div>	                                    	
		                                    <div class="bd bd_51">
												<ul class="tableCont_bd_51">
													
												</ul>                                 
			                                </div>		                        			                                    
		                                </div>		                                
								</div>
							</div>							
							
							
						</div>
						
						<div>
							<div class="show_c" style="margin: 0 auto; width:100%;height:258px">
								<div class="backWhite has-feedback">
	 
	                                    <ul class="clearfix tableTitle_a tableTitle8 marTBLR0">
	       									 
											<li>承运商名称</li>
											<li>订单总数</li>
											 
											<li>总重量(吨)</li>
											<li>总体积(方)</li>
	                                    </ul> 
	                                    <div class="slideTxtBox_m3 leftLoop">
											<div class="hd hd_54 hide">
												<ul></ul> 
											</div>	                                    	
		                                    <div class="bd bd_54">
												<ul class="tableCont_bd_54">
													
												</ul>                                 
			                                </div>		                        			                                    
		                                </div>
								</div>
							</div>							
							
							
						</div>
						 	
					</div>
					
					<!--今年-->
					<div class="show_a_year"><!--今年-->
						 
						<div style="margin-bottom: 20px;">
							<div class="show_c" style="margin: 0 auto; width:100%;height:258px">
								<div class="backWhite has-feedback">
	 
	                                    <ul class="clearfix tableTitle_a tableTitle8 marTBLR0">
	       									 
											<li>线路名称</li>
											<li>订单总数</li>
											 
											<li>总重量(吨)</li>
											<li>总体积(方)</li>
	                                    </ul> 
	                                    <div class="slideTxtBox_y1 leftLoop">
											<div class="hd hd_47 hide">
												<ul></ul> 
											</div>	                                    	
		                                    <div class="bd bd_47">
												<ul class="tableCont_bd_47"></ul>                                 
			                                </div>		                        			                                    
		                                </div>
								</div>
							</div>							
							
							
						</div>
						
						<div style="margin-bottom: 20px;">
							<div class="show_c" style="margin: 0 auto; width:100%;height:258px">
								<div class="backWhite has-feedback">
	 
	                                    <ul class="clearfix tableTitle_a tableTitle8 marTBLR0">
	       									 
											<li>客户名称</li>
											<li>订单总数</li>
											 
											<li>总重量(吨)</li>
											<li>总体积(方)</li>
	                                    </ul> 
	                                    <div class="slideTxtBox_y2 leftLoop">
											<div class="hd hd_50 hide">
												<ul></ul> 
											</div>	                                    	
		                                    <div class="bd bd_50">
												<ul class="tableCont_bd_50">
													
												</ul>                                 
			                                </div>		                        			                                    
		                                </div>
								</div>
							</div>							
							
							
						</div>
						
						<div>
							<div class="show_c" style="margin: 0 auto; width:100%;height:258px">
								<div class="backWhite has-feedback">
	 
	                                    <ul class="clearfix tableTitle_a tableTitle8 marTBLR0">
	       									 
											<li>承运商名称</li>
											<li>订单总数</li>
											 
											<li>总重量(吨)</li>
											<li>总体积(方)</li>
	                                    </ul> 
	                                    <div class="slideTxtBox_y3 leftLoop">
											<div class="hd hd_53 hide">
												<ul></ul> 
											</div>	                                    	
		                                    <div class="bd bd_53">
												<ul class="tableCont_bd_53">
													
												</ul>                                 
			                                </div>		                        			                                    
		                                </div>
								</div>
							</div>							
							
							
						</div>
						 				
					</div>					
 				</div> 				
 				
 			</div>
          
        
            <div class="clear"></div>

        </div>








</div>


<!--
<button onclick="huan(1)" style=" position: absolute; top:500px ; left: 400px; width: 100px; height: 100px;"> qwqwq</button>

<button onclick="huan(2)" style=" position: absolute; top:500px ; left: 600px; width: 100px; height: 100px;"> sasa</button>

<button onclick="huan(3)" style=" position: absolute; top:500px ; left: 800px; width: 100px; height: 100px;"> xxzxzx</button>

-->


<span id="Span2" style="display:none">11029</span>
	
	
	
</body>
    <script type="text/javascript">
//	nineth('main4_0');    
 
//	nineth('main0_3');    
//	
//	second('main0_1');  //市内
//	
//	third('main0_2');   //线路
//	
//	fourth('main0_0');   
// 
//	fifth('main0_4');
//	
//	sixth('main0_5');
//		
//	seventh('main0_6');
//			
//	eighth('main0_7');
//		setTimeout("APP.init8()",1040);
//		setTimeout("APP.init5_1()",2300);
//		setTimeout("APP.init5_2()",7300);
//		setTimeout("APP.init2()",1000);
		APP.init8();
   		APP.init5_1();	
		APP.init5_2();	
		APP.init2();


 		function huan(index){
 
 			$(".main"+index).siblings().addClass('hide');
 			$(".main"+index).removeClass('hide');

 		}
 		
 
		function huan_1(){	 
			fifth('min_main51');	
		 
			$('.name_h51').text('全国货源流向图');
		}
		function huan_2(){	 
			sixth('min_main51');	 
			$('.name_h51').text('城市发货量热力图');
		}	
		function huan_3(){	 
			seventh('min_main51');	 
			$('.name_h51').text('货物在途信息图');
		}	
		function huan_4(){	 
			eighth('min_main51');	
			$('.name_h51').text('省份发货量热力图');
		}		 
	
		function huan_5(){	 
			nineth('min_main52');	
		 
			$('.name_h52').text('');
		}
		function huan_6(){	 
			second('min_main52');	 
			$('.name_h52').text('市内与长途统计图');
		}	
		function huan_7(){	 
			third('min_main52');	 
			$('.name_h52').text('线路统计图(单位/方)');
		}	
		function huan_8(){	 
			fourth('min_main52');	
			$('.name_h52').text('整车与零担统计图');
		}	
 
		function huan_z1(){	 
			nineth('main4_0');	
		 
			$('.name_h40').text(' ');
		}
		function huan_z2(){	 
			second('main4_0');	
		 
			$('.name_h40').text('市内与长途统计图');
		}
		function huan_z3(){	 
			third('main4_0');	
		 
			$('.name_h40').text('线路统计图(单位/方)');
		}
		function huan_z4(){	 
			fourth('main4_0');	
		 
			$('.name_h40').text('整车与零担统计图');
		}

		function huan_y1(){	 
			fifth('main4_1');	
		 
			$('.name_h41').text('全国货源流向图');
		}
		function huan_y2(){	 
			sixth('main4_1');	
		 
			$('.name_h41').text('城市发货量热力图');
		}
		function huan_y3(){	 
			seventh('main4_1');	
		 
			$('.name_h41').text('货物在途信息图');
		}
		function huan_y4(){	 
			eighth('main4_1');	
		 
			$('.name_h41').text('省份发货量热力图');
		}


 
		function huan_51(){	 
			nineth('main5_1');	
		 
			$('.name_h5_1').text(' ');
		}
		function huan_52(){	 
			second('main5_1');	
		 
			$('.name_h5_1').text('市内与长途统计图');
		}
		function huan_53(){	 
			third('main5_1');	
		 
			$('.name_h5_1').text('线路统计图(单位/方)');
		}
		function huan_54(){	 
			fourth('main5_1');	
		 
			$('.name_h5_1').text('整车与零担统计图');
		}

		function huan_55(){	 
			fifth('main5_1');	
		 
			$('.name_h5_1').text('全国货源流向图');
		}
		function huan_56(){	 
			sixth('main5_1');	
		 
			$('.name_h5_1').text('城市发货量热力图');
		}
		function huan_57(){	 
			seventh('main5_1');	
		 
			$('.name_h5_1').text('货物在途信息图');
		}
		function huan_58(){	 
			eighth('main5_1');	
		 
			$('.name_h5_1').text('省份发货量热力图');
		}

function huan9(){
	 			$(".main9").siblings().addClass('hide');
	 			$(".main9").removeClass('hide');
	 			
 			if($(".tableCont_bd_47").text() != ''){
 
 			}else{
				//分公司
				b_today();
				b_month();
				b_year();
				//客户
				c_today();
				c_month();
				c_year();
				//承运商
				f_today();
				f_month();
				f_year();
 			}
}
 








var _socket = io.connect( "http://106.14.17.157:8086/" );

	if (typeof(_socket) != "undefinded" || _socket != null ) {
		_DoluckyIn('watch_tv', 'NDT lucky Controller');			//登录

		_socket.on ( 'connection', function()
		{
			var _log = 'connected';
			$("[name='log']").val( _log );

			_DoluckyIn('watch_tv', 'NDT lucky Shower');
		});
		_socket.on( 'command', function(data)
		{
			var _from = data.from;
			var _to = data.to;
			var _index = data.message[0].num_index;
			var _indexx = data.message[0].gender;
			console.log(_index,_indexx);
			if(_indexx == '9' &&  _index == "9"){
				huan9();	
			}else if(_indexx != undefined && _index == ""){
				setTimeout("huan_"+_indexx+"()",100);
			}else if(_indexx == 'undefined' && _index != undefined){
				huan(_index);	
			}else{
				huan(_index);
				setTimeout("huan_"+_indexx+"()",100);
			}

 			
		});
		_socket.on( 'status', function(data)
		{
			var _log = $("[name='log']").val();
			_log += '\r\n' + JSON.stringify( data);
			$("[name='log']").val( _log );
		});
		_socket.on( 'logout', function(data)
		{
			var _log = $("[name='log']").val();
			_log += '\r\n' + JSON.stringify( data);
			$("[name='log']").val( _log );
		});
		_socket.on( 'login', function(data)
		{
			var _log = $("[name='log']").val();
			_log += '\r\n' + JSON.stringify( data);
			$("[name='log']").val( _log );
		});
	}
 
	function _DoClear()
	{
		$("[name='log']").val("");
	}

	function _DoStatus( id )
	{
		if (_socket)
		{
			_socket.emit( 'status', '{"cmd":"connections"}' );
		}
	}

	function _DoluckyOut( id )
	{
		if (_socket)
		{
			_socket.emit( 'logout', '{"id":"' + id + '"}' );
		}	
	}

	function _DoluckyIn( id, desc)
	{
		if (_socket)
		{
			_socket.emit( 'login', '{"id":"' + id + '","name":"' + desc + '"}' );
		}
	}

		
		
    </script>  
</html>