 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="channelcode" value="${uploadOwner }" />
<c:set var="playList" value="${list }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	<div class="modal-body">
	<%-- action="<%=request.getContextPath() %>/upload_success.do?code=${channelcode.channel_code}" --%>
	<%-- <form method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/upload_success.do;" class="form-floating" id="send_form"> --%>
		<div class="container-fluid">
		    <div class="row">
		      <div class="col-md-2">
		      	<div class="upload-font">파일 업로드</div>
		      </div>
		      <div class="col-md-2 ms-auto">
		      	<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
		      </div>
		    </div>
		    <div class="row">
		      <div class="col-md-3 ms-auto">
		      	<div class="touch_img">
		      		<div class="d-grid gap-2 d-md-block">
					  <button class="btn btn-primary btn-sm start_img_btn" type="button">영상 미리보기 이미지</button>
					  <input type="file" hidden name="upload_input_img" class="input_start_img">
					  <div class="icon_img">
					  	
					  </div>
					</div>
		      	</div>
		      </div>
		      <div class="col-md-9 ms-auto out-side">
		      	<%-- 업로드 섹션 시작 --%>
		      	<div class="drag-area">
		      		<div class="submit_video">
			      		<div class="icon icon_change">
			      			<i class="fas fa-cloud-upload-alt"></i>
			      		</div>
			      		<header>업로드할 파일을 드래그 해주세요.</header>
			      		<span>또는</span>		      		
		      		</div>
		      		<input type="button" class="upload_click_btn" value="클 릭">
		      		<div class="file_div"><input class="upload_input_file" id="upload_input_file" name="upload_input_file"  type="file" hidden></div>
		      	</div>
		      <%-- 업로드 섹션 끝 --%>
			    </div>
			</div><!-- upload div -->
			<div class="row">
			  <div class="col-md-12 ms-auto">
				  	<div class="form-floating cont_area">
					  <textarea class="form-control title_field" name="title_field" placeholder id="floatingTextarea2"></textarea>
					  <label for="floatingTextarea2" >시청자에게 제목을 알려주세요</label>
					</div>
		      </div>
			</div>
			<!-- 설명 div -->
			    <div class="row">
	 		      <div class="col-md-12 ms-auto">
			      	<div class="form-floating cont_area">
					  <textarea class="form-control" name="cont_area" placeholder="시청자에게 동영상에 대해 이야기하기" id="floatingTextarea3"></textarea>
					  <label for="floatingTextarea3" >시청자에게 동영상에 대해 이야기하기</label>
					</div>
			      </div>
			      <div class="col-md-2 ms-auto"></div>
			    </div>
			<!-- 설명끝 div -->
			    <div class="row">
			      <div class="col-sm-9" align="left">
			        <label for="validationServer04" class="form-label">재생목록</label>
					   <c:if test="${empty playList }">
			  			<a href="#" class="text-decoration-none">재생목록이 없어요</a>
			  		</c:if>
			  		<c:if test="${!empty playList }">
			  			<select id="update_playList" name="video_playList" class="form-select" size="3" aria-label="size 3 select example">
						  <c:forEach items="${playList }" var="play">
						      	<option value="${play.playlist_title }">${play.playlist_title }</option>
						  </c:forEach>
						</select>
			  		</c:if>
					</div>
					<p>
					<hr>
					<p>
			        <div class="row">
			          <div class="col-8 col-sm-6" style="font-size: 14px;">
			            시청자층<br>
						이 동영상이 아동용으로 설정됨 크리에이터가 설정함<br>
						모든 크리에이터는 위치에 상관없이 아동 온라인 개인정보 보호법(COPPA) 및 기타 법률을 준수해야 할 법적인 의무가 있습니다. 아동용 동영상인지 여부는 크리에이터가 지정해야 합니다.
			          </div>
			          <div class="col-4 col-sm-6 age_select">
			          	<div class="form-check age_select">
							  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" checked>
							  <label class="form-check-label" for="flexRadioDefault1">
							    예 아동용 입니다
							  </label>
							</div>
							<div class="form-check age_select">
							  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2">
							  <label class="form-check-label" for="flexRadioDefault2">
							    아니요 성인용 입니다
							  </label>
						</div>
			          </div>
			        </div>
			        <div class="row">
			        	<div class="col-8 col-sm-6">
			        	</div>
			        	<div class="col-4 col-sm-6">
			        		<button type="button" onclick="upload_seccess();" class="btn btn-primary video_upload_btn">업로드</button>
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			        	</div>
			        </div>
			    </div>
		  </div>
	<!--  </form> -->
	</div>
	<script type="text/javascript" src="${path }/resources/hochan_JavaScript/uploadBtn.js"></script>
</body>
</html>