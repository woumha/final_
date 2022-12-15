<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
window.onload = function() {

	let channel_code = ${channel_code };
	console.log('channel_code >>> ' + channel_code);
	
	let video_location = 'https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4';
	
/* 	$.ajax({
		console.log('==================================');
		console.log('channel_code >>> ' + channel_code);
		
		type: "get",
		url: getContextPath()+"/history.do?channel_code"+channel_code,
		dataType: "json",
		success:function(data){
			var s= "";
				let list = data.datas;
				$(list).each(function(i,item){
				s+= "<div class='video_box'>"
				s+= "<video class='test_video' src="+item.video_location+" controls></video>";
				s+= "<div class='video_pbox'>";
				s+= "<p class='video_title_p'>"+item.video_title+"<p>";
				s+= "<p class='video_channel_p'>"+item.channel_name+" • 조회수 "+item.video_view_cnt+"회<p>";
				s+= "<p class='video_views_p'>"+item.video_cont+"<p>";
				s+= "</div>";
				s+= "<a href='+"{path}"+/history_one_delete.do?video_code="+item.video_code+"&channel_code="+channel_code+"'>";
				s+= "<img class='video_history_d_img' src='+"{path}+"/resources/img/x.png'>";
				s+= "</a>";
				s+= "</div>";
				});
			
			$("#ajax_area").html(s)
		}
	});
}; 
*/
/* 
function history_list() {
	$.ajax({
		url : getContextPath()+"/history_test.do?channel_code="+channel_code,
		type : "get",
		dataType : "json",
		success : history_list,
		error : function () {alert("error");}
	});
}

function history_list(data) {
	var result = "";
	$.each(data, (i,item)){
		result+= "<div class='video_box'>"
		result+= "<video class='test_video' src="+item.video_location+" controls></video>";
		result+= "<div class='video_pbox'>";
		result+= "<p class='video_title_p'>"+item.video_title+"<p>";
		result+= "<p class='video_channel_p'>"+item.channel_name+" • 조회수 "+item.video_view_cnt+"회<p>";
		result+= "<p class='video_views_p'>"+item.video_cont+"<p>";
		result+= "</div>";
		result+= "<a href='+"{path}"+/history_one_delete.do?video_code="+item.video_code+"&channel_code="+channel_code+"'>";
		result+= "<img class='video_history_d_img' src='"+{path}+"/resources/img/x.png'>";
		result+= "</a>";
		result+= "</div>";
	});
}
 */

</script>

</head>
<body>

<ul id="list"></ul>
<div id="observer"></div>


<div id="wrap_myPage">

	<!-- top 영역 -->
	<jsp:include page="../include/top_include.jsp"/>
	<jsp:include page="../include/side_include.jsp"/>

	<!-- 모달창 관련 링크 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/myPage_CSS/history.css">

	<!-- 오른쪽 사이드 채널 정보 영역 -->
	<div id="channel_area" class="area_style">
		<div id="history_search_area">
			<form action="<%=request.getContextPath()%>/history_search.do">
				<input type="hidden" name="channel_code" value="995">
				<input type="text" class="history_search" name="keyword" placeholder="시청 기록 검색">
				<input id="search_img" type="image" src="${pageContext.request.contextPath}/resources/img/search_img.jpg">
			</form>
		</div>
	
		<div id="profile_info">
			<div class="info_box">
				<div class="info_title">
					<p><a class="btn" href="<%=request.getContextPath() %>/myPage_go.do?channel_code=${channel_code }"><span>🗃</span> 내 보관함</a></p>
				</div>
			</div>
			
			<hr class="info_hr">
			
			<div class="info_box">
				<div class="info_title">
					<p><a class="btn" href="#history_delete"><span>🗑</span>&nbsp;시청 기록 지우기</a></p>
				</div>
			</div>
			
			<hr class="info_hr">
			
			<div class="info_box">
				<div class="info_title">
					<p><a class="btn" href="#history_stop"><span>✂</span>&nbsp;시청 기록 일시정지</a></p>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 중앙 메인컨텐츠 영역 -->
	<div id="content_area" class="area_style">
		
		<!-- [기록(시청한 동영상)] 박스 -->
		<div id="watch_box" class="content_box">
			<div class="test">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/history_list.do?channel_code=${channel_code }">시청 기록</a></p>
			</div>
			
			<c:set var="endValue" value="200"/>
			
			<c:set var="history" value="${h_list }" />
			<c:if test="${!empty history }">
			<div id="ajax_area"></div>
			<c:forEach items="${history }" var="h_dto" begin="0" end="${endValue }">
			
			<!-- ============================= forEach 반복 시작 ============================= -->
			<div class="video_box">
				<video class="test_video" src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
				<div class="video_pbox">
					<p class="video_title_p">${h_dto.getVideo_title() }<p>
					<p class="video_channel_p">
					${h_dto.getChannel_name() } • 조회수
					<%-- 조회수 출력 영역 --%>
					<c:set var="cnt" value="${h_dto.getVideo_view_cnt() }" />
					<c:if test="${cnt < 1000 }">${cnt }회</c:if>
					<c:if test="${cnt >= 1000 && cnt < 10000 }">
						<fmt:formatNumber value="${cnt / 1000 }" pattern=".0" />천회
					</c:if>
					<c:if test="${cnt >= 10000 && cnt < 100000 }">
						<fmt:formatNumber value="${cnt / 10000 }" pattern=".0" />만회
					</c:if>
					<c:if test="${cnt >= 100000 && cnt < 100000000 }">
						<fmt:formatNumber value="${cnt / 10000 }" pattern="0" />만회
					</c:if>
					<c:if test="${cnt >= 100000000 }">
						<fmt:formatNumber value="${cnt / 100000000 }" pattern=".00" />억회
					</c:if>
					<%-- 구독자 출력 영역 끝 --%>
					<p>
					<p class="video_views_p">${h_dto.getVideo_cont() }<p>
				</div>
				<a href="<%=request.getContextPath() %>/history_one_delete.do?video_code=${h_dto.getVideo_code() }&channel_code=${channel_code }">
					<img class="video_history_d_img" src="${pageContext.request.contextPath}/resources/img/x.png">
				</a>
			</div>
			<!-- ============================= forEach 반복 end ============================= -->
			</c:forEach>
			</c:if>
			
			<p id="sentinel"></p>
			<c:if test="${empty history }">
				목록에 동영상이 없습니다.
			</c:if>
		</div>
	</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<!-- ======================================== 모달창 관련 영역 ========================================  -->
<div id="history_delete" class="modal">
	<p class="model_title">시청 기록을 삭제할까요?</p>
	<br>
	<p>VIDIDI 시청 기록이 모든 기기의 모든 VIDIDI 앱에서 삭제됩니다.(임시 내용입니다)</p>
	<p>맞춤 동영상이 재설정되지만 다른 제품에서의 활동으로부터 계속 영향을 받을 수 있습니다.</p>
	<br>
	<button class="model_btn" onclick="location.href='delete_history.do?channel_code=${channel_code }'">시청 기록 지우기</button>
</div>
<div id="history_stop" class="modal">
	<p class="model_title">시청 기록을 중지할까요?</p>
	<br>
	<p>VIDIDI 시청 기록이 모든 기기의 모든 VIDIDI 앱에서 기록 중지됩니다.(임시 내용입니다)</p>
	<p>맞춤 동영상이 재설정되지만 다른 제품에서의 활동으로부터 계속 영향을 받을 수 있습니다.</p>
	<br>
	<button class="model_btn" onclick="location.href='dont_save_history.do?member_code=VD00002'">시청 기록 중지하기</button>
</div>
<!-- ====================================== 모달창 자바 스크립트 영역 ====================================== -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/myPage/myPage_JavaScript/history.js"></script>
<!-- ======================= 모달창 관련 영역 end =======================  -->
</body>
</html>