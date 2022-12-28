<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIDIVIDI SEARCH</title>

<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- 스타일 시트 -->
<link rel="stylesheet" href="${path }/resources/eunji_CSS/search.css">	
</head>

<body>

<div id="all_content">

<%-- 검색 필드 include 영역 --%>
	<div id="top_wrap">
		<jsp:include page="../include/top_include.jsp"/>
	</div>

<%-- 사이드바 영역 --%>
	<div id="side_wrap">
		<div id="sidebar">
			<jsp:include page="../include/side_include.jsp"/>
		</div>
	</div> 
	

<%-- 정렬 변환 스위치 영역 --%>
	<div class="centerer">
	    <div class="switcher">
	      <input type="radio" name="balance" value="yin" id="yin" class="switcher__input switcher__input--yin" checked="">
	      <label for="yin" class="switcher__label" id="popular">
	      	<i class="fa-solid fa-ranking-star"></i> 인기순</label>
	      
	      <input type="radio" name="balance" value="yang" id="yang" class="switcher__input switcher__input--yang">
	      <label for="yang" class="switcher__label" id="recent">
	      	<i class="fa-solid fa-star"></i> 최신순</label>
	      
	      <span class="switcher__toggle"></span>
	    </div>
	</div>


<%-- 검색 페이지 출력 영역 --%>
	<div id="search_result"></div>

	
<%-- 무한 스크롤 중 로딩... --%>
 <div class="loading_list">
  <div>
    <div class="c1"></div>
    <div class="c2"></div>
    <div class="c3"></div>
    <div class="c4"></div>
  </div>
  <span>loading · · ·</span>
</div>


<%-- 광고 배너 이미지 영역 --%>	
	<div id="adv_box">
		<img alt="경로 못찾음" id="adv" src="${path }/resources/eunji_IMG/side_banner1.png">
	</div>

<%-- 넘어온 값 받기 --%>
	<input type="hidden" value="${keyword }" id="keyword" >
	<input type="hidden" value="${field }" id="field" >
	<input type="hidden" value="${RepChannelCode}" id="code" >

</div> <!-- 전체 div end -->
</body> 


<script type="text/javascript">
/*---------------------------------------------------------검색결과 인기순 ajax + 기본 설정----------------------------------------------------------------  */

let keyword = $("#keyword").val();
let field = $("#field").val();
let play_code = $("#code").val();

let page_rec = 1;
let page_pop = 1;
let check = 0;
let option = "video_regdate";

let loading = true;

function getContextPath(){
    let path = location.href.indexOf(location.host)+location.host.length;
    return location.href.substring(path, location.href.indexOf('/', path+1));
}

function getSearchVideoList_popular(keyword, field, option, page_pop){
	
	$.ajax({
		url : "search_result.do",
		type: "post",
		async : false,
		data : {
			field : field,
			keyword : keyword,
			option : option,
			page : page_pop
		},
		success: function(data){
			
			console.log(field);
			console.log(keyword);
			
			console.log(data);
			console.log("인기순 함수 실행");
			let str = data;
			
			if(str.length == 0){
				$(".loading_list").css("display", "none");
			}
			
			if(str == "[]"){
				loading = false;
				
			}else{
				
				let div = "";
				
				div += "<div class='search_table'>"
				
				$(data).each(function(){
				div += "<div id='watch_box' class='content_box'>";
				div += "<div class='video_box'>";
				
				div += "<video class='test_video' width='320px' height='180px' src='"+getContextPath()+"/resources/AllChannel/"+this.channel_code+"/"+this.video_title+".mp4' controls></video>";
					div += "<div class='video_pbox'>";
					
						//전송용 비디오 코드
						div += "<p class='vi_code'style='display:none;'>" +  this.video_code + "</p>";
						
						//비디오 제목 + 채널 프로필 
						div += "<p class = 'video_title_p'>"+ "<a href='<%=request.getContextPath() %>/watch.do?video_code=" + this.video_code + "'>"
								+ "<img class='channel_profile' src='" + getContextPath() + "/resources/img/channel_profile/" + this.channel_profil+ "'>"
								+ this.video_title + "</a> </p>" + "<button class='play_list_plus' onclick='location.href='#''> <i class='fa-solid fa-plus'></i> </button>";
						
						//재생목록 추가 버튼 클릭 시 팝업
						div += "<div class = 'add_popList' style='display:none;'>" + "<a class='text_title'>" + "<b>●&nbsp; 재생목록 &nbsp;●</b>" +
									"<div class='listResult_pop'> </div>" + 
									"<button class='add_playList'>추가하기</button>" + "</div>"		
						
						//채널명
						div += "<p class = 'video_channel_p'>"+ "<a href='<%=request.getContextPath() %>/channel.do?mc=" + this.channel_code + "'>" + this.channel_name + "</p>";
						
						//조회수 + 업데이트 날짜
						div += "<p class = 'video_view_date_p'>" + "조회수&nbsp;" + this.video_view_cnt + "회" +"&nbsp; <i class='fa-solid fa-carrot'></i> &nbsp;" + this.video_regdate + "</p>";
						
						//비디오 내용
						div += "<p class = 'video_views_p'>" + this.video_cont + "</p>";
					div += "</div>"; //video pbox end
					div += "<hr>"
				div += "</div>"; //video box end
				div += "</div>"; //watch box end
				}); //each end
				
				div += "</div>";
				
				$("#search_result").append($("<div>").html(div));	
		
			}//else end
		},
		
		error: function(){
			console.log(data);
			alert("검색 비디오 리스트 인기 ajax 오류입니다.");
			
		}
	});
}//전체 end

	//기본 인기순	
	if(check == 2) {
		 page_rec = 1;
	 	 page_pop = 1;
		getSearchVideoList_recent(keyword, field, option, page_rec);
	} else if(check != 2){
		 page_rec = 1;
	 	 page_pop = 1;
		getSearchVideoList_popular(keyword, field, option, page_pop);
	};


