<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>
</head>
<body>

<div id="wrap_myPage">
<!-- top, side 영역 -->
<jsp:include page="../include/top_include.jsp"/>
<jsp:include page="../include/side_include.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/myPage_CSS/subscribe.css">

<div id="content_box">

<div class="">
	<!-- 구독 한 리스트 영역 -->
	
	<c:set var="s_list" value="${subscribe_list }" />
	<c:if test="${!empty member_code }">
	<div id="subscribe_title"><p><i class="fa-solid fa-stamp"></i>&nbsp;&nbsp;구독 목록</p></div>
	<c:if test="${!empty s_list }">
	<c:forEach items="${s_list }" var="s_dto">
	<div class="chanel_area">
		<div class="channel_box">
			<div class="channel_icon"> <img src="${pageContext.request.contextPath}/resources/img/unnamed.jpg"> </div>
			<div class="channel_name"> ${s_dto.getChannel_name() } </div>
		</div> <!-- ".channel_box" end -->
		
		<div class="channel_info">
			<div class="info_box">
				<div class="info_text">
					<p class="channel_like">구독자
						<%-- 구독자 출력 영역 --%>
						<c:set var="like" value="${s_dto.getChannel_like() }" />
						<c:if test="${like < 1000 }">${like }명</c:if>
						<c:if test="${like >= 1000 && like < 10000 }">
							<fmt:formatNumber value="${like / 1000 }" pattern=".0" />천명
						</c:if>
						<c:if test="${like >= 10000 && like < 100000 }">
							<fmt:formatNumber value="${like / 10000 }" pattern=".0" />만명
						</c:if>
						<c:if test="${like >= 100000 && like < 100000000 }">
							<fmt:formatNumber value="${like / 10000 }" pattern="0" />만명
						</c:if>
						<c:if test="${like >= 100000000 }">
							<fmt:formatNumber value="${like / 100000000 }" pattern=".00" />억명
						</c:if>
						<%-- 구독자 출력 영역 끝 --%>
					</p>
				</div>
			</div>
		</div> <!-- ".channel_info" end -->
		
		<button class="cancel_btn" onclick="location.href='<%=request.getContextPath() %>/subscribe_one_delete.do?member_code=${member_code }&channel_code=${s_dto.getChannel_code() }'">
		구독중
		</button>

	</div> <!-- ".channel_area" end -->
	</c:forEach>

	</c:if>
	<c:if test="${empty s_list }">
	</c:if>
	<div id="chanel_area_plus" class="chanel_area" onclick="location.href='<%=request.getContextPath() %>/'">
		<div class="channel_box">
			<div class="channel_icon"> <img src="${pageContext.request.contextPath}/resources/img/plus.png"> </div>
			<div class="channel_name"> 구독하러 가기 </div>
		</div>
		<button class="cancel_btn_plus">
		구독+
		</button>
	</div>
	</c:if> <!-- member_code 있음!!! -->
	
	<c:if test="${empty member_code }">
		<div id="page_none">
			<img id="none_img" src="${pageContext.request.contextPath}/resources/img/subscribe.png">
			<p id="none_title">마음에 드는 채널을 구독해 보세요.</p>
			<p id="none_text">구독 하거나 편집을 원하시면 로그인하세요.</p>
			<button id="none_btn" onclick="location.href='<%=request.getContextPath() %>/login.do'">로그인</button>
		</div>
	</c:if>

</div> <!-- "." end -->

</div> <!-- "#content_box" end -->

</div> <!-- "#wrap_myPage" end -->
</body>
</html>