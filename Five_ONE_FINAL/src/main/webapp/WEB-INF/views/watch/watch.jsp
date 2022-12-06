<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://vjs.zencdn.net/7.20.3/video.min.js"></script>
<link href="//vjs.zencdn.net/7.20.3/video-js.min.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<%-- <script type="text/javascript" src="${path }/resources/watch_JS/video.js"></script> --%>
</head>
<body>
	
	<c:set var="dto" value="${dto }" />
	
	<jsp:include page="../include/top_include.jsp"/>
	
	<div class="container">
		<div class="container_L">
		
		</div>
		<div class="watch_container">
		
			<div class="video_box">
				<div class="video_wrap">
					<video id="myPlayer" class="video-js vjs-default-skin vjs-16-9" autoplay="autoplay"></video>
					<!-- <video id="myPlayer" class="video-js vjs-theme-city player" controls="controls" autoplay="autoplay"></video> -->
				</div>
			</div>
			
			<div class="watch_info">
			
				<div class="hash_box">
					<div id="input_hash">
						<a href="#">#해시태그</a>
					</div>
				</div>
				
				<div class="title_box">
					<div id="input_title">
						<div id="video_title">
						<p>${dto.getVideo_title() }</p>
						</div>
					</div>
				</div>
				<div class="channel_box card_a">
					<div class="channel_wrap">
						<div class="card_a">
							<div class="item_a">
								<div id="input_profile">
									<img class="profile" src="${pageContext.request.contextPath}/resources/img/unnamed.jpg">
								</div>
							</div>
							
							<div class="item_a">
								<div class="channel_info">
									<div id="input_uploader">업로더</div>
									<div id="input_member">100명</div>
								</div>
							</div>
							
							<div class="item_a">
								<button class="btn">
									<div class="subscribe">구독</div>
								</button>
							</div>
						</div>
					</div>
					<div class="channel_wrap">
						<div class="card_e">
							<div class="item_a btn_wrap">
								<button class="btn2 card_b">
									<div class="subscribe"><div class="card_b"><img class="good" src="${pageContext.request.contextPath}/resources/watch/watch_img/good.svg"><div>좋아요</div></div></div>
									<div class="subscribe"><div class="card_b"><img class="bad" src="${pageContext.request.contextPath}/resources/watch/watch_img/bad.svg"><div>싫어요</div></div></div>
								</button>
							</div>
							<div class="item_a btn_wrap">
								<button class="btn">
									<div class="share">공유</div>
								</button>
							</div>
							
							<div class="item_a btn_wrap">
								<button class="btn">
									<div class="save">오프라인 저장</div>
								</button>
							</div>
							
							<div class="item_a btn_wrap">
								<button class="btn">
									<div class="other">기타</div>
								</button>
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="cont_box">
					<div class="input_cont">
						<span>조회수</span>&nbsp;&nbsp;
						<span>날짜</span>
					</div>
					<div class="cont">${dto.getVideo_cont() }</div>
				</div>
			</div>
			
			<div class="watch_reply ">
			
				<div class="option_box card_c">
					<div class="item_a">
						<div id="input_reply" class="card_a">
							<div class="reply_count">댓글 ${reply_count }개</div>
							<div class="reply_option"><img class="menu_icon" src="${pageContext.request.contextPath}/resources/watch/watch_img/dropdown_menu.svg">정렬기준</div>
						</div>
					</div>
					
					<div class="item_a">
						<div id="card_a">
							<div class="card_a">
								<div class="input_profile"><img class="profile" src="${pageContext.request.contextPath}/resources/img/unnamed.jpg"></div>
								<div class="write_box">
									<div class="item_a write_field">
										<div class="reply_cont" contenteditable="true" placeholder="댓글 추가..."></div>
									</div>

									<div class="item_a card_b">
										<div>이모티콘</div>
										<div class="card_e">
											<div class="item_reply btn_wrap">
												<button class="btn">
													<div class="cancle_btn">취소</div>
												</button>
											</div>
											<div class="item_reply btn_wrap">
												<button class="btn">
													<div class="reply_btn">답글</div>
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>				
			
				
				<div class="reply_box card_a">
					<div class="item_a">
						<div class="reply_wrap">
							<div class="input_profile"><img class="profile" src="${pageContext.request.contextPath}/resources/img/unnamed.jpg"></div>	
						</div>
					</div>
					
					<div class="input_reply item_a">
						<div id="input_reply_writer" class="writer_info">
							<span class="reply_writer">댓글작성자</span>
							<span class="reply_date">날짜</span>
						</div>
						
						<div class="reply_cont_box">
							<div id="input_reply_cont">
								wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
							</div>
						</div>
						
						<div class="reply_action_box">
							<div class="toolbar_wrap card_a">
								<div class="reply_good_btn">
									<div class="card_b"><img class="reply_good" src="${pageContext.request.contextPath}/resources/watch/watch_img/good.svg"><div>1.1만개</div></div>
								</div>
								
								<div class="reply_bad_btn">
									<img class="reply_bad" src="${pageContext.request.contextPath}/resources/watch/watch_img/bad.svg">
								</div>
								
								<div class="reply_comment_btn">
									답글
								</div>
								
							</div>
						</div>
					</div>
					
					<div class="render_box">
						<div class="render_wrap">
							<button class="render">
								<img class="render_icon" src="${pageContext.request.contextPath}/resources/watch/watch_img/render_icon.png">
							</button>
						</div>
					</div>
				</div>  <!-- 댓글하나 -->
			
			
				<!-- 대댓글영역 -->
				<div class="comment_box">
					<div class="comment_wrap card_c">
						<div class="comment_btn close">
							<button class="comment_toggle card_a">
								<img class="toggle open" src="${pageContext.request.contextPath}/resources/watch/watch_img/comment_open.png">
								<div class="comment_count">답글 x개</div>
							</button>
						</div>
						
						<div class="input_comment card_a">
							<div class="profile">
								<img class="profile" src="${pageContext.request.contextPath}/resources/img/unnamed.jpg">
							</div>
							
							<div class="comment_card card_c">
								<div id="input_comment_writer" class="writer_info">
									<span class="reply_writer">댓글작성자</span>
									<span class="reply_date">날짜</span>
								</div>
								
								<div class="reply_cont_box">
									<div id="input_comment_cont">
										ddddddddddddddddddddddddddddddd
									</div>
								</div>
								
								<div class="reply_action_box">
									<div class="toolbar_wrap card_a">
										<div class="reply_good_btn">
											<div class="card_b"><img class="reply_good" src="${pageContext.request.contextPath}/resources/watch/watch_img/good.svg"><div>1.1만개</div></div>
										</div>
										
										<div class="reply_bad_btn">
											<img class="reply_bad" src="${pageContext.request.contextPath}/resources/watch/watch_img/bad.svg">
										</div>
										
									</div>
								</div>
							</div>
							
							<div class="render_box">
								<div class="render_wrap">
									<button class="render">
										<img class="render_icon" src="${pageContext.request.contextPath}/resources/watch/watch_img/render_icon.png">
									</button>
								</div>
							</div>
						</div>
					</div>
				</div><!-- 대댓글영역 -->	
				
				
				<!-- ==========================댓글 1개 + 대댓글====================== -->
				
				
				
				
				
				
								<div class="reply_box card_a">
					<div class="item_a">
						<div class="reply_wrap">
							<div class="input_profile"><img class="profile" src="${pageContext.request.contextPath}/resources/img/unnamed.jpg"></div>	
						</div>
					</div>
					
					<div class="intput_reply item_a">
						<div id="input_reply_writer" class="writer_info">
							<span class="reply_writer">댓글작성자</span>
							<span class="reply_date">날짜</span>
						</div>
						
						<div class="reply_cont_box">
							<div id="input_reply_cont">
								wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
							</div>
						</div>
						
						<div class="reply_action_box">
							<div class="toolbar_wrap card_a">
								<div class="reply_good_btn">
									<div class="card_b"><img class="reply_good" src="${pageContext.request.contextPath}/resources/watch/watch_img/good.svg"><div>1.1만개</div></div>
								</div>
								
								<div class="reply_bad_btn">
									<img class="reply_bad" src="${pageContext.request.contextPath}/resources/watch/watch_img/bad.svg">
								</div>
								
								<div class="reply_comment_btn">
									답글
								</div>
								
							</div>
						</div>
					</div>
				</div>  
			
				<div class="comment_box">
					<div class="comment_wrap card_c">
						<div class="comment_btn close">
							<button class="comment_toggle card_a">
								<img class="toggle open" src="${pageContext.request.contextPath}/resources/watch/watch_img/comment_open.png">
								<div class="comment_count">답글 x개</div>
							</button>
						</div>
						
						<div class="input_comment card_a">
							<div class="profile">
								<img class="profile" src="${pageContext.request.contextPath}/resources/img/unnamed.jpg">
							</div>
							
							<div class="comment_card card_c">
								<div id="input_comment_writer" class="writer_info">
									<span class="reply_writer">댓글작성자</span>
									<span class="reply_date">날짜</span>
								</div>
								
								<div class="reply_cont_box">
									<div id="input_comment_cont">
										ddddddddddddddddddddddddddddddd
									</div>
								</div>
								
								<div class="reply_action_box">
									<div class="toolbar_wrap card_a">
										<div class="reply_good_btn">
											<div class="card_b"><img class="reply_good" src="${pageContext.request.contextPath}/resources/watch/watch_img/good.svg"><div>1.1만개</div></div>
										</div>
										
										<div class="reply_bad_btn">
											<img class="reply_bad" src="${pageContext.request.contextPath}/resources/watch/watch_img/bad.svg">
										</div>
										
									</div>
								</div>
							</div>
						</div>					
					</div>
				</div><!-- 대댓글영역 -->	
				
				
				
				
				
			</div> <!-- 댓글영역 -->
		</div>

	
		<div class="side_box">
		</div>
	</div>

	