/*-----------------------------------------------------검색결과 최신순 ajax----------------------------------------------------------------  */
 let vicode = this.video_code;

 function getSearchVideoList_recent(keyword, field, option, page_rec){
	
	$.ajax({
		url : "search_result_new.do",
		type: "post",
		async : false,
		data : {
			field : field,
			keyword : keyword,
			option : option,
			page : page_rec
		},
		success: function(data){
			
			console.log(data);
			console.log("최신순 함수 실행");
			
			let str = data;
			
			if(str.length == 0){
				$(".loading_list").css("display", "none");
			}
			
			if(str == "[]"){
				loading = false;
				
			}else{
			
			let div = "";
			
			div += "<div class='search_table'>"
			
				$(data).each(function(){
					div += "<div id='watch_box' class='content_box'>";
					div += "<div class='video_box'>";
					div += "<video class='test_video' width='320px' height='180px' src='"+getContextPath()+"/resources/AllChannel/"+this.channel_code+"/"+this.video_title+".mp4' controls></video>";
						div += "<div class='video_pbox'>";
						
							//전송용 비디오 코드
							div += "<p class='vi_code'style='display:none;'>" +  this.video_code + "</p>";
							
							//비디오 제목 + 채널 프로필 
							div += "<p class = 'video_title_p'>"+ "<a href='<%=request.getContextPath() %>/watch.do?video_code=" + this.video_code + "'>"
									+ "<img class='channel_profile' src='" + getContextPath() + "/resources/img/channel_profile/" + this.channel_profil+ "'>"
									+ this.video_title + "</a> </p>" + "<button class='play_list_plus' onclick='location.href='#''> <i class='fa-solid fa-plus'></i> </button>";
							
							//재생목록 추가 버튼 클릭 시 팝업
							div += "<div class = 'add_popList' style='display:none;'>" + "<a class='text_title'>" + "<b>●&nbsp; 재생목록 &nbsp;●</b>" +
										"<div class='listResult_pop'> </div>" + 
										"<button class='add_playList'>추가하기</button>" + "</div>"		
							
							//채널명
							div += "<p class = 'video_channel_p'>"+ "<a href='<%=request.getContextPath() %>/channel.do?mc=" + this.channel_code + "'>" + this.channel_name + "</p>";
							
							//조회수 + 업데이트 날짜
							div += "<p class = 'video_view_date_p'>" + "조회수&nbsp;" + this.video_view_cnt + "회" +"&nbsp; <i class='fa-solid fa-carrot'></i> &nbsp;" + this.video_regdate + "</p>";
							
							//비디오 내용
							div += "<p class = 'video_views_p'>" + this.video_cont + "</p>";
						div += "</div>"; //video pbox end
						div += "<hr>"
					div += "</div>"; //video box end
					div += "</div>"; //watch box end
					}); //each end
			
			div += "</div>";
				$("#search_result").append($("<div>").html(div));			
		
			} //else end		
		},
		
		error: function(){
			console.log(data);
			alert("검색 비디오 리스트 최신 ajax 오류입니다.");
		}
	});
}


//-----------------------------------------------------------------토글버튼 클릭 시 소트 정렬--------------------------------------------------------------------

	//인기순 버튼을 클릭했을 때
	$(document).on("click", ".switcher__input--yin", function(){
		check = 1;
		page_rec = 1;
		page_pop = 1;
		option = "video_good";

		$(".search_table").remove();
		console.log("인기순>>>" + check);
		getSearchVideoList_popular(keyword, field, option, page_pop);
	});
	
	//최신순 버튼을 클릭했을 때
	$(document).on("click", ".switcher__input--yang", function(){
		check = 2;
		page_rec = 1;
		page_pop = 1;
		
		$(".search_table").remove();
		console.log("최신순>>>" + check);
		getSearchVideoList_recent(keyword, field, option, page_rec);
	});
	
	
//--------------------------------------------------------------비디오 hover시 자동재생--------------------------------------
	$(document).on("mouseover", ".test_video", function(){
		 $(this).get(0).play();
	});
	
	$(document).on("mouseout", ".test_video", function(){
		 $(this).get(0).pause();
	});	
	
	
