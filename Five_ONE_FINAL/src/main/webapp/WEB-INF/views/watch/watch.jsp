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
	
	<div class="container">
		<div class="watch_box">
			<div class="watch_info video">
				<video id="myPlayer" class="video-js vjs-theme-city player" controls="controls" autoplay="autoplay"></video>
			</div>
			
			<div class="watch_info hash">
				<div id="watch_hash">
					<a href="#">#해시태그</a>
				</div>
			</div>
			
			<div class="watch_info title">
				<div id="input_title">
					<div id="video_title">
					<p>${dto.getVideo_title() }</p>
					</div>
				</div>

			</div>
			
			<div class="watch_info menu">
				<div class="menubar_channel">
					
				</div>
				
				<div class="menubar_button">
					<div class="menubar good">
					
					</div>
					
					<div class="menubar bad">
						
					</div>
					
					<div class="menubar save">
					
					</div>
					
					<div class="menubar toggle">
					
					</div>
				</div>
			</div>
			
			<div class="watch_info cont">
				<p>${dto.getVideo_cont() }</p>
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
    preload : "metadata"
});

/* player.addClass('vjs-matrix'); */

$( document ).ready(function() {
	

});

</script>

<style>



.player{

	width : 100rem;
	height : 30rem;
	
}


.container {

	margin: 0 auto;
	display: flex;
	flex-direction: row;
	background-color: black;
}


.watch_box {
	
	flex: 1;
	background-color: red;
}

.watch_info{

	background-color: yellow;
}

.side_box {
	flex: 1;
	
	background-color: blue;
}






</style>


</html>