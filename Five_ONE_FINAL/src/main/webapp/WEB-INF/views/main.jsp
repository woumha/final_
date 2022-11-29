<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8" %>
<html>
<head>
	<title>MAIN</title>
</head>
<body align="center">
MAINㅇㅇㅇㅇ~~~!! test용

<video src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls>
</video>

<form method="post" enctype="multipart/form-data" action="<%= request.getContextPath()%>/upload.do">
	<input type="file" name="file1">
	<input type="submit" value="전송">
</form>

</body>
</html>
