<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="${path }/resources/hochan_CSS/channel.css">
<link rel="stylesheet" href="${path }/resources/hochan_CSS/css/bootstrap.css">



<title>채널입니다.</title>
</head>
<body>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	
	<img src="${path }/resources/hochan_img/vidi.png" class="col-lg-12 img-fluid mb-3" style="width: 1546px; height: 423px; border: 1px solid" alt="...">
	<div class="container text-center mb-3">
	  <div class="row mb-3">
	    <div class="col-lg-2">
	      <img src="${path }/resources/hochan_img/channelprofil_test.png" class="img-fluid" id="chennelprofil" alt="...">
	    </div>
	    <div class="col-lg-6">
	     	<div class="col-sm-12 text-left mb-1" style="font-size: 18px">
			  채널이름
			</div>
			<div class="col-sm-12 text-left mb-1" style="font-size: 14px">
			  채널아이디
			</div>
			<div class="col-sm-12 text-left mb-1" style="font-size: 14px">
			  구독자수
			</div>
	    </div> <!-- 중간 -->
	    <div class="col-lg-4 align-self-center">
	     	<button type="button" class="btn btn-primary btn-dark">구독</button>
	    </div>
	  </div>
	  <ul class="nav nav-tabs mb-3" id="myTab" role="tablist">
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
		    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">커뮤니티</button>
		  </li>
		</ul>
	  <div class="tab-content" id="myTabContent">
	  	<div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
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
			</div>
			<hr width="100%" color="gary">
			<div class="container text-center">
			  <div class="row row-lg-2">
			    <div class="col">Column</div>
			    <div class="col">Column</div>
			    <div class="col">Column</div>
			    <div class="col">Column</div>
			    <div class="col">Column</div>
			    <div class="col">Column</div>
			  </div>
			</div>
		</div>
		
	  <div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
	  	
	  </div>
	  <div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">...</div>
	  <div class="tab-pane fade" id="disabled-tab-pane" role="tabpanel" aria-labelledby="disabled-tab" tabindex="0">...</div>
	</div> <!-- 토글버튼 내용 입력 -->
	
	
	
</div>
</body>
</html>