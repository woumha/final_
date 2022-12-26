<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<html>
<head>

<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<!-- 스타일 시트 -->
<link rel="stylesheet" href="${path }/resources/eunji_CSS/main.css">	

<title>VIDIVIDI</title>
</head>

<body align="center">

<%-- 검색 필드 include 영역 --%>

	<div id="top_wrap">
		<jsp:include page="./include/top_include.jsp"/>
	</div>
	
	<br>

<%-- 카테고리 영역 --%>

	<nav id="mainnav" class="group">
	    <div id="menu">&#x2261; Menu</div>
	    <ul>
	        <li id="all"><a href="#">전체</a></li>
	        <li id="music"><a href="#">음악</a></li>
	        <li id="game"><a href="#">게임</a></li>
	        <li id="cook"><a href="#">요리</a></li>
	        <li id="sports"><a href="#">스포츠</a></li>
	        <li id="news"><a href="#">뉴스</a></li>
	        <li id="education"><a href="#">교육</a></li>
	        <li id="kids"><a href="#">유아</a></li>
	    </ul>
	</nav>
	 	

<%-- 캐러셀 영역 --%>

<div id="slide_wrap">
	
		<div id="slide"> 
	
		<section id="section">
		  <ul class="carousel">
		    <li class="items main-pos" id="1">
		    <iframe width="600" height="320" src="https://www.youtube.com/embed/D1xoRXtzc8c" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items right-pos" id="2">
		      <iframe width="600" height="320" src="https://www.youtube.com/embed/UFovWG_A_fk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items back-pos" id="3">
		      <iframe width="600" height="320" src="https://www.youtube.com/embed/YHQmzncbIds" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items back-pos" id="4">
		    <iframe width="600" height="320" src="https://www.youtube.com/embed/M0O2YjP7ngw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items back-pos" id="5">
		     <iframe width="600" height="320" src="https://www.youtube.com/embed/Kmgo00avvEw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items back-pos" id="6">
		      <iframe width="600" height="320" src="https://www.youtube.com/embed/4Qry1Osot08" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items left-pos" id="7">
		    <iframe width="600" height="320" src="https://www.youtube.com/embed/I9vK5EVTt0U" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		  </ul>
		  
		  <div id = "slidebtn_wrap">
			<button id="prev"><i class="fa-solid fa-angles-left"></i></button>
			<button id="next"><i class="fa-solid fa-angles-right"></i></button>
		  </div>
		  
	</section>
    </div>
    	
  </div>  
	
	<br>
	
	<div id="re_label">
		<button class="custom-btn re_btn"><i class="fa-solid fa-ranking-star"></i>&nbsp;&nbsp;추천 동영상</button>
		<button class="custom-btn up_btn"><i class="fa-solid fa-star"></i>&nbsp;&nbsp;신규 동영상</button>
	</div>
	
	
<%-- 사이드바 영역 --%>
	<div id="side_wrap">
		<div id="sidebar">
			<jsp:include page="./include/side_include.jsp"/>
		</div>
	</div>
	 
	
<%-- 동영상 리스트 영역 --%>
<div id = "video_wrap">
	<div class="video_list"> </div> 
</div> 
	
<%-- 무한 스크롤 중 로딩... --%>
 <div class="loading_list">
	<div>
	    <div class="c1"></div>
	    <div class="c2"></div>
	    <div class="c3"></div>
	    <div class="c4"></div>
	</div>
	  <span>loading ···</span>
</div>


<%-- 하단 영역 --%>	  
	<%-- <div id="bottom_wrap">
		<jsp:include page="./include/bottom_include.jsp"/>
	</div> --%>
	
</body>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
<script>

//-------------------------------------------------------------동영상 리스트 ajax(인기도순)--------------------------------------------------------

let loading = true;
let page_rec = 1;
let page_pop = 1;
let page_sort = 1;
let check = 0;
var option = "{$option}"; 