</body>

<script type="text/javascript">

let ur = "BigBuckBunny.mp4"; 

var player = videojs("myPlayer", {
    sources : [
        { src : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/" +ur, type : "video/mp4"}
    ],
    controls : true,
    playsinline : true,
    muted : true,
    preload : "metadata",
   	fluid : true

});

/* player.addClass('vjs-matrix'); */

$(document).ready(function() {
	
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
 				toggle_img.attr("src", "${pageContext.request.contextPath}/resources/watch/watch_img/comment_close.png");
 				toggle_img.removeClass("open");
 				toggle_img.addClass("close");
 			}else{
 				toggle_img.attr("src", "${pageContext.request.contextPath}/resources/watch/watch_img/comment_open.png");
 				toggle_img.removeClass("close");
 				toggle_img.addClass("open");
 			}
 			
 			
 		
 		
 	 });
 
});




/* var vi = $('video'),
win = $('.video_box');

$(window).resize(function () {
var height = win.height();
vi.css('height', height);

var videoWidth = vi.width(),
    windowWidth = win.width(),
    marginLeftAdjust = (windowWidth - videoWidth) / 2;

vi.css({
    'height': height,
    'marginLeft': marginLeftAdjust
});
}).resize(); */


</script>

<style>

button{
	border: none;
}

