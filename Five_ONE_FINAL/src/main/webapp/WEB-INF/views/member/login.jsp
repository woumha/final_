<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Google -->
<meta name ="google-signin-client_id" content="279446786317-1d8b3dusm3g9oc69uvskvd84p04eira1.apps.googleusercontent.com">
<title>Insert title here</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script> 
<!-- member css -->
<link rel="stylesheet" href="${path}/resources/member/member_login.css">
<link rel="stylesheet" href="${path}/resources/member/member_cummon.css"> 

<!-- toast -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- bootstrap icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

<!-- Google signin api -->
<script src="https://accounts.google.com/gsi/client" async defer></script>

<!-- KaKao -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
  integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous"></script>
<script type="text/javascript">
	Kakao.init('f76456adebea52ab2b1a18207c100a25');
</script>

<!-- Naver -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<!-- member js -->
<script type="text/javascript" src="${path}/resources/member/member_js.js"></script>

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
		
		
		inputPlaceholder();
		pwdShow();
				
	});

	
	
	<!-- 로그인 보호 사용중인지 아닌지 체크하여 로그인하는 함수-->
	function loginCheck(){
		
		$.ajax({
			url : "<%=request.getContextPath()%>/loginOk.do",
			data : $('#login-form').serialize(),
			datatype : 'text',
			success : function(data){
				
				console.log("data : "+data);
				
				if (data == 'success'){
					$(location).attr('href', '<%=request.getContextPath()%>');
				}else if(data == 'fail'){
					toastr.error('아이디와 비밀번호를 확인하세요.','로그인 실패!');
				}else if(data == 'expired'){
					toastr.error('탈퇴한 회원입니다.');
				}else{
					$("#email-auth-span").text("이메일 전송중");
					modalShow();
					protectLogin(data);
				}
			},
			error : function(){
				toastr["error"]("데이터 통신 오류");
			}
		});
		
	}
	
	<!-- 보호 사용중인 계정 로그인하는 함수 -->
	function authLogin(){

		$.ajax({
			url : "<%=request.getContextPath()%>/protect_login_ok.do",
			data : $('#login-form').serialize(),
			datatype : 'text',
			success : function(data){
				
				if (data == 'success'){
					$(location).attr('href', '<%=request.getContextPath()%>');
				}else if(data == 'fail'){
					toastr.error('아이디와 비밀번호를 확인하세요.','로그인 실패!');
				}else if(data == 'expired'){
					toastr.error('탈퇴한 회원입니다.');
				}
			},
			error : function(){
				toastr["error"]("데이터 통신 오류");
			}
		});
		
	}
	
	<!-- 인증번호 확인하는 함수 -->
	function protectLogin(key){
		
		authtimer();
		setTimeout(function(){
			clearInterval(CountDown);
			key == "";
			$("#email-auth-span").text("인증 번호 만료");
			toastr.warning("인증 시간이 초과되었습니다.");
		}, 180000);
		
		$("#protect-login-btn").on('click', function(){
			if ($("#input-authKey").val() == key){
				authLogin();
			}else {
				toastr.error('인증번호를 확인하세요.');
			}
		});
		
		$("#protect-cancle-btn").on('click', function(){
			modalHide();
			clearInterval(CountDown);
			key == "";
			$("#email-auth-span").text("");
			toastr.warning("로그인이 취소되었습니다.");
		});
	}
	