function getContextPath(){
    let path = location.href.indexOf(location.host)+location.host.length;
    return location.href.substring(path, location.href.indexOf('/', path+1));
}


	//좋아요 순 정렬
	function getMainVideoList_popular(page_pop){
		$.ajax({
			url : "mainVideoList.do",
			type: "post",
			async : false,
			data: {
				page : page_pop
			},
			success: function(data){
				
				console.log("인기순 함수 실행");
				console.log(data);
				console.log(check);

				let str = data;
				
				if(str.length == 0){
					$(".loading_list").css("display", "none");
				}
				
				if(str == "[]"){
					loading = false;
				}else{

					var table = "";
					
					table += "<table class='video_table'>"
					
					$(data).each(function(){
					
					table += "<tr>";
					table += "<td colspan='2'>" + "<video class='test_video' controls width='320px' height='180px' poster='" + getContextPath() + "/resources/img/vidividi_logo.png'" +
								"src='https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4' controls></video>" + "</td>";
					
					table += "<td class = 'video_title'>" + "<a href='<%=request.getContextPath() %>/watch.do?video_code=" + this.video_code + "'>" +
								"<img class='channel_profile' src='" + getContextPath() + "/resources/img/" + this.channel_profil+ "'>"
								+ '&nbsp;' + this.video_title + "</td>";
																	
					table += "<td class = 'video_channel'>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + 
								"<a href='<%=request.getContextPath() %>/channel.do?mc=" + this.channel_code + "'>" + this.channel_name + "</td>";
					
					table += "<td class = 'video_view_ctn'>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "조회수&nbsp;" + this.video_view_cnt + "회" +
								"&nbsp; <i class='fa-solid fa-carrot'></i> &nbsp;" + this.video_regdate; +"</td>";
					table += "</tr>";
									
					table += "<tr>";
					table += "<td>" + "</td>";
					table += "</tr>";
					table += "<tr>";
					table += "<td>" + "</td>";
					table += "</tr>";
					table += "<tr>";
					table += "<td>" + "</td>";
					table += "</tr>";
					table += "<tr>";
					table += "<td>" + "</td>";
					table += "</tr>";
					
					}); //each end
					
					table += "</table>";
					
					$(".video_list").append($("<div>").html(table));		
				}	
			},
			error: function(){
				alert("메인 비디오 리스트 ajax 오류입니다.");
				
			}
		});
	}
	
	//기본 인기순	
	if(check == 2) {
        page_rec = 1;
 	    page_pop = 1;
		getMainVideoList_recent(page_rec);
	} else if(check != 2){
        page_rec = 1;
 	    page_pop = 1;
		getMainVideoList_popular(page_pop);
	};
	
//----------------------------------------------------------------동영상 리스트 ajax(최신순)-------------------------------------------------------------------------
 
//최신순 정렬
function getMainVideoList_recent(page_rec){
		$.ajax({
			url : "mainVideoList_up.do",
			type: "post",
			async : false,
			data: {
				page : page_rec
			},
			success: function(data){
				
				console.log("최신순 함수 실행");
				console.log(data);
				console.log(check);
				
				let str = data;
				
				if(str.length == 0){
					$(".loading_list").css("display", "none");
				}

				if(str == "[]"){
					loading = false;
					
				}else{

				var table = "";
				
				table += "<table class='video_table'>"
				
				$(data).each(function(){
				
					table += "<tr>";
					table += "<td colspan='2'>" + "<video class='test_video' controls width='320px' height='180px' poster='" + getContextPath() + "/resources/img/vidividi_logo.png'" +
								"src='https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4' controls></video>" + "</td>";

					table += "<td class = 'video_title'>" + "<a href='<%=request.getContextPath() %>/watch.do?video_code=" + this.video_code + "'>" +
								"<img class='channel_profile' src='" + getContextPath() + "/resources/img/" + this.channel_profil+ "'>"
								+ '&nbsp;' + this.video_title + "</td>";

					table += "<td class = 'video_channel'>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + 
								"<a href='<%=request.getContextPath() %>/channel.do?mc=" + this.channel_code + "'>" + this.channel_name + "</td>";
					
					table += "<td class = 'video_view_ctn'>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + 
								"조회수&nbsp;" + this.video_view_cnt + "회" +"&nbsp; <i class='fa-solid fa-carrot'></i> &nbsp;" + this.video_regdate; +"</td>";
					table += "</tr>";
					
					table += "<tr>";
					table += "<td>" +"</td>";
					table += "</tr>";
					table += "<tr>";
					table += "<td>" + "</td>";
					table += "</tr>";
					table += "<tr>";
					table += "<td>" + "</td>";
					table += "</tr>";
					table += "<tr>";
					table += "<td>" + "</td>";
					table += "</tr>";

				}); //each end
				
				table += "</table>";
				
				$(".video_list").append($("<div>").html(table));
				
				}	
			},
			error: function(){
				alert("신규 비디오 리스트 ajax 오류입니다.");
				
			}
		});
	} //최신순 정렬 end

  
	//인기순 버튼을 클릭했을 때
	$(document).on("click", ".re_btn", function(){
		check = 1;
        page_rec = 1;
 	    page_pop = 1;
 	    $(".video_table").remove();
		getMainVideoList_popular(page_pop);
	});
	  
	//최신순 버튼을 클릭했을 때
	$(document).on("click", ".up_btn", function(){
		check = 2;
        page_rec = 1;
 	    page_pop = 1;
 	    console.log('버튼 클릭 시 최신 페이지' + page_rec);
 	    console.log('버튼 클릭 시 인기 페이지' + page_pop);
		$(".video_table").remove();
		getMainVideoList_recent(page_rec);
	});

	
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
	        		   
	        		   if(check == 0){
	        			   page_pop++;
	        			   getMainVideoList_popular(page_pop);
	        			   console.log('인기순 페이지' + page_pop);
	        			   
	        		   }else if(check == 1){
	        			   page_pop++;
	        			   getMainVideoList_popular(page_pop);
	        			   console.log('인기순 페이지' + page_pop);
	        			   
	        		   }else if(check == 2){
	        			   page_rec++;
	        			   getMainVideoList_recent(page_rec);
	        			   console.log('최신순 페이지' +page_rec);
	        			   
	        		   }
	        		   
	        	   }else{
	        		   $(".loading_list").css("display", "none");
	        	   }//loading end
	           }else{
	        	  // $(".loading_list").css("display", "none");
	           }
	       }
	   }, 250); // 무한 스크롤 end
		
	
