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
<!-- member css -->
<link rel="stylesheet" href="${path}/resources/member/member_setting.css">
<link rel="stylesheet" href="${path}/resources/member/member_cummon.css">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>  
<!-- member js -->
<script src="${path}/resources/member/member_js.js"></script>
<!-- toast -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script type="text/javascript">

function numberPad(n, width) {
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

function authtimer() {
	
	let time = 180000;
	let min = 3;
	let sec = 60;
	
	$("#email-auth-span").text(min+":"+'00');
	
	CountDown = setInterval(function(){
					time = time-1000;
					min = time/(60*1000);
					
					if(sec > 0){
						sec = sec-1;
						$("#email-auth-span").text(Math.floor(min)+ ':' + numberPad(sec, 2));
					}
					if (sec == 0){
						sec = 60;
						$("#email-auth-span").text(Math.floor(min)+ ':' +'00');
					}
				},1000);
	
}


function changeAuthStatus(email){
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	});
	
	$.ajax({
		url : '<%=request.getContextPath()%>/changeAuthStatus.do',
		data: {
			member_email : email,
			member_code : "${MemberDTO.getMember_code()}"
		},
		success : function(data){
			if(data=="success"){
				toastr.success("이메일이 인증되었습니다.");
				
				$("#input-email").attr("disabled", false);
				$("#input-email").removeClass("disabled");
				$("#email-auth-input").attr("disabled", false);
				$("#email-auth-request-btn").attr("disabled", false);
				
				$("#email-auth-complete").css("display", "block");
				$("#email-auth-complete").siblings().css("display", "none");
				
			}else if(data == "fail"){
				toastr.error("로그인 상태를 확인하세요.","이메일 인증 실패!");
			}
		},
		error : function(){
			toastr.error("인증상태 변경 통신 오류");
		}
		
	});
	
}


function authEmail(email){
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	});
	
	$.ajax({
		url : '<%=request.getContextPath()%>/sendEmail.do',
		data: { 
			member_email : email, 
			member_code : "${MemberDTO.getMember_code()}"
		},
		success : function(data) {
			if (data != "fail"){ 
				toastr.success("이메일이 전송되었습니다.");
				$("#input-email").attr("disabled", true);
				$("#input-email").addClass("disabled");
				
				authtimer();
				setTimeout(function(){
					clearInterval(CountDown);
					data == "";
					toastr.warning("다시 시도하세요.","인증 시간이 초과되었습니다.");
					$("#input-email").attr("disabled", false);
					$("#input-email").removeClass("disabled");
					$("#email-auth-input").attr("disabled", false);
					$("#email-auth-request-btn").attr("disabled", false);
					$("#email-auth-request-btn").css("display", "block");
					$("#email-auth-request-btn").siblings().css("display", "none");
				}, 180000);
				
				$("#email-auth-confirm-btn").on("click", function(){
					if ($("#email-auth-input").val() == data) {
						clearInterval(CountDown);
						changeAuthStatus(email);
						
					}else{
						toastr.error("인증번호가 틀렸습니다.");
					} 
					
				});
				
			}else if(data == "fail"){
				toastr.success("이메일을 확인하세요.","이메일 전송 실패");
				$("#email-auth-request-btn").attr("disabled", false);
				$("#email-auth-request-btn").css("display", "block");
				$("#email-auth-request-btn").siblings().css("display", "none");
			}else if(data == "already"){
				toastr.warning("다른 이메일을 입력해주세요.","이미 인증된 이메일입니다.");
				
			}
		},
		error : function(){
			toastr.error('잠시 후 다시 시도하세요.','이메일 전송 오류');
			$("#email-auth-request-btn").attr("disabled", false);
			$("#email-auth-request-btn").css("display", "block");
			$("#email-auth-request-btn").siblings().css("display", "none");
		}
		
	});
	
}



$(function(){
	
	if ('${MemberDTO.getMember_code()}' != ''){
		let channelCode = '${MemberDTO.getMember_rep_channel()}';
		changeBackColor(channelCode);
	}
	
	if ('${MemberDTO.getMember_email()}' != ''){
		if('${MemberDTO.getMember_email_auth()}' == 1){
			$("#email-auth-complete").css("display", "block");
			$("#email-auth-complete").siblings().css("display", "none");
		}
	}
	
	$("body").css("position","fixed");
	inputPlaceholder();
	$("body").css("position","");
	noCalHolder(); 
	naviCSS();
	
	$("#profile-submit-btn").attr("disabled", true);
	
	$("#email-auth-request-btn").on("click", function(){
		authEmail($("#input-email").val());
		$("#email-auth-span").css("color", "red");
		$(this).css("display", "none");
		$(this).siblings().css("display", "block");
		$("#email-auth-complete").css("display","none");
		$(this).attr("disabled", true);
		
	});
	
	
	$("#input-email").on('keyup', function(){
		
		let keyupTimeout;
		clearTimeout(keyupTimeout);
		keyupTimeout = setTimeout(function(){
			
			if ($("#input-email").val() != "${MemberDTO.getMember_email()}"){
				$("#email-auth-request-btn").css("display", "block");
				$("#email-auth-request-btn").siblings().css("display", "none");
			}
		
		}, 1000);
		
	});

	
});



