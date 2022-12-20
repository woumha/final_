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
	/* $(function(){
		
		$("#channel-add").mouseover(function(){
			$(this).find('img').addClass('hover-filter');
			$(this).find('span').addClass('hover-color');
		});
		
		$("#channel-add").mouseout(function(){
			$(this).find('img').removeClass('hover-filter');
			$(this).find('span').removeClass('hover-color');
		});
		
	});  */

</script>

</head>
<body>
	<c:forEach items="${ChannelList }" var="dto" varStatus="status">
		<div class="channel-card">
			<input id="hidden-code-${status.count }" type="hidden" name="channel_code" value="${dto.getChannel_code() }">
			<div class="channel-card-banner">
				<figure>
					<img id="channel-banner-${status.count }" src="<%=request.getContextPath() %>/resources/img/channel_banner/${dto.getChannel_banner()}" style="border-radius: 10px; width: 100%; height: 120%;">
					<figcaption>${dto.getChannel_name() }</figcaption>
				</figure>
			</div>
			<div class="channel-card-content">
				<div class="channel-card-content-top">
					<img id="channel-profile-${status.count }" src="<%=request.getContextPath() %>/resources/img/channel_profile/${dto.getChannel_profil()}" style="border-radius:100%; width:15%;">
					<input type="button" value="채널 관리" onclick="location.href='<%=request.getContextPath()%>/channel_manager.do?code=${dto.getChannel_code() }'">
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
</body>
</html>