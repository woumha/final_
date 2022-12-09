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
	console.log('video_code >>>' +video_code);
	
	let video_option = "most";
	
	function getReply(video_code, video_option){
		console.log('댓글실행');
		console.log(video_code);
		console.log(video_option);
		$.ajax({

			url : getContextPath() +"/reply.do",
			data : {
				"video_code" : video_code,
				"video_option" : video_option
			},
			datatype : 'JSON',
			contentType : "application/json;charset=UTF-8",
			success : function(data){
				

				let reply = JSON.parse(data);

				console.log('reply>>>' +reply.datas);
				
				
				
			

				   $.each(reply.datas, function(index, item) { // 데이터 =item
				   	console.log('each 실행');
				   	console.log(item.channel_name);
				   });
				   
			},

			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}
			
		});

	}


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

 	 	
	 
	//  기본 실행 함수
	 getReply(video_code, video_option);




 		
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

		  
 
});