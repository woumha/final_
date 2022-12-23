<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="playList" value="${list }" /> <!-- videoplay -->
<c:set var="mainCategory" value="${cateList }" /> <!-- category -->
<c:set var="bundle" value="${playBundle }" /> <!-- bundle -->
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

	<!-- Vertically centered scrollable modal -->
	<div class="modal-body">
		<form method="post" id="formData" enctype="multipart/form-data" action="<%=request.getContextPath() %>/video_update_success.do?videoCode=${playList.video_code }">
		<input type="hidden" name="subVideoCode" value="${playList.video_code }">
		<input type="hidden" name="channelCode" value="${playList.channel_code }">
	  	<div class="container text-center">
	  	  <div class="row">
		      <div class="col-md-2">
		      	<div class="upload-font">V I D I D I</div>
		      </div>
		      <div class="col-md-2 ms-auto">
		      	<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
		      </div>
		   </div>
		   
		  <div class="row">
		    <div class="col-6">
		     <div id="file_area">
		     	<div>동 영 상</div>
		      <video id="upload_file_btn" class="update_modal">
		      	<source class="source_tag" src="${path }/resources/AllChannel/${playList.channel_code}/${playList.video_title}.mp4" type="video/mp4">
		      </video>
		     </div> 
		      <input id="input_file" type="file" hidden name="file_mv">
		    </div>
		    
		    <div class="col-6">
		      <div class="row">
		     	<div align="left">제 목</div>
		      	<input class="form-control" name="video_title" list="datalistOptions" id="exampleDataList" placeholder="변경할 제목을 알려주세요" value="${playList.video_title }">
		      </div>
		      <div class="row">
				<div class="form-floating">
				<c:if test="${playList.video_cont eq 'null'}">
				  <textarea class="form-control" name="video_cont" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 250px; width: 100%;"></textarea>
				  <label for="floatingTextarea2">영상을 설명해주세요</label>
				</c:if>
				<c:if test="${playList.video_cont ne 'null' }">
				  <textarea class="form-control" name="video_cont" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 250px; width: 100%;">${playList.video_cont }</textarea>
				  <label for="floatingTextarea2">영상을 설명해주세요</label>
				</c:if> 
				</div>
		      </div>
		    </div>
		  </div>
		  <hr>
		  
		  <div class="row">
		  	<div class="col-12" align="left">
		  		<strong>영상 카테고리</strong>
		  	</div>
		  	<div class="col-12">
		  		<c:if test="${empty mainCategory }">
		  			<a href="#" class="text-decoration-none" style="display: flex;">카테고리 오류</a>
		  		</c:if>
		  		<c:if test="${!empty mainCategory }">
		  			<select id="category_List" name="category_List" class="form-select" size="3" aria-label="size 3 select example">
					  <c:forEach items="${mainCategory }" var="categoryList">
					      	<option value="${categoryList.category_code }" <c:if test="${playList.category_code eq categoryList.category_code}" >selected</c:if>>${categoryList.category_title }</option>
					  </c:forEach>
					</select>
		  		</c:if>
		  	</div>
		  </div>
		  
		  <hr>
		  <div class="row">
		  	<div class="col-12" align="left">
		  		<strong>재생목록</strong>
		  	</div>
		  	<div class="col-12 bundleDiv">
		  		<c:if test="${empty bundle }">
		  			<a href="#" class="text-decoration-none" style="display: flex;">재생목록이 없어요. 재생목록을 추가해보세요!</a>
		  		</c:if>
		  		<c:if test="${!empty bundle }">
		  			<select id="bundleCheck" name="bundleValue" class="form-select" size="3" aria-label="size 3 select example">
					  <c:forEach items="${bundle }" var="bundlelist">
					      	<option value="${bundlelist.bundle_code }" <c:if test="${bundlelist.bundle_code eq list.playList_code }">selected</c:if>>${bundlelist.bundle_title }</option>
					  </c:forEach>
					</select>
		  		</c:if>
		  	</div>
		  </div>
		  <hr>
		  
		  <div class="row">
		  	<div class="col-8" align="left">
		  		<h5>시청자층*</h5>
				이 동영상이 아동용으로 설정됨 크리에이터가 설정함<br>
				모든 크리에이터는 위치에 상관없이 아동 온라인 개인정보 보호법(COPPA) 및 기타 법률을 준수해야 할 법적인 의무가 있습니다. 아동용 동영상인지 여부는 크리에이터가 지정해야 합니다.
		  	</div>
		  	<div class="col-4" align="left">
		  		<br>
		  		<div class="form-check age_select" >
					  <input class="form-check-input" type="radio" name="flexRadioDefault_age" id="flexRadioDefault1" checked>
					  <label class="form-check-label" for="flexRadioDefault1">
					    예 아동용 입니다
					  </label>
					</div>
					<div class="form-check age_select">
					  <input class="form-check-input" type="radio" name="flexRadioDefault_age" id="flexRadioDefault2">
					  <label class="form-check-label" for="flexRadioDefault2">
					    아니요 성인용 입니다
					  </label>
				</div>
		  	</div>
		  </div>
		  <hr>
		  <div class="row" align="left">
		  	<strong>공개 여부</strong>
		  	<div class="col-10 open_check">
		  		<div class="form-check">
				  <input class="form-check-input" type="radio" name="flexRadioDefault_openClose" id="flexRadioDefault3" checked>
				  <label class="form-check-label" for="flexRadioDefault3">
				   	시청자들과 같이 보기
				  </label>
				</div>
				&nbsp; &nbsp;
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="flexRadioDefault_openClose" id="flexRadioDefault4">
				  <label class="form-check-label" for="flexRadioDefault4">
				   	나만 보기
				  </label>
				</div>
		  	</div>
		  	<div class="col-2 ">
		  		<button type="button" class="btn btn-primary up_btn">수 정</button> <!-- submit_btn -->
		  		&nbsp;
		  		<button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">취 소</button>
		  	</div>
		  </div>
		  <hr>
		  <div class="row">
			<strong>영상 첫이미지 수정하기</strong>
			<div class="input-group mb-3">
			  <input type="file" id="input_img" name="file_img" class="form-control" id="inputGroupFile02">
			</div>		  
		  </div>
		</div> 	
		</form>		  		  		  		  	
	</div>
	
	<script type="text/javascript" src="${path }/resources/hochan_JavaScript/channel_manager.js"></script>
</body>
</html>