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


$(function(){
	
	if ('${MemberCode}' != ''){
		let channelCode = '${MemberDTO.getMember_rep_channel()}';
		let memberCode = '${MemberCode}';
		changeBackColor(channelCode);
		getChannelList(memberCode);
	}
	
	naviCSS();
	
});



</script>
<style type="text/css">
	html, body, #info-page-wrap {
		height: 100%;
	}
	
	#info-wrap-bottom{
		height: 90%;
	}

	#setting-channel-content {
		display: grid;
		width: 48%;
		margin: auto;
		height: 80%;
		grid-template-columns: 1fr 1fr;
		gap: 20px 20px;
	}
	
	.channel-card {
		width: 100%;
		height: 260px;
		border: 1px solid lightgray;
		border-radius: 10px;
		display: inline-block;
	}
	
	.channel-card-banner {
		width: 100%;
		height: 60%;
	}
	
	.channel-card figure {
		position: relative;	
		height: 100%;
	}
	
	.channel-card-banner figure figcaption {
		padding: 10px;
		position: absolute;
		bottom: 1px;
		color: white;
		font-weight: 400;
		font-size: 1.2em;
	}
		
	.channel-card-banner img {
		display: block;
		position: relative;
		z-index: -1;
		border-top-left-radius: 10px;
    	border-top-right-radius: 10px;
	}
	
	.channel-card-content {
		border-top: 1px solid lightgray;
		padding:10px;
	}
	
	.channel-card-content-top {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.channel-card-content-top button {
		height: 35px;
		color: rgb(50, 50, 50);
		border: 1px solid lightgray;
		border-radius: 10px;
		background-color: rgb(240, 240, 240);
	}
	.channel-card-content-top button:hover {
		cursor: pointer;
	}
	
	#channel-add {
		display: flex;
		align-items: center;
		background-color: white;
		cursor: pointer;
	}
	
	#channel-add:hover {
		filter: brightness(0.6) contrast(5);
	}
	
	#channel-add div{
		margin: auto;
		text-align: center;
	}
	
	img.channel-add-content{
		filter: opacity(0.1);
		display: block;
		margin: auto;
	}
	
	span.channel-add-content {
		display: inline-block;
		margin: 10px;
		color: lightgray;
	}
	
	img.channel-ribbon-icon {
		position: absolute; 
		top:10px; 
		right: 5px; 
		width:50px;
		cursor: pointer;
		z-index: 999;
	}
	
	img.channel-ribbon-icon.general {
		filter: opacity(0.3);
	}
	
	img.channel-ribbon-icon.general:hover {
		filter: opacity(0.3) brightness(1.8);
	}
	
	button.channel-card-btn {
		color: white;
		background-color: #fc942c;
	}
	
	button.channel-card-btn:hover {
		filter: brightness(1.1);
	}
	
	button.channel-card-btn:focus {
		outline: none;
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
							<li onclick="location.href='setting_profile.do'" id="info-menu-1" class="navi-not-page">프로필</li>
							<li onclick="location.href='setting_channel.do'" id="info-menu-2" class="navi-this-page info-navi-selected">채널</li>
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
						<h4>채널</h4>
						<hr>
						<span>채널을 추가하거나 삭제하고, 대표채널을 변경합니다.</span>
						<br>
						<span>채널을 관리하려면 관리 페이지로 이동하세요.</span>
					</div>
					<div id="setting-channel-content">
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>