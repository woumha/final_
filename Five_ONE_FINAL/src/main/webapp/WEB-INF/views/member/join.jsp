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
<!-- jQuery UI -->
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 
<!-- member css -->
<link rel="stylesheet" href="${path}/resources/member/member_join.css">
<link rel="stylesheet" href="${path}/resources/member/member_cummon.css">
<!-- toast -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- 카카오 주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- bootstrap icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">


<style type="text/css">

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

<script type="text/javascript">
	
	$(function(){
		
		// -------------------- ajex 셋업 -----------------------------
		$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type : "post"								
		});
		
		
		// -------------------- view 화면 구성 -----------------------------
		$("#join-content-1").nextAll().hide();
		
		$("#submit-1").attr("disabled", true);
		$("#submit-2").attr("disabled", true);
		
		// input 창 placeholder 구현 ->js파일에서 모듈화
		inputPlaceholder();
		
		
		// 선택정보 입력 확인하는 함수(1가지 항목이라도 입력하면 활성화)
		
		
		// 필수입력 & 선택입력 확인하여 submit버튼 활성화하는 함수
		
		$(".member-input").on('keyup', function(){
			// (필수입력은 모두 입력해야 활성화)
			if ($("#input-id").val() != '' && $("#input-pwd").val() != '' && $("#input-pwd-confirm").val() != '') {
				if (idOk && pwdOk && pwdCheckOk){
					$("#submit-1").attr("disabled", false);
					$("#submit-1").removeClass("disabled");
				}else {
					$("#submit-1").attr("disabled", true);
					$("#submit-1").addClass("disabled");
				}
			}else {
				$("#submit-1").attr("disabled", true);
				$("#submit-1").addClass("disabled");
			}
		});
		
		
		$(".member-input.optional").on('keyup', function(){
			if ($("#input-name").val() == "" &&
				$("#input-email").val() == "" &&	
				$("#input-birth").val().toString() == "" &&
				$("#input-phone").val() == "" &&
				$("#input-addr").val() == "")
			{
				$("#submit-2").attr("disabled", true);
				$("#submit-2").addClass("disabled");
			}else {
				$("#submit-2").attr("disabled", false);
				$("#submit-2").removeClass("disabled");
			}
		});
		
		// input[type=date] placeholder 제거하는 함수
		noCalHolder(); 
		$("#input-birth").on("change", function(){
			
			optionalInputChange();
		});
		
		
		// 주소창을 클릭하면 주소 검색 팝업을 띄우는 함수
		
		$("#input-addr1").on("click", function(){
			addrSearch();
		});
		$("#input-zipcode").on("click", function(){
			addrSearch();
		});
		
		// 비밀번호 보여주는 기능 구현 함수
		pwdShow();
		
		
		
		// -------------------- 클라이언트 -> 컨트롤러 로직 -----------------------
		
		// 아이디 중복을 확인하는 함수
		function joinIdCheck(){
			let id = $("#input-id").val();
			console.log(id);
			$.ajax({
				url: "<%=request.getContextPath()%>/joinIdCheck.do",
				data: { id : id },
				success: function(result){
/* 					if ($("#input-id").val() != ""){
						$("#input-id-check").show();
						$("#input-id-label").hide();
					} */
					
					if(result == 'allow'){
						$("#input-id-check").text("사용 가능한 아이디입니다.");
						$("#input-id-check").css("color", "green");
						idOk = true;
						
					}else if(result == 'deny'){
						$("#input-id-check").text("중복된 아이디입니다.");
						$("#input-id-check").css("color", "red");
						idOk=false;
						$("#submit-1").attr("disabled", true);
					}
				},
				error: function(){
					toastr.warning("아이디 중복 검사 오류");	
				}
			});
				
		}
		
		
		// 아이디 입력 시 1초동안 keyup없으면 id유효성 검사하는 이벤트 (db에 과요청 방지)
		$("#input-id").on('keyup', function(){
			
			$("#input-id").val($("#input-id").val().replace(/[^0-9a-zA-Z]/gi, ''));
			
			let keyupTimeout;
			clearTimeout(keyupTimeout);
			keyupTimeout = setTimeout(function(){
				
				if ($("#input-id").val() != ""){
					
					if (!regCheck(idReg, $("#input-id").val())){
						$("#input-id-check").text("4~10글자의 이하의 영문, 숫자만 아이디로 사용할 수 있습니다.");
						$("#input-id-check").css("color", "red");
						idOk = false;
						$("#submit-1").attr("disabled", true);
					}else{
						joinIdCheck();
					}
					
					$("#input-id-check").show();
					$("#input-id-label").hide();
				}
			}, 1000);
			
		});
		
		// 비빌번호 유효 검사
		memberPwdCheck();
		
		// 선택정보 유효 검사
		
		
	});

	
	let newMemberCode;
	
	// 회원가입
	function joinMember(){
		
		$.ajax({
			url : "<%=request.getContextPath()%>/joinOk.do",
			data : $('#join-form-1').serialize(),
			success : function(data){
				
				if (data != "fail"){
					// 새로 생성된 멤버코드 반환받아 히든 태그에 저장
					newMemberCode = data;
					console.log('ajax 반환값 : ' +data);
					$("#new-membercode").val(data);
					// 창 전환, 프로세스 바 이동
					$("#join-content-1").fadeOut('fast');
					$("#join-content-2").fadeIn(1000);
					$("#bar").animate({width: "66%"}, 1000);
				}else if (data == "fail"){
					toastr.warning("아이디/비밀번호를 확인하세요.", "가입 실패!");
				}
			},
			error : function(){
				toastr.error("이미 존재하는 아이디입니다.");
			}
			
		});
	}
	
	function DIVchange(){
		$("#join-content-2").fadeOut('fast');
		$("#join-content-3").fadeIn(1000);
		$("#bar").animate({width: "100%"}, 1000);
	}
	
	function infoUpdate(){
		
		$.ajax({
			url : "<%=request.getContextPath()%>/infoUpdate.do",
			data : $('#join-form-2').serialize(),
			success : function(result){
				if (result != 0){
					DIVchange();
				}else if (result == 0){
					toastr.warning("입력한 정보가 정확한지 확인하세요.", "정보 입력 실패!");
				}
				
			},
			error: function(){
				toastr.error("선택정보 입력 실패");
			}
			
		});		
	}

	
