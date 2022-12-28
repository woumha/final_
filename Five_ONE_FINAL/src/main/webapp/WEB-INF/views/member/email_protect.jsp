<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<!-- bootstrap icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>  
<!-- member css -->
<link rel="stylesheet" href="${path}/resources/member/member_setting.css">
<link rel="stylesheet" href="${path}/resources/member/member_cummon.css">

<!-- toast -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- member js -->
<script src="${path}/resources/member/member_js.js"></script>
</head>
<body>
	<div id="protect-page-wrap">
		<jsp:include page="../include/top_include.jsp"/>
		<div id="protect-wrap">
			<div id="protect-side-bar">
				<jsp:include page="../include/side_include.jsp"></jsp:include>
			</div>
			<div id="protect-content">
				<div id="protect-wrap-top">
					<div id="protect-logo">
						<span>이메일 인증</span>
					</div>
				</div>
				<div id="protect-wrap-bottom">
					<div id="protect-card">
						<div class="input-wrap">
							<input name="authKey" class="member-input form-input" id="input-authKey" placeholder="인증번호">
						</div>
						<div class="input-wrap">
							<input type="button" value="로그인" class="form-btn" onclick="location.href='<%=request.getContextPath()%>/protect_login.do'">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>