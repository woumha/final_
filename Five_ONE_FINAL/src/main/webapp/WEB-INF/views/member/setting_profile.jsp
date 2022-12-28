<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

<!-- toast -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- 카카오 주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">


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


function changePwd(){
	
	let id_form = $("#input-id").val();
	let current = $("#input-pwd-current").val();
	let change = $("#input-pwd").val();
	
	$.ajax({
		url : "<%=request.getContextPath()%>/change_pwd.do",
		data : {
			id : id_form,
			current_pwd : current,
			change_pwd : change
		},
		success : function(data){
			if (data == "success"){
				toastr.success('비밀번호가 변경되었습니다.');
				$("#input-pwd-current").val("");
				$("#input-pwd").val("");
				$("#input-pwd-confirm").val("");
				inputPlaceholder();
			}else if (data == "fail"){
				toastr.warning('현재 비밀번호를 확인하세요.');
			}else if (data == "session"){
				toastr.error('로그인 세션이 만료되었습니다.','다시 로그인 하세요.');
				$(location).attr('href', '<%=request.getContextPath()%>/login.do');
			}
		},
		error : function(){
			toastr.error('비밀번호 변경 통신 오류');
		}			
	});
	
}


function changeProfile(){
	$.ajax({
		url : "<%=request.getContextPath()%>/change_profile.do",
		data : $("#profile-form").serialize(),
		success : function(data){
			if (data == "success"){
				toastr.success('프로필이 변경되었습니다.');
			}else if (data == "fail"){
				toastr.warning('프로필 변경에 실패했습니다.','입력한 정보를 다시 확인하세요.');
			}else if (data == "session"){
				toastr.error('로그인 세션이 만료되었습니다.','다시 로그인 하세요.');
				$(location).attr('href', '<%=request.getContextPath()%>/login.do');
			}
		},
		error : function(){
			toastr.error('프로필 변경 통신 오류');
		}			
	});
}

function expire(){
	
	modalShow();
	
	<% 
	
	String memberCode = "";
	if (session.getAttribute("MemberCode") != null) {
		memberCode = (String)session.getAttribute("MemberCode");
	}else {
		memberCode = "sessionExpired";
	}
	%>
	$("#expire-btn").on('click', function(){
		if ($("#expire-confirm-input").val() == '${MemberDTO.getMember_name()} 탈퇴를 확인합니다.'){
			$.ajax({
				url : "<%=request.getContextPath()%>/member_expire.do",
				data : {
					member_code : "<%= memberCode %>"
				},
				success : function(data){
					if (data == "success"){
						toastr.success('다음에 다시 만나요.','탈퇴되었습니다.');
						setTimeout(() => {
							$(location).attr('href', '<%=request.getContextPath()%>');
						}, 2000);
					}else if (data == "fail"){
						toastr.warning('회원 탈퇴에 실패했습니다.','입력한 정보를 다시 확인하세요.');
					}else if (data == "session"){
						toastr.error('로그인 세션이 만료되었습니다.','다시 로그인 하세요.');
						$(location).attr('href', '<%=request.getContextPath()%>/login.do');
					}
				},
				error : function(){
					toastr.error('회원 탈퇴 통신 오류');
				}		
			});
		}else{
			toastr.warning('메세지를 정확하게 다시 입력하세요.');
		}
	});
}


function cancleExpire(){
	modalHide();
	$("#expire-confirm-input").val("");
}



