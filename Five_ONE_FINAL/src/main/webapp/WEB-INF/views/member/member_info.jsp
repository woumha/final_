<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="info-page-wrap">
		<jsp:include page="../include/top_include.jsp"/>
		
		<div id="info-wrap">
			<div id="info-side-bar">
				<jsp:include page="../include/side_include.jsp"></jsp:include>
			</div>
			<div id="info-wrap-top">
				<div id="info-logo">
					<span class="info-logo">${MemberName }님, 환영합니다.</span>
					<div id="info-nav">
						<ul>
							<li>내 프로필</li>
							<li>계정 보안 설정</li> <!-- 이메일 로그인, 로그인 기록  -->
							<li>결제 관리</li>
						</ul>
					</div>
				</div>
			</div>
			<div id="info-wrap-bottom">
				<div id="info-component-left">
					<form method="post" action="<%=request.getContextPath()%>/loginOk.do" id="login-form">
						
					</form>
				</div>
				<hr class="vertical-hr">
				<div id="info-component-right">
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>