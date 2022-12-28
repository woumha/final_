<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html id="html">
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<!-- 스타일 시트 -->
<link rel="stylesheet" href="${path }/resources/eunji_CSS/top.css">	

<style type="text/css">

#side_wrap{
	display: none;
}

#adv_box{
	display: none;
}

<%-- 이호찬 --%>
#user_popup {
	z-index: 1000;
}
</style>

<!-- 자동완성 기능 라이브러리 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<title>Insert title here</title>
<style type="text/css">

	img.channel-backcolor{
		border-radius: 100%;
	}

	#user_popup img.channel-backcolor{
		width: 22px;
	}
	
	#user_div img.channel-backcolor{
		width: 40px;
		height: 40px;
	}

</style>
<script type="text/javascript">

	$(function(){
		if ('${RepChannelCode}' != ''){
			let channelCode = '${RepChannelCode}';
			changeBackColor(channelCode);
		}
	});
</script>

</head>


<body id="body">

<%--  로딩화면  --%>
 <div id="loading">
	<div class="rabbit"></div>
		<div class="clouds"></div>
		<div class = "loading_logo">
		<img src="${pageContext.request.contextPath}/resources/img/vidividi_logo.png" width="230px" height="90px">
	</div>
</div>


<%--  전체 컨텐츠 화면  --%>
		 <div id="wrap">
		
			<img src="${pageContext.request.contextPath}/resources/img/vidividi_logo.png"  
				id="logo" width="230px" height="90px" onclick="location.href='<%= request.getContextPath() %>/'">
			
			<form method="post" action="<%=request.getContextPath() %>/search.do" id="search_go">
						
			<div id="search_div">
			
			<div class="search_select">
			  <select name="field">			    
			    <c:set var = "tag" value = "${field }" />
					<option value="video_title"
						<c:if test="${tag == 'video_title'}">selected</c:if>>동영상 제목</option>
					
					<option value="video_cont"
						<c:if test="${tag == 'video_cont'}">selected</c:if>>동영상 내용</option>	
						
					<option value="channel_name"
						<c:if test="${tag == 'channel_name'}">selected</c:if>>채널명</option>
									
			  </select>
			</div>
			
			<c:if test="${empty keyword }">
				<input id="search_input" class="search_input" name="auto_search" type="text" placeholder="검색어를 입력하세요." required> &nbsp;&nbsp;
			</c:if>
			
			<c:if test="${! empty keyword }">
				<input id="search_input" class="search_input" name="auto_search" type="text" placeholder="${keyword }" required> &nbsp;&nbsp;
			</c:if>
			
				<button id="search_btn" type="submit"><i class="fas fa-search"></i></button>	
				
				<div class = "rel_search">
					<ul class="pop_rel_keywords" id="pop_rel_keywords"> </ul>
			    </div>		
			    	
			</div> 
			</form>	
				
			<div id="user_div">
				<c:if test="${!empty MemberCode }">
					<button class="customm-btn" id="user_logout" onclick="location.href='<%=request.getContextPath() %>/logout.do'" value="Login">Logout</button>&nbsp;&nbsp;
				</c:if>
				
				<c:if test="${!empty MemberCode }">
					<c:if test="${RepChannelPsa == default_channel_profile.png}">
						<img id="user_icon" src="<%=request.getContextPath()%>/resources/img/channel_profile/default_channel_profile.png" class="channel-backcolor">
					</c:if>
					<c:if test="${RepChannelPsa != default_channel_profile.png}">
						<img id="user_icon" src="<%=request.getContextPath()%>/resources/img/channel_profile/${RepChannelPsa }" class="channel-backcolor">
					</c:if>
				</c:if>
				
				<c:if test="${empty MemberCode }">
					<button class="customm-btn" id="user_login" onclick="location.href='<%=request.getContextPath() %>/login.do'" value="Login">Login</button>&nbsp;&nbsp;
				</c:if>
				<c:if test="${empty MemberCode }">
					<button class="customm-btn" id="user_join" onclick="location.href='<%=request.getContextPath() %>/join.do'">Join</button>&nbsp;&nbsp;
				</c:if>
				
			</div>
			
			</div>
			
		
		<c:if test="${!empty MemberCode }">
			<div id="user_popup"> 
				<ul id="user_list">
					<li id="userpop_title"><b>
						<img id="userpop_img" src="${pageContext.request.contextPath}/resources/img/default_channel_profile.png" width="45px" height="45px">
						${MemberName }&nbsp;님</b>
					</li>
					<hr>
					<%-- 내 채널 이미지 //이호찬 --%>
          <c:set var="ccode" value="${RepChannelCode }" />
					<li id="userpop_mychannel" onclick="location.href='<%=request.getContextPath() %>/channel.do?mc=${ccode }'">
					
					<i class="fa-regular fa-circle-user"></i>&nbsp;&nbsp;마이 채널</li>
					
					<li id="userpop_mypage" onclick="location.href='<%=request.getContextPath()%>/myPage_go.do?channel_code=${RepChannelCode}'"> <i class="fa-solid fa-circle-user"></i>&nbsp;&nbsp;마이 페이지</li>
					
					<li id="userpop_box" onclick="location.href='<%=request.getContextPath()%>/myPage_go.do?channel_code=${RepChannelCode}'"><i class="fa-regular fa-square-check"></i>&nbsp;&nbsp;보관함</li>
					<hr>
					<li id="userpop_setting" onclick="location.href='<%=request.getContextPath()%>/setting.do'"><i class="fa-solid fa-gear"></i>&nbsp;&nbsp;계정 설정</li>
					<li id="userpop_logout" onclick="location.href='<%=request.getContextPath()%>/logout.do'"><i class="fa-solid fa-arrow-right-from-bracket"></i>&nbsp;&nbsp;로그아웃</li>		
				</ul>
			</div>
		</c:if>

