/**
 * 
 */

let feedback_code;

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
	console.log('res > ' +res);
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
	let resultGood

	function getContextPath(){
		
		let path = location.href.indexOf(location.host)+location.host.length;
		
		return location.href.substring(path, location.href.indexOf('/', path+1));
	}




	function changeValue(tag, good_img, bad_img, name, video_good){
		
		let check = tag.attr("data-value");
		let good_cnt = tag.find("#good_cnt");	


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

		good_cnt.text(video_good);
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
				console.log('구독성공');
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
				console.log('구독취소성공');
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
				console.log('insert성공');
				console.log('data> ' +data);
				console.log('data-code>' +data.good_code);
				console.log('data-cnt>', +data.video_good);
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
				console.log('delete성공');
				console.log('data> '+data);
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
				console.log('update성공');
				console.log('data>'+data);
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

		console.log('v>' +video_code);
		console.log("r>" +reply_code);

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

	function deleteFeedback(feedback_code, feedback_good){

		console.log('c>' +feedback_code);

		$.ajax({

			url :  getContextPath() +"/deleteFeedback.do",
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"feedback_code" : feedback_code,
				"feedback_good" : feedback_good
			},
			success : function(data){
				console.log('feedback delete');
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});

	}

	function updateFeedback(feedback_code, feedback_good){
		$.ajax({

			url :  getContextPath() +"/updateFeedback.do",
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				"feedback_code" : feedback_code,
				"feedback_good" : feedback_good
			},
			success : function(data){
				console.log('feedback update');
			},
			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}

		});
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
				div += "<div class='input_profile'><img class='profile' src='" +getContextPath()+ "/resources/img/" +data.channel_profil+ "'></div></div></div>";

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
					div += "<img class='profile' src='" +getContextPath()+ "/resources/img/" +data.channel_profil+ "'>";
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
					console.log('취소 > '+video_good);
					changeValue(tag, good_img, bad_img, check_good, video_good);

				}else if(check == 2){ // 좋아요 수정
					video_good = updateGood(video_code, good_code, good_bad);				
					console.log('수정 > ' +video_good);
					changeValue(tag, good_img, bad_img, check_good, video_good);

				}else{ // 좋아요 추가
					resultGood = insertGood(video_code, good_bad);
					good_code = resultGood.good_code;
					video_good =  resultGood.video_good;
					changeValue(tag, good_img, bad_img, check_good, video_good);
				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
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
					updateGood(video_code, good_code, good_bad);
					changeValue(tag, good_img, bad_img, check_good);

				}else{ // 싫어요 추가
					good_code = insertGood(video_code, good_bad);
					console.log(good_code);
					changeValue(tag, good_img, bad_img, check_good);

				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
			}
			
	
		});


		// 댓글 좋아요
		$(document).on("click", ".reply_good_btn", function(){

			let reply_code = $(this).parents().closest(".reply_box").find(".reply_code").val();

			let tag = $(this).parents().closest(".reply_box");

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
					console.log('del');
					deleteFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}else if(check == 2){ // 좋아요 수정
					console.log('up');
					updateFeedback(feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}else{ // 좋아요 추가
					console.log('in');
					feedback_code = insertFeedback(video_code, reply_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
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
					deleteFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}else if(check == 1){ // 싫어요 수정
					updateFeedback(feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}else{ // 싫어요 추가
					feedback_code = insertFeedback(video_code, reply_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
			}
			
	
		});		

		// 대댓글 좋아요
		$(document).on("click", ".comment_good_btn", function(){

			let reply_code = $(this).parents().closest(".comment_wrap").find(".reply_code").val();

			console.log('댓글번호 >' +reply_code);

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
					console.log('del');
					deleteFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}else if(check == 2){ // 좋아요 수정
					console.log('up');
					updateFeedback(feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}else{ // 좋아요 추가
					console.log('in');
					feedback_code = insertFeedback(video_code, reply_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
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
					console.log('del');
					deleteFeedback(reply_code, feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}else if(check == 1){ // 싫어요 수정
					console.log('up');
					updateFeedback(feedback_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}else{ // 싫어요 추가
					console.log('in');
					feedback_code = insertFeedback(video_code, reply_code, feedback_good);
					changeValue(tag, good_img, bad_img, check_good);

				}	

			}else{ // 로그인 x
				alert('로그인 해주세요');
			}
			
	
		});	

		// 댓글 입력
		$("#reply_complete").on("click", function(){
			//let reply_cont = $("#reply_cont").children().text;
			//let reply_cont = document.getElementById('reply_cont').innerText.replace("\r\n","<br>");
			//let join_reply_cont = reply_cont.join();

			let reply_cont = document.getElementById("reply_cont").innerText.replaceAll("\n","\\n");

			if(session){
				console.log('if문 ')
				console.log('내용>' +reply_cont);
				let reply_comment = 0;
				inputReply(video_code, reply_cont, reply_comment);
				$("#reply_cont").empty();

			}else{
				console.log('else문')
				alert('로그인 해주세요');
			}

		});

		//댓글 입력 reset
		$("#reply_cancle").on("click", function(){

			$("#reply_cont").empty();
		});

		//답글 버튼 클릭
		$(document).on("click", ".reply_comment_btn", function(){
			console.log('클릭');

			let input_reply = $(this).parents(".input_reply");
			
			if(input_reply.hasClass("reply_open")){
				input_reply.removeClass("reply_open");
				input_reply.find(".comment_inputBox").remove();
			}else{
			let div="";
			div += "<div class='comment_inputBox card_a'>";
			// .comment_inputBox(item1)
			div += "<div class='input_profile'><img class='profile' src='" +getContextPath()+ "/resources/img/" +profil+ "'></div>";

			// .commnet_inputBox(item2)
			div += "<div class='write_box'>";

			div += "<div class='write_field'>";
			div += "<div id='reply_cont' class='reply_cont' contenteditable='true' placeholder='댓글 추가...'></div>";
			div += "</div>"; // .write_field

			div += "<div class='comment_input_footer card_b'>";
			// comment_input_footer(item1)
			div += "<div>이모티콘</div>"
			div += "<div class='comment_input_footer_btn card_e'>";
			// comment_input_footer_btn(item1)
			div += "<div class='item_reply btn_wrap'>";
			div += "<button class='comment_cancle' class='watch_btn'>";
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
				console.log('group > ' +reply_group);
				let div = inputComment(video_code, reply_cont, reply_comment, reply_group, reply_code);

				$(this).parents(".write_box").find(".reply_cont").empty();
				$(this).parents().closest(".input_reply").append(div);

			}else{
				console.log('else문')
				alert('로그인 해주세요');
			}

		});

		$(document).on("click", ".comment_cancle", function(){

			let cancle = $(this).parents(".write_box").find(".reply_cont");
			
			
			cancle.empty();
		});
 });