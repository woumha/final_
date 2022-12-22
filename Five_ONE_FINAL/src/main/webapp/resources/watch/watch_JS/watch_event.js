/**
 * 
 */
 
 $(document).ready(function(){

	let good_code = $("#good_code").val();
	console.log('goodnum > ' +good_code);
	let video_code = $("#video_code").val();


	function getContextPath(){
		
		let path = location.href.indexOf(location.host)+location.host.length;
		
		return location.href.substring(path, location.href.indexOf('/', path+1));
	}

	function changeImg(check){
		if(check > 0){
			alert('실행완료');
		}else if(check = 0){
			alert('실행 실패');
		}else{
			alert('오류');
		}
	}

	function insertGood(video_code, good_code, good_bad){
		$.ajax({

			url :  getContextPath() +"/insertGood.do",
			contentType : "application/json; charset=UTF-8",
			data : {
				"video_code" : video_code,
				"good_code" : good_code,
				"good_bad" : good_bad
			},
			success : function(data){
				console.log('insert성공');
				changeImg(data);
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});
	}

	function deleteGood(good_code){

		$.ajax({

			url :  getContextPath() +"/deleteGood.do",
			contentType : "application/json; charset=UTF-8",
			data : {
				"good_code" : good_code
			},
			success : function(data){
				console.log('delete성공');
				changeImg(data);
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});	
	}

	function updateGood(good_code, good_bad){
		
		$.ajax({

			url :  getContextPath() +"/updateGood.do",
			contentType : "application/json; charset=UTF-8",
			data : {
				"good_code" : good_code,
				"good_bad" : good_bad
			},
			success : function(data){
				console.log('update성공');
				changeImg(data);
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});			
	}




	// 댓글 더보기
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
	 
	 // 영상 설명 더보기
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
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

	 	// 드롭다운 메뉴 클릭
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
		
		// 다른곳 클릭 시 드롭다운 메뉴 닫기 
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


		// 네비게이션 클릭
		let scrollNav = $('.test').scrollLeft();
	
		$("#slide_right").on("click", function(){

			scrollNav.scrollLeft(scrollNav + 250);
		});

		$("#slide_left").on("click", function(){
			scrollNav.scrollLeft(scrollNav - 250);
		});
		
 
		// 좋아요 클릭
		$(".watch_good_btn").on("click", function(){
			console.log('좋아요 클릭!')
			if(good_code){
				console.log('좋아요if');
				let check = $(this).attr("data-value");
				if(check == 1){ // 좋아요 취소
					console.log('좋아요 취소');
					deleteGood(good_code);
				}else if(check == 2){ // 좋아요 수정
					console.log('좋아요 추가');
					updateGood(good_code, '1');
				}else{ // 좋아요 추가
					console.log('좋아요 추가')
					insertGood(video_code, good_code, '1');
				}	
			}else{
				insertGood(video_code, good_code, '1');
			}
	
		});
		
 
 
 });