<!-- 구글 로그인 -->

	function getGoogleData(response){
	 	console.log("Encoded JWT ID token: " + response.credential);
	 	
	 	$.ajax({
	 		url : '<%=request.getContextPath()%>/google_login.do',
			data: {
				jwt : response.credential
			},
			success : function(data){
				if (data == "joined" || data == "linked"){
					toastr.success("로그인 성공");
					$(location).attr("href", "<%=request.getContextPath()%>");
				}else if (data == "notlinked"){
					toastr.success('기존 아이디가 구글과 연동되었습니다.');
					$(location).attr("href", "<%=request.getContextPath()%>");
				}else if(data == 'expired'){
					toastr.error('탈퇴한 회원입니다.');
				}
			},
			error: function(){
				toastr.error("구글 로그인 데이터 통신 오류");
			}
	 		
	 		
	 	});
	}
	

	
	<!-- 카카오 로그인 -->
	function loginWithKakao() {
	 console.log('loginWithKakao() 호출됨');
	 Kakao.Auth.authorize({
	    redirectUri: 'http://localhost:8282/one/kakao_login.do',
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
						<div class="input-wrap">
							<div class="label-input" >
								<label for="input-id" id="input-id-check"></label>
								<label for="input-id" id="input-id-label">아이디</label>
								</div>
								<input name="id" class="member-input form-input" id="input-id">
							</div>
							<div class="input-wrap">
								<div class="label-input" >
									<label for="input-id" class="label-input" id="input-pwd-check"></label>
									<label for="input-id" class="label-input" id="input-pwd-label">비밀번호</label>
								</div>
								<div class="pwd-wrap">
									<input name="pwd" class="password member-input form-input essential member-pwd-input" id="input-pwd" autocomplete="off">
									<div class="pwd-eye showEye">
										<i class="bi bi-eye-fill"></i>
									</div>
								</div>
							</div>
						<input type="button" value="로그인" class="form-btn" onclick="loginCheck()">
						<hr class="horizontal-hr">
						<div class="login-menu">
							<a href="<%=request.getContextPath()%>/find_id.do" class="form-a">
								<span class="form-text">로그인이 안되세요?<span class="form-link"> 아이디/비밀번호 찾기</span></span> 
							</a>
						</div>
					</form>
				</div>
				<hr class="vertical-hr">
				<div id="login-component-right">
					<span id="social-title">소셜 로그인</span>
					<hr class="horizontal-hr">
					<div id="login-icon-wrap">
					<div id="google-wrap">
						<div id="g_id_onload"
				         data-client_id="279446786317-1d8b3dusm3g9oc69uvskvd84p04eira1.apps.googleusercontent.com"
				         data-callback="getGoogleData"
				         data-auto_prompt="false"
				         data-auto_select="false"
				         data-context="signin">
				      </div>
				      <div class="g_id_signin"
				         data-type="icon"
				         data-size="large"
				         data-theme="outline"
				         data-text="sign_in_with"
				         data-shape="circle"
				         data-logo_alignment="center"
				         >
				      </div>
					</div>
				    
					<div id="kakao-wrap">
						<a id="kakao-login-btn" href="javascript:loginWithKakao()">
						  <img src="<%=request.getContextPath() %>/resources/img/kakao_login_circle.png" alt="카카오 로그인 버튼" width="40px"/>
						</a>
					</div>
					<div id="naver-wrap">
						<a id="naver-login-btn" href="${NaverLoginUrl }">
						  <img src="<%=request.getContextPath() %>/resources/img/naver_login_circle.png" alt="네이버 로그인 버튼" width="40px"/>
						</a>
					</div>
					</div>
					<hr class="horizontal-hr">
					<div class="login-menu">
							<a href="<%=request.getContextPath()%>/join.do" class="form-a">
								<span class="form-text">아직 회원이 아니세요?<span class="form-link"> 회원가입</span></span> 
							</a>
						</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 로그인 이메일 인증 모달 -->
		<div class="member-modal">
		<div class="member-modal-body">
			<div class="member-modal-title member-alert">
				<span>로그인 보호</span>
			</div>
			<hr>
			<div class="member-modal-content member-alert">
				<span>이메일로 발송된 인증번호를 입력하세요.</span>
				<div class="input-wrap" style="color:gray;">
					<span id="email-auth-span"></span>
				</div>
				<div class="input-wrap">
					<input id="input-authKey" class="member-input form-input">
				</div>
				<br>
				<input type="button" value="로그인" class="member-emp" id="protect-login-btn">
				<input type="button" value="취소" id="protect-cancle-btn">
			</div>
		</div>
	</div>
</body>
</html>