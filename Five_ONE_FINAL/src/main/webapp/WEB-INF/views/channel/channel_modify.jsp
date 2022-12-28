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
<link rel="stylesheet" href="${path }/resouces/hochan_CSS/channel_modify.css" />
</head>
<body>
	<div class="container text-left">
	  <div class="row col-10">
	  	<div class="col-10">
	  		<div>사진</div>
	  		<div>프로필 사진은 동영상 및 댓글 옆과 같이 VIDIVIDI에서 채널을 나타내는 위치에 표시됩니다.</div>
	  	</div>
	  </div>
	  
	  <div class="row col-10" style="float: none; margin: 0 auto;">
	    <div class="col-5" style="max-wdith: 290px; max-height: 160px;"">
	    	<img src="${path }/resources/img/channel_profile/${channelOwner.channel_profil }" style="max-width:140px; max-height: 140px;" class="img-thumbnail">
	    	<input type="file" hidden name="profilArea" id="profilArea">
	    </div>
	    <div class="col-5">
	      	<div>PNG 또는 JPG 파일을 사용하세요. 사진이 VIDIVIDI 커뮤니티 가이드를 준수합니다.</div>
	      	<div><a href="" onclick="">업로드</a></div>
	    </div>
	  </div>
	  
	  <div class="row col-10">
	  	<div class="col-10">
	  		<div>배너 이미지</div>
	  		<div>이 이미지가 채널 상단에 표시됩니다.</div>
	  	</div>
	  </div>
	  
	  <div class="row col-10">
	  	<div class="col-5">
	  		<img src="${path }/resources/img/channel_profile/${channelOwner.channel_banner }" class="img-thumbnail">
	  		<input type="file" hidden name="bannerArea" id="bannerArea">
	  	</div>
	  	<div class="col-5">
	  		<div>모든 기기에 최적화된 이미지가 표시되도록 6MB 이하의 이미지를 사용하세요.</div>
	  		<div><a href="" onclick="">업로드</a></div>
	  	</div>
	  </div>
	  
	  <div class="row col-10">
	  	<div class="col-10">
	  		<div>이름</div>
	  		<div>나와 내 콘텐츠를 잘 나타내는 채널 이름을 선택하세요. 변경된 이름 및 프로필 사진은 VIDIVIDI에만 표시됩니다.</div>
	  	</div>
	  </div>
	  <div class="row col-10">
	  	<div class="col-10">
	  		<div>
	  			 <input type="text" class="form-control" id="exampleFormControlInput1" placeholder="${channelOwner.channel_name }">
	  		</div>
	  	</div>
	  </div>
	  
	</div><!-- 끝 -->
</body>
</html>