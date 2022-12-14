<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<style type="text/css">

	/* 인풋태그 자동완성 배경색 없애기*/
	
	input:-webkit-autofill,
	input:-webkit-autofill:hover,
	input:-webkit-autofill:focus,
	input:-webkit-autofill:active {
		-webkit-text-fill-color: #000;
	    -webkit-box-shadow: 0 0 0px 1000px #fff inset;
	    box-shadow: 0 0 0px 1000px #fff inset;
	    transition: background-color 5000s ease-in-out 0s;
	}
	
	input:autofill,
	input:autofill:hover,
	input:autofill:focus,
	input:autofill:active {
		-webkit-text-fill-color: #000;
	    -webkit-box-shadow: 0 0 0px 1000px #fff inset;
	    box-shadow: 0 0 0px 1000px #fff inset;
	    transition: background-color 5000s ease-in-out 0s;
	}
	
	#info-wrap {
		display: flex;
	}
	
	#info-side-bar {
		flex: 1;
	}
	
	#info-content {
		flex: 9;
		display: flex;
		flex-direction: column;
	}
	
	#info-wrap-top {
		flex: 2;
		text-align: center;
	}
	
	#info-wrap-bottom {
		flex: 8;
	}
	
	#info-logo {
	}
	
	#info-navi-wrap {
	}
	
	ul.info-navi {
		list-style: none;
	    padding-left: 0;
	    display: flex;
	    justify-content: space-around;
	    width: 50%;
	    margin: auto;
	}
	
	ul.info-navi li {
		font-size: 1.3em;
		color: gray;
	}
	
	#info-wrap-bottom {
		text-align: center;
	}
	
	#info-profile-card {
		margin: 10px;
	}
	
	#info-protect-card, #info-premium-card {
		margin: 10px;
		display: inline-block;
	}
	
	


</style>
</head>
<body>
	<div id="info-page-wrap">
		<jsp:include page="../include/top_include.jsp"/>
		
		<div id="info-wrap">
			<div id="info-side-bar">
				<jsp:include page="../include/side_include.jsp"></jsp:include>
			</div>
			<div id="info-content">
				<div id="info-wrap-top">
					<div id="info-logo">
						<span class="info-logo">${MemberName }님, 환영합니다.</span>
					</div>
					<div id="info-navi-wrap">
						<ul class="info-navi">
							<li>내 프로필</li>
							<li>계정 보안</li> <!-- 이메일 로그인, 로그인 기록  -->
							<li>결제 관리</li>
						</ul>
					</div>
				</div>
				<div id="info-wrap-bottom">
					<div id="info-profile-card">
						프로필카드    >>> 수정하기
						<br>
						이름
						<br>
						이메일
						<br>
						연락처
						<br>
						주소
						<br>
						대표 채널 정보
						
					</div>
					<div id="info-protect-card">
						계정 보안    >>> 더 보기
						<br>
						이메일 로그인 설정
						<br>
						로그인 기록
					</div>
					<div id="info-premium-card">
						비디비디 프리미엄
						<br>						
						결제 관리   >>> 더 보기
						<br>
						결제 내역
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>