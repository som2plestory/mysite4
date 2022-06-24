<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="aside">
		<h2>회원</h2>
		<ul>
			<c:choose>
				<c:when test="${empty authUser}">
					<li><a href="./loginForm">로그인</a></li>
					<li><a href="./joinForm">회원가입</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="./modifyForm">회원정보수정</a></li>	
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
	<!-- //aside -->

</body>
</html>