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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<script src="https://vjs.zencdn.net/7.20.3/video.min.js"></script>
<link href="//vjs.zencdn.net/7.20.3/video-js.min.css" rel="stylesheet">

<script type="text/javascript" src="${path }/resources/watch/watch_JS/watch.js"></script>
<script type="text/javascript" src="${path }/resources/watch/watch_JS/watch_event.js"></script>
<link rel="stylesheet" href="${path }/resources/watch/watch_CS/watch.css">


</head>
<body>
	
	<c:set var="video_dto" value="${video_dto }" />
	<c:set var="reply_count" value="${reply_count }" />
	<c:set var="playList_dto" value="${playlist_dto }"/>
	<c:set var="subscribe_dto" value="${subscribe_dto }"/>
	<c:set var="good_dto" value="${good_dto }"/>
	
	<input type="hidden" value="${video_dto.getVideo_code() }" id="video_code">
	<input type="hidden" value="${video_dto.getVideo_title() }" id="video_title">
	<input type="hidden" value="${video_dto.getChannel_code() }" id="channel_code">
	<input type="hidden" value="${video_dto.getCategory_code() }" id="category_code">
	<input type="hidden" value="${good_dto.getGood_code()}" id ="good_code">
	<input type="hidden" value="${subscribe_dto.getSubscribe_code() }" id="subscribe_code">
	<input type="hidden" value="${channel_dto.getChannel_profil()}" id="profil">
	<input type="hidden" value="${video_dto.getVideo_img() }" id="video_img">
	
	<jsp:include page="../include/top_include.jsp"/>
	<%-- <jsp:include page="../include/side_include.jsp"/> --%>
<div class="all">
	<div class="watch_layer">
		<div class="container_L">
		</div>
		<div class="watch_container">
			<div class="video_box">
				<div class="video_wrap">
					<video id="myPlayer" class="video-js vjs-default-skin vjs-16-9 vjs-big-play-centered" ></video>
					<!-- <video id="myPlayer" class="video-js vjs-theme-city player" controls="controls" autoplay="autoplay"></video> -->
				</div>
			</div>
			
			<div class="watch_info">
			
<!-- 				<div class="hash_box">
					<div id="input_hash">
						<a href="#">#해시태그</a>
					</div>
				</div> -->
				
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
								<a href="${pageContext.request.contextPath}/channel.do?mc=${video_dto.getChannel_code() }">
									<img class="profile channel-backcolor" src="${pageContext.request.contextPath}/resources/img/channel_profile/${video_dto.getChannel_profil()}">
								</a>
								</div>
							</div>
							
							<div class="item_a">
								<div class="channel_info card_c">
									<div class="input_uploader">${video_dto.getChannel_name()}</div>
									<div class="input_member">구독자 &nbsp; ${video_dto.getChannel_like() }명</div>
								</div>
							</div>
							
							<div  class="item_a">
								<c:if test="${empty subscribe_dto }">
									<button id="subscribe_btn" class="subscribe_false">
										<div>구독</div>
									</button>
								</c:if>
								<c:if test="${!empty subscribe_dto }">
									<button id="subscribe_btn" class="subscribe_true">
										<div class="subscribe_text">구독중</div>
									</button>
								</c:if>
								
							</div>
						</div>
					</div>
					<div class="channel_wrap">
						<div class="card_e">
							<c:if test="${empty good_dto.getGood_bad() }">
								<div class="item_a btn_wrap card_a" data-value="0">
							</c:if>
							<c:if test="${!empty good_dto.getGood_bad() }">
								<div class="item_a btn_wrap card_a" data-value="${good_dto.getGood_bad() }">
							</c:if>
									<button class="watch_good_btn card_b" >
										<div class="card_b">
											<c:if test="${good_dto.getGood_bad() != 1}">
												<img class="good" src="${pageContext.request.contextPath}/resources/watch/watch_img/good_icon.svg">
											</c:if>
											<c:if test="${good_dto.getGood_bad() == 1}">
												<img class="good" src="${pageContext.request.contextPath}/resources/watch/watch_img/good_icon_selected.svg">
											</c:if>
												<div class="good_cnt">${videoGood_count }</div>
										</div>
								</button>
								<button class="watch_bad_btn" data-value="${good_dto.getGood_bad() }">
										<div>
											<c:if test="${good_dto.getGood_bad() != 2}">
												<img class="bad" src="${pageContext.request.contextPath}/resources/watch/watch_img/bad_icon.svg">
											</c:if>
											<c:if test="${good_dto.getGood_bad() == 2}">
												<img class="bad" src="${pageContext.request.contextPath}/resources/watch/watch_img/bad_icon_selected.svg">
											</c:if>
										</div>
								</button>
							</div><!-- .btn_wrap -->
<!-- 							<div class="item_a btn_wrap">
								<button class="watch_btn">
									<div class="share">공유</div>
								</button>
							</div> -->
							
							<div class="item_a btn_wrap">
								<button class="watch_btn savePlaylist_btn">
									<div class="save">재생목록 추가</div>
								</button>
							</div>
							