//--------------------------------------------------------------비디오 hover시 자동재생--------------------------------------
	$(document).on("mouseover", ".test_video", function(){
		 $(this).get(0).play();
	});
	
	$(document).on("mouseout", ".test_video", function(){
		 $(this).get(0).pause();
	});	

//----------------------------------------------------------------동영상 리스트 ajax(상단 내비 소트 정렬)-------------------------------------------------------------------------
	 
	//소트 정렬
	function getMainVideoList_sort(page_sort, option){
			$.ajax({
				url : "mainVideoList_sort.do",
				type: "post",
				data: {
					option : option,
					page : page_sort
				},
				success: function(data){
					
					console.log("소트 함수 실행");
					
					let str = data;
					
					if(str.length == 0){
						$(".loading_list").css("display", "none");
					}

					if(str == "[]"){
						loading = false;
						
					}else{
					
					var table = "";
					
					table += "<table class='video_table'>"
					
					$(data).each(function(){
					
						table += "<tr>";
						table += "<td colspan='2'>" + "<video class='test_video' controls width='320px' height='180px' poster='" + getContextPath() + "/resources/img/vidividi_logo.png'" +
									"src='https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4' controls></video>" + "</td>";
		
						table += "<td class = 'video_title'>" + "<a href='<%=request.getContextPath() %>/watch.do?video_code=" + this.video_code + "'>" +
									"<img class='channel_profile' src='" + getContextPath() + "/resources/img/" + this.channel_profil+ "'>"
									+ '&nbsp;' + this.video_title + "</td>";

						table += "<td class = 'video_channel'>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + 
									"<a href='<%=request.getContextPath() %>/channel.do?mc=" + this.channel_code + "'>" + this.channel_name + "</td>";
						
						table += "<td class = 'video_view_ctn'>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "조회수&nbsp;" + this.video_view_cnt + "회" +"&nbsp; <i class='fa-solid fa-carrot'></i> &nbsp;" + this.video_regdate; +"</td>";
						table += "<tr>";
						table += "<td>" + "</td>";
						table += "</tr>";
						table += "<tr>";
						table += "<td>" + "</td>";
						table += "</tr>";
						table += "<tr>";
						table += "<td>" + "</td>";
						table += "</tr>";
						table += "<tr>";
						table += "<td>" + "</td>";
						table += "</tr>"
					}); //each end
					
					table += "</table>";
						
					$(".video_list").append($("<div>").html(table));
				
					}//else end
				},
				error: function(){
					alert("소트 정렬 비디오 리스트 ajax 오류입니다.");
				}
			});
		} //소트 정렬 end
	
	
