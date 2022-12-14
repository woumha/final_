<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script> 
<!-- jQuery UI -->
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 
<!-- toast -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<style type="text/css">
	html, body, #join-page-wrap {
		height: 100%;
	}

	#join-wrap {
		display: flex;
		align-items: center;
		height: 80%;
	}
	
	#join-side-bar {
		flex: 1;
	}
	
	#join-content {
		flex: 9;
		height: 100%;
		display: flex;
		align-items: center;
	}
	
	#join-content-box {
		margin: auto;
		width: 30%;
	}
	
	#join-content-1, #join-content-2, #join-content-3 {
		display: inline-block;
		width: 100%;
	}
	
	
	#join-content-box div input, #join-content-box div span.block-span {
		display: block;
		width: 100%;
		padding: 15px;
		padding-top: 20px;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	input.password {
		-webkit-text-security:disc;
	}
	
	#join-process-bar {
		width: 100%;
		height: 5px;
		background-color: lightgray;
	}
	
	#bar {
		width: 33%;
		height: 100%;
		background-color: #fc942c;
	}
	
	div.label-input {
		display: inline;
		position: absolute;
	    color: gray;
	    transition: all 0.5s;
	    margin-left: 20px;
	    margin-top: 18px;
	}
	
	label.label-input{
		
	}
	
	.join-input{
		border-radius: 10px;
		border: 1px solid gray;
		background-color: transparent;
		font-size: 1em;
	}
	
	.join-input:focus{
		outline: none;
		box-shadow: none;
	}
	
	.onfocus{
		font-size: 0.6em;
		margin-left:12px !important;
		margin-top:8px !important;
	}
	
	/* input[type=date]::-webkit-datetime-edit-text {
	    -webkit-appearance: none;
	    display: none;
	}
	input[type=date]::-webkit-datetime-edit-month-field{
	    -webkit-appearance: none;
	    display: none;
	}
	input[type=date]::-webkit-datetime-edit-day-field {
	    -webkit-appearance: none;
	    display: none;
	}
	input[type=date]::-webkit-datetime-edit-year-field {
	    -webkit-appearance: none;
	    display: none;
	}
	 */
	 
	 
	 .date-empty:before{
	 	content: attr(data-placeholder);
	 	width: 100%;
	 }
	 
	 /* 부트스트랩 토스트창 배경색 중복 수정 */
	div.toast {
		background-color: unset;
	}
	
	div.toast-success {
		background-color: #51A351;
	}
	div.toast-warning {
		background-color: #f89406;
	}
	div.toast-info {
		background-color: #2F96B4;
	}
	div.toast-error {
		background-color: #BD362F;
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
		
		// input 창 placeholder 구현
		$(".join-input").on('focus', function(){
			$(this).prev('div').addClass('onfocus');
		});
				
		$(".join-input").on('blur', function(){
			if($(this).val() == ''){
				$(this).prev('div').removeClass('onfocus');
				$(this).prev('div').children().eq(0).hide();
				$(this).prev('div').children().eq(1).show();
			}
		});
		
		
		// 선택정보 입력 확인하는 함수(1가지 항목이라도 입력하면 활성화)
		function optionalInputChange(){
			if ( 
					$("#input-name").val() == "" &&
					$("#input-email").val() == "" &&	
					$("#input-birth").val().toString() == "" &&
					$("#input-phone").val() == "" &&
					$("#input-addr").val() == ""
				) {
					$("#submit-2").attr("disabled", true);
				}else {
					$("#submit-2").attr("disabled", false);
				}
		}
		
		// 필수입력 & 선택입력 확인하여 submit버튼 활성화하는 함수
		$(".join-input").on('keyup', function(){
			
			// (필수입력은 모두 입력해야 활성화)
			if ($("#input-id").val() != '' && $("#input-pwd").val() != '' && $("#input-pwd-confirm").val() != '') {
				$("#submit-1").attr("disabled", false);
			}else {
				$("#submit-1").attr("disabled", true);
			}
						
			optionalInputChange();
			
		});
		
		
		// input[type=date] placeholder 제거하는 함수
		$("input[type=date].date-placeholder").on("change", function(){
			if ($(this).val() == ""){
				$(this).addClass("date-empty");
				console.log($("#input-birth").val());
			}else{
				$(this).removeClass("date-empty");
				console.log($("#input-birth").val());
			}
			
			optionalInputChange();
		});
		
		
		
		// -------------------- 클라이언트 -> 컨트롤러 로직 -----------------------
		
		// 아이디, 비밀번호, 이름, 이메일, 전화번호 유효성 확인하는 정규식
		let idReg = /^[a-zA-Z0-9][a-zA-Z0-9]{3,10}$/; //영대소문, 숫자 4~10글자
		let pwdReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/; //영대소문, 숫자, 특수문자 하나씩 포함하여 8~16글자
		let nameReg = /^[가-힣a-zA-Z]+$/;
		let emailReg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		let phoneReg = /^01[0179][0-9]{7,8}$/;
		
		// 정규식에 부합한지 확인하는 함수
		function regCheck(checkType, value){
			let Reg = RegExp(checkType);
			let result = Reg.test(value);
			return result;
		}
		
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
					}else if(result == 'deny'){
						$("#input-id-check").text("중복된 아이디입니다.");
						$("#input-id-check").css("color", "red");
					}
				},
				error: function(){
					toastr.warning("데이터 전송 오류");	
				}
			});
				
		}
		
		
		// 아이디 입력 시 1초동안 keyup없으면 id유효성 검사하는 이벤트 (db에 과요청 방지)
		$("#input-id").on('keyup', function(){
			
			let keyupTimeout;
			clearTimeout(keyupTimeout);
			keyupTimeout = setTimeout(function(){
				
				if ($("#input-id").val() != ""){
					
					if (!regCheck(idReg, $("#input-id").val())){
						// 정규식 어긋나는거 지우는건 잘 안되는 중..
						$("#input-id").val($("#input-id").val().replace("/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi", ''));
						$("#input-id-check").text("4~10글자의 이하의 영문, 숫자만 아이디로 사용할 수 있습니다.");
						$("#input-id-check").css("color", "red");
					}else{
						joinIdCheck();
					}
					
					$("#input-id-check").show();
					$("#input-id-label").hide();
										
				}
			
			}, 1000);
			
			
		});
		
		// -------------------------- 나중에 할 일 ------------------------
		
		
		// 비빌번호 유효 검사
		
		// 선택정보 유효 검사
		
		
	});