.container_L{
	position: fixed;
	width: 102px;
}


.container {

	margin: 0 auto;
	display: flex;
	flex-direction: row;
}


.watch_container {
	
	flex: 1;
	margin-left: 5rem;
	margin-right: 2rem;
}


/* 영상 CSS */
.video_wrap{
	
	width: 85rem;
	height: auto;
}


/* watch_info CSS */

.watch_info{

	margin-top:0.5rem;
	margin-bottom:1rem;
}




.card_a{
	display: flex;
	justify-content: flex-start;
	flex-direction: row;
}

.card_b{
	display: flex;
	justify-content: space-between;
	flex-direction: row;
	align-items: center;
}

.card_c{
	display: flex;
	flex-direction: column;
}

.card_e{
	display: flex;
	justify-content: flex-end;
	flex-direction: row;
	align-items: center;
}


/* 해시태그 CSS */
.hash_box{

	text-align:left;
	padding-bottom: 0.5rem;
}

.hash_box a{
	margin-bottom: 1rem;
}

.title_box{
	text-align: left;
}

.cont_box{
	text-align: left;
	background-color: #e3e3e3;
	border-radius: 30px;
}

.input_cont{
	border-radius: inherit;
	margin: 2rem;	
}




/* 채널 정보 CSS */
.channel_wrap{
	flex-basis: 50%;
}

