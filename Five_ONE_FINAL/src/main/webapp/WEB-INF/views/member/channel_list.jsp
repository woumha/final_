<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<!-- member js -->
<script src="${path}/resources/member/member_js.js"></script>
<script type="text/javascript">

function newChannel(code){
	
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	});
	
	$.ajax({
		url : '<%=request.getContextPath()%>/newChannel.do',
		data: { member_code : code },
		dataType: "text",
		success : function(data) {
			if (data == "success") {
				toastr.success("채널이 추가되었습니다.");
				getChannelList(code);
			}else if(data == "fail"){
				toastr.error("채널 추가 실패!");
			}
			
		},
		error : function(){
			toastr.error('데이터 통신 오류. 로그인 세션이 만료되었는지 확인하세요.');
		}
	});
	
}

function deleteChannel(mem_code, chan_code){
	
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	});
	
	$.ajax({
		url : '<%=request.getContextPath()%>/delete_channel.do',
		data: { 
			member_code : mem_code,
			channel_code : chan_code
		},
		dataType: "text",
		success : function(data) {
			if (data == "success") {
				toastr.success("채널이 삭제되었습니다.");
				getChannelList(mem_code);
			}else if(data == "fail"){
				toastr.error("채널 삭제 실패!");
			}else if (data == "essential"){
				toastr.error("1개 이상의 채널은 필수입니다.", "채널 삭제 실패!");
			}
		},
		error : function(){
			toastr.error('채널 삭제 ajax 오류. 채널 코드를 확인하세요.');
		}
	});
	
}


function alreadyRep(){
	toastr.error('이미 대표채널입니다.', '대표채널을 변경할 수 없습니다.');
}


function changeRep(code){
	
	let channel_member_code = '${MemberDTO.getMember_code()}';
	
	$.ajax({
		url : '<%=request.getContextPath()%>/change_rep_channel.do',
		data : {
			channel_code : code,
			member_code : channel_member_code
		},
		success : function(data){
			if(data == 'success'){
				toastr.success('대표채널이 변경되었습니다.');
				getChannelList(channel_member_code);
			}else {
				toastr.error('대표채널이 변경에 실패했습니다.');
			}
		},
		error : function(){
			toastr.error('대표채널 변경 통신 오류');
		}
	});
}



$(function(){
	
	toastrSetup();
	
	$("#channel-add").on('click', function(){
		if ('${MemberDTO.getMember_code()}' != ''){
			newChannel('${MemberDTO.getMember_code()}');
		}
	});
	
	let clickedChannelCode;
	
	$(".channel-delete-btn").on('click', function(){
		modalShow();
		clickedChannelCode = $(this).val();
		console.log(clickedChannelCode);
		console.log('${MemberDTO.getMember_rep_channel()}');
	});
	
	$("#channel-delete-confirm-btn").on('click', function(){
		modalHide();
		if (clickedChannelCode != '${MemberDTO.getMember_rep_channel()}'){
			deleteChannel('${MemberDTO.getMember_code()}', clickedChannelCode);
		}else if (clickedChannelCode == '${MemberDTO.getMember_rep_channel()}'){
			toastr.error("대표 채널은 삭제할 수 없습니다.");
		}
		
	});
});

