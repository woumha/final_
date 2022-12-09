<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 모달창 관련 링크 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<!-- 모달창 관련 링크 end -->
<style type="text/css">

html {
/* 항상 우측 스크롤바 표시 */
overflow-y : scroll;
}

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
float: left;
margin-left: 14%;
}

/* 오른쪽 사이드 채널 정보 영역 */
#chanel_area {
/* background-color: orange; */
width: 250px;
margin-top: 100px;

position: fixed;
right: 10%;
}
/* 컨텐츠 박스 공통 스타일 */
.content_box {
background-color: white;
width: 100%;
height: auto;
display: inline-block;
}

/* ------------- 동영상 설정 ------------- */
.test_video {
border-radius: 10px;
width: 250px;
margin-right: 10px;
margin-left: 2px;
}
/* ----------- 동영상 설정 end ----------- */
.video_box {
display: inline-block;
margin-right: 0px;
margin-left: 0px;
margin-bottom: 30px;
}

.video_pbox {
width: 550px;
vertical-align: top;
margin-top: 0px;
display: inline-block;
word-break:break-all;
}

.test {
width: 100%;
display: inline-block;
}

.content_title1 {
font-size: 20px;
margin-left: 15px;
}


.content_title1 a { text-decoration: none; }

.video_title_p {
font-size: 22px; margin-bottom: -10px; margin-top: 0px;
overflow: hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-line-clamp: 2;
-webkit-box-orient: vertical;
}
.video_channel_p { font-size: 12px; margin-bottom: 0px; margin-top: 0px;}
.video_views_p {
font-size: 12px;
margin-top: 30px;
overflow: hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-line-clamp: 2;
-webkit-box-orient: vertical;
}


.btn {
background-color: white;
font-size: 15px;
color: black;
text-decoration: none;

margin-left: 10px;
}
.btn span{
font-size: 20px;
}

.info_hr {
margin-top: 20px;
margin-bottom: 20px;
}

/* ========================= 사이드바 스타일 ========================= */

/* ======================= 사이드바 스타일 end ======================= */
@media screen and (max-width: 500px) {
	
	#sub_menu_area {
		display: none;
	}
}

#history_search_area {
  position: relative;
  width: 200px;
  margin-bottom: 70px;
}

.history_search {
  width: 100%;
  /* border: 1px solid #bbb;
  border-radius: 8px; */
  border: none;
  padding: 10px 12px;
  font-size: 14px;
}

#search_img {
  position : absolute;
  width: 17px;
  top: 10px;
  right: 5px;
  margin: 0;
}

.video_history_d_img {
display: inline-block;
width: 25px;
vertical-align: top;
}
.video_history_d_img:hover {
cursor: pointer;
}

</style>

</head>
<body>

