<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="channelOwner" value="${channel }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path }/resources/hochan_CSS/channel_modify.css" />
</head>
<body>
	<script type="text/javascript" src="${path }/resources/hochan_JavaScript/channel_modify.js"></script>
	<p>
	<input type="hidden" id="channelCode" value="${channelOwner.channel_code }" />
	<div class="container text-left">
	  <div class="row col-10">
	  	<div class="col-10">
			<hr class="hrtag">
	  		<div>사진</div>
	  		<div>프로필 사진은 동영상 및 댓글 옆과 같이 VIDIVIDI에서 채널을 나타내는 위치에 표시됩니다.</div>
	  	</div>
	  </div>
	  
	 <br> 
	 
	  <div class="row col-10">
	    <div class="col-5" style="max-wdith: 290px; max-height: 160px;">
	  
	    	<img src="${path }/resources/img/channel_profile/${channelOwner.channel_profil }" style="max-width:140px; max-height: 140px;" class="img-thumbnail imgSrc">
	    	<input type="hidden" id="defaultProfil" value="${channelOwner.channel_profil }">
	    	<input type="file" hidden name="profilArea" id="profilArea">
	  
	    </div>
	    <div class="col-5">
	      	<div>PNG 또는 JPG 파일을 사용하세요. 사진이 VIDIVIDI 커뮤니티 가이드를 준수합니다.</div>
	      	<div><a href="#" onclick="profilBtn()">업로드</a></div>
	    </div>
	  </div>
	  
	  <br>
	  
	  <div class="row col-10">
	  	<div class="col-10">
		  <hr class="hrtag">
	  		<div>배너 이미지</div>
	  		<div>이 이미지가 채널 상단에 표시됩니다.</div>
	  	</div>
	  </div>
	  <br>
	  <div class="row col-10">
	  	<div class="col-5">
	  		<img src="${path }/resources/img/channel_banner/${channelOwner.channel_banner }" class="img-thumbnail bannerSrc">
	  		<input type="hidden" id="defaultBanner" value="${channelOwner.channel_banner }">
	  		<input type="file" hidden name="bannerArea" id="bannerArea">
	  	</div>
	  	<div class="col-5">
	  		<div>모든 기기에 최적화된 이미지가 표시되도록 6MB 이하의 이미지를 사용하세요.</div>
	  		<div><a href="#" onclick="bannerBtn()">업로드</a></div>
	  	</div>
	  </div>
	  
	  <br>
	  
	  <form method="post">
		  <div class="row col-10">
		  	<div class="col-10">
			    <hr class="hrtag">
		  		<div>이름</div>
		  		<div>나와 내 콘텐츠를 잘 나타내는 채널 이름을 선택하세요. 변경된 이름 및 프로필 사진은 VIDIVIDI에만 표시됩니다.</div>
		  	</div>
		  </div>
		  
		  <div class="row col-10">
		  	<div class="col-7">
			  	<div class="input-group mb-3">
				  <input type="text" class="form-control nameAreaText" id="areaText" placeholder="${channelOwner.channel_name }" aria-label="Recipient's username" aria-describedby="button-addon2">
				  <button class="btn btn-outline-secondary btn-sm nameAreaBtn" type="button" id="button-addon2">수정</button>
				</div>
		  	</div>
		  </div>
		  
		  <br>
		  
		  <div class="row col-10">
		  	<div class="col-10">
			    <hr class="hrtag">
			  		설명
			  		<button class="btn btn-outline-secondary btn-sm offset-10 contAreaBtn" type="button" id="button-addon2">수정</button>
			  	</div>
		  </div>
		  <br>
		  <div class="row col-10">
		  	<div class="col-10">
		  		<textarea id='contAreaText' rows="10px" cols="100px" style="resize: none;">${channelOwner.channel_cont }</textarea>
		  	</div>
		  </div>
	  </form>
	</div><!-- 끝 -->
</body>
</html>