.profile{
	width: 2.5rem;
	height: 2.5rem;
	border-radius: 50%;
	object-fit: cover;
	margin-bottom: 10px;
	margin-right: 1rem;
	vertical-align: middle;
}

.channel_info{
	margin-left: 0.5rem;
	margin-right: 2rem;
}

.btn{
	background-color: #e3e3e3;
	border-radius: 80px / 130px;
	width: auto;
	height: 36px;
}

.btn2{
	background-color: #e3e3e3;
	opacity:0.7;
	border-radius: 80px / 130px;
	height: 36px;
	width: 11rem;
}

.btn_wrap{
	flex-basis: 100px;
}

.subscribe{
	border-radius:inherit;
	margin-right: 0.2rem;
	vertical-align: middle;
	padding-right: 0.2rem;
}

.save{
	border-radius:inherit;
}

.good{
	width: 24px;
	height: 24px;
	margin-right: 0.2rem;
	vertical-align: middle;
}

.bad{
	width: 24px;
	height: 24px;
	margin-right: 0.2rem;
	vertical-align: middle;
}


/* 댓글 CSS */
.option_box{
	
	text-align: left;
	margin: 0.2rem;
}

.write_box{
	width:100%;
	box-sizing: border-box;
}

.write_field{
	margin-bottom: 1rem;
}

.reply_count{
	margin-right: 2rem;
	margin-bottom: 2rem;
}

.menu_icon{
	width: 24px;
	height: 24px;
	margin-right: 0.5rem;
	vertical-align: middle;
}

.reply_cont{
	width: 100%;
	border: none;
	font-size:14px;
	border-bottom: 1px solid #999;
	outline: none;
}

.reply_cont:empty:before{
	content:attr(placeholder);
	color:gray;
	display: block;
}



.cancle_btn{
	border-radius:inherit;
}


.item_reply{
	margin-right: 1rem;
	width: 100%;
}

.reply_box{
	margin-top: 2rem;
	text-align: left;
}

.reply_cont_box{
	text-align: left;
	margin-bottom: 1rem;
}

.reply_writer{
	margin-bottom: 0.5rem;
}

.toolbar_wrap{
	margin-bottom: 1rem;
}


.reply_good{
	height: 1rem;
	margin-right: 0.2rem;
	padding-right: 0.2rem;
	vertical-align: middle;
	border-radius:inherit;
}

.reply_good_btn{
	margin-right: 1rem;
}

.reply_bad_btn{
	margin-right: 1rem;
}

.reply_bad{
	height: 1rem;
	margin-right: 0.2rem;
	vertical-align: middle;
	border-radius:inherit;
}

.input_reply{
	width:100%;
}




/* 대댓글 CSS */
.comment_box{
	text-align: left;
}

.comment_card{
	width:100%;
}

.comment_wrap{
	margin-left: 2.5rem;
}

.comment_btn{
	margin-bottom: 1rem;
	
}


.comment_toggle{
	background-color: #fff;
	color: #66c;
	font-weight:bold;
	align-items: center;
}

.comment_toggle:hover{
	background-color: #9cf;
	border-radius: 100px;
}

.toggle{
	height: 1rem;
	margin-right: 0.2rem;
	padding-right: 0.2rem;
	border-radius:inherit;
	vertical-align: middle;
}

.render{
	background-color: #fff;
}

.render_box{
	width:5rem;
	display: flex;
	justify-content: center;
	align-items: center;	
}


.render_icon{
	width: 2rem;
	display: none;
}

.reply_box:hover .render_icon{
	display: block;
}

.input_comment:hover .render_icon{
	display: block;
}

/* 사이드바 CSS */
.side_box {
	flex: 1;
	background-color: blue;
}



.more{
	opacity: 0.5;
}

.card_a{
	vertical-align: middle;
}




</style>


</html>