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

<style type="text/css">

body {
margin: 0;
padding: 0;
}

#wrap_myPage {
/* background-color: yellow; */
width: 100%;
height: 1080px;
}


/* area 공통 스타일 */
.area_style{
}
/* 왼쪽 사이드 서브 메뉴 영역 */
#sub_menu_area{
background-color: gray;
width: 100px;
height: 1080px;

float: left;
}

/* 중앙 메인 컨텐츠 영역 */
#content_area {
/* background-color: blue; */
width: 60%;
height: auto;
margin-top: 30px;
float: right;
}

/* 오른쪽 사이드 채널 정보 영역 */
#chanel_area {
/* background-color: orange; */
width: 10%;
height: 1000px;
text-align: center;
margin-right: 8%;
margin-left: 1%;
float: right;
}
/* 컨텐츠 박스 공통 스타일 */
.content_box {
background-color: white;
width: 100%;
height: auto;
}

.test_video {
border-radius: 10px;
width: 210px;
margin-right: 2px;
margin-left: 2px;
}
.test_video_play {
border-radius: 10px;
width: 210px;
margin-right: 2px;
margin-left: 2px;
}

.video_box {
display: inline-block;
margin-right: 0px;
margin-left: 0px;
margin-bottom: 30px;
}

.video_box p {
margin-top: 0px;
/* margin-bottom: 0px; */
}

.test {
width: 100%;
display: inline-block;
}

.content_title1 {
font-size: 20px;
margin-left: 15px;
float: left;
}

.content_title2 {
margin-right: 40px;
float: right;
text-decoration: none;
vertical-align: middle
}
.content_title1 a { text-decoration: none; }
.content_title2 a { text-decoration: none; vertical-align: middle; }

.hr_style { width: 95%; margin-top: 10px; margin-bottom: 10px;}
.video_title_p {
width: 215px;
font-size: 15px; margin-bottom: -5px;
overflow: hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-line-clamp: 1;
-webkit-box-orient: vertical;
}
.video_title_p_his {
width: 215px;
font-size: 15px; margin-bottom: 12px;
overflow: hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-line-clamp: 1;
-webkit-box-orient: vertical;
}

.video_channel_p { font-size: 12px; margin-bottom: -15px;}
.video_views_p { font-size: 12px; margin-bottom: -15px;}
.video_upload_p { font-size: 10px; margin-bottom: -10px;}

.info_box {
display: inline-block;
width: 90%;
margin-top: 10px;
margin-bottom: 7px;
}
.info_title {float: left;}
.info_cont {float: right;}
.info_title p { margin: 0px; font-size: 13px;}
.info_cont p { margin: 0px; font-size: 13px;}


#profile_icon {
margin-top: 90px;
overflow: hidden;
}

#profile_icon img{
width: 70px;
height: 70px;
border-radius: 50%;
object-fit: cover;
margin-bottom: 10px;
}
.channel_hr {
width: 90%;
}

#profile_box {
margin-bottom: 30px;
}

/* 로그인 안했을 시 */
#page_none {
width: 100%;
height: 800px;
text-align: center;
}
#none_img {
margin-top: 12%;
}
#none_title {
font-size: 30px;
font-weight: bold;
}
#none_text {
font-size: 17px;
}
#none_btn {

}

#reply_box {

margin-bottom: 200px;
/* margin-bottom: 100px; */

}
/* (foreach) 작성한 댓글 리스트 스타일 */
.reply_list {
display: inline-block;
border-radius: 10px;
padding-left: 10px;
width: 200px;
height: 100px;

font-size: 15px;

box-shadow: 5px 5px 5px gray;
border: 1px solid;
}

/* (foreach) 댓글 작성자 p */
.reply_list_writer {
margin-top: 10px;
font-size: 13px;
}
/* (foreach) 댓글 내용 p */
.reply_list_cont {
font-size: 12px;
overflow: hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-line-clamp: 1;
-webkit-box-orient: vertical;
}
/* (foreach) 댓글 업로드 날짜 p */
.reply_list_date {
font-size: 10px;
}


/* ======================= 미디어 쿼리 스타일 영역 ======================= */
@media screen and (max-width: 1088px) {
	#chanel_area {
		display: none;
	}
	/* .content_title2 a {
		margin-right: 150px;
	} */
}
@media screen and (max-width: 600px) {
	
	.content_title2 a {
		margin-right: 0px;
	}
}

/* ========================= 미디어 쿼리 end ========================= */
/* ========================= 사이드바 스타일 ========================= */

/* ======================= 사이드바 스타일 end ======================= */

</style>

</head>
<body>

