$(document).ready(function() {


	$("link[rel=stylesheet][href*='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css']").remove();

	function getContextPath(){
		
		let path = location.href.indexOf(location.host)+location.host.length;
		
		return location.href.substring(path, location.href.indexOf('/', path+1));
	}

	let video_code = $("#video_code").val();
	

	let reply_group = 'a1a1a1';
	
	let reply_option = "most";
	let page_reply = 1;
	let page_comment = 1;
	let loading_reply = true;
	let loading_video = true;

	function getReply(video_code, reply_option, page_reply){

		$.ajax({

			url : getContextPath() +"/reply.do",
			data : {
				"video_code" : video_code,
				"reply_option" : reply_option,
				"page" : page_reply 
			},
			datatype : 'JSON',
			contentType : "application/json; charset=UTF-8",
			success : function(data){
				
				let str = data;

				if(str == "[]"){
					loading_reply = false;
					
				}else{
					let reply = JSON.parse(data);
					
					let div = "";  


					$(reply).each(function(){

						div += "<div class='reply_box card_a'>";

						div += "<div class='item_a'>";
						div += "<div class='reply_wrap'>";
						div += "<div class='input_profile'><img class='profile' src='" +getContextPath()+ "/resources/img/" +this.channel_profil+ "'></div></div></div>"

						div += "<div class='input_reply item_a'>";

						div += "<div id='input_reply_writer' class='writer_info'>";
						div += "<span class='reply_writer'>" +this.channel_name+"</span>";
						div += "<span class='reply_date'>" +this.reply_regdate+ "</span>";
						div += "</div>";

						div += "<div class='reply_cont_box'>";
						div += "<div id='input_reply_cont'>" +this.reply_cont+ "</div>";
						div += "</div>";

						div += "<div class='reply_action_box'>";
						div += "<div class='toolbar_wrap card_a'>";
						div += "<div class='reply_good_btn'><div class='card_b'><img class='reply_good' src='" +getContextPath()+ "/resources/watch/watch_img/good.svg'><div>" +this.reply_good+ "</div></div></div>";
						div += "<div class='reply_bad_btn'><img class='reply_bad' src='" +getContextPath()+ "/resources/watch/watch_img/bad.svg'></div>";
						div += "<div class='reply_comment_btn'>답글</div>";
						div += "</div>"; // .toolbar_wrap
						div += "</div>"; // .reply_action
						div += "</div>"; // .input_reply


						div += "<div class='render_box'><div class='render_wrap'><button class='render'><img class='render_icon' src='" +getContextPath()+ "/resources/watch/watch_img/render_icon.png'></button></div></div>";
						div += "</div>"; // .reply_box
						
						if(this.reply_comment == 1){

							div += "<div class='comment_box'>";
							div += "<div class='comment_menu card_c'><div class='comment_btn close'><button class='comment_toggle card_a' value='" +this.reply_group+ "'><img class='toggle open' src='" +getContextPath()+ "/resources/watch/watch_img/comment_open.png'>";
							div += "<div class='comment_count'>답글" +this.comment_count+ "개</div>";
							div += "</button></div>"
							div += "</div>" // .comment_wrap
							div += "<div class='input_comment'></div>";
							div += "</div>"; //.comment_box
						}
						
						//div += "</div></div>";
					});
					
					
					$("#input_reply_box").append(div);
				}
			},

			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}
			
		}); 

	}	// getReply() end


	function getComment(video_code, reply_group, page_comment){

		let div = "";

		$.ajax({
			

			url : getContextPath() +"/comment.do",
			data : {
				"video_code" : video_code,
				"reply_group" : reply_group,
				"page" : page_comment
			},
			datatype : 'JSON',
			contentType : "application/json; charset=UTF-8",
			async : false,
			success : function(data){

				let comment = JSON.parse(data);

				$(comment).each(function(){
					
					div += "<div class='comment_wrap card_a'>"; //card
					// commnet_wrap(item1)
					div += "<div class='profile'>"; //.comment_wrap(item1)
					div += "<img class='profile' src='" +getContextPath()+ "/resources/img/" +this.channel_profil+ "'>";
					div += "</div>"; //.profile end
					//comment_wrap(item2)
					div += "<div class='comment_card card_c'>"; //card
					// comment_card(item1)
					div += "<div id='input_comment_writer' class='writer_info'>"; 
					div += "<span class='reply_writer'>" +this.channel_name+ "</span>";
					div += "<span class='reply_date'>" +this.reply_regdate+ "</span>";	
					div += "</div>"; //#input_comment_writer end
					// comment_card(item2)
					div += "<div class='reply_cont_box'>"; 
					div += "<div id='input_comment_cont'>" +this.reply_cont+ "</div>";
					div += "</div>"; //.reply_cont_box end
					// comment_card(item3)
					div += "<div class='reply_action_box'>"; 
					div += "<div class='toolbar_wrap card_a'>" //card
					// toolbar(item1)
					div += "<div class='reply_good_btn'><div class='card_b'>"; 
					div += "<img class='reply_good' src='" +getContextPath()+ "/resources/watch/watch_img/good.svg'>";
					div += "<div>" +this.reply_good+ "</div>";
					div += "</div></div>"; //.reply_good_btn, .card_b
					// toolbar(item2)
					div += "<div class='reply_bad_btn'>"; 
					div += "<img class='reply_bad' src='" +getContextPath()+ "/resources/watch/watch_img/bad.svg'>";
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

				});

				if(comment.length < 10){
					div += "<div class='comment_more'>";
					div += "더보기ㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣ";

					div += "</div>" //.comment_more
				}

				
			},

			error : function(){
				alert('대댓글 불러오기 error');
			}

			
		});

		return div;

	} //getComment() end



 	 	
	 
	//  기본 실행 함수
	 getReply(video_code, reply_option, page_reply);



 		





	
 	/* 대댓글 토글 버튼 */
	$(document).on("click", ".comment_toggle", function(){
		
		console.log('대댓글 실행');

		let toggle_img = $(this).find(".toggle");
		let reply_group = $(this).val();
		let ap = $(this).parents(".comment_menu").next();
		
		if(toggle_img.hasClass("open")){
			toggle_img.attr("src", getContextPath() +"/resources/watch/watch_img/comment_close.png");
			toggle_img.removeClass("open");
			toggle_img.addClass("close");

			let res = getComment(video_code, reply_group, page_comment);

			if(ap.children().length == 0){
				ap.append(res);
			}
			
			ap.addClass("show");


		}else{
			toggle_img.attr("src", getContextPath() +"/resources/watch/watch_img/comment_open.png");
			toggle_img.removeClass("close");
			toggle_img.addClass("open");

			ap.removeClass("show");
		}			 					
	
		});

		


		// 무한 스크롤
		$(window).scroll(function(){
	
			if($(window).scrollTop()>=$(document).height() - $(window).height()){
				if(loading_reply){
					page_reply++;
					getReply(video_code, reply_option, page_reply);
				}
			}
			
		}); //scroll end



}); // document.ready end


