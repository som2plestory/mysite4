<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYSITE: 회원가입</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/user.css" rel="stylesheet" type="text/css">

</head>

<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<!-- //header -->

		<div id="container" class="clearfix">
			
			<c:import url="/WEB-INF/views/includes/aside/user.jsp"></c:import>
			<!-- //aside -->

			<div id="content">
			
				<div id="content-head">
					<h3>회원가입</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>회원</li>
							<li class="last">회원가입</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->
	
				<div id="user">
					<div id="joinForm">
						<form action="${pageContext.request.contextPath}/user/join" method="post">
							
							<div class="form-group">
								<span class="form-text"></span> 
								<c:choose>
									<c:when test="${userVo.password == '' || userVo.name == ''}">
										<span style="color:#FF0000;">회원가입 실패: *표시된 부분은 필수입니다.</span>
									</c:when>
									<c:otherwise>
										<span style="color:#0000FF;">*표시된 부분은 필수입니다.</span>
									</c:otherwise>
								</c:choose>
							</div>
							
							<!-- 아이디 -->
							<div class="form-group">
								<label class="form-text" for="input-uid">*아이디</label> 
								<input type="text" id="input-uid" name="id" 
									<c:if test="${userVo.id != ''}">
										value="${userVo.id}"
									</c:if>
									placeholder="아이디를 입력하세요.">
								<button type="button" id="id-check">중복체크</button>
								
								<!-- 아이디 중복 -->
								<c:if test="${idCheck == 'Fail' && userVo.id != ''}">
									<span style="color:#FF0000;">이미 존재하는 아이디입니다.</span>
								</c:if>
							</div>

							<!-- 비밀번호 -->
							<div class="form-group">
								<label class="form-text" for="input-pass">*비밀번호</label> 
								<input type="password" id="input-pass" name="password" value="" placeholder="비밀번호를 입력하세요"	>
							</div>
	
							<!-- 이름 -->
							<div class="form-group">
								<label class="form-text" for="input-name">*이름</label> 
								<input type="text" id="input-name" name="name" 
									<c:if test="${userVo.name != ''}">value="${userVo.name}"</c:if>
								 placeholder="이름을 입력하세요">
							</div>
	
							<!-- 성별 -->
							<div class="form-group">
								<span class="form-text">성별</span> 
								
								<label for="rdo-male">남</label> 
								<input type="radio" id="rdo-male" name="gender" value="male" 
									<c:if test="${userVo.gender == 'male'}"> checked="checked" </c:if>> 
								<label for="rdo-female">여</label> 
								<input type="radio" id="rdo-female" name="gender" value="female"  
									<c:if test="${userVo.gender == 'female'}"> checked="checked" </c:if>>
							</div>
	
							<!-- 약관동의 -->
							<div class="form-group">
								<span class="form-text">약관동의</span> 
								<input type="checkbox" id="chk-agree" name="agree" value="true">
								<label for="chk-agree">서비스 약관에 동의합니다.</label> 
								<span style="color:#FF0000;">약관에 동의하지 않으면 가입이 불가합니다.</span>
							</div>
							
							<!-- 버튼영역 -->
							<div class="button-area">
								<button type="submit" id="btn-submit">회원가입</button>
							</div>
							
						</form>
					</div>
					<!-- //joinForm -->
				</div>
				<!-- //user -->
			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->
		
		<!-- footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		<!-- //footer -->

	</div>
	<!-- //wrap -->

</body>

</html>