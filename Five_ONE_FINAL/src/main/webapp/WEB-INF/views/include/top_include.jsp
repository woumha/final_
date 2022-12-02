<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" 
			integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" 
			crossorigin="anonymous" 
			referrerpolicy="no-referrer" />
    
<title>Insert title here</title>

<style type="text/css">

	@media screen and (max-width: 700px) {
		#user_div{
			display: none;
		}
	}
	
	#wrap{
		height: 80px;
		width: 100%;
		background-color: #e78111;
		margin: 0px;
		padding-bottom: 0px;
		display: flex;
	}
	
	form{
		width: 100%;
		justify-content: center;
	}

	
	html, body {
		  margin: 0;
		  padding: 0;
		  text-align: center;
	}
	
	#search_div{
		margin-top: 1%;
		margin-left: 15%;
		justify-content: center;
		display: inline-flex;
		flex: 1;
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
		 background: #2d2d2d;
	}
	
	#user_login:hover {
		 background: #2d2d2d;
		 color: white;
	}
	
	#user_join:hover {
		 background: #2d2d2d;
		 color: white;
	}


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
	
	#user_login{
		border-radius: 15px;
		border-color: white;
		background-color: white;
		color:  #e78111;
		font-weight: bold;
		font-size: 1.3rem;
		display: inline-flex;
	}
	
	#user_join{
		border-radius: 15px;
		border-color: white;
		background-color: white;
		color:  #e78111;
		font-weight: bold;
		font-size: 1.3rem;
		display: inline-flex;
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
				<input type="button"id="user_login" onclick="location.href='로그인 이동'" value="Login"> &nbsp;&nbsp;
				<input type="button" id="user_join" onclick="location.href='회원가입 이동'" value="Join"> &nbsp; &nbsp;
				<i class="fa-solid fa-user" onclick="location.href='유저 개인 페이지'"></i>
			</div>	
	
			</form>
			
		</div>

</body>
</html>