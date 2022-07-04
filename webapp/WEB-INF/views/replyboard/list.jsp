<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYSITE: 댓글게시판</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/board.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<!-- //header -->

		<div id="container" class="clearfix">
			
			<c:import url="/WEB-INF/views/includes/aside/board.jsp"></c:import>
			<!-- //aside -->

			<div id="content">

				<div id="content-head">
					<h3>게시판</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>게시판</li>
							<li class="last">일반게시판</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->
	
				<div id="board">
					<div id="list">
						<form action="${pageContext.request.contextPath}/board/list/" method="get">
							<div class="form-group text-right">
								<input type="text" name="keyword" value="">
								<button type="submit" id=btn_search>검색</button>
							</div>
						</form>
						<table >
							<colgroup>
							<col style="width: 8%;">
							<col style="width: 38%;">
							<col style="width: 12%;">
							<col style="width: 12%;">
							<col style="width: 19.5%;">
							<col style="width: 10.5%;">
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>글쓴이</th>
									<th>조회수</th>
									<th>작성일</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${boardList}" var="boardVo">
									<tr>
										<td>${boardVo.no}</td>
										<td class="text-left"><a href="./read?no=${boardVo.no}">${boardVo.title}</a></td>
										<td>${boardVo.name}</td>
										<td>${boardVo.hit}</td>
										<td>${boardVo.regDate}</td>
										<c:if test="${authUser.no == boardVo.userNo}">
											<td><a href="./delete?no=${boardVo.no}">[삭제]</a></td>
										</c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
			
						<div id="paging">
							<input type="hidden" name="action" value="">
							<ul>
								<li><a href="">◀</a></li>
								<li <c:if test = "${pageStart%10 == 1}">class="active"</c:if>>
									<a href="">${pageStart}</a>
								</li>
								<li <c:if test = "${(pageStart+1)%10 == 2}">class="active"</c:if>>
									<a href="">${pageStart+1}</a>
								</li>
								<li <c:if test = "${(pageStart+2)%10 == 3}">class="active"</c:if>>
									<a href="">${pageStart+2}</a>
								</li>
								<li <c:if test = "${(pageStart+3)%10 == 4}">class="active"</c:if>>
									<a href="">${pageStart+3}</a>
								</li>
								<li <c:if test = "${(pageStart+4)%10 == 5}">class="active"</c:if>>
									<a href="">${pageStart+4}</a>
								</li>
								<li <c:if test = "${(pageStart+5)%10 == 6}">class="active"</c:if>>
									<a href="">${pageStart+5}</a>
								</li>
								<li <c:if test = "${(pageStart+6)%10 == 7}">class="active"</c:if>>
									<a href="">${pageStart+6}</a>
								</li>
								<li <c:if test = "${(pageStart+7)%10 == 8}">class="active"</c:if>>
									<a href="">${pageStart+7}</a>
								</li>
								<li <c:if test = "${(pageStart+8)%10 == 9}">class="active"</c:if>>
									<a href="">${pageStart+8}</a>
								</li>
								<li <c:if test = "${(pageStart+9)%10== 10}">class="active"</c:if>>
									<a href="">${pageStart+9}</a>
								</li>
								<li><a href="">▶</a></li>
							</ul>
							
							
							<div class="clear"></div>
						</div>
						<c:if test="${!empty authUser}">
							<a id="btn_write" href="./writeForm">글쓰기</a>
						</c:if>
					</div>
					<!-- //list -->
				</div>
				<!-- //board -->
			</div>
			<!-- //content  -->

		</div>
		<!-- //container  -->
		

		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		<!-- //footer -->
	</div>
	<!-- //wrap -->

</body>

</html>