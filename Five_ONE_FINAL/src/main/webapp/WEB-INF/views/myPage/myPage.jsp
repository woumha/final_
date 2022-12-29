<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>

<!-- 아이콘 관련 링크 -->
<script src="https://kit.fontawesome.com/ccf3e996b8.js" crossorigin="anonymous"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>

<script type="text/javascript">
$(document).on("mouseover", ".test_video", function(){
	 $(this).get(0).play();
});

$(document).on("mouseout", ".test_video", function(){
	 $(this).get(0).pause();
});	

function getContextPath(){
	let path = location.href.indexOf(location.host)+location.host.length;
	return location.href.substring(path, location.href.indexOf('/', path+1));
}

/* 넘어온 기본 값 */
let RepChannelCode = "${RepChannelCode}";
let page = 1;
let loading = true;

/* 재생목록 ajax */
function getPlaylist_list(page){
	
	let channel_name = '${m_channel.getChannel_name() }';
	console.log("channel_name >>> " + channel_name);
	
	$.ajax({
		url : getContextPath() +"/getPlaylist_list.do",
		data : {
			"page" : page,
		},
		datatype : 'JSON',
		contentType : "application/json; charset=UTF-8",
		success : function(data){
			
			let str = data;

			if(str == "[]"){
				loading = false;
				
				console.log("걸러짐");
				
			}else{
				let playlist = JSON.parse(data);
				let div = "";
				
				console.log("data >>> " + data);
				console.log("good >>> " + playlist);
				$(playlist).each(function(){
					div += "<div class='video_box'>";
					div += "<div class='playlist_video_div'>";
					div += "<a href='"+getContextPath()+"/playlist_list.do?playlist_code="+this.playlist_code+"'>";					
					div += "<div class='playlist_lid'>";
					
					div += "<p class='p_playlist_lid'>재생목록 보기</p>";
					div += "<img class='playlist_lid_img' src='"+getContextPath()+"/resources/img/playlist_lid1.png'>";
					div += "</div>";
					
					div += "<video class='video_play' src='"+getContextPath()+"/resources/AllChannel/"+this.channel_code+"/"+this.video_title+".mp4' controls></video>";
					div += "</div>";
					div += "<p class='video_title_p' style='margin-top: 5px;'>"+this.playlist_title+"<p>";
					div += "</a>";
					div += "<p class='video_channel_p'>"+channel_name+"<p>" ;
					div += "</div>";
					
				});
				console.log("playlist >>> " + playlist);
				$("#playlist_area").append(div);
				
			}
		},
		error : function(){
			let div = "";
			
			div +="<div>저장한 재생목록이 여기에 표시됩니다.</div>";
			$("#playlist_area").append(div);
			
		}
	}); 
};

// 기본 실행 함수
console.log("기본 함수 진입!!!!");
getPlaylist_list(page);

// 재생목록 더보기 클릭시
$(document).on("click", "#playlist_more", function(){
	if(loading == true) {
		page++;
		console.log("재생목록 더보기 실행");
		getPlaylist_list(page);
	}else if(loading == false) {
		$("#playlist_more").css('display', 'none');
	}
});
</script>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/myPage_CSS/myPage.css">
</head>
<body>

