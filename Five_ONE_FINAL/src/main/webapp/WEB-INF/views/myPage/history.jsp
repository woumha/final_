<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
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
float: left;
margin-left: 12%;
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
.tset_video {
border-radius: 10px;
width: 300px;
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
font-size: 20px; margin-bottom: -10px; margin-top: 0px;
overflow: hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-line-clamp: 2;
-webkit-box-orient: vertical;
}
.video_channel_p { font-size: 12px; margin-bottom: 0px; margin-top: 0px;}
.video_views_p {
font-size: 10px; margin-bottom: -15px;
overflow: hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-line-clamp: 2;
-webkit-box-orient: vertical;
}
.video_upload_p { font-size: 10px; margin-bottom: -10px;}

.info_title button {
border: 0;
outline: 0;
background-color: white;
font-size: 15px;

margin-left: 10px;
}
.info_title button span{
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
</style>

</head>
<body>

<div id="wrap_myPage">

	<!-- top 영역 -->
	<jsp:include page="../include/top_include.jsp"/>


	<!-- 왼쪽 사이드 서브 메뉴 영역 -->
	<div id="sub_menu_area" class="area_style">
	</div>
	
	<!-- 오른쪽 사이드 채널 정보 영역 -->
	<div id="chanel_area" class="area_style">
		<div id="profile_info">
			<div class="info_box">
				<div class="info_title">
					<button> <span>🗑</span> &nbsp;시청 기록 지우기 </button>
				</div>
			</div>
			<hr class="info_hr">
			<div class="info_box">
				<div class="info_title">
					<button> <span>🚦</span> 시청 기록 일시정지 </button>
				</div>
			</div>
			<hr class="info_hr">
			<div class="info_box">
				<div class="info_title">
					<button> <span>✂</span> 시청 기록 전체관리 </button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 중앙 메인컨텐츠 영역 -->
	<div id="content_area" class="area_style">
		
		<!-- [기록(시청한 동영상)] 박스 -->
		<div id="watch_box" class="content_box">
			<div class="test">
				<p class="content_title1"><a href="#">시청 기록</a></p>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<div class ="video_pbox">
					<p class="video_title_p">동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목<p>
					<p class="video_channel_p">업로더 채널명 • 조회수<p>
					<p class="video_views_p">abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcaabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcbcabcabcabcabc<p>
				</div>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<div class ="video_pbox">
					<p class="video_title_p">동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목<p>
					<p class="video_channel_p">업로더 채널명 • 조회수<p>
					<p class="video_views_p">abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcaabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcbcabcabcabcabc<p>
				</div>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<div class ="video_pbox">
					<p class="video_title_p">동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목<p>
					<p class="video_channel_p">업로더 채널명 • 조회수<p>
					<p class="video_views_p">abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcaabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcbcabcabcabcabc<p>
				</div>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<div class ="video_pbox">
					<p class="video_title_p">동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목<p>
					<p class="video_channel_p">업로더 채널명 • 조회수<p>
					<p class="video_views_p">abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcaabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcbcabcabcabcabc<p>
				</div>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<div class ="video_pbox">
					<p class="video_title_p">동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목<p>
					<p class="video_channel_p">업로더 채널명 • 조회수<p>
					<p class="video_views_p">abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcaabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcbcabcabcabcabc<p>
				</div>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<div class ="video_pbox">
					<p class="video_title_p">동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목<p>
					<p class="video_channel_p">업로더 채널명 • 조회수<p>
					<p class="video_views_p">abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcaabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcbcabcabcabcabc<p>
				</div>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<div class ="video_pbox">
					<p class="video_title_p">동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목동영상 제목<p>
					<p class="video_channel_p">업로더 채널명 • 조회수<p>
					<p class="video_views_p">abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcaabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcbcabcabcabcabc<p>
				</div>
			</div>
		</div>
		
	</div>

</div>
	

</body>
</html>