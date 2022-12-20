<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script> 
<!-- member css -->
<link rel="stylesheet" href="${path}/resources/member/member_login.css">
<link rel="stylesheet" href="${path}/resources/member/member_cummon.css"> 
<!-- toast -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style type="text/css">

</style>
<script type="text/javascript">
	$(function(){
		
		$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type : "post"								
		});
		
		toastr.options = {
				  "closeButton": false,
				  "debug": false,
				  "newestOnTop": false,
				  "progressBar": false,
				  "positionClass": "toast-top-center",
				  "preventDuplicates": false,
				  "onclick": null,
				  "showDuration": "300",
				  "hideDuration": "1000",
				  "timeOut": "2000",
				  "extendedTimeOut": "2000",
				  "showEasing": "swing",
				  "hideEasing": "linear",
				  "showMethod": "fadeIn",
				  "hideMethod": "fadeOut"
				}
	});
	
	function loginCheck(){
		
		$.ajax({
			url : "<%=request.getContextPath()%>/loginOk.do",
			data : $('#login-form').serialize(),
			datatype : 'text',
			success : function(data){
				if (data == 'success'){
					$(location).attr('href', '<%=request.getContextPath()%>');
				}else if(data == 'fail'){
					toastr.error('아이디와 비밀번호를 확인하세요.','로그인 실패!');
				}
			},
			error : function(){
				toastr["error"]("데이터 통신 오류");
			}
		});
		
	}

</script>

</head>
<body>
	<div id="login-page-wrap">
		<jsp:include page="../include/top_include.jsp"/>
		
		<div id="login-wrap">
			<div id="login-side-bar">
				<jsp:include page="../include/side_include.jsp"></jsp:include>
			</div>
			<div id="login-wrap-top">
				<div id="login-logo">
					<span class="login-logo">로그인</span>
					<span class="login-logo txt">당신 근처의 비디오, 비디비디</span>
				</div>
			</div>
			<div id="login-wrap-bottom">
				<div id="login-component-left">
					<form method="post" action="<%=request.getContextPath()%>/loginOk.do" id="login-form">
						<input name="id" class="form-input id" placeholder="아이디">
						<input name="pwd" class="form-input password" placeholder="비밀번호">
						<!-- <input type="submit" value="로그인" class="form-btn"> -->
						<input type="button" value="로그인" class="form-btn" onclick="loginCheck()">
						<hr class="horizontal-hr">
						<div class="login-menu">
							<a href="<%=request.getContextPath()%>/find.do" class="form-a">
								<span class="form-text">로그인이 안되세요?</span> <span class="form-link">아이디/비밀번호 찾기</span>
							</a>
						</div>
					</form>
				</div>
				<hr class="vertical-hr">
				<div id="login-component-right">
					<input type="button" value="구글 로그인" class="form-btn">
					<input type="button" value="카카오 로그인" class="form-btn">
					<input type="button" value="네이버 로그인" class="form-btn">
					<hr class="horizontal-hr">
					<div class="login-menu">
							<a href="<%=request.getContextPath()%>/join.do" class="form-a">
								<span class="form-text">아직 회원이 아니세요?</span> <span class="form-link">회원가입</span>
							</a>
						</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>