</script>
<style type="text/css">

	#profile-input {
		width: 48%;
		margin: auto;	
	}
	
	input#input-email{
		margin: 0px;
	}
	
	div#email-input-wrap{
		margin-top: 10px;
		margin-bottom: 10px;
		display: flex;
		align-items: center;
	}
	
	div#email-input {
		flex:7;
	}
	
	div#email-auth-btn {
		flex:3;
		padding-left: 10px;
		display: flex;
		position: relative;
	}
	
	#email-auth-request-btn{
		height: 60px;
	}
	
	#email-auth-input {
		margin-right: 10px;
		height: 60px;
	    border-radius: 10px;
	    border: 1px solid gray;
	    padding-left: 20px;
	}

	#email-auth-span{
		position:absolute;
		left: 57%;
		top: 30%;
	}
	
	#email-auth-complete{
		color: green;
		display: none;
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
						<span class="info-logo"><a href='<%=request.getContextPath() %>/setting.do'>${MemberName }님, 반가워요.</a></span>
					</div>
					<div id="info-navi-wrap">
						<ul class="info-navi">
							<li onclick="location.href='setting_profile.do'" id="info-menu-1" class="navi-this-page info-navi-selected">프로필</li>
							<li onclick="location.href='setting_channel.do'" id="info-menu-2" class="navi-not-page">채널</li>
							<li id="info-menu-3" class="navi-not-page">계정 보안
								<ul id="info-submenu-3">
									<li onclick="location.href='setting_protect.do'">이메일 로그인</li>
									<li onclick="location.href='setting_login_history.do'">로그인 기록</li>
								</ul>
							</li> <!-- 이메일 로그인, 로그인 기록  -->
							<li onclick="location.href='vidividi_premium.do'" id="info-menu-4" class="navi-not-page">비디비디 프리미엄
								<ul id="info-submenu-4">
									<li>프리미엄 가입하기</li>
									<li>결제 내역</li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<div id="info-wrap-bottom">
					<div id="info-info">
						<h4>프로필</h4>
						<hr>
						<span>개인 정보를 추가하거나 수정합니다.</span>
						<br>
						<span>연령과 인증 정보에 따라 이용에 제한이 있을 수 있습니다.</span>
					</div>
					<div id="profile-input">
						<form>
							
							<div class="label-input onfocus" >
							<label for="input-id" id="input-id-check"></label>
							<label for="input-id" id="input-id-label">아이디</label>
							</div>
							<input name="member_id" class="member-input form-input disabled" id="input-id" value="${MemberDTO.getMember_id() }" disabled="disabled">
						
							<div class="label-input" >
							<label for="input-pwd" id="input-pwd-check"></label>
							<label for="input-pwd" id="input-pwd-label">비밀번호 변경</label>
							</div>
							<input name="member_pwd" class="member-input form-input password" id="input-pwd" value="">
														
							<div class="label-input" >
							<label for="input-pwd-confirm" id="input-pwd-confirm-check"></label>
							<label for="input-pwd-confirm" id="input-pwd-confirm-label">비밀번호 변경 확인</label>
							</div>
							<input name="member_pwd_confirm" class="member-input form-input password" id="input-pwd-confirm" value="">
														
							<div class="label-input" >
							<label for="input-name" id="input-name-check"></label>
							<label for="input-name" id="input-name-label">이름</label>
							</div>
							<input name="member_name" class="member-input form-input" id="input-name" value="${MemberDTO.getMember_name() }">
							
							<div id="email-input-wrap">
								<div id="email-input">
									<div class="label-input" >
										<label for="input-email" id="input-email-check"></label>
										<label for="input-email" id="input-email-label">이메일</label>
									</div>
									<input name="member_email" class="member-input form-input" id="input-email" value="${MemberDTO.getMember_email() }">
								</div>
								<div id="email-auth-btn">
									<input type="button" value="인증번호 받기" id="email-auth-request-btn" class="form-btn">
									<input id="email-auth-input" class="info-hidden" placeholder="인증번호">
									<span id="email-auth-span" class="info-hidden">전송중</span>
									<input type="button" value="입력" id="email-auth-confirm-btn" class="form-btn info-hidden">
									<span id="email-auth-complete"><i class="bi bi-check2-circle"></i> 인증 완료</span>
								</div>
							</div>
						
							<div class="label-input" >
							<label for="input-phone" id="input-phone-check"></label>
							<label for="input-phone" id="input-phone-label">전화번호</label>
							</div>
							<input name="member_phone" class="member-input form-input" id="input-phone" value="${MemberDTO.getMember_phone() }">
						
							<div class="label-input" >
							<label for="input-birth" id="input-birth-check"></label>
							<label for="input-birth" id="input-birth-label">생년월일</label>
							</div>
							<input type="date" name="member_birth" class="member-input form-input date-placeholder" id="input-birth" value="${MemberDTO.getMember_birth().substring(0,10) }">
						
							<div class="label-input" >
							<label for="input-addr" id="input-addr-check"></label>
							<label for="input-addr" id="input-addr-label">주소</label>
							</div>
							<input name="member_addr" class="member-input form-input" id="input-addr" value="${MemberDTO.getMember_addr() }">
							<div style="text-align: center;">
								<input type="button" class="form-btn disabled" id="profile-submit-btn" value="프로필 수정">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>