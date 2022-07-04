<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYSITE- 게시판 글 수정</title>
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
					<div id="modifyForm">
						<form action="${pageContext.request.contextPath}/board/modify?no=${boardVo.no}" method="post">
							<!-- 작성자 -->
							<div class="form-group">
								<span class="form-text">작성자</span>
								<span class="form-value">${boardVo.name}</span>
							</div>
							
							<!-- 조회수 -->
							<div class="form-group">
								<span class="form-text">조회수</span>
								<span class="form-value">${boardVo.hit}</span>
							</div>
							
							<!-- 작성일 -->
							<div class="form-group">
								<span class="form-text">작성일</span>
								<span class="form-value">${boardVo.regDate}</span>
							</div>
							
							<!-- 제목 -->
							<div class="form-group">
								<label class="form-text" for="txt-title">제목</label>
								<input type="text" id="txt-title" name="title" 
								<c:choose>
									<c:when test="${modify == 'Fail' && writeVo.title != ''}">
										value="${writeVo.title}"
									</c:when>
									<c:otherwise>
										value="${boardVo.title}"
									</c:otherwise>
								</c:choose>
								placeholder="변경할 제목을 입력해주세요.">
							</div>
						
							<!-- 내용 -->
							<div class="form-group">
								<textarea id="txt-content" name="content" placeholder="변경할 내용을 입력해주세요."><c:choose><c:when test="${modify == 'Fail' && writeVo.content != ''}">${writeVo.content}</c:when><c:otherwise>${boardVo.content}</c:otherwise></c:choose></textarea>
							</div>
							<span class="bold" style="color:#FF0000;">
								<c:if test="${modify == 'Fail'}">게시글 수정 실패: 제목 또는 내용이 입력되지 않았습니다.(입력되지 않은 경우 기존 게시글의 정보를 불러옵니다.)</c:if>
							</span>	
							<a id="btn_cancel" href="${pageContext.request.contextPath}/board">취소</a>
							<button id="btn_modify" type="submit" >수정</button>
							
							
						</form>
						<!-- //form -->
					</div>
					<!-- //modifyForm -->
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