</body>


<script type="text/javascript">		

//로딩 완료 시 로딩 관련 div 사라지게 하기 / 사이드바 + 광고 나타나게 하기
$(window).on('load', function () {
	$("#loading").fadeOut();
	$("#side_wrap").css("display", "block");
	$("#adv_box").css("display", "block");
}); 

//------------------------------------------------------마이페이지 팝업--------------------------------------------------
	
//마이페이지 팝업
	$(document).ready(function(){
		$("#user_icon").click(function(){
			if($("#user_popup").is(":visible")){
			$("#user_popup").css("display", "none");
					
			}else {
				$("#user_popup").css("display", "block");	
			}
				
			var offset = $("#user_popup").offset();
	         $("html, body").animate({scrollTop: offset.top}, 300);
		});	
	});
	
	
//------------------------------------------------------------------아마존 api 이용 자동완성----------------------------------------------
	
	const ul = document.querySelector(".pop_rel_keywords");
	const searchInput = document.querySelector("#search_input");
	const relContainer = document.querySelector(".rel_search");
	let cache = '';

	
	const checkInput = () => {
	    const beforeInput = searchInput.value;
	    timer(beforeInput);
	}
	
	
	const timer = (beforeInput) => {
	  setTimeout(() => {
	
	    if(searchInput.value === beforeInput) {
	      loadData(searchInput.value);
	      checkInput();
	      
	    } else {
	      checkInput();
	    }
	   
	    if(searchInput.value === "") {
	      relContainer.classList.add("hide");
	    } else {
	      relContainer.classList.remove("hide");
	    }
	  }, 100);
	}
  

	const loadData = (input) => {
	  const url = `https://completion.amazon.com/api/2017/suggestions?session-id=135-3077052-6015425&customer-id=&request-id=DMRETXPQ3PZJQ5TKYSWX&page-type=Gateway&lop=en_US&site-variant=desktop&client-info=amazon-search-ui&mid=ATVPDKIKX0DER&alias=aps&b2b=0&fresh=0&ks=undefined&prefix=`+input+`&event=onFocusWithSearchTerm&limit=11&fb=1&suggestion-type=KEYWORD&suggestion-type=WIDGET&_=1615280967091`;
	  console.log(input);
	  if(cache === url) return;
		else {
			cache = url
			fetch(url)
			.then((res) => res.json())
			.then(res => fillSearch(res.suggestions))
		}
	}
			
	const fillSearch = (suggestArr) => {
		ul.innerHTML = "";
		suggestArr.forEach((el, idx) => {
		const li = document.createElement("li");
		li.innerHTML = el.value;
		li.classList = "autoList";
		console.log(el.value);
		ul.appendChild(li);
	})  
		const liList = document.querySelectorAll(".pop_rel_keywords li");	  
	}	
		const highlightText = () => {
	}
			
		checkInput();
		

//-------------------------------------------------------------자동완성 클릭 + 방향키 이동----------------------------------------------
//자동완성 클릭 + input에 클릭 값 넣기
	$(document).on("click", ".autoList", function(){		
		$(this).css('background-color', '#facc9d');
		$(".autoList").not(this).css('background-color', 'white');
		$(".search_input").val(($(this).text())); 
			   
	});  	
	
	// autoList에서 search_input 노드...
	//this.parentElement.parentElement.parentElement.firstElementChild.nextElementSibling
	
	var ul2 = document.getElementById('pop_rel_keywords');
	var liSelected;
	var index = -1;
	
	document.addEventListener('keydown', function(event) {
	  var len = ul2.getElementsByTagName('li').length - 1;
	  if (event.which === 40) {
	    index++;
	    //down 
	    if (liSelected) {
	      removeClass(liSelected, 'selected');
	      next = ul2.getElementsByTagName('li')[index];
	      if (typeof next !== undefined && index <= len) {
	
	        liSelected = next;
	      } else {
	        index = 0;
	        liSelected = ul2.getElementsByTagName('li')[0];
	      }
	      addClass(liSelected, 'selected');
	      $(".search_input").val(($('.selected').text())); 
	      
	    } else {
	      index = 0;
	
	      liSelected = ul2.getElementsByTagName('li')[0];
	      addClass(liSelected, 'selected');
	    }
	  } else if (event.which === 38) {
	
	    //up
	    if (liSelected) {
	      removeClass(liSelected, 'selected');
	      index--;
	      $(".search_input").val(($('.selected').text())); 
	      
	      next = ul2.getElementsByTagName('li')[index];
	      if (typeof next !== undefined && index >= 0) {
	        liSelected = next;
	      } else {
	        index = len;
	        liSelected = ul2.getElementsByTagName('li')[len];
	      }
	      addClass(liSelected, 'selected');
	    } else {
	      index = 0;
	      liSelected = ul2.getElementsByTagName('li')[len];
	      addClass(liSelected, 'selected');
	    }
	  }
	}, false);
	
	function removeClass(el, className) {
	  if (el.classList) {
	    el.classList.remove(className);
	  } else {
	    el.className = el.className.replace(new RegExp('(^|\\b)' + className.split(' ').join('|') + '(\\b|$)', 'gi'), ' ');
	  }
	};
	
	function addClass(el, className) {
	  if (el.classList) {
	    el.classList.add(className);
	  } else {
	    el.className += ' ' + className;
	  }
	};
	
	
</script>
<!-- member js -->
<script src="${path}/resources/member/member_js.js"></script>
</html>