<div id="wrap_myPage">

	<!-- top, side 영역 -->
	<jsp:include page="../include/top_include.jsp"/>
	<jsp:include page="../include/side_include.jsp"/>

	
	

	<c:if test="${!empty RepChannelCode }">
	<!-- 오른쪽 사이드 채널 정보 영역 -->
	<div id="chanel_area">
		<div id="profile_box">
			<div id="profile_icon">
				<a href="<%=request.getContextPath() %>/channel.do?mc=${m_channel.getChannel_code() }">
					<img src="${pageContext.request.contextPath}/resources/img/channel_profile/${m_channel.getChannel_profil() }">
				</a>
			</div>
			<div id="profile_name"> ${m_channel.getChannel_name() } </div>
		</div>
		
		<div id="profile_info">
			<hr class="channel_hr">
			<div class="info_box">
				<div class="info_title"> <p>구독</p> </div>
				<div class="info_cont"> <p>${channel_sub}</p> </div>
			</div>
			
			<hr class="channel_hr">
			
			<div class="info_box">
				<div class="info_title"> <p>업로드</p> </div>
				<div class="info_cont"> <p>${fn:length(channel_video)}</p> </div>
			</div>
			
			<hr class="channel_hr">
			
			<div class="info_box">
				<div class="info_title"> <p>채널 생성일</p> </div>
				<div class="info_cont"> <p>${channel_regdate.substring(0,10)}</p> </div>
			</div>
		</div>
	</div>
	
	<!-- 중앙 메인컨텐츠 영역 -->
	<div id="content_area" class="area_style">
		
		<!-- [기록(시청한 동영상)] 박스 -->
		<c:set var="history" value="${h_list }" />
		<div id="history_box" class="content_box">
			<div class="content_title_box">
				<img id="history_logo" src="${pageContext.request.contextPath}/resources/img/history.png">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/history_list.do">기록</a> [${fn:length(h_list)}]</p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/history_list.do">모두보기</a></p>
			</div>
			
			<c:if test="${!empty history }">
				<c:forEach items="${history }" var="h_dto" begin="0" end="9" step="1">
					<div class="video_box">
						<a href='<%=request.getContextPath() %>/watch.do?video_code=${h_dto.getVideo_code() }'>
							<video class="test_video" src="<%=request.getContextPath() %>/resources/AllChannel/${h_dto.getChannel_code() }/${h_dto.getVideo_title() }.mp4" controls></video>
							<p class="video_title_p_his">${h_dto.getVideo_title() }</p>
						</a>
						
						<p class="video_channel_p">
							<a href="<%=request.getContextPath() %>/channel.do?mc=${h_dto.getChannel_code() }">
								<img class="channel_profil" src="${pageContext.request.contextPath}/resources/img/channel_profile/${h_dto.getChannel_profil() }">&nbsp;${h_dto.getChannel_name() }
							</a>
						</p>
						
						<p class="video_views_p">조회수 ${h_dto.getVideo_view_cnt() }회 <i class="fa-solid fa-carrot"></i> ${h_dto.getVideo_regdate() }<p>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty history }">
				<p class="p_none">시청했던 동영상이 여기에 표시됩니다.</p>
			</c:if>
		</div>
		
		<hr class="hr_style">
		
		<!-- [재생목록] 박스 -->
		<div id="playlist_box" class="content_box">
			<div class="content_title_box">
				<img id="playlist_logo" src="${pageContext.request.contextPath}/resources/img/playlist_lid.png">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/playlist_list.do">재생목록</a></p>
			</div>
			
			<c:set var="playlist" value="${p_list }" />
			<c:if test="${!empty playlist }">
			
				<div id="playlist_area"></div>
				<button id="playlist_more"><i class="fa-solid fa-caret-down"></i>&nbsp;더보기</button>
			</c:if>
			
			<c:if test="${empty playlist }">
				<p class="p_none">만들거나 저장한 재생목록이 여기에 표시됩니다.</p>
			</c:if>
		</div>
		
		<hr class="hr_style">
		
		<!-------------------------------------- [좋아요 표시한 동영상] 박스 -------------------------------------->
		<div id="good_box" class="content_box">
			<div class="content_title_box">
				<img id="good_logo" src="${pageContext.request.contextPath}/resources/img/good.png">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/good_list.do">좋아요 동영상</a> [${fn:length(g_list)}]</p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/good_list.do">모두보기</a></p>
			</div>
			
			<c:set var="good" value="${g_list }" />
			<c:if test="${!empty good }">
				<c:forEach items="${good }" var="g_dto" begin="0" end="4" step="1">
					<div class="video_box">
					<a href='<%=request.getContextPath() %>/watch.do?video_code=${g_dto.getVideo_code() }'>
						<video class="test_video" src="<%=request.getContextPath() %>/resources/AllChannel/${g_dto.getChannel_code() }/${g_dto.getVideo_title() }.mp4" controls></video>
						<p class="video_title_good">${g_dto.getVideo_title() }</p>
					</a>
					
					<p class="video_channel_p">
						<a href="<%=request.getContextPath() %>/channel.do?mc=${g_dto.getChannel_code() }">
							<img class="channel_profil" src="${pageContext.request.contextPath}/resources/img/channel_profile/${g_dto.getChannel_profil() }">&nbsp;${g_dto.getChannel_name() }
						</a>
					</p>
						<p class="video_views_p">조회수 ${g_dto.getVideo_view_cnt() }회 <i class="fa-solid fa-carrot"></i> ${g_dto.getVideo_regdate() }<p>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty good }">
				<p class="p_none">좋아요 누른 동영상이 여기에 표시됩니다.</p>
			</c:if>
		</div>
		<!-------------------------------------- [좋아요 표시한 동영상] 끝 -------------------------------------->
		
		<hr class="hr_style">

		<!-------------------------------------- [작성한 댓글 리스트] 박스 -------------------------------------->
		<div id="reply_box" class="content_box">
			<div class="content_title_box">
				<img id="reply_logo" src="${pageContext.request.contextPath}/resources/img/reply.png">
				<p class="content_title1"><a href="<%=request.getContextPath() %>/my_reply.do">작성한 댓글</a> [${fn:length(reply_list)}]</p>
				<p class="content_title2"><a href="<%=request.getContextPath() %>/my_reply.do">모두보기</a></p>
			</div>
			<c:set var="r_list" value="${reply_list }"  />
			<c:if test="${!empty r_list }">
				<c:forEach  var="r_dto" items="${r_list }" begin="0" end="4" step="1">
					<%-- <div class="reply_list">				
						<p class="reply_list_writer">${c_info.getChannel_name() }</p>
						<p class="reply_list_cont">${r_dto.getReply_cont() }</p>
						<c:if test="${r_dto.getReply_regdate() ne null }">
							<p class="reply_list_date">작성일 ${r_dto.getReply_regdate() }</p>
						</c:if>
					</div>
					 --%>
					<div class='reply_box'>
						<div class='reply_text_box'>
							<div class='reply_cont'>${r_dto.getReply_cont() }</div>
							<a href='<%=request.getContextPath() %>/watch.do?video_code=${r_dto.getVideo_code() }'>
								<div class='video_title'>${r_dto.getVideo_title() }</div>
							</a>
							<div class='video_title_sub'>에 남긴 댓글&nbsp;&nbsp;&nbsp;<span class="reply_regdate">${r_dto.getReply_regdate() }</span></div>
						</div>
						<div class='video_img_box'>
							<img class='video_img' src='<%=request.getContextPath() %>/resources/AllChannel/${r_dto.getVideo_owner() }/thumbnail/${r_dto.getVideo_img() }'>
						</div>
					</div>
					
					<hr class='reply_line'>
					
					
				</c:forEach>
			</c:if>
			<c:if test="${empty r_list }">
				<p class="p_none">작성한 댓글이 여기에 표시됩니다.</p>
			</c:if>
		</div>
	</div>
	</c:if>
	<c:if test="${empty RepChannelCode }">
		<div id="page_none">
			<img id="none_img" src="${pageContext.request.contextPath}/resources/img/myPage_no.jpg">
			<p id="none_title">좋아하는 동영상을 감상해 보세요.</p>
			<p id="none_text">저장하거나 좋아요 표시한 동영상을 보려면 로그인하세요.</p>
			<button id="none_btn" onclick="location.href='<%=request.getContextPath() %>/login.do'">로그인</button>
		</div>
	</c:if>
</div>
</body>
</html>