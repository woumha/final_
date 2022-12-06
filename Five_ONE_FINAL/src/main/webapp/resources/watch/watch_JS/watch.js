/**
 * 
 */


/* player.addClass('vjs-matrix'); */


$(document).ready(function() {


	$("link[rel=stylesheet][href*='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css']").remove();

	function getContextPath(){
		
		let path = location.href.indexOf(location.host)+location.host.length;
		
		return location.href.substring(path, location.href.indexOf('/', path+1));
	}

	let video_code = $("#video_code").val();
	
	


 	 $(".reply_cont_box").each(function(){
	        //var content = $(this).children('.content');
	        
	        var content = $(this).find('#input_reply_cont');

	        var content_txt = content.text();
	        var content_html = content.html();
	        var content_txt_short = content_txt.substring(0,100)+"...";
	        var btn_more = $('<span class="more">더보기</span>');

	        console.log(content_txt_short);
	        
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

	        console.log(content_txt_short);
	        
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
 	 
 	 
 		
 		
 		/* 대댓글 토글 버튼 */
 		$(".comment_toggle").on("click", function(){
 			
 			let toggle_img = $(this).find(".toggle");
 			
 			if(toggle_img.hasClass("open")){
 				toggle_img.attr("src", getContextPath() +"/resources/watch/watch_img/comment_close.png");
 				toggle_img.removeClass("open");
 				toggle_img.addClass("close");
 			}else{
 				toggle_img.attr("src", getContextPath() +"/resources/watch/watch_img/comment_open.png");
 				toggle_img.removeClass("close");
 				toggle_img.addClass("open");
 			}
 			
 			
 		
 		
 	 });
 
});