</script>
</head>
<body>
	<c:forEach items="${ChannelList }" var="dto" varStatus="status">
		<div class="channel-card">
			<input id="hidden-code-${status.count }" type="hidden" name="channel_code" value="${dto.getChannel_code() }">
			<div class="channel-card-banner">
				<figure>
					<img id="channel-banner-${status.count }" src="<%=request.getContextPath() %>/resources/img/channel_banner/${dto.getChannel_banner()}" style="width: 100%; height: 100%;" alt="채널 배너">
					<figcaption onclick="location.href='<%=request.getContextPath()%>/channel.do?mc=${dto.getChannel_code()}'" style="cursor: pointer;">${dto.getChannel_name() }</figcaption>
					<c:if test="${dto.getChannel_code() == MemberDTO.getMember_rep_channel()}">
						<img src="<%=request.getContextPath() %>/resources/img/rep_channel.png" class="channel-ribbon-icon rep" onclick="alreadyRep()" alt="대표 채널">
					</c:if>
					<c:if test="${dto.getChannel_code() != MemberDTO.getMember_rep_channel()}">
						<img src="<%=request.getContextPath() %>/resources/img/general_channel.png" class="channel-ribbon-icon general" alt="대표채널 변경" onclick="changeRep('${dto.getChannel_code()}')">
					</c:if>
				</figure>
			</div>
			<div class="channel-card-content">
				<div class="channel-card-content-top">
					<img onclick="location.href='<%=request.getContextPath()%>/channel.do?mc=${dto.getChannel_code()}'" id="channel-profile-${status.count }" src="<%=request.getContextPath() %>/resources/img/channel_profile/${dto.getChannel_profil()}" style="border-radius:100%; width:15%; cursor: pointer;" alt="채널 프로필 사진">
					<div>
						<button class="channel-card-btn" onclick="location.href='<%=request.getContextPath() %>/channel_manager.do?code=${dto.getChannel_code()}'">관리</button>
						<button class="channel-card-btn channel-delete-btn" value="${dto.getChannel_code() }">삭제</button>
					</div>
				</div>
				<div class="channel-card-content-bottom">
					<c:if test="${empty dto.getChannel_cont() }">
						<span class="small-content-span-2">채널 소개가 없습니다.</span>
					</c:if>
					<c:if test="${!empty dto.getChannel_cont() }">
						<span class="small-content-span-2">${dto.getChannel_cont() }</span>
					</c:if>
				</div>
			</div>
		</div>
		
		<script>
			let channelBanner = document.getElementById("channel-banner-${status.count}");
			let channelProfile = document.getElementById("channel-profile-${status.count}");
			channelBanner.onload = function(){
				let channelCode = document.getElementById("hidden-code-${status.count}").value;
				
				console.log(document.getElementById("hidden-code-${status.count}").value);
				console.log(channelCode.charAt(3));
			
				
				switch(channelCode.charAt(3)){
					case '1' :
						channelBanner.style.backgroundColor="DarkSalmon";
						channelProfile.style.backgroundColor="DarkSalmon";
					break;
					
					case '2' :
						channelBanner.style.backgroundColor="HotPink";
						channelProfile.style.backgroundColor="HotPink";
					break;
					
					case '3' :
						channelBanner.style.backgroundColor="IndianRed";
						channelProfile.style.backgroundColor="IndianRed";
					break;
					
					case '4' :
						channelBanner.style.backgroundColor="lightpink";
						channelProfile.style.backgroundColor="lightpink";
					break;
					
					case '5' :
						channelBanner.style.backgroundColor="Teal";
						channelProfile.style.backgroundColor="Teal";
					break;
					
					case '6' :
						channelBanner.style.backgroundColor="RoyalBlue";
						channelProfile.style.backgroundColor="RoyalBlue";
					break;
					
					case '7' :
						channelBanner.style.backgroundColor="Turquoise";
						channelProfile.style.backgroundColor="Turquoise";
					break;
					
					case '8' :
						channelBanner.style.backgroundColor="MediumPurple";
						channelProfile.style.backgroundColor="MediumPurple";
					break;
					
					case '9' :
						channelBanner.style.backgroundColor="Wheat";
						channelProfile.style.backgroundColor="Wheat";
					break;
				
					case '0' :
						channelBanner.style.backgroundColor="SeaGreen";
						channelProfile.style.backgroundColor="SeaGreen";
					break;
					default:
						channelBanner.style.backgroundColor="#fc942c";
						channelProfile.style.backgroundColor="#fc942c";
					break;
				} 
			}		
		</script>
	</c:forEach>
	
	<div class="channel-card" id="channel-add">
		<div>
			<img class="channel-add-content" src='<%=request.getContextPath() %>/resources/img/plus.png' alt="채널 추가" style="width:50%;">
			<span class="channel-add-content">채널 추가</span>
		</div>
	</div>
	
	<div class="member-modal">
		<div class="member-modal-body">
			<div class="member-modal-title member-alert">
				<span>정말 채널을 삭제할까요?</span>
			</div>
			<hr>
			<div class="member-modal-content member-alert">
				<span>채널의 모든 내용이 삭제됩니다.</span>
				<br>
				<input type="button" value="확인" id="channel-delete-confirm-btn">
				<input type="button" value="취소" class="member-emp" onclick="modalHide()">
			</div>
		</div>
	</div>
</body>
</html>