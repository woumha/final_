<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>

<!-- 아이콘 관련 링크 -->
<script src="https://kit.fontawesome.com/ccf3e996b8.js" crossorigin="anonymous"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!--
<script type="text/javascript">
$(document).on("mouseover", ".test_video", function(){
	 $(this).get(0).play();
});

$(document).on("mouseout", ".test_video", function(){
	 $(this).get(0).pause();
});	

/* 넘어온 기본 값 */
let channel_code = "${channel_code}";
let page = 1;
let loading = false;

/* 재생목록 ajax */
function getPlaylist_list(channel_code, page){
	$.ajax({
		url : getContextPath() +"/getPlaylist_list.do",
		data : {
			"channel_code" : channel_code,
			"page" : page,
		},
		datatype : 'JSON',
		contentType : "application/json; charset=UTF-8",
		success : function(data){
			
			let str = data;

			if(str == "[]"){
				loading = false;
				
				$("#playlist_more").css('display', 'none');
				
			}else{
				let good = JSON.parse(data);
				let div = "";
				
				$(good).each(function(){
					div += "<div class='video_box'>";
					div += "<div class='playlist_video_div'>";
					div += "<div class='playlist_lid' onclick='location.href='"+getContextPath()+"/playlist_list.do?channel_code="+channel_code+"&playlist_code="+this.playlist_code+"'>";
					div += "<p class='p_playlist_lid'>재생목록 보기</p>"
					div += "<img class='playlist_lid_img' src='"+${pageContext.request.contextPath}+"/resources/img/playlist_lid1.png'>"
					div += "</div>"
					div += "<video class='video_play' src='https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4' controls></video>"
					div += "</div>"
					div += "<p class='video_title_p' style='margin-top: 5px;'>"+this.playlist_title+"<p>"
					div += "<p class='video_channel_p'>"+${c_info.getChannel_name() }+"<p>"
					div += "</div>"
				});

				$("#playlist_area").append(div);
				
			}
		},
		error : function(){
			alert('getPlaylist_list 불러오기 오류!!!!!!!!!');
		}
	}); 
};

// 기본 실행 함수
console.log("기본 함수 진입!!!!");
getPlaylist_list(channel_code, page);

// 재생목록 더보기 클릭시
$(document).on("click", "#playlist_more", function(){
	console.log("재생목록 더보기 실행!!!!!");
	getPlaylist_list(channel_code, page);
});
</script>
 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/myPage_CSS/myPage.css">
</head>
<body>

