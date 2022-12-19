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

$("link[rel=stylesheet][href*='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css']").remove();

function getContextPath(){
	let path = location.href.indexOf(location.host)+location.host.length;
	return location.href.substring(path, location.href.indexOf('/', path+1));
}

/* 넘어온 기본 값 */
let channel_code = ${channel_code};
let search = ${search};
/* search가 1이면 search 아님,
 * search가 2이면 search 임.       */
let option = "${option}";
/* option가 "date" 이면 좋아요 누른 날짜 순,
 * option가 "most" 이면 좋아요 높은 순      */
console.log("default channel_code >>> " + channel_code);
console.log("default search >>> " + search);
console.log("default option >>> " + option);

let page_good = 1;
let page_search = 1;
let loading_good = true;
let loading_search = true;

function getGood_new(channel_code, page_good, option){
	console.log("new ajax안에 option 값 >>> " + option);
	$.ajax({
		url : getContextPath() +"/good_new.do",
		data : {
			"channel_code" : channel_code,
			"page" : page_good,
			"option" : option
		},
		datatype : 'JSON',
		contentType : "application/json; charset=UTF-8",
		success : function(data){
			
			let str = data;

			if(str == "[]"){
				loading_good = false;
				
			}else{
				let good = JSON.parse(data);
				let div = "";  
				$(good).each(function(){
					div += "<div class='video_box'>";
					div += "<video class='test_video' src='https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4' controls></video>";
					div += "<div class='video_pbox'>";
					div += "<p class='video_title_p'>"+this.video_title+"<p>";
					div += "<p class='video_channel_p'>"+this.channel_name+" • 조회수 "+this.video_view_cnt+"회</p>";
					div += "<p class='video_views_p'>"+this.video_cont+"<p>";
					div += "</div>";
					div += "<a href='"+getContextPath()+"/good_one_delete.do?video_code="+this.video_code+"&channel_code="+channel_code+"&search="+search+"&option="+option+"'>";
					div += "<img class='video_d_img' src='"+getContextPath()+"/resources/img/x.png'>";
					div += "</a>";
					div += "</div>";
				});
				loading_saerch = false;
				loading_good = true;
				$("#ajax_area").append(div);
			}
		},
		error : function(){
			alert('good_new 불러오기 오류!!!!!!!!!');
		}
	}); 
}

function getGood_search(channel_code, page_search, option) {
	var keyword = "${keyword}";
	console.log("search ajax안에 option 값 >>> " + option);
    $.ajax({
  		url : getContextPath() +"/good_search.do",
  		data : {
  			"channel_code" : channel_code,
			"page" : page_search,
			"keyword" : keyword,
			"option" : option
  		}, 
  		datatype : 'JSON',
  		contentType : "application/json; charset=UTF-8",
  		success : function(data){
			let str = data;
			if(str == "[]"){
				loading_search = false;
				
			}else{
				let good_search = JSON.parse(data);
				let div = "";  
				$(good_search).each(function(){
					div += "<div class='video_box'>";
					div += "<video class='test_video' src='https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4' controls></video>";
					div += "<div class='video_pbox'>";
					div += "<p class='video_title_p'>"+this.video_title+"<p>";
					div += "<p class='video_channel_p'>"+this.channel_name+" • 조회수 "+this.video_view_cnt+"회</p>";
					div += "<p class='video_views_p'>"+this.video_cont+"<p>";
					div += "</div>";
					div += "<a href='"+getContextPath()+"/good_one_delete.do?video_code="+this.video_code+"&channel_code="+channel_code+"&keyword="+keyword+"&search="+search+"&option="+option+"'>";
					div += "<img class='video_d_img' src='"+getContextPath()+"/resources/img/x.png'>";
					div += "</a>";
					div += "</div>";
				});
				loading_good = false;
				loading_search = true;
				$("#search_area").append(div);
			}
		},
		error : function(){
			alert('good_search 불러오기 오류!!!!!!!!!');
		}
	}); 
};	



//기본 실행 함수
if(search == 1) {
	getGood_new(channel_code, page_good, option);	
} else if(search != 1){
	getGood_search(channel_code, page_search, option);
}

