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
<!-- bootstrap icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>  
<!-- member css -->
<link rel="stylesheet" href="${path}/resources/member/member_find.css">
<link rel="stylesheet" href="${path}/resources/member/member_setting.css">
<link rel="stylesheet" href="${path}/resources/member/member_cummon.css">

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

<!-- toast -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script type="text/javascript">
	$(function(){
		inputPlaceholder();
	});
	
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
	
	function replaceStar(value, number){
		
		let show = value.substring(0, (value.length - number));
		let star = "";
		for (i=1; i<=number; i++){
			star += "*";
		}
		
		return show+star;		
	}
	
	<!-- 아이디 찾기 -->
	function findIdwithEmail(){
		
		let input_email = $("#input-email").val();
		
		$.ajax({
			url : '<%=request.getContextPath()%>/find_id_ok.do',
			data : {
				email : input_email
			},
			success : function(data){
				console.log("data : "+data);
				
				$("#find-card").empty();
				$("#find-card").css("background-color", "rgb(245,245,245)");
				$("#find-card").css("border-radius", "10px");
				$("#find-card").css("display", "flex");
				$("#find-card").css("align-items", "center");
				$("#find-card").css("justify-content", "center");
				$("#find-card").html("<span class='find-txt'></span>");
				
				if (data == "undefined"){
					$("#find-card span").text("조회된 아이디가 없습니다.");
				}else if (data == "google"){
					$("#find-card span").text("구글로 가입된 아이디입니다.");
				}else if (data == "kakao"){
					$("#find-card span").text("카카오로 가입된 아이디입니다.");
				}else if (data == "naver"){
					$("#find-card span").text("네이버로 가입된 아이디입니다.");
				}else {
					$("#find-card span").text(replaceStar(data,4));
				}
			},
			error : function(){
				toastr.error('아이디 찾기 통신 오류');
			}
		});
	}
	

</script>
</head>
<body>
	<div id="find-page-wrap">
		<jsp:include page="../include/top_include.jsp"/>
		<div id="find-wrap">
			<div id="find-side-bar">
				<jsp:include page="../include/side_include.jsp"></jsp:include>
			</div>
			<div id="find-content">
				<div id="find-wrap-top">
					<div id="find-navi-wrap">
						<ul class="find-navi">
							<li onclick="location.href='#'" id="find-id" class="navi-this-page">아이디 찾기</li>
							<li onclick="location.href='<%=request.getContextPath() %>/find_pwd.do'" id="find-pwd" class="navi-not-page">비밀번호 찾기</li>
						</ul>
					</div>
				</div>
				<div id="find-wrap-bottom">
					<div id="find-card">
						<div class="input-wrap">
							<div class="label-input" >
								<label for="input-id" id="input-id-check"></label>
								<label for="input-id" id="input-id-label">이메일</label>
							</div>
								<input name="member_email" class="member-input form-input" id="input-email">
						</div>
						<div class="input-wrap">
							<input type="button" value="아이디 찾기" class="form-btn" onclick="findIdwithEmail()">
						</div>
					</div>
					<br>
					<div id="social-card">
					<hr class="vertical-hr">
						<span class="form-text">아이디/비밀번호 잊지말고 간편하게 <span class="small-title-span">소셜 로그인</span> 하세요!</span>
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
	</div>
</body>
</html>