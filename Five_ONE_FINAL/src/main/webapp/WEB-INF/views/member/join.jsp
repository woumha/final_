<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#join-wrap {
		display: flex;
	}
	
	#join-side-bar {
		flex: 1;
	}
	
	#join-content {
		flex: 9;
	}
</style>
</head>
<body>
	<div id="join-page-wrap">
		<jsp:include page="../include/top_include.jsp"/>
		<div id="join-wrap">
			<div id="join-side-bar">
				사이드바 공간
			</div>
			<div id="join-content">
				회원가입 내용~
			</div>
		</div>
	</div>
</body>
</html>