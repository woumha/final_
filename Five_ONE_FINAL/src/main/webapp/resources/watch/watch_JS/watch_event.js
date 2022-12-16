/**
 * 
 */
 
 $(document).ready(function(){


 
  	 $(".reply_cont_box").each(function(){
	        //var content = $(this).children('.content');
	        
	        var content = $(this).find('#input_reply_cont');

	        var content_txt = content.text();
	        var content_html = content.html();
	        var content_txt_short = content_txt.substring(0,100)+"...";
	        var btn_more = $('<span class="more">더보기</span>');

	        $(this).append(btn_more);
	        
	        if(content_txt.length >= 100){
	            content.html(content_txt_short)
	        }
	        
	        btn_more.click(toggle_content);
	        function toggle_content(){
	            if($(this).hasClass('short')){
	                // 접기 상태
	                $(this).html('더보기');
	                content.html(content_txt_short)
	                $(this).removeClass('short');
	            }else{
	                // 더보기 상태
	                $(this).html('간략히');
	                content.html(content_html);
	                $(this).addClass('short');

	            }
	        }
	    }); 
	 
	 
 	 $(".cont_box").each(function(){
	        //var content = $(this).children('.content');
	        
	        var content = $(this).find('.cont');

	        var content_txt = content.text();
	        var content_html = content.html();
	        var content_txt_short = content_txt.substring(0,100)+"...";
	        var btn_more = $('<span class="more">더보기</span>');

	        $(this).append(btn_more);
	        
	        if(content_txt.length >= 100){
	            content.html(content_txt_short)
	        }
	        
	        btn_more.click(toggle_content);
	        function toggle_content(){
	            if($(this).hasClass('short')){
	                // 접기 상태
	                $(this).html('더보기');
	                content.html(content_txt_short)
	                $(this).removeClass('short');
	            }else{
	                // 더보기 상태
	                $(this).html('간략히');
	                content.html(content_html);
	                $(this).addClass('short');

	            }
	        }
	 });
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


		$(".dropdown_menu").on("click", function(){
		
		console.log('클릭')
		let wrap = $("#dropdown_wrap");

		if(wrap.hasClass("open_wrap")){
			console.log('if');
			wrap.removeClass("open_wrap");
		}else{
			console.log('else');
			wrap.addClass("open_wrap");
		}

		});
		
		$(document).mouseup(function(e){

		if (!$(".dropdown_wrap").is(e.target) && $(".dropdown_wrap").has(e.target).length === 0){

		$(".dropdown_wrap").removeClass("open_wrap");

		}	
		});

		$(".video_option").on("click", function(){
		video_option = $(this).attr("data-value");
		
		getReply(video_code, video_option);
		});

		$(".comment_toggle").on("click", function(){

			reply_group = $(this).attr("data-value");

			let res = getComment(video_code, reply_group);

			$(this).closest(".input_comment").append(res);


		});

		let scrollNav = document.querySelector('.scrollmenu');
		
		$("#slide_right").on("click", function(){

			scrollNav.scrollLeft += 250;
		});

		$("#slide_left").on("click", function(){
			scrollNav.scrollLeft -= 250;
		});
		
 
 
 
 
 });