<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
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
    
<title>Insert title here</title>

<style type="text/css">

	@media screen and (max-width: 1000px) {
		#user_div{
			display: none;
		}
		
		#search_div{
			width: 600px;
		}
	
	}
	
	
	@media screen and (min-width: 1001px) {
		#user_div{
			margin-top: 1%;
			flex: 1;
			color: white;
			float: right;
			font-size: 1.5rem;
			display: inline-flex;
			margin-right: 1%;
			vertical-align: middle;
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
	
	form{
		width: 100%;
		justify-content: center;
	}

	
	html, body {
		  margin: 0;
		  padding: 0;
	}
	
	#search_div{
		margin-top: 1%;
		margin-left: 15%;
		justify-content: center;
		display: inline-flex;
		align-items: center;
		vertical-align: middle;
		flex: 1;
	}
	
	#user_icon {
		font-size: 1.5em;
		color: #e78111;
	}
	

	#search_field{
		display: inline-flex;
		justify-content: center;
		align-items: center;
		margin: 0 auto;
		width: 50em;
		height: 3em;
		border-radius: 20px;
	}
	
	#search_btn{
		  color: white;
		  width: 40px;
		  height: 40px;
		  border-color: white;
		  border-radius: 50%;
		  background: #e78111;
		  align-items: center;
		  justify-content: center;
		  display: inline-flex;
		  margin: 0 auto;
		  font-size: 1.3rem;
	}
	
	#search_btn:hover {
		 background-color: white;
		 color: #e78111;
	}
	
	#user_login:hover {
		 background: white;
		 color: #e78111;
	}
	
	#user_join:hover {
		 background: white;
		 color: #e78111;
	}

	
	#user_login{
		border-radius: 15px;
		border-color: white;
		background-color: #e78111;
		color: white ;
		font-weight: bold;
		font-size: 1.3rem;
		display: inline-flex;
	}
	
	#user_join{
		border-radius: 15px;
		border-color: white;
		background-color: #e78111;
		color: white ;
		font-weight: bold;
		font-size: 1.3rem;
		display: inline-flex;
	}

	#user_popup{
		display: none;
		width: 150px;
		height: 260px;
		background-color:white;
		float: right;
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
		color: #5c3306;
	}

	#user_nickname{
		font-size: 2rem;
		color: #5c3306;
	}
	
</style>

</head>

<body>
		<div id="wrap">
			<form method="post" action="<%=request.getContextPath() %>/search.do">
		
			<div id="search_div">
				<input id="search_field" class="search_item" type="text" placeholder="  검색어를 입력하세요."> &nbsp;&nbsp;
				<button id="search_btn" class="search_item" type="submit"><i class="fas fa-search"></i></button>
			</div>
				
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
	
	
	</script>


</html>