<!-- 							<div class="item_a btn_wrap">
								<button class="watch_btn">
									<div class="other">기타</div>
								</button>
							</div> -->
						</div>
					</div>
				</div> <!-- watch_info end -->
				
				
				<div class="cont_box">
					<div class="input_cont">
						<span>조회수&nbsp;${video_dto.getVideo_view_cnt() }</span>&nbsp;&nbsp;
						<span>날짜&nbsp;${video_dto.getVideo_regdate() }</span>
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
					
					<c:if test="${!empty RepChannelCode }">
					<div class="item_a">
						<div>
							<div class="card_a">
								<div class="input_profile"><img class="profile" src="${pageContext.request.contextPath}/resources/img/channel_profile/${channel_dto.getChannel_profil()}"></div>
								<div class="write_box">
									<div class="item_a write_field">
										<div id="reply_cont" class="reply_cont" contenteditable="true" placeholder="댓글 추가..."></div>
									</div>

									<div class="item_a card_b">
										<div></div> <!-- 이모티콘 -->
										<div class="card_e">
											<div class="item_reply btn_wrap">
												<button id="reply_cancle" class="watch_btn">
													<div class="cancle_btn">취소</div>
												</button>
											</div>
											<div class="item_reply btn_wrap">
												<button id="reply_complete" class="watch_btn watch btn btn-secondary" data-bs-placement="right" data-bs-content="완료">
													<div class="reply_btn">댓글 입력</div>
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					</c:if>
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
				    <a class="scrollmenu_btn important" href="#" onclick="return false;" data-value="all">모두</a>
				    <a class="scrollmenu_btn important" href="#" onclick="return false;" data-value="category">관련 콘텐츠</a>
				    <a class="scrollmenu_btn important" href="#" onclick="return false;" data-value="current">최근에 업로드된 영상</a>
				    <a class="scrollmenu_btn important" href="#" onclick="return false;" data-value="history">감상한 동영상</a>
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
						
		</div> <!-- side_container end -->
		
		<jsp:include page="../include/side_include.jsp"/>
	</div>
</div>

<div class="savePlaylist_container">
	<div class="savePlaylist_wrap">
		<div class="savePlaylist_top card_a">
		<div class="savePlaylist_title">저장하기</div>
		<div class="savePlaylist_close_btn">x</div>			
		</div>
	
		<div class="savePlaylist_box">
			<div class="list-group" id="input_bundleList">
		<!-- 	  <label class="list-group-item">
			    <input class="form-check-input me-1" type="checkbox" value="">
			    First checkbox
			  </label>
			  <label class="list-group-item">
			    <input class="form-check-input me-1" type="checkbox" value="">
			    Second checkbox
			  </label>
			  <label class="list-group-item">
			    <input class="form-check-input me-1" type="checkbox" value="">
			    Third checkbox
			  </label>
			  <label class="list-group-item">
			    <input class="form-check-input me-1" type="checkbox" value="">
			    Fourth checkbox
			  </label>
			  <label class="list-group-item">
			    <input class="form-check-input me-1" type="checkbox" value="">
			    Fifth checkbox
			  </label>
			  <label class="list-group-item">
			    <input class="form-check-input me-1" type="checkbox" value="">
			    Fifth checkbox
			  </label>
			  <label class="list-group-item">
			    <input class="form-check-input me-1" type="checkbox" value="">
			    Fifth checkbox
			  </label>			  --> 
			</div>
					
		</div>	
		
		<div class="newPlaylist">
			<button class="newPlaylist_btn">
				새 재생목록 만들기
			</button>
		</div>
		
		<div class="newPlaylist_input_box">
			<input class="input_playlist_title" id="playlist_title" placeholder="새 재생목록 제목">
			<input type="hidden" id="playlist_open" value="2">
			
			<div class="dropdown">
			  <button class="btn btn-secondary dropdown-toggle playlist_dropdown" type="button" id="playlist_btn_text" data-bs-toggle="dropdown" aria-expanded="false">
			    공개 여부
			  </button>
			  <ul class="dropdown-menu dropdown-menu-dark playlist_dropdown" aria-labelledby="dropdownMenuButton2">
			    <li><a class="dropdown-item" href="#" onclick="return false;" data-value="0">공개</a></li>
			    <li><a class="dropdown-item" href="#" onclick="return false;" data-value="1">비공개</a></li>
			  </ul>
			  
			  
			  
			  
			  <div id="complete_playlist" class="complete_playlist">
			  	<button id="newPlaylist_check" type="button" class="btn btn-secondary"  data-bs-placement="right" data-bs-content="완료" >
 					만들기
				</button>
			  </div>
			</div>				

		</div>		
		
		
	</div>
</div>




</body>

<!-- <script type="text/javascript">

function getContextPath(){
	
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}

//let video_url = ${video_dto.getVideo_code()} +".mp4"; 
let url_channel_code = $("#channel_code").val()
let url_video_title = $("#video_title").val();

let video_url = url_channel_code + "/" +url_video_title+ ".mp4"; 

console.log("url>" +video_url);



var player = videojs("myPlayer", {
	sources : [
		//{ src : getContextPath() +"/webapp/resources/AllChannel/" +video_url, type : "video/mp4"}
		//{ src : getContextPath() +"/webapp/resources/AllChannel/CH-a6ab151d-eacd-481e-8b6f-3bfd31665e6b/나만.mp4", type : "video/mp4"}
		{ src : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", type : "video/mp4"}
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


</script> -->



</html>