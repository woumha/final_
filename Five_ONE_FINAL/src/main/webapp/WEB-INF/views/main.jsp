<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8" %>
<html>
<head>
	<title>MAIN</title>
</head>

<link rel="stylesheet" href="/css/main_css.css" type="text/css">

<body align="center">

<jsp:include page="./include/top_include.jsp"/>

<div id="container">

	<div id="navbar">
        <nav class="nav">
            <div>
                <div class="side_nav">
                    <h4> test </h4>
                </div>
			</div>
		</nav>
	</div>


<video src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video>
</div>

<form method="post" enctype="multipart/form-data" action="<%= request.getContextPath()%>/upload.do">
	<input type="file" name="file1">
	<input type="submit" value="전송">
</form>



<a href="<%=request.getContextPath() %>/DBtest.do">[DB테스트 페이지]</a>

<a href="<%=request.getContextPath() %>/channel.do">채널</a>

</body>
</html>
