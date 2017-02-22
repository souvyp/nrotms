// 
//$(document).on("scroll",function(){
//	if($(document).scrollTop()>200){ 
//		$(".nav").stop().animate({
//			height:'50px', backgroundColor: "#2c2c2c" 
//		});
//	 
//		$(".nav-logo img").stop().animate({
//			height:'45px'
//		});
//		$(".nav-list").stop().animate({
//			height:'50px',lineHeight:'50px'
//		});		
//	 		
//	}else{
//		$(".nav").stop().animate({
//			height:'105px',backgroundColor:'rgba(0,0,0,0)'
//		});
//		$(".nav-logo img").stop().animate({
//			height:'91px'
//		});		
//		$(".nav-list").stop().animate({
//			height:'105px',lineHeight:'110px'
//		});				
//	}		
//});

 
$(document).on('mousemove', '.subNav_c li', function() {
//	alert($(this).index());
	var index = $(this).index();
	$(this).siblings().removeClass('active_h');
 	$(this).addClass('active_h');

});