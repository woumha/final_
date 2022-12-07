<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="https://vjs.zencdn.net/7.20.3/video.min.js"></script>
<link href="//vjs.zencdn.net/7.20.3/video-js.min.css" rel="stylesheet">

<script type="text/javascript" src="${path }/resources/watch/watch_JS/watch.js"></script>


<link rel="stylesheet" href="${path }/resources/watch/watch_CS/watch.css">

</head>
<body>
	
	<c:set var="video_dto" value="${video_dto }" />
	<c:set var="channel_dto" value="${channel_dto }" />
	<c:set var="channel_good" value="${channel_good }" />
	
	
	<input type="hidden" value="${video_dto.getVideo_code() }" name="video_code" id="video_code">
	
	<jsp:include page="../include/top_include.jsp"/>
	
	<div class="watch_layer">
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
						<p>${video_dto.getVideo_title() }</p>
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
								<div class="channel_info card_c">
									<div id="input_uploader">${channel_dto.getChannel_name()}</div>
									<div id="input_member">구독자 &nbsp; ${channel_good }명</div>
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
					<div class="cont">${video_dto.getVideo_cont() }</div>
				</div>
			</div>
			
			<div class="watch_reply ">
			
				<div class="option_box card_c">
					<div class="item_a">
						<div class="card_a">
							<div class="reply_cnt">댓글 ${reply_count }개</div>
							<div class="dropdown_menu card_c">
								<div><img class="menu_icon" src="${pageContext.request.contextPath}/resources/watch/watch_img/dropdown_menu.svg">정렬기준</div>
								<div id="dropdown" class="dropdown_box">
									<div class="dropdown_wrap card_c">
										<div class="dropdown_content"><a>인기 댓글순</a></div>
										<div class="dropdown_content"><a>최신순</a></div>
									</div>
								</div>								
							</div>
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

function getContextPath(){
	
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}


let video_url = ${video_dto.getVideo_code()} +".mp4"; 

var player = videojs("myPlayer", {
	sources : [
		{ src : getContextPath() +"/resources/Upload/UploadVideo/" +video_url, type : "video/mp4"}
	],
	controls : true,
	playsinline : true,
	muted : true,
	preload : "metadata",
	fluid : true

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






</style>


</html>