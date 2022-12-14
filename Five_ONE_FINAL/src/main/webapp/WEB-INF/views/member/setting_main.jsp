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
		height: 50px;
	}
	
	#info-navi-wrap {
		height: 50px;
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

	#info-protect-card, #info-premium-card {
		display: inline-block;
		border: 1px solid gray;
		border-radius: 10px;
		padding: 30px;
		width: 48%;
		text-align: left;
	}
	
	#info-protect-card {
		margin-right: 1%;
	}	
	
	#info-premium-card {
		margin-left: 1%;
	}	
	
	#info-profile-card, #info-channel-card {
		display: inline-block;
		border: 1px solid gray;
		border-radius: 10px;
		padding: 30px;
		width: 49%;
		margin-bottom: 1%;
	}

	#info-card-wrap-bottom {
		width: 50%;
		display: flex;
		margin-left: auto;
		margin-right: auto;
		justify-content: center;
	}
	
	#info-profile-card-content {
		text-align: left;
	}
	
	#info-profile-card-content-left, #info-profile-card-content-right {
		flex: 5;
	}
	
	#info-profile-card-title, #info-channel-card-title{
		display: flex;
		justify-content: space-between;
	}
	
	div.card-in-card{
		margin-top:10px;
		margin-bottom:10px;
		border-radius: 10px;
		border: 1px solid gray;
		padding: 10px;
	}
	
	#info-channel-card-content {
		text-align: left;
	}
	
	#info-profile-table {
		border-collapse: collapse;
		width: 100%;
	}
	
	#info-profile-table th{
		width: 15%;
	}
	#info-profile-table td{
		width: 35%;
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
							<li>프로필</li>
							<li>채널</li>
							<li>계정 보안</li> <!-- 이메일 로그인, 로그인 기록  -->
							<li>비디비디 프리미엄</liz>
						</ul>
					</div>
				</div>
				<div id="info-wrap-bottom">
					<div id="info-card-wrap">
						<div id="info-profile-card">
							<div id="info-profile-card-title">
								<span>프로필</span>
								<span>>>> 정보 수정</span>
							</div>
							<hr>
							<div id="info-profile-card-content">
								<table id="info-profile-table">
									<tr>
										<th>이름</th>
										<td>${MemberDTO.getMember_name() }</td>
										<th>이메일</th>
										<td>${MemberDTO.getMember_email() }</td>
									</tr>
									<tr>
										<th>생년월일</th>
										<td>${MemberDTO.getMember_birth() }</td>
										<th>전화번호</th>
										<td>${MemberDTO.getMember_phone() }</td>
									</tr>
									<tr>
										<th>나이</th>
										<td>알아서 계산</td>
										<th>주소</th>
										<td>${MemberDTO.getMember_addr() }</td>
									</tr>
									
								</table>
							</div>
						</div>
						<br>
						<div id="info-channel-card">
							<div id="info-channel-card-title">
								<span>채널</span>
								<span>>>> 채널 관리</span>
							</div>
							<hr>
							<div id="info-channel-card-content">
								<table>
									<tr>
										<td rowspan="4" style="width:20%;">
											<!-- 사용자가 프로필 사진 바꾸면 유동값으로 줘야함 -->
											<img src="<%=request.getContextPath() %>/resources/hochan_img/channelprofil.png" style="border-radius: 100%; width: 80%;">
										</td>
									</tr>
									<tr>
										<td>대표채널</td>
										<td colspan="3">채널 이름 가져오기~~~ </td>
									</tr>
									<tr>
										<td>구독자</td>
										<td>구독자 수 가져오기~~~ </td>
										<td>동영상</td>
										<td>동영상 수 가져오기~~~ </td>
									</tr>
									<tr>
										<td colspan="4">채널 설명 가져오기~~!</td>
									</tr>
								</table>
							</div>
							
						</div>
					<br>
						<div id="info-card-wrap-bottom">
							<div id="info-protect-card">
								<div id="info-protect-card-title">
									<span>계정 보안</span>
								</div>
								<hr>
								<div id="info-protect-card-content">
									<div class="card-in-card">
										<div><span>이메일 로그인 설정</span></div>
										<div style="display: flex; align-items: center;">
											<div>
											<img src="<%=request.getContextPath() %>/resources/img/protect.png" width="80px">
											</div>
											<div>
											<span>로그인 할 때마다 이메일 인증을 사용하여 계정 보안을 강화합니다.</span>
											</div>
										</div>
									</div>
									<div class="card-in-card">
										<div><span>로그인 기록</span></div>
										<div style="display: flex; align-items: center;">
										<div><img src="<%=request.getContextPath() %>/resources/img/login_history.png" width="80px"></div>
										<div><span>로그인 기록을 열람하고 관리합니다.</span></div>
										</div>
									</div>
								</div>
							</div>
							<div id="info-premium-card">
								<div id="info-premium-card-title">
									<span>비디비디 프리미엄</span>
								</div>
								<hr>						
								<div id="info-premium-card-content">
									<div class="card-in-card">
										<div><span>결제 관리</span></div>
										<div style="display: flex; align-items: center;">
											<div>
											<img src="<%=request.getContextPath() %>/resources/img/premium.png" width="80px">
											</div>
											<div>
											<span>비디비디 프리미엄을 결제하고 광고 없이 편안한 영상을 만나보세요.</span>
											</div>
										</div>
									</div>
									<div class="card-in-card">
										<div><span>결제 내역</span></div>
										<div style="display: flex; align-items: center;">
										<div><img src="<%=request.getContextPath() %>/resources/img/card_history.png" width="80px"></div>
										<div><span>결제 내역을 관리합니다.</span></div>
										</div>
									</div>
								</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>