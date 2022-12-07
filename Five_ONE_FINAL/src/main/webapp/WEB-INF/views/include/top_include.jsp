<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html id="html">
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>  

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" 
			integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" 
			crossorigin="anonymous" 
			referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>


<!-- 자동완성 기능 라이브러리 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>Insert title here</title>

<style type="text/css">

	@media screen and (max-width: 1500px) {
		#user_div{
			display: none;
		}
		
		#search_div{
			width: 600px;
		}
	
	}
	
	
	@media screen and (min-width: 1501px) {
		#user_div{
			margin-top: 22px;
			flex: 1;
			height: 60px;
			color: white;
			position: absolute;
			right: 1px;
			font-size: 1.5rem;
			display: inline-flex;
			margin-right: 1%;
			vertical-align: bottom;
			text-align: center;
		}
	}
	
	
	#wrap{
		height: 80px;
		width: 100%;
		background-color: white;
		margin: 0px;
		padding-bottom: 0px;
		display: flex;
		text-align: center;
	}
	
	#search_go {
		width: 100%;
		justify-content: center;
		margin-top: 11px;
	}

	#search_input:focus {
   		 outline: none;
	}
	
	#html, #body {
		  margin: 0;
		  padding: 0;
	}
	
	#wrap{
		height: 80px;
	}
	
	#search_div{
		margin-top: 1%;
		justify-content: center;
		display: inline-flex;
		align-items: center;
		vertical-align: middle;
		flex: 1;
	}
	
	#user_icon {
		font-size: 1.6em;
		color: #fc942c;
		position: relative;
	}
	

	#search_input{
		display: inline-flex;
		justify-content: center;
		align-items: center;
		margin: 0 auto;
		width: 50em;
		height: 3em;
		border-radius: 5px 0 0 5px;
		border: 3px solid #fc942c;
 		padding: 10px;
 		box-shadow: 3px 3px 3px 2px rgba(0, 0, 0, 0.3);
	}
	
	#search_btn{
		  color: white;
		  width: 40px;
		  height: 40px;
		  border-color: white;
		  border-radius: 50%;
		  background: #fc942c;
		  align-items: center;
		  justify-content: center;
		  display: inline-flex;
		  margin: 0 auto;
		  font-size: 1.3rem;
	}
	
	#search_input:hover {
		 background-color: #e1eff7;
		 color: #fc942c;
	}
	
	#search_btn:hover {
		 background-color: white;
		 color: #fc942c;
	}
	
	
	/* ----------------------------------------user_login  css-------------------------- */
	
	 .customm-btn {
	  width: 200px;
	  height: 40px;
	  color: #fff;
	  border-radius: 5px;
	  font-family: 'Lato', sans-serif;
	  background: transparent;
	  cursor: pointer;
	  transition: all 0.3s ease;
	  position: relative;
	  display: inline-block;
	  box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
	   7px 7px 20px 0px rgba(0,0,0,.1),
	   4px 4px 5px 0px rgba(0,0,0,.1);
	  outline: none;
	}
   
	 #user_login {
	  background: #333333;
	  border: none;
	  z-index: 3;
	  width: 100px;
	}
	
  	#user_login:after {
	  position: absolute;
	  content: "";
	  width: 0;
	  height: 100%;
	  top: 0;
	  right: 0;
	  z-index: -1;
	  background-color: #fc942c;
	  border-radius: 5px;
	   box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
	   7px 7px 20px 0px rgba(0,0,0,.1),
	   4px 4px 5px 0px rgba(0,0,0,.1);
	  transition: all 0.3s ease;
	} 
	 
	#user_login:hover {
	  background-color: #fc942c;
	}
 	#user_login:hover:after {
	  left: 0;
	  width: 100%;
	}
	#user_login:active {
	  top: 2px;
	} 
	
	
	
	/* ----------------------------------------user_join css---------------------------  */
	
	 #user_join {
	  background: #333333;
	  border: none;
	  z-index: 3;
	  width: 100px;
	}
	
 	#user_join:after {
	  position: absolute;
	  content: "";
	  width: 0;
	  height: 100%;
	  top: 0;
	  right: 0;
	  z-index: -1;
	  background-color: #fc942c;
	  border-radius: 5px;
	   box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
	   7px 7px 20px 0px rgba(0,0,0,.1),
	   4px 4px 5px 0px rgba(0,0,0,.1);
	  transition: all 0.3s ease;
	} 
	
	#user_join:hover {
	  background-color: #fc942c;
	}
	#user_join:hover:after {
	  left: 0;
	  width: 100%;
	}
	#user_join:active {
	  top: 2px;
	}


	/*----------------------------------------user_popup css---------------------------  */
	#user_popup{
		position: absolute;
		display: none;
		width: 230px;
		height: 300px;
		background-color:white;
		right: 1px;
		top: 80px;
		border-color: lightgray;
		border-radius: 15px;
		border: 1px solid;
		text-align: left;
		
	}
	
	#user_popup ul{
		padding-bottom: 5px;
	}
	
	
	
	#user_popup ul li{
		font-size: 1rem;
		padding-left: 10px;
		color: #33333;
		margin: 5px;
	}

	#user_nickname{
		margin-top: 10px;
		font-size: 2rem;
		color: #33333;
	}
	
	#user_div b{
		margin-top: 15px;
	}
	
	
	/* ------------------------------------------------자동완성창 css--------------------------------------- */
	 .hide {
		  display: none !important;
		} 
		
		.rel_search {
		  position: fixed; 
		  flex-direction:column; 
		  z-index: 10000; 
		  justify-content : space-around;
		  border: 1px solid #e4e7e8;
		  border-radius: 0 0 6px 6px;
		  width: 50em;
		  text-align: left;
		  margin-left: 22.2%;
		  line-height: 1.8rem;
		  background-color: #fff;
		  border-top: 0;
		  box-shadow: 0 2px 3px 0;
		}	
		
		.pop_rel_keywords {
		  list-style: none;
		  margin-right: 30%;
		
		}
		
		.pop_rel_keywords > li {
		  line-height : 250%
		}
			
	