//검색 버튼을 클릭했을 때
$(document).on("click", "#search_img", function(){		
	getGood_search(channel_code, page_search, option);
});
//날짜순, 좋아요 순 버튼을 클릭했을때 (일단 <p>태그임)
$(document).on("click", "#good_date", function(){
	console.log("날짜순 눌렀을때 option1 >>> " + option);
	var option = "date";
	console.log("날짜순 눌렀을때 option2 >>> " + option);
	getGood_search(channel_code, page_search, option);
});
$(document).on("click", "#good_most", function(){
	console.log("날짜순 눌렀을때 option1 >>> " + option);
	var option = "most";
	console.log("날짜순 눌렀을때 option2 >>> " + option);
	getGood_search(channel_code, page_search, option);
});
//무한 스크롤
$(window).scroll(function(){
	if($(window).scrollTop()>=$(document).height() - $(window).height()){
		
		console.log("무한스크롤 함수 실행!!! ");
		console.log("무한스크롤 함수 안에 loading_good >>> " + loading_good);
		
		if(loading_good == true){
			page_good++;
			getGood_new(channel_code, page_good);
		} else if(loading_search == true){
			page_search++;
			getGood_search(channel_code, page_search);
		}
	}
}); //scroll end
</script>
</head>
<body>
<div id="wrap_myPage">
	<!-- top 영역 -->
	<jsp:include page="../include/top_include.jsp"/>
	<jsp:include page="../include/side_include.jsp"/>

	<!-- 모달창 관련 링크 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/myPage_CSS/good.css">

	<!-- 오른쪽 사이드 채널 정보 영역 -->
	<div id="channel_area" class="area_style">
		<div id="search_area">
			<form action="<%=request.getContextPath()%>/good_search.do">
				<input type="hidden" name="channel_code" value="${channel_code }">
				<input type="text" class="good_search" name="keyword" placeholder="좋아요 누른 동영상 검색">
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
					<p><a class="btn" href="#good_delete"><span>🗑</span>&nbsp;좋아요 목록 지우기</a></p>
				</div>
			</div>
			
			<hr class="info_hr">
			
			<div class="info_box">
				<div class="info_title">
					<p><a class="btn" href="#good_stop"><span>✂</span>&nbsp;다른기능 or 삭제</a></p>
					<p id="good_date"> 좋아요 누른 날짜 순</p>
					<p id="good_most"> 좋아요 많은 영상 순</p>					
				</div>
			</div>
		</div>
	</div>
	
	<!-- 중앙 메인컨텐츠 영역 -->
	<div id="content_area" class="area_style">
	<c:set var="code" value="${channel_code }" />
		
		<!-- [기록(시청한 동영상)] 박스 -->
		<div id="watch_box" class="content_box">
			<c:if test="${!empty code}">
			<div class="test">
				<p class="content_title1" onclick="location.href='<%=request.getContextPath() %>/good_list.do?channel_code=${channel_code }'">좋아요 누른 동영상</p>
			</div>
			<div id="ajax_area"></div>
			<div id="search_area"></div>
			</c:if>
			
			<!-- 로그인이 되어있지 않으면 출력하는 영역 -->
			<c:if test="${empty code}">
			<div id="page_none">
				<img id="none_img" src="${pageContext.request.contextPath}/resources/img/myPage_no.jpg">
				<p id="none_title">좋아하는 동영상을 감상해 보세요.</p>
				<p id="none_text">저장하거나 좋아요 표시한 동영상을 보려면 로그인하세요.</p>
				<button id="none_btn" onclick="location.href='<%=request.getContextPath() %>/login.do'">로그인</button>
			</div>
			</c:if>
		</div>
		
	</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<!-- ======================================== 모달창 관련 영역 ========================================  -->
<div id="good_delete" class="modal">
	<p class="model_title">좋아요를 해제 할까요?</p>
	<br>
	<p>VIDIDI 시청 기록이 모든 기기의 모든 VIDIDI 앱에서 삭제됩니다.(임시 내용입니다)</p>
	<p>맞춤 동영상이 재설정되지만 다른 제품에서의 활동으로부터 계속 영향을 받을 수 있습니다.</p>
	<br>
	<button class="model_btn" onclick="location.href='delete_good.do?channel_code=${channel_code }'">시청 기록 지우기</button>
</div>
<div id="good_stop" class="modal">
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