$(function(){
	
	if ('${MemberDTO.getMember_birth()}' != ''){
		$("#input-birth").removeClass('date-empty');
	}
	
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
	
	toastrSetup();
	$("body").css("position","fixed");
	inputPlaceholder();
	$("body").css("position","");
	noCalHolder(); 
	naviCSS();
		
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
	
	// 주소창을 클릭하면 주소 검색 팝업을 띄우는 함수
	
	$("#input-addr1").on("click", function(){
		addrSearch();
	});
	$("#input-zipcode").on("click", function(){
		addrSearch();
	});
	
	// 비밀번호 유효성 검사
	memberPwdCheck();
	
	// 비밀번호 보여주는 기능
	pwdShow();
	
	
	// 비밀번호 입력하면 버튼 활성화하는 함수
	$("input.member-input").on('keyup',function(){
		if($("#input-pwd").val() != "" && pwdOk && pwdCheckOk){
			$("#pwd-submit-btn").attr("disabled", false);
			$("#pwd-submit-btn").removeClass("disabled");
		}else {
			$("#pwd-submit-btn").attr("disabled", true);
			$("#pwd-submit-btn").addClass("disabled");
		}
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
	
	#addr-wrap{
		display: flex;
	}
	
	#addr-wrap div:nth-child(1){
		flex: 3;
		margin-right: 10px;
	}
	
	#addr-wrap div:nth-child(2){
		flex: 7;
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
						<span class="info-logo"><a href='<%= request.getContextPath() %>/setting.do'>${MemberName }님, 반가워요.</a></span>
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
						<form id="profile-form">
							<div id="profile-pwd"> <!-- 비밀번호 변경 -->
								<div class="input-wrap">
									<div class="label-input onfocus" >
									<label for="input-id" id="input-id-check"></label>
									<label for="input-id" id="input-id-label">아이디</label>
									</div>
									<c:if test="${!fn:contains(MemberDTO.getMember_id(), '-')}">
										<input name="member_id" class="member-input form-input disabled" id="input-id" value="${MemberDTO.getMember_id() }" disabled="disabled">
									</c:if>
									<c:if test="${fn:contains(MemberDTO.getMember_id(), '-')}">
										<input name="member_id" class="member-input form-input disabled" id="input-id" value="소셜 로그인" disabled="disabled">
									</c:if>
								</div>
								<div class="input-wrap">
									<div class="label-input" >
										<label for="input-pwd-current" class="label-input" id="input-pwd-current-check"></label>
										<label for="input-pwd-current" class="label-input" id="input-pwd-current-label">현재 비밀번호</label>
									</div>
									<div class="pwd-wrap">
										<c:if test="${!fn:contains(MemberDTO.getMember_id(), '-')}">
											<input name="current_pwd" class="password member-input form-input essential member-pwd-input" id="input-pwd-current" autocomplete="off">
											<div class="pwd-eye showEye">
												<i class="bi bi-eye-fill"></i>
											</div>
										</c:if>
										<c:if test="${fn:contains(MemberDTO.getMember_id(), '-')}">
											<input name="current_pwd" class="member-input form-input essential member-pwd-input disabled" value="현재 비밀번호" id="input-pwd-current" autocomplete="off" disabled="disabled">
											<div style="position: absolute; top:15px; right:20px; color: gray;">
												<i class="bi bi-eye-fill"></i>
											</div>
										</c:if>
									</div>
									
								</div>
								<div class="input-wrap">
									<div class="label-input" >
										<label for="input-pwd" class="label-input" id="input-pwd-check"></label>
										<label for="input-pwd" class="label-input" id="input-pwd-label">비밀번호 변경</label>
									</div>
									<div class="pwd-wrap">
										<c:if test="${!fn:contains(MemberDTO.getMember_id(), '-')}">
											<input name="mamber_pwd" class="password member-input form-input essential member-pwd-input" id="input-pwd" autocomplete="off">
											<div class="pwd-eye showEye">
												<i class="bi bi-eye-fill"></i>
											</div>
										</c:if>
										<c:if test="${fn:contains(MemberDTO.getMember_id(), '-')}">
											<input name="mamber_pwd" class="member-input form-input essential member-pwd-input disabled" value="비밀번호 변경" id="input-pwd" autocomplete="off" disabled="disabled">
											<div style="position: absolute; top:15px; right:20px; color: gray;">
												<i class="bi bi-eye-fill"></i>
											</div>
										</c:if>
									</div>
									
								</div>
								
								<div class="input-wrap">
									<div class="label-input" >
										<label for="input-pwd-confirm" class="label-input" id="input-pwd-confirm-check"></label>
										<label for="input-pwd-confirm" class="label-input" id="input-pwd-confirm-label">비밀번호 변경 확인</label>
									</div>
									<div class="pwd-wrap">
										<c:if test="${!fn:contains(MemberDTO.getMember_id(), '-')}">
											<input name="confirm_pwd" class="password member-input form-input essential member-pwd-input" id="input-pwd-confirm" autocomplete="off">
											<div class="pwd-eye showEye">
												<i class="bi bi-eye-fill"></i>
											</div>
										</c:if>
										<c:if test="${fn:contains(MemberDTO.getMember_id(), '-')}">
											<input name="confirm_pwd" class="member-input form-input essential member-pwd-input disabled" value="비밀번호 변경 확인" id="input-pwd-confirm" autocomplete="off" disabled="disabled">
											<div style="position: absolute; top:15px; right:20px; color: gray;">
												<i class="bi bi-eye-fill"></i>
											</div>
										</c:if>
									</div>
								</div>
								
								<div class="input-wrap">
									<div style="text-align: center;">
										<input type="button" class="form-btn disabled" id="pwd-submit-btn" value="비밀번호 변경" disabled="disabled" onclick="changePwd()">
									</div>
								</div>
								
							</div> <!-- 비밀번호 변경 끝 -->
							<div class="gap"></div>
							<div id="profile-optional"> <!-- 선택정보 -->
								<div class="input-wrap">
									<div class="label-input" >
									<label for="input-name" id="input-name-check"></label>
									<label for="input-name" id="input-name-label">이름</label>
									</div>
									<input name="member_name" class="member-input form-input" id="input-name" value="${MemberDTO.getMember_name() }">
								</div>
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
								<div class="input-wrap">
									<div class="label-input" >
									<label for="input-phone" id="input-phone-check"></label>
									<label for="input-phone" id="input-phone-label">전화번호</label>
									</div>
									<input name="member_phone" class="member-input form-input" id="input-phone" value="${MemberDTO.getMember_phone() }">
								</div>
								<div class="input-wrap">
									<div class="label-input" >
									<label for="input-birth" id="input-birth-check"></label>
									<label for="input-birth" id="input-birth-label">생년월일</label>
									</div>
									<input type="date" name="member_birth" class="member-input form-input date-placeholder date-empty" id="input-birth" value="${MemberDTO.getMember_birth().substring(0,10)}">
								</div>
								<div class="input-wrap">
									<div id="addr-wrap">
										<div>
										<div class="label-input" >
										<label for="input-zipcode" id="input-zipcode-check"></label>
										<label for="input-zipcode" id="input-zipcode-label">우편번호</label>
										</div>
										<input name="member_zipcode" class="member-input form-input" id="input-zipcode" value="${MemberDTO.getMember_zipcode() }">
										</div>
										<div>
										<div class="label-input" >
										<label for="input-addr1" id="input-addr1-check"></label>
										<label for="input-addr1" id="input-addr1-label">주소</label>
										</div>
										<input name="member_addr1" class="member-input form-input" id="input-addr1" value="${MemberDTO.getMember_addr1() }">
										</div>
									</div>
								</div>
								<div class="input-wrap">
									<div class="label-input" >
									<label for="input-addr2" id="input-addr2-check"></label>
									<label for="input-addr2" id="input-addr2-label">상세주소</label>
									</div>
									<input name="member_addr2" class="member-input form-input" id="input-addr2" value="${MemberDTO.getMember_addr2() }">
								</div>
								<div class="input-wrap">
									<div style="text-align: center;">
										<input type="button" class="form-btn" id="profile-submit-btn" value="프로필 수정" onclick="changeProfile()">
									</div>
								</div>
							<div style="text-align:right;"><span class="small-span" onclick="expire()" style="cursor: pointer;">회원탈퇴<i class="bi bi-chevron-double-right"></i></span></div>
							</div> <!-- 선택정보 입력 끝 -->
							
						</form>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 회원 탈퇴 모달 -->
		<div class="member-modal">
		<div class="member-modal-body">
			<div class="member-modal-title member-sad">
				<span>정말 비디비디를 떠나실거에요?</span>
			</div>
			<hr>
			<div class="member-modal-content member-sad">
				<span>- 더 이상 로그인하실 수 없어요.</span><br>
				<span>- 채널과 업로드한 영상을 관리할 수 없어요.</span><br>
				<span>- 가입한 프리미엄 혜택이 바로 종료돼요.</span><br><br>
				<span>그래도 탈퇴하시려면 다음 내용을 정확하게 입력해주세요.</span><br><br>
				<div class="input-warp" style="background-color: rgb(245, 245, 245); padding: 20px;">
					<span class="small-title-span">${MemberDTO.getMember_name() } 탈퇴를 확인합니다.</span>
				</div>
				<div class="input-wrap">
					<input id="expire-confirm-input" class="member-input form-input">
				</div>
				<br>
				<input type="button" value="탈퇴" id="expire-btn">
				<input type="button" value="취소" class="member-emp" id="expire-cancle-btn" onclick="cancleExpire()">
			</div>
		</div>
	</div>
</body>
</html>