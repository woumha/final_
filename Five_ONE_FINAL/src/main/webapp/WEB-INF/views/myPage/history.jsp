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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	$("link[rel=stylesheet][href*='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css']").remove();

	function getContextPath(){
		
		let path = location.href.indexOf(location.host)+location.host.length;
		
		return location.href.substring(path, location.href.indexOf('/', path+1));
	}

	let channel_code = ${channel_code};
	console.log(channel_code);
	let page_history = 1;
	
	let loading_history = true;
	
	function getHistory_new(channel_code, page_history, video_loction){

		$.ajax({

			url : getContextPath() +"/history_new.do",
			data : {
				"channel_code" : channel_code,
				"page" : page_history 
			},
			datatype : 'JSON',
			contentType : "application/json; charset=UTF-8",
			success : function(data){
				
				let str = data;

				if(str == "[]"){
					loading_history = false;
				}else{
					let history = JSON.parse(data);
					
					let div = "";  


					$(history).each(function(){
						/* div += "<div>Hello</div>"; */
						div += "<div class='video_box'>";
						div += "<video class='test_video' src='https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4' controls></video>";
						div += "<div class='video_pbox'>";
						div += "<p class='video_title_p'>"+this.video_title+"<p>";

						div += "<p class='video_channel_p'>"+this.channel_name+" • 조회수 "+this.video_view_cnt+"회</p>";
						div += "<p class='video_views_p'>"+this.video_cont+"<p>";
						div += "</div>";
						div += "<a href='"+getContextPath()+"/history_one_delete.do?video_code="+this.video_code+"&channel_code="+channel_code+"'>";
						div += "<img class='video_history_d_img' src='"+getContextPath()+"/resources/img/x.png'>";

						div += "</a>";
						div += "</div>";
					});
					
					
					$("#ajax_area").append(div);
				}
			},

			error : function(){
				alert('히스토리 불러오기 오류!!!!!!!!!');
			}
			
		}); 
	
	}
	//  기본 실행 함수
	getHistory_new(channel_code, page_history);
	
	
	// 무한 스크롤
	$(window).scroll(function(){

		if($(window).scrollTop()>=$(document).height() - $(window).height()){
			if(loading_history){
				page_history++;
				getHistory_new(channel_code, page_history);
			}
		}
		
	}); //scroll end
	
	//인기순 버튼을 클릭했을 때
	$(document).on("click", ".content_title1", function(){		
		getHistory_search(channel_code, page_history, keyword);
	});
	
	
	
	
});

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
				<input type="hidden" name="channel_code" value="${channel_code}">
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
				<button class="content_title1">시청 기록</button>
			</div>
			<div id="ajax_area"></div>
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