// -------------------------------------------------------모달 클릭 시 재생목록 리스트 불러오기 ---------------------------------------------

//재생목록 데이터 지우기
function close() {
	console.log("지우기 함수 실행");
	$(".pl_tr").remove();
}

//클릭 시 재생목록 추가 창 보이기
$(document).on("click", ".play_list_plus", function(){
	
	if(${empty RepChannelCode }){
		alert("로그인 이후 이용할 수 있는 서비스입니다.");
	}else{
		
		if(this.nextElementSibling.style.display == "none"){
			this.nextElementSibling.style.display = 'block';
			close();
			getPlayList(play_code);
		}else{
			close();
			this.nextElementSibling.style.display = 'none';
		}	
	}//감싸는 else end
	
});


//재생목록 가져오기 함수
function getPlayList(play_code){
	
	$.ajax({
		url : "playList_result.do",
		type: "post",
		data: {
			play_code : play_code
		},
		success: function(data){
			
			console.log("리스트 함수 성공");
			
			if(data.length > 0){
			
				let table = "";
				
				table += "<table class='playList_table'>"
				
				$(data).each(function(){
					table += "<tr class='pl_tr'>";
					table += "<td style='display:none;'>" + this.bundle_code + "</td>";
					table += "<td>" + "<input type='radio' name='play_radio' class='click_radio'>" + this.bundle_title + "</td>";
					table += "</tr>";
					
				}); //each end
				
				table += "</table>";
					$(".listResult_pop").append($("<table>").html(table));	
				
			}else{
				console.log("데이터 없음");
			}
					
		},
		
		error: function(){
			alert("재생 목록 리스트 ajax 오류입니다.");
			console.log("data>>>" + data);
		}
	});
		
}//재생목록 end


//-----------------------------------------------------------해당 영상 재생목록에 추가하기-------------------------------------------------

//라디오 버튼 클릭 시 필요한 값 받아오기
let radio_code = '';
let radio_title = '';
let add_video_code = '';
let add_video_title = '';

$(document).on("click", ".click_radio", function(){
	radio_code = this.parentElement.parentElement.firstChild.textContent;
	radio_title= this.parentElement.parentElement.firstChild.nextElementSibling.textContent;
	add_video_code = this.parentNode.parentNode.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.firstChild.firstChild.textContent;
	//add_video_title = this.parentNode.parentNode.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.firstChild.firstChild.nextElementSibling.textContent;
	
	console.log(radio_code);
	console.log(radio_title);
	console.log(add_video_code);
	//console.log(add_video_title);
	
}); //추가 함수 end


//등록 함수 
function addPlayList(){	
	
	console.log("~~~~~~~~~~~~등록 함수 실행~~~~~~~~~~~~~");
	
	$.ajax({
		url : "playList_add.do",
		type: "post",
		data: {
			//멤버코드
			play_code: play_code,
			//번들 제목
			play_bundle_title: radio_title, 
			//비디오 코드
			play_video_code: add_video_code,
			//번들 번호 코드
			play_bundle_code: radio_code
		},
		success: function(data){
			alert("해당 재생목록에 추가되었습니다.");
		},
		
		error: function(){
			alert("재생목록 추가에 실패했습니다.");
			console.log("data>>>" + data);
		}
	});	
}

//추가하기 버튼 클릭 시
$(document).on("click", ".add_playList", function(){
	console.log("클릭 함수 실행");
	addPlayList();
}); //추가 함수 end
	
//---------------------------------------------------------------- 배너 스크롤 따라 이동 ---------------------------------------------------------------------	

	// 기본 위치(top)값
		var floatPosition = parseInt($("#adv_box").css('top'))
	
	// scroll 인식
		$(window).scroll(function() {
				  
	// 현재 스크롤 위치
		var currentTop = $(window).scrollTop();
		var bannerTop = currentTop + floatPosition + "px";
	
	//이동 애니메이션
		$("#adv_box").stop().animate({
			"top" : bannerTop
		}, 750);

		}).scroll();
		
//-----------------------------------------------------------------무한 스크롤------------------------------------------

 	let scroll_check = false;

	   $(window).scroll(function(){
	   scroll_check = true;
	  });
	  
	   setInterval(function() {
	       if (scroll_check) {
	           scroll_check = false;

	           if($(window).scrollTop()>=$(document).height() - $(window).height()){
	        	   if(loading){
	        		   
	        		   if(check == 1){
	        			   page_pop++;
		        	 	   getSearchVideoList_popular(keyword, field, option, page_pop);
		        	 	   
	        		   }else if(check == 2){
	        			   page_rec++;
	        			   getSearchVideoList_recent(keyword, field, option, page_rec);
	        			   
	        		   }else if(check == 0){
	        			   page_pop++;
		        	 	   getSearchVideoList_popular(keyword, field, option, page_pop);
	        		   }
	        		  
	        	   } //loading if end
	        	   
	           } //전체 if end
	       }
	   }, 250); // 무한 스크롤 end		


</script>

</html>