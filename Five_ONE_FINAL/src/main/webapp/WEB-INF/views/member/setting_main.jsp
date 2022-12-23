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
	if ('${MemberDTO.getMember_code()}' != ''){
		let channelCode = '${MemberDTO.getMember_rep_channel()}';
		changeBackColor(channelCode);
	}
	
	naviCSS();
	
});

</script>

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
					<div id="info-card-wrap">
						<div id="info-profile-card">
							<div id="info-profile-card-title">
								<span class="small-title-span">프로필</span>
								<span class="small-span" onclick="location.href='setting_profile.do'" style="cursor: pointer;">정보 수정<i class="bi bi-chevron-double-right"></i></span>
							</div>
							<hr>
							<div id="info-profile-card-content">
								<table id="info-profile-table">
									<tr>
										<th class="small-content-span-1">이름</th>
										<td class="small-content-span-2">${MemberDTO.getMember_name() }</td>
										<th class="small-content-span-1">이메일</th>
										<c:if test="${empty MemberDTO.getMember_email()}" >
											<td class="small-content-span-2">미입력</td>
										</c:if>
										<c:if test="${!empty MemberDTO.getMember_email()}" >
											<td class="small-content-span-2">${MemberDTO.getMember_email() }</td>
										</c:if>
									</tr>
									<tr>
										<th class="small-content-span-1">생년월일</th>
										<c:if test="${empty MemberDTO.getMember_birth()}" >
											<td class="small-content-span-2">미입력</td>
										</c:if>
										<c:if test="${!empty MemberDTO.getMember_birth()}" >
											<td class="small-content-span-2">${MemberDTO.getMember_birth().substring(0, 10) }</td>
										</c:if>
										<th class="small-content-span-1">전화번호</th>
										<c:if test="${empty MemberDTO.getMember_phone()}" >
											<td class="small-content-span-2">미입력</td>
										</c:if>
										<c:if test="${!empty MemberDTO.getMember_phone()}" >
											<td class="small-content-span-2">${MemberDTO.getMember_phone() }</td>
										</c:if>
									</tr>
									<tr>
										<th class="small-content-span-1">나이</th>
										<c:if test="${MemberAge == -1}" >
											<td class="small-content-span-2">미입력</td>
										</c:if>
										<c:if test="${MemberAge != -1}" >
											<td class="small-content-span-2">
												만 ${MemberAge }세
											</td>											
										</c:if>
										<th class="small-content-span-1">주소</th>
										<c:if test="${empty MemberDTO.getMember_addr()}" >
											<td class="small-content-span-2">미입력</td>
										</c:if>
										<c:if test="${!empty MemberDTO.getMember_addr()}" >
											<td class="small-content-span-2">${MemberDTO.getMember_addr() }</td>
										</c:if>
									</tr>
									
								</table>
							</div>
						</div>
						<br>
						<div id="info-channel-card">
							<div id="info-channel-card-title">
								<span class="small-title-span">채널</span>
								<span class="small-span" onclick="location.href='setting_channel.do'" style="cursor: pointer;">채널 관리<i class="bi bi-chevron-double-right"></i></span>
							</div>
							<hr>
							<div id="info-channel-card-content">
								<table id="info-channel-table">
									<tr>
										<td rowspan="4" style="width:20%;">
											<!-- 사용자가 프로필 사진 바꾸면 유동값으로 줘야함 -->
											<img src="<%=request.getContextPath() %>/resources/img/channel_profile/${ChannelDTO.getChannel_profil()}" class = "channel-backcolor">
										</td>
									</tr>
									<tr>
										<th class="small-content-span-1">대표채널</th>
										<td colspan="3" class="small-content-span-2">${ChannelDTO.getChannel_name() } </td>
									</tr>
									<tr>
										<th class="small-content-span-1">구독자</th>
										<td class="small-content-span-2">${ChannelLike}명</td>
										<th class="small-content-span-1">동영상</th>
										<td class="small-content-span-2">${VideoCount }개</td>
									</tr>
									<tr>
										<c:if test="${!empty ChannelDTO.getChannel_cont() }" >
											<td colspan="4" class="small-content-span-2">${ChannelDTo.getChannel_cont() }</td>
										</c:if>
										<c:if test="${empty ChannelDTO.getChannel_cont() }" >
											<td colspan="4" class="small-content-span-2">채널 설명이 없습니다.</td>
										</c:if>
									</tr>
								</table>
							</div>
							
						</div>
					<br>
						<div id="info-card-wrap-bottom">
							<div id="info-protect-card">
								<div id="info-protect-card-title">
									<span class="small-title-span">계정 보안</span>
								</div>
								<hr>
								<div id="info-protect-card-content">
									<div class="card-in-card" id="email-protect-card" onclick="location.href='setting_protect.do'">
										<div><span class="small-content-span-1">이메일 로그인 설정</span></div>
										<div style="display: flex; align-items: center;">
											<div>
											<img src="<%=request.getContextPath() %>/resources/img/protect.png" width="80px">
											</div>
											<div>
											<span class="small-content-span-2">로그인 할 때마다 이메일 인증을 사용하여 계정 보안을 강화합니다.</span>
											</div>
										</div>
									</div>
									<div class="card-in-card" id="login-history-card" onclick="location.href='setting_login_history.do'">
										<div><span class="small-content-span-1">로그인 기록</span></div>
										<div style="display: flex; align-items: center;">
										<div><img src="<%=request.getContextPath() %>/resources/img/login_history.png" width="80px"></div>
										<div><span class="small-content-span-2">로그인 기록을 열람하고 관리합니다.</span></div>
										</div>
									</div>
								</div>
							</div>
							<div id="info-premium-card">
								<div id="info-premium-card-title">
									<span class="small-title-span">비디비디 프리미엄</span>
								</div>
								<hr>						
								<div id="info-premium-card-content">
									<div class="card-in-card" id="premium-card">
										<div><span class="small-content-span-1">결제 관리</span></div>
										<div style="display: flex; align-items: center;">
											<div><img src="<%=request.getContextPath() %>/resources/img/premium.png" width="80px"></div>
											<div><span class="small-content-span-2">비디비디 프리미엄을 결제하고 광고 없이 편안한 영상을 만나보세요.</span></div>
										</div>
									</div>
									<div class="card-in-card" id="credit-hitory-card">
										<div><span class="small-content-span-1">결제 내역</span></div>
										<div style="display: flex; align-items: center;">
											<div><img src="<%=request.getContextPath() %>/resources/img/card_history.png" width="80px"></div>
											<div><span class="small-content-span-2">결제 내역을 관리합니다.</span></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>