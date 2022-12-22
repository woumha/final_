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

function toggleEmailLogin(code){
	
	console.log('toggleEmailLogin 호출됨');
	
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	});
	
	$.ajax({
		url : '<%=request.getContextPath()%>/toggleEmailLogin.do',
		data: {
			member_code : "${MemberDTO.getMember_code()}"
		},
		success : function(data){
			if (data == "done"){
				toastr.success("이메일 로그인 설정을 변경했습니다.");
			}
		},
		error: function(){
			toastr.error("데이터 통신 오류");
		}
	});
}


$(function(){
	if ('${MemberDTO.getMember_code()}' != ''){
		let channelCode = '${MemberDTO.getMember_rep_channel()}';
		changeBackColor(channelCode);
	}
	
	naviCSS();
	
	if ('${MemberDTO.getMember_email_auth()}' == '0'){
		$("#toggle-email-login").attr("disabled", true);
		$("#toggle-email-login").on("change", function(){
			toastr.warning("이메일 인증을 먼저 진행해주세요.");
		});
	}else {
		if ('${MemberDTO.getMember_protect()}' == '1'){
			$("#toggle-email-login").prop("checked", true);
		}
		
		$("#toggle-email-login").change(function(){
			toggleEmailLogin('${MemberDTO.getMember_code()}');
		});
	}
	
});

</script>
<style type="text/css">
	
	

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
							<li onclick="location.href='setting_profile.do'" id="info-menu-1" class="navi-not-page">프로필</li>
							<li onclick="location.href='setting_channel.do'" id="info-menu-2" class="navi-not-page">채널</li>
							<li id="info-menu-3" class="navi-this-page">계정 보안
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
					<div>
						<div id="info-info">
							<h4>이메일 로그인</h4>
							<hr>
							<span>로그인 할 때마다 이메일 인증을 사용하여 계정 보안을 강화합니다.</span>
							<br>
							<span>인증된 이메일만 이메일 로그인을 사용할 수 있습니다.</span>
						</div>
							<div id="info-profile-card">
							<div id="info-profile-card-title">
								<span class="small-title-span">이메일 로그인</span>
								<label class="toggle-switch">
									<input type="checkbox" id="toggle-email-login">
									<span class="toggle-switch-slider round"></span>
								</label>
							</div>
							<hr>
							<div id="info-profile-card-content">
								<table id="info-profile-table">
									<tr>
										<th>이메일</th>
										<c:if test="${empty MemberDTO.getMember_email()}">
											<td colspan="2">미입력</td>
										</c:if>
										<c:if test="${!empty MemberDTO.getMember_email()}">
											<td colspan="2">${MemberDTO.getMember_email() }</td>
										</c:if>
									</tr>
									<tr>
										<th>상태</th>
										<c:if test="${MemberDTO.getMember_email_auth() == 0}">
											<td style="color: red;"><i class="bi bi-exclamation-diamond"></i>인증되지 않음</td>
											<td><span class="small-span" onclick="location.href='setting_profile.do'" style="cursor: pointer;">이메일 인증하기<i class="bi bi-chevron-double-right"></i></span></td>
										</c:if>
										<c:if test="${MemberDTO.getMember_email_auth() == 1}">
											<td colspan="2" style="color: green;"><i class="bi bi-check2-circle"></i>인증됨</td>
										</c:if>
									</tr>
								</table>
							</div>
						</div>
						<div>
						
						</div>
					</div>

					
				</div>
			</div>
		</div>
	</div>
	
	
	
</body>
</html>

