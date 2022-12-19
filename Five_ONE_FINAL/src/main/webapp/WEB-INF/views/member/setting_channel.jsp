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

function getChannelList(code){
	
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	});
	
	console.log('ajax로 보낼 멤버 코드 : '+code);
	
	$.ajax({
		url : '<%=request.getContextPath()%>/getChannelList.do',
		data: { member_code : code },
		dataType: "html",
		success : function(data) {
			$("#setting-channel-content").html(data);
		},
		error : function(){
			toastr.error('채널 목록 불러오기 실패!');
		}
	});
	
}


$(function(){
	
	if ('${MemberDTO.getMember_code()}' != ''){
		let channelCode = '${MemberDTO.getMember_rep_channel()}';
		let memberCode = '${MemberCode}';
		changeBackColor(channelCode);
		getChannelList(memberCode);
	}
	
	naviCss();
	
});



</script>
<style type="text/css">
	html, body, #info-page-wrap {
		height: 100%;
	}
	
	#info-wrap-bottom{
		height: 80%;
	}

	#setting-channel-content {
		display: grid;
		width: 50%;
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
	}
	
	.channel-card-content {
		border-top: 1px solid lightgray;
		padding:10px;
		background-color: white;
		position: relative;
		z-index: -1;
	}
	
	.channel-card-content-top {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.channel-card-content-top input[type=button] {
		height: 35px;
		color: rgb(50, 50, 50);
		border: 1px solid lightgray;
		border-radius: 10px;
		background-color: rgb(240, 240, 240);
		position: relative;
		z-index: 100;
	}
	.channel-card-content-top input[type=button]:hover {
		cursor: pointer;
	}
	
	#channel-add {
		display: flex;
		align-items: center;
		background-color: white;
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
					<div id="setting-channel-content">
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>