</style>

</head>

<body id="body">

		 <div id="wrap">
		
			<img src="${pageContext.request.contextPath}/resources/img/vidividi_logo.png" 
				width="230px" height="90px" onclick="location.href='<%= request.getContextPath() %>/'">
			
			<form method="post" action="<%=request.getContextPath() %>/search.do" id="search_go">
			<div id="search_div">
				<input id="search_input" class="search_item" type="text" placeholder="검색어를 입력하세요."> &nbsp;&nbsp;
				<button id="search_btn" class="search_item" type="submit"><i class="fas fa-search"></i></button>				
				
			<div id="user_div">

				<c:if test="${!empty MemberCode }">
					<input type="button" id="user_login" onclick="location.href='<%=request.getContextPath() %>/logout.do'" value="Logout"> &nbsp;&nbsp;
				</c:if>
				<c:if test="${empty MemberCode }">
					<input type="button" id="user_login" onclick="location.href='<%=request.getContextPath() %>/login.do'" value="Login"> &nbsp;&nbsp;
				</c:if>
				<c:if test="${empty MemberCode }">
					<input type="button" id="user_join" onclick="location.href='<%=request.getContextPath() %>/join.do'" value="Join"> &nbsp; &nbsp;
				</c:if>
				<i class="fa-solid fa-circle-user" id="user_icon"></i>
			</div>
			
			</div>
				<div class = "rel_search">
					<ul class="pop_rel_keywords"> </ul>
			</div>
				
			</form>
		</div> 
	
		<c:if test="${!empty MemberCode }">
			<div id="user_popup"> 
				<ul id="user_list">
					<li> &nbsp;&nbsp;</li>
					<li><b><i class="fa-solid fa-circle-user" id="user_nickname"></i> ${MemberNick }님</b></li>
					<li> &nbsp;&nbsp;</li>
					<li> &nbsp;<i class="fa-solid fa-circle-user"></i>&nbsp;&nbsp;마이 페이지</li>
					<li> &nbsp;<i class="fa-regular fa-square-check"></i>&nbsp;&nbsp;보관함</li>
					<hr>
					<li>&nbsp;<i class="fa-solid fa-gear"></i>&nbsp;&nbsp;설정</li>
					<li>&nbsp;<i class="fa-solid fa-arrow-right-from-bracket"></i>&nbsp;&nbsp;<a href="location.href='<%=request.getContextPath() %>/logout.do'">로그아웃</a></li>		
				</ul>
			</div>
		</c:if>
		<c:if test="${empty MemberCode }">
			<div id="user_popup">
				<ul id="user_list">
					<li><a href="location.href='<%=request.getContextPath() %>/login.do'">로그인이 필요합니다.</a></li>
				</ul>
			</div>
		</c:if>

</body>

	<script type="text/javascript">
	
		//방향키 이동
		
 
	//-------------------------------------------------------------------------------
	
		//마이페이지 팝업
		$(document).ready(function(){
			$("#user_icon").click(function(){
				if($("#user_popup").is(":visible")){
					$("#user_popup").css("display", "none");
					
				}else {
					$("#user_popup").css("display", "block");	
				}
				
				var offset = $("#user_popup").offset();
	            $("html, body").animate({scrollTop: offset.top}, 100);
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
	      console.log("입력멈춤");
	      loadData(searchInput.value);
	      checkInput();
	      
	    } else {
	      console.log("입력변함");
	      checkInput();
	    }
	   
	    if(searchInput.value === "") {
	      relContainer.classList.add("hide");
	    } else {
	      relContainer.classList.remove("hide");
	    }
	  }, 500);
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
			    li.className = "autoList";
			    console.log(el.value);
			    ul.appendChild(li);
			  }) 
			    
			   const liList = document.querySelectorAll(".pop_rel_keywords li");
				
			  
			}
			
			const highlightText = () => {
			
			
			}
			
		checkInput();
  
	
	</script>


</html>