//-----------------------------------------------------------------상단 내비 소트-------------------------------------------------

	//전체 카테고리 선택
	$(document).on("click", "#all", function(){
		$("#slide_wrap").css("display", "block"); $("#re_label").css("display", "block");
		$("#all").css("background-color", "#fc942c"); $("#music").css("background-color", "#424242");
		$("#game").css("background-color", "#424242"); $("#cook").css("background-color", "#424242");
		$("#sports").css("background-color", "#424242"); $("#news").css("background-color", "#424242");
		$("#education").css("background-color", "#424242"); $("#kids").css("background-color", "#424242");
		
		$(".video_table").remove();
		check = 2;
        page_rec = 1;
 	    page_pop = 1;
		getMainVideoList_popular(page_pop);
	});
	
	//음악 카테고리 선택
	$(document).on("click", "#music", function(){
		$("#slide_wrap").css("display", "none"); $("#re_label").css("display", "none");
		$("#all").css("background-color", "#424242"); $("#music").css("background-color", "#fc942c");
		$("#game").css("background-color", "#424242"); $("#cook").css("background-color", "#424242");
		$("#sports").css("background-color", "#424242"); $("#news").css("background-color", "#424242");
		$("#education").css("background-color", "#424242"); $("#kids").css("background-color", "#424242");
		
		$(".video_table").remove();
		var option = 100;
		getMainVideoList_sort(page_sort, option);
		$(".video_table").css("margin-left", "11%");
	});
	
	//게임 카테고리 선택
	$(document).on("click", "#game", function(){
		$("#slide_wrap").css("display", "none"); $("#re_label").css("display", "none");
		$("#all").css("background-color", "#424242"); $("#music").css("background-color", "#424242");
		$("#game").css("background-color", "#fc942c"); $("#cook").css("background-color", "#424242");
		$("#sports").css("background-color", "#424242"); $("#news").css("background-color", "#424242");
		$("#education").css("background-color", "#424242"); $("#kids").css("background-color", "#424242");
		
		$(".video_table").remove();
		var option = 200;
		getMainVideoList_sort(page_sort, option);
		
	});
	
	//요리 카테고리 선택
	$(document).on("click", "#cook", function(){
		$("#slide_wrap").css("display", "none"); $("#re_label").css("display", "none");
		$("#all").css("background-color", "#424242"); $("#music").css("background-color", "#424242");
		$("#game").css("background-color", "#424242"); $("#cook").css("background-color", "#fc942c");
		$("#sports").css("background-color", "#424242"); $("#news").css("background-color", "#424242");
		$("#education").css("background-color", "#424242"); $("#kids").css("background-color", "#424242");

		$(".video_table").remove();
		var option = 300;
		getMainVideoList_sort(page_sort, option);
	});
	
	
	//스포츠 카테고리 선택
	$(document).on("click", "#sports", function(){
		$("#slide_wrap").css("display", "none"); $("#re_label").css("display", "none");
		$("#all").css("background-color", "#424242"); $("#music").css("background-color", "#424242");
		$("#game").css("background-color", "#424242"); $("#cook").css("background-color", "#424242");
		$("#sports").css("background-color", "#fc942c"); $("#news").css("background-color", "#424242");
		$("#education").css("background-color", "#424242"); $("#kids").css("background-color", "#424242");
		
		$(".video_table").remove();
		var option = 400;
		getMainVideoList_sort(page_sort, option);
	});
	
	//뉴스 카테고리 선택
	$(document).on("click", "#news", function(){
		$("#slide_wrap").css("display", "none"); $("#re_label").css("display", "none");
		$("#all").css("background-color", "#424242"); $("#music").css("background-color", "#424242");
		$("#game").css("background-color", "#424242"); $("#cook").css("background-color", "#424242");
		$("#sports").css("background-color", "#424242"); $("#news").css("background-color", "#fc942c");
		$("#education").css("background-color", "#424242"); $("#kids").css("background-color", "#424242");
		
		$(".video_table").remove();
		var option = 500;
		getMainVideoList_sort(page_sort, option);
	});
	
	
	//교육 카테고리 선택
	$(document).on("click", "#education", function(){
		$("#slide_wrap").css("display", "none"); $("#re_label").css("display", "none");
		$("#all").css("background-color", "#424242"); $("#music").css("background-color", "#424242");
		$("#game").css("background-color", "#424242");$("#cook").css("background-color", "#424242");
		$("#sports").css("background-color", "#424242"); $("#news").css("background-color", "#424242");
		$("#education").css("background-color", "#fc942c"); $("#kids").css("background-color", "#424242");
		
		$(".video_table").remove();
		var option = 600;
		getMainVideoList_sort(page_sort, option);
	});
	
	//아동용 카테고리 선택
	$(document).on("click", "#kids", function(){
		$("#slide_wrap").css("display", "none"); $("#re_label").css("display", "none");
		$("#all").css("background-color", "#424242"); $("#music").css("background-color", "#424242");
		$("#game").css("background-color", "#424242"); $("#cook").css("background-color", "#424242");
		$("#sports").css("background-color", "#424242"); $("#news").css("background-color", "#424242");
		$("#education").css("background-color", "#424242"); $("#kids").css("background-color", "#fc942c");
		
		$(".video_table").remove();
		var option = 700;
		getMainVideoList_sort(page_sort, option);
	});	


