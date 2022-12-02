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
			
			<div class="watch_reply option">
			
			</div>
			
			<div class="watch_reply ">
				<p>${dto.getChannel_code() }</p>
			</div>
		</div>

	
		<div class="side_box">
		</div>
	</div>

	



</body>

<script type="text/javascript">

var player = videojs("myPlayer", {
    sources : [
        { src : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", type : "video/mp4"}
    ],
    controls : true,
    playsinline : true,
    muted : true,
    preload : "metadata",
   	fluid : true

});

/* player.addClass('vjs-matrix'); */

$(document).ready(function() {
	
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

.container_L{
	position: fixed;
	width: 102px;
	background-color: maroon;
}

.container {

	margin: 0 auto;
	display: flex;
	flex-direction: row;
}


.watch_container {
	
	flex: 1;
	background-color: red;
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
	background-color: yellow;
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

.card_e{
	display: flex;
	justify-content: flex-end;
	flex-direction: row;
	align-items: center;
}


/* 해시태그 CSS */
.hash_box{

	text-align:left;
	background-color: orange;	
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


/* 채널 정보 CSS */
.channel_wrap{
	flex-basis: 50%;
}

.profile{
	width: 40px;
	height: 40px;
	border-radius: 50%;
	object-fit: cover;
	margin-bottom: 10px;
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


/* 사이드바 CSS */
.side_box {
	flex: 1;
	background-color: blue;
}







</style>


</html>