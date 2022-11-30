<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:set var="list" value="${Test }" />

<table>
	<tr>
		<th>TEST1컬럼</th>
		<th>TEST2컬럼</th>
	</tr>
	<c:forEach items="${list}" var="dto">
		<tr>
			<td>${dto.getTest1() }</td>	
			<td>${dto.getTest2() }</td>	
		</tr>
	</c:forEach>
</table>

</body>
</html>