<div id="wrap_myPage">

	<!-- top 영역 -->
	<jsp:include page="../include/top_include.jsp"/>


	<!-- 왼쪽 사이드 서브 메뉴 영역 -->
	<div id="sub_menu_area" class="area_style">
	</div>
	
	<c:set var="c_info" value="${m_channel }" />

	<c:if test="${!empty h_list }">
	<!-- 오른쪽 사이드 채널 정보 영역 -->
	<div id="chanel_area" class="area_style">
		<div id="profile_box">
			<div id="profile_icon">
				<img src="${pageContext.request.contextPath}/resources/img/unnamed.jpg">
			</div>
			<div id="profile_name">
				${c_info.getChannel_name() }
			</div>
		</div>
		
		<div id="profile_info">
			<hr class="channel_hr">
			<div class="info_box">
				<div class="info_title">
					<p>구독</p>
				</div>
				<div class="info_cont">
					<p>${fn:length(channel_sub)}</p>
				</div>
			</div>
			<hr class="channel_hr">
			<div class="info_box">
				<div class="info_title">
					<p>업로드</p>
				</div>
				<div class="info_cont">
					<p>${fn:length(channel_video)}</p>
				</div>
			</div>
			<hr class="channel_hr">
			<div class="info_box">
				<div class="info_title">
					<p>좋아요</p>
				</div>
				<div class="info_cont">
					<p>${fn:length(g_list)}</p>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 중앙 메인컨텐츠 영역 -->
	<div id="content_area" class="area_style">
		
		<!-- [기록(시청한 동영상)] 박스 -->
		<div id="watch_box" class="content_box">
			<div class="test">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/history_list.do?channel_code=995">기록</a></p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/history_list.do?channel_code=995">모두보기</a></p>
			</div>
			
			<c:set var="history" value="${h_list }" />
			
			<c:forEach items="${history }" var="h_dto" begin="0" end="9" step="1">
			<div class="video_box">
				<video class="test_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p_his">${h_dto.getVideo_title() }</p>
				<p class="video_channel_p">${h_dto.getChannel_name() }<p>
				<p class="video_views_p">조회수 ${h_dto.getVideo_view_cnt() }회 • ${h_dto.getVideo_regdate().substring(0,10) }<p>
			</div>
			</c:forEach>
		</div>
		
		<hr class="hr_style">
		
		<!-- [재생목록] 박스 -->
		<div id="playlist_box" class="content_box">
			<div class="test">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/playlist_list.do?channel_code=995">재생목록</a></p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/playlist_list.do?channel_code=995">모두보기</a></p>
			</div>
			
			<c:set var="playlist" value="${p_list }" />
			
			<c:forEach items="${playlist }" var="p_dto" begin="0" end="9" step="1">
			<div class="video_box">
				<!-- 재생목록 덮개 -->
<style>
.playlist_lid {
position: absolute;
text-align: center;
width: 50%;
height: 118px;
background-color: black;

margin-top: 0px;

opacity:0.8; /* 불투명도 */
margin-left: 108px;

border-top-right-radius: 10px;
border-bottom-right-radius: 10px;

cursor: pointer;

z-index: 3;
}
.test_video_play {
position: absolute;
z-index: 2;
}
.playlist_video_div {
position: relative;
width: 210px;
height: 119px;
}
.playlist_lid_img {
width: 20px;
color: white;
margin-left: 0px;


}
.playlist_lid p {
font-size: 18px;
color: white;
margin-top: 26px;
margin-bottom: 5px;
margin-left: 0px;
}
</style>
				
				
				<div class="playlist_video_div">
					<!-- 재생목록 덮개 영역 -->
					<div class="playlist_lid" onclick="location.href='<%=request.getContextPath() %>/playlist_no_page.do?playlist_no=${p_dto.getPlaylist_no() }'">
						<p>3</p>
						<img class="playlist_lid_img" src="${pageContext.request.contextPath}/resources/img/playlist_lid1.png">
					</div>
					<video class="test_video_play" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				</div>
				<p class="video_title_p">${p_dto.getPlaylist_title() }<p>
				<p class="video_channel_p">${c_info.getChannel_name() }<p>
				<%-- <p class="video_views_p">조회수 ${p_dto.getVideo_view_cnt() }회 • ${p_dto.getVideo_regdate().substring(0,10) }<p> --%>
			</div>
			</c:forEach>
		</div>
	
		
		<hr class="hr_style">
		
		<!-- [좋아요 표시한 동영상] 박스 -->
		<div id="good_box" class="content_box">
			<div class="test">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/good_list.do?channel_code=995">좋아요 표시한 동영상</a> [${fn:length(g_list)}]</p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/good_list.do?channel_code=995">모두보기</a></p>
			</div>
			
			<c:set var="good" value="${g_list }" />
			
			<c:forEach items="${good }" var="g_dto" begin="0" end="9" step="1">
			<div class="video_box">
				<video class="test_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">${g_dto.getVideo_title() }<p>
				<p class="video_channel_p">${g_dto.getChannel_name() }<p>
				<p class="video_views_p">조회수 ${g_dto.getVideo_view_cnt() }회 • ${g_dto.getVideo_regdate().substring(0,10) }<p>
			</div>
			</c:forEach>
		</div>
		
		<hr class="hr_style">

		<!-- [작성한 댓글 리스트] 박스 -->
		<div id="reply_box" class="content_box">
			<div class="test">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/reply_list.do?channel_code=995">작성한 댓글</a> [${fn:length(reply_list)}]</p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/reply_list.do?channel_code=995">모두보기</a></p>
			</div>
			<c:set var="r_list" value="${reply_list }"  />
			<c:forEach  var="r_dto" items="${r_list }" begin="0" end="9" step="1">
			<div class="reply_list">				
				<p class="reply_list_writer">${c_info.getChannel_name() }</p>
				<p class="reply_list_cont">${r_dto.getReply_cont() }</p>
				<c:if test="${r_dto.getReply_regdate() ne null }">
					<p class="reply_list_date">작성일 ${r_dto.getReply_regdate().substring(0,10) }</p>
				</c:if>
				<c:if test="${r_dto.getReply_regdate() eq null }">
					<p class="reply_list_date">${r_dto.getReply_update().substring(0,10) }•수정됨 </p>
				</c:if>
			</div>
			</c:forEach>
			
		</div>
	</div>
	</c:if>
	<c:if test="${empty h_list }">
	<div id="page_none">
		<img id="none_img" src="${pageContext.request.contextPath}/resources/img/myPage_no.jpg">
		<p id="none_title">좋아하는 동영상을 감상해 보세요.</p>
		<p id="none_text">저장하거나 좋아요 표시한 동영상을 보려면 로그인하세요.</p>
		<button id="none_btn">로그인</button>
	</div>
	</c:if>
	
	
	
</div>
	

</body>
</html>