//----------------------------------------------------------------------카테고리------------------------------------------------------------------------
	$(document).ready(function() {
	//네비바 토글
	$('#menu').bind('click',function(event){
		$('#mainnav ul').slideToggle();
	});
			$(window).resize(function(){  
			var w = $(window).width();  
			if(w > 768) {  
			$('#mainnav ul').removeAttr('style');  
		  }  
	   });		
	});

//----------------------------------------------------------------------캐러셀------------------------------------------------------------------------

	//슬라이드 쇼 움직이는 속도
	var autoSwap = setInterval( swap,3500);
	
	//마우스 빠지면 슬라이드 멈추기
	$('ul, span').hover(
	  function () {
	    clearInterval(autoSwap);
	}, 
	  function () {
	   autoSwap = setInterval( swap,3500);
	});
	
	var items = [];
	var startItem = 1;
	var position = 0;
	var itemCount = $('.carousel li.items').length;
	var leftpos = itemCount;
	var resetCount = itemCount;
	
	$('li.items').each(function(index) {
	    items[index] = $(this).text();
	});
	
	//이미지 바뀌기
	function swap(action) {
	  var direction = action;
	  
	  //캐러셀 뒤로 가기
	  if(direction == 'counter-clockwise') {
	    var leftitem = $('.left-pos').attr('id') - 1;
	    if(leftitem == 0) {
	      leftitem = itemCount;
	    }
	    
	    $('.right-pos').removeClass('right-pos').addClass('back-pos');
	    $('.main-pos').removeClass('main-pos').addClass('right-pos');
	    $('.left-pos').removeClass('left-pos').addClass('main-pos');
	    $('#'+leftitem+'').removeClass('back-pos').addClass('left-pos');
	    
	    startItem--;
	    if(startItem < 1) {
	      startItem = itemCount;
	    }
	  }
	  
	  //캐러샐 앞으로 가기
	  if(direction == 'clockwise' || direction == '' || direction == null ) {
	    function pos(positionvalue) {
	      if(positionvalue != 'leftposition') {
	        //리스트 아이디 증가
	        position++;
	        
	        //등록 동영상 끝까지 가면 처음으로 돌아오기
	        if((startItem+position) > resetCount) {
	          position = 1-startItem;
	        }
	      }
	    
	      //왼쪽 아이템 세팅
	      if(positionvalue == 'leftposition') {
	        
	        position = startItem - 1;
	      
	        if(position < 1) {
	          position = itemCount;
	        }
	      }
	   
	      return position;
	    }  
	  
	   $('#'+ startItem +'').removeClass('main-pos').addClass('left-pos');
	   $('#'+ (startItem+pos()) +'').removeClass('right-pos').addClass('main-pos');
	   $('#'+ (startItem+pos()) +'').removeClass('back-pos').addClass('right-pos');
	   $('#'+ pos('leftposition') +'').removeClass('left-pos').addClass('back-pos');
	
	    startItem++;
	    position=0;
	    if(startItem > itemCount) {
	      startItem = 1;
	    }
	  }
	}
	
	//다음 버튼
	$('#next').click(function() {
	  swap('clockwise');
	});
	
	//이전 버튼
	$('#prev').click(function() {
	  swap('counter-clockwise');
	});
	
	//다음 버튼을 클릭했을 때 다음 동영상이 없다면
	$('li').click(function() {
	  if($(this).attr('class') == 'items left-pos') {
	     swap('counter-clockwise'); 
	  }
	  else {
	    swap('clockwise'); 
	  }
	});

	
</script>

</html>