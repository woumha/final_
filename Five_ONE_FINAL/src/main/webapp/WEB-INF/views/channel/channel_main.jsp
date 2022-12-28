<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="owner" value="${currentOwner }" />
<c:set var="current" value="${currentVideo }" />
<c:set var="lastUpVideo" value="${currentNewVideo }" />
<c:set var="bundle" value="${bundleList }" />
<%
	String repCode = (String)session.getAttribute("RepChannelCode");
%>
<c:set var="sessionChannelCode" value="<%=repCode %>" />
<c:set var="subCheck" value="${subCheck }" />
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<title>채널입니다.</title>
</head>
<body>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	<%-- 검색 필드 include 영역 --%>
	<jsp:include page="../include/top_include.jsp"/>
	<jsp:include page="../include/side_include.jsp"/>
	<script type="text/javascript" src="${path }/resources/hochan_JavaScript/channel.js"></script>
	<img src="${path }/resources/img/channel_banner/${owner.channel_banner}" id="channel_banner" class="col-10 img-fluid mb-3" style="max-width: 100%; max-height: 423px; border: 1px solid;" alt="...">
	<div class="container text-center mb-3">
	  <div class="row mb-3">
	    <div class="col-lg-2">
	      <img src="${path }/resources/img/channel_profile/${owner.channel_profil}" class="img-fluid" id="chennelprofil" alt="...">
	    </div>
	    <div class="col-lg-6">
	     	<div class="col-sm-12 text-left mb-1" style="font-size: 18px">
			 	 ${owner.channel_name }
			</div>
			<div class="col-sm-12 text-left mb-1" style="font-size: 14px">
				<input type="hidden" id="ownerCode" value="${owner.channel_code }">
			  채널&nbsp; ${owner.channel_code }
			</div>
			<div class="col-sm-12 text-left mb-1" style="font-size: 14px">
			 	${owner.channel_like }명
			</div>
	    </div> <!-- 중간 -->
	    <div class="col-lg-4 align-self-center">
	    	<div id="subBtn">
	    		<c:if test="${owner.channel_code.trim() ne sessionChannelCode.trim() }">
		    		<c:if test="${subCheck == 1 }">
				     	<button type="button" class="btn btn-primary btn-red text-red subing" style="color: red; background-color: #ECE9EF;" onclick="insertscribe('${owner.channel_code.trim()}', '${sessionChannelCode.trim() }')">구독중</button>
		    		</c:if>
		    		<c:if test="${subCheck != 1 }">
				     	<button type="button" class="btn btn-primary btn-dark subed" onclick="insertscribe('${owner.channel_code.trim()}', '${sessionChannelCode.trim() }')">구독</button>
		    		</c:if>
	    		</c:if>
	    	</div>
			<c:if test="${owner.channel_code.trim() eq sessionChannelCode.trim() }">
		     	<button data-toggle="modal" data-target="#exampleModal" role="button" id="video_upload_btn" class="btn btn-primary btn-blue">
		     		동영상 업로드
		     	</button>
		     	<button role="button" id="video_manage_btn" class="btn btn-primary btn-blue" onclick="location.href='<%=request.getContextPath() %>/channel_manager.do?code=${owner.channel_code }'">
		     		채널 관리
		     	</button>			
			</c:if>	     	
	     	
	     	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			    <div class="modal-dialog modal-xl" role="document">
			        <div class="modal-content">
			       		
			        </div>
			    </div>
			</div>
	    </div>
	  </div>
	   <c:if test="${empty current}">
	    	<div class="col-lg-12 align-self-center div_upload_btn">
	    		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-circle arrow upload_btn" viewBox="0 0 16 16">
				  <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
				</svg>
				<div class="arrow upload_font">시청자들에게 영상 보여주기</div>
	    	</div>
	    </c:if>
		<c:if test="${!empty current }">
	    	<ul class="nav nav_channel nav-tabs mb-3 container text-center" id="myTab" role="tablist">
			  <li class="nav-item" role="presentation">
			    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">홈</button>
			  </li>
			  <li class="nav-item" role="presentation">
			    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">쇼츠</button>
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
				  		<c:if test="${!empty lastUpVideo }">
				  			<c:if test="${empty lastUpVideo.video_img }" >
				  			</c:if>
				  			<c:if test="${!empty lastUpVideo.video_img }" >
				  			</c:if>
				  			<video autoplay loop class="embed-responsive-item" width="400px" height="300px" controls>
									<source src="${path }/resources/AllChannel/${owner.channel_code  }/${lastUpVideo.video_title}.mp4" type="video/mp4">
							</video>
				  		</c:if>
				  		<c:if test="${empty lastUpVideo }">
				  			<div>영상을 올려주세요!</div>
				  			
				  		</c:if>
					</div><!-- video -->
					  <div class="col">
					    <div class="col mb-1" style="font-size: 14px;">${lastUpVideo.video_title }</div>
					    <div class="col mb-1" style="font-size: 12px;">${lastUpVideo.video_view_cnt }회 . ${lastUpVideo.video_regdate }</div>
					    <c:if test="${lastUpVideo.video_cont eq 'null' }">
					    	<div class="col mb-1" style="font-size: 14px;">
					    		설명<br>
					    	</div>	
					    </c:if>
					    <c:if test="${lastUpVideo.video_cont ne 'null' }">
					    	
						    <div class="col mb-1" style="font-size: 14px;">
						   		설명<br>
						    	${lastUpVideo.video_cont }
						    </div>
					    </c:if>
					  </div>
				  </div>
				</div><!-- 메인 배너 영상 -->
				<%-- 다음 재생목록 영상 --%>
				<hr width="100%" color="gary">
				<div class="play_list_title">최근 업로드한 영상</div>
				<div class="play_list_title">▶모두재생</div>
				<div class="container text-center"> <!-- 그리드 시작 -->
				  <div class="row">
			  		<div class="col-1 paging_css"><i class="bi bi-caret-left fs-5"></i></div>
				  	<c:forEach items="${current }" var="currentList">
					    <div class="col-10 col-sm-6 col-lg-3">
					    	<div class="m-1 ratio ratio-4x3">
						      <video class="vicl" id="se-se-one"  loop class="embed-responsive-item" controls>
									<source src="${path }/resources/AllChannel/${owner.channel_code}/${currentList.video_title}.mp4" type="video/mp4">
								</video>
						    </div>
						    <div class="video-title">${currentList.video_title }</div>
						    <div class="video-up">${currentList.video_view_cnt }회 . ${currentList.video_regdate }</div>
					    </div>
				  	</c:forEach>
					    <div class="col-1 paging_css"><i class="bi bi-caret-right fs-5"></i></div>				  		
				  </div>
				</div><!-- 그리드 -->
				<!-- 재생목록 및 영상 삽입 -->
				<!-- bundle -->
				
				
				<%-- 재생목록 목록 및 영상 --%>
				<c:forEach items="${bundle }" var="bundle_dto">
					<hr width="100%" color="#ECE9EF">
					<input type="hidden" class="bundle_Code" value="${bundle_dto.bundle_code }">
					<div class="play_list_title">${bundle_dto.bundle_title }</div>
					<div class="play_list_title">▶모두재생</div>
					<div class="container text-center"> <!-- 그리드 시작 -->
						<div class="row">
  							<div class="col-1 paging_css"><i class="bi bi-caret-left fs-5"></i></div>
							<div class="row col-10 ${bundle_dto.bundle_code }">
							
							</div>
							<div class="col-1 paging_css"><i class="bi bi-caret-right fs-5"></i></div>
						</div>
					</div>
				</c:forEach>
				<%-- 재생목록 목록 및 영상 끝 --%>
		   </div><!-- 메인 끝 -->
		   
		  <div class="tab-pane fade side-color" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
		  	쇼츠
		  </div>
		  
		  <%-- 재생목록 --%>
		  <div class="tab-pane fade side-color" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">
		  	<div class="container text-center">
			  <div class="row">
			    <c:forEach items="${bundle }" var="bundle_bundleList">
			    <div class="col-6 col-sm-4 col-lg-2 m-4 p-4">
				      	<div class="video_box">
				      		<input type="hidden" class="bundle_bundle_list" value="${bundle_bundleList.bundle_code}">
							<div class="playlist_video_div">
								<div class="playlist_lid b${bundle_bundleList.bundle_code }">
									<p>${bundle_bundleList.bundle_title }</p>
									<img class="playlist_lid_img" src="${pageContext.request.contextPath}/resources/img/playlist_lid1.png">
								</div>
								<video class="video_player" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
							</div>
						</div>			    
			    </div>
			    </c:forEach>
			  </div>
			</div>
		  </div>
		  <%-- 재생목록 끝 --%>
		  <div class="tab-pane fade side-color" id="comm-tab-pane" role="tabpanel" aria-labelledby="comm-tab" tabindex="0">
		  	커뮤니티
		  </div>
		  <div class="tab-pane fade side-color" id="infor-tab-pane" role="tabpanel" aria-labelledby="infor-tab" tabindex="0">
		  
		  	<div class="container text-center">
			  	<div class="row">
				    <div class="col-8" align="left">
				   		 <c:if test="${empty owner.channel_cont }">
				   		 	<div align="center">
								채널을 소개해주세요~				   		 	
				   		 	</div>
				    	</c:if>
				    	<c:if test="${!empty owner.channel_cont }">
					   		 <div>${owner.channel_cont }</div>
				    	</c:if>
				    </div>
				    <div class="col-4">
				    통계
				    <hr color="black" size="50%">
				    가입일 ${owner.channel_date.substring(0, 10) }
				    <hr color="black" size="50%">
				    조회수 ${owner.channel_view_cnt }
				    </div>
				</div>
			</div>
		  </div>
		  <div class="tab-pane fade" id="search-tab-pane" role="tabpanel" aria-labelledby="search-tab" tabindex="0">
		  	
		  </div>
		  <%-- id, aria-labelledby --%>
		</div> <!-- 토글버튼 내용 입력 -->
		</c:if>
</div><!-- 배너를 제외한 모든 -->
</body>
</html>