</script>
</head>
<body>
	<div id="join-page-wrap"> 
		<jsp:include page="../include/top_include.jsp"/>
		<div id="join-wrap">
			<div id="join-side-bar">
				<jsp:include page="../include/side_include.jsp"></jsp:include>
			</div>
			<div id="join-content">
				<div id="join-content-box">
					<div id="join-process-bar">
						<div id="bar"></div>
					</div>
					<div id="join-content-1">
						<form method="post" id="join-form-1">
							<span class="block-span login-logo">간편회원가입</span>
							<div class="input-wrap">
								<div class="label-input" >
									<label for="input-id" id="input-id-check"></label>
									<label for="input-id" id="input-id-label">아이디</label>
								</div>
								<input name="member_id" class="member-input essential" id="input-id">
							</div>
							
							<div class="input-wrap">
								<div class="label-input" >
									<label for="input-id" class="label-input" id="input-pwd-check"></label>
									<label for="input-id" class="label-input" id="input-pwd-label">비밀번호</label>
								</div>
								<div class="pwd-wrap">
									<input name="member_pwd" class="password member-input essential member-pwd-input" id="input-pwd" autocomplete="off">
									<div class="pwd-eye showEye">
										<i class="bi bi-eye-fill"></i>
									</div>
								</div>
								
							</div>
							
							<div class="input-wrap">
								<div class="label-input" >
									<label for="input-id" class="label-input" id="input-pwd-confirm-check"></label>
									<label for="input-id" class="label-input" id="input-pwd-confirm-label">비밀번호 확인</label>
								</div>
								<div class="pwd-wrap">
									<input name="check-pwd" class="password member-input essential member-pwd-input" id="input-pwd-confirm" autocomplete="off">
									<div class="pwd-eye showEye">
										<i class="bi bi-eye-fill"></i>
									</div>
								</div>
							</div>
							<div class="input-wrap">
								<input type="button" value="회원가입" class="form-btn disabled" id="submit-1" onclick="joinMember()">
							</div>
						</form>
					</div>
					<div id="join-content-2">
						<div>
						<span class="block-span login-logo">회원가입이 완료되었어요!</span>
						<span class="login-logo txt">선택정보를 입력하시면 더욱 편리하게 이용할 수 있어요.</span>
						</div>
						<form method="post" id="join-form-2">
							<input type="hidden" name="member_code" id="new-membercode" value="멤버코드">
							<div class="input-wrap">
								<div class="label-input" >
									<label for="input-name" class="label-input" id="input-name-check"></label>
									<label for="input-name" class="label-input" id="input-name-label">이름</label>
								</div>
								<input name="member_name" class="member-input optional" id="input-name"> <!-- 이름을 입력하지 않으면 id값을 받아와 이름으로 처리 -->
							</div>
							<div class="input-wrap">
								<div class="label-input" >
									<label for="input-email" class="label-input" id="input-email-check"></label>
									<label for="input-email" class="label-input" id="input-email-label">이메일</label>
								</div>
								<input name="member_email" class="member-input optional" id="input-email"> <!-- *@*.* 형식인지 체크-->
							</div>
							<div class="input-wrap">
								<div class="label-input" >
									<label for="input-birth" class="label-input" id="input-birth-check"></label>
									<label for="input-birth" class="label-input" id="input-birth-label">생년월일</label>
								</div>
								<input type="date" name="member_birth" class="member-input optional date-placeholder date-empty" id="input-birth" data-placeholder="" > <!-- 일정 나이 이상이어야 조회가능한 동영상이 있음. -->
							</div>
							<div class="input-wrap">
								<div class="label-input" >
									<label for="input-phone" class="label-input" id="input-phone-check"></label>
									<label for="input-phone" class="label-input" id="input-phone-label">전화번호</label>
								</div>
								<input name="member_phone" class="member-input optional" id="input-phone"> <!-- 문자인증 하지않으면 동영상 업로드 안되게..? 불법적인 동영상 있을 수 있으니까 실명인증 -->
							</div>
							<div class="input-wrap">
								<div id="addr-wrap">
									<div>
										<div class="label-input" >
										<label for="input-zipcode" class="label-input" id="input-zipcode-check"></label>
										<label for="input-zipcode" class="label-input" id="input-zipcode-label">우편번호</label>
										</div>
										<input name="member_zipcode" class="member-input optional" id="input-zipcode">
									</div>
									<div>
										<div class="label-input" >
										<label for="input-addr1" class="label-input" id="input-addr1-check"></label>
										<label for="input-addr1" class="label-input" id="input-addr1-label">주소</label>
										</div>
										<input name="member_addr1" class="member-input optional" id="input-addr1"> 
									</div>
								</div>
							</div>
							<div class="input-wrap">
								<div class="label-input" >
									<label for="input-addr2" class="label-input" id="input-addr2-check"></label>
									<label for="input-addr2" class="label-input" id="input-addr2-label">상세주소</label>
								</div>
								<input name="member_addr2" class="member-input optional" id="input-addr2"> 
							</div>
							<div class="input-wrap">
								<input type="button" value="선택정보 입력" class="form-btn disabled" id="submit-2" onclick = "infoUpdate()" disabled="disabled">
							</div>
							<div class="input-wrap">
								<input type="button" value="다음에 할래요" class="form-btn disabled" id="submit-3" onclick = "DIVchange()">
							</div>
						</form>
					</div>
					<div id="join-content-3">
						<span class="block-span login-logo">가입을 축하합니다! 🎉</span>
						<span class="login-logo txt">이제 비디비디를 즐기러 가볼까요?</span>
						<div class="input-wrap">
							<input type="button" value="메인으로 가기" class="form-btn" id="submit-4" onclick="location.href='<%=request.getContextPath()%>'">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>