/* 	function ajaxTest(){
		$.ajax({
			url : "./testajax.do",
			type: "POST",
			success : function(data){
				
				$(data).each(function(){
					alert(this.member_code+"/"+this.member_id+"/"+this.member_name);
				});
				
			},
			error : function(){
				alert("데이터 통신 오류");
			}
		});
		
	} */
	
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
				toastr.error("데이터 통신 에러");
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
				toastr.error("데이터 통신 에러");
			}
			
		});		
	}

	
</script>
</head>
<body>
<!-- <button onclick="ajaxTest();">테스트~~~~~~~~~~~~</button> -->
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
							<span class="block-span">간편회원가입</span>
							<input type="hidden" name="member_code" id="new-membercode">
							<div class="label-input" >
								<label for="input-id" id="input-id-check"></label>
								<label for="input-id" id="input-id-label">아이디</label>
							</div>
							<input name="member_id" class="join-input essential" id="input-id">
							
							<div class="label-input" >
								<label for="input-id" class="label-input" id="input-pwd-check"></label>
								<label for="input-id" class="label-input" id="input-pwd-label">비밀번호</label>
							</div>
							<input name="member_pwd" class="password join-input essential" id="input-pwd">
							
							<div class="label-input" >
								<label for="input-id" class="label-input" id="input-pwd-confirm-check"></label>
								<label for="input-id" class="label-input" id="input-pwd-confirm-label">비밀번호 확인</label>
							</div>
							<input name="check-pwd" class="password join-input essential" id="input-pwd-confirm">
							
							<input type="button" value="회원가입" class="join-form-btn" id="submit-1" onclick="joinMember()">
						</form>
						<hr>
						<span class="block-span">소셜로 가입하기</span>
						<input type="button" value="구글로 가입하기">
						<input type="button" value="카카오로 가입하기">
						<input type="button" value="네이버로 가입하기">
					</div>
					<div id="join-content-2">
						<div>
						<span>회원가입이 완료되었어요!</span>
						<br>
						<span>선택정보를 입력하시면 더욱 편리하게 이용할 수 있어요</span>
						</div>
						<form method="post" id="join-form-2">
							<input type="hidden" name="member_code" id="new-membercode">
							<div class="label-input" >
								<label for="input-name" class="label-input" id="input-name-check"></label>
								<label for="input-name" class="label-input" id="input-name-label">이름</label>
							</div>
							<input name="member_name" class="join-input optional" id="input-name"> <!-- 이름을 입력하지 않으면 id값을 받아와 이름으로 처리 -->
							
							<div class="label-input" >
								<label for="input-email" class="label-input" id="input-email-check"></label>
								<label for="input-email" class="label-input" id="input-email-label">이메일</label>
							</div>
							<input name="member_email" class="join-input optional" id="input-email"> <!-- *@*.* 형식인지 체크-->
							
							<div class="label-input" >
								<label for="input-birth" class="label-input" id="input-birth-check"></label>
								<label for="input-birth" class="label-input" id="input-birth-label">생년월일</label>
							</div>
							<input type="date" name="member_birth" class="join-input optional date-placeholder date-empty" id="input-birth" data-placeholder=""> <!-- 일정 나이 이상이어야 조회가능한 동영상이 있음. -->
							
							<div class="label-input" >
								<label for="input-phone" class="label-input" id="input-phone-check"></label>
								<label for="input-phone" class="label-input" id="input-phone-label">전화번호</label>
							</div>
							<input name="member_phone" class="join-input optional" id="input-phone"> <!-- 문자인증 하지않으면 동영상 업로드 안되게..? 불법적인 동영상 있을 수 있으니까 실명인증 -->
							
							<div class="label-input" >
								<label for="input-addr" class="label-input" id="input-addr-check"></label>
								<label for="input-addr" class="label-input" id="input-addr-label">주소</label>
							</div>
							<input name="member_addr" class="join-input optional" id="input-addr"> <!-- 주소는..없앨까...? -->
														
							<input type="button" value="선택정보 입력" class="join-form-btn" id="submit-2" onclick = "infoUpdate()">
							<input type="button" value="다음에 할래요" class="join-form-btn" id="submit-3" onclick = "DIVchange()">
						</form>
					</div>
					<div id="join-content-3">
						<span>가입을 축하합니다!</span>
						<input type="button" value="메인으로 가기" class="join-form-btn" id="submit-4" onclick="location.href='<%=request.getContextPath()%>'">
						<input type="button" value="마이페이지로 가기" class="join-form-btn" id="submit-5">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>