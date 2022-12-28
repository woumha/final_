/**
 * 
 */

let feedback_code;

function getContextPath(){
		
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}

function getSession(){

	let res;
	$.ajax({
		url : getContextPath() +"/getSession.do",
		async : false,
		ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		success : function(data){
			if(data){
				res = data;
			}
		},
		error : function(request, status, error){
			console.log("code: " + request.status);
			console.log("message: " + request.responseText);
			console.log("error: " + error);
		}

	});
	return res;
}

 
$(document).ready(function(){

	

	let good_code = $("#good_code").val();
	let video_code = $("#video_code").val();
	let channel_code = $("#channel_code").val();
	let subscribe_code = $("#subscribe_code").val();
	let profil = $("#profil").val();
	let session;
	let feedback_code;	
	let resultGood;




	function closePlaylist(){
		$(".savePlaylist_container").removeClass("block");
		$(".newPlaylist_input_box").css("display", "none");	
		$(".newPlaylist_btn").css("display", "block");	
		$("#input_bundleList").empty(); //재생목록 초기화
		$("#playlist_open").val("2");
		$("#playlist_title").val("");
		$("#playlist_btn_text").text("공개 여부");
	}

	function showPopover(popover){

		popover.popover("enable");
		popover.popover("show");

		setTimeout(function(){
			popover.popover("hide");
		}, 1000);
	}

	function addPlaylist(video_code, playlist_code, playlist_title){

		$.ajax({
			url :  getContextPath() +"/addPlaylist.do",
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"video_code": video_code,
				"playlist_code" : playlist_code,
				"playlist_title" : playlist_title
			},
			success : function(data){
				console.log('리스트등록성공');
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}
		});

	}

	function deletePlaylist(video_code, playlist_code){

		$.ajax({
			url :  getContextPath() +"/deletePlaylist.do",
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"video_code": video_code,
				"playlist_code" : playlist_code
			},
			success : function(data){
				console.log('리스트삭제성공');
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}
		});		
	}


	function getBundleList(video_code){

		$.ajax({
			url :  getContextPath() +"/getBundleList.do",
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			async: false,
			data : {
				"video_code": video_code
			},
			success : function(data){
				let div = "";

					$(data).each(function(){

						div += "<label class='list-group-item list_group watch'>";
						if(this.check == 0){
							div += "<input name='addPlaylist' class='form-check-input me-1' type='checkbox' value='"+this.bundle_code+"'>";
						}else{
							div += "<input name='addPlaylist' class='form-check-input me-1' type='checkbox' value='"+this.bundle_code+"' checked>";
						}
						div += this.bundle_title;
						div += "</label>"					
					});

					$("#input_bundleList").append(div);
				
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});		
	}

	function newPlaylist(playlist_title, playlist_open){


		$.ajax({
			url :  getContextPath() +"/newPlaylist.do",
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"playlist_title" : playlist_title,
				"playlist_open" : playlist_open
			},
			success : function(){
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});

	};




	function changeValue(tag, good_img, bad_img, name, good){
		
		let check = tag.attr("data-value");
		let good_cnt = tag.find(".good_cnt");	

		if(name == "good"){
			if(check == 1){ // 좋아요 취소
				good_img.attr("src", getContextPath() +"/resources/watch/watch_img/good_icon.svg");
				tag.attr("data-value", 0);
			}else if(check == 2){ // 좋아요 수정
				good_img.attr("src", getContextPath() +"/resources/watch/watch_img/good_icon_selected.svg");
				bad_img.attr("src", getContextPath() +"/resources/watch/watch_img/bad_icon.svg");
				tag.attr("data-value", 1);
			}else{ // 좋아요 추가
				good_img.attr("src", getContextPath() +"/resources/watch/watch_img/good_icon_selected.svg");
				tag.attr("data-value", 1);
			}


		}else if(name == "bad"){
			if(check == 2){ // 싫어요 취소
				bad_img.attr("src", getContextPath() +"/resources/watch/watch_img/bad_icon.svg");
				tag.attr("data-value", 0);
			}else if(check == 1){ // 싫어요 수정
				good_img.attr("src", getContextPath() +"/resources/watch/watch_img/good_icon.svg");
				bad_img.attr("src", getContextPath() +"/resources/watch/watch_img/bad_icon_selected.svg");
				tag.attr("data-value", 2);
			}else{ // 싫어요 추가
				bad_img.attr("src", getContextPath() +"/resources/watch/watch_img/bad_icon_selected.svg");
				tag.attr("data-value", 2);
			}
		}
		if(video_code != '' || null || undefined || 0 || NaN){
			good_cnt.text(good);
		}
		
	}

	function insertSubscribe(channel_code){

		let resl
		$.ajax({

			url :  getContextPath() +"/insertSubscribe.do",
			async : false,
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"channel_code" : channel_code,
			},
			success : function(data){
				res = data;
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}
		});

		return res;
	}

	function deleteSubscribe(subscribe_code){
		
		$.ajax({

			url :  getContextPath() +"/deleteSubscribe.do",
			async : false,
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"subscribe_code" : subscribe_code,
			},
			success : function(data){
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}
		});

	}

	function insertGood(video_code, good_bad){

		let res;

		$.ajax({

			url :  getContextPath() +"/insertGood.do",
			async : false,
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"video_code" : video_code,
				"good_bad" : good_bad
			},
			success : function(data){
				res = data;
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}
		});

		return res;
	}

	function deleteGood(video_code, good_code, good_bad){

		let res;
		$.ajax({

			url :  getContextPath() +"/deleteGood.do",
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"video_code" : video_code,
				"good_code" : good_code,
				"good_bad" : good_bad
			},
			async: false,
			success : function(data){
				res = data;

			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});	
		return res;
	}

	function updateGood(video_code, good_code, good_bad){
		
		let res;
		$.ajax({

			url :  getContextPath() +"/updateGood.do",
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"video_code" : video_code,
				"good_code" : good_code,
				"good_bad" : good_bad
			},
			async: false,
			success : function(data){
				res = data;
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});		
		return res;	
	}

	function insertFeedback(video_code, reply_code, feedback_good){

		let res;

		$.ajax({

			url :  getContextPath() +"/insertFeedback.do",
			async : false,
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"video_code" : video_code,
				"reply_code" : reply_code,
				"feedback_good" : feedback_good
			},
			success : function(data){
				res = data;
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});
		return res;
	}

	function deleteFeedback(reply_code, feedback_code, feedback_good){

		let res;

		$.ajax({

			url :  getContextPath() +"/deleteFeedback.do",
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			async: false,
			data : {
				"reply_code" : reply_code,
				"feedback_code" : feedback_code,
				"feedback_good" : feedback_good
			},
			success : function(data){
				res = data;
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});

		return res;
	}

	function updateFeedback(reply_code, feedback_code, feedback_good){

		let res;

		$.ajax({

			url :  getContextPath() +"/updateFeedback.do",
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			async: false,
			data : {
				"reply_code" :reply_code,
				"feedback_code" : feedback_code,
				"feedback_good" : feedback_good
			},
			success : function(data){
				res = data;
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});

		return res;
	}


	function inputReply(video_code, reply_cont, reply_comment){

		$.ajax({
			url : getContextPath() +"/inputReply.do",
			data : {
				"video_code" : video_code,
				"reply_cont" : reply_cont,
				"reply_comment" : reply_comment
			},
			async : false,
			success : function(data){

				let div = "";

				let reply_cont = data.reply_cont.replaceAll("\\n","<br>");

				div += "<div class='reply_box card_a' data-value='" +data.check_good+ "' data-code='" +data.check_code+ "'>";
				
				div += "<input type='hidden' class='reply_code' name='reply_code' value='" +data.reply_code+ "'>";

				div += "<div class='item_a'>";
				div += "<div class='reply_wrap'>";
				div += "<div class='input_profile'><img class='profile channel-backcolor' src='" +getContextPath()+ "/resources/img/channel_profile/" +data.channel_profil+ "'></div></div></div>";

				div += "<div class='input_reply item_a'>";

				div += "<div id='input_reply_writer' class='writer_info'>";
				div += "<span class='reply_writer'>" +data.channel_name+"</span>";
				div += "<span class='reply_date'>" +data.reply_regdate+ "</span>";
				div += "</div>";

				div += "<div class='reply_cont_box'>";
				div += "<div id='input_reply_cont'>" +reply_cont+ "</div>";
				//div += "<div id='input_reply_cont'>" +repalceEnter(this.reply_cont)+ "</div>";
				div += "</div>";

				div += "<div class='reply_action_box'>";
				div += "<div class='toolbar_wrap card_a'>";

				div += "<div class='reply_good_btn'><div class='card_b'>";
				if(data.check_good == 1){
					div += "<img class='reply_good' src='" +getContextPath()+ "/resources/watch/watch_img/good_icon_selected.svg'>";
				}else{
					div += "<img class='reply_good' src='" +getContextPath()+ "/resources/watch/watch_img/good_icon.svg'>";
				}
				div += "<div>" +data.reply_good+ "</div></div></div>" //reply_goodbtn;

				div += "<div class='reply_bad_btn'>";
				if(data.check_good == 2){
					div += "<img class='reply_bad' src='" +getContextPath()+ "/resources/watch/watch_img/bad_icon_selected.svg'>";
				}else{
					div += "<img class='reply_bad' src='" +getContextPath()+ "/resources/watch/watch_img/bad_icon.svg'>";
				}
				div += "</div>"; // reply_bad_btn

				div += "<div class='reply_comment_btn'>답글</div>";
				div += "</div>"; // .toolbar_wrap
				div += "</div>"; // .reply_action_box
				
				div += "</div>"; // .input_reply


				div += "<div class='render_box'><div class='render_wrap'><button class='render'><img class='render_icon' src='" +getContextPath()+ "/resources/watch/watch_img/render_icon.png'></button></div></div>";
				div += "</div>"; // .reply_box

				if(data.reply_comment == 1){

					div += "<div class='comment_box'>";
					div += "<div class='comment_menu card_c'><div class='comment_btn close'><button class='comment_toggle card_a' value='" +data.reply_group+ "'><img class='toggle open' src='" +getContextPath()+ "/resources/watch/watch_img/comment_open.png'>";
					div += "<div class='comment_count'>답글" +data.comment_count+ "개</div>";
					div += "</button></div>"
					div += "</div>" // .comment_wrap
					div += "<div class='input_comment'></div>";
					div += "</div>"; //.comment_box
				}

				$("#input_reply_box").prepend(div);
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}			

		})
	}

	// 대댓글 입력 함수
	function inputComment(video_code, reply_cont, reply_comment, reply_group, reply_code){

		let div = "";
		$.ajax({
			url : getContextPath() +"/inputReply.do",
			data : {
				"video_code" : video_code,
				"reply_cont" : reply_cont,
				"reply_comment" : reply_comment,
				"reply_group" : reply_group,
				"reply_code" : reply_code
			},
			async : false,
			success : function(data){
					
					let reply_cont = data.reply_cont.replaceAll("\\n","<br>");

					div += "<div class='comment_wrap card_a' data-value='" +data.check_good+ "' data-code='" +data.check_code+ "'>"; //card
					div += "<input type='hidden' class='reply_code' name='reply_code' value='" +data.reply_code+ "'>";
					// commnet_wrap(item1)
					div += "<div class='profile'>"; //.comment_wrap(item1)
					div += "<img class='profile channel-backcolor' src='" +getContextPath()+ "/resources/img/channel_profile/" +data.channel_profil+ "'>";
					div += "</div>"; //.profile end
					//comment_wrap(item2)
					div += "<div class='comment_card card_c'>"; //card
					// comment_card(item1)
					div += "<div id='input_comment_writer' class='writer_info'>"; 
					div += "<span class='reply_writer'>" +data.channel_name+ "</span>";
					div += "<span class='reply_date'>" +data.reply_regdate+ "</span>";	
					div += "</div>"; //#input_comment_writer end
					// comment_card(item2)
					div += "<div class='reply_cont_box'>"; 
					div += "<div id='input_comment_cont'>" +reply_cont+ "</div>";
					div += "</div>"; //.reply_cont_box end
					// comment_card(item3)
					div += "<div class='reply_action_box'>"; 
					div += "<div class='toolbar_wrap card_a'>" //card
					// toolbar(item1)
					div += "<div class='comment_good_btn'><div class='card_b'>"; 
					if(data.check_good == 1){
						div += "<img class='reply_good' src='" +getContextPath()+ "/resources/watch/watch_img/good_icon_selected.svg'>";
					}else{
						div += "<img class='reply_good' src='" +getContextPath()+ "/resources/watch/watch_img/good_icon.svg'>";
					}
					div += "<div>" +data.reply_good+ "</div>";
					div += "</div></div>"; //.reply_good_btn, .card_b
					// toolbar(item2)
					div += "<div class='comment_bad_btn'>"; 
					if(data.check_good == 2){
						div += "<img class='reply_bad' src='" +getContextPath()+ "/resources/watch/watch_img/bad_icon_selected.svg'>";
					}else{
						div += "<img class='reply_bad' src='" +getContextPath()+ "/resources/watch/watch_img/bad_icon.svg'>";
					}
					div += "</div>"; // .reply_bad_btn end
					div += "</div>"; //.toolbar_wrap end
					div += "</div>"; //.reply_action_box end

					div += "</div>"; //.comment_card end

					// comment_wrap(item3)
					div += "<div class='render_box'>";
					div += "<div class='render_wrap'>";
					div += "<button class='render'><img class='render_icon' src='" +getContextPath()+ "/resources/watch/watch_img/render_icon.png'></button>";
					div += "</div>"; // .render_wrap end
					div += "</div>"; // .render_box end
									
					div += "</div>"; // .comment_wrap		

			}
		})
		return div;

		
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
 
	 // 기본 실행 함수
	 session = getSession();
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

	 	// 드롭다운 메뉴 클릭
		$(".dropdown_menu").on("click", function(){
		
		let wrap = $("#dropdown_wrap");

		if(wrap.hasClass("open_wrap")){
			wrap.removeClass("open_wrap");
		}else{
			wrap.addClass("open_wrap");
		}

		});
		
		// 다른곳 클릭 시 드롭다운 메뉴 닫기 
		$(document).mouseup(function(e){

		if (!$(".dropdown_wrap").is(e.target) && $(".dropdown_wrap").has(e.target).length === 0){

		$(".dropdown_wrap").removeClass("open_wrap");

		}	
		});

		$(".comment_toggle").on("click", function(){

			reply_group = $(this).attr("data-value");

			let res = getComment(video_code, reply_group);

			$(this).closest(".input_comment").append(res);


		});


		// 네비게이션 클릭
		let scrollNav = $(".scrollmenu").scrollLeft();
	
		$("#slide_right").on("click", function(){
			$(".scrollmenu").scrollLeft(scrollNav + 250);
		});

		$("#slide_left").on("click", function(){
			$(".scrollmenu").scrollLeft(scrollNav - 250);
		});
		

		// 구독버튼 클릭
		$("#subscribe_btn").on("click", function(){


			
			if(session){
				if($(this).attr("class") == "subscribe_true"){
					deleteSubscribe(subscribe_code);
					$(this).attr("class", "subscribe_false");
					$(this).children().text("구독");
				}else {
					subscribe_code = insertSubscribe(channel_code);
					$(this).attr("class", "subscribe_true");
					$(this).children().text("구독중");
				}
			}else{
				alert('로그인 해주세요');
				location.href= getContextPath() +"/login.do";
			}
		});


 
		// 영상 좋아요 클릭
		$(".watch_good_btn").on("click", function(){

			let video_good;
			let tag = $(this).parent(); //btn_wrap
			let check = tag.attr("data-value");
			let good_img = $(this).find(".good");	
			let bad_img = tag.find(".bad");
			let check_good = "good";
			let good_bad = 1;
			if(session){ // 로그인 체크
					
				if(check == 1){ // 좋아요 취소
					video_good = deleteGood(video_code, good_code, good_bad);
					changeValue(tag, good_img, bad_img, check_good, video_good);

				}else if(check == 2){ // 좋아요 수정
					video_good = updateGood(video_code, good_code, good_bad);				
					changeValue(tag, good_img, bad_img, check_good, video_good);

				}else{ // 좋아요 추가
					resultGood = insertGood(video_code, good_bad);
					good_code = resultGood.getCode;
					video_good =  resultGood.getGood;
					changeValue(tag, good_img, bad_img, check_good, video_good);
				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
				location.href= getContextPath() +"/login.do";
			}
			
	
		});
		// 영상 싫어요 클릭
		$(".watch_bad_btn").on("click", function(){

			let check = $(this).parent().attr("data-value");
			
			let bad_img = $(this).find(".bad");
			let tag = $(this).parent();
			let good_img = tag.find(".good");
			let check_good = "bad";
			let good_bad = 2;
			if(session){ // 로그인 체크
					
				if(check == 2){ // 싫어요 취소
					deleteGood(video_code, good_code, good_bad);
					changeValue(tag, good_img, bad_img, check_good);

				}else if(check == 1){ // 싫어요 수정
					video_good = updateGood(video_code, good_code, good_bad);
					changeValue(tag, good_img, bad_img, check_good, video_good);

				}else{ // 싫어요 추가
					resultGood = insertGood(video_code, good_bad);
					good_code = resultGood.getCode;
					changeValue(tag, good_img, bad_img, check_good);

				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
				location.href= getContextPath() +"/login.do";
			}
			
	
		});


		// 댓글 좋아요
		$(document).on("click", ".reply_good_btn", function(){

			let reply_code = $(this).parents().closest(".reply_box").find(".reply_code").val();

			let tag = $(this).parents().closest(".reply_box"); //

			let check = tag.attr("data-value");
			
			if(tag.attr("data-code")){
				feedback_code = tag.attr("data-code");
			}
			

			let good_img = tag.find(".reply_good");
			let bad_img = tag.find(".reply_bad");

			let check_good = "good";
			let feedback_good = 1;
			if(session){ // 로그인 체크
					
				if(check == 1){ // 좋아요 취소
					feedback_good = deleteFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good, feedback_good);

				}else if(check == 2){ // 좋아요 수정
					feedback_good = updateFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good, feedback_good);

				}else{ // 좋아요 추가
					result_feedback = insertFeedback(video_code, reply_code, feedback_good);
					feedback_code = result_feedback.getCode;
					feedback_good = result_feedback.getGood;
					changeValue(tag, good_img, bad_img, check_good, feedback_good);
				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
				location.href= getContextPath() +"/login.do";
			}
			
	
		});
		

		// 댓글 싫어요
		$(document).on("click", ".reply_bad_btn", function(){

			let reply_code = $(this).parents().closest(".reply_box").find(".reply_code").val();
		
			let tag = $(this).parents().closest(".reply_box");

			let check = tag.attr("data-value");

			if(tag.attr("data-code")){
				feedback_code = tag.attr("data-code");
			}

			let good_img = tag.find(".reply_good");
			let bad_img = tag.find(".reply_bad");

			let check_good = "bad";
			let feedback_good = 2;

			if(session){ // 로그인 체크
					
				if(check == 2){ // 싫어요 취소
					feedback_good = deleteFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good, feedback_good);

				}else if(check == 1){ // 싫어요 수정
					feedback_good = updateFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good, feedback_good);

				}else{ // 싫어요 추가
					result_feedback = insertFeedback(video_code, reply_code, feedback_good);
					feedback_code = result_feedback.getCode;
					feedback_good = result_feedback.getGood;
					changeValue(tag, good_img, bad_img, check_good, feedback_good);

				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
				location.href= getContextPath() +"/login.do";
			}
			
	
		});		

		// 대댓글 좋아요
		$(document).on("click", ".comment_good_btn", function(){

			let reply_code = $(this).parents().closest(".comment_wrap").find(".reply_code").val();

			let tag = $(this).parents().closest(".comment_wrap");

			let check = tag.attr("data-value");
			let feedback_good = 1;
			
			if(tag.attr("data-code")){
				feedback_code = tag.attr("data-code");
			}
			

			let good_img = tag.find(".reply_good");
			let bad_img = tag.find(".reply_bad");

			let check_good = "good";

			if(session){ // 로그인 체크
					
				if(check == 1){ // 좋아요 취소
					feedback_good = deleteFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good, feedback_good);

				}else if(check == 2){ // 좋아요 수정
					feedback_good = updateFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good, feedback_good);

				}else{ // 좋아요 추가
					result_feedback = insertFeedback(video_code, reply_code, feedback_good);
					feedback_code = result_feedback.getCode;
					feedback_good = result_feedback.getGood;

					changeValue(tag, good_img, bad_img, check_good, feedback_good);
				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
				location.href= getContextPath() +"/login.do";
			}
			
	
		});		

		// 대댓글 싫어요
		$(document).on("click", ".comment_bad_btn", function(){

			let reply_code = $(this).parents().closest(".comment_wrap").find(".reply_code").val();

			let tag = $(this).parents().closest(".comment_wrap");

			let check = tag.attr("data-value");
			
			if(tag.attr("data-code")){
				feedback_code = tag.attr("data-code");
			}
			

			let good_img = tag.find(".reply_good");
			let bad_img = tag.find(".reply_bad");

			let check_good = "bad";
			let feedback_good = 2;

			
			if(session){ // 로그인 체크
					
				if(check == 2){ // 싫어요 취소
					feedback_good = deleteFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good, feedback_good);

				}else if(check == 1){ // 싫어요 수정
					feedback_good = updateFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good, feedback_good);

				}else{ // 싫어요 추가
					result_feedback = insertFeedback(video_code, reply_code, feedback_good);
					feedback_code = result_feedback.getCode;
					feedback_good = result_feedback.getGood;
					changeValue(tag, good_img, bad_img, check_good, feedback_good);

				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
				location.href= getContextPath() +"/login.do";
			}
			
	
		});	

		// 댓글 입력
		$("#reply_complete").on("click", function(){
			//let reply_cont = $("#reply_cont").children().text;
			//let reply_cont = document.getElementById('reply_cont').innerText.replace("\r\n","<br>");
			//let join_reply_cont = reply_cont.join();
			let popover = $(this);

			let reply_cont = document.getElementById("reply_cont").innerText.replaceAll("\n","\\n");

			if(session){

				if(reply_cont == '' || null || undefined || 0 || NaN){
					
					
					popover.attr("data-bs-content", "댓글 내용을 입력하세요");
					showPopover(popover);

				}else{
					popover.popover("disable");
					let reply_comment = 0;
					inputReply(video_code, reply_cont, reply_comment);
					$("#reply_cont").empty();
				}




			}else{
				alert('로그인 해주세요');
				location.href= getContextPath() +"/login.do";
			}

		});

		//댓글 입력 reset
		$("#reply_cancle").on("click", function(){

			$("#reply_cont").empty();
		});

		//대댓글 버튼 클릭
		$(document).on("click", ".reply_comment_btn", function(){

			let input_reply = $(this).parents(".input_reply");
			
			if(input_reply.hasClass("reply_open")){
				input_reply.removeClass("reply_open");
				input_reply.find(".comment_inputBox").remove();
			}else{
			let div="";
			div += "<div class='comment_inputBox card_a'>";
			// .comment_inputBox(item1)
			div += "<div class='input_profile'><img class='profile channel-backcolor' src='" +getContextPath()+ "/resources/img/channel_profile/" +profil+ "'></div>";

			// .commnet_inputBox(item2)
			div += "<div class='write_box'>";

			div += "<div class='write_field'>";
			div += "<div id='reply_cont' class='reply_cont' contenteditable='true' placeholder='댓글 추가...'></div>";
			div += "</div>"; // .write_field

			div += "<div class='comment_input_footer card_b'>";
			// comment_input_footer(item1)
			div += "<div></div>" //이모티콘
			div += "<div class='comment_input_footer_btn card_e'>";
			// comment_input_footer_btn(item1)
			div += "<div class='item_reply btn_wrap'>";
			div += "<button class='comment_cancle watch_btn watch'>";
			div += "<div class='cancle_btn'>취소</div>";
			div += "</button>";
			div += "</div>"; // .item_reply
			// comment_input_footer_btn(item2)
			div += "<div class='item_reply btn_wrap'>";
			div += "<button class='commnet_complete watch_btn'>";
			div +="<div class='reply_btn'>답글</div>";
			div +="</button>";
			div += "</div>"; //item_reply
			div += "</div>"; //.comment_input_footer_btn
			div +="</div>"; //.comment_input_footer

			div += "</div>"; // .write_box

			div += "</div>"; // .comment_inputBox

			input_reply.append(div);
			input_reply.addClass("reply_open");

			}
		
			

		});

		

		// 대댓글 입력
		$(document).on("click", ".commnet_complete", function(){

			if(session){

				let reply_cont = $(this).parents(".write_box").find(".reply_cont").html().replaceAll(/<div>|<\/div>|<br>/g, '\\n');
				let reply_comment = 2;
				let reply_group = $(this).parents().closest(".reply_box").find(".reply_group").val();
				let reply_code = $(this).parents().closest(".reply_box").find(".reply_code").val();
				let popover = $(this);
				if(reply_cont == '' || null || undefined || 0 || NaN){
					
					
					popover.attr("data-bs-content", "댓글 내용을 입력하세요");
					showPopover(popover);

				}else{

					popover.popover("disable");
					let div = inputComment(video_code, reply_cont, reply_comment, reply_group, reply_code);
					$(this).parents(".write_box").find(".reply_cont").empty();
					$(this).parents().closest(".input_reply").append(div);
				}

				

			}else{
				alert('로그인 해주세요');
				location.href= getContextPath() +"/login.do";
			}

		});

		$(document).on("click", ".comment_cancle", function(){

			let cancle = $(this).parents(".write_box").find(".reply_cont");
			
			
			cancle.empty();
		});

		// 재생목록에 추가 열기 버튼
		$(".savePlaylist_btn").on("click", function(){

			if(session){
				$(".savePlaylist_container").addClass("block");

				getBundleList(video_code); // 재생목록 불러오는 함수
			}else{
				alert('로그인 해주세요');
				location.href= getContextPath() +"/login.do";
			}

		});

		// 재생목록 추가 닫기 버튼
		$(".savePlaylist_close_btn").on("click", function(){
			closePlaylist();
		});


		// 새 재생목록 만들기 버튼
		$(".newPlaylist_btn").on("click", function(){
			$(this).css("display", "none");
			$(".newPlaylist_input_box").css("display", "block");			
		});

		// 공개 비공개 선택
		$(".dropdown-item").on("click", function(){
			let text = $(this).text();
			let playlist_open = $(this).attr("data-value");
			console.log('값>' +playlist_open);
		 	$("#playlist_open").val(playlist_open);
			$("#playlist_btn_text").text(text);
		 });

		 // 재생목록 생성완료
		 $("#newPlaylist_check").on("click", function(){
			let popover = $(this);
			let playlist_title = $("#playlist_title").val();
			let playlist_open = $("#playlist_open").val();

			if(playlist_title == '' || null || undefined || 0 || NaN){
				console.log('if title');
				console.log('title > ' +playlist_title);
				popover.attr("data-bs-content", "제목을 입력하세요");
				showPopover(popover);
							
			}else if(playlist_open == 2){
				console.log('if else');
				console.log('open > ' +playlist_open);
				popover.attr("data-bs-content", "공개/비공개 여부를 선택 해주세요");
				showPopover(popover);
			}else{		
				console.log('else');
				popover.popover("disable");
				closePlaylist();
				newPlaylist(playlist_title, playlist_open);
			}

		 });


		 // 재생목록 추가
		 $(document).on("change", "input[name='addPlaylist']", function(){
			
			let playlist_code = $(this).val();
			let playlist_title = $(this).parent().text();

			if($(this).is(":checked") == true){
				addPlaylist(video_code, playlist_code, playlist_title);
			}else{
				deletePlaylist(video_code, playlist_code);
			}			


		 });
		 

	// 	 // 동영상 마우스 over
	// 	 $(document).on("mouseover", ".video_list_thumbnail", function(){

	// 		let src = $(this).children("video_list_img").attr("src");
			
	// 		console.log('src > ' +src);
	// 		//$(this).get(0).play();
	//    });
   
	//    $(document).on("mouseout", ".video_list_box", function(){
	// 		//$(this).get(0).pause();
	//    });


 });