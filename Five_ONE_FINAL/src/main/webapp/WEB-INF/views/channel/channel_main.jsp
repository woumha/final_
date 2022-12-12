<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="owner" value="${currentOwner }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="${path }/resources/hochan_CSS/channel.css">
<link rel="stylesheet" href="${path }/resources/hochan_CSS/uploadBtn.css">
<link rel="stylesheet" href="${path }/resources/hochan_CSS/css/bootstrap.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script type="text/javascript">
	$(function() {
		
	});
</script>


<title>채널입니다.</title>
</head>
<body>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	<%-- 검색 필드 include 영역 --%>
	<jsp:include page="../include/top_include.jsp"/>
	<jsp:include page="../include/side_include.jsp"/>
	<script type="text/javascript" src="${path }/resources/hochan_JavaScript/channel.js"></script>
	
	<img src="${path }/resources/hochan_img/vidi.png" class="col-lg-12 img-fluid mb-3" style="max-width: 100%; max-height: 423px; border: 1px solid;" alt="...">
	<div class="container text-center mb-3">
	  <div class="row mb-3">
	    <div class="col-lg-2">
	      <img src="${path }/resources/hochan_img/channelprofil_test.png" class="img-fluid" id="chennelprofil" alt="...">
	    </div>
	    <div class="col-lg-6">
	     	<div class="col-sm-12 text-left mb-1" style="font-size: 18px">
			  ${owner.channel_name }
			</div>
			<div class="col-sm-12 text-left mb-1" style="font-size: 14px">
			  채널아이디
			  ${owner.channel_code }
			</div>
			<div class="col-sm-12 text-left mb-1" style="font-size: 14px">
			 	${owner.channel_like }명
			</div>
	    </div> <!-- 중간 -->
	    <div class="col-lg-4 align-self-center">
	    	<c:if test="${empty owner }">
		     	<button type="button" class="btn btn-primary btn-dark">구독</button>
	    	</c:if>
			<c:if test="${!empty owner }">
		     	<button data-toggle="modal" data-target="#exampleModal" role="button" id="video_upload_btn" class="btn btn-primary btn-blue">
		     		동영상 업로드
		     	</button>				
			</c:if>	     	
	     	
	     	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			    <div class="modal-dialog modal-lg">
			        <div class="modal-content">
			       		 <jsp:include page="/movie_upload.do?code=${owner.channel_code }"></jsp:include>
			        </div>
			    </div>
			</div>
	    </div>
	  </div>
	  <ul class="nav nav_channel nav-tabs mb-3 container text-center" id="myTab" role="tablist">
		  <li class="nav-item" role="presentation">
		    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">홈</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">동영상</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">재생목록</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="comm-tab" data-bs-toggle="tab" data-bs-target="#comm-tab-pane" type="button" role="tab" aria-controls="comm-tab-pane" aria-selected="false">커뮤니티</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <button class="nav-link" id="infor-tab" data-bs-toggle="tab" data-bs-target="#infor-tab-pane" type="button" role="tab" aria-controls="infor-tab-pane" aria-selected="false">정보</button>
		  </li>
		  <li class="nav-item" role="presentation">
		    <yt-icon icon="yt-icons:search" class="style-scope ytd-expandable-tab-renderer">
		    	<svg viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet" focusable="false" class="style-scope yt-icon" style="pointer-events: none; display: block; width: 100%; height: 100%;">
		    		<g class="style-scope yt-icon">
		    			<path d="M20.87,20.17l-5.59-5.59C16.35,13.35,17,11.75,17,10c0-3.87-3.13-7-7-7s-7,3.13-7,7s3.13,7,7,7c1.75,0,3.35-0.65,4.58-1.71 l5.59,5.59L20.87,20.17z M10,16c-3.31,0-6-2.69-6-6s2.69-6,6-6s6,2.69,6,6S13.31,16,10,16z" class="style-scope yt-icon">
		    				</path></g></svg><!--css-build:shady--></yt-icon>
		    <div class="form-floating">
		    	<form action="">
				  <input type="text" class="search-control" name="search_text" placeholder="검색">		    	
		    	</form>
			</div>
		  </li>
		</ul> <%--id, data-bs-target, aria-controls --%>
		<%-- 영상이 없을때 영상을 업로드 하는 버튼 생성 --%>
	  <div class="tab-content container text-center" id="myTabContent">
	  	<div class="tab-pane fade show side-color active " id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
		  	<div>
			  <div align="left" class="row">
			  	
			  	<div class="embed-responsive embed-responsive-16by9 col-lg-4" align="left">
					<video autoplay loop class="embed-responsive-item" width="400px" height="300px" controls>
						<source src="${path }/resources/hochan_video/main_video.mov" type="video/mp4">
					</video>
					
				</div><!-- video -->
				  <div class="col">
				    <div class="col mb-1" style="font-size: 14px;">영상 제목</div>
				    <div class="col mb-1" style="font-size: 12px;">조회수 . 현재날짜-올린날짜</div>
				    <div class="col mb-1" style="font-size: 14px;">영상 설명</div>
				  </div>
			  </div>
			</div><!-- 메인 배너 영상 -->
			<%-- 다음 재생목록 영상 --%>
			<hr width="100%" color="gary">
			<div class="play_list_title">재생목록 제목</div>
			<div class="play_list_title">▶모두재생</div>
			<div class="container text-center"> <!-- 그리드 시작 -->
			  <div class="row">
			    <div class="col-12 col-sm-6 col-lg-3">
			    	<div class="m-1 ratio ratio-4x3">
				      <video class="vicl" id="se-se-one"  loop class="embed-responsive-item" controls>
							<source src="${path }/resources/hochan_video/main_video.mov" type="video/mp4">
						</video>
				    </div>
				    <div class="video-title">영상 제목</div>
				    <div class="video-up">조회수.업로드시간</div>
			    </div>
			    <div class="col-12 col-sm-6 col-lg-3">
			    	<div class="m-1 ratio ratio-4x3">
				      <video class="vicl" id="se-se-one"  loop class="embed-responsive-item" controls>
							<source src="${path }/resources/hochan_video/main_video.mov" type="video/mp4">
						</video>
				    </div>
				    <div class="video-title">영상 제목</div>
				    <div class="video-up">조회수.업로드시간</div>
			    </div>
			    <div class="col-12 col-sm-6 col-lg-3">
			    	<div class="m-1 ratio ratio-4x3">
				      <video class="vicl" id="se-se-one"  loop class="embed-responsive-item" controls>
							<source src="${path }/resources/hochan_video/main_video.mov" type="video/mp4">
						</video>
				    </div>
				    <div class="video-title">영상 제목</div>
				    <div class="video-up">조회수.업로드시간</div>
			    </div>
			    <div class="col-12 col-sm-6 col-lg-3">
			    	<div class="m-1 ratio ratio-4x3">
				      <video class="vicl" id="se-se-one"  loop class="embed-responsive-item" controls>
							<source src="${path }/resources/hochan_video/main_video.mov" type="video/mp4">
						</video>
				    </div>
				    <div class="video-title">영상 제목</div>
				    <div class="video-up">조회수.업로드시간</div>
			    </div>
			  </div>
			</div><!-- 그리드 -->
			
			<%-- 다음 재생목록 영상 --%>
			<hr width="100%" color="gary">
			<div class="play_list_title">재생목록 제목</div>
			<div class="play_list_title">▶모두재생</div>
			<div class="container text-center"> <!-- 그리드 시작 -->
			  <div class="row">
			    <div class="col-12 col-sm-6 col-lg-3">
			    	<div class="m-1 ratio ratio-4x3">
				      <video class="vicl" id="se-se-one" loop class="embed-responsive-item" controls>
							<source src="${path }/resources/hochan_video/main_video.mov" type="video/mp4">
						</video>
				    </div>
				    <div class="video-title">영상 제목</div>
				    <div class="video-up">조회수.업로드시간</div>
			    </div>
			    <div class="col-12 col-sm-6 col-lg-3">
			    	<div class="m-1 ratio ratio-4x3">
				      <video class="vicl" id="se-se-one" loop class="embed-responsive-item" controls>
							<source src="${path }/resources/hochan_video/main_video.mov" type="video/mp4">
						</video>
				    </div>
				    <div class="video-title">영상 제목</div>
				    <div class="video-up">조회수.업로드시간</div>
			    </div>
			    <div class="col-12 col-sm-6 col-lg-3">
			    	<div class="m-1 ratio ratio-4x3">
				      <video class="vicl" id="se-se-one" loop class="embed-responsive-item" controls>
							<source src="${path }/resources/hochan_video/main_video.mov" type="video/mp4">
						</video>
				    </div>
				    <div class="video-title">영상 제목</div>
				    <div class="video-up">조회수.업로드시간</div>
			    </div>
			    <div class="col-12 col-sm-6 col-lg-3">
			    	<div class="m-1 ratio ratio-4x3">
				      <video class="vicl" id="se-se-one"  loop class="embed-responsive-item" controls>
							<source src="${path }/resources/hochan_video/main_video.mov" type="video/mp4">
						</video>
				    </div>
				    <div class="video-title">영상 제목</div>
				    <div class="video-up">조회수.업로드시간</div>
			    </div>
			  </div>
			</div><!-- 그리드 -->
	   </div><!-- 마지막 -->
	  <div class="tab-pane fade side-color" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
	  	동영상
	  </div>
	  <div class="tab-pane fade side-color" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">
	  	재생목록
	  </div>
	  <div class="tab-pane fade side-color" id="comm-tab-pane" role="tabpanel" aria-labelledby="comm-tab" tabindex="0">
	  	커뮤니티
	  </div>
	  <div class="tab-pane fade side-color" id="infor-tab-pane" role="tabpanel" aria-labelledby="infor-tab" tabindex="0">
	  	<div class="container text-center">
		  	<div class="row">
			    <div class="col-8" align="left">
			   		 내용
			    </div>
			    <div class="col-4">
			    통계
			    <hr color="black" size="50%">
			    가입일
			    <hr color="black" size="50%">
			    조회수
			    </div>
			</div>
		</div>
	  </div>
	  <div class="tab-pane fade" id="search-tab-pane" role="tabpanel" aria-labelledby="search-tab" tabindex="0">
	  	
	  </div>
	  <%-- id, aria-labelledby --%>
	</div> <!-- 토글버튼 내용 입력 -->
</div><!-- 배너를 제외한 모든 -->
</body>
</html>