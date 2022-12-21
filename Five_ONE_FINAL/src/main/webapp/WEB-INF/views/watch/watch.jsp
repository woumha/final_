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
<script type="text/javascript" src="${path }/resources/watch/watch_JS/watch_event.js"></script>


<link rel="stylesheet" href="${path }/resources/watch/watch_CS/watch.css">

</head>
<body>
	
	<c:set var="video_dto" value="${video_dto }" />
<%-- 	<c:set var="channel_good" value="${channel_good }" /> --%>
	<c:set var="reply_count" value="${reply_count }" />
	<c:set var="playList_dto" value="${playlist_dto }"/>
	<c:set var="subscribe_dto" value="${subscribe_dto }"/>
	<c:set var="good_dto" value="${good_dto }"/>
	
	
	<input type="hidden" value="${video_dto.getVideo_code() }" id="video_code">
	<input type="hidden" value="${video_dto.getChannel_code() }" id="channel_code">
	<input type="hidden" value="${video_dto.getCategory_code() }" id="category_code">
	
	<jsp:include page="../include/top_include2.jsp"/>
	<%-- <jsp:include page="../include/side_include.jsp"/> --%>
<div class="all">
	
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
									<div id="input_uploader">${video_dto.getChannel_name()}</div>
									<div id="input_member">구독자 &nbsp; ${video_dto.getChannel_like() }명</div>
								</div>
							</div>
							
							<div class="item_a">
							
								<c:if test="${empty subscribe_dto }">
									<button class="subscribe_false">
										<div>구독</div>
									</button>
								</c:if>
								<c:if test="${!empty subscribe_dto }">
									<button class="subscribe_true">
										<div>구독중</div>
									</button>
								</c:if>
								
							</div>
						</div>
					</div>
					<div class="channel_wrap">
						<div class="card_e">
							<div class="item_a btn_wrap card_a">
								<button class="watch_good_btn card_b">
										<div class="card_b">
											<c:if test="${good_dto.getGood_bad() != 1}">
												<img class="good" src="${pageContext.request.contextPath}/resources/watch/watch_img/good_icon.svg">
											</c:if>
											<c:if test="${good_dto.getGood_bad() == 1}">
												<img class="good" src="${pageContext.request.contextPath}/resources/watch/watch_img/good_icon_selected.svg">
											</c:if>
												<div>좋아요</div>
										</div>
								</button>
								<button class="watch_bad_btn card_b">
										<div class="card_b">
											<c:if test="${good_dto.getGood_bad() != 2}">
												<img class="bad" src="${pageContext.request.contextPath}/resources/watch/watch_img/bad_icon.svg">
											</c:if>
											<c:if test="${good_dto.getGood_bad() == 2}">
												<img class="bad" src="${pageContext.request.contextPath}/resources/watch/watch_img/bad_icon_selected.svg">
											</c:if>
												<div>싫어요</div>
										</div>
								</button>
							</div>
							<div class="item_a btn_wrap">
								<button class="watch_btn">
									<div class="share">공유</div>
								</button>
							</div>
							
							<div class="item_a btn_wrap">
								<button class="watch_btn">
									<div class="save">오프라인 저장</div>
								</button>
							</div>
							
							<div class="item_a btn_wrap">
								<button class="watch_btn">
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
							<div class="card_c">
								<div class="dropdown_menu"><img class="menu_icon" src="${pageContext.request.contextPath}/resources/watch/watch_img/dropdown_menu.svg">정렬기준</div>
								<div id="dropdown" class="dropdown_box">
									<div id="dropdown_wrap" class="dropdown_wrap card_c">
										<div class="dropdown_content"><a class="video_option" data-value="most">인기 댓글순</a></div>
										<div class="dropdown_content"><a class="video_option" data-value="reply_regdate">최신순</a></div>
									</div>
								</div>								
							</div>
						</div>
					</div>
					
					<div class="item_a">
						<div>
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
												<button class="watch_btn">
													<div class="cancle_btn">취소</div>
												</button>
											</div>
											<div class="item_reply btn_wrap">
												<button class="watch_btn">
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
			
				
				
				<!-- 댓글영역 시작 -->
				<div id="input_reply_box">
				
				</div>
<%-- 	 			<div class="reply_box card_a">
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
			
			
				<!-- 대댓글영역 시작 -->
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
				</div> <!-- 댓글영역 end -->	 --%>
				
			</div> <!-- 댓글 end -->
		</div> <!-- watch container end -->

	
		<div class="side_container">
			<c:if test="${!empty playList_dto }">
				<div>리스트 있음</div>
			</c:if>
			
			
			<div class="video_list_wrap card_c">
				<div class="menu_container">
				  <div class="button_container">
				    <button id="slide_left"><</button>
				  </div>
				  <div class="scrollmenu">
				    <a class="scrollmenu_btn" href="#" onclick="return false;" data-value="all">모두</a>
				    <a class="scrollmenu_btn" href="#" onclick="return false;" data-value="category">관련 콘텐츠</a>
				    <a class="scrollmenu_btn" href="#" onclick="return false;" data-value="current">최근에 업로드된 영상</a>
				    <a class="scrollmenu_btn" href="#" onclick="return false;" data-value="history">감상한 동영상</a>
				  </div> 
				  <div class="button_container">
				    <button id="slide_right">></button>
				  </div>
				</div>
				<div id="input_video_list_all" class="input_video_list">
					<%-- <div class="video_list_box card_a">
					
						<div class="video_list_thumbnail">
							<a>
								<img class="video_list_img" src="${pageContext.request.contextPath}/resources/watch/watch_img/render_icon.png">
							</a>
						</div>
						
						<div class="video_list_info card_c">
							<div class="video_list_title">title</div>
							<div class="video_list_channel_name">name</div>
							<div class="video_list_meta_block">
								<span class="video_list_view_cnt">cnt</span>
								<span class="video_list_date">date</span> 
							</div>
								
						</div>
						
						<div class="render_box">
							<div class="render_wrap">
								<button class="render">
									<img class="render_icon" src="${pageContext.request.contextPath}/resources/watch/watch_img/render_icon.png">
								</button>
							</div>
						</div>
					</div><!-- video_list_box end --> --%>
				</div> <!-- input_video_list end -->
				<div id="input_video_list" class="input_video_list">
				</div>
			</div><!-- video_list_wrap end -->
						
		</div> <!-- side_box end -->
		
		<%-- <jsp:include page="../include/side_include.jsp"/> --%>
	</div>
</div>
	



</body>

<script type="text/javascript">

function getContextPath(){
	
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}

let vid = ${video_dto.getVideo_code()};


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