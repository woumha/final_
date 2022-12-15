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

<script type="text/javascript">

$(function(){
	
	$("#profile-submit-btn").attr("disabled", true);
	
	if ('${MemberDTO.getMember_rep_channel()}' != ''){
		let memberCode = '${MemberDTO.getMember_rep_channel()}';
		changeBackColor(memberCode);
	}
		
	inputPlaceholder();
	naviCss();
	noCalHolder(); 
	
	/* $("#file-input").on('change', function(event){
		
		event.preventDefault();
		var files = event.originalEvent.dataTransfer.files;
		var formData = new FormData();
		formData.append('files', files[0]);

	}); */
		
});

<%-- function ajaxFileTest(){
	
	$.ajax({
		url: "<%=request.getContextPath()%>/ajaxFileTest.do",
		data: $("#fileTest").serialize(),
		processData: false,
		contentType: false,
		type: 'POST',
		success: function(data){
			if (data == 'success'){
				alert('success');
			}
		},
		error : function(){
			alert('fail');
		}
	});
	
} --%>

</script>
<style type="text/css">

	#profile-input {
		width: 30%;
		margin: auto;	
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
						<span class="info-logo">${MemberName }님, 반가워요.</span>
					</div>
					<div id="info-navi-wrap">
						<ul class="info-navi">
							<li onclick="location.href='setting_profile.do'">프로필</li>
							<li onclick="location.href='setting_channel.do'">채널</li>
							<li onclick="location.href='setting_protect.do'">계정 보안</li> <!-- 이메일 로그인, 로그인 기록  -->
							<li onclick="location.href='vidividi_premium.do'">비디비디 프리미엄</li>
						</ul>
					</div>
				</div>
				<div id="info-wrap-bottom">
					<div id="profile-input">
						<div>
							<span></span>
						</div>
<!-- 						<form id="fileTest">
							<input name="test1">
							<input name="test2">
							<input type="file" id="file-input" name="file">
							<input type="button" value="submit" onclick="ajaxFileTest();">
						</form>
						 -->
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
											
							<div class="label-input" >
							<label for="input-email" id="input-email-check"></label>
							<label for="input-email" id="input-email-label">이메일</label>
							</div>
							<input name="member_email" class="member-input form-input" id="input-email" value="${MemberDTO.getMember_email() }">
							
						
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