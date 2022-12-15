<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIDIVIDI SEARCH</title>

<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- 스타일 시트 -->
<link rel="stylesheet" href="${path }/resources/eunji_CSS/search.css">	

</head>
<body>

<%-- <c:set var="list" value="${Search }" /> --%>

<div id="all_content">

<%-- 검색 필드 include 영역 --%>
	<div id="top_wrap">
		<jsp:include page="../include/top_include.jsp"/>
	</div>

<%-- 사이드바 영역 --%>
	<div id="side_wrap">
		<div id="sidebar">
			<jsp:include page="../include/side_include.jsp"/>
		</div>
	</div>
	

<%-- 검색 페이지 출력 영역 --%>
	<div id="search_result"></div>
	
</div> <!-- 전체 div end -->
	
	<input type="hidden" value="${keyword }" id="keyword" >
	<input type="hidden" value="${field }" id="field" >
	
</body> 


<script type="text/javascript">
/*-----------------------------------------------------검색결과 인기순 ajax----------------------------------------------------------------  */

let keyword = $("#keyword").val();
let field = $("#field").val();

console.log("필드값>>>" + field);
console.log("키워드값>>>" + keyword);

 
function getSearchVideoList_popular(keyword, field){
	
	console.log("ajax 실행");
	
	$.ajax({
		url : "search_result.do",
		type: "post",
		data : {
			field : field,
			keyword : keyword
		},
		success: function(data){
			
			console.log("ajax실행");
			
			var table = "";
			
			table += "<table id='search_table'>"
			
			$(data).each(function(){
			
			table += "<tr>";
			table += "<td colspan='2'>" + "<video width='320px' height='180px' src='https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4' controls></video>" + "</td>"
			table += "<td id = 'video_title'>" + this.video_title + "</td>";
			table += "<td id = 'video_channel'>" + this.channel_name + "</td>";
			table += "<td id = 'video_view_ctn'>" + '조회수&nbsp;: &nbsp;' + this.video_view_cnt + "&nbsp; &nbsp;" + this.video_regdate + "</td>";
			table += "</tr>";
			
			}); //each end
			
			table += "</table>";
			
			$("#search_result").html(table);			
			
		},
		
		error: function(){
			console.log(data);
			alert("검색 비디오 리스트 ajax 오류입니다.");
			
		}
	});
}

getSearchVideoList_popular(keyword, field);



/*-----------------------------------------------------검색결과 최신순 ajax----------------------------------------------------------------  */

</script>

</html>