<div id="wrap_myPage">

	<!-- top, side 영역 -->
	<jsp:include page="../include/top_include.jsp"/>
	<jsp:include page="../include/side_include.jsp"/>
	
	<!-- 모달창 관련 링크 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

	
	<!-- 오른쪽 사이드 채널 정보 영역 -->
	<div id="chanel_area" class="area_style">
		<div id="history_search_area">
			<form action="<%=request.getContextPath()%>/playlist_search.do">
				<input type="hidden" name="channel_code" value="${channel_code }">
				<input type="hidden" name="playlist_no" value="${playlist_no }">
				<input type="text" class="history_search" name="keyword" placeholder="재생목록 검색">
				<input id="search_img" type="image" src="${pageContext.request.contextPath}/resources/img/search_img.jpg">
			</form>
			
		</div>
	
		<div id="profile_info">
			<div class="info_box">
				<div class="info_title">
					<p><a class="btn" href="<%=request.getContextPath() %>/myPage_go.do?channel_code=995"><span>🗃</span> 내 보관함</a></p>
				</div>
			</div>
			
			<hr class="info_hr">
			
			<div class="info_box">
				<div class="info_title">
					<p><a class="btn" href="#playlist_delete"><span>🗑</span>&nbsp;재생목록 삭제</a></p>
				</div>
			</div>
			
			<hr class="info_hr">
			
			<div class="info_box">
				<div class="info_title">
					<p><a class="btn" href="#playlist_stop"><span>✂</span>&nbsp;시청 기록 일시정지</a></p>
				</div>
			</div>
			
		</div>
	</div>
	
	<!-- 중앙 메인컨텐츠 영역 -->
	<c:set var="playlist" value="${playlist_list }" />
	<div id="content_area" class="area_style">
		
		<!-- [재생목록 박스] -->
		<div id="watch_box" class="content_box">
			<c:if test="${!empty playlist }">
			<div class="test">
				<p class="content_title1">
					<a href="<%=request.getContextPath() %>/playlist_list.do?channel_code=${channel_code }&playlist_title=${playlist_title }&playlist_no=${playlist_no }">
						재생목록
					</a>
				</p>
			</div>
			
			
			<c:forEach items="${playlist }" var="p_dto">
			<div class="video_box">
				<video class="test_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<div class="video_pbox">
					<p class="video_title_p">${p_dto.getVideo_title() }<p>
					<p class="video_channel_p">${p_dto.getChannel_name() } • 조회수 ${p_dto.getVideo_view_cnt() }회<p>
					<p class="video_views_p">${p_dto.getVideo_cont() }<p>
				</div>
				<a href="<%=request.getContextPath() %>/playlist_one_delete.do?video_code=${p_dto.getVideo_code() }&channel_code=${channel_code }&playlist_no=${playlist_no }">
					<img class="video_history_d_img" src="${pageContext.request.contextPath}/resources/img/delete.png">
				</a>
			</div>
			</c:forEach>
			</c:if>
			<c:if test="${empty playlist }">
				<p>목록에 동영상이 없습니다.</p>
				<p><a class="btn" href="<%=request.getContextPath() %>/myPage_go.do?channel_code=995"><span>🗃</span>보관함으로 돌아가기</a></p>
			</c:if>
		</div>
	</div>
<style>
.modal {
max-width: 780px;
height: 300px;
}
.modal a.close-modal {
top: 5.5px;
right: 5.5px;
}
#h_d_title {
margin-top: 25px;
font-size: 25px;
}
#h_d_btn {
float: right;
margin-right: 10px;
margin-bottom: 10px;
}
#h_s_title {
font-size: 25px;
}
#h_s_btn {
float: right;
margin-right: 10px;
margin-bottom: 10px;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<!-- ======================== 모달창 관련 영역 ========================  -->
<div id="playlist_delete" class="modal">
	<p id="h_d_title">시청 기록을 삭제할까요?</p>
	<p>VIDIDI 시청 기록이 모든 기기의 모든 VIDIDI 앱에서 삭제됩니다.(임시 내용입니다)</p>
	<br>
	<p>맞춤 동영상이 재설정되지만 다른 제품에서의 활동으로부터 계속 영향을 받을 수 있습니다.</p>
	<br>
	<button id="h_d_btn" onclick="location.href='delete_playlist.do?channel_code=${channel_code}&playlist_no=${playlist_no }'">시청 기록 지우기</button>
</div>
<div id="playlist_stop" class="modal">
	<p id="h_s_title">시청 기록을 중지할까요?</p>
	<p>VIDIDI 시청 기록이 모든 기기의 모든 VIDIDI 앱에서 기록 중지됩니다.(임시 내용입니다)</p>
	<br>
	<p>맞춤 동영상이 재설정되지만 다른 제품에서의 활동으로부터 계속 영향을 받을 수 있습니다.</p>
	<br>
	<button id="h_s_btn" onclick="location.href='dont_save_playlist.do?member_code=VD00002'">시청 기록 중지하기</button>
</div>
<!-- ====================== 모달창 자바 스크립트 영역 ====================== -->
<script>
	$('a[href="#playlist_delete"]').click(function(event) {
 		event.preventDefault();
		$(this).modal({
			fadeDuration: 250
		});
	});
	$('a[href="#playlist_stop"]').click(function(event) {
 		event.preventDefault();
		$(this).modal({
			fadeDuration: 250
		});
	});
</script>	
<!-- ======================= 모달창 관련 영역 end =======================  -->
</body>
</html>