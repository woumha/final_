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

#wrap {
/* background-color: yellow; */
width: 100%;
height: 1080px;
}

/* ===============<<!임시!>> top 영역 ===============*/
#top_area {
background-color: purple;
width: 100%;
height: 130px;
opacity:0.8;
position: fixed;
}
/* ================================================ */

/* area 공통 스타일 */
.area_style{
margin-top: 130px;
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
width: 65%;
height: auto;

float: right;
}

/* 오른쪽 사이드 채널 정보 영역 */
#chanel_area {
/* background-color: orange; */
width: 10%;
height: 1000px;
text-align: center;
margin-right: 140px;
float: right;
}
/* 컨텐츠 박스 공통 스타일 */
.content_box {
background-color: white;
width: 100%;
height: auto;
}

/* 미디어 쿼리 스타일영역*/
@media screen and (max-width: 1000px) {
	#chanel_area {
		display: none;
	}
}/* 미디어 쿼리 end */


/* 각 컨텐츠 박스 스타일 */
#watch_box {}
#playlist_box {}
#reply_box {}
#good_box {}

.tset_video {
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
.video_title_p { font-size: 15px; margin-bottom: -5px;}
.video_channel_p { font-size: 10px; margin-bottom: -15px;}
.video_views_p { font-size: 10px; margin-bottom: -15px;}
.video_upload_p { font-size: 10px; margin-bottom: -10px;}

.info_box {
display: inline-block;
width: 170px;
margin-top: 10px;
margin-bottom: 10px;
}
.info_title {float: left;}
.info_cont {float: right;}
.info_title p { margin: 0px;}
.info_cont p { margin: 0px;}


#profile_icon {
/*width: 70px;
height: 70px;
border-radius: 50%; */
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
width: 80%;
}

#profile_box {
margin-bottom: 30px;
}

</style>

</head>
<body>

