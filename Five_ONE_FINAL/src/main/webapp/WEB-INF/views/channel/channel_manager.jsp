<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="channelOwner" value="${currentOwner }" />
<c:set var="mvlist" value="${mvList }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="${path }/resources/hochan_CSS/channel_manager.css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>채널 관리 페이지</title>
</head>
<body>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	<jsp:include page="../include/top_include.jsp"/>
	
	<input type="hidden" id="oCc" value="${channelOwner.channel_code }">
	<input type="hidden" id="chaName" value="${channelOwner.channel_name }">
	<div class="container col-xl-12 align-middle" style="margin-top: 0.5%;">
	  <div class="row justify-content-center">
	    <div class="col-4 col-xl-3 d-xl-block d-xxl-none">
	      	<div class="card left_card" style="width: 18rem;">
			  <img src="${path }/resources/img/channel_profile/${channelOwner.channel_profil }" class="card-img-top left_img channel-backcolor" onload="changeBackColor('${channelOwner.getChannel_code()}')" alt="...">
			  <button class="btn btn-primary profil_settings">
			  	<font size="2px">
			  		이미지 수정하기  				  	
			  	</font>
			   </button>
		  		<input type="file" name="file" class="profil_input" hidden />			   
			 
			  <div class="card-body">
			    <h5 class="card-title">
			    	${channelOwner.channel_name }
			    </h5>
			    <p class="card-text">
			    	<div>구독자 ${channelOwner.channel_like }명</div>
			    	<div>${channelOwner.channel_date.substring(0, 10) }</div>
			    </p>
			  </div>
			</div>
	    </div>
	    <div class="col-6 col-xl-7">
		    <div class="row">
			    <c:if test="${empty mvlist }">
			    	<div class="col-12 align-self-center div_upload_btn">
			    		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-circle arrow upload_btn" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
						</svg>
						<div class="arrow upload_font">시청자들에게 영상 보여주기</div>
			    	</div>
			    </c:if>
			    <c:if test="${!empty mvlist }">
			    <form>
			    	<table class="table table-hover">
			    	<thead>
					  <tr>
					  	<th class="col-4">동영상</th>
					  	<th class="col-3">제목</th>
					  	<th class="col-1" style="font-size: 14px;">공개 상태</th>
					  	<th class="col-1" style="font-size: 14px;">제한 사항</th>
					  	<th class="col-1">날짜</th>
					  	<th class="col-1">조회수</th>
					  	<th class="col-1">좋아요</th>
					  </tr>
					</thead>
					<tbody>
					  <c:forEach items="${mvlist }" var="mvdto">
					  	<tr onclick="modal('${mvdto.video_code}')" data-toggle="modal" data-target="#MoaModal"> <!-- data-toggle="modal" data-target="#MoaModal" -->
					  		<td>
					  			<c:if test="${empty mvdto.video_img }">
							    	<div><video class="show_file"><source src="${path }/resources/AllChannel/${channelOwner.channel_code}/${mvdto.video_title }.mp4"></video></div>
					   			</c:if>
					   			<c:if test="${!empty mvdto.video_img }">
					   				<img class="show_file" src="${path }/resources/AllChannel/${channelOwner.channel_code}/thumbnail/${mvdto.video_img }">
					   			</c:if>
					  		</td>
					  		<td>
					  			${mvdto.video_title }
					  		</td>
					  		<td>
					  			<c:if test="${mvdto.video_open == 1}">
									비공개
								</c:if>
								<c:if test="${mvdto.video_open == 0}">
									공개
								</c:if>
					  		</td>
					  		<td>
					  			child? 
					  		</td>
					  		<td>
					  			 ${mvdto.video_view_cnt }
					  		</td>
					  		<td>
					  			${mvdto.video_regdate }
					  		</td>
					  		<td>
					  			<c:if test="${mvdto.video_good == 0 }">
					  				0%
					  			</c:if>
					  			<c:if test="${mvdto.video_good != 0 }">
					  				<fmt:formatNumber var="good" value="${mvdto.getVideo_good() }" pattern="#.##" />
						  			<fmt:formatNumber var="bad" value="${mvdto.getVideo_bad() }" pattern="#.##"/>
						  			<fmt:formatNumber var="answer" value="${(good - bad)/bad }" />	
						  			${answer }%
					  			</c:if>
					  		</td>
					  	</tr>
					  </c:forEach>
					  </tbody>
					</table>
					</form>
			    </c:if>
		    </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 -->
	<div class="modal fade" id="MoaModal" tabindex="-1" role="dialog" aria-labelledby="historyModalLabel" aria-hidden="true" data-backdrop="static">
	  <div class="modal-dialog modal-xl" role="document">
	    <div class="modal-content">
	    	
	    </div>
	  </div>
	</div>
	<script type="text/javascript" src="${path }/resources/hochan_JavaScript/channel_manager.js"></script>
	<!-- member js -->
	<script src="${path}/resources/member/member_js.js"></script>
</body>
</html>