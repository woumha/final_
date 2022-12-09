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
	
	
	#join-content-box div input, #join-content-box div span {
		display: block;
		width: 100%;
		padding: 20px;
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
	
	.label-input {
		display: block;
		position: absolute;
		padding-left: 20px;
	    padding-top: 18px;
	    color: gray;
	    transition: all 0.5s;
	}
	
	.join-input{
		border-radius: 10px;
		border: 1px solid gray;
		background-color: transparent;
	}
	
	.join-input:focus{
		outline: none;
		box-shadow: none;
	}
	
	.onfocus{
		font-size: 0.6em;
		padding-top: 8px;
		padding-left: 12px;
	}

	
	
</style>

<script type="text/javascript">
	
	$(function(){
		
		$("#join-content-1").nextAll().hide();
		$(".join-check").hide();
		
		$("#submit-1").attr("disabled", true);
		$("#submit-2").attr("disabled", true);
		
		$(".join-form-btn").on('click', function(){
			$(this).parent().parent('div').fadeOut('fast');
			$(this).parent().parent('div').next().fadeIn(1000);
			if ($(this).val() == '회원가입'){
				$("#bar").animate({width: "66%"}, 1000);
			}else {
				$("#bar").animate({width: "100%"}, 1000);
			}
			
		});
		
		$(".join-input").on('focus', function(){
			$(this).prev('label').addClass('onfocus');
		});
		
		$(".join-input").on('blur', function(){
			if($(this).val() == ''){
				$(this).prev('label').removeClass('onfocus');
			}
		});
		
		$(".join-input").on('keyup', function(){
			
			if ($("#input-id").val() != '' && $("#input-pwd").val() != '' && $("#input-pwd-confirm").val() != '') {
				$("#submit-1").attr("disabled", false);
			}else {
				$("#submit-1").attr("disabled", true);
			}
			
			if ($("#join-form-2").serialize() != '') {
				$("#submit-2").attr("disabled", false);
			}else {
				$("#submit-2").attr("disabled", true);
			}
		});

	});
	
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
							<span>간편회원가입</span>
							<label for="input-id" class="label-input" id="input-id-label">아이디</label>
							<input name="id" class="join-input essential" id="input-id">
							<div class="join-check" id="id-check">
								<span>6글자 이상</span>
								<span>영소문자, 숫자만 사용가능</span>
								<span>중복 아이디 사용 불가</span>
							</div>
							
							<label for="input-id" class="label-input" id="input-pwd-label">비밀번호</label>
							<input name="pwd" class="password join-input essential" id="input-pwd">
							
							<label for="input-id" class="label-input" id="input-pwd-confirm-label">비밀번호 확인</label>
							<input name="check-pwd" class="password join-input essential" id="input-pwd-confirm">
							<div class="join-check" id="pwd-check">
								<span>8글자 이상</span>
								<span>영대문자, 영소문자, 숫자, 특수문자 사용</span>
								<span>비밀번호가 일치합니다.</span>
								<span>비밀번호가 일치하지 않습니다.</span>
							</div>
							<input type="button" value="회원가입" class="join-form-btn" id="submit-1">
						</form>
						<hr>
						<span>소셜로 가입하기</span>
						<input type="button" value="구글로 가입하기">
						<input type="button" value="카카오로 가입하기">
						<input type="button" value="네이버로 가입하기">
					</div>
					<div id="join-content-2">
						<span>회원가입이 완료되었어요!</span>
						<span>선택정보를 입력하시면 더욱 편리하게 이용할 수 있어요</span>
						<span>사실 가입 안됐습니다. view 페이지 구성중입니다.</span>
						<form method="post" id="join-form-2">
							<input name="name" placeholder="이름" class="join-input optional" id="input-name"> <!-- 이름을 입력하지 않으면 id값을 받아와 이름으로 처리 -->
							<input name="email" placeholder="이메일" class="join-input optional" id="input-email"> <!-- *@*.* 형식인지 체크-->
							<input type="date" name="birth" placeholder="생년월일" class="join-input optional" id="input-name"> <!-- 일정 나이 이상이어야 조회가능한 동영상이 있음. -->
							<input name="phone" placeholder="전화번호" class="join-input optional" id="input-name"> <!-- 문자인증 하지않으면 동영상 업로드 안되게..? 불법적인 동영상 있을 수 있으니까 실명인증 -->
							<input name="addr" placeholder="주소" class="join-input optional" id="input-name"> <!-- 주소는..없앨까...? -->
							<input type="button" value="선택정보 입력" class="join-form-btn" class="join-input optional" id="submit-2" id="input-name">
							<input type="button" value="다음에 할래요" class="join-form-btn" class="join-input optional" id="submit-3" id="input-name">
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