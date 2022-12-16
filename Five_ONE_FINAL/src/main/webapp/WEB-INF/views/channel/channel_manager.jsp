<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="videoList" value="${list }" />
<c:set var="channelOwner" value="${currentOwner }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="${path }/resources/hochan_CSS/channel_manage.css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>채널 관리 페이지</title>
</head>
<body>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	<jsp:include page="../include/top_include.jsp"/>
	
	<input type="hidden" id="oCc" value="${channelOwner.channel_code }">
	<input type="hidden" id="chaName" value="${channelOwner.channel_name }">
	<div class="container text-center">
	  <div class="row">
	    <div class="col-xl-4">
	      	<div class="card left_card" style="width: 18rem;">
			  <img src="${path }/resources/img/channel_profile/${channelOwner.channel_profil }" class="card-img-top left_img" alt="...">
			  <button class="btn btn-primary profil_settings">
			  	<font size="2px">
			  		프로필 수정하기  				  	
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
	    <div class="col-xl-6">
	      Column
	    </div>
	    <div class="col-xl-2">
	      Column
	    </div>
	  </div>
	</div>
	<script type="text/javascript" src="${path }/resources/hochan_JavaScript/channel_manage.js"></script>
</body>
</html>