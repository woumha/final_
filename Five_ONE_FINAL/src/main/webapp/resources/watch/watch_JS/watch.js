$(document).ready(function() {


	$("link[rel=stylesheet][href*='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css']").remove();

	function getContextPath(){
		
		let path = location.href.indexOf(location.host)+location.host.length;
		
		return location.href.substring(path, location.href.indexOf('/', path+1));
	}

	let video_code = $("#video_code").val();
	console.log('video_code >>>' +video_code);

	let reply_group = 'a1a1a1';
	
	let video_option = "most";
	let page = 1;
	
	function getReply(video_code, video_option, page){

		$.ajax({

			url : getContextPath() +"/reply.do",
			data : {
				"video_code" : video_code,
				"video_option" : video_option
			},
			datatype : 'JSON',
			contentType : "application/json; charset=UTF-8",
			success : function(data){
				

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
					div += "</div>";
					div += "</div></div>";


					div += "<div class='render_box'><div class='render_wrap'><button class='render'><img class='render_icon' src='" +getContextPath()+ "/resources/watch/watch_img/render_icon.png'></button></div></div></div>";
					
					if(this.reply_comment == 1){

						div += "<div class='comment_box'>";
						div += "<div class='comment_wrap card_c'><div class='comment_btn close'><a class='comment_toggle card_a' data-value='" +this.reply_group+ "'><img class='toggle open' src='" +getContextPath()+ "/resources/watch/watch_img/comment_open.png'>";
						div += "<div class='comment_count'>답글" +this.comment_count+ "개</div>";
						div += "</a></div>"
						div += "<div class='input_comment card_a'></div>";
						div += "</div>"; //.comment_box
					}
					
					div += "</div></div>";
				});
				
				$("#input_reply_box").append(div);
				   
			},

			error : function(request, status, error){
				console.log("code: " + request.status);
				console.log("message: " + request.responseText);
				console.log("error: " + error);
			}
			
		}); 

	}	// getReply() end


	function getComment(video_code, reply_group){

		let div = "";

		$.ajax({
			

			url : getContextPath() +"/comment.do",
			data : {
				"video_code" : video_code,
				"reply_group" : reply_group
			},
			datatype : 'JSON',
			contentType : "application/json; charset=UTF-8",
			success : function(data){

				let comment = JSON.parse(data);

				

				$(comment).each(function(){

					div += "<div class='profile'>";
					div += "<img class='profile' src='" +getContextPath()+ "/resources/img/" +this.channel_profil+ "'></div>";
					div += "</div>";

					div += "<div class='comment_card card_c'>"
					div += "<div id='input_comment_writer' class='writer_info'>";
					div += "<span class='reply_writer>" +this.channel_name+ "</span>";
					div += "<span class='reply_date>" +this.reply_date+ "</span>";				;
					div += "</div></div>";

					div += "<div class='reply_cont_box'>";
					div += "<div id='input_comment_cont'>" +this.reply_cont+ "</div>";
					div += "</div>";

					div += "<div class='reply_action_box'>";
					div += "<div class='toolbar_wrap card_a'>"

					div += "<div class='reply_good_btn'>"
					div += "<div class='card_b'><img class='reply_good' src='" +getContextPath()+ "/resources/watch/watch_img/good.svg'>";
					div += "<div>" +this.reply_good+ "</div></div>"
					div += "</div></div></div>";

					div += "<div class='reply_bad_btn'>";
					div += "<img class='reply_bad' src='" +getContextPath()+ "/resources/watch/watch_img/bad.svg'>";
					div += "</div>";

					div += "<div class='render_box'>";
					div += "<div class='render_wrap'>";
					div += "<button class='render'><img class='render_icon' src='" +getContextPath()+ "/resources/watch/watch_img/render_icon.png'></button>";
					div += "</div></div>";

				});

		
			},

			error : function(){
				alert('대댓글 불러오기 error');
			}

		});

		return div;

	} //getComment() end


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

		$(".comment_toggle").on("click", function(){

			reply_group = $(this).attr("data-value");

			let res = getComment(video_code, reply_group);

			$(this).closest(".input_comment").append(res);


		});

		


}); // document.ready end