<div id="wrap">

	<!-- 임시 top 영역 -->
	<div id="top_area">
	
	</div>

	<!-- 왼쪽 사이드 서브 메뉴 영역 -->
	<div id="sub_menu_area" class="area_style">
		
	</div>
	
	<!-- 오른쪽 사이드 채널 정보 영역 -->
	<div id="chanel_area" class="area_style">
		<div id="profile_box">
			<div id="profile_icon">
				<img src="${pageContext.request.contextPath}/resources/img/unnamed.jpg"> 
			</div>
			<div id="profile_name">
			채널 이름
		</div>
		</div>
		
		<div id="profile_info">
			<hr class="channel_hr">
			<div class="info_box">
				<div class="info_title">
					<p>구독</p>
				</div>
				<div class="info_cont">
					<p>0</p>
				</div>
			</div>
			<hr class="channel_hr">
			<div class="info_box">
				<div class="info_title">
					<p>업로드</p>
				</div>
				<div class="info_cont">
					<p>0</p>
				</div>
			</div>
			<hr class="channel_hr">
			<div class="info_box">
				<div class="info_title">
					<p>좋아요</p>
				</div>
				<div class="info_cont">
					<p>0</p>
				</div>
			</div>
		</div>
		
	</div>
	
	<!-- 중앙 메인컨텐츠 영역 -->
	<div id="content_area" class="area_style">
		
		<!-- [기록(시청한 동영상)] 박스 -->
		<div id="watch_box" class="content_box">
			<div class="test">
				<p class="content_title1"><a href="#">기록</a></p>
				<p class="content_title2"><a href="#">모두보기</a></p>
			</div>
			
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">동영상 제목<p>
				<p class="video_channel_p">업로더 채널명<p>
				<p class="video_views_p">조회수 • 업로드 날짜<p>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">동영상 제목<p>
				<p class="video_channel_p">업로더 채널명<p>
				<p class="video_views_p">조회수 • 업로드 날짜<p>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">동영상 제목<p>
				<p class="video_channel_p">업로더 채널명<p>
				<p class="video_views_p">조회수 • 업로드 날짜<p>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">동영상 제목<p>
				<p class="video_channel_p">업로더 채널명<p>
				<p class="video_views_p">조회수 • 업로드 날짜<p>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">동영상 제목<p>
				<p class="video_channel_p">업로더 채널명<p>
				<p class="video_views_p">조회수 • 업로드 날짜<p>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">동영상 제목<p>
				<p class="video_channel_p">업로더 채널명<p>
				<p class="video_views_p">조회수 • 업로드 날짜<p>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">동영상 제목<p>
				<p class="video_channel_p">업로더 채널명<p>
				<p class="video_views_p">조회수 • 업로드 날짜<p>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">동영상 제목<p>
				<p class="video_channel_p">업로더 채널명<p>
				<p class="video_views_p">조회수 • 업로드 날짜<p>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">동영상 제목<p>
				<p class="video_channel_p">업로더 채널명<p>
				<p class="video_views_p">조회수 • 업로드 날짜<p>
			</div>
			<div class="video_box">
				<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<p class="video_title_p">동영상 제목<p>
				<p class="video_channel_p">업로더 채널명<p>
				<p class="video_views_p">조회수 • 업로드 날짜<p>
			</div>
			
		</div>
		
		<hr class="hr_style">
		
		<!-- [재생목록] 박스 -->
		<div id="playlist_box" class="content_box">
			<div class="test">
				<p class="content_title1"><a href="#">재생목록</a></p>
				<p class="content_title2"><a href="#">모두보기</a></p>
			</div>
			<div>
				<div class="video_box">
					<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
					<p class="video_title_p">동영상 제목<p>
					<p class="video_channel_p">업로더 채널명<p>
					<p class="video_views_p">조회수 • 업로드 날짜<p>
				</div>
				<div class="video_box">
					<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
					<p class="video_title_p">동영상 제목<p>
					<p class="video_channel_p">업로더 채널명<p>
					<p class="video_views_p">조회수 • 업로드 날짜<p>
				</div>
				<div class="video_box">
					<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
					<p class="video_title_p">동영상 제목<p>
					<p class="video_channel_p">업로더 채널명<p>
					<p class="video_views_p">조회수 • 업로드 날짜<p>
				</div>
				<div class="video_box">
					<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
					<p class="video_title_p">동영상 제목<p>
					<p class="video_channel_p">업로더 채널명<p>
					<p class="video_views_p">조회수 • 업로드 날짜<p>
				</div>
			</div>
		</div>
	
		<hr class="hr_style">
		
		<!-- [작성한 댓글 리스트] 박스 -->
		<div id="reply_box" class="content_box">
			<div class="test">
				<p class="content_title1"><a href="#">작성한 댓글</a></p>
				<p class="content_title2"><a href="#">모두보기</a></p>
			</div>
			<div></div>
		</div>
		
		<hr class="hr_style">
		
		<!-- [좋아요 표시한 동영상] 박스 -->
		<div id="good_box" class="content_box">
			<div class="test">
				<p class="content_title1"><a href="#">좋아요 표시한 동영상</a></p>
				<p class="content_title2"><a href="#">모두보기</a></p>
			</div>
			<div>
				<div class="video_box">
					<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
					<p class="video_title_p">동영상 제목<p>
					<p class="video_channel_p">업로더 채널명<p>
					<p class="video_views_p">조회수 • 업로드 날짜<p>
				</div>
				<div class="video_box">
					<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
					<p class="video_title_p">동영상 제목<p>
					<p class="video_channel_p">업로더 채널명<p>
					<p class="video_views_p">조회수 • 업로드 날짜<p>
				</div>
				<div class="video_box">
					<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
					<p class="video_title_p">동영상 제목<p>
					<p class="video_channel_p">업로더 채널명<p>
					<p class="video_views_p">조회수 • 업로드 날짜<p>
				</div>
				<div class="video_box">
					<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
					<p class="video_title_p">동영상 제목<p>
					<p class="video_channel_p">업로더 채널명<p>
					<p class="video_views_p">조회수 • 업로드 날짜<p>
				</div>
				<div class="video_box">
					<video class="tset_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
					<p class="video_title_p">동영상 제목<p>
					<p class="video_channel_p">업로더 채널명<p>
					<p class="video_views_p">조회수 • 업로드 날짜<p>
				</div>
			</div>
		</div>
		
	</div>
	
	
	
	
	
	
</div>
	

</body>
</html>