<div id="wrap_myPage">

	<!-- top, side 영역 -->
	<jsp:include page="../include/top_include.jsp"/>
	<jsp:include page="../include/side_include.jsp"/>

	
	<c:set var="c_info" value="${m_channel }" />

	<c:if test="${!empty channel_code }">
	<!-- 오른쪽 사이드 채널 정보 영역 -->
	<div id="chanel_area">
		<div id="profile_box">
			<div id="profile_icon"> <img src="${pageContext.request.contextPath}/resources/img/unnamed.jpg"> </div>
			<div id="profile_name"> ${c_info.getChannel_name() } </div>
		</div>
		
		<div id="profile_info">
			<hr class="channel_hr">
			<div class="info_box">
				<div class="info_title"> <p>구독</p> </div>
				<div class="info_cont"> <p>${fn:length(channel_sub)}</p> </div>
			</div>
			
			<hr class="channel_hr">
			
			<div class="info_box">
				<div class="info_title"> <p>업로드</p> </div>
				<div class="info_cont"> <p>${fn:length(channel_video)}</p> </div>
			</div>
			
			<hr class="channel_hr">
			
			<div class="info_box">
				<div class="info_title"> <p>좋아요</p> </div>
				<div class="info_cont"> <p>${fn:length(g_list)}</p> </div>
			</div>
		</div>
	</div>
	
	<!-- 중앙 메인컨텐츠 영역 -->
	<div id="content_area" class="area_style">
		
		<!-- [기록(시청한 동영상)] 박스 -->
		<c:set var="history" value="${h_list }" />
		<div id="history_box" class="content_box">
			<div class="content_title_box">
				<img id="history_logo" src="${pageContext.request.contextPath}/resources/img/history.png">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/history_list.do?channel_code=${channel_code }">기록</a> [${fn:length(h_list)}]</p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/history_list.do?channel_code=${channel_code }">모두보기</a></p>
			</div>
			
			<c:if test="${!empty history }">
				<c:forEach items="${history }" var="h_dto" begin="0" end="9" step="1">
					<div class="video_box">
						<video class="test_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
						<p class="video_title_p_his">${h_dto.getVideo_title() }</p>
						<p class="video_channel_p"><i class='fa-solid fa-circle-user' id='ch_img'></i>&nbsp;${h_dto.getChannel_name() }<p>
						<p class="video_views_p">조회수 ${h_dto.getVideo_view_cnt() }회 <i class="fa-solid fa-carrot"></i> ${h_dto.getVideo_regdate() }<p>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty history }">
				<p class="p_none">시청했던 동영상이 여기에 표시됩니다.</p>
			</c:if>
		</div>
		
		<hr class="hr_style">
		
		<!-- [재생목록] 박스 -->
		<div id="playlist_box" class="content_box">
			<div class="content_title_box">
				<img id="playlist_logo" src="${pageContext.request.contextPath}/resources/img/playlist_lid.png">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/playlist_list.do?channel_code=995">재생목록</a></p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/playlist_list.do?channel_code=995">모두보기</a></p>
			</div>
			
			<c:set var="playlist" value="${p_list }" />
			<c:if test="${!empty playlist }">
			
				<div id="playlist_area"></div>
				<button id="playlist_more">더보기</button>
			</c:if>
			
			<c:if test="${empty playlist }">
				<p class="p_none">만들거나 저장한 재생목록이 여기에 표시됩니다.</p>
			</c:if>
		</div>
		
		<hr class="hr_style">
		
		<!-------------------------------------- [좋아요 표시한 동영상] 박스 -------------------------------------->
		<div id="good_box" class="content_box">
			<div class="content_title_box">
				<img id="good_logo" src="${pageContext.request.contextPath}/resources/img/good.png">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/good_list.do?channel_code=995">좋아요 동영상</a> [${fn:length(g_list)}]</p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/good_list.do?channel_code=995">모두보기</a></p>
			</div>
			
			<c:set var="good" value="${g_list }" />
			<c:if test="${!empty good }">
				<c:forEach items="${good }" var="g_dto" begin="0" end="4" step="1">
					<div class="video_box">
						<video class="test_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
						<p class="video_title_p">${g_dto.getVideo_title() }<p>
						<p class="video_channel_p"><i class='fa-solid fa-circle-user' id='ch_img'></i>&nbsp;${g_dto.getChannel_name() }<p>
						<p class="video_views_p">조회수 ${g_dto.getVideo_view_cnt() }회 <i class="fa-solid fa-carrot"></i> ${g_dto.getVideo_regdate() }<p>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty good }">
				<p class="p_none">좋아요 누른 동영상이 여기에 표시됩니다.</p>
			</c:if>
		</div>
		<!-------------------------------------- [좋아요 표시한 동영상] 끝 -------------------------------------->
		
		<hr class="hr_style">

		<!-------------------------------------- [작성한 댓글 리스트] 박스 -------------------------------------->
		<div id="reply_box" class="content_box">
			<div class="content_title_box">
				<img id="reply_logo" src="${pageContext.request.contextPath}/resources/img/reply.png">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/reply_list.do?channel_code=995">작성한 댓글</a> [${fn:length(reply_list)}]</p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/reply_list.do?channel_code=995">모두보기</a></p>
			</div>
			<c:set var="r_list" value="${reply_list }"  />
			<c:if test="${!empty r_list }">
				<c:forEach  var="r_dto" items="${r_list }" begin="0" end="4" step="1">
					<div class="reply_list">				
						<p class="reply_list_writer">${c_info.getChannel_name() }</p>
						<p class="reply_list_cont">${r_dto.getReply_cont() }</p>
						<c:if test="${r_dto.getReply_regdate() ne null }">
							<p class="reply_list_date">작성일 ${r_dto.getReply_regdate() }</p>
						</c:if>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty r_list }">
				<p class="p_none">작성한 댓글이 여기에 표시됩니다.</p>
			</c:if>
		</div>
	</div>
	</c:if>
	<c:if test="${empty channel_code }">
		<div id="page_none">
			<img id="none_img" src="${pageContext.request.contextPath}/resources/img/myPage_no.jpg">
			<p id="none_title">좋아하는 동영상을 감상해 보세요.</p>
			<p id="none_text">저장하거나 좋아요 표시한 동영상을 보려면 로그인하세요.</p>
			<button id="none_btn" onclick="location.href='<%=request.getContextPath() %>/login.do'">로그인</button>
		</div>
	</c:if>
</div>
</body>
</html>