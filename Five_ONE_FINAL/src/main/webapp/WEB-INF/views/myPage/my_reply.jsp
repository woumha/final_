<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

function getContextPath(){
	
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}

let RepChannelCode = "${RepChannelCode}";
let loading = false;
let page = 1;

function getReply_list(page){

	$.ajax({

		url : getContextPath() +"/getMy_reply_list.do",
		data : {
			"page" : page
		},
		datatype : 'JSON',
		contentType : "application/json; charset=UTF-8",
		success : function(data){
			
			let str = data;

			if(str == "[]"){
				
				loading = false;
				
			}else{
				console.log("data >>> " + data);
				
				let reply_div = JSON.parse(data);
				
				let div = "";
				
				div += "<div class='video_boxs'>";
				
				
				
				$(reply_div).each(function(){
					
					div += "<div class='reply_box'>";
					div += "<div class='delete_reply'>";
					div += "<form method='post' action='<%=request.getContextPath()%>/my_reply_delete.do'>";
					div += "<input type='hidden' name='reply_code' value='"+this.reply_code+"'>";					
					div += "<input type='hidden' name='reply_group' value='"+this.reply_group+"'>";										
					div += "<input type='image' class='video_d_img' src='"+getContextPath()+"/resources/img/x.png'>";
					div += "</form>";
					div += "</div>";
					div += "<div class='reply_text_box'>";
					div += "<div class='reply_cont'>"+this.reply_cont+"</div>";
					div += "<a href='"+getContextPath()+"/watch.do?video_code="+this.video_code+"'>";
					div += "<div class='video_title'>"+this.video_title+"</div>";
					div += "</a>";
					div += "<div class='video_title_sub'>에 남긴 댓글</div>";
					div += "<div class='reply_regdate'>"+this.reply_regdate+"</div>";
					div += "</div>";
					div += "<div class='video_img_box'>";
					div += "<img class='video_img' src='"+getContextPath()+"/resources/AllChannel/"+this.video_owner+"/thumbnail/"+this.video_img+"'>";
					div += "</div>";
					div += "</div>";
					div += "<hr class='reply_line'>";
					
				});
				
				div += "</div>";
				
				loading = true;
				$("#ajax_area").append(div);
			}
		},
		error : function(){
			
		}
	});
}

function getReply_delete_list(page, code, group, comment){
	console.log("code >>> " + code);
	$.ajax({

		url : getContextPath() +"/delete_one_my_reply.do",
		data : {
			"page" : page,
			"reply_code" : code,
			"reply_group" : group,
			"reply_comment" : comment
		},
		datatype : 'JSON',
		contentType : "application/json; charset=UTF-8",
		success : function(data){
			
			let str = data;

			if(str == "[]"){
				
				loading = false;
				
			}else{
				
				let reply_div = JSON.parse(data);
				
				let div = "";
				
				div += "<div class='video_boxs'>";
				
				$(reply_div).each(function(){
					
					div += "<div class='reply_box'>";
					div += "<div class='delete_reply'>";
					div += "<form method='post' action='<%=request.getContextPath()%>/my_reply_delete.do'>";
					div += "<input type='hidden' name='reply_code' value='"+this.reply_code+"'>";					
					div += "<input type='hidden' name='reply_group' value='"+this.reply_group+"'>";										
					div += "<input type='image' class='video_d_img' src='"+getContextPath()+"/resources/img/x.png'>";
					div += "</form>";
					div += "</div>";
					div += "<div class='reply_text_box'>";
					div += "<div class='reply_cont'>"+this.reply_cont+"</div>";
					div += "<a href='"+getContextPath()+"/watch.do?video_code="+this.video_code+"'>";
					div += "<div class='video_title'>"+this.video_title+"</div>";
					div += "</a>";
					div += "<div class='video_title_sub'>에 남긴 댓글</div>";
					div += "<div class='reply_regdate'>"+this.reply_regdate+"</div>";
					div += "</div>";
					div += "<div class='video_img_box'>";
					div += "<img class='video_img' src='"+getContextPath()+"/resources/AllChannel/"+this.video_owner+"/thumbnail/"+this.video_img+"'>";
					div += "</div>";
					div += "</div>";
					div += "<hr class='reply_line'>";
				});
				
				div += "</div>";
				
				loading = true;
				$("#ajax_area").append(div);
			}
		},
		error : function(){
			
		}
	}); 
}


function reply_delete(code, group, comment) {
	page = 1;
	console.log("삭제 함수 code >>> " + code);
	console.log("삭제 함수 group >>> " + group);
	console.log("삭제 함수 comment >>> " + comment);
	getReply_delete_list(page, code, group, comment);
}

// 기본 실행 함수
getReply_list(page);	

// 무한 스크롤
$(window).scroll(function(){
	if($(window).scrollTop()>=$(document).height() - $(window).height()){

		if(loading == true){
			page++;
			getReply_list(page);
		}
	}
}); //scroll end


</script>
</head>
<body>

<div id="wrap_myPage">
<!-- top, side 영역 -->
<jsp:include page="../include/top_include.jsp"/>
<jsp:include page="../include/side_include.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/myPage_CSS/my_reply.css">

<div id="content_box">

<div class="">
	<!-- 작성한 댓글 영역 -->
	<c:if test="${!empty RepChannelCode }">
	<div id="my_reply_title"><p><i class="fa-solid fa-comment"></i>&nbsp;&nbsp;댓글 목록</p></div>

	<div id="ajax_area"></div>
	
	<div id="reply_end">더 이상 표시할 콘텐츠가 없습니다.</div>
	
	</c:if>
	<!-- 로그인 안했을 시 -->
	<c:if test="${empty RepChannelCode }">
		<div id="page_none">
			<img id="none_img" src="${pageContext.request.contextPath}/resources/img/subscribe.png">
			<p id="none_title">자신의 감상이나 남기고 싶은 말을 작성해보세요.</p>
			<p id="none_text">댓글을 작성하거나 편집을 원하시면 로그인하세요.</p>
			<button id="none_btn" onclick="location.href='<%=request.getContextPath() %>/login.do'">로그인</button>
		</div>
	</c:if>

</div> <!-- "." end -->

</div> <!-- "#content_box" end -->

</div> <!-- "#wrap_myPage" end -->
</body>
</html>