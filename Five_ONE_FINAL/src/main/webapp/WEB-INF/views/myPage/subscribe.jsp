<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>
<script type="text/javascript">

function getContextPath(){
	
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}


function getSubscribe_list(member_code){

	$.ajax({

		url : getContextPath() +"/getSubscribe_list.do",
		data : {
			"member_code" : member_code,
		},
		datatype : 'JSON',
		contentType : "application/json; charset=UTF-8",
		success : function(data){
			
			let str = data;

			if(str == "[]"){
				loading = false;
				
			}else{
				
				let subscribe_div = JSON.parse(data);
				let div = "";
				div += "<div class='video_boxs'>"
				$(subscribe_div).each(function(){
					div += "<div class='chanel_area'>";
					div += "<div class='chanel_box'>";
					div += "<div class='channel_icon'> <img src='"+getContextPath()+"/resources/img/unnamed.jpg'> </div>";
					div += "<div class='channel_name'>"+this.channel_name+"</div>";
					div += "</div>";
					div += "<div class='channel_info'>";
					div += "<div class='info_box'>";
					div += "<div class='info_text'>";
					div += "<p class='channel_like'>구독자 "+this.channel_like+"</p>";
					div += "</div>";
					div += "</div>";
					div += "</div>";
					div += "<button class='cancel_btn' onclick=''>구독중</button>";
					div += "</div>";
				});
				div += "</div>";
				loading = true;
				$("#ajax_area").append(div);
			}
		},
		error : function(){
			alert('구독목록 불러오기 오류!!!!!!!!!');
		}
	}); 
}




</script>
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