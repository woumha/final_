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
	
	#join-content-box div {
		display: inline-block;
		width: 100%;
	}
	
	#join-content-box div * {
		display: block;
		width: 100%;
		padding: 10px;
		margin: 5px;
	}
	
	input.password {
		-webkit-text-security:disc;
	}
	
</style>

<script type="text/javascript">
	
	$(function(){
		$("#join-content-2").hide();
		$("#join-content-3").hide();
		$("#id-confirm").hide();
		$("#pwd-confirm").hide();
		
		$("#join-form-submit-1").on('click', function(){
			$("#join-content-1").fadeOut('fast');
			$("#join-content-2").fadeIn(1000);
		});
		
		$("#join-form-submit-2").on('click', function(){
			$("#join-content-2").fadeOut('fast');
			$("#join-content-3").fadeIn(1000);
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
					<div id="join-content-1">
						<span>간편회원가입</span>
						<form method="post" action="joinOk.do">
						<input name="id" placeholder="아이디">
						<div id="id-confirm">
							<span>6글자 이상</span>
							<span>영소문자, 숫자만 사용가능</span>
							<span>중복 아이디 사용 불가</span>
						</div>
						<input name="pwd" placeholder="비밀번호" class="password">
						<input name="check-pwd" placeholder="비밀번호 확인" class="password">
						<div id="pwd-confirm">
							<span>8글자 이상</span>
							<span>영대문자, 영소문자, 숫자, 특수문자 사용</span>
							<span>비밀번호가 일치합니다.</span>
							<span>비밀번호가 일치하지 않습니다.</span>
						</div>
						<input type="button" value="회원가입" id="join-form-submit-1">
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
						<form method="post" action="joinAddInfo.do">
						<input type="text" name="name" placeholder="이름"> <!-- 이름을 입력하지 않으면 id값을 받아와 이름으로 처리 -->
						<input type="date" name="birth" placeholder="생년월일"> <!-- 일정 나이 이상이어야 조회가능한 동영상이 있음. -->
						<input type="text" name="email" placeholder="이메일"> <!-- *@*.* 형식인지 체크-->
						<input type="text" name="phone" placeholder="전화번호"> <!-- 문자인증 하지않으면 동영상 업로드 안되게..? 불법적인 동영상 있을 수 있으니까 실명인증 -->
						<input type="text" name="addr" placeholder="주소"> <!-- 주소는..없앨까...? -->
						<input type="button" value="선택정보 입력완료" id="join-form-submit-2">
						<input type="button" value="다음에 할래요" id="join-form-submit-3">
						</form>
					</div>
					<div id="join-content-3">
						<span>가입을 축하합니다!</span>
						<input type="button" value="메인으로 가기" id="join-form-submit-2" onclick="location.href='<%=request.getContextPath()%>'">
						<input type="button" value="마이페이지로